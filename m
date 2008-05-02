Return-Path: <jeremy.mcnicoll@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 9F2CCDDE16
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 10:10:50 +1000 (EST)
From: Jeremy McNicoll <jeremy.mcnicoll@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] SBC8548: Add flash support and HW Rev reporting
Date: Fri,  2 May 2008 16:20:01 -0400
Message-Id: <1209759601-5659-1-git-send-email-jeremy.mcnicoll@windriver.com>
Cc: Jeremy McNicoll <jeremy.mcnicoll@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following adds local bus, flash and MTD partition nodes for
sbc8548. As well, a compatible field for the soc node, so that
of_platform_bus_probe() will pick it up.

Something that is provided through this newly added epld node
is the Hardware Revision is now being reported at bootup.

Signed-off-by: Jeremy McNicoll <jeremy.mcnicoll@windriver.com>
---
 arch/powerpc/boot/dts/sbc8548.dts     |   94 +++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/sbc8548.c |   25 +++++++++
 2 files changed, 119 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index b86e65d..dd9a061 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -52,6 +52,99 @@
 		reg = <0x00000000 0x10000000>;
 	};
 
+	localbus@e0000000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		reg = <0xe0000000 0x5000>;
+		interrupt-parent = <&mpic>;
+
+		ranges = <0x0 0x0 0xff800000 0x00800000		/*8MB Flash*/
+			  0x3 0x0 0xf0000000 0x04000000		/*64MB SDRAM*/
+			  0x4 0x0 0xf4000000 0x04000000 	/*64MB SDRAM*/
+			  0x5 0x0 0xf8000000 0x00b10000		/* EPLD */
+			  0x6 0x0 0xfb800000 0x04000000>;	/*64MB Flash*/
+
+
+		flash@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x800000>;
+			bank-width = <1>;
+			device-width = <1>;
+			partition@0x0 {
+				label = "space";
+				reg = <0x00000000 0x00100000>;
+			};
+			partition@0x100000 {
+				label = "bootloader";
+				reg = <0x00100000 0x00700000>;
+				read-only;
+			};
+		};
+
+		epld@5,0 {
+			compatible = "wrs,epld-localbus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			reg = <0x5 0x0 0x00b10000>;
+			ranges = <
+				0x0 0x0 0x5 0x000000 0x1fff	/* LED */
+				0x1 0x0 0x5 0x100000 0x1fff	/* Switches */
+				0x3 0x0 0x5 0x300000 0x1fff	/* HW Rev. */
+				0xb 0x0	0x5 0xb00000 0x1fff	/* EEPROM */
+			>;
+
+			led@0,0 {
+				compatible = "led";
+				reg = <0x0 0x0 0x1fff>;
+			};
+			
+			switches@1,0 {
+				compatible = "switches";
+				reg = <0x1 0x0 0x1fff>;
+			};
+
+			hw-rev@3,0 {
+				compatible = "hw-rev";
+				reg = <0x3 0x0 0x1fff>;
+			};
+
+			eeprom@b,0 {
+				compatible = "eeprom";
+				reg = <0xb 0 0x1fff>;
+			};
+
+		};
+
+		alt-flash@6,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x6 0x0 0x04000000>;
+			compatible = "cfi-flash";
+			bank-width = <4>; 
+			device-width = <1>;
+			partition@0x0 {
+				label = "bootloader"; 
+				reg = <0x00000000 0x00100000>;
+				read-only;
+			};
+			partition@0x00100000 {
+				label = "file-system";
+				reg = <0x00100000 0x01f00000>;
+			};
+			partition@0x02000000 {
+				label = "boot-config";
+				reg = <0x02000000 0x00100000>;
+			};
+			partition@0x02100000 {
+				label = "space";
+				reg = <0x02100000 0x01f00000>;
+			};
+                };
+        };
+
 	soc8548@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -59,6 +152,7 @@
 		ranges = <0x00000000 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00001000>;	// CCSRBAR
 		bus-frequency = <0>;
+		compatible = "simple-bus";
 
 		memory-controller@2000 {
 			compatible = "fsl,8548-memory-controller";
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index 488facb..d148d45 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -130,6 +130,7 @@ static void sbc8548_show_cpuinfo(struct seq_file *m)
 static struct of_device_id __initdata of_bus_ids[] = {
 	{ .name = "soc", },
 	{ .type = "soc", },
+	{ .compatible = "simple-bus", },
 	{},
 };
 
@@ -141,6 +142,30 @@ static int __init declare_of_platform_devices(void)
 }
 machine_device_initcall(sbc8548, declare_of_platform_devices);
 
+/* Extract the HW Rev from the EPLD on the board */
+static int __init sbc8548_hw_rev(void)
+{
+	struct device_node *np;
+	struct resource res;
+	unsigned int *rev;
+
+	np = of_find_compatible_node(NULL, NULL, "hw-rev");
+	if (np == NULL) {
+		printk("No HW-REV found in DTB.\n");
+		return -ENODEV;
+	}
+
+	of_address_to_resource(np, 0, &res);
+	of_node_put(np);
+
+	rev = ioremap(res.start,sizeof(unsigned int));
+	printk("Detected HW Rev. 0x%x\n", ((*rev) >> 28));
+	iounmap(rev);
+
+	return 0;
+}
+arch_initcall(sbc8548_hw_rev);
+
 /*
  * Called very early, device-tree isn't unflattened
  */
-- 
1.5.3.7
