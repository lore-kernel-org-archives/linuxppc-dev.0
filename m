Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 3D41B67BCE
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 00:23:13 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k5SENBO6023466
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 07:23:11 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5SEN9gu016242
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 09:23:10 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E04FD3@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'dwmw2@infradead.org'" <dwmw2@infradead.org>
Subject: [PATCH 2/7] mtd: Add map file for mpc83xx boards
Date: Wed, 28 Jun 2006 22:23:08 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	Yin Olivia-r63875 <Hong-Hua.Yin@freescale.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org,
	"'linux-mtd@lists.infradead.org'" <linux-mtd@lists.infradead.org>,
	Chu hanjin-r52514 <Hanjin.Chu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Flash mapping file for MPC83xx MDS platforms.

Signed-off-by: Yin Olivia <hong-hua.yin@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
 drivers/mtd/maps/Kconfig         |    6 +
 drivers/mtd/maps/Makefile        |    1 
 drivers/mtd/maps/mpc83xx_flash.c |  154 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 0 deletions(-)
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 7abd7fe..eac049e 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -631,5 +631,11 @@ config MTD_PLATRAM
 
 	  This selection automatically selects the map_ram driver.
 
+config MTD_MPC83xx
+	tristate "CFI Flash device map on MPC83xx MDS support"
+	depends on 83xx && MTD_CFI && MTD_PARTITIONS
+	help
+	  Freescale MPC83xx board uses CFI compliant flash.
+
 endmenu
 
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index ab71f17..f0f8afd 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -71,3 +71,4 @@ obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
 obj-$(CONFIG_MTD_OMAP_NOR)	+= omap_nor.o
 obj-$(CONFIG_MTD_MTX1)		+= mtx-1_flash.o
 obj-$(CONFIG_MTD_TQM834x)	+= tqm834x.o
+obj-$(CONFIG_MTD_MPC83xx)	+= mpc83xx_flash.o
diff --git a/drivers/mtd/maps/mpc83xx_flash.c b/drivers/mtd/maps/mpc83xx_flash.c
new file mode 100644
index 0000000..84f058a
--- /dev/null
+++ b/drivers/mtd/maps/mpc83xx_flash.c
@@ -0,0 +1,154 @@
+/*
+ * Handle mapping of the flash on MPC83xx board
+ *
+ * Copyright (C) 2005 Freescale semicondutor
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <asm/io.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+
+
+/* MPC8349MDS flash layout 
+ * 0 : 0xFE00 0000 - 0xFE01 FFFF : HRCW (128KB)
+ * 1 : 0xFE02 0000 - 0xFE5F FFFF : JFFS2 file system (5.875MB)
+ * 2 : 0xFE60 0000 - 0xFE6F FFFF : Kernel (1MB)
+ * 3 : 0xFE70 0000 - 0xFE7F FFFF : U-Boot (1MB)
+ */
+#ifdef CONFIG_MPC834x
+#define WINDOW_ADDR 0xFE000000
+#define WINDOW_SIZE 0x00800000
+#endif
+
+/* MPC8360EPB flash layout 
+ * 0 : 0xFE00 0000 - 0xFE01 FFFF : HRCW (128KB)
+ * 1 : 0xFE02 0000 - 0xFE8F FFFF : JFFS2 file system (8.875MB)
+ * 2 : 0xFE90 0000 - 0xFECF FFFF : Ramdisk file system (4MB)
+ * 3 : 0xFED0 0000 - 0xFEEF FFFF : Kernel (2MB)
+ * 4 : 0xFEF0 0000 - 0xFEFF FFFF : U-Boot (1MB)
+ */
+#ifdef CONFIG_MPC8360E_PB
+#define WINDOW_ADDR 0xFE000000
+#define WINDOW_SIZE 0x01000000
+#endif
+
+/* partition_info gives details on the logical partitions that the split the
+ * single flash device into. If the size if zero we use up to the end of the
+ * device. */
+static struct mtd_partition partition_info[]={
+	{
+		.name		= "HRCW",
+		.offset 	= 0,
+		.size		= 0x020000,
+		.mask_flags	= MTD_WRITEABLE
+	},
+	{
+		.name		= "JFFS2",
+		.offset		= MTDPART_OFS_APPEND,
+#ifdef CONFIG_MPC834x
+		.size		= 0x5E0000
+#endif
+#ifdef CONFIG_MPC8360E_PB
+		.size		= 0x8E0000
+#endif
+	},
+#ifdef CONFIG_MPC8360E_PB
+	{
+		.name           = "Ramdisk",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x400000
+	},
+#endif
+	{
+		.name		= "Kernel",
+		.offset		= MTDPART_OFS_APPEND,
+#ifdef CONFIG_MPC834x
+		.size		= 0x100000
+#endif
+#ifdef CONFIG_MPC8360E_PB
+		.size		= 0x200000
+#endif
+	},
+	{
+		.name		= "U-Boot",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 0x100000,
+		.mask_flags	= MTD_WRITEABLE
+    }
+};
+
+#define PARTITION_NUM (sizeof(partition_info)/sizeof(struct mtd_partition))
+
+static struct mtd_info *mymtd;
+
+
+struct map_info mpc83xx_map = {
+#ifdef CONFIG_MPC834x
+	.name		= "MPC8349MDS Flash Map Info",
+#endif
+#ifdef CONFIG_MPC8360E_PB
+	.name		= "MPC8360E PB Flash Map Info",
+#endif
+	.size		= WINDOW_SIZE,
+	.phys		= WINDOW_ADDR,
+	.bankwidth	= 2,
+};
+
+int __init init_mpc83xx_mtd(void)
+{
+	char *board;
+#ifdef CONFIG_MPC834x
+	board = "MPC8349MDS";
+#endif
+#ifdef CONFIG_MPC8360E_PB
+	board = "MPC8360E PB"; 
+#endif
+	printk(KERN_NOTICE "%s flash device: %x at %x Partition number %d\n",
+			board,WINDOW_SIZE, WINDOW_ADDR, PARTITION_NUM);
+	mpc83xx_map.virt = ioremap(WINDOW_ADDR, WINDOW_SIZE);
+
+	if (!mpc83xx_map.virt) {
+		printk("Failed to ioremap\n");
+		return -EIO;
+	}
+	simple_map_init(&mpc83xx_map);
+	
+	mymtd = do_map_probe("cfi_probe", &mpc83xx_map);
+	if (mymtd) {
+		mymtd->owner = THIS_MODULE;
+                add_mtd_partitions(mymtd, partition_info, PARTITION_NUM);
+		printk(KERN_NOTICE "%s flash device initialized\n", board);
+		return 0;
+	}
+
+	iounmap((void *)mpc83xx_map.virt);
+	return -ENXIO;
+}
+
+static void __exit cleanup_mpc83xx_mtd(void)
+{
+	if (mymtd) {
+		del_mtd_device(mymtd);
+		map_destroy(mymtd);
+	}
+	if (mpc83xx_map.virt) {
+		iounmap((void *)mpc83xx_map.virt);
+		mpc83xx_map.virt = 0;
+	}
+}
+
+module_init(init_mpc83xx_mtd);
+module_exit(cleanup_mpc83xx_mtd);
+
+MODULE_AUTHOR("FSL");
+MODULE_DESCRIPTION("MTD map driver for Freescale MPC83xx board");
+MODULE_LICENSE("GPL");
