Return-Path: <greg.weeks@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 087ED67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 06:05:53 +1100 (EST)
Message-ID: <4237320D.9040200@timesys.com>
Date: Tue, 15 Mar 2005 14:05:49 -0500
From: Greg Weeks <greg.weeks@timesys.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [patch] mpc8560ads mtd map 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Add an MTD map for the flash on the mpc8560ads board.

Signed-off-by: Greg Weeks <greg.weeks@timesys.com>


--- /dev/null
+++ ppc-mpc8560ads/drivers/mtd/maps/mpc85xxads.c
@@ -0,0 +1,104 @@
+/*
+ * $Id$
+ *
+ * Mapping for Motorola MPC85xxADS flash
+ *
+ * Greg Weeks <greg.weeks@timesys.com>
+ *
+ * Copyright 2004 Timesys Corp.
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
+#include <asm/io.h>
+#include <platforms/85xx/mpc85xx_ads_common.h>
+
+static struct mtd_info *flash;
+
+static struct map_info mpc85xxads_map = {
+       .name =         "mpc85xxads-flash",
+       .size =         MPC85XXADS_FLASH_SIZE,
+       .bankwidth =    4,
+};
+
+static struct mtd_partition mpc85xxads_partitions[] = {
+       {
+               .name =   "Linux JFFS2 Filesystem",
+               .offset = 0x0,
+               .size =   0x00800000,
+       },
+       {
+               .name =   "Linux Kernel",
+               .offset = 0x00800000,
+               .size =   0x00200000,
+       },
+       {
+               .name =   "Linux INITRD",
+               .offset = 0x00a00000,
+               .size =   0x00580000,
+       },
+       {
+               .name   = "Bootloader",
+               .offset = 0x00f80000,
+               .size   = 0x00080000,
+       }
+};
+
+int __init mpc85xxads_map_init(void)
+{
+       unsigned long mpc85xxads_flash_base = MPC85XXADS_FLASH_BASE;
+
+       mpc85xxads_map.phys = mpc85xxads_flash_base;
+       mpc85xxads_map.virt = (unsigned 
long)ioremap(mpc85xxads_flash_base, mpc85xxads_map.size);
+
+       if (!mpc85xxads_map.virt) {
+               printk("Failed to ioremap flash\n");
+               return -EIO;
+       }
+
+       simple_map_init(&mpc85xxads_map);
+
+       flash = do_map_probe("cfi_probe", &mpc85xxads_map);
+       if (flash) {
+               flash->owner = THIS_MODULE;
+               add_mtd_partitions(flash, mpc85xxads_partitions,
+                                       ARRAY_SIZE(mpc85xxads_partitions));
+       } else {
+               iounmap((void *)mpc85xxads_map.virt);
+               printk("map probe failed for flash\n");
+               return -ENXIO;
+       }
+
+       return 0;
+}
+
+static void __exit mpc85xxads_map_exit(void)
+{
+       if (flash) {
+               del_mtd_partitions(flash);
+               map_destroy(flash);
+       }
+
+       if (mpc85xxads_map.virt) {
+               iounmap((void *)mpc85xxads_map.virt);
+               mpc85xxads_map.virt = 0;
+       }
+}
+
+module_init(mpc85xxads_map_init);
+module_exit(mpc85xxads_map_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Greg Weeks <greg.weeks@timesys.com>");
+MODULE_DESCRIPTION("MTD map and partitions for Motorola MPC85xxADS");
                                                                                                    

--- ppc-mpc8560ads/arch/ppc/platforms/85xx/mpc85xx_ads_common.h-orig
+++ ppc-mpc8560ads/arch/ppc/platforms/85xx/mpc85xx_ads_common.h
                                                                                                    

@@ -47,4 +47,7 @@
                                                                                                    

 #define MPC85XX_PCI1_IO_SIZE   0x01000000
                                                                                                    

+#define MPC85XXADS_FLASH_BASE 0xff000000
+#define MPC85XXADS_FLASH_SIZE 0x01000000
+
 #endif                         /* __MACH_MPC85XX_ADS_H__ */
                                                                                                    

--- ppc-mpc8560ads/drivers/mtd/maps/Kconfig-orig
+++ ppc-mpc8560ads/drivers/mtd/maps/Kconfig
                                                                                                    

@@ -667,5 +667,12 @@
        help
          This enables access to the flash chip on the Sharp SL Series 
of PDAs.
                                                                                                    

+config MTD_MPC85XXADS
+       tristate "Flash device mapped on the MPC85XXADS board"
+       depends on MTD_CFI && MTD_CFI_INTELEXT && MTD_PARTITIONS && 
MPC8560_ADS
+       help
+         This enables access to the Flash on the MPC85xxADS boards.
+         If you have such a board, say 'Y'.
+
 endmenu
                                                                                                    

                                                                                                    

--- ppc-mpc8560ads/drivers/mtd/maps/Makefile-orig
+++ ppc-mpc8560ads/drivers/mtd/maps/Makefile
                                                                                                    

@@ -72,3 +72,4 @@
 obj-$(CONFIG_MTD_WRSBC8260)    += wr_sbc82xx_flash.o
 obj-$(CONFIG_MTD_DMV182)       += dmv182.o
 obj-$(CONFIG_MTD_SHARP_SL)     += sharpsl-flash.o
+obj-$(CONFIG_MTD_MPC85XXADS)   += mpc85xxads.o
