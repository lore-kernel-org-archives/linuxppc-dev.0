Return-Path: <wfarnsworth@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 7112567A6F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Apr 2005 03:33:40 +1000 (EST)
Received: from rhino.az.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA22426
	for <linuxppc-embedded@ozlabs.org>; Wed, 6 Apr 2005 10:33:34 -0700
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <1112808669.24673.304.camel@rhino.az.mvista.com>
References: <1112808085.24527.296.camel@rhino.az.mvista.com>
	<1112808669.24673.304.camel@rhino.az.mvista.com>
Content-Type: multipart/mixed; boundary="=-g7JJaLz4TaDGzFpSHHcW"
Message-Id: <1112808814.24527.307.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 06 Apr 2005 10:33:34 -0700
Subject: Re: [PATCH 3/3] PPC440EP: MTD support for the Bamboo Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



--=-g7JJaLz4TaDGzFpSHHcW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This adds MTD support for the Bamboo board.

-Wade Farnsworth

--=-g7JJaLz4TaDGzFpSHHcW
Content-Disposition: attachment; filename=ibm440ep-mtd.patch
Content-Type: text/x-patch; name=ibm440ep-mtd.patch
Content-Transfer-Encoding: 7bit

diff -uprN linux-2.5-orig/drivers/mtd/maps/Kconfig linux-2.5-440ep/drivers/mtd/maps/Kconfig
--- linux-2.5-orig/drivers/mtd/maps/Kconfig	2005-04-05 15:31:12.000000000 -0700
+++ linux-2.5-440ep/drivers/mtd/maps/Kconfig	2005-04-05 15:37:05.000000000 -0700
@@ -397,6 +397,14 @@ config MTD_OCOTEA
 	  Ocotea board. If you have one of these boards and would like to
 	  use the flash chips on it, say 'Y'.
 
+config MTD_BAMBOO
+	tristate "Flash devices mapped on IBM 440EP Bamboo"
+	depends on MTD_CFI && PPC32 && 44x && BAMBOO
+	help
+	  This enables access routined for the flash chips on the IBM 440EP
+	  Bamboo board.  If you have one of these boards and would like to
+	  use the flash chips on it, say 'Y'.
+
 config MTD_REDWOOD
 	tristate "CFI Flash devices mapped on IBM Redwood"
 	depends on MTD_CFI && PPC32 && 4xx && 40x && ( REDWOOD_4 || REDWOOD_5 || REDWOOD_6 )
diff -uprN linux-2.5-orig/drivers/mtd/maps/Makefile linux-2.5-440ep/drivers/mtd/maps/Makefile
--- linux-2.5-orig/drivers/mtd/maps/Makefile	2005-04-05 15:31:12.000000000 -0700
+++ linux-2.5-440ep/drivers/mtd/maps/Makefile	2005-04-05 15:37:06.000000000 -0700
@@ -59,6 +59,7 @@ obj-$(CONFIG_MTD_NETtel)	+= nettel.o
 obj-$(CONFIG_MTD_SCB2_FLASH)	+= scb2_flash.o
 obj-$(CONFIG_MTD_EBONY)		+= ebony.o
 obj-$(CONFIG_MTD_OCOTEA)	+= ocotea.o
+obj-$(CONFIG_MTD_BAMBOO)	+= bamboo.o
 obj-$(CONFIG_MTD_BEECH)		+= beech-mtd.o
 obj-$(CONFIG_MTD_ARCTIC)	+= arctic-mtd.o
 obj-$(CONFIG_MTD_WALNUT)        += walnut.o
