Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 70498DDD0A
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 18:28:04 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/9] mpc834x_mds: Convert device tree source to dts-v1
Date: Mon, 28 Jan 2008 02:27:52 -0500
Message-Id: <51b1015cd61540df832ee5d5ee125e7326c3f0ed.1201503958.git.paul.gortmaker@windriver.com>
In-Reply-To: <a050480a21aef92854805e9bee517c0d65d5bd59.1201503958.git.paul.gortmaker@windriver.com>
References: <1201505279-25847-1-git-send-email-paul.gortmaker@windriver.com>
	<a050480a21aef92854805e9bee517c0d65d5bd59.1201503958.git.paul.gortmaker@windriver.com>
In-Reply-To: <a050480a21aef92854805e9bee517c0d65d5bd59.1201503958.git.paul.gortmaker@windriver.com>
References: <a050480a21aef92854805e9bee517c0d65d5bd59.1201503958.git.paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move mpc834x_mds device tree source forward to dts-v1 format.  Nothing
too complex in this one, so it boils down to just adding a bunch of 0x
in the right places and converting clock speeds to decimal.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/mpc834x_mds.dts |  254 +++++++++++++++++----------------
 1 files changed, 128 insertions(+), 126 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 4120e92..537a77c 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -9,6 +9,8 @@
  * option) any later version.
  */
 
+/dts-v1/;
+
 / {
 	model = "MPC8349EMDS";
 	compatible = "MPC8349EMDS", "MPC834xMDS", "MPC83xxMDS";
@@ -31,10 +33,10 @@
 		PowerPC,8349@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
-			d-cache-size = <8000>;		// L1, 32K
-			i-cache-size = <8000>;		// L1, 32K
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
@@ -43,26 +45,26 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 10000000>;	// 256MB at 0
+		reg = <0x00000000 0x10000000>;	// 256MB at 0
 	};
 
 	bcsr@e2400000 {
 		device_type = "board-control";
-		reg = <e2400000 8000>;
+		reg = <0xe2400000 0x8000>;
 	};
 
 	soc8349@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		ranges = <0 e0000000 00100000>;
-		reg = <e0000000 00000200>;
+		ranges = <0x0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;
 
 		wdt@200 {
 			device_type = "watchdog";
 			compatible = "mpc83xx_wdt";
-			reg = <200 100>;
+			reg = <0x200 0x100>;
 		};
 
 		i2c@3000 {
@@ -70,14 +72,14 @@
 			#size-cells = <0>;
 			cell-index = <0>;
 			compatible = "fsl-i2c";
-			reg = <3000 100>;
-			interrupts = <e 8>;
-			interrupt-parent = < &ipic >;
+			reg = <0x3000 0x100>;
+			interrupts = <14 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 
 			rtc@68 {
 				compatible = "dallas,ds1374";
-				reg = <68>;
+				reg = <0x68>;
 			};
 		};
 
@@ -86,41 +88,41 @@
 			#size-cells = <0>;
 			cell-index = <1>;
 			compatible = "fsl-i2c";
-			reg = <3100 100>;
-			interrupts = <f 8>;
-			interrupt-parent = < &ipic >;
+			reg = <0x3100 0x100>;
+			interrupts = <15 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 		};
 
 		spi@7000 {
 			device_type = "spi";
 			compatible = "fsl_spi";
-			reg = <7000 1000>;
-			interrupts = <10 8>;
-			interrupt-parent = < &ipic >;
+			reg = <0x7000 0x1000>;
+			interrupts = <16 0x8>;
+			interrupt-parent = <&ipic>;
 			mode = "cpu";
 		};
 
-		/* phy type (ULPI or SERIAL) are only types supportted for MPH */
+		/* phy type (ULPI or SERIAL) are only types supported for MPH */
 		/* port = 0 or 1 */
 		usb@22000 {
 			compatible = "fsl-usb2-mph";
-			reg = <22000 1000>;
+			reg = <0x22000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = < &ipic >;
-			interrupts = <27 8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <39 0x8>;
 			phy_type = "ulpi";
 			port1;
 		};
 		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
