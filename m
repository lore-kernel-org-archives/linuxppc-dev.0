Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 50D90DE595
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jan 2009 15:20:14 +1100 (EST)
Date: Fri, 9 Jan 2009 23:20:11 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Warp patches for the new ndfc driver
Message-ID: <20090109232011.19f6e780@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Woo hoo! The ndfc driver finally got in the kernel! These patches update
the warp to use the new driver.

Cheers,
   Sean

These patches allow the warp to use the new of platform ndfc driver.
- warp.dts changed to work with ndfc
- warp-nand.c no longer needed
- removed obsolete rev A support from cuboot-warp.c

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/boot/cuboot-warp.c b/arch/powerpc/boot/cuboot-warp.c
index 2178021..806df69 100644
--- a/arch/powerpc/boot/cuboot-warp.c
+++ b/arch/powerpc/boot/cuboot-warp.c
@@ -18,57 +18,14 @@
 
 static bd_t bd;
 
-static void warp_fixup_one_nor(u32 from, u32 to)
-{
-	void *devp;
-	char name[50];
-	u32 v[2];
-
-	sprintf(name, "/plb/opb/ebc/nor_flash@0,0/partition@%x", from);
-
-	devp = finddevice(name);
-	if (!devp)
-		return;
-
-	if (getprop(devp, "reg", v, sizeof(v)) == sizeof(v)) {
-		v[0] = to;
-		setprop(devp, "reg", v, sizeof(v));
-
-		printf("NOR 64M fixup %x -> %x\r\n", from, to);
-	}
-}
-
-
 static void warp_fixups(void)
 {
 	ibm440ep_fixup_clocks(66000000, 11059200, 50000000);
 	ibm4xx_sdram_fixup_memsize();
 	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
 	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
-
-	/* Fixup for 64M flash on Rev A boards. */
-	if (bd.bi_flashsize == 0x4000000) {
-		void *devp;
-		u32 v[3];
-
-		devp = finddevice("/plb/opb/ebc/nor_flash@0,0");
-		if (!devp)
-			return;
-
-		/* Fixup the size */
-		if (getprop(devp, "reg", v, sizeof(v)) == sizeof(v)) {
-			v[2] = bd.bi_flashsize;
-			setprop(devp, "reg", v, sizeof(v));
-		}
-
-		/* Fixup parition offsets */
-		warp_fixup_one_nor(0x300000, 0x3f00000);
-		warp_fixup_one_nor(0x340000, 0x3f40000);
-		warp_fixup_one_nor(0x380000, 0x3f80000);
-	}
 }
 
-
 void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 		   unsigned long r6, unsigned long r7)
 {
diff --git a/arch/powerpc/boot/dts/warp.dts b/arch/powerpc/boot/dts/warp.dts
index f4e4ba6..7e183ff 100644
--- a/arch/powerpc/boot/dts/warp.dts
+++ b/arch/powerpc/boot/dts/warp.dts
@@ -149,12 +149,17 @@
 					reg = <0x00000002 0x00004000 0x00000A00>;
 				};
 
-				nor_flash@0,0 {
+				nor@0,0 {
 					compatible = "amd,s29gl032a", "cfi-flash";
 					bank-width = <2>;
 					reg = <0x00000000 0x00000000 0x00400000>;
 					#address-cells = <1>;
 					#size-cells = <1>;
+
+					partition@0 {
+						label = "splash";
+						reg = <0x00000000 0x00020000>;
+					};
 					partition@300000 {
 						label = "fpga";
 						reg = <0x0300000 0x00040000>;
@@ -168,6 +173,41 @@
 						reg = <0x0380000 0x00080000>;
 					};
 				};
+
+				ndfc@1,0 {
+					compatible = "ibm,ndfc";
+					reg = <0x00000001 0x00000000 0x00002000>;
+					ccr = <0x00001000>;
+					bank-settings = <0x80002222>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					nand {
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						partition@0 {
+							label = "kernel";
+							reg = <0x00000000 0x00200000>;
+						};
+						partition@200000 {
+							label = "root";
+							reg = <0x00200000 0x03E00000>;
+						};
+						partition@40000000 {
+							label = "persistent";
+							reg = <0x04000000 0x04000000>;
+						};
+						partition@80000000 {
+							label = "persistent1";
+							reg = <0x08000000 0x04000000>;
+						};
+						partition@C0000000 {
+							label = "persistent2";
+							reg = <0x0C000000 0x04000000>;
+						};
+					};
+				};
 			};
 
 			UART0: serial@ef600300 {
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 6981331..01f51da 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -3,5 +3,4 @@ obj-$(CONFIG_PPC44x_SIMPLE) += ppc44x_simple.o
 obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_SAM440EP) 	+= sam440ep.o
 obj-$(CONFIG_WARP)	+= warp.o
