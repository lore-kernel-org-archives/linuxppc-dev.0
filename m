Return-Path: <vwool@ru.mvista.com>
Date: Mon, 20 Nov 2006 16:32:39 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
To: galak@kernel.crashing.org
Subject: [PATCH] powerpc: Add of_platform support for ROM devices
Message-Id: <20061120163239.f9a38fc1.vwool@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello folks,

inlined below is the patch which adds support for flash device descriptions to the OF device tree. It's inspired by and partially borrowed from Sergei's patch which can be found at http://patchwork.ozlabs.org/linuxppc/patch?id=6526 but arranges things in a different way.
This patch is a respin of the patch which can be found at http://ozlabs.org/pipermail/linuxppc-embedded/2006-November/025013.html with comments from Sergei and Josh taken into account and with "compatible" property changed to "direct-mapped" from "physmap" not to be Linux-biased, and some additional cleanups in booting-without-of.txt.

 Documentation/powerpc/booting-without-of.txt |   39 +++++++++++++++++++++++++++
 arch/powerpc/sysdev/Makefile                 |    1 
 arch/powerpc/sysdev/rom.c                    |   31 +++++++++++++++++++++
 3 files changed, 71 insertions(+)
 
Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Index: powerpc/Documentation/powerpc/booting-without-of.txt
===================================================================
--- powerpc.orig/Documentation/powerpc/booting-without-of.txt
+++ powerpc/Documentation/powerpc/booting-without-of.txt
@@ -6,6 +6,8 @@
     IBM Corp.
 (c) 2005 Becky Bruce <becky.bruce at freescale.com>,
     Freescale Semiconductor, FSL SOC and 32-bit additions
+(c) 2006 MontaVista Software, Inc.
+    Flash chip node definition
 
    May 18, 2005: Rev 0.1 - Initial draft, no chapter III yet.
 
@@ -1693,6 +1695,43 @@ platforms are moved over to use the flat
 		};
 	};
 
+    g) Flash chip nodes
+
+    Flash chips (Memory Technology Devices) are often used for solid state
+    file systems on embedded devices.
+
+    Required properties:
+
+     - device_type : has to be "rom"
+     - compatible : Should specify what this ROM device is compatible with
+       (i.e. "onenand"). Currently, this is most likely to be "direct-mapped"
+       (which corresponds to the MTD physmap mapping driver).
+     - regs : Offset and length of the register set (or memory mapping) for
+       the device.
+
+    Recommended properties :
+
+     - bank-width : Width of the flash data bus in bytes. Required
+       for the NOR flashes (compatible == "direct-mapped" and others) ONLY.
+     - partitions : Several pairs of 32-bit values where the first value is
+       partition's offset from the start of the device and the second one is
+       partition size in bytes with LSB used to signify a read only
+       partititon (so, the parition size should always be an even number).
+     - partition-names : The list of concatenated zero terminated strings
+       representing the partition names.
+
+   Example:
+
+ 	flash@ff000000 {
+ 		device_type = "rom";
+ 		compatible = "direct-mapped";
+ 		regs = <ff000000 01000000>;
+ 		bank-width = <4>;
+ 		partitions = <00000000 00f80000
+ 			      00f80000 00080001>;
+ 		partition-names = "fs\0firmware";
+ 	};
+
    More devices will be defined as this spec matures.
 
 
Index: powerpc/arch/powerpc/sysdev/Makefile
===================================================================
--- powerpc.orig/arch/powerpc/sysdev/Makefile
+++ powerpc/arch/powerpc/sysdev/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 obj-$(CONFIG_PPC_MPC52xx)	+= mpc52xx_pic.o
+obj-$(CONFIG_MTD)		+= rom.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
Index: powerpc/arch/powerpc/sysdev/rom.c
===================================================================
--- /dev/null
+++ powerpc/arch/powerpc/sysdev/rom.c
@@ -0,0 +1,31 @@
+/*
+ * ROM device registration
+ *
+ * (C) 2006 MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/kernel.h>
+#include <asm/of_device.h>
+
+static int __init powerpc_flash_init(void)
+{
+	struct device_node *node = NULL;
+
+	/*
+	 * Register all the devices which type is "rom"
+	 */
+	while ((node = of_find_node_by_type(node, "rom")) != NULL) {
+		if (node->name == NULL) {
+			printk(KERN_WARNING "powerpc_flash_init: found 'rom' "
+				"device, but with no name, skipping...\n");
+			continue;
+		}
+		of_platform_device_create(node, node->name, NULL);
+	}
+	return 0;
+}
+
+arch_initcall(powerpc_flash_init);
