Return-Path: <dgibson@ozlabs.org>
Date: Fri, 4 May 2007 16:38:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: powerpc: Abolish powerpc_flash_init(), fix physmap_of flash driver
Message-ID: <20070504063803.GA19714@localhost.localdomain>
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

powerpc_flash_init() implements a broken way of probing for flash
devices supported by the physmap_of driver.  It finds all nodes in the
device tree with device_type=="rom" and instantiates of_platform
devices for them.  This is fundamentally incompatible with the normal
and correct way of probing for of_platform_bus_probe().  Platforms
which relied on powerpc_flash_init()s behaviour (none are in-tree)
will have to update their platform probing code to correctly probe
busses containing flash devices.

In addition, this patch fixes a small bug in the physmap_of driver
itself (a missing printk parameter).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/drivers/mtd/maps/physmap_of.c
===================================================================
--- working-2.6.orig/drivers/mtd/maps/physmap_of.c	2007-04-30 10:57:47.000000000 +1000
+++ working-2.6/drivers/mtd/maps/physmap_of.c	2007-05-02 12:36:37.000000000 +1000
@@ -186,7 +186,7 @@ static int __devinit of_physmap_probe(st
 	else {
  		if (strcmp(of_probe, "ROM"))
 			dev_dbg(&dev->dev, "map_probe: don't know probe type "
-			"'%s', mapping as rom\n");
+			"'%s', mapping as rom\n", of_probe);
 		info->mtd = do_map_probe("mtd_rom", &info->map);
 	}
 	if (info->mtd == NULL) {
Index: working-2.6/arch/powerpc/sysdev/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/sysdev/Makefile	2007-04-26 13:57:24.000000000 +1000
+++ working-2.6/arch/powerpc/sysdev/Makefile	2007-05-02 13:22:02.000000000 +1000
@@ -26,7 +26,6 @@ endif
 
 # Temporary hack until we have migrated to asm-powerpc
 ifeq ($(ARCH),powerpc)
-obj-$(CONFIG_MTD)		+= rom.o
 obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
 obj-$(CONFIG_8xx)		+= mpc8xx_pic.o commproc.o
 obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
Index: working-2.6/arch/powerpc/sysdev/rom.c
===================================================================
--- working-2.6.orig/arch/powerpc/sysdev/rom.c	2007-05-02 13:22:05.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,32 +0,0 @@
-/*
- * ROM device registration
- *
- * (C) 2006 MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#include <linux/kernel.h>
-#include <asm/of_device.h>
-#include <asm/of_platform.h>
-
-static int __init powerpc_flash_init(void)
-{
-	struct device_node *node = NULL;
-
-	/*
-	 * Register all the devices which type is "rom"
-	 */
-	while ((node = of_find_node_by_type(node, "rom")) != NULL) {
-		if (node->name == NULL) {
-			printk(KERN_WARNING "powerpc_flash_init: found 'rom' "
-				"device, but with no name, skipping...\n");
-			continue;
-		}
-		of_platform_device_create(node, node->name, NULL);
-	}
-	return 0;
-}
-
-arch_initcall(powerpc_flash_init);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