diff -uprN linux-2.5-orig/drivers/mtd/maps/bamboo.c linux-2.5-440ep/drivers/mtd/maps/bamboo.c
--- linux-2.5-orig/drivers/mtd/maps/bamboo.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.5-440ep/drivers/mtd/maps/bamboo.c	2005-04-05 15:37:06.000000000 -0700
@@ -0,0 +1,245 @@
+/*
+ * Mapping for Bamboo user flash
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ *
+ * Copyright 2005 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+#include <linux/config.h>
+#include <asm/io.h>
+#include <asm/ibm44x.h>
+#include <platforms/4xx/bamboo.h>
+
+static struct mtd_info *small_flash, *large_flash, *sram;
+
+static struct map_info bamboo_small_map = {
+	.name = "Bamboo small flash",
+	.size = BAMBOO_SMALL_FLASH_SIZE,
+	.bankwidth = 1,
+};
+
+static struct map_info bamboo_large_map = {
+	.name = "Bamboo large flash",
+	.size = BAMBOO_LARGE_FLASH_SIZE,
+	.bankwidth = 2,
+};
+
+static struct map_info bamboo_sram_map = {
+	.name = "Bamboo SRAM",
+	.size = BAMBOO_SRAM_SIZE,
+	.bankwidth = 2,
+};
+
+static struct mtd_partition bamboo_small_partitions[] = {
+	{
+		.name = "pibs",
+		.offset = 0x0,
+		.size = 0x100000,
+		.mask_flags = MTD_WRITEABLE,
+	}
+};
+
+static struct mtd_partition bamboo_large_partitions[] = {
+	{
+	 	.name = "filesystem",
+	 	.offset = 0x0,
+	 	.size = 0x400000,
+	}
+};
+
+static struct mtd_partition bamboo_sram_partitions[] = {
+	{
+	 	.name = "sram",
+	 	.offset = 0x0,
+	 	.size = 0x100000,
+	}
+};
+
+int __init
+init_bamboo(void)
+{
+	u8 setting_reg;
+	u8 *setting_adr;
+	unsigned long small_flash_base, large_flash_base, sram_base;
+	unsigned long *gpio_base;
+
+	setting_adr = ioremap64(BAMBOO_FPGA_SETTING_REG_ADDR, 8);
+	if (!setting_adr)
+		return -ENOMEM;
+	setting_reg = readb(setting_adr);
+	iounmap(setting_adr);
+
+	/* 
+	 * Some versions of PIBS don't set up the GPIO controller
+	 * for the devices on chip select 4 (large flash and sram).
+	 */
+	gpio_base = ioremap64(0x0EF600B00ULL, 0x80);
+	if (!gpio_base) {
+		printk("Failed to ioremap GPIO\n");
+		return -ENOMEM;
+	}
+	* (gpio_base + 0x02) |= 0x00001000;
+	* (gpio_base + 0x04) |= 0x00001000;
+	iounmap((void *) gpio_base);
+
+	/* 
+	 * Use the values in the FPGA Setting Register to determine where
+	 * each flash bank is located.
+	 */
+	if (!BAMBOO_BOOT_NAND_FLASH(setting_reg)) {
+		if (BAMBOO_BOOT_SMALL_FLASH(setting_reg)) {
+			small_flash_base = BAMBOO_SMALL_FLASH_HIGH;
+		} else {
+			small_flash_base = BAMBOO_SMALL_FLASH_LOW;
+		}
+
+		bamboo_small_map.phys = small_flash_base;
+		bamboo_small_map.virt = 
+			(ulong *) ioremap64(small_flash_base, 
+					    bamboo_small_map.size);
+		if (!bamboo_small_map.virt) {
+			printk("Failed to ioremap flash\n");
+			return -EIO;
+		}
+
+		simple_map_init(&bamboo_small_map);
+
+		small_flash = do_map_probe("map_rom", &bamboo_small_map);
+		if (small_flash) {
+			small_flash->owner = THIS_MODULE;
+			add_mtd_partitions(small_flash, bamboo_small_partitions,
+					   ARRAY_SIZE(bamboo_small_partitions));
+		} else {
+			printk(KERN_INFO
+			       "small flash disabled: Probe failed due to probable hardware issue\n");
+			iounmap((void *) bamboo_small_map.virt);
+			bamboo_small_map.virt = 0;
+		}
+	} else
+		bamboo_small_map.virt = 0;
+
+	/* 
+	 * Wiring to the large flash on the Rev 0 Bamboo is incorrect, so 
+	 * this should fail.
+	 *
+	 * This has been fixed on the Rev 1.
+	 */
+	if (BAMBOO_BOOT_NAND_FLASH(setting_reg) ||
+	    BAMBOO_BOOT_SMALL_FLASH(setting_reg))
+		large_flash_base = BAMBOO_LARGE_FLASH_LOW;
+	else if (BAMBOO_LARGE_FLASH_EN(setting_reg))
+		large_flash_base = BAMBOO_LARGE_FLASH_HIGH1;
+	else
+		large_flash_base = BAMBOO_LARGE_FLASH_HIGH2;
+	bamboo_large_map.phys = large_flash_base;
+	bamboo_large_map.virt = (ulong *) ioremap64(large_flash_base, 
+						    bamboo_large_map.size);
+	if (!bamboo_large_map.virt) {
+		printk("Failed to ioremap flash\n");
+		return -EIO;
+	}
+
+	simple_map_init(&bamboo_large_map);
+	large_flash = do_map_probe("cfi_probe", &bamboo_large_map);
+	if (large_flash) {
+		large_flash->owner = THIS_MODULE;
+		add_mtd_partitions(large_flash, bamboo_large_partitions,
+				   ARRAY_SIZE(bamboo_large_partitions));
+	} else {
+		printk(KERN_INFO
+		       "large flash disabled: Probe failed due to probable hardware issue\n");
+		iounmap((void *) bamboo_large_map.virt);
+		bamboo_large_map.virt = 0;
+	}
+
+	if (BAMBOO_BOOT_NAND_FLASH(setting_reg) ||
+	    BAMBOO_BOOT_SMALL_FLASH(setting_reg))
+		sram_base = BAMBOO_SRAM_LOW;
+	else if (BAMBOO_LARGE_FLASH_EN(setting_reg))
+		sram_base = BAMBOO_SRAM_HIGH2;
+	else
+		sram_base = BAMBOO_SRAM_HIGH1;
+
+	bamboo_sram_map.phys = sram_base;
+	bamboo_sram_map.virt = (ulong *) ioremap64(sram_base, 
+						   bamboo_sram_map.size);
+	if (!bamboo_sram_map.virt) {
+		printk("Failed to ioremap flash \n");
+		return -EIO;
+	}
+
+	simple_map_init(&bamboo_sram_map);
+
+	sram = do_map_probe("map_ram", &bamboo_sram_map);
+	if (sram) {
+		sram->owner = THIS_MODULE;
+		sram->erasesize = 0x10;
+		add_mtd_partitions(sram, bamboo_sram_partitions,
+				   ARRAY_SIZE(bamboo_sram_partitions));
+	} else {
+		printk(KERN_INFO
+		       "sram disabled: Probe failed due to probable hardware issue\n");
+		iounmap((void *) bamboo_sram_map.virt);
+		bamboo_sram_map.virt = 0;
+	}
+
+	if (!(small_flash || large_flash || sram))
+		return -ENXIO;
+
+	return 0;
+}
+
+static void __exit
+cleanup_bamboo(void)
+{
+	if (small_flash) {
+		del_mtd_partitions(small_flash);
+		map_destroy(small_flash);
+	}
+
+	if (large_flash) {
+		del_mtd_partitions(large_flash);
+		map_destroy(large_flash);
+	}
+
+	if (sram) {
+		del_mtd_partitions(sram);
+		map_destroy(sram);
+	}
+
+	if (bamboo_small_map.virt) {
+		iounmap((void *) bamboo_small_map.virt);
+		bamboo_small_map.virt = 0;
+	}
+
+	if (bamboo_large_map.virt) {
+		iounmap((void *) bamboo_large_map.virt);
+		bamboo_large_map.virt = 0;
+	}
+
+	if (bamboo_sram_map.virt) {
+		iounmap((void *) bamboo_sram_map.virt);
+		bamboo_sram_map.virt = 0;
+	}
+}
+
+module_init(init_bamboo);
+module_exit(cleanup_bamboo);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Wade Farnsworth <wfarnsworth@mvista.com>");
+MODULE_DESCRIPTION("MTD map and partitions for IBM 440EP Bamboo boards");
diff -uprN linux-2.5-orig/drivers/mtd/nand/Kconfig linux-2.5-440ep/drivers/mtd/nand/Kconfig
--- linux-2.5-orig/drivers/mtd/nand/Kconfig	2005-04-05 15:31:12.000000000 -0700
+++ linux-2.5-440ep/drivers/mtd/nand/Kconfig	2005-04-05 15:37:07.000000000 -0700
@@ -122,6 +122,13 @@ config MTD_NAND_S3C2410_HWECC
 	  currently not be able to switch to software, as there is no
 	  implementation for ECC method used by the S3C2410
 