-			reg = <23000 1000>;
+			reg = <0x23000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = < &ipic >;
-			interrupts = <26 8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <38 0x8>;
 			dr_mode = "otg";
 			phy_type = "ulpi";
 		};
@@ -129,18 +131,18 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,gianfar-mdio";
-			reg = <24520 20>;
+			reg = <0x24520 0x20>;
 
 			phy0: ethernet-phy@0 {
-				interrupt-parent = < &ipic >;
-				interrupts = <11 8>;
-				reg = <0>;
+				interrupt-parent = <&ipic>;
+				interrupts = <17 0x8>;
+				reg = <0x0>;
 				device_type = "ethernet-phy";
 			};
 			phy1: ethernet-phy@1 {
-				interrupt-parent = < &ipic >;
-				interrupts = <12 8>;
-				reg = <1>;
+				interrupt-parent = <&ipic>;
+				interrupts = <18 0x8>;
+				reg = <0x1>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -150,11 +152,11 @@
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
-			reg = <24000 1000>;
+			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <20 8 21 8 22 8>;
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy0 >;
+			interrupts = <32 0x8 33 0x8 34 0x8>;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy0>;
 			linux,network-index = <0>;
 		};
 
@@ -163,11 +165,11 @@
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
-			reg = <25000 1000>;
+			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <23 8 24 8 25 8>;
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy1 >;
+			interrupts = <35 0x8 36 0x8 37 0x8>;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy1>;
 			linux,network-index = <1>;
 		};
 
@@ -175,20 +177,20 @@
 			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4500 100>;
+			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <9 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <9 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4600 100>;
+			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <a 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <10 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		/* May need to remove if on a part without crypto engine */
@@ -196,15 +198,15 @@
 			device_type = "crypto";
 			model = "SEC2";
 			compatible = "talitos";
-			reg = <30000 10000>;
-			interrupts = <b 8>;
-			interrupt-parent = < &ipic >;
+			reg = <0x30000 0x10000>;
+			interrupts = <11 0x8>;
+			interrupt-parent = <&ipic>;
 			num-channels = <4>;
-			channel-fifo-len = <18>;
-			exec-units-mask = <0000007e>;
+			channel-fifo-len = <0x18>;
+			exec-units-mask = <0x0000007e>;
 			/* desc mask is for rev2.0,
 			 * we need runtime fixup for >2.0 */
-			descriptor-types-mask = <01010ebf>;
+			descriptor-types-mask = <0x01010ebf>;
 		};
 
 		/* IPIC
@@ -217,129 +219,129 @@
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
-			reg = <700 100>;
+			reg = <0x700 0x100>;
 			device_type = "ipic";
 		};
 	};
 
 	pci0: pci@e0008500 {
 		cell-index = <1>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 
 				/* IDSEL 0x11 */
-				 8800 0 0 1 &ipic 14 8
-				 8800 0 0 2 &ipic 15 8
-				 8800 0 0 3 &ipic 16 8
-				 8800 0 0 4 &ipic 17 8
+				 0x8800 0x0 0x0 0x1 &ipic 20 0x8
+				 0x8800 0x0 0x0 0x2 &ipic 21 0x8
+				 0x8800 0x0 0x0 0x3 &ipic 22 0x8
+				 0x8800 0x0 0x0 0x4 &ipic 23 0x8
 
 				/* IDSEL 0x12 */
-				 9000 0 0 1 &ipic 16 8
-				 9000 0 0 2 &ipic 17 8
-				 9000 0 0 3 &ipic 14 8
-				 9000 0 0 4 &ipic 15 8
+				 0x9000 0x0 0x0 0x1 &ipic 22 0x8
+				 0x9000 0x0 0x0 0x2 &ipic 23 0x8
+				 0x9000 0x0 0x0 0x3 &ipic 20 0x8
+				 0x9000 0x0 0x0 0x4 &ipic 21 0x8
 
 				/* IDSEL 0x13 */
