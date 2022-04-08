-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ffmanager
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ffmanager
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ffmanager` DEFAULT CHARACTER SET utf8 ;
USE `ffmanager` ;

-- -----------------------------------------------------
-- Table `ffmanager`.`tipos_areas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`tipos_areas` (
  `id_tipo_area` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NULL,
  `descripcion` VARCHAR(255) NULL,
  `es_techada` TINYINT(1) NOT NULL DEFAULT 0,
  `observaciones` VARCHAR(255) NULL,
  `es_compuesta` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_tipo_area`),
  UNIQUE INDEX `id_TIPO_AREA_ENTRENAMIENTO_UNIQUE` (`id_tipo_area` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ffmanager`.`datos_institucion_deportiva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`datos_institucion_deportiva` (
  `id_datos_institucion_deportiva` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `observaciones` VARCHAR(255) NULL,
  `direccion` VARCHAR(200) NOT NULL,
  `telefono_contacto` VARCHAR(45) NULL,
  PRIMARY KEY (`id_datos_institucion_deportiva`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ffmanager`.`complejos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`complejos` (
  `id_complejo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(200) NOT NULL,
  `telefono_contacto` VARCHAR(45) NOT NULL,
  `fk_institucion_deportiva` INT NOT NULL,
  PRIMARY KEY (`id_complejo`),
  INDEX `fk_complejos_datos_institucion_deportiva1_idx` (`fk_institucion_deportiva` ASC) VISIBLE,
  CONSTRAINT `fk_complejos_datos_institucion_deportiva1`
    FOREIGN KEY (`fk_institucion_deportiva`)
    REFERENCES `ffmanager`.`datos_institucion_deportiva` (`id_datos_institucion_deportiva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ffmanager`.`areas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`areas` (
  `id_area` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE` VARCHAR(255) NOT NULL,
  `observaciones` VARCHAR(255) NULL,
  `fk_id_tipo_area` INT NOT NULL,
  `fk_id_complejo` INT NOT NULL,
  PRIMARY KEY (`id_area`),
  UNIQUE INDEX `idT_AREA_ENTRENAMIENTO_UNIQUE` (`id_area` ASC) VISIBLE,
  UNIQUE INDEX `NOMBRE_UNIQUE` (`NOMBRE` ASC) VISIBLE,
  INDEX `fk_areas_tipos_areas1_idx` (`fk_id_tipo_area` ASC) VISIBLE,
  INDEX `fk_areas_complejos1_idx` (`fk_id_complejo` ASC) VISIBLE,
  CONSTRAINT `fk_areas_tipos_areas1`
    FOREIGN KEY (`fk_id_tipo_area`)
    REFERENCES `ffmanager`.`tipos_areas` (`id_tipo_area`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_areas_complejos1`
    FOREIGN KEY (`fk_id_complejo`)
    REFERENCES `ffmanager`.`complejos` (`id_complejo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ffmanager`.`estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`estados` (
  `id_estado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NOT NULL,
  `observaciones` VARCHAR(255) NULL,
  `permite_usar` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_estado`));


-- -----------------------------------------------------
-- Table `ffmanager`.`sectores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`sectores` (
  `id_sector` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NOT NULL,
  `observaciones` VARCHAR(255) NULL,
  `tamaño` DOUBLE NULL,
  `fk_id_area` INT NOT NULL,
  `es_sector_golero` TINYINT(1) NOT NULL DEFAULT 0,
  `numero_sector` INT NOT NULL,
  PRIMARY KEY (`id_sector`),
  INDEX `fk_sectores_areas1_idx` (`fk_id_area` ASC) VISIBLE,
  CONSTRAINT `fk_sectores_areas1`
    FOREIGN KEY (`fk_id_area`)
    REFERENCES `ffmanager`.`areas` (`id_area`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `ffmanager`.`cargos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`cargos` (
  `id_cargo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_cargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ffmanager`.`perfiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`perfiles` (
  `id_perfil` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `es_admin` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_perfil`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ffmanager`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(45) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `fecha_creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `email` VARCHAR(255) NULL,
  `fk_id_cargo` INT NOT NULL,
  `fk_id_perfil` INT NOT NULL,
  `telefono` BIGINT(12) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `fk_usuarios_cargos1_idx` (`fk_id_cargo` ASC) VISIBLE,
  INDEX `fk_usuarios_perfiles1_idx` (`fk_id_perfil` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_cargos1`
    FOREIGN KEY (`fk_id_cargo`)
    REFERENCES `ffmanager`.`cargos` (`id_cargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_perfiles1`
    FOREIGN KEY (`fk_id_perfil`)
    REFERENCES `ffmanager`.`perfiles` (`id_perfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `ffmanager`.`materiales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`materiales` (
  `id_material` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NOT NULL,
  `stock` INT NOT NULL,
  `maximo_por_dia` INT NOT NULL,
  `observaciones` VARCHAR(255) NULL,
  PRIMARY KEY (`id_material`));


-- -----------------------------------------------------
-- Table `ffmanager`.`reservas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`reservas` (
  `id_reserva` INT NOT NULL AUTO_INCREMENT,
  `fecha_desde` DATETIME NULL,
  `fecha_hasta` DATETIME NULL,
  `fk_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_reserva`),
  INDEX `fk_reservas_usuarios1_idx` (`fk_id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_reservas_usuarios1`
    FOREIGN KEY (`fk_id_usuario`)
    REFERENCES `ffmanager`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `ffmanager`.`items_menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`items_menu` (
  `id_item_menu` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `link` VARCHAR(200) NULL,
  `es_hoja` TINYINT(1) NULL DEFAULT 1,
  `es_raiz` TINYINT(1) NULL DEFAULT 1,
  `id_item_padre` INT NULL,
  PRIMARY KEY (`id_item_menu`),
  INDEX `fk_items_menu_items_menu_idx` (`id_item_padre` ASC) VISIBLE,
  CONSTRAINT `fk_items_menu_items_menu`
    FOREIGN KEY (`id_item_padre`)
    REFERENCES `ffmanager`.`items_menu` (`id_item_menu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ffmanager`.`items_de_perfiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`items_de_perfiles` (
  `fk_id_perfil` INT NOT NULL AUTO_INCREMENT,
  `fk_id_item_menu` INT NOT NULL,
  `id_item_perfil` INT NOT NULL,
  PRIMARY KEY (`id_item_perfil`),
  INDEX `fk_perfiles_has_items_menu_items_menu1_idx` (`fk_id_item_menu` ASC) VISIBLE,
  INDEX `fk_perfiles_has_items_menu_perfiles1_idx` (`fk_id_perfil` ASC) VISIBLE,
  CONSTRAINT `fk_perfiles_has_items_menu_perfiles1`
    FOREIGN KEY (`fk_id_perfil`)
    REFERENCES `ffmanager`.`perfiles` (`id_perfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_perfiles_has_items_menu_items_menu1`
    FOREIGN KEY (`fk_id_item_menu`)
    REFERENCES `ffmanager`.`items_menu` (`id_item_menu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ffmanager`.`estados_de_areas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`estados_de_areas` (
  `fk_id_estado` INT NOT NULL AUTO_INCREMENT,
  `fk_id_area` INT NOT NULL,
  `fecha_asignado` DATETIME NOT NULL,
  `id_estado_area` INT NOT NULL,
  PRIMARY KEY (`id_estado_area`),
  INDEX `fk_estados_has_areas_areas1_idx` (`fk_id_area` ASC) VISIBLE,
  INDEX `fk_estados_has_areas_estados1_idx` (`fk_id_estado` ASC) VISIBLE,
  CONSTRAINT `fk_estados_has_areas_estados1`
    FOREIGN KEY (`fk_id_estado`)
    REFERENCES `ffmanager`.`estados` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estados_has_areas_areas1`
    FOREIGN KEY (`fk_id_area`)
    REFERENCES `ffmanager`.`areas` (`id_area`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `ffmanager`.`estados_de_sectores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`estados_de_sectores` (
  `fk_id_estado` INT NOT NULL AUTO_INCREMENT,
  `fk_id_sector` INT NOT NULL,
  `fecha_asignado` DATETIME NOT NULL,
  `id_estado_sector` INT NOT NULL,
  PRIMARY KEY (`id_estado_sector`),
  INDEX `fk_estados_has_sectores_sectores1_idx` (`fk_id_sector` ASC) VISIBLE,
  INDEX `fk_estados_has_sectores_estados1_idx` (`fk_id_estado` ASC) VISIBLE,
  CONSTRAINT `fk_estados_has_sectores_estados1`
    FOREIGN KEY (`fk_id_estado`)
    REFERENCES `ffmanager`.`estados` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estados_has_sectores_sectores1`
    FOREIGN KEY (`fk_id_sector`)
    REFERENCES `ffmanager`.`sectores` (`id_sector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `ffmanager`.`actividades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`actividades` (
  `id_actividad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `observaciones` VARCHAR(255) NULL,
  `duracion` INT NULL,
  PRIMARY KEY (`id_actividad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ffmanager`.`materiales_de_reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`materiales_de_reserva` (
  `fk_id_reserva` INT NOT NULL AUTO_INCREMENT,
  `fk_id_material` INT NOT NULL,
  `id_material_reserva` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id_material_reserva`),
  INDEX `fk_reservas_has_materiales_materiales1_idx` (`fk_id_material` ASC) VISIBLE,
  INDEX `fk_reservas_has_materiales_reservas1_idx` (`fk_id_reserva` ASC) VISIBLE,
  CONSTRAINT `fk_reservas_has_materiales_reservas1`
    FOREIGN KEY (`fk_id_reserva`)
    REFERENCES `ffmanager`.`reservas` (`id_reserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_has_materiales_materiales1`
    FOREIGN KEY (`fk_id_material`)
    REFERENCES `ffmanager`.`materiales` (`id_material`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `ffmanager`.`actividades_de_reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`actividades_de_reserva` (
  `fk_id_reserva` INT NOT NULL AUTO_INCREMENT,
  `fk_id_actividad` INT NOT NULL,
  `id_actividad_reserva` INT NOT NULL,
  `duracion` INT NULL,
  INDEX `fk_reservas_has_actividades_actividades1_idx` (`fk_id_actividad` ASC) VISIBLE,
  INDEX `fk_reservas_has_actividades_reservas1_idx` (`fk_id_reserva` ASC) VISIBLE,
  PRIMARY KEY (`id_actividad_reserva`),
  CONSTRAINT `fk_reservas_has_actividades_reservas1`
    FOREIGN KEY (`fk_id_reserva`)
    REFERENCES `ffmanager`.`reservas` (`id_reserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_has_actividades_actividades1`
    FOREIGN KEY (`fk_id_actividad`)
    REFERENCES `ffmanager`.`actividades` (`id_actividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `ffmanager`.`reserva_de_sector`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`reserva_de_sector` (
  `fk_id_sector` INT NOT NULL AUTO_INCREMENT,
  `fk_id_reserva` INT NOT NULL,
  `id_reserva_sector` INT NOT NULL,
  PRIMARY KEY (`id_reserva_sector`),
  INDEX `fk_sectores_has_reservas_reservas1_idx` (`fk_id_reserva` ASC) VISIBLE,
  INDEX `fk_sectores_has_reservas_sectores1_idx` (`fk_id_sector` ASC) VISIBLE,
  CONSTRAINT `fk_sectores_has_reservas_sectores1`
    FOREIGN KEY (`fk_id_sector`)
    REFERENCES `ffmanager`.`sectores` (`id_sector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sectores_has_reservas_reservas1`
    FOREIGN KEY (`fk_id_reserva`)
    REFERENCES `ffmanager`.`reservas` (`id_reserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `ffmanager`.`reserva_de_area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ffmanager`.`reserva_de_area` (
  `fk_id_area` INT NOT NULL AUTO_INCREMENT,
  `fk_id_reserva` INT NOT NULL,
  `id_reserva_area` INT NOT NULL,
  PRIMARY KEY (`id_reserva_area`),
  INDEX `fk_areas_has_reservas_reservas1_idx` (`fk_id_reserva` ASC) VISIBLE,
  INDEX `fk_areas_has_reservas_areas1_idx` (`fk_id_area` ASC) VISIBLE,
  CONSTRAINT `fk_areas_has_reservas_areas1`
    FOREIGN KEY (`fk_id_area`)
    REFERENCES `ffmanager`.`areas` (`id_area`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_areas_has_reservas_reservas1`
    FOREIGN KEY (`fk_id_reserva`)
    REFERENCES `ffmanager`.`reservas` (`id_reserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