+config MTD_NAND_BAMBOO
+	tristate "NAND flash support on IBM/AMCC 440EP Eval Board (Bamboo)"
+	depends on BAMBOO && MTD_NAND
+	help
+	  This enables the NAND flash driver on the IBM/AMCC 440EP Eval Board
+	  (Bamboo).
+
 config MTD_NAND_DISKONCHIP
 	tristate "DiskOnChip 2000, Millennium and Millennium Plus (NAND reimplementation) (EXPERIMENTAL)"
 	depends on MTD_NAND && EXPERIMENTAL
diff -uprN linux-2.5-orig/drivers/mtd/nand/Makefile linux-2.5-440ep/drivers/mtd/nand/Makefile
--- linux-2.5-orig/drivers/mtd/nand/Makefile	2005-04-05 15:31:12.000000000 -0700
+++ linux-2.5-440ep/drivers/mtd/nand/Makefile	2005-04-05 15:37:08.000000000 -0700
@@ -15,6 +15,7 @@ obj-$(CONFIG_MTD_NAND_TX4938NDFMC)	+= tx
 obj-$(CONFIG_MTD_NAND_AU1550)		+= au1550nd.o
 obj-$(CONFIG_MTD_NAND_PPCHAMELEONEVB)	+= ppchameleonevb.o
 obj-$(CONFIG_MTD_NAND_S3C2410)		+= s3c2410.o