-obj-$(CONFIG_WARP)	+= warp-nand.o
 obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
diff --git a/arch/powerpc/platforms/44x/warp-nand.c b/arch/powerpc/platforms/44x/warp-nand.c
deleted file mode 100644
index 89ecd76..0000000
--- a/arch/powerpc/platforms/44x/warp-nand.c
+++ /dev/null
@@ -1,135 +0,0 @@
-/*
- * PIKA Warp(tm) NAND flash specific routines
- *
- * Copyright (c) 2008 PIKA Technologies
- *   Sean MacLennan <smaclennan@pikatech.com>
- */
-
-#include <linux/platform_device.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/nand.h>
-#include <linux/mtd/ndfc.h>
-#include <linux/of.h>
-#include <asm/machdep.h>
-
-
-#ifdef CONFIG_MTD_NAND_NDFC
-
-#define CS_NAND_0	1	/* use chip select 1 for NAND device 0 */
-
-#define WARP_NAND_FLASH_REG_ADDR	0xD0000000UL
-#define WARP_NAND_FLASH_REG_SIZE	0x2000
-
-static struct resource warp_ndfc = {
-	.start = WARP_NAND_FLASH_REG_ADDR,
-	.end   = WARP_NAND_FLASH_REG_ADDR + WARP_NAND_FLASH_REG_SIZE - 1,
-	.flags = IORESOURCE_MEM,
-};
-
-static struct mtd_partition nand_parts[] = {
-	{
-		.name   = "kernel",
-		.offset = 0,
-		.size   = 0x0200000
-	},
-	{
-		.name   = "root",
-		.offset = 0x0200000,
-		.size   = 0x3E00000
-	},
-	{
-		.name   = "persistent",
-		.offset = 0x4000000,
-		.size   = 0x4000000
-	},
-	{
-		.name   = "persistent1",
-		.offset = 0x8000000,
-		.size   = 0x4000000
-	},
-	{
-		.name   = "persistent2",
-		.offset = 0xC000000,
-		.size   = 0x4000000
-	}
-};
-
-struct ndfc_controller_settings warp_ndfc_settings = {
-	.ccr_settings = (NDFC_CCR_BS(CS_NAND_0) | NDFC_CCR_ARAC1),
-	.ndfc_erpn = 0,
-};
-
-static struct ndfc_chip_settings warp_chip0_settings = {
-	.bank_settings = 0x80002222,
-};
-
-struct platform_nand_ctrl warp_nand_ctrl = {
-	.priv = &warp_ndfc_settings,
-};
-
-static struct platform_device warp_ndfc_device = {
-	.name = "ndfc-nand",
-	.id = 0,
-	.dev = {
-		.platform_data = &warp_nand_ctrl,
-	},
-	.num_resources = 1,
-	.resource = &warp_ndfc,
-};
-
-/* Do NOT set the ecclayout: let it default so it is correct for both
- * 64M and 256M flash chips.
- */
-static struct platform_nand_chip warp_nand_chip0 = {
-	.nr_chips = 1,
-	.chip_offset = CS_NAND_0,
-	.nr_partitions = ARRAY_SIZE(nand_parts),
-	.partitions = nand_parts,
-	.chip_delay = 20,
-	.priv = &warp_chip0_settings,
-};
-
-static struct platform_device warp_nand_device = {
-	.name = "ndfc-chip",
-	.id = 0,
-	.num_resources = 0,
-	.dev = {
-		.platform_data = &warp_nand_chip0,
-		.parent = &warp_ndfc_device.dev,
-	}
-};
-
-static int warp_setup_nand_flash(void)
-{
-	struct device_node *np;
-
-	/* Try to detect a rev A based on NOR size. */
-	np = of_find_compatible_node(NULL, NULL, "cfi-flash");
-	if (np) {
-		struct property *pp;
-
-		pp = of_find_property(np, "reg", NULL);
-		if (pp && (pp->length == 12)) {
-			u32 *v = pp->value;
-			if (v[2] == 0x4000000) {
-				/* Rev A = 64M NAND */
-				warp_nand_chip0.nr_partitions = 3;
-
-				nand_parts[1].size   = 0x3000000;
-				nand_parts[2].offset = 0x3200000;
-				nand_parts[2].size   = 0x0e00000;
-			}
-		}
-		of_node_put(np);
-	}
-
-	platform_device_register(&warp_ndfc_device);
-	platform_device_register(&warp_nand_device);
-
-	return 0;
-}
-machine_device_initcall(warp, warp_setup_nand_flash);
-
-#endif