-				 9800 0 0 1 &ipic 17 8
-				 9800 0 0 2 &ipic 14 8
-				 9800 0 0 3 &ipic 15 8
-				 9800 0 0 4 &ipic 16 8
+				 0x9800 0x0 0x0 0x1 &ipic 23 0x8
+				 0x9800 0x0 0x0 0x2 &ipic 20 0x8
+				 0x9800 0x0 0x0 0x3 &ipic 21 0x8
+				 0x9800 0x0 0x0 0x4 &ipic 22 0x8
 
 				/* IDSEL 0x15 */
-				 a800 0 0 1 &ipic 14 8
-				 a800 0 0 2 &ipic 15 8
-				 a800 0 0 3 &ipic 16 8
-				 a800 0 0 4 &ipic 17 8
+				 0xa800 0x0 0x0 0x1 &ipic 20 0x8
+				 0xa800 0x0 0x0 0x2 &ipic 21 0x8
+				 0xa800 0x0 0x0 0x3 &ipic 22 0x8
+				 0xa800 0x0 0x0 0x4 &ipic 23 0x8
 
 				/* IDSEL 0x16 */
-				 b000 0 0 1 &ipic 17 8
-				 b000 0 0 2 &ipic 14 8
-				 b000 0 0 3 &ipic 15 8
-				 b000 0 0 4 &ipic 16 8
+				 0xb000 0x0 0x0 0x1 &ipic 23 0x8
+				 0xb000 0x0 0x0 0x2 &ipic 20 0x8
+				 0xb000 0x0 0x0 0x3 &ipic 21 0x8
+				 0xb000 0x0 0x0 0x4 &ipic 22 0x8
 
 				/* IDSEL 0x17 */
-				 b800 0 0 1 &ipic 16 8
-				 b800 0 0 2 &ipic 17 8
-				 b800 0 0 3 &ipic 14 8
-				 b800 0 0 4 &ipic 15 8
+				 0xb800 0x0 0x0 0x1 &ipic 22 0x8
+				 0xb800 0x0 0x0 0x2 &ipic 23 0x8
+				 0xb800 0x0 0x0 0x3 &ipic 20 0x8
+				 0xb800 0x0 0x0 0x4 &ipic 21 0x8
 
 				/* IDSEL 0x18 */
-				 c000 0 0 1 &ipic 15 8
-				 c000 0 0 2 &ipic 16 8
-				 c000 0 0 3 &ipic 17 8
-				 c000 0 0 4 &ipic 14 8>;
-		interrupt-parent = < &ipic >;
-		interrupts = <42 8>;
+				 0xc000 0x0 0x0 0x1 &ipic 21 0x8
+				 0xc000 0x0 0x0 0x2 &ipic 22 0x8
+				 0xc000 0x0 0x0 0x3 &ipic 23 0x8
+				 0xc000 0x0 0x0 0x4 &ipic 20 0x8>;
+		interrupt-parent = <&ipic>;
+		interrupts = <0x42 0x8>;
 		bus-range = <0 0>;