+obj-$(CONFIG_MTD_NAND_BAMBOO)		+= bamboo_nand.o
 obj-$(CONFIG_MTD_NAND_DISKONCHIP)	+= diskonchip.o
 obj-$(CONFIG_MTD_NAND_H1900)		+= h1910.o
 obj-$(CONFIG_MTD_NAND_RTC_FROM4)	+= rtc_from4.o
diff -uprN linux-2.5-orig/drivers/mtd/nand/bamboo_nand.c linux-2.5-440ep/drivers/mtd/nand/bamboo_nand.c
--- linux-2.5-orig/drivers/mtd/nand/bamboo_nand.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.5-440ep/drivers/mtd/nand/bamboo_nand.c	2005-04-06 09:11:52.000000000 -0700
@@ -0,0 +1,467 @@
+/*
+ *  drivers/mtd/bamboo_nand.c
+ *
+ *  Overview:
+ *   This is a device driver for the NAND flash devices found on the
+ *   IBM 440EP Evaluation Board (Bamboo).
+ *
+ *  Author: Wade Farnsworth <wfarnsworth@mvista.com>
+ *
+ *  Copyright 2005 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/nand_ecc.h>
+#include <linux/mtd/partitions.h>
+#include <linux/config.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <asm/io.h>
+#include <asm/ibm44x.h>
+#include <platforms/4xx/bamboo.h>
+
+struct ppc440ep_ndfc_regs {
+	uint cmd;
+	uint addr;
+	uint data;
+	uint reserved1;
+	uint ecc0;
+	uint ecc1;
+	uint ecc2;
+	uint ecc3;
+	uint ecc4;
+	uint ecc5;
+	uint ecc6;
+	uint ecc7;
+	uint b0cr;
+	uint b1cr;
+	uint b2cr;
+	uint b3cr;
+	uint cr;
+	uint sr;
+	uint hwctl;
+	uint reserved2;
+	uint revid;
+};
+
+static struct mtd_info *bamboo_nand0_mtd;
+static struct mtd_info *bamboo_nand1_mtd;
+static u8 hwctl;
+static struct ppc440ep_ndfc_regs *bamboo_ndfc;
+
+#define NAND0_NUM_PARTITIONS 1
+static struct mtd_partition nand0_partition_info[] = {
+	{
+	 	.name = "filesystem",
+	 	.offset = 0x0,
+	 	.size = 0x4000000,
+	 },
+};
+
+#define NAND1_NUM_PARTITIONS 1
+static struct mtd_partition nand1_partition_info[] = {
+	{
+		.name = "filesystem",
+		.offset = 0x0,
+		.size = 0x10000000,
+	}
+};
+
+/* 
+ * The 440EP has a NAND Flash Controller (NDFC) that handles all accesses to 
+ * the NAND devices.  The NDFC has command, address and data registers that 
+ * when accessed will set up the NAND flash pins appropriately.  We'll use the 
+ * hwcontrol function to save the configuration in a global variable.  
+ * We can then use this information in the read and write functions to 
+ * determine which NDFC register to access. For the NCE commands, we'll just
+ * set or clear the Bank Enable bit in the NDFC Bank Config registers.
+ *
+ * There are 2 NAND devices on the board, a Samsung K9F1208U0A (64 MB) and a
+ * Samsung K9K2G08U0M (256 MB).
+ */
+static void
+bamboo_hwcontrol(struct mtd_info *mtd, int cmd)
+{
+	switch (cmd) {
+	case NAND_CTL_SETCLE:
+		hwctl |= 0x1;
+		break;
+	case NAND_CTL_CLRCLE:
+		hwctl &= ~0x1;
+		break;
+	case NAND_CTL_SETALE:
+		hwctl |= 0x2;
+		break;
+	case NAND_CTL_CLRALE:
+		hwctl &= ~0x2;
+		break;
+	}
+}
+
+static void
+bamboo_nand0_hwcontrol(struct mtd_info *mtd, int cmd)
+{
+	switch(cmd) {
+	case NAND_CTL_SETNCE:
+		bamboo_ndfc->b1cr |= 0x80000000;
+		break;
+	case NAND_CTL_CLRNCE:
+		bamboo_ndfc->b1cr &= ~0x80000000;
+		break;
+	default:
+		bamboo_hwcontrol(mtd, cmd);
+	}
+}
+
+static void
+bamboo_nand1_hwcontrol(struct mtd_info *mtd, int cmd)
+{
+	switch(cmd) {
+	case NAND_CTL_SETNCE:
+		bamboo_ndfc->b2cr |= 0x80000000;
+		break;
+	case NAND_CTL_CLRNCE:
+		bamboo_ndfc->b2cr &= ~0x80000000;
+		break;
+	default:
+		bamboo_hwcontrol(mtd, cmd);
+	}
+}
+
+static void
+bamboo_nand0_enable(void)
+{
+	bamboo_ndfc->cr = 0x01001000;
+}
+
+static void
+bamboo_nand1_enable(void)
+{
+	bamboo_ndfc->cr = 0x02003000;
+}
+
+static void
+bamboo_write_byte(struct mtd_info *mtd, u_char byte)
+{
+	if (hwctl & 0x1)
+		writeb(byte, &(bamboo_ndfc->cmd));
+	else if (hwctl & 0x2)
+		writeb(byte, &(bamboo_ndfc->addr));
+	else
+		writeb(byte, &(bamboo_ndfc->data));
+}
+
+static void
+bamboo_nand0_write_byte(struct mtd_info *mtd, u_char byte)
+{
+	bamboo_nand0_enable();
+	bamboo_write_byte(mtd, byte);
+}
+
+static void
+bamboo_nand1_write_byte(struct mtd_info *mtd, u_char byte)
+{
+	bamboo_nand1_enable();
+	bamboo_write_byte(mtd,byte);
+}
+
+static u_char
+bamboo_read_byte(struct mtd_info *mtd)
+{
+	u_char retval;
+	if (hwctl & 0x1)
+		retval = readb(&(bamboo_ndfc->cmd));
+	else if (hwctl & 0x2)
+		retval = readb(&(bamboo_ndfc->addr));
+	else
+		retval = readb(&(bamboo_ndfc->data));
+	return retval;
+}
+
+static u_char
+bamboo_nand0_read_byte(struct mtd_info *mtd)
+{
+	bamboo_nand0_enable();
+	return bamboo_read_byte(mtd);
+}
+
+static u_char
+bamboo_nand1_read_byte(struct mtd_info *mtd)
+{
+	bamboo_nand1_enable();
+	return bamboo_read_byte(mtd);
+}
+
+static void
+bamboo_nand_write_buf(struct mtd_info *mtd, const u_char * buf, int len)
+{
+	int i;
+	for (i = 0; i < len; i++) {
+		if (hwctl & 0x1)
+			writeb(buf[i], &(bamboo_ndfc->cmd));
+		else if (hwctl & 0x2)
+			writeb(buf[i], &(bamboo_ndfc->addr));
+		else
+			writeb(buf[i], &(bamboo_ndfc->data));
+	}
+}
+
+static void
+bamboo_nand0_write_buf(struct mtd_info *mtd, const u_char * buf, int len)
+{
+	bamboo_nand0_enable();
+	bamboo_nand_write_buf(mtd, buf, len);
+}
+
+static void
+bamboo_nand1_write_buf(struct mtd_info *mtd, const u_char * buf, int len)
+{
+	bamboo_nand1_enable();
+	bamboo_nand_write_buf(mtd, buf, len);
+}
+
+static void
+bamboo_nand_read_buf(struct mtd_info *mtd, u_char * buf, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if (hwctl & 0x1)
+			buf[i] = readb(&(bamboo_ndfc->cmd));
+		else if (hwctl & 0x2)
+			buf[i] = readb(&(bamboo_ndfc->addr));
+		else
+			buf[i] = readb(&(bamboo_ndfc->data));
+	}
+}
+
+static void
+bamboo_nand0_read_buf(struct mtd_info *mtd, u_char * buf, int len)
+{
+	bamboo_nand0_enable();
+	bamboo_nand_read_buf(mtd, buf, len);
+}
+
+static void
+bamboo_nand1_read_buf(struct mtd_info *mtd, u_char * buf, int len)
+{
+	bamboo_nand1_enable();
+	bamboo_nand_read_buf(mtd, buf, len);
+}
+
+static int
+bamboo_nand_verify_buf(struct mtd_info *mtd, const u_char * buf, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if (hwctl & 0x1) {
+			if (buf[i] != readb(&(bamboo_ndfc->cmd)))
+				return i;
+		} else if (hwctl & 0x2) {
+			if (buf[i] != readb(&(bamboo_ndfc->addr)))
+				return i;
+		} else {
+			if (buf[i] != readb(&(bamboo_ndfc->data)))
+				return i;
+		}
+
+	}
+
+	return 0;
+}
+
+static int
+bamboo_nand0_verify_buf(struct mtd_info *mtd, const u_char * buf, int len)
+{
+	bamboo_nand0_enable();
+	return bamboo_nand_verify_buf(mtd, buf, len);
+}
+
+static int
+bamboo_nand1_verify_buf(struct mtd_info *mtd, const u_char *buf, int len)
+{
+	bamboo_nand1_enable();
+	return bamboo_nand_verify_buf(mtd, buf, len);
+}
+
+static int
+bamboo_dev_ready(struct mtd_info *mtd)
+{
+	return ((bamboo_ndfc->sr) & 0x01000000) ? 1 : 0; 
+}
+
+int __init
+bamboo_init(void)
+{
+	struct nand_chip *this;
+	uint * selection1_base, * gpio_base;
+	u8 selection1_val;
+	int err = 0;
+	
+	hwctl = 0;
+
+	/* 
+	 * Bank 0 was set up by the firmware already.  Bank 1 wasn't, so set it
+	 * up now. 
+	 */
+
+	selection1_base = ioremap64(BAMBOO_FPGA_SELECTION1_REG_ADDR, 8);
+	if(!selection1_base){
+		printk("Ioremap to access FPGA Selection Register 1 failed \n");
+		err = -EIO;
+		goto out;
+	}
+	selection1_val = readb(selection1_base);
+	selection1_val |= 0x02;
+	writeb(selection1_val, selection1_base);
+	iounmap((void *)(selection1_base));
+
+	SDR_WRITE(DCRN_SDR_CUST0, SDR_READ(DCRN_SDR_CUST0) | 0x2);
+
+	gpio_base = ioremap64(0x0EF600B00ULL, 0x80);
+	if(!gpio_base) {
+		printk("Ioremap to access GPIO Registers failed \n");
+		err = -EIO;
+		goto out;
+	}
+	*(uint *) (gpio_base + 0x2) |= 0x00010000;
+	*(uint *) (gpio_base + 0x4) |= 0x00010000;
+	iounmap((void *) gpio_base);
+	
+	bamboo_nand0_mtd = kmalloc(sizeof(struct mtd_info) +
+				   sizeof(struct nand_chip),
+				   GFP_KERNEL);
+	
+	bamboo_nand1_mtd = kmalloc(sizeof (struct mtd_info) +
+				   sizeof (struct nand_chip),
+				   GFP_KERNEL);
+	if (!bamboo_nand1_mtd) {
+		printk("Unable to allocate NAND 1 MTD device structure.\n");
+		err = -ENOMEM;
+		goto out_mtd0;
+	}
+
+	bamboo_ndfc = ioremap64(BAMBOO_NAND_FLASH_REG_ADDR, 
+			        BAMBOO_NAND_FLASH_REG_SIZE); 
+	if (!bamboo_ndfc) {
+		printk("Ioremap to access NDFC Registers failed \n");
+		err = -EIO;
+		goto out_mtd1;
+	}
+	bamboo_ndfc->b2cr = 0xC0007777;
+
+	/* Initialize structures */
+	memset((char *) bamboo_nand0_mtd, 0,
+	       sizeof (struct mtd_info) + sizeof (struct nand_chip));
+
+	memset((char *) bamboo_nand1_mtd, 0,
+	       sizeof (struct mtd_info) + sizeof (struct nand_chip));
+
+	/* Get pointer to private data */
+	this = (struct nand_chip *) (&bamboo_nand0_mtd[1]);
+	/* Link the private data with the MTD structure */
+	bamboo_nand0_mtd->priv = this;
+
+	/* Set address of NAND IO lines (Using Linear Data Access Region) */
+	this->IO_ADDR_R = (void __iomem *) ((ulong) bamboo_ndfc + 0x1000);
+	this->IO_ADDR_W = (void __iomem *) ((ulong) bamboo_ndfc + 0x1000);
+	/* Reference hardware control function */
+	this->hwcontrol  = bamboo_nand0_hwcontrol;
+	/* Set command delay time */
+	this->chip_delay = 12;
+	this->eccmode    = NAND_ECC_SOFT;
+	this->write_byte = bamboo_nand0_write_byte;
+	this->read_byte  = bamboo_nand0_read_byte;
+	this->write_buf  = bamboo_nand0_write_buf;
+	this->read_buf   = bamboo_nand0_read_buf;
+	this->verify_buf = bamboo_nand0_verify_buf;
+	this->dev_ready  = bamboo_dev_ready;
+
+	/* Scan to find existance of the device */
+	if (nand_scan(bamboo_nand0_mtd, 1)) {
+		err = -ENXIO;
+		goto out_ior;
+	}
+
+	/* Get pointer to private data */
+	this = (struct nand_chip *) (&bamboo_nand1_mtd[1]);
+	/* Link the private data with the MTD structure */
+	bamboo_nand1_mtd->priv = this;
+
+	/* Set address of NAND IO lines (Using Linear Data Access Region) */
+	this->IO_ADDR_R = (void __iomem *) ((ulong) bamboo_ndfc + 0x1000);
+	this->IO_ADDR_W = (void __iomem *) ((ulong) bamboo_ndfc + 0x1000);
+	/* Reference hardware control function */
+	this->hwcontrol  = bamboo_nand1_hwcontrol;
+	/* Set command delay time */
+	this->chip_delay = 25;
+	this->eccmode    = NAND_ECC_SOFT;
+	this->write_byte = bamboo_nand1_write_byte;
+	this->read_byte  = bamboo_nand1_read_byte;
+	this->write_buf  = bamboo_nand1_write_buf;
+	this->read_buf   = bamboo_nand1_read_buf;
+	this->verify_buf = bamboo_nand1_verify_buf;
+	this->dev_ready  = NULL;
+
+	/* Scan to find existance of the device */
+	if (nand_scan(bamboo_nand1_mtd, 1)) {
+		err = -ENXIO;
+		goto out_ior;
+	}
+
+	
+	add_mtd_partitions(bamboo_nand0_mtd, nand0_partition_info, 
+			   NAND0_NUM_PARTITIONS);
+
+	add_mtd_partitions(bamboo_nand1_mtd, nand1_partition_info, 
+			   NAND1_NUM_PARTITIONS);
+	goto out;
+
+out_ior:
+	iounmap((void *)bamboo_ndfc);
+out_mtd1:
+	kfree(bamboo_nand1_mtd);
+out_mtd0:
+	kfree(bamboo_nand0_mtd);
+out:
+	return err;
+}
+
+static void __exit
+bamboo_cleanup(void)
+{
+	/* Unregister partitions */
+	del_mtd_partitions(bamboo_nand0_mtd);
+	del_mtd_partitions(bamboo_nand1_mtd);
+
+	/* Release resources, unregister device */
+	del_mtd_device(bamboo_nand0_mtd);
+	del_mtd_device(bamboo_nand1_mtd);
+
+	/* unmap physical address */
+	iounmap((void *) bamboo_ndfc);
+
+	/* Free the MTD device structure */
+	kfree(bamboo_nand0_mtd);
+	kfree(bamboo_nand1_mtd);
+}
+
+module_init(bamboo_init);
+module_exit(bamboo_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Wade Farnsworth <wfarnsworth@mvista.com>");
+MODULE_DESCRIPTION
+    ("Board-specific glue layer for NAND flash on IBM 440EP eval board");

--=-g7JJaLz4TaDGzFpSHHcW--
