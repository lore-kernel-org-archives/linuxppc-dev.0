Return-Path: <sshtylyov@ru.mvista.com>
Message-ID: <44DCA2BF.1030002@ru.mvista.com>
Date: Fri, 11 Aug 2006 19:31:11 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org,
	linux-mtd@lists.infradead.org
Subject: [RFC] Adding MTD to device tree
References: <20060614213643.137680b8@vitb.ru.mvista.com>	<44A83AE1.4020707@ru.mvista.com>	<20060705153118.6ffbe97d@localhost.localdomain>	<44ABC0D1.1020407@ru.mvista.com>	<20060705191007.54e8b4b6@localhost.localdomain>	<44B00C03.5010409@ru.mvista.com>
	<20060709001435.7a94294e@localhost.localdomain>
In-Reply-To: <20060709001435.7a94294e@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------080005010505060805080604"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080005010505060805080604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    Here's the proposal for the representation of the MTD (optionally having
some partitions) in the device tree, along with the sample code that parses 
the MTD node and hands the necessary information to the 'physmap' driver using 
the 'platform_device' method.  The representation was fitted to the current 
Linux MTD driver model, so it doesn't bear any information on the chip models 
or the flash interflace, letting the MTD probing code figure all that out 
(this part might need some changes I suspect).

    To me, however, this method seems too limiting: we have to look thru the
device tree for each particular kind MTDs (assuming that there could be
different ones that 'physmap' can't drive) and register each of them its own
way.  If we teach 'physmap' to register on the 'of_platform_device' bus, we
may look up the device tree for *any* MTD nodes somewhere in arch/powerpc/ 
tree, register them all, and leave it up to the particular driver to claim 
them and get the information the driver needs from their node's properties. 
That would require introducing another MTD partition pasrsing module (so the 
code that parses the partitions in this patch will move into the separate 
module under drivers/mtd/).

    Opinions on what way should be taken and what needs to be added from both
PowerPC and MTD communities are very welcome.

WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------080005010505060805080604
Content-Type: text/plain;
 name="OF-physmap-device.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="OF-physmap-device.patch"

Index: powerpc/Documentation/powerpc/booting-without-of.txt
===================================================================
--- powerpc.orig/Documentation/powerpc/booting-without-of.txt
+++ powerpc/Documentation/powerpc/booting-without-of.txt
@@ -6,6 +6,8 @@
     IBM Corp.
 (c) 2005 Becky Bruce <becky.bruce at freescale.com>,
     Freescale Semiconductor, FSL SOC and 32-bit additions
+(c) 2006 MontaVista Software, Inc.
+    MTD node definition
 
    May 18, 2005: Rev 0.1 - Initial draft, no chapter III yet.
 
@@ -1442,6 +1444,42 @@ platforms are moved over to use the flat
        };
 
 
+   h) MTD nodes
+
+   Memory Technology Devices are flash, ROM, and similar chips, often used
+   for solid state file systems on embedded devices.
+
+   Required properties:
+
+    - device_type : has to be "mtd"
+    - compatible : Should be the name of the MTD driver. Currently, this is
+      most likely to be "physmap".
+    - reg : Offset and length of the register set for the device.
+
+   Recommended properties :
+
+    - bank-width : Width of the flash data bus in bytes. Must be specified
+      for the NOR flashes.
+    - partitions : Several pairs of 32-bit values where the first value is
+      partition's offset from the start of the MTD device and the second
+      one is partition size in bytes with LSB used to signify a read only
+      partititon (so, the parition size should always be an even number).
+    - partition-names : The list of concatenated zero terminated strings
+      representing the partition names.
+
+  Example:
+
+	flash@ff000000 {
+		device_type = "mtd";
+		compatible = "physmap";
+		reg = <ff000000 01000000>;
+		bank-width = <4>;
+		partitions = <00000000 00f80000
+			      00f80000 00080001>;
+		partition-names = "fs\0firmware";
+	};
+
+
    More devices will be defined as this spec matures.
 
 