-		ranges = <02000000 0 90000000 90000000 0 10000000
-			  42000000 0 80000000 80000000 0 10000000
-			  01000000 0 00000000 e2000000 0 00100000>;
-		clock-frequency = <3f940aa>;
+		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
+			  0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
+		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <e0008500 100>;
+		reg = <0xe0008500 0x100>;
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
 
 	pci1: pci@e0008600 {
 		cell-index = <2>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 
 				/* IDSEL 0x11 */
-				 8800 0 0 1 &ipic 14 8
-				 8800 0 0 2 &ipic 15 8
-				 8800 0 0 3 &ipic 16 8
-				 8800 0 0 4 &ipic 17 8
+				 0x8800 0x0 0x0 0x1 &ipic 20 0x8
+				 0x8800 0x0 0x0 0x2 &ipic 21 0x8
+				 0x8800 0x0 0x0 0x3 &ipic 22 0x8
+				 0x8800 0x0 0x0 0x4 &ipic 23 0x8
 
 				/* IDSEL 0x12 */
-				 9000 0 0 1 &ipic 16 8
-				 9000 0 0 2 &ipic 17 8
-				 9000 0 0 3 &ipic 14 8
-				 9000 0 0 4 &ipic 15 8
+				 0x9000 0x0 0x0 0x1 &ipic 22 0x8
+				 0x9000 0x0 0x0 0x2 &ipic 23 0x8
+				 0x9000 0x0 0x0 0x3 &ipic 20 0x8
+				 0x9000 0x0 0x0 0x4 &ipic 21 0x8
 
 				/* IDSEL 0x13 */
-				 9800 0 0 1 &ipic 17 8
-				 9800 0 0 2 &ipic 14 8
-				 9800 0 0 3 &ipic 15 8
-				 9800 0 0 4 &ipic 16 8
+				 0x9800 0x0 0x0 0x1 &ipic 23 0x8
+				 0x9800 0x0 0x0 0x2 &ipic 20 0x8
+				 0x9800 0x0 0x0 0x3 &ipic 21 0x8
+				 0x9800 0x0 0x0 0x4 &ipic 22 0x8
 
 				/* IDSEL 0x15 */
-				 a800 0 0 1 &ipic 14 8
-				 a800 0 0 2 &ipic 15 8
-				 a800 0 0 3 &ipic 16 8
-				 a800 0 0 4 &ipic 17 8
+				 0xa800 0x0 0x0 0x1 &ipic 20 0x8
+				 0xa800 0x0 0x0 0x2 &ipic 21 0x8
+				 0xa800 0x0 0x0 0x3 &ipic 22 0x8
+				 0xa800 0x0 0x0 0x4 &ipic 23 0x8
 
 				/* IDSEL 0x16 */
-				 b000 0 0 1 &ipic 17 8
-				 b000 0 0 2 &ipic 14 8
-				 b000 0 0 3 &ipic 15 8
-				 b000 0 0 4 &ipic 16 8
+				 0xb000 0x0 0x0 0x1 &ipic 23 0x8
+				 0xb000 0x0 0x0 0x2 &ipic 20 0x8
+				 0xb000 0x0 0x0 0x3 &ipic 21 0x8
+				 0xb000 0x0 0x0 0x4 &ipic 22 0x8
 
 				/* IDSEL 0x17 */
-				 b800 0 0 1 &ipic 16 8
-				 b800 0 0 2 &ipic 17 8
-				 b800 0 0 3 &ipic 14 8
-				 b800 0 0 4 &ipic 15 8
+				 0xb800 0x0 0x0 0x1 &ipic 22 0x8
+				 0xb800 0x0 0x0 0x2 &ipic 23 0x8
+				 0xb800 0x0 0x0 0x3 &ipic 20 0x8
+				 0xb800 0x0 0x0 0x4 &ipic 21 0x8
 
 				/* IDSEL 0x18 */
-				 c000 0 0 1 &ipic 15 8
-				 c000 0 0 2 &ipic 16 8
-				 c000 0 0 3 &ipic 17 8
-				 c000 0 0 4 &ipic 14 8>;
-		interrupt-parent = < &ipic >;
-		interrupts = <42 8>;
+				 0xc000 0x0 0x0 0x1 &ipic 21 0x8
+				 0xc000 0x0 0x0 0x2 &ipic 22 0x8
+				 0xc000 0x0 0x0 0x3 &ipic 23 0x8
+				 0xc000 0x0 0x0 0x4 &ipic 20 0x8>;
+		interrupt-parent = <&ipic>;
+		interrupts = <66 0x8>;
 		bus-range = <0 0>;
-		ranges = <02000000 0 b0000000 b0000000 0 10000000
-			  42000000 0 a0000000 a0000000 0 10000000
-			  01000000 0 00000000 e2100000 0 00100000>;
-		clock-frequency = <3f940aa>;
+		ranges = <0x02000000 0x0 0xb0000000 0xb0000000 0x0 0x10000000
+			  0x42000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xe2100000 0x0 0x00100000>;
+		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <e0008600 100>;
+		reg = <0xe0008600 0x100>;
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
-- 
1.5.4.rc4.gcab31
