Return-Path: <matteo.facchinetti@sirius-es.it>
Received: from ns1.gatteins.it (ns1.gatteins.it [193.58.239.94])
 by ozlabs.org (Postfix) with ESMTP id B4CEC2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 00:57:40 +1100 (EST)
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 3/3] powerpc/mpc512x: add platform code for MPC5125.
Date: Thu,  4 Apr 2013 15:57:30 +0200
Message-Id: <1365083850-25468-1-git-send-email-matteo.facchinetti@sirius-es.it>
Cc: agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tested on MPC5125 Tower evaluation board with
mpc512x_defconfig compile configuration.

In detail, supports for:
- PSC / UART
- RTC
- ETH
- DIU
- I2C

Signed-off-by: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
---
v2:
 * change mpc512x_select_psc_compat() implementation
      and fix it using const char* return
 * drop device_type and port-number properties in mpc5125twr.dts
 * add "fsl,mpc5121" and "fsl,mpc5125" in mpc512x dts files
 * change reset module name in mpc5125twr.dts (different from mpc5121)
---
v3:
 * fix i2c compatible in mpc5125twr.dts changing
      from "fsl-i2c" to "fsl,mpc5121-i2c", "fsl-i2c"
---
 arch/powerpc/boot/dts/mpc5121ads.dts          |    2 +-
 arch/powerpc/boot/dts/mpc5125twr.dts          |  233 +++++++++++++++++++++++++
 arch/powerpc/boot/dts/pdm360ng.dts            |    2 +-
 arch/powerpc/platforms/512x/clock.c           |    9 +-
 arch/powerpc/platforms/512x/mpc512x.h         |    1 +
 arch/powerpc/platforms/512x/mpc512x_generic.c |    1 +
 arch/powerpc/platforms/512x/mpc512x_shared.c  |   20 ++-
 7 files changed, 264 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc5125twr.dts

diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
index f269b13..7d3cb79 100644
--- a/arch/powerpc/boot/dts/mpc5121ads.dts
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -13,7 +13,7 @@
 
 / {
 	model = "mpc5121ads";
-	compatible = "fsl,mpc5121ads";
+	compatible = "fsl,mpc5121ads", "fsl,mpc5121";
 
 	nfc@40000000 {
 		/*
diff --git a/arch/powerpc/boot/dts/mpc5125twr.dts b/arch/powerpc/boot/dts/mpc5125twr.dts
new file mode 100644
index 0000000..4177b62
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc5125twr.dts
@@ -0,0 +1,233 @@
+/*
+ * STx/Freescale ADS5125 MPC5125 silicon
+ *
+ * Copyright (C) 2009 Freescale Semiconductor Inc. All rights reserved.
+ *
+ * Reworked by Matteo Facchinetti (engineering@sirius-es.it)
+ * Copyright (C) 2013 Sirius Electronic Systems
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "mpc5125twr"; // In BSP "mpc5125ads"
+	compatible = "fsl,mpc5125ads", "fsl,mpc5125";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&ipic>;
+
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		ethernet0 = &eth0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,5125@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <0x20>;	// 32 bytes
+			i-cache-line-size = <0x20>;	// 32 bytes
+			d-cache-size = <0x8000>;	// L1, 32K
+			i-cache-size = <0x8000>;	// L1, 32K
+			timebase-frequency = <49500000>;// 49.5 MHz (csb/4)
+			bus-frequency = <198000000>;	// 198 MHz csb bus
+			clock-frequency = <396000000>;	// 396 MHz ppc core
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;	// 256MB at 0
+	};
+
+	sram@30000000 {
+		compatible = "fsl,mpc5121-sram";
+		reg = <0x30000000 0x08000>;		// 32K at 0x30000000
+	};
+
+	soc@80000000 {
+		compatible = "fsl,mpc5121-immr";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		ranges = <0x0 0x80000000 0x400000>;
+		reg = <0x80000000 0x400000>;
+		bus-frequency = <66000000>;	// 66 MHz ips bus
+
+		// IPIC
+		// interrupts cell = <intr #, sense>
+		// sense values match linux IORESOURCE_IRQ_* defines:
+		// sense == 8: Level, low assertion
+		// sense == 2: Edge, high-to-low change
+		//
+		ipic: interrupt-controller@c00 {
+			compatible = "fsl,mpc5121-ipic", "fsl,ipic";
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0xc00 0x100>;
+		};
+
+		rtc@a00 {	// Real time clock
+			compatible = "fsl,mpc5121-rtc";
+			reg = <0xa00 0x100>;
+			interrupts = <79 0x8 80 0x8>;
+		};
+
+		reset@e00 {	// Reset module
+			compatible = "fsl,mpc5125-reset";
+			reg = <0xe00 0x100>;
+		};
+
+		clock@f00 {	// Clock control
+			compatible = "fsl,mpc5121-clock";
+			reg = <0xf00 0x100>;
+		};
+
+		pmc@1000{  // Power Management Controller
+			compatible = "fsl,mpc5121-pmc";
+			reg = <0x1000 0x100>;
+			interrupts = <83 0x2>;
+		};
+
+		gpio0: gpio@1100 {
+			compatible = "fsl,mpc5125-gpio";
+			reg = <0x1100 0x080>;
+			interrupts = <78 0x8>;
+		};
+
+		gpio1: gpio@1180 {
+			compatible = "fsl,mpc5125-gpio";
+			reg = <0x1180 0x080>;
+			interrupts = <86 0x8>;
+		};
+
+		can@1300 { // CAN rev.2
+			compatible = "fsl,mpc5121-mscan";
+			interrupts = <12 0x8>;
+			reg = <0x1300 0x80>;
+		};
+
+		can@1380 {
+			compatible = "fsl,mpc5121-mscan";
+			interrupts = <13 0x8>;
+			reg = <0x1380 0x80>;
+		};
+
+		sdhc@1500 {
+			compatible = "fsl,mpc5121-sdhc";
+			interrupts = <8 0x8>;
+			reg = <0x1500 0x100>;
+		};
+
+		i2c@1700 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
+			reg = <0x1700 0x20>;
+			interrupts = <0x9 0x8>;
+		};
+
+		i2c@1720 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
+			reg = <0x1720 0x20>;
+			interrupts = <0xa 0x8>;
+		};
+
+		i2c@1740 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
+			reg = <0x1740 0x20>;
+			interrupts = <0xb 0x8>;
+		};
+
+		i2ccontrol@1760 {
+			compatible = "fsl,mpc5121-i2c-ctrl";
+			reg = <0x1760 0x8>;
+		};
+
+		diu@2100 {
+			compatible = "fsl,mpc5121-diu";
+			reg = <0x2100 0x100>;
+			interrupts = <64 0x8>;
+		};
+
+		mdio@2800 {
+			compatible = "fsl,mpc5121-fec-mdio";
+			reg = <0x2800 0x800>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			phy0: ethernet-phy@0 {
+				reg = <1>;
+			};
+		};
+
+		eth0: ethernet@2800 {
+			compatible = "fsl,mpc5125-fec";
+			reg = <0x2800 0x800>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <4 0x8>;
+			phy-handle = < &phy0 >;
+			phy-connection-type = "rmii";
+		};
+
+		// IO control
+		ioctl@a000 {
+			compatible = "fsl,mpc5125-ioctl";
+			reg = <0xA000 0x1000>;
+		};
+
+		usb@3000 {
+			compatible = "fsl,mpc5121-usb2-dr";
+			reg = <0x3000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <43 0x8>;
+			dr_mode = "host";
+			phy_type = "ulpi";
+		};
+
+		// 5125 PSCs are not 52xx or 5121 PSC compatible
+		// PSC1 uart0 aka ttyPSC0
+		serial@11100 {
+			compatible = "fsl,mpc5125-psc-uart", "fsl,mpc5125-psc";
+			reg = <0x11100 0x100>;
+			interrupts = <40 0x8>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		// PSC9 uart1 aka ttyPSC1
+		serial@11900 {
+			compatible = "fsl,mpc5125-psc-uart", "fsl,mpc5125-psc";
+			reg = <0x11900 0x100>;
+			interrupts = <40 0x8>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		pscfifo@11f00 {
+			compatible = "fsl,mpc5121-psc-fifo";
+			reg = <0x11f00 0x100>;
+			interrupts = <40 0x8>;
+		};
+
+		dma@14000 {
+			compatible = "fsl,mpc5121-dma"; // BSP name: "mpc512x-dma2"
+			reg = <0x14000 0x1800>;
+			interrupts = <65 0x8>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/pdm360ng.dts b/arch/powerpc/boot/dts/pdm360ng.dts
index 0b06947..7433740 100644
--- a/arch/powerpc/boot/dts/pdm360ng.dts
+++ b/arch/powerpc/boot/dts/pdm360ng.dts
@@ -17,7 +17,7 @@
 
 / {
 	model = "pdm360ng";
-	compatible = "ifm,pdm360ng";
+	compatible = "ifm,pdm360ng", "fsl,mpc5121";
 	#address-cells = <1>;
 	#size-cells = <1>;
 	interrupt-parent = <&ipic>;
diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
index 52d57d2..e504166 100644
--- a/arch/powerpc/platforms/512x/clock.c
+++ b/arch/powerpc/platforms/512x/clock.c
@@ -29,6 +29,8 @@
 #include <asm/mpc5121.h>
 #include <asm/clk_interface.h>
 
+#include "mpc512x.h"
+
 #undef CLK_DEBUG
 
 static int clocks_initialized;
@@ -683,8 +685,13 @@ static void psc_clks_init(void)
 	struct device_node *np;
 	struct platform_device *ofdev;
 	u32 reg;
+	const char *psc_compat;
+
+	psc_compat = mpc512x_select_psc_compat();
+	if (!psc_compat)
+		return;
 
-	for_each_compatible_node(np, NULL, "fsl,mpc5121-psc") {
+	for_each_compatible_node(np, NULL, psc_compat) {
 		if (!of_property_read_u32(np, "reg", &reg)) {
 			int pscnum = (reg & 0xf00) >> 8;
 			struct clk *clk = psc_dev_clk(pscnum);
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index c32b399..0a8e600 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -15,6 +15,7 @@ extern void __init mpc512x_init_IRQ(void);
 extern void __init mpc512x_init(void);
 extern int __init mpc5121_clk_init(void);
 void __init mpc512x_declare_of_platform_devices(void);
+extern const char *mpc512x_select_psc_compat(void);
 extern void mpc512x_restart(char *cmd);
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
diff --git a/arch/powerpc/platforms/512x/mpc512x_generic.c b/arch/powerpc/platforms/512x/mpc512x_generic.c
index ca1ca66..1ca7b61 100644
--- a/arch/powerpc/platforms/512x/mpc512x_generic.c
+++ b/arch/powerpc/platforms/512x/mpc512x_generic.c
@@ -28,6 +28,7 @@
  */
 static const char * const board[] __initconst = {
 	"prt,prtlvt",
+	"fsl,mpc5125ads",
 	NULL
 };
 
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index d30235b..1ef2fa1 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -350,6 +350,17 @@ void __init mpc512x_declare_of_platform_devices(void)
 
 #define DEFAULT_FIFO_SIZE 16
 
+const char *mpc512x_select_psc_compat(void)
+{
+	if (of_machine_is_compatible("fsl,mpc5121"))
+		return "fsl,mpc5121-psc";
+
+	if (of_machine_is_compatible("fsl,mpc5125"))
+		return "fsl,mpc5125-psc";
+
+	return NULL;
+}
+
 static unsigned int __init get_fifo_size(struct device_node *np,
 					 char *prop_name)
 {
@@ -375,9 +386,16 @@ void __init mpc512x_psc_fifo_init(void)
 	void __iomem *psc;
 	unsigned int tx_fifo_size;
 	unsigned int rx_fifo_size;
+	const char *psc_compat;
 	int fifobase = 0; /* current fifo address in 32 bit words */
 
-	for_each_compatible_node(np, NULL, "fsl,mpc5121-psc") {
+	psc_compat = mpc512x_select_psc_compat();
+	if (!psc_compat) {
+		pr_err("%s: no compatible devices found\n", __func__);
+		return;
+	}
+
+	for_each_compatible_node(np, NULL, psc_compat) {
 		tx_fifo_size = get_fifo_size(np, "fsl,tx-fifo-size");
 		rx_fifo_size = get_fifo_size(np, "fsl,rx-fifo-size");
 
-- 
1.7.10.4
