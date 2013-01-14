Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 132C52C009C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 07:40:05 +1100 (EST)
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net
 [192.168.8.180])
 by mail-out.m-online.net (Postfix) with ESMTP id 3YlRH7216Xz3hhqH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 21:34:11 +0100 (CET)
Received: from localhost (p4FDE760D.dip.t-dialin.net [79.222.118.13])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA id 3YlRH64bqDzbbfw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 21:34:10 +0100 (CET)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc/mpc5121: pdm360ng.dts: use common mpc5121.dtsi
Date: Mon, 14 Jan 2013 21:34:06 +0100
Message-Id: <1358195648-18678-2-git-send-email-agust@denx.de>
In-Reply-To: <1358195648-18678-1-git-send-email-agust@denx.de>
References: <1358195648-18678-1-git-send-email-agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change dts file for pdm360ng board to use common mpc5121
SoC dtsi file.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/boot/dts/pdm360ng.dts |  273 ++++--------------------------------
 1 files changed, 31 insertions(+), 242 deletions(-)

diff --git a/arch/powerpc/boot/dts/pdm360ng.dts b/arch/powerpc/boot/dts/pdm360ng.dts
index 94dfa5c..0b06947 100644
--- a/arch/powerpc/boot/dts/pdm360ng.dts
+++ b/arch/powerpc/boot/dts/pdm360ng.dts
@@ -13,7 +13,7 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "mpc5121.dtsi"
 
 / {
 	model = "pdm360ng";
@@ -22,38 +22,12 @@
 	#size-cells = <1>;
 	interrupt-parent = <&ipic>;
 
-	aliases {
-		ethernet0 = &eth0;
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
 	memory {
 		device_type = "memory";
 		reg = <0x00000000 0x20000000>;	// 512MB at 0
 	};
 
 	nfc@40000000 {
-		compatible = "fsl,mpc5121-nfc";
-		reg = <0x40000000 0x100000>;
-		interrupts = <0x6 0x8>;
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
 		bank-width = <0x1>;
 		chips = <0x1>;
 
@@ -63,17 +37,7 @@
 		};
 	};
 
-	sram@50000000 {
-		compatible = "fsl,mpc5121-sram";
-		reg = <0x50000000 0x20000>;	// 128K at 0x50000000
-	};
-
 	localbus@80000020 {
-		compatible = "fsl,mpc5121-localbus";
-		#address-cells = <2>;
-		#size-cells = <1>;
-		reg = <0x80000020 0x40>;
-
 		ranges = <0x0 0x0 0xf0000000 0x10000000   /* Flash */
 			  0x2 0x0 0x50040000 0x00020000>; /* CS2: MRAM */
 
@@ -129,74 +93,8 @@
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
-		pmc@1000{	//Power Management Controller
-			compatible = "fsl,mpc5121-pmc";
-			reg = <0x1000 0x100>;
-			interrupts = <83 0x2>;
-		};
-
-		gpio@1100 {
-			compatible = "fsl,mpc5121-gpio";
-			reg = <0x1100 0x100>;
-			interrupts = <78 0x8>;
-		};
-
-		can@1300 {
-			compatible = "fsl,mpc5121-mscan";
-			interrupts = <12 0x8>;
-			reg = <0x1300 0x80>;
-		};
-
-		can@1380 {
-			compatible = "fsl,mpc5121-mscan";
-			interrupts = <13 0x8>;
-			reg = <0x1380 0x80>;
-		};
 
 		i2c@1700 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,mpc5121-i2c";
-			reg = <0x1700 0x20>;
-			interrupts = <0x9 0x8>;
 			fsl,preserve-clocking;
 
 			eeprom@50 {
@@ -210,201 +108,92 @@
 			};
 		};
 
-		i2c@1740 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,mpc5121-i2c";
-			reg = <0x1740 0x20>;
-			interrupts = <0xb 0x8>;
-			fsl,preserve-clocking;
-		};
-
-		i2ccontrol@1760 {
-			compatible = "fsl,mpc5121-i2c-ctrl";
-			reg = <0x1760 0x8>;
-		};
-
-		axe@2000 {
-			compatible = "fsl,mpc5121-axe";
-			reg = <0x2000 0x100>;
-			interrupts = <42 0x8>;
-		};
-
-		display@2100 {
-			compatible = "fsl,mpc5121-diu";
-			reg = <0x2100 0x100>;
-			interrupts = <64 0x8>;
+		i2c@1720 {
+			status = "disabled";
 		};
 
-		can@2300 {
-			compatible = "fsl,mpc5121-mscan";
-			interrupts = <90 0x8>;
-			reg = <0x2300 0x80>;
-		};
-
-		can@2380 {
-			compatible = "fsl,mpc5121-mscan";
-			interrupts = <91 0x8>;
-			reg = <0x2380 0x80>;
+		i2c@1740 {
+			fsl,preserve-clocking;
 		};
 
-		viu@2400 {
-			compatible = "fsl,mpc5121-viu";
-			reg = <0x2400 0x400>;
-			interrupts = <67 0x8>;
+		ethernet@2800 {
+			phy-handle = <&phy0>;
 		};
 
 		mdio@2800 {
-			compatible = "fsl,mpc5121-fec-mdio";
-			reg = <0x2800 0x200>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			phy: ethernet-phy@0 {
+			phy0: ethernet-phy@1f {
 				compatible = "smsc,lan8700";
 				reg = <0x1f>;
 			};
 		};
 
-		eth0: ethernet@2800 {
-			compatible = "fsl,mpc5121-fec";
-			reg = <0x2800 0x200>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <4 0x8>;
-			phy-handle = < &phy >;
-		};
-
-		// USB1 using external ULPI PHY
+		/* USB1 using external ULPI PHY */
 		usb@3000 {
-			compatible = "fsl,mpc5121-usb2-dr";
-			reg = <0x3000 0x600>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <43 0x8>;
 			dr_mode = "host";
-			phy_type = "ulpi";
 		};
 
-		// USB0 using internal UTMI PHY
+		/* USB0 using internal UTMI PHY */
 		usb@4000 {
-			compatible = "fsl,mpc5121-usb2-dr";
-			reg = <0x4000 0x600>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <44 0x8>;
-			dr_mode = "otg";
-			phy_type = "utmi_wide";
 			fsl,invert-pwr-fault;
 		};
 
-		// IO control
-		ioctl@a000 {
-			compatible = "fsl,mpc5121-ioctl";
-			reg = <0xA000 0x1000>;
-		};
-
-		// 512x PSCs are not 52xx PSCs compatible
-		serial@11000 {
+		psc@11000 {
 			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
-			cell-index = <0>;
-			reg = <0x11000 0x100>;
-			interrupts = <40 0x8>;
-			fsl,rx-fifo-size = <16>;
-			fsl,tx-fifo-size = <16>;
 		};
 
-		serial@11100 {
+		psc@11100 {
 			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
-			cell-index = <1>;
-			reg = <0x11100 0x100>;
-			interrupts = <40 0x8>;
-			fsl,rx-fifo-size = <16>;
-			fsl,tx-fifo-size = <16>;
 		};
 
-		serial@11200 {
+		psc@11200 {
 			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
-			cell-index = <2>;
-			reg = <0x11200 0x100>;
-			interrupts = <40 0x8>;
-			fsl,rx-fifo-size = <16>;
-			fsl,tx-fifo-size = <16>;
 		};
 
-		serial@11300 {
+		psc@11300 {
 			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
-			cell-index = <3>;
-			reg = <0x11300 0x100>;
-			interrupts = <40 0x8>;
-			fsl,rx-fifo-size = <16>;
-			fsl,tx-fifo-size = <16>;
 		};
 
-		serial@11400 {
+		psc@11400 {
 			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
-			cell-index = <4>;
-			reg = <0x11400 0x100>;
-			interrupts = <40 0x8>;
-			fsl,rx-fifo-size = <16>;
-			fsl,tx-fifo-size = <16>;
 		};
 
-		serial@11600 {
-			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
-			cell-index = <6>;
-			reg = <0x11600 0x100>;
-			interrupts = <40 0x8>;
-			fsl,rx-fifo-size = <16>;
-			fsl,tx-fifo-size = <16>;
+		psc@11500 {
+			status = "disabled";
 		};
 
-		serial@11800 {
+		psc@11600 {
 			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
-			cell-index = <8>;
-			reg = <0x11800 0x100>;
-			interrupts = <40 0x8>;
-			fsl,rx-fifo-size = <16>;
-			fsl,tx-fifo-size = <16>;
 		};
 
-		serial@11B00 {
-			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
-			cell-index = <11>;
-			reg = <0x11B00 0x100>;
-			interrupts = <40 0x8>;
-			fsl,rx-fifo-size = <16>;
-			fsl,tx-fifo-size = <16>;
+		psc@11700 {
+			status = "disabled";
 		};
 
-		pscfifo@11f00 {
-			compatible = "fsl,mpc5121-psc-fifo";
-			reg = <0x11f00 0x100>;
-			interrupts = <40 0x8>;
+		psc@11800 {
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
 		};
 
-		spi@11900 {
+		psc@11900 {
 			compatible = "fsl,mpc5121-psc-spi", "fsl,mpc5121-psc";
-			cell-index = <9>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0x11900 0x100>;
-			interrupts = <40 0x8>;
-			fsl,rx-fifo-size = <16>;
-			fsl,tx-fifo-size = <16>;
 
-			// 7845 touch screen controller
+			/* ADS7845 touch screen controller */
 			ts@0 {
 				compatible = "ti,ads7846";
 				reg = <0x0>;
 				spi-max-frequency = <3000000>;
-				// pen irq is GPIO25
+				/* pen irq is GPIO25 */
 				interrupts = <78 0x8>;
 			};
 		};
 
-		dma@14000 {
-			compatible = "fsl,mpc5121-dma";
-			reg = <0x14000 0x1800>;
-			interrupts = <65 0x8>;
+		psc@11a00 {
+			status = "disabled";
+		};
+
+		psc@11b00 {
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
 		};
 	};
 };
-- 
1.7.5.4
