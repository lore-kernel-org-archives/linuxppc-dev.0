Return-Path: <mgreer@mvista.com>
Date: Mon, 10 Dec 2007 17:38:16 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/8] powerpc: mv64x60 - Replace marvell, mv64x60 with marvell,
	mv64360
Message-ID: <20071211003815.GD4995@mag.az.mvista.com>
References: <20071211003108.GA4995@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071211003108.GA4995@mag.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

Compatible property names like "marvell,mv64x60..." are not acceptable
so replace them with name like "marvell,mv64360..."

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 arch/powerpc/boot/dts/prpmc2800.dts            |   34 +++++++--------
 arch/powerpc/platforms/embedded6xx/prpmc2800.c |    4 -
 arch/powerpc/sysdev/mv64x60_dev.c              |    6 +-
 arch/powerpc/sysdev/mv64x60_pci.c              |    6 +-
 arch/powerpc/sysdev/mv64x60_pic.c              |    4 -
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/boot/dts/prpmc2800.dts b/arch/powerpc/boot/dts/prpmc2800.dts
index 1657ee6..a4a3622 100644
--- a/arch/powerpc/boot/dts/prpmc2800.dts
+++ b/arch/powerpc/boot/dts/prpmc2800.dts
@@ -93,7 +93,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "mdio";
-			compatible = "marvell,mv64x60-mdio";
+			compatible = "marvell,mv64360-mdio";
 			PHY0: ethernet-phy@1 {
 				device_type = "ethernet-phy";
 				compatible = "broadcom,bcm5421";
@@ -114,7 +114,7 @@
 			reg = <0x2000 0x2000>;
 			eth0 {
 				device_type = "network";
-				compatible = "marvell,mv64x60-eth";
+				compatible = "marvell,mv64360-eth";
 				block-index = <0>;
 				interrupts = <32>;
 				interrupt-parent = <&PIC>;
@@ -123,7 +123,7 @@
 			};
 			eth1 {
 				device_type = "network";
-				compatible = "marvell,mv64x60-eth";
+				compatible = "marvell,mv64360-eth";
 				block-index = <1>;
 				interrupts = <33>;
 				interrupt-parent = <&PIC>;
@@ -134,7 +134,7 @@
 
 		SDMA0: sdma@4000 {
 			device_type = "dma";
-			compatible = "marvell,mv64x60-sdma";
+			compatible = "marvell,mv64360-sdma";
 			reg = <0x4000 0xc18>;
 			virtual-reg = <0xf1004000>;
 			interrupt-base = <0>;
@@ -144,7 +144,7 @@
 
 		SDMA1: sdma@6000 {
 			device_type = "dma";
-			compatible = "marvell,mv64x60-sdma";
+			compatible = "marvell,mv64360-sdma";
 			reg = <0x6000 0xc18>;
 			virtual-reg = <0xf1006000>;
 			interrupt-base = <0>;
@@ -153,7 +153,7 @@
 		};
 
 		BRG0: brg@b200 {
-			compatible = "marvell,mv64x60-brg";
+			compatible = "marvell,mv64360-brg";
 			reg = <0xb200 0x8>;
 			clock-src = <8>;
 			clock-frequency = <133000000>;
@@ -162,7 +162,7 @@
 		};
 
 		BRG1: brg@b208 {
-			compatible = "marvell,mv64x60-brg";
+			compatible = "marvell,mv64360-brg";
 			reg = <0xb208 0x8>;
 			clock-src = <8>;
 			clock-frequency = <133000000>;
@@ -224,14 +224,14 @@
 		};
 
 		wdt@b410 {			/* watchdog timer */
-			compatible = "marvell,mv64x60-wdt";
+			compatible = "marvell,mv64360-wdt";
 			reg = <0xb410 0x8>;
 			timeout = <10>;		/* wdt timeout in seconds */
 		};
 
 		i2c@c000 {
 			device_type = "i2c";
-			compatible = "marvell,mv64x60-i2c";
+			compatible = "marvell,mv64360-i2c";
 			reg = <0xc000 0x20>;
 			virtual-reg = <0xf100c000>;
 			freq_m = <8>;
@@ -245,18 +245,18 @@
 		PIC: pic {
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
-			compatible = "marvell,mv64x60-pic";
+			compatible = "marvell,mv64360-pic";
 			reg = <0x0000 0x88>;
 			interrupt-controller;
 		};
 
 		mpp@f000 {
-			compatible = "marvell,mv64x60-mpp";
+			compatible = "marvell,mv64360-mpp";
 			reg = <0xf000 0x10>;
 		};
 
 		gpp@f100 {
-			compatible = "marvell,mv64x60-gpp";
+			compatible = "marvell,mv64360-gpp";
 			reg = <0xf100 0x20>;
 		};
 
@@ -265,7 +265,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			device_type = "pci";
-			compatible = "marvell,mv64x60-pci";
+			compatible = "marvell,mv64360-pci";
 			reg = <0x0cf8 0x8>;
 			ranges = <0x01000000 0x0 0x0
 					0x88000000 0x0 0x01000000
@@ -304,28 +304,28 @@
 		};
 
 		cpu-error@0070 {
-			compatible = "marvell,mv64x60-cpu-error";
+			compatible = "marvell,mv64360-cpu-error";
 			reg = <0x0070 0x10 0x0128 0x28>;
 			interrupts = <3>;
 			interrupt-parent = <&PIC>;
 		};
 
 		sram-ctrl@0380 {
-			compatible = "marvell,mv64x60-sram-ctrl";
+			compatible = "marvell,mv64360-sram-ctrl";
 			reg = <0x0380 0x80>;
 			interrupts = <13>;
 			interrupt-parent = <&PIC>;
 		};
 
 		pci-error@1d40 {
-			compatible = "marvell,mv64x60-pci-error";
+			compatible = "marvell,mv64360-pci-error";
 			reg = <0x1d40 0x40 0x0c28 0x4>;
 			interrupts = <12>;
 			interrupt-parent = <&PIC>;
 		};
 
 		mem-ctrl@1400 {
-			compatible = "marvell,mv64x60-mem-ctrl";
+			compatible = "marvell,mv64360-mem-ctrl";
 			reg = <0x1400 0x60>;
 			interrupts = <17>;
 			interrupt-parent = <&PIC>;
diff --git a/arch/powerpc/platforms/embedded6xx/prpmc2800.c b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
index a01e219..1a1baf9 100644
--- a/arch/powerpc/platforms/embedded6xx/prpmc2800.c
+++ b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
@@ -50,13 +50,13 @@ static void __init prpmc2800_setup_arch(void)
 	 * ioremap mpp and gpp registers in case they are later
 	 * needed by prpmc2800_reset_board().
 	 */
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64x60-mpp");
+	np = of_find_compatible_node(NULL, NULL, "marvell,mv64360-mpp");
 	reg = of_get_property(np, "reg", NULL);
 	paddr = of_translate_address(np, reg);
 	of_node_put(np);
 	mv64x60_mpp_reg_base = ioremap(paddr, reg[1]);
 
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64x60-gpp");
+	np = of_find_compatible_node(NULL, NULL, "marvell,mv64360-gpp");
 	reg = of_get_property(np, "reg", NULL);
 	paddr = of_translate_address(np, reg);
 	of_node_put(np);
diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index 304056c..dca205f 100644
--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -457,17 +457,17 @@ static int __init mv64x60_device_setup(void)
 			goto error;
 
 	id = 0;
-	for_each_compatible_node(np, "network", "marvell,mv64x60-eth")
+	for_each_compatible_node(np, "network", "marvell,mv64360-eth")
 		if ((err = mv64x60_eth_device_setup(np, id++)))
 			goto error;
 
 	id = 0;
-	for_each_compatible_node(np, "i2c", "marvell,mv64x60-i2c")
+	for_each_compatible_node(np, "i2c", "marvell,mv64360-i2c")
 		if ((err = mv64x60_i2c_device_setup(np, id++)))
 			goto error;
 
 	/* support up to one watchdog timer */
-	np = of_find_compatible_node(np, NULL, "marvell,mv64x60-wdt");
+	np = of_find_compatible_node(np, NULL, "marvell,mv64360-wdt");
 	if (np) {
 		if ((err = mv64x60_wdt_device_setup(np, id)))
 			goto error;
diff --git a/arch/powerpc/sysdev/mv64x60_pci.c b/arch/powerpc/sysdev/mv64x60_pci.c
index d21ab8f..1456015 100644
--- a/arch/powerpc/sysdev/mv64x60_pci.c
+++ b/arch/powerpc/sysdev/mv64x60_pci.c
@@ -86,14 +86,14 @@ static int __init mv64x60_sysfs_init(void)
 	struct platform_device *pdev;
 	const unsigned int *prop;
 
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64x60");
+	np = of_find_compatible_node(NULL, NULL, "marvell,mv64360");
 	if (!np)
 		return 0;
 
 	prop = of_get_property(np, "hs_reg_valid", NULL);
 	of_node_put(np);
 
-	pdev = platform_device_register_simple("marvell,mv64x60", 0, NULL, 0);
+	pdev = platform_device_register_simple("marvell,mv64360", 0, NULL, 0);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
@@ -166,6 +166,6 @@ void __init mv64x60_pci_init(void)
 {
 	struct device_node *np;
 
-	for_each_compatible_node(np, "pci", "marvell,mv64x60-pci")
+	for_each_compatible_node(np, "pci", "marvell,mv64360-pci")
 		mv64x60_add_bridge(np);
 }
diff --git a/arch/powerpc/sysdev/mv64x60_pic.c b/arch/powerpc/sysdev/mv64x60_pic.c
index 19e6ef2..2aa4ed0 100644
--- a/arch/powerpc/sysdev/mv64x60_pic.c
+++ b/arch/powerpc/sysdev/mv64x60_pic.c
@@ -238,13 +238,13 @@ void __init mv64x60_init_irq(void)
 	const unsigned int *reg;
 	unsigned long flags;
 
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64x60-gpp");
+	np = of_find_compatible_node(NULL, NULL, "marvell,mv64360-gpp");
 	reg = of_get_property(np, "reg", &size);
 	paddr = of_translate_address(np, reg);
 	mv64x60_gpp_reg_base = ioremap(paddr, reg[1]);
 	of_node_put(np);
 
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64x60-pic");
+	np = of_find_compatible_node(NULL, NULL, "marvell,mv64360-pic");
 	reg = of_get_property(np, "reg", &size);
 	paddr = of_translate_address(np, reg);
 	mv64x60_irq_reg_base = ioremap(paddr, reg[1]);
