Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id F0697DE19F
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 00:39:53 +1000 (EST)
Message-Id: <20080610142948.237270763@arndb.de>
References: <20080610142702.354823071@arndb.de>
Date: Tue, 10 Jun 2008 16:27:07 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [PATCH 5/5] powerpc/mtd: remove dead platform specific maps
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It is no longer possible to select compilation of these
drivers with arch/powerpc, so the code should be removed.

New platforms should use physmap_of.

Cc: linux-mtd@lists.infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/maps/Kconfig            |   57 --------
 drivers/mtd/maps/Makefile           |    6 -
 drivers/mtd/maps/mbx860.c           |  100 -------------
 drivers/mtd/maps/ocotea.c           |  154 ---------------------
 drivers/mtd/maps/redwood.c          |  176 -----------------------
 drivers/mtd/maps/rpxlite.c          |   66 ---------
 drivers/mtd/maps/tqm8xxl.c          |  261 -----------------------------------
 drivers/mtd/maps/wr_sbc82xx_flash.c |  180 ------------------------
 8 files changed, 0 insertions(+), 1000 deletions(-)
 delete mode 100644 drivers/mtd/maps/mbx860.c
 delete mode 100644 drivers/mtd/maps/ocotea.c
 delete mode 100644 drivers/mtd/maps/redwood.c
 delete mode 100644 drivers/mtd/maps/rpxlite.c
 delete mode 100644 drivers/mtd/maps/tqm8xxl.c
 delete mode 100644 drivers/mtd/maps/wr_sbc82xx_flash.c

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 17bc87a..c334e66 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -297,34 +297,6 @@ config MTD_SBC8240
           Flash access on the SBC8240 board from Wind River.  See
           <http://www.windriver.com/products/sbc8240/>
 
-config MTD_TQM8XXL
-	tristate "CFI Flash device mapped on TQM8XXL"
-	depends on MTD_CFI && TQM8xxL
-	help
-	  The TQM8xxL PowerPC board has up to two banks of CFI-compliant
-	  chips, currently uses AMD one. This 'mapping' driver supports
-	  that arrangement, allowing the CFI probe and command set driver
-	  code to communicate with the chips on the TQM8xxL board. More at
-	  <http://www.denx.de/embedded-ppc-en.html>.
-
-config MTD_RPXLITE
-	tristate "CFI Flash device mapped on RPX Lite or CLLF"
-	depends on MTD_CFI && (RPXCLASSIC || RPXLITE)
-	help
-	  The RPXLite PowerPC board has CFI-compliant chips mapped in
-	  a strange sparse mapping. This 'mapping' driver supports that
-	  arrangement, allowing the CFI probe and command set driver code
-	  to communicate with the chips on the RPXLite board. More at
-	  <http://www.embeddedplanet.com/>.
-
-config MTD_MBX860
-	tristate "System flash on MBX860 board"
-	depends on MTD_CFI && MBX
-	help
-	  This enables access routines for the flash chips on the Motorola
-	  MBX860 board. If you have one of these boards and would like
-	  to use the flash chips on it, say 'Y'.
-
 config MTD_DBOX2
 	tristate "CFI Flash device mapped on D-Box2"
 	depends on DBOX2 && MTD_CFI_INTELSTD && MTD_CFI_INTELEXT && MTD_CFI_AMDSTD
@@ -356,22 +328,6 @@ config MTD_EBONY
 	  Ebony board. If you have one of these boards and would like to
 	  use the flash chips on it, say 'Y'.
 
-config MTD_OCOTEA
-	tristate "Flash devices mapped on IBM 440GX Ocotea"
-	depends on MTD_CFI && OCOTEA && !PPC_MERGE
-	help
-	  This enables access routines for the flash chips on the IBM 440GX
-	  Ocotea board. If you have one of these boards and would like to
-	  use the flash chips on it, say 'Y'.
-
-config MTD_REDWOOD
-	tristate "CFI Flash devices mapped on IBM Redwood"
-	depends on MTD_CFI && ( REDWOOD_4 || REDWOOD_5 || REDWOOD_6 )
-	help
-	  This enables access routines for the flash chips on the IBM
-	  Redwood board. If you have one of these boards and would like to
-	  use the flash chips on it, say 'Y'.
-
 config MTD_SOLUTIONENGINE
 	tristate "CFI Flash device mapped on Hitachi SolutionEngine"
 	depends on SUPERH && SOLUTION_ENGINE && MTD_CFI && MTD_REDBOOT_PARTS
@@ -523,19 +479,6 @@ config MTD_UCLINUX
 	help
 	  Map driver to support image based filesystems for uClinux.
 
-config MTD_WRSBC8260
-	tristate "Map driver for WindRiver PowerQUICC II MPC82xx board"
-	depends on (SBC82xx || SBC8560)
-	select MTD_PARTITIONS
-	select MTD_MAP_BANK_WIDTH_4
-	select MTD_MAP_BANK_WIDTH_1
-	select MTD_CFI_I1
-	select MTD_CFI_I4
-	help
-	  Map driver for WindRiver PowerQUICC II MPC82xx board. Drives
-	  all three flash regions on CS0, CS1 and CS6 if they are configured
-	  correctly by the boot loader.
-
 config MTD_DMV182
         tristate "Map driver for Dy-4 SVME/DMV-182 board."
         depends on DMV182
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 957fb5f..7855ecb 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -21,7 +21,6 @@ obj-$(CONFIG_MTD_ICHXROM)	+= ichxrom.o
 obj-$(CONFIG_MTD_CK804XROM)	+= ck804xrom.o
 obj-$(CONFIG_MTD_TSUNAMI)	+= tsunami_flash.o
 obj-$(CONFIG_MTD_PXA2XX)	+= pxa2xx-flash.o
