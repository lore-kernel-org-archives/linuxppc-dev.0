Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 0295667A65
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Mar 2005 11:41:18 +1100 (EST)
Message-ID: <42323A97.5070105@mvista.com>
Date: Fri, 11 Mar 2005 17:40:55 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: dwmw2@infradead.org
Content-Type: multipart/mixed; boundary="------------090506070708090904090209"
Cc: linux-mtd@lists.infradead.org,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 2.6.12] mtd: Remove MTD map file for Chestnut platform.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.
--------------090506070708090904090209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Remove Chestnut mtd map file.

The chestnut now sets up its MTD map from its platform-specific file so 
the map file drivers/mtd/maps/chestnut.c is no longer needed.  This 
patch removes the file & the Kconfig/Makefile hooks.

Please apply.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
-- 

--------------090506070708090904090209
Content-Type: text/plain;
 name="chestnut_mtd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="chestnut_mtd.patch"

diff -Nru a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
--- a/drivers/mtd/maps/Kconfig	2005-03-11 14:51:08 -07:00
+++ b/drivers/mtd/maps/Kconfig	2005-03-11 14:51:08 -07:00
@@ -405,14 +405,6 @@
 	  Redwood board. If you have one of these boards and would like to
 	  use the flash chips on it, say 'Y'.
 
-config MTD_CHESTNUT
-	tristate "CFI Flash devices mapped on IBM 750FX or IBM 750GX Eval Boards"
-	depends on MTD_CFI && PPC32 && CHESTNUT && MTD_PARTITIONS
-	help
-	  This enables access routines for the flash chips on the IBM
-	  750FX and 750GX Eval Boards. If you have one of these boards and
-	  would like to use the flash chips on it, say 'Y'
-
 config MTD_CSTM_MIPS_IXX
 	tristate "Flash chip mapping on ITE QED-4N-S01B, Globespan IVR or custom board"
 	depends on MIPS && MTD_CFI && MTD_JEDECPROBE && MTD_PARTITIONS
diff -Nru a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
--- a/drivers/mtd/maps/Makefile	2005-03-11 14:51:08 -07:00
+++ b/drivers/mtd/maps/Makefile	2005-03-11 14:51:08 -07:00
@@ -54,7 +54,6 @@
 obj-$(CONFIG_MTD_IMPA7)		+= impa7.o
 obj-$(CONFIG_MTD_FORTUNET)	+= fortunet.o
 obj-$(CONFIG_MTD_REDWOOD)	+= redwood.o
-obj-$(CONFIG_MTD_CHESTNUT)	+= chestnut.o
 obj-$(CONFIG_MTD_UCLINUX)	+= uclinux.o
 obj-$(CONFIG_MTD_NETtel)	+= nettel.o
 obj-$(CONFIG_MTD_SCB2_FLASH)	+= scb2_flash.o
diff -Nru a/drivers/mtd/maps/chestnut.c b/drivers/mtd/maps/chestnut.c
--- a/drivers/mtd/maps/chestnut.c	2005-03-11 14:51:08 -07:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,91 +0,0 @@
-/*
- * drivers/mtd/maps/chestnut.c
- *
- * $Id: chestnut.c,v 1.1 2005/01/05 16:59:50 dwmw2 Exp $
- *
- * Flash map driver for IBM Chestnut (750FXGX Eval)
- *
- * Chose not to enable 8 bit flash as it contains the firmware and board
- * info.  Thus only the 32bit flash is supported.
- *
- * Author: <source@mvista.com>
- *
- * 2004 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <asm/io.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-#include <platforms/chestnut.h>
-
-static struct map_info chestnut32_map = {
-   	.name 		= "User FS",
-   	.size 		= CHESTNUT_32BIT_SIZE,
-   	.bankwidth 	= 4,
-	.phys 		= CHESTNUT_32BIT_BASE,
-};
-
-static struct mtd_partition chestnut32_partitions[] = {
-	{
-		.name 	= "User FS",
-		.offset	= 0,
-		.size	= CHESTNUT_32BIT_SIZE,
-	}
-};
-
-static struct mtd_info *flash32;
-
-int __init init_chestnut(void)
-{
-	/* 32-bit FLASH */
-
-   	chestnut32_map.virt = ioremap(chestnut32_map.phys, chestnut32_map.size);
-
-   	if (!chestnut32_map.virt) {
-      		printk(KERN_NOTICE "Failed to ioremap 32-bit flash\n");
-		return -EIO;
-   	}
-
-	simple_map_init(&chestnut32_map);
-
-   	flash32 = do_map_probe("cfi_probe", &chestnut32_map);
-   	if (flash32) {
-   		flash32->owner = THIS_MODULE;
-   		add_mtd_partitions(flash32, chestnut32_partitions,
-					ARRAY_SIZE(chestnut32_partitions));
-   	} else {
-      		printk(KERN_NOTICE "map probe failed for 32-bit flash\n");
-		return -ENXIO;
-	}
-
-   	return 0;
-}
-
-static void __exit
-cleanup_chestnut(void)
-{
-   	if (flash32) {
-      		del_mtd_partitions(flash32);
-		map_destroy(flash32);
-   	}
-
-   	if (chestnut32_map.virt) {
-      		iounmap((void *)chestnut32_map.virt);
-	  	chestnut32_map.virt = 0;
-   	}
-}
-
-module_init(init_chestnut);
-module_exit(cleanup_chestnut);
-
-MODULE_DESCRIPTION("MTD map and partitions for IBM Chestnut (750fxgx Eval)");
-MODULE_AUTHOR("<source@mvista.com>");
-MODULE_LICENSE("GPL");

--------------090506070708090904090209--