Index: powerpc/arch/powerpc/sysdev/Makefile
===================================================================
--- powerpc.orig/arch/powerpc/sysdev/Makefile
+++ powerpc/arch/powerpc/sysdev/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PPC_83xx)		+= ipic.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_PPC_TODC)		+= todc.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
+obj-$(CONFIG_MTD)		+= flash.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
Index: powerpc/arch/powerpc/sysdev/flash.c
===================================================================
--- /dev/null
+++ powerpc/arch/powerpc/sysdev/flash.c
@@ -0,0 +1,104 @@
+/*
+ * arch/powerpc/sysdev/flash.c
+ *
+ * Flash memory registration
+ *
+ * (C) 2006 MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/physmap.h>
+#include <linux/mtd/partitions.h>
+#include <linux/platform_device.h>
+#include <asm/prom.h>
+
+static void parse_flash_partitions(struct device_node *node,
+				   struct physmap_flash_data *physmap_data)
+{
+#ifdef CONFIG_MTD_PARTITIONS
+	int i, plen, num_parts;
+	const  u32  *part;
+	const  char *name;
+
+	part = get_property(node, "partitions", &plen);
+	if (part == NULL)
+		return;
+
+	physmap_data->nr_parts = num_parts = plen / (2 * sizeof(u32));
+	physmap_data->parts = kcalloc(num_parts, sizeof(struct mtd_partition),
+				      GFP_KERNEL);
+	if (physmap_data->parts == NULL) {
+		printk(KERN_ERR "Can't allocate the flash partition data!\n");
+		return;
+	}
+
+	name = get_property(node, "partition-names", &plen);
+
+	for (i = 0; i < num_parts; i++) {
+		physmap_data->parts[i].offset = *part++;
+		physmap_data->parts[i].size   = *part & ~1;
+		if (*part++ & 1) /* bit 0 set signifies read only partition */
+			physmap_data->parts[i].mask_flags = MTD_WRITEABLE;
+
+		if (name != NULL && plen > 0) {
+			int len = strlen(name) + 1;
+
+			physmap_data->parts[i].name = (char *)name;
+			plen -= len;
+			name += len;
+		} else
+			physmap_data->parts[i].name = "unnamed";
+	}
+#endif
+}
+
+static int __init powerpc_flash_init(void)
+{
+	struct device_node *node = NULL;
+	int num = 0;
+
+	while ((node = of_find_compatible_node(node, "mtd", "physmap")) != NULL) {
+		struct platform_device *physmap_flash;
+		struct physmap_flash_data physmap_data;
+		struct resource res;
+		const  u32 *width;
+
+		if (of_address_to_resource(node, 0, &res)) {
+			printk(KERN_ERR "Can't get the flash mapping!\n");
+			continue;
+		}
+
+		width = get_property(node, "bank-width", NULL);
+		if (width == NULL) {
+			printk(KERN_ERR "Can't get the flash bank width!\n");
+			continue;
+		}
+
+		physmap_flash = platform_device_register_simple("physmap-flash",
+								num, &res, 1);
+		if (IS_ERR(physmap_flash)) {
+			printk(KERN_ERR "Can't register the \"physmap-flash\" "
+			       "platform device!\n");
+			continue;
+		}
+
+		memset(&physmap_data, 0, sizeof(physmap_data));
+		physmap_data.width = *width;
+
+		parse_flash_partitions(node, &physmap_data);
+
+		if (platform_device_add_data(physmap_flash, &physmap_data,
+					     sizeof(struct physmap_flash_data))) {
+			printk(KERN_ERR "Can't pass data to physmap driver!\n");
+			platform_device_unregister(physmap_flash);
+			continue;
+		}
+		++num;
+	}
+	return 0;
+}
+
+arch_initcall(powerpc_flash_init);


--------------080005010505060805080604--
