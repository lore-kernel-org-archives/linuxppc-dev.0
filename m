Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 184C32C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 07:40:05 +1100 (EST)
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net
 [192.168.8.180])
 by mail-out.m-online.net (Postfix) with ESMTP id 3YlRH71tRKz3hhmM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 21:34:10 +0100 (CET)
Received: from localhost (p4FDE760D.dip.t-dialin.net [79.222.118.13])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA id 3YlRH45r57zbbfY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 21:34:08 +0100 (CET)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc/mpc5121: add common .dtsi and use it in
 mpc5121ads.dts
Date: Mon, 14 Jan 2013 21:34:05 +0100
Message-Id: <1358195648-18678-1-git-send-email-agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Provide common mpc5121.dtsi file for mpc5121 SoC and modify
mpc5121ads.dts to use mpc5121.dtsi.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/boot/dts/mpc5121.dtsi   |  410 ++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc5121ads.dts |  319 ++++-----------------------
 2 files changed, 449 insertions(+), 280 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc5121.dtsi

diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
new file mode 100644
index 0000000..723e292
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc5121.dtsi
@@ -0,0 +1,410 @@
+/*
+ * base MPC5121 Device Tree Source
+ *
+ * Copyright 2007-2008 Freescale Semiconductor Inc.
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
+	model = "mpc5121";
+	compatible = "fsl,mpc5121";
+	#address-cells = <1>;
+	#size-cells = <1>;
+        interrupt-parent = <&ipic>;
+
+	aliases {
+		ethernet0 = &eth0;
+		pci = &pci;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,5121@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <0x20>;	/* 32 bytes */
+			i-cache-line-size = <0x20>;	/* 32 bytes */
+			d-cache-size = <0x8000>;	/* L1, 32K */
+			i-cache-size = <0x8000>;	/* L1, 32K */
+			timebase-frequency = <49500000>;/* 49.5 MHz (csb/4) */
+			bus-frequency = <198000000>;	/* 198 MHz csb bus */
+			clock-frequency = <396000000>;	/* 396 MHz ppc core */
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;	/* 256MB at 0 */
+	};
+
+	mbx@20000000 {
+		compatible = "fsl,mpc5121-mbx";
+		reg = <0x20000000 0x4000>;
+		interrupts = <66 0x8>;
+	};
+
+	sram@30000000 {
+		compatible = "fsl,mpc5121-sram";
+		reg = <0x30000000 0x20000>;	/* 128K at 0x30000000 */
+	};
+
+	nfc@40000000 {
+		compatible = "fsl,mpc5121-nfc";
+		reg = <0x40000000 0x100000>;	/* 1M at 0x40000000 */
+		interrupts = <6 8>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	localbus@80000020 {
+		compatible = "fsl,mpc5121-localbus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0x80000020 0x40>;
+		interrupts = <7 0x8>;
+		ranges = <0x0 0x0 0xfc000000 0x04000000>;
+	};
+
+	soc@80000000 {
+		compatible = "fsl,mpc5121-immr";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		ranges = <0x0 0x80000000 0x400000>;
+		reg = <0x80000000 0x400000>;
+		bus-frequency = <66000000>;	/* 66 MHz ips bus */
+
+
+		/*
+		 * IPIC
+		 * interrupts cell = <intr #, sense>
+		 * sense values match linux IORESOURCE_IRQ_* defines:
+		 * sense == 8: Level, low assertion
+		 * sense == 2: Edge, high-to-low change
+		 */
+		ipic: interrupt-controller@c00 {
+			compatible = "fsl,mpc5121-ipic", "fsl,ipic";
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0xc00 0x100>;
+		};
+
+		/* Watchdog timer */
+		wdt@900 {
+			compatible = "fsl,mpc5121-wdt";
+			reg = <0x900 0x100>;
+		};
+
+		/* Real time clock */
+		rtc@a00 {
+			compatible = "fsl,mpc5121-rtc";
+			reg = <0xa00 0x100>;
+			interrupts = <79 0x8 80 0x8>;
+		};
+
+		/* Reset module */
+		reset@e00 {
+			compatible = "fsl,mpc5121-reset";
+			reg = <0xe00 0x100>;
+		};
+
+		/* Clock control */
+		clock@f00 {
+			compatible = "fsl,mpc5121-clock";
+			reg = <0xf00 0x100>;
+		};
+
+		/* Power Management Controller */
+		pmc@1000{
+			compatible = "fsl,mpc5121-pmc";
+			reg = <0x1000 0x100>;
+			interrupts = <83 0x8>;
+		};
+
+		gpio@1100 {
+			compatible = "fsl,mpc5121-gpio";
+			reg = <0x1100 0x100>;
+			interrupts = <78 0x8>;
+		};
+
+		can@1300 {
+			compatible = "fsl,mpc5121-mscan";
+			reg = <0x1300 0x80>;
+			interrupts = <12 0x8>;
+		};
+
+		can@1380 {
+			compatible = "fsl,mpc5121-mscan";
+			reg = <0x1380 0x80>;
+			interrupts = <13 0x8>;
+		};
+
+		sdhc@1500 {
+			compatible = "fsl,mpc5121-sdhc";
+			reg = <0x1500 0x100>;
+			interrupts = <8 0x8>;
+		};
+
+		i2c@1700 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
+			reg = <0x1700 0x20>;
+			interrupts = <9 0x8>;
+		};
+
+		i2c@1720 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
+			reg = <0x1720 0x20>;
+			interrupts = <10 0x8>;
+		};
+
+		i2c@1740 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
+			reg = <0x1740 0x20>;
+			interrupts = <11 0x8>;
+		};
+
+		i2ccontrol@1760 {
+			compatible = "fsl,mpc5121-i2c-ctrl";
+			reg = <0x1760 0x8>;
+		};
+
+		axe@2000 {
+			compatible = "fsl,mpc5121-axe";
+			reg = <0x2000 0x100>;
+			interrupts = <42 0x8>;
+		};
+
+		display@2100 {
+			compatible = "fsl,mpc5121-diu";
+			reg = <0x2100 0x100>;
+			interrupts = <64 0x8>;
+		};
+
+		can@2300 {
+			compatible = "fsl,mpc5121-mscan";
+			reg = <0x2300 0x80>;
+			interrupts = <90 0x8>;
+		};
+
+		can@2380 {
+			compatible = "fsl,mpc5121-mscan";
+			reg = <0x2380 0x80>;
+			interrupts = <91 0x8>;
+		};
+
+		viu@2400 {
+			compatible = "fsl,mpc5121-viu";
+			reg = <0x2400 0x400>;
+			interrupts = <67 0x8>;
+		};
+
+		mdio@2800 {
+			compatible = "fsl,mpc5121-fec-mdio";
+			reg = <0x2800 0x800>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		eth0: ethernet@2800 {
+			device_type = "network";
+			compatible = "fsl,mpc5121-fec";
+			reg = <0x2800 0x800>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <4 0x8>;
+		};
+
+		/* USB1 using external ULPI PHY */
+		usb@3000 {
+			compatible = "fsl,mpc5121-usb2-dr";
+			reg = <0x3000 0x600>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <43 0x8>;
+			dr_mode = "otg";
+			phy_type = "ulpi";
+		};
+
+		/* USB0 using internal UTMI PHY */
+		usb@4000 {
+			compatible = "fsl,mpc5121-usb2-dr";
+			reg = <0x4000 0x600>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <44 0x8>;
+			dr_mode = "otg";
+			phy_type = "utmi_wide";
+		};
+
+		/* IO control */
+		ioctl@a000 {
+			compatible = "fsl,mpc5121-ioctl";
+			reg = <0xA000 0x1000>;
+		};
+
+		/* LocalPlus controller */
+		lpc@10000 {
+			compatible = "fsl,mpc5121-lpc";
+			reg = <0x10000 0x200>;
+		};
+
+		pata@10200 {
+			compatible = "fsl,mpc5121-pata";
+			reg = <0x10200 0x100>;
+			interrupts = <5 0x8>;
+		};
+
+		/* 512x PSCs are not 52xx PSC compatible */
+
+		/* PSC0 */
+		psc@11000 {
+			compatible = "fsl,mpc5121-psc";
+			reg = <0x11000 0x100>;
+			interrupts = <40 0x8>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		/* PSC1 */
+		psc@11100 {
+			compatible = "fsl,mpc5121-psc";
+			reg = <0x11100 0x100>;
+			interrupts = <40 0x8>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		/* PSC2 */
+		psc@11200 {
+			compatible = "fsl,mpc5121-psc";
+			reg = <0x11200 0x100>;
+			interrupts = <40 0x8>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		/* PSC3 */
+		psc@11300 {
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+			reg = <0x11300 0x100>;
+			interrupts = <40 0x8>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		/* PSC4 */
+		psc@11400 {
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+			reg = <0x11400 0x100>;
+			interrupts = <40 0x8>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		/* PSC5 */
+		psc@11500 {
+			compatible = "fsl,mpc5121-psc";
+			reg = <0x11500 0x100>;
+			interrupts = <40 0x8>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		/* PSC6 */
+		psc@11600 {
+			compatible = "fsl,mpc5121-psc";
+			reg = <0x11600 0x100>;
+			interrupts = <40 0x8>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		/* PSC7 */
+		psc@11700 {
+			compatible = "fsl,mpc5121-psc";
+			reg = <0x11700 0x100>;
+			interrupts = <40 0x8>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		/* PSC8 */
+		psc@11800 {
+			compatible = "fsl,mpc5121-psc";
+			reg = <0x11800 0x100>;
+			interrupts = <40 0x8>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		/* PSC9 */
+		psc@11900 {
+			compatible = "fsl,mpc5121-psc";
+			reg = <0x11900 0x100>;
+			interrupts = <40 0x8>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		/* PSC10 */
+		psc@11a00 {
+			compatible = "fsl,mpc5121-psc";
+			reg = <0x11a00 0x100>;
+			interrupts = <40 0x8>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		/* PSC11 */
+		psc@11b00 {
+			compatible = "fsl,mpc5121-psc";
+			reg = <0x11b00 0x100>;
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
+			compatible = "fsl,mpc5121-dma";
+			reg = <0x14000 0x1800>;
+			interrupts = <65 0x8>;
+		};
+	};
+
+	pci: pci@80008500 {
+		compatible = "fsl,mpc5121-pci";
+		device_type = "pci";
+		interrupts = <1 0x8>;
+		clock-frequency = <0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+
+		reg = <0x80008500 0x100	/* internal registers */
+		       0x80008300 0x8>;	/* config space access registers */
+		bus-range = <0x0 0x0>;
+		ranges = <0x42000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
+			  0x02000000 0x0 0xb0000000 0xb0000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0x84000000 0x0 0x01000000>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
index c9ef6bb..f269b13 100644
--- a/arch/powerpc/boot/dts/mpc5121ads.dts
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -1,7 +1,7 @@
 /*
  * MPC5121E ADS Device Tree Source
  *
- * Copyright 2007,2008 Freescale Semiconductor Inc.
+ * Copyright 2007-2008 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -9,74 +9,26 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "mpc5121.dtsi"
 
 / {
 	model = "mpc5121ads";
 	compatible = "fsl,mpc5121ads";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	aliases {
-		pci = &pci;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,5121@0 {
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <0x20>;	// 32 bytes
-			i-cache-line-size = <0x20>;	// 32 bytes
-			d-cache-size = <0x8000>;	// L1, 32K
-			i-cache-size = <0x8000>;	// L1, 32K
-			timebase-frequency = <49500000>;// 49.5 MHz (csb/4)
-			bus-frequency = <198000000>;	// 198 MHz csb bus
-			clock-frequency = <396000000>;	// 396 MHz ppc core
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x00000000 0x10000000>;	// 256MB at 0
-	};
-
-	mbx@20000000 {
-		compatible = "fsl,mpc5121-mbx";
-		reg = <0x20000000 0x4000>;
-		interrupts = <66 0x8>;
-		interrupt-parent = < &ipic >;
-	};
-
-	sram@30000000 {
-		compatible = "fsl,mpc5121-sram";
-		reg = <0x30000000 0x20000>;		// 128K at 0x30000000
-	};
 
 	nfc@40000000 {
-		compatible = "fsl,mpc5121-nfc";
-		reg = <0x40000000 0x100000>;	// 1M at 0x40000000
-		interrupts = <6 8>;
-		interrupt-parent = < &ipic >;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		// ADS has two Hynix 512MB Nand flash chips in a single
-		// stacked package.
+		/*
+		 * ADS has two Hynix 512MB Nand flash chips in a single
+		 * stacked package.
+		 */
 		chips = <2>;
+
 		nand@0 {
 			label = "nand";
-			reg = <0x00000000 0x40000000>;	// 512MB + 512MB
+			reg = <0x00000000 0x40000000>;	/* 512MB + 512MB */
 		};
 	};
 
 	localbus@80000020 {
-		compatible = "fsl,mpc5121-localbus";
-		#address-cells = <2>;
-		#size-cells = <1>;
-		reg = <0x80000020 0x40>;
-
 		ranges = <0x0 0x0 0xfc000000 0x04000000
 			  0x2 0x0 0x82000000 0x00008000>;
 
@@ -87,6 +39,7 @@
 			#size-cells = <1>;
 			bank-width = <4>;
 			device-width = <2>;
+
 			protected@0 {
 				label = "protected";
 				reg = <0x00000000 0x00040000>;  // first sector is protected
@@ -121,91 +74,18 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			reg = <0x2 0xa 0x5>;
-			interrupt-parent = < &ipic >;
-			// irq routing
-			//	all irqs but touch screen are routed to irq0 (ipic 48)
-			//	touch screen is statically routed to irq1 (ipic 17)
-			//	so don't use it here
+			/* irq routing:
+			 * all irqs but touch screen are routed to irq0 (ipic 48)
+			 * touch screen is statically routed to irq1 (ipic 17)
+			 * so don't use it here
+			 */
 			interrupts = <48 0x8>;
 		};
 	};
 
 	soc@80000000 {
-		compatible = "fsl,mpc5121-immr";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		#interrupt-cells = <2>;
-		ranges = <0x0 0x80000000 0x400000>;
-		reg = <0x80000000 0x400000>;
-		bus-frequency = <66000000>;	// 66 MHz ips bus
-
-
-		// IPIC
-		// interrupts cell = <intr #, sense>
-		// sense values match linux IORESOURCE_IRQ_* defines:
-		// sense == 8: Level, low assertion
-		// sense == 2: Edge, high-to-low change
-		//
-		ipic: interrupt-controller@c00 {
-			compatible = "fsl,mpc5121-ipic", "fsl,ipic";
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0xc00 0x100>;
-		};
-
-		rtc@a00 {	// Real time clock
-			compatible = "fsl,mpc5121-rtc";
-			reg = <0xa00 0x100>;
-			interrupts = <79 0x8 80 0x8>;
-			interrupt-parent = < &ipic >;
-		};
-
-		reset@e00 {	// Reset module
-			compatible = "fsl,mpc5121-reset";
-			reg = <0xe00 0x100>;
-		};
-
-		clock@f00 {	// Clock control
-			compatible = "fsl,mpc5121-clock";
-			reg = <0xf00 0x100>;
-		};
-
-		pmc@1000{  //Power Management Controller
-			compatible = "fsl,mpc5121-pmc";
-			reg = <0x1000 0x100>;
-			interrupts = <83 0x2>;
-			interrupt-parent = < &ipic >;
-		};
-
-		gpio@1100 {
-			compatible = "fsl,mpc5121-gpio";
-			reg = <0x1100 0x100>;
-			interrupts = <78 0x8>;
-			interrupt-parent = < &ipic >;
-		};
-
-		can@1300 {
-			compatible = "fsl,mpc5121-mscan";
-			interrupts = <12 0x8>;
-			interrupt-parent = < &ipic >;
-			reg = <0x1300 0x80>;
-		};
-
-		can@1380 {
-			compatible = "fsl,mpc5121-mscan";
-			interrupts = <13 0x8>;
-			interrupt-parent = < &ipic >;
-			reg = <0x1380 0x80>;
-		};
 
 		i2c@1700 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
-			reg = <0x1700 0x20>;
-			interrupts = <9 0x8>;
-			interrupt-parent = < &ipic >;
 			fsl,preserve-clocking;
 
 			hwmon@4a {
@@ -224,196 +104,75 @@
 			};
 		};
 
-		i2c@1720 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
-			reg = <0x1720 0x20>;
-			interrupts = <10 0x8>;
-			interrupt-parent = < &ipic >;
-		};
-
-		i2c@1740 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,mpc5121-i2c", "fsl-i2c";
-			reg = <0x1740 0x20>;
-			interrupts = <11 0x8>;
-			interrupt-parent = < &ipic >;
+		eth0: ethernet@2800 {
+			phy-handle = <&phy0>;
 		};
 
-		i2ccontrol@1760 {
-			compatible = "fsl,mpc5121-i2c-ctrl";
-			reg = <0x1760 0x8>;
+		can@2300 {
+			status = "disabled";
 		};
 
-		axe@2000 {
-			compatible = "fsl,mpc5121-axe";
-			reg = <0x2000 0x100>;
-			interrupts = <42 0x8>;
-			interrupt-parent = < &ipic >;
+		can@2380 {
+			status = "disabled";
 		};
 
-		display@2100 {
-			compatible = "fsl,mpc5121-diu";
-			reg = <0x2100 0x100>;
-			interrupts = <64 0x8>;
-			interrupt-parent = < &ipic >;
+		viu@2400 {
+			status = "disabled";
 		};
 
 		mdio@2800 {
-			compatible = "fsl,mpc5121-fec-mdio";
-			reg = <0x2800 0x800>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			phy: ethernet-phy@0 {
+			phy0: ethernet-phy@0 {
 				reg = <1>;
-				device_type = "ethernet-phy";
 			};
 		};
 
-		ethernet@2800 {
-			device_type = "network";
-			compatible = "fsl,mpc5121-fec";
-			reg = <0x2800 0x800>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <4 0x8>;
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy >;
-			fsl,align-tx-packets = <4>;
+		/* mpc5121ads only uses USB0 */
+		usb@3000 {
+			status = "disabled";
 		};
 
-		// 5121e has two dr usb modules
-		// mpc5121_ads only uses USB0
-
-		// USB1 using external ULPI PHY
-		//usb@3000 {
-		//	compatible = "fsl,mpc5121-usb2-dr";
-		//	reg = <0x3000 0x1000>;
-		//	#address-cells = <1>;
-		//	#size-cells = <0>;
-		//	interrupt-parent = < &ipic >;
-		//	interrupts = <43 0x8>;
-		//	dr_mode = "otg";
-		//	phy_type = "ulpi";
-		//};
-
-		// USB0 using internal UTMI PHY
+		/* USB0 using internal UTMI PHY */
 		usb@4000 {
-			compatible = "fsl,mpc5121-usb2-dr";
-			reg = <0x4000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupt-parent = < &ipic >;
-			interrupts = <44 0x8>;
-			dr_mode = "otg";
-			phy_type = "utmi_wide";
+			dr_mode = "host";
 			fsl,invert-drvvbus;
 			fsl,invert-pwr-fault;
 		};
 
-		// IO control
-		ioctl@a000 {
-			compatible = "fsl,mpc5121-ioctl";
-			reg = <0xA000 0x1000>;
-		};
-
-		pata@10200 {
-			compatible = "fsl,mpc5121-pata";
-			reg = <0x10200 0x100>;
-			interrupts = <5 0x8>;
-			interrupt-parent = < &ipic >;
-		};
-
-		// 512x PSCs are not 52xx PSC compatible
-		// PSC3 serial port A aka ttyPSC0
-		serial@11300 {
-			device_type = "serial";
+		/* PSC3 serial port A aka ttyPSC0 */
+		psc@11300 {
 			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
-			// Logical port assignment needed until driver
-			// learns to use aliases
-			port-number = <0>;
-			cell-index = <3>;
-			reg = <0x11300 0x100>;
-			interrupts = <40 0x8>;
-			interrupt-parent = < &ipic >;
-			rx-fifo-size = <16>;
-			tx-fifo-size = <16>;
 		};
 
-		// PSC4 serial port B aka ttyPSC1
-		serial@11400 {
-			device_type = "serial";
+		/* PSC4 serial port B aka ttyPSC1 */
+		psc@11400 {
 			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
-			// Logical port assignment needed until driver
-			// learns to use aliases
-			port-number = <1>;
-			cell-index = <4>;
-			reg = <0x11400 0x100>;
-			interrupts = <40 0x8>;
-			interrupt-parent = < &ipic >;
-			rx-fifo-size = <16>;
-			tx-fifo-size = <16>;
 		};
 
-		// PSC5 in ac97 mode
-		ac97@11500 {
+		/* PSC5 in ac97 mode */
+		ac97: psc@11500 {
 			compatible = "fsl,mpc5121-psc-ac97", "fsl,mpc5121-psc";
-			cell-index = <5>;
-			reg = <0x11500 0x100>;
-			interrupts = <40 0x8>;
-			interrupt-parent = < &ipic >;
 			fsl,mode = "ac97-slave";
-			rx-fifo-size = <384>;
-			tx-fifo-size = <384>;
-		};
-
-		pscfifo@11f00 {
-			compatible = "fsl,mpc5121-psc-fifo";
-			reg = <0x11f00 0x100>;
-			interrupts = <40 0x8>;
-			interrupt-parent = < &ipic >;
+			fsl,rx-fifo-size = <384>;
+			fsl,tx-fifo-size = <384>;
 		};
-
-		dma@14000 {
-			compatible = "fsl,mpc5121-dma";
-			reg = <0x14000 0x1800>;
-			interrupts = <65 0x8>;
-			interrupt-parent = < &ipic >;
-		};
-
 	};
 
 	pci: pci@80008500 {
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
-				// IDSEL 0x15 - Slot 1 PCI
+				/* IDSEL 0x15 - Slot 1 PCI */
 				 0xa800 0x0 0x0 0x1 &cpld_pic 0x0 0x8
 				 0xa800 0x0 0x0 0x2 &cpld_pic 0x1 0x8
 				 0xa800 0x0 0x0 0x3 &cpld_pic 0x2 0x8
 				 0xa800 0x0 0x0 0x4 &cpld_pic 0x3 0x8
 
-				// IDSEL 0x16 - Slot 2 MiniPCI
+				/* IDSEL 0x16 - Slot 2 MiniPCI */
 				 0xb000 0x0 0x0 0x1 &cpld_pic 0x4 0x8
 				 0xb000 0x0 0x0 0x2 &cpld_pic 0x5 0x8
 
-				// IDSEL 0x17 - Slot 3 MiniPCI
+				/* IDSEL 0x17 - Slot 3 MiniPCI */
 				 0xb800 0x0 0x0 0x1 &cpld_pic 0x6 0x8
 				 0xb800 0x0 0x0 0x2 &cpld_pic 0x7 0x8
 				>;
-		interrupt-parent = < &ipic >;
-		interrupts = <1 0x8>;
-		bus-range = <0 0>;
-		ranges = <0x42000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
-			  0x02000000 0x0 0xb0000000 0xb0000000 0x0 0x10000000
-			  0x01000000 0x0 0x00000000 0x84000000 0x0 0x01000000>;
-		clock-frequency = <0>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0x80008500 0x100		/* internal registers */
-		       0x80008300 0x8>;		/* config space access registers */
-		compatible = "fsl,mpc5121-pci";
-		device_type = "pci";
 	};
 };
-- 
1.7.5.4