-obj-$(CONFIG_MTD_MBX860)	+= mbx860.o
 obj-$(CONFIG_MTD_CEIVA)		+= ceiva.o
 obj-$(CONFIG_MTD_OCTAGON)	+= octagon-5066.o
 obj-$(CONFIG_MTD_PHYSMAP)	+= physmap.o
@@ -29,8 +28,6 @@ obj-$(CONFIG_MTD_PHYSMAP_OF)	+= physmap_of.o
 obj-$(CONFIG_MTD_PMC_MSP_EVM)   += pmcmsp-flash.o
 obj-$(CONFIG_MTD_PMC_MSP_RAMROOT)+= pmcmsp-ramroot.o
 obj-$(CONFIG_MTD_PCMCIA)	+= pcmciamtd.o
-obj-$(CONFIG_MTD_RPXLITE)	+= rpxlite.o
-obj-$(CONFIG_MTD_TQM8XXL)	+= tqm8xxl.o
 obj-$(CONFIG_MTD_SA1100)	+= sa1100-flash.o
 obj-$(CONFIG_MTD_IPAQ)		+= ipaq-flash.o
 obj-$(CONFIG_MTD_SBC_GXX)	+= sbc_gxx.o
@@ -48,19 +45,16 @@ obj-$(CONFIG_MTD_AUTCPU12)	+= autcpu12-nvram.o
 obj-$(CONFIG_MTD_EDB7312)	+= edb7312.o
 obj-$(CONFIG_MTD_IMPA7)		+= impa7.o
 obj-$(CONFIG_MTD_FORTUNET)	+= fortunet.o
-obj-$(CONFIG_MTD_REDWOOD)	+= redwood.o
 obj-$(CONFIG_MTD_UCLINUX)	+= uclinux.o
 obj-$(CONFIG_MTD_NETtel)	+= nettel.o
 obj-$(CONFIG_MTD_SCB2_FLASH)	+= scb2_flash.o
 obj-$(CONFIG_MTD_EBONY)		+= ebony.o
-obj-$(CONFIG_MTD_OCOTEA)	+= ocotea.o
 obj-$(CONFIG_MTD_WALNUT)        += walnut.o
 obj-$(CONFIG_MTD_H720X)		+= h720x-flash.o
 obj-$(CONFIG_MTD_SBC8240)	+= sbc8240.o
 obj-$(CONFIG_MTD_NOR_TOTO)	+= omap-toto-flash.o
 obj-$(CONFIG_MTD_IXP4XX)	+= ixp4xx.o
 obj-$(CONFIG_MTD_IXP2000)	+= ixp2000.o
-obj-$(CONFIG_MTD_WRSBC8260)	+= wr_sbc82xx_flash.o
 obj-$(CONFIG_MTD_DMV182)	+= dmv182.o
 obj-$(CONFIG_MTD_SHARP_SL)	+= sharpsl-flash.o
 obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
