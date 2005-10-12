Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id 0DD50684C5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Oct 2005 01:44:53 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Wed, 12 Oct 2005 17:44:31 +0200
Sender: wd@denx.de
Message-Id: <20051012154431.C4C53353A4F@atlas.denx.de>
Cc: llandre <r&d2@dave-tech.it>
Subject: [PATCH 2/2] MTD: Add initial support for DAVE "PPChameleon" board.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

the following  patch  (against  current  kernel.org  tree)  adds  MTD
support  for  the NOR and NAND flashes on the "PPChameleon" modules /
eval boards manufactured by DAVE s.r.l.



[PATCH] MTD: Add support for DAVE "PPChameleon" board.

Included support for the NOR and NAND flashes on the module, and for
the NAND flash on the eval board.

Note: on my system, all sectors of the NAND flash on the eval board
get flagged as bad, while there are actually only 5 bad sectors on
this device. This needs more investigation,

Signed-off-by: Wolfgang Denk <wd@denx.de>

---
commit 1fe4ae42778972c8065e5aaa1e807571798c57e8
tree 80ae5bb762dd29bb82d39f7bdd69ed7951aee629
parent c9759e3e50c6e0f7c935a0f84f6c811e0bc3bc84
author Wolfgang Denk <wd@pollux.denx.de> Wed, 12 Oct 2005 17:42:18 +0200
committer Wolfgang Denk <wd@pollux.denx.de> Wed, 12 Oct 2005 17:42:18 +0200

 drivers/mtd/maps/Kconfig          |    8 +++
 drivers/mtd/maps/Makefile         |    1 
 drivers/mtd/maps/ppchameleon.c    |  109 +++++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/Kconfig          |    6 +-
 drivers/mtd/nand/ppchameleonevb.c |   55 +++++++++----------
 5 files changed, 147 insertions(+), 32 deletions(-)

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -356,6 +356,14 @@ config MTD_REDWOOD
 	  Redwood board. If you have one of these boards and would like to
 	  use the flash chips on it, say 'Y'.
 
+config MTD_PPCHAMELEON
+	tristate "Flash device mapped on DAVE PPChamelonEVB Boards"
+	depends on MTD_CFI && PPC32 && 40x && PPChameleonEVB
+	help
+          This enables access routines for the flash chips on the
+          DAVE PPChamelonEVB board. If you have one of these boardsr
+	  and would like to use the flash chips on it, say 'Y'.
+
 config MTD_UBOOT_PARTITIONS
 	bool "Use U-Boot partition setup"
 	depends on MTD_WALNUT || MTD_EBONY || MTD_OCOTEA || MTD_BAMBOO
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -72,3 +72,4 @@ obj-$(CONFIG_MTD_DMV182)	+= dmv182.o
 obj-$(CONFIG_MTD_SHARP_SL)	+= sharpsl-flash.o
 obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
 obj-$(CONFIG_MTD_OMAP_NOR)	+= omap_nor.o
