Return-Path: <dgibson@ozlabs.org>
Date: Wed, 9 May 2007 17:13:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Woodhouse <dwmw2@redhat.com>
Subject: Remove flash maps for no longer supported 405LP boards
Message-ID: <20070509071331.GA16163@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

drivers/mtd/maps includes flash maps for the Beech and Arctic PowerPC
405LP based boards.  However, the 405LP was discontinued before any
quantity were distributed and those boards no longer have kernel
support in general.  Therefore, this patch removes this obsolete code.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

---
 drivers/mtd/maps/Kconfig      |   16 ----
 drivers/mtd/maps/Makefile     |    2 
 drivers/mtd/maps/arctic-mtd.c |  145 ------------------------------------------
 drivers/mtd/maps/beech-mtd.c  |  122 -----------------------------------
 4 files changed, 285 deletions(-)

Index: working-2.6/drivers/mtd/maps/Kconfig
===================================================================
--- working-2.6.orig/drivers/mtd/maps/Kconfig	2007-05-01 10:05:02.000000000 +1000
+++ working-2.6/drivers/mtd/maps/Kconfig	2007-05-09 17:11:27.000000000 +1000
@@ -358,22 +358,6 @@ config MTD_CFI_FLAGADM
 	  Mapping for the Flaga digital module. If you don't have one, ignore
 	  this setting.
 
-config MTD_BEECH
-	tristate "CFI Flash device mapped on IBM 405LP Beech"
-	depends on MTD_CFI && BEECH
-	help
-	  This enables access routines for the flash chips on the IBM
-	  405LP Beech board. If you have one of these boards and would like
-	  to use the flash chips on it, say 'Y'.
-
-config MTD_ARCTIC
-	tristate "CFI Flash device mapped on IBM 405LP Arctic"
-	depends on MTD_CFI && ARCTIC2
-	help
-	  This enables access routines for the flash chips on the IBM 405LP
-	  Arctic board. If you have one of these boards and would like to
-	  use the flash chips on it, say 'Y'.
-
 config MTD_WALNUT
 	tristate "Flash device mapped on IBM 405GP Walnut"
 	depends on MTD_JEDECPROBE && WALNUT
Index: working-2.6/drivers/mtd/maps/Makefile
===================================================================
--- working-2.6.orig/drivers/mtd/maps/Makefile	2007-05-01 10:05:02.000000000 +1000
+++ working-2.6/drivers/mtd/maps/Makefile	2007-05-09 17:08:45.000000000 +1000
@@ -58,8 +58,6 @@ obj-$(CONFIG_MTD_NETtel)	+= nettel.o
 obj-$(CONFIG_MTD_SCB2_FLASH)	+= scb2_flash.o
 obj-$(CONFIG_MTD_EBONY)		+= ebony.o
 obj-$(CONFIG_MTD_OCOTEA)	+= ocotea.o
-obj-$(CONFIG_MTD_BEECH)		+= beech-mtd.o
-obj-$(CONFIG_MTD_ARCTIC)	+= arctic-mtd.o
 obj-$(CONFIG_MTD_WALNUT)        += walnut.o
 obj-$(CONFIG_MTD_H720X)		+= h720x-flash.o
 obj-$(CONFIG_MTD_SBC8240)	+= sbc8240.o