diff --git a/drivers/mtd/maps/mbx860.c b/drivers/mtd/maps/mbx860.c
deleted file mode 100644
index 06b1187..0000000
--- a/drivers/mtd/maps/mbx860.c
+++ /dev/null
@@ -1,100 +0,0 @@
-/*
- * $Id: mbx860.c,v 1.9 2005/11/07 11:14:27 gleixner Exp $
- *
- * Handle mapping of the flash on MBX860 boards
- *
- * Author:	Anton Todorov
- * Copyright:	(C) 2001 Emness Technology
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <asm/io.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-
-
-#define WINDOW_ADDR 0xfe000000
-#define WINDOW_SIZE 0x00200000
-
-/* Flash / Partition sizing */
-#define MAX_SIZE_KiB              8192
-#define BOOT_PARTITION_SIZE_KiB    512
-#define KERNEL_PARTITION_SIZE_KiB 5632
-#define APP_PARTITION_SIZE_KiB    2048
-
-#define NUM_PARTITIONS 3
-
-/* partition_info gives details on the logical partitions that the split the
- * single flash device into. If the size if zero we use up to the end of the
- * device. */
-static struct mtd_partition partition_info[]={
-	{ .name = "MBX flash BOOT partition",
-	.offset = 0,
-	.size =   BOOT_PARTITION_SIZE_KiB*1024 },
-	{ .name = "MBX flash DATA partition",
-	.offset = BOOT_PARTITION_SIZE_KiB*1024,
-	.size = (KERNEL_PARTITION_SIZE_KiB)*1024 },
-	{ .name = "MBX flash APPLICATION partition",
-	.offset = (BOOT_PARTITION_SIZE_KiB+KERNEL_PARTITION_SIZE_KiB)*1024 }
-};
-
-
-static struct mtd_info *mymtd;
-
-struct map_info mbx_map = {
-	.name = "MBX flash",
-	.size = WINDOW_SIZE,
-	.phys = WINDOW_ADDR,
-	.bankwidth = 4,
-};
-
-int __init init_mbx(void)
-{
-	printk(KERN_NOTICE "Motorola MBX flash device: 0x%x at 0x%x\n", WINDOW_SIZE*4, WINDOW_ADDR);
-	mbx_map.virt = ioremap(WINDOW_ADDR, WINDOW_SIZE * 4);
-
-	if (!mbx_map.virt) {
-		printk("Failed to ioremap\n");
-		return -EIO;
-	}
-	simple_map_init(&mbx_map);
-
-	mymtd = do_map_probe("jedec_probe", &mbx_map);
-	if (mymtd) {
-		mymtd->owner = THIS_MODULE;
-		add_mtd_device(mymtd);
-                add_mtd_partitions(mymtd, partition_info, NUM_PARTITIONS);
-		return 0;
-	}
-
-	iounmap((void *)mbx_map.virt);
-	return -ENXIO;
-}
-
-static void __exit cleanup_mbx(void)
-{
-	if (mymtd) {
-		del_mtd_device(mymtd);
-		map_destroy(mymtd);
-	}
-	if (mbx_map.virt) {
-		iounmap((void *)mbx_map.virt);
-		mbx_map.virt = 0;
-	}
-}
-
-module_init(init_mbx);
-module_exit(cleanup_mbx);
-
-MODULE_AUTHOR("Anton Todorov <a.todorov@emness.com>");
-MODULE_DESCRIPTION("MTD map driver for Motorola MBX860 board");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mtd/maps/ocotea.c b/drivers/mtd/maps/ocotea.c
deleted file mode 100644
index 5522eac..0000000
--- a/drivers/mtd/maps/ocotea.c
+++ /dev/null
@@ -1,154 +0,0 @@
-/*
- * Mapping for Ocotea user flash
- *
- * Matt Porter <mporter@kernel.crashing.org>
- *
- * Copyright 2002-2004 MontaVista Software Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-#include <asm/io.h>
-#include <asm/ibm44x.h>
-#include <platforms/4xx/ocotea.h>
-
-static struct mtd_info *flash;
-
-static struct map_info ocotea_small_map = {
-	.name =		"Ocotea small flash",
-	.size =		OCOTEA_SMALL_FLASH_SIZE,
-	.buswidth =	1,
-};
-
-static struct map_info ocotea_large_map = {
-	.name =		"Ocotea large flash",
-	.size =		OCOTEA_LARGE_FLASH_SIZE,
-	.buswidth =	1,
-};
-
-static struct mtd_partition ocotea_small_partitions[] = {
-	{
-		.name =   "pibs",
-		.offset = 0x0,
-		.size =   0x100000,
-	}
-};
-
-static struct mtd_partition ocotea_large_partitions[] = {
-	{
-		.name =   "fs",
-		.offset = 0,
-		.size =   0x300000,
-	},
-	{
-		.name =   "firmware",
-		.offset = 0x300000,
-		.size =   0x100000,
-	}
-};
-
-int __init init_ocotea(void)
-{
-	u8 fpga0_reg;
-	u8 *fpga0_adr;
-	unsigned long long small_flash_base, large_flash_base;
-
-	fpga0_adr = ioremap64(OCOTEA_FPGA_ADDR, 16);
-	if (!fpga0_adr)
-		return -ENOMEM;
-
-	fpga0_reg = readb((unsigned long)fpga0_adr);
-	iounmap(fpga0_adr);
-
-	if (OCOTEA_BOOT_LARGE_FLASH(fpga0_reg)) {
-		small_flash_base = OCOTEA_SMALL_FLASH_HIGH;
-		large_flash_base = OCOTEA_LARGE_FLASH_LOW;
-	}
-	else {
-		small_flash_base = OCOTEA_SMALL_FLASH_LOW;
-		large_flash_base = OCOTEA_LARGE_FLASH_HIGH;
-	}
-
-	ocotea_small_map.phys = small_flash_base;
-	ocotea_small_map.virt = ioremap64(small_flash_base,
-					 ocotea_small_map.size);
-
-	if (!ocotea_small_map.virt) {
-		printk("Failed to ioremap flash\n");
-		return -EIO;
-	}
-
-	simple_map_init(&ocotea_small_map);
-
-	flash = do_map_probe("map_rom", &ocotea_small_map);
-	if (flash) {
-		flash->owner = THIS_MODULE;
-		add_mtd_partitions(flash, ocotea_small_partitions,
-					ARRAY_SIZE(ocotea_small_partitions));
-	} else {
-		printk("map probe failed for flash\n");
-		iounmap(ocotea_small_map.virt);
-		return -ENXIO;
-	}
-
-	ocotea_large_map.phys = large_flash_base;
-	ocotea_large_map.virt = ioremap64(large_flash_base,
-					 ocotea_large_map.size);
-
-	if (!ocotea_large_map.virt) {
-		printk("Failed to ioremap flash\n");
-		iounmap(ocotea_small_map.virt);
-		return -EIO;
-	}
-
-	simple_map_init(&ocotea_large_map);
-
-	flash = do_map_probe("cfi_probe", &ocotea_large_map);
-	if (flash) {
-		flash->owner = THIS_MODULE;
-		add_mtd_partitions(flash, ocotea_large_partitions,
-					ARRAY_SIZE(ocotea_large_partitions));
-	} else {
-		printk("map probe failed for flash\n");
-		iounmap(ocotea_small_map.virt);
-		iounmap(ocotea_large_map.virt);
-		return -ENXIO;
-	}
-
-	return 0;
-}
-
-static void __exit cleanup_ocotea(void)
-{
-	if (flash) {
-		del_mtd_partitions(flash);
-		map_destroy(flash);
-	}
-
-	if (ocotea_small_map.virt) {
-		iounmap((void *)ocotea_small_map.virt);
-		ocotea_small_map.virt = 0;
-	}
-
-	if (ocotea_large_map.virt) {
-		iounmap((void *)ocotea_large_map.virt);
-		ocotea_large_map.virt = 0;
-	}
-}
-
-module_init(init_ocotea);
-module_exit(cleanup_ocotea);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Matt Porter <mporter@kernel.crashing.org>");
-MODULE_DESCRIPTION("MTD map and partitions for IBM 440GX Ocotea boards");
diff --git a/drivers/mtd/maps/redwood.c b/drivers/mtd/maps/redwood.c
deleted file mode 100644
index 4d858b3..0000000
--- a/drivers/mtd/maps/redwood.c
+++ /dev/null
@@ -1,176 +0,0 @@
-/*
- * $Id: redwood.c,v 1.11 2005/11/07 11:14:28 gleixner Exp $
- *
- * drivers/mtd/maps/redwood.c
- *
- * FLASH map for the IBM Redwood 4/5/6 boards.
- *
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- * 2001-2003 (c) MontaVista, Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-
-#include <asm/io.h>
-
-#if !defined (CONFIG_REDWOOD_6)
-
-#define WINDOW_ADDR 0xffc00000
-#define WINDOW_SIZE 0x00400000
-
-#define RW_PART0_OF	0
-#define RW_PART0_SZ	0x10000
-#define RW_PART1_OF	RW_PART0_SZ
-#define RW_PART1_SZ	0x200000 - 0x10000
-#define RW_PART2_OF	0x200000
-#define RW_PART2_SZ	0x10000
-#define RW_PART3_OF	0x210000
-#define RW_PART3_SZ	0x200000 - (0x10000 + 0x20000)
-#define RW_PART4_OF	0x3e0000
-#define RW_PART4_SZ	0x20000
-
-static struct mtd_partition redwood_flash_partitions[] = {
-	{
-		.name = "Redwood OpenBIOS Vital Product Data",
-		.offset = RW_PART0_OF,
-		.size = RW_PART0_SZ,
-		.mask_flags = MTD_WRITEABLE	/* force read-only */
-	},
-	{
-		.name = "Redwood kernel",
-		.offset = RW_PART1_OF,
-		.size = RW_PART1_SZ
-	},
-	{
-		.name = "Redwood OpenBIOS non-volatile storage",
-		.offset = RW_PART2_OF,
-		.size = RW_PART2_SZ,
-		.mask_flags = MTD_WRITEABLE	/* force read-only */
-	},
-	{
-		.name = "Redwood filesystem",
-		.offset = RW_PART3_OF,
-		.size = RW_PART3_SZ
-	},
-	{
-		.name = "Redwood OpenBIOS",
-		.offset = RW_PART4_OF,
-		.size = RW_PART4_SZ,
-		.mask_flags = MTD_WRITEABLE	/* force read-only */
-	}
-};
-
-#else /* CONFIG_REDWOOD_6 */
-/* FIXME: the window is bigger - armin */
-#define WINDOW_ADDR 0xff800000
-#define WINDOW_SIZE 0x00800000
-
-#define RW_PART0_OF	0
-#define RW_PART0_SZ	0x400000	/* 4 MiB data */
-#define RW_PART1_OF	RW_PART0_OF + RW_PART0_SZ
-#define RW_PART1_SZ	0x10000		/* 64K VPD */
-#define RW_PART2_OF	RW_PART1_OF + RW_PART1_SZ
-#define RW_PART2_SZ	0x400000 - (0x10000 + 0x20000)
-#define RW_PART3_OF	RW_PART2_OF + RW_PART2_SZ
-#define RW_PART3_SZ	0x20000
-
-static struct mtd_partition redwood_flash_partitions[] = {
-	{
-		.name = "Redwood filesystem",
-		.offset = RW_PART0_OF,
-		.size = RW_PART0_SZ
-	},
-	{
-		.name = "Redwood OpenBIOS Vital Product Data",
-		.offset = RW_PART1_OF,
-		.size = RW_PART1_SZ,
-		.mask_flags = MTD_WRITEABLE	/* force read-only */
-	},
-	{
-		.name = "Redwood kernel",
-		.offset = RW_PART2_OF,
-		.size = RW_PART2_SZ
-	},
-	{
-		.name = "Redwood OpenBIOS",
-		.offset = RW_PART3_OF,
-		.size = RW_PART3_SZ,
-		.mask_flags = MTD_WRITEABLE	/* force read-only */
-	}
-};
-
-#endif /* CONFIG_REDWOOD_6 */
-
-struct map_info redwood_flash_map = {
-	.name = "IBM Redwood",
-	.size = WINDOW_SIZE,
-	.bankwidth = 2,
-	.phys = WINDOW_ADDR,
-};
-
-
-#define NUM_REDWOOD_FLASH_PARTITIONS ARRAY_SIZE(redwood_flash_partitions)
-
-static struct mtd_info *redwood_mtd;
-
-int __init init_redwood_flash(void)
-{
-	int err;
-
-	printk(KERN_NOTICE "redwood: flash mapping: %x at %x\n",
-			WINDOW_SIZE, WINDOW_ADDR);
-
-	redwood_flash_map.virt = ioremap(WINDOW_ADDR, WINDOW_SIZE);
-
-	if (!redwood_flash_map.virt) {
-		printk("init_redwood_flash: failed to ioremap\n");
-		return -EIO;
-	}
-	simple_map_init(&redwood_flash_map);
-
-	redwood_mtd = do_map_probe("cfi_probe",&redwood_flash_map);
-
-	if (redwood_mtd) {
-		redwood_mtd->owner = THIS_MODULE;
-		err = add_mtd_partitions(redwood_mtd,
-				redwood_flash_partitions,
-				NUM_REDWOOD_FLASH_PARTITIONS);
-		if (err) {
-			printk("init_redwood_flash: add_mtd_partitions failed\n");
-			iounmap(redwood_flash_map.virt);
-		}
-		return err;
-
-	}
-
-	iounmap(redwood_flash_map.virt);
-	return -ENXIO;
-}
-
-static void __exit cleanup_redwood_flash(void)
-{
-	if (redwood_mtd) {
-		del_mtd_partitions(redwood_mtd);
-		/* moved iounmap after map_destroy - armin */
-		map_destroy(redwood_mtd);
-		iounmap((void *)redwood_flash_map.virt);
-	}
-}
-
-module_init(init_redwood_flash);
-module_exit(cleanup_redwood_flash);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("MontaVista Software <source@mvista.com>");
-MODULE_DESCRIPTION("MTD map driver for the IBM Redwood reference boards");
diff --git a/drivers/mtd/maps/rpxlite.c b/drivers/mtd/maps/rpxlite.c
deleted file mode 100644
index 809a0c8..0000000
--- a/drivers/mtd/maps/rpxlite.c
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * $Id: rpxlite.c,v 1.22 2004/11/04 13:24:15 gleixner Exp $
- *
- * Handle mapping of the flash on the RPX Lite and CLLF boards
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <asm/io.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-
-
-#define WINDOW_ADDR 0xfe000000
-#define WINDOW_SIZE 0x800000
-
-static struct mtd_info *mymtd;
-
-static struct map_info rpxlite_map = {
-	.name = "RPX",
-	.size = WINDOW_SIZE,
-	.bankwidth = 4,
-	.phys = WINDOW_ADDR,
-};
-
-int __init init_rpxlite(void)
-{
-	printk(KERN_NOTICE "RPX Lite or CLLF flash device: %x at %x\n", WINDOW_SIZE*4, WINDOW_ADDR);
-	rpxlite_map.virt = ioremap(WINDOW_ADDR, WINDOW_SIZE * 4);
-
-	if (!rpxlite_map.virt) {
-		printk("Failed to ioremap\n");
-		return -EIO;
-	}
-	simple_map_init(&rpxlite_map);
-	mymtd = do_map_probe("cfi_probe", &rpxlite_map);
-	if (mymtd) {
-		mymtd->owner = THIS_MODULE;
-		add_mtd_device(mymtd);
-		return 0;
-	}
-
-	iounmap((void *)rpxlite_map.virt);
-	return -ENXIO;
-}
-
-static void __exit cleanup_rpxlite(void)
-{
-	if (mymtd) {
-		del_mtd_device(mymtd);
-		map_destroy(mymtd);
-	}
-	if (rpxlite_map.virt) {
-		iounmap((void *)rpxlite_map.virt);
-		rpxlite_map.virt = 0;
-	}
-}
-
-module_init(init_rpxlite);
-module_exit(cleanup_rpxlite);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Arnold Christensen <AKC@pel.dk>");
-MODULE_DESCRIPTION("MTD map driver for RPX Lite and CLLF boards");
diff --git a/drivers/mtd/maps/tqm8xxl.c b/drivers/mtd/maps/tqm8xxl.c
deleted file mode 100644
index 5217340..0000000
--- a/drivers/mtd/maps/tqm8xxl.c
+++ /dev/null
@@ -1,261 +0,0 @@
-/*
- * Handle mapping of the flash memory access routines
- * on TQM8xxL based devices.
- *
- * $Id: tqm8xxl.c,v 1.15 2005/11/07 11:14:28 gleixner Exp $
- *
- * based on rpxlite.c
- *
- * Copyright(C) 2001 Kirk Lee <kirk@hpc.ee.ntu.edu.tw>
- *
- * This code is GPLed
- *
- */
-
-/*
- * According to TQM8xxL hardware manual, TQM8xxL series have
- * following flash memory organisations:
- *	| capacity |	| chip type |	| bank0 |	| bank1 |
- *	    2MiB	   512Kx16	  2MiB		   0
- *	    4MiB	   1Mx16	  4MiB		   0
- *	    8MiB	   1Mx16	  4MiB		   4MiB
- * Thus, we choose CONFIG_MTD_CFI_I2 & CONFIG_MTD_CFI_B4 at
- * kernel configuration.
- */
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-
-#include <asm/io.h>
-
-#define FLASH_ADDR 0x40000000
-#define FLASH_SIZE 0x00800000
-#define FLASH_BANK_MAX 4
-
-// trivial struct to describe partition information
-struct mtd_part_def
-{
-	int nums;
-	unsigned char *type;
-	struct mtd_partition* mtd_part;
-};
-
-//static struct mtd_info *mymtd;
-static struct mtd_info* mtd_banks[FLASH_BANK_MAX];
-static struct map_info* map_banks[FLASH_BANK_MAX];
-static struct mtd_part_def part_banks[FLASH_BANK_MAX];
-static unsigned long num_banks;
-static void __iomem *start_scan_addr;
-
-/*
- * Here are partition information for all known TQM8xxL series devices.
- * See include/linux/mtd/partitions.h for definition of the mtd_partition
- * structure.
- *
- * The *_max_flash_size is the maximum possible mapped flash size which
- * is not necessarily the actual flash size.  It must correspond to the
- * value specified in the mapping definition defined by the
- * "struct map_desc *_io_desc" for the corresponding machine.
- */
-
-#ifdef CONFIG_MTD_PARTITIONS
-/* Currently, TQM8xxL has upto 8MiB flash */
-static unsigned long tqm8xxl_max_flash_size = 0x00800000;
-
-/* partition definition for first flash bank
- * (cf. "drivers/char/flash_config.c")
- */
-static struct mtd_partition tqm8xxl_partitions[] = {
-	{
-	  .name = "ppcboot",
-	  .offset = 0x00000000,
-	  .size = 0x00020000,           /* 128KB           */
-	  .mask_flags = MTD_WRITEABLE,  /* force read-only */
-	},
-	{
-	  .name = "kernel",             /* default kernel image */
-	  .offset = 0x00020000,
-	  .size = 0x000e0000,
-	  .mask_flags = MTD_WRITEABLE,  /* force read-only */
-	},
-	{
-	  .name = "user",
-	  .offset = 0x00100000,
-	  .size = 0x00100000,
-	},
-	{
-	  .name = "initrd",
-	  .offset = 0x00200000,
-	  .size = 0x00200000,
-	}
-};
-/* partition definition for second flash bank */
-static struct mtd_partition tqm8xxl_fs_partitions[] = {
-	{
-	  .name = "cramfs",
-	  .offset = 0x00000000,
-	  .size = 0x00200000,
-	},
-	{
-	  .name = "jffs",
-	  .offset = 0x00200000,
-	  .size = 0x00200000,
-	  //.size = MTDPART_SIZ_FULL,
-	}
-};
-#endif
-
-int __init init_tqm_mtd(void)
-{
-	int idx = 0, ret = 0;
-	unsigned long flash_addr, flash_size, mtd_size = 0;
-	/* pointer to TQM8xxL board info data */
-	bd_t *bd = (bd_t *)__res;
-
-	flash_addr = bd->bi_flashstart;
-	flash_size = bd->bi_flashsize;
-
-	//request maximum flash size address space
-	start_scan_addr = ioremap(flash_addr, flash_size);
-	if (!start_scan_addr) {
-		printk(KERN_WARNING "%s:Failed to ioremap address:0x%x\n", __func__, flash_addr);
-		return -EIO;
-	}
-
-	for (idx = 0 ; idx < FLASH_BANK_MAX ; idx++) {
-		if(mtd_size >= flash_size)
-			break;
-
-		printk(KERN_INFO "%s: chip probing count %d\n", __func__, idx);
-
-		map_banks[idx] = kzalloc(sizeof(struct map_info), GFP_KERNEL);
-		if(map_banks[idx] == NULL) {
-			ret = -ENOMEM;
-			/* FIXME: What if some MTD devices were probed already? */
-			goto error_mem;
-		}
-
-		map_banks[idx]->name = (char *)kmalloc(16, GFP_KERNEL);
-
-		if (!map_banks[idx]->name) {
-			ret = -ENOMEM;
-			/* FIXME: What if some MTD devices were probed already? */
-			goto error_mem;
-		}
-		sprintf(map_banks[idx]->name, "TQM8xxL%d", idx);
-
-		map_banks[idx]->size = flash_size;
-		map_banks[idx]->bankwidth = 4;
-
-		simple_map_init(map_banks[idx]);
-
-		map_banks[idx]->virt = start_scan_addr;
-		map_banks[idx]->phys = flash_addr;
-		/* FIXME: This looks utterly bogus, but I'm trying to
-		   preserve the behaviour of the original (shown here)...
-
-		map_banks[idx]->map_priv_1 =
-		start_scan_addr + ((idx > 0) ?
-		(mtd_banks[idx-1] ? mtd_banks[idx-1]->size : 0) : 0);
-		*/
-
-		if (idx && mtd_banks[idx-1]) {
-			map_banks[idx]->virt += mtd_banks[idx-1]->size;
-			map_banks[idx]->phys += mtd_banks[idx-1]->size;
-		}
-
-		//start to probe flash chips
-		mtd_banks[idx] = do_map_probe("cfi_probe", map_banks[idx]);
-
-		if (mtd_banks[idx]) {
-			mtd_banks[idx]->owner = THIS_MODULE;
-			mtd_size += mtd_banks[idx]->size;
-			num_banks++;
-
-			printk(KERN_INFO "%s: bank%d, name:%s, size:%dbytes \n", __func__, num_banks,
-			mtd_banks[idx]->name, mtd_banks[idx]->size);
-		}
-	}
-
-	/* no supported flash chips found */
-	if (!num_banks) {
-		printk(KERN_NOTICE "TQM8xxL: No support flash chips found!\n");
-		ret = -ENXIO;
-		goto error_mem;
-	}
-
-#ifdef CONFIG_MTD_PARTITIONS
-	/*
-	 * Select Static partition definitions
-	 */
-	part_banks[0].mtd_part = tqm8xxl_partitions;
-	part_banks[0].type = "Static image";
-	part_banks[0].nums = ARRAY_SIZE(tqm8xxl_partitions);
-
-	part_banks[1].mtd_part = tqm8xxl_fs_partitions;
-	part_banks[1].type = "Static file system";
-	part_banks[1].nums = ARRAY_SIZE(tqm8xxl_fs_partitions);
-
-	for(idx = 0; idx < num_banks ; idx++) {
-		if (part_banks[idx].nums == 0) {
-			printk(KERN_NOTICE "TQM flash%d: no partition info available, registering whole flash at once\n", idx);
-			add_mtd_device(mtd_banks[idx]);
-		} else {
-			printk(KERN_NOTICE "TQM flash%d: Using %s partition definition\n",
-					idx, part_banks[idx].type);
-			add_mtd_partitions(mtd_banks[idx], part_banks[idx].mtd_part,
-								part_banks[idx].nums);
-		}
-	}
-#else
-	printk(KERN_NOTICE "TQM flash: registering %d whole flash banks at once\n", num_banks);
-	for(idx = 0 ; idx < num_banks ; idx++)
-		add_mtd_device(mtd_banks[idx]);
-#endif
-	return 0;
-error_mem:
-	for(idx = 0 ; idx < FLASH_BANK_MAX ; idx++) {
-		if(map_banks[idx] != NULL) {
-			kfree(map_banks[idx]->name);
-			map_banks[idx]->name = NULL;
-			kfree(map_banks[idx]);
-			map_banks[idx] = NULL;
-		}
-	}
-error:
-	iounmap(start_scan_addr);
-	return ret;
-}
-
-static void __exit cleanup_tqm_mtd(void)
-{
-	unsigned int idx = 0;
-	for(idx = 0 ; idx < num_banks ; idx++) {
-		/* destroy mtd_info previously allocated */
-		if (mtd_banks[idx]) {
-			del_mtd_partitions(mtd_banks[idx]);
-			map_destroy(mtd_banks[idx]);
-		}
-		/* release map_info not used anymore */
-		kfree(map_banks[idx]->name);
-		kfree(map_banks[idx]);
-	}
-
-	if (start_scan_addr) {
-		iounmap(start_scan_addr);
-		start_scan_addr = 0;
-	}
-}
-
-module_init(init_tqm_mtd);
-module_exit(cleanup_tqm_mtd);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Kirk Lee <kirk@hpc.ee.ntu.edu.tw>");
-MODULE_DESCRIPTION("MTD map driver for TQM8xxL boards");
diff --git a/drivers/mtd/maps/wr_sbc82xx_flash.c b/drivers/mtd/maps/wr_sbc82xx_flash.c
deleted file mode 100644
index ac5b810..0000000
--- a/drivers/mtd/maps/wr_sbc82xx_flash.c
+++ /dev/null
@@ -1,180 +0,0 @@
-/*
- * $Id: wr_sbc82xx_flash.c,v 1.8 2005/11/07 11:14:29 gleixner Exp $
- *
- * Map for flash chips on Wind River PowerQUICC II SBC82xx board.
- *
- * Copyright (C) 2004 Red Hat, Inc.
- *
- * Author: David Woodhouse <dwmw2@infradead.org>
- *
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <asm/io.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-
-#include <asm/immap_cpm2.h>
-
-static struct mtd_info *sbcmtd[3];
-static struct mtd_partition *sbcmtd_parts[3];
-
-struct map_info sbc82xx_flash_map[3] = {
-	{.name = "Boot flash"},
-	{.name = "Alternate boot flash"},
-	{.name = "User flash"}
-};
-
-static struct mtd_partition smallflash_parts[] = {
-	{
-		.name =		"space",
-		.size =		0x100000,
-		.offset =	0,
-	}, {
-		.name =		"bootloader",
-		.size =		MTDPART_SIZ_FULL,
-		.offset =	MTDPART_OFS_APPEND,
-	}
-};
-
-static struct mtd_partition bigflash_parts[] = {
-	{
-		.name =		"bootloader",
-		.size =		0x00100000,
-		.offset =	0,
-	}, {
-		.name =		"file system",
-		.size =		0x01f00000,
-		.offset =	MTDPART_OFS_APPEND,
-	}, {
-		.name =		"boot config",
-		.size =		0x00100000,
-		.offset =	MTDPART_OFS_APPEND,
-	}, {
-		.name =		"space",
-		.size =		0x01f00000,
-		.offset =	MTDPART_OFS_APPEND,
-	}
-};
-
-static const char *part_probes[] __initdata = {"cmdlinepart", "RedBoot", NULL};
-
-#define init_sbc82xx_one_flash(map, br, or)			\
-do {								\
-	(map).phys = (br & 1) ? (br & 0xffff8000) : 0;		\
-	(map).size = (br & 1) ? (~(or & 0xffff8000) + 1) : 0;	\
-	switch (br & 0x00001800) {				\
-	case 0x00000000:					\
-	case 0x00000800:	(map).bankwidth = 1;	break;	\
-	case 0x00001000:	(map).bankwidth = 2;	break;	\
-	case 0x00001800:	(map).bankwidth = 4;	break;	\
-	}							\
-} while (0);
-
-int __init init_sbc82xx_flash(void)
-{
-	volatile memctl_cpm2_t *mc = &cpm2_immr->im_memctl;
-	int bigflash;
-	int i;
-
-#ifdef CONFIG_SBC8560
-	mc = ioremap(0xff700000 + 0x5000, sizeof(memctl_cpm2_t));
-#else
-	mc = &cpm2_immr->im_memctl;
-#endif
-
-	bigflash = 1;
-	if ((mc->memc_br0 & 0x00001800) == 0x00001800)
-		bigflash = 0;
-
-	init_sbc82xx_one_flash(sbc82xx_flash_map[0], mc->memc_br0, mc->memc_or0);
-	init_sbc82xx_one_flash(sbc82xx_flash_map[1], mc->memc_br6, mc->memc_or6);
-	init_sbc82xx_one_flash(sbc82xx_flash_map[2], mc->memc_br1, mc->memc_or1);
-
-#ifdef CONFIG_SBC8560
-	iounmap((void *) mc);
-#endif
-
-	for (i=0; i<3; i++) {
-		int8_t flashcs[3] = { 0, 6, 1 };
-		int nr_parts;
-
-		printk(KERN_NOTICE "PowerQUICC II %s (%ld MiB on CS%d",
-		       sbc82xx_flash_map[i].name,
-		       (sbc82xx_flash_map[i].size >> 20),
-		       flashcs[i]);
-		if (!sbc82xx_flash_map[i].phys) {
-			/* We know it can't be at zero. */
-			printk("): disabled by bootloader.\n");
-			continue;
-		}
-		printk(" at %08lx)\n",  sbc82xx_flash_map[i].phys);
-
-		sbc82xx_flash_map[i].virt = ioremap(sbc82xx_flash_map[i].phys, sbc82xx_flash_map[i].size);
-
-		if (!sbc82xx_flash_map[i].virt) {
-			printk("Failed to ioremap\n");
-			continue;
-		}
-
-		simple_map_init(&sbc82xx_flash_map[i]);
-
-		sbcmtd[i] = do_map_probe("cfi_probe", &sbc82xx_flash_map[i]);
-
-		if (!sbcmtd[i])
-			continue;
-
-		sbcmtd[i]->owner = THIS_MODULE;
-
-		nr_parts = parse_mtd_partitions(sbcmtd[i], part_probes,
-						&sbcmtd_parts[i], 0);
-		if (nr_parts > 0) {
-			add_mtd_partitions (sbcmtd[i], sbcmtd_parts[i], nr_parts);
-			continue;
-		}
-
-		/* No partitioning detected. Use default */
-		if (i == 2) {
-			add_mtd_device(sbcmtd[i]);
-		} else if (i == bigflash) {
-			add_mtd_partitions (sbcmtd[i], bigflash_parts, ARRAY_SIZE(bigflash_parts));
-		} else {
-			add_mtd_partitions (sbcmtd[i], smallflash_parts, ARRAY_SIZE(smallflash_parts));
-		}
-	}
-	return 0;
-}
-
-static void __exit cleanup_sbc82xx_flash(void)
-{
-	int i;
-
-	for (i=0; i<3; i++) {
-		if (!sbcmtd[i])
-			continue;
-
-		if (i<2 || sbcmtd_parts[i])
-			del_mtd_partitions(sbcmtd[i]);
-		else
-			del_mtd_device(sbcmtd[i]);
-
-		kfree(sbcmtd_parts[i]);
-		map_destroy(sbcmtd[i]);
-
-		iounmap((void *)sbc82xx_flash_map[i].virt);
-		sbc82xx_flash_map[i].virt = 0;
-	}
-}
-
-module_init(init_sbc82xx_flash);
-module_exit(cleanup_sbc82xx_flash);
-
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("David Woodhouse <dwmw2@infradead.org>");
-MODULE_DESCRIPTION("Flash map driver for WindRiver PowerQUICC II");
-- 
1.5.4.3

-- 