+obj-$(CONFIG_MTD_PPCHAMELEON)	+= ppchameleon.o
diff --git a/drivers/mtd/maps/ppchameleon.c b/drivers/mtd/maps/ppchameleon.c
new file mode 100644
--- /dev/null
+++ b/drivers/mtd/maps/ppchameleon.c
@@ -0,0 +1,109 @@
+/*
+ * drivers/mtd/maps/ppchameleon.c
+ *
+ * Mapping for DAVE PPChamelonEVB flash
+ *
+ * Maintained by Wolfgang Denk, <wd@denx.de>
+ *
+ * Copyright (c) 2005 DENX Software Engineering
+ * Wolfgang Denk <wd@denx.de>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
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
+#include <linux/version.h>
+#include <asm/io.h>
+#include <asm/ibm4xx.h>
+#include <asm/ppcboot.h>
+
+extern bd_t __res;
+
+static struct mtd_info *flash;
+
+static struct map_info ppchameleon_map = {
+	.name =		"PPChameleon",
+	.bankwidth =	2,
+};
+
+static struct mtd_partition ppchameleon_partitions[] = {
+    {
+	name:	"linux",			/* Linux kernel image */
+	offset:	0x00000000,
+	size:	0x00180000,
+/*	mask_flags: MTD_WRITEABLE,		/ * force read-only */
+    },
+    {
+	name:	"user",				/* unassigned */
+	offset:	0x00180000,
+	size:	0x00240000,
+    },
+    {
+	name:	"u-boot",			/* U-Boot Firmware */
+	offset:	0x003C0000,
+	size:	0x00040000,			/* 256 KB */
+/*	mask_flags: MTD_WRITEABLE,		/ * force read-only */
+    },
+};
+
+int __init init_ppchameleon(void)
+{
+	unsigned long flash_base, flash_size;
+
+	flash_base = __res.bi_flashstart;
+	flash_size = __res.bi_flashsize;
+
+	ppchameleon_map.size = flash_size;
+	ppchameleon_map.phys = flash_base;
+	ppchameleon_map.virt =
+		(void __iomem *)ioremap(flash_base, ppchameleon_map.size);
+
+	if (!ppchameleon_map.virt) {
+		printk("Failed to ioremap flash.\n");
+		return -EIO;
+	}
+
+	simple_map_init(&ppchameleon_map);
+
+	flash = do_map_probe("cfi_probe", &ppchameleon_map);
+	if (flash) {
+		flash->owner = THIS_MODULE;
+		add_mtd_partitions(flash, ppchameleon_partitions,
+					ARRAY_SIZE(ppchameleon_partitions));
+	} else {
+		printk("map probe failed for flash\n");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static void __exit cleanup_ppchameleon(void)
+{
+	if (flash) {
+		del_mtd_partitions(flash);
+		map_destroy(flash);
+	}
+
+	if (ppchameleon_map.virt) {
+		iounmap((void *)ppchameleon_map.virt);
+		ppchameleon_map.virt = 0;
+	}
+}
+
+module_init(init_ppchameleon);
+module_exit(cleanup_ppchameleon);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Wolfgang Denk <wd@denx.de>");
+MODULE_DESCRIPTION("MTD map and partitions for DAVE PPChameleonEVB boards");
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -75,10 +75,10 @@ config MTD_NAND_RTC_FROM4
 	  flash interface board (FROM_BOARD4)
 
 config MTD_NAND_PPCHAMELEONEVB
-	tristate "NAND Flash device on PPChameleonEVB board"
-	depends on PPCHAMELEONEVB && MTD_NAND
+	tristate "NAND Flash device on DAVE PPChameleonEVB board"
+	depends on PPChameleonEVB && MTD_NAND
 	help
-	  This enables the NAND flash driver on the PPChameleon EVB Board.
+	  This enables the NAND flash driver on the DAVE PPChameleonEVB Board.
 
 config MTD_NAND_S3C2410
 	tristate "NAND Flash support for S3C2410/S3C2440 SoC"
diff --git a/drivers/mtd/nand/ppchameleonevb.c b/drivers/mtd/nand/ppchameleonevb.c
--- a/drivers/mtd/nand/ppchameleonevb.c
+++ b/drivers/mtd/nand/ppchameleonevb.c
@@ -1,6 +1,7 @@
 /*
  *  drivers/mtd/nand/ppchameleonevb.c
  *
+ *  Copyright (C) 2005 Wolfgang Denk <wd@denx.de>
  *  Copyright (C) 2003 DAVE Srl (info@wawnet.biz)
  *
  *  Derived from drivers/mtd/nand/edb7312.c
@@ -30,7 +31,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <asm/io.h>
-#include <platforms/PPChameleonEVB.h>
+#include <platforms/4xx/ppchameleon.h>
 
 #undef USE_READY_BUSY_PIN
 #define USE_READY_BUSY_PIN
@@ -41,8 +42,9 @@
 /* handy sizes */
 #define SZ_4M                           0x00400000
 #define NAND_SMALL_SIZE                 0x02000000
-#define NAND_MTD_NAME		"ppchameleon-nand"
-#define NAND_EVB_MTD_NAME	"ppchameleonevb-nand"
+
+#define NAND_MTD_NAME			"ppchameleon-nand"
+#define NAND_EVB_MTD_NAME		"ppchameleonevb-nand"
 
 /* GPIO pins used to drive NAND chip mounted on processor module */
 #define NAND_nCE_GPIO_PIN 		(0x80000000 >> 1)
@@ -50,51 +52,46 @@
 #define NAND_ALE_GPIO_PIN 		(0x80000000 >> 3)
 #define NAND_RB_GPIO_PIN 		(0x80000000 >> 4)
 /* GPIO pins used to drive NAND chip mounted on EVB */
-#define NAND_EVB_nCE_GPIO_PIN 	(0x80000000 >> 14)
-#define NAND_EVB_CLE_GPIO_PIN 	(0x80000000 >> 15)
-#define NAND_EVB_ALE_GPIO_PIN 	(0x80000000 >> 16)
-#define NAND_EVB_RB_GPIO_PIN 	(0x80000000 >> 31)
+#define NAND_EVB_nCE_GPIO_PIN 		(0x80000000 >> 14)
+#define NAND_EVB_CLE_GPIO_PIN 		(0x80000000 >> 15)
+#define NAND_EVB_ALE_GPIO_PIN 		(0x80000000 >> 16)
+#define NAND_EVB_RB_GPIO_PIN 		(0x80000000 >> 31)
 
 /*
  * MTD structure for PPChameleonEVB board
  */
-static struct mtd_info *ppchameleon_mtd 	= NULL;
+static struct mtd_info *ppchameleon_mtd    = NULL;
 static struct mtd_info *ppchameleonevb_mtd = NULL;
 
 /*
  * Module stuff
  */
-static unsigned long ppchameleon_fio_pbase 	= CFG_NAND0_PADDR;
+static unsigned long ppchameleon_fio_pbase    = CFG_NAND0_PADDR;
 static unsigned long ppchameleonevb_fio_pbase = CFG_NAND1_PADDR;
 
-#ifdef MODULE
-module_param(ppchameleon_fio_pbase, ulong, 0);
-module_param(ppchameleonevb_fio_pbase, ulong, 0);
-#else
-__setup("ppchameleon_fio_pbase=",ppchameleon_fio_pbase);
-__setup("ppchameleonevb_fio_pbase=",ppchameleonevb_fio_pbase);
-#endif
-
 #ifdef CONFIG_MTD_PARTITIONS
 /*
  * Define static partitions for flash devices
  */
 static struct mtd_partition partition_info_hi[] = {
-	{ name: "PPChameleon HI Nand Flash",
-		  offset: 0,
-		  size: 128*1024*1024 }
+    {	name:	"PPChameleon HI Nand Flash",
+	offset:	0,
+	size:	128*1024*1024
+    },
 };
 
 static struct mtd_partition partition_info_me[] = {
-	{ name: "PPChameleon ME Nand Flash",
-		  offset: 0,
-		  size: 32*1024*1024 }
+    {	name:	"PPChameleon ME Nand Flash",
+	offset:	0,
+	size:	32*1024*1024
+    },
 };
 
 static struct mtd_partition partition_info_evb[] = {
-	{ name: "PPChameleonEVB Nand Flash",
-		  offset: 0,
-		  size: 32*1024*1024 }
+    {	name:	"PPChameleonEVB Nand Flash",
+	offset:	0,
+	size:	32*1024*1024
+    },
 };
 
 #define NUM_PARTITIONS 1
@@ -405,9 +402,9 @@ static void __exit ppchameleonevb_cleanu
 	
 	/* Release iomaps */
 	this = (struct nand_chip *) &ppchameleon_mtd[1];
-	iounmap((void *) this->IO_ADDR_R;
+	iounmap((void *) this->IO_ADDR_R);
 	this = (struct nand_chip *) &ppchameleonevb_mtd[1];
-	iounmap((void *) this->IO_ADDR_R;
+	iounmap((void *) this->IO_ADDR_R);
 
 	/* Free the MTD device structure */
 	kfree (ppchameleon_mtd);
@@ -417,4 +414,4 @@ module_exit(ppchameleonevb_cleanup);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("DAVE Srl <support-ppchameleon@dave-tech.it>");
-MODULE_DESCRIPTION("MTD map driver for DAVE Srl PPChameleonEVB board");
+MODULE_DESCRIPTION("MTD NAND flash driver for DAVE Srl PPChameleonEVB board");