Index: working-2.6/drivers/mtd/maps/arctic-mtd.c
===================================================================
--- working-2.6.orig/drivers/mtd/maps/arctic-mtd.c	2007-01-24 12:01:18.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,145 +0,0 @@
-/*
- * $Id: arctic-mtd.c,v 1.14 2005/11/07 11:14:26 gleixner Exp $
- *
- * drivers/mtd/maps/arctic-mtd.c MTD mappings and partition tables for
- *                              IBM 405LP Arctic boards.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Copyright (C) 2002, International Business Machines Corporation
- * All Rights Reserved.
- *
- * Bishop Brock
- * IBM Research, Austin Center for Low-Power Computing
- * bcbrock@us.ibm.com
- * March 2002
- *
- * modified for Arctic by,
- * David Gibson
- * IBM OzLabs, Canberra, Australia
- * <arctic@gibson.dropbear.id.au>
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/init.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-
-#include <asm/io.h>
-#include <asm/ibm4xx.h>
-
-/*
- * 0 : 0xFE00 0000 - 0xFEFF FFFF : Filesystem 1 (16MiB)
- * 1 : 0xFF00 0000 - 0xFF4F FFFF : kernel (5.12MiB)
- * 2 : 0xFF50 0000 - 0xFFF5 FFFF : Filesystem 2 (10.624MiB) (if non-XIP)
- * 3 : 0xFFF6 0000 - 0xFFFF FFFF : PIBS Firmware (640KiB)
- */
-
-#define FFS1_SIZE	0x01000000 /* 16MiB */
-#define KERNEL_SIZE	0x00500000 /* 5.12MiB */
-#define FFS2_SIZE	0x00a60000 /* 10.624MiB */
-#define FIRMWARE_SIZE	0x000a0000 /* 640KiB */
-
-
-#define NAME     	"Arctic Linux Flash"
-#define PADDR    	SUBZERO_BOOTFLASH_PADDR
-#define BUSWIDTH	2
-#define SIZE		SUBZERO_BOOTFLASH_SIZE
-#define PARTITIONS	4
-
-/* Flash memories on these boards are memory resources, accessed big-endian. */
-
-{
-  /* do nothing for now */
-}
-
-static struct map_info arctic_mtd_map = {
-	.name		= NAME,
-	.size		= SIZE,
-	.bankwidth	= BUSWIDTH,
-	.phys		= PADDR,
-};
-
-static struct mtd_info *arctic_mtd;
-
-static struct mtd_partition arctic_partitions[PARTITIONS] = {
-	{ .name		= "Filesystem",
-	  .size		= FFS1_SIZE,
-	  .offset	= 0,},
-        { .name		= "Kernel",
-	  .size		= KERNEL_SIZE,
-	  .offset	= FFS1_SIZE,},
-	{ .name		= "Filesystem",
-	  .size		= FFS2_SIZE,
-	  .offset	= FFS1_SIZE + KERNEL_SIZE,},
-	{ .name		= "Firmware",
-	  .size		= FIRMWARE_SIZE,
-	  .offset	= SUBZERO_BOOTFLASH_SIZE - FIRMWARE_SIZE,},
-};
-
-static int __init
-init_arctic_mtd(void)
-{
-	int err;
-
-	printk("%s: 0x%08x at 0x%08x\n", NAME, SIZE, PADDR);
-
-	arctic_mtd_map.virt = ioremap(PADDR, SIZE);
-
-	if (!arctic_mtd_map.virt) {
-		printk("%s: failed to ioremap 0x%x\n", NAME, PADDR);
-		return -EIO;
-	}
-	simple_map_init(&arctic_mtd_map);
-
-	printk("%s: probing %d-bit flash bus\n", NAME, BUSWIDTH * 8);
-	arctic_mtd = do_map_probe("cfi_probe", &arctic_mtd_map);
-
-	if (!arctic_mtd) {
-		iounmap(arctic_mtd_map.virt);
-		return -ENXIO;
-	}
-
-	arctic_mtd->owner = THIS_MODULE;
-
-	err = add_mtd_partitions(arctic_mtd, arctic_partitions, PARTITIONS);
-	if (err) {
-		printk("%s: add_mtd_partitions failed\n", NAME);
-		iounmap(arctic_mtd_map.virt);
-	}
-
-	return err;
-}
-
-static void __exit
-cleanup_arctic_mtd(void)
-{
-	if (arctic_mtd) {
-		del_mtd_partitions(arctic_mtd);
-		map_destroy(arctic_mtd);
-		iounmap((void *) arctic_mtd_map.virt);
-	}
-}
-
-module_init(init_arctic_mtd);
-module_exit(cleanup_arctic_mtd);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("David Gibson <arctic@gibson.dropbear.id.au>");
-MODULE_DESCRIPTION("MTD map and partitions for IBM 405LP Arctic boards");
Index: working-2.6/drivers/mtd/maps/beech-mtd.c
===================================================================
--- working-2.6.orig/drivers/mtd/maps/beech-mtd.c	2007-01-24 12:01:18.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,122 +0,0 @@
-/*
- * $Id: beech-mtd.c,v 1.11 2005/11/07 11:14:26 gleixner Exp $
- *
- * drivers/mtd/maps/beech-mtd.c MTD mappings and partition tables for
- *                              IBM 405LP Beech boards.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Copyright (C) 2002, International Business Machines Corporation
- * All Rights Reserved.
- *
- * Bishop Brock
- * IBM Research, Austin Center for Low-Power Computing
- * bcbrock@us.ibm.com
- * March 2002
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/init.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-
-#include <asm/io.h>
-#include <asm/ibm4xx.h>
-
-#define NAME     "Beech Linux Flash"
-#define PADDR    BEECH_BIGFLASH_PADDR
-#define SIZE     BEECH_BIGFLASH_SIZE
-#define BUSWIDTH 1
-
-/* Flash memories on these boards are memory resources, accessed big-endian. */
-
-
-static struct map_info beech_mtd_map = {
-	.name =		NAME,
-	.size =		SIZE,
-	.bankwidth =	BUSWIDTH,
-	.phys =		PADDR
-};
-
-static struct mtd_info *beech_mtd;
-
-static struct mtd_partition beech_partitions[2] = {
-	{
-	      .name = "Linux Kernel",
-	      .size = BEECH_KERNEL_SIZE,
-	      .offset = BEECH_KERNEL_OFFSET
-	}, {
-	      .name = "Free Area",
-	      .size = BEECH_FREE_AREA_SIZE,
-	      .offset = BEECH_FREE_AREA_OFFSET
-	}
-};
-
-static int __init
-init_beech_mtd(void)
-{
-	int err;
-
-	printk("%s: 0x%08x at 0x%08x\n", NAME, SIZE, PADDR);
-
-	beech_mtd_map.virt = ioremap(PADDR, SIZE);
-
-	if (!beech_mtd_map.virt) {
-		printk("%s: failed to ioremap 0x%x\n", NAME, PADDR);
-		return -EIO;
-	}
-
-	simple_map_init(&beech_mtd_map);
-
-	printk("%s: probing %d-bit flash bus\n", NAME, BUSWIDTH * 8);
-	beech_mtd = do_map_probe("cfi_probe", &beech_mtd_map);
-
-	if (!beech_mtd) {
-		iounmap(beech_mtd_map.virt);
-		return -ENXIO;
-	}
-
-	beech_mtd->owner = THIS_MODULE;
-
-	err = add_mtd_partitions(beech_mtd, beech_partitions, 2);
-	if (err) {
-		printk("%s: add_mtd_partitions failed\n", NAME);
-		iounmap(beech_mtd_map.virt);
-	}
-
-	return err;
-}
-
-static void __exit
-cleanup_beech_mtd(void)
-{
-	if (beech_mtd) {
-		del_mtd_partitions(beech_mtd);
-		map_destroy(beech_mtd);
-		iounmap((void *) beech_mtd_map.virt);
-	}
-}
-
-module_init(init_beech_mtd);
-module_exit(cleanup_beech_mtd);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Bishop Brock <bcbrock@us.ibm.com>");
-MODULE_DESCRIPTION("MTD map and partitions for IBM 405LP Beech boards");

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
