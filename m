Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id F231ADDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 18:28:06 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/9] mpc832x_mds: Convert mpc832x_mds to dts-v1 format.
Date: Mon, 28 Jan 2008 02:27:55 -0500
Message-Id: <fa3dbfb49842f4553d619b1cf209102ca2457d62.1201503958.git.paul.gortmaker@windriver.com>
In-Reply-To: <1d2d2df57a47cff00d8539194b0c997175d18170.1201503958.git.paul.gortmaker@windriver.com>
References: <1201505279-25847-1-git-send-email-paul.gortmaker@windriver.com>
	<a050480a21aef92854805e9bee517c0d65d5bd59.1201503958.git.paul.gortmaker@windriver.com>
	<51b1015cd61540df832ee5d5ee125e7326c3f0ed.1201503958.git.paul.gortmaker@windriver.com>
	<d8e187e4d4aa981109450f333658730e3408f627.1201503958.git.paul.gortmaker@windriver.com>
	<1d2d2df57a47cff00d8539194b0c997175d18170.1201503958.git.paul.gortmaker@windriver.com>
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

Convert the MPC832x MDS dts file to v1 format.  Entries for
values normally parsed by humans are left in decimal (i.e. IRQ,
cache size, clock rates, basic counts and index values).

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/mpc832x_mds.dts |  234 +++++++++++++++++----------------
 1 files changed, 119 insertions(+), 115 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 6902524..17afa8c 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -21,6 +21,8 @@
  * you're going by the schematic, the pin is called "P19J-K22".
  */
 
+/dts-v1/;
+
 / {
 	model = "MPC8323EMDS";
 	compatible = "MPC8323EMDS", "MPC832xMDS", "MPC83xxMDS";
@@ -42,10 +44,10 @@
 		PowerPC,8323@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
-			d-cache-size = <4000>;		// L1, 16K
-			i-cache-size = <4000>;		// L1, 16K
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <16384>;		// L1, 16K
+			i-cache-size = <16384>;		// L1, 16K
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
@@ -54,26 +56,26 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 08000000>;
+		reg = <0x00000000 0x08000000>;
 	};
 
 	bcsr@f8000000 {
 		device_type = "board-control";
-		reg = <f8000000 8000>;
+		reg = <0xf8000000 0x8000>;
 	};
 
 	soc8323@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		ranges = <0 e0000000 00100000>;
-		reg = <e0000000 00000200>;
-		bus-frequency = <7DE2900>;
+		ranges = <0x0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00000200>;
+		bus-frequency = <132000000>;
 
 		wdt@200 {
 			device_type = "watchdog";
 			compatible = "mpc83xx_wdt";
-			reg = <200 100>;
+			reg = <0x200 0x100>;
 		};
 
 		i2c@3000 {
@@ -81,14 +83,14 @@
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
 
@@ -96,46 +98,46 @@
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
 
 		crypto@30000 {
 			device_type = "crypto";
 			model = "SEC2";
 			compatible = "talitos";
-			reg = <30000 7000>;
-			interrupts = <b 8>;
-			interrupt-parent = < &ipic >;
+			reg = <0x30000 0x7000>;
+			interrupts = <11 0x8>;
+			interrupt-parent = <&ipic>;
 			/* Rev. 2.2 */
 			num-channels = <1>;
-			channel-fifo-len = <18>;
-			exec-units-mask = <0000004c>;
-			descriptor-types-mask = <0122003f>;
+			channel-fifo-len = <0x18>;
+			exec-units-mask = <0x0000004c>;
+			descriptor-types-mask = <0x0122003f>;
 		};
 
 		ipic: pic@700 {
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
-			reg = <700 100>;
+			reg = <0x700 0x100>;
 			device_type = "ipic";
 		};
 
 		par_io@1400 {
-			reg = <1400 100>;
+			reg = <0x1400 0x100>;
 			device_type = "par_io";
 			num-ports = <7>;
 
@@ -144,8 +146,8 @@
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					3  4  3  0  2  0  /* MDIO */
 					3  5  1  0  2  0  /* MDC */
-					0  d  2  0  1  0 	/* RX_CLK (CLK9) */
-					3 18  2  0  1  0 	/* TX_CLK (CLK10) */
+					0 13  2  0  1  0 	/* RX_CLK (CLK9) */
+					3 24  2  0  1  0 	/* TX_CLK (CLK10) */
 					1  0  1  0  1  0 	/* TxD0 */
 					1  1  1  0  1  0 	/* TxD1 */
 					1  2  1  0  1  0 	/* TxD2 */
@@ -156,30 +158,30 @@
 					1  7  2  0  1  0 	/* RxD3 */
 					1  8  2  0  1  0 	/* RX_ER */
 					1  9  1  0  1  0 	/* TX_ER */
-					1  a  2  0  1  0 	/* RX_DV */
-					1  b  2  0  1  0 	/* COL */
-					1  c  1  0  1  0 	/* TX_EN */
-					1  d  2  0  1  0>;/* CRS */
+					1 10  2  0  1  0 	/* RX_DV */
+					1 11  2  0  1  0 	/* COL */
+					1 12  1  0  1  0 	/* TX_EN */
+					1 13  2  0  1  0>;	/* CRS */
 			};
 			pio4: ucc_pin@04 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
-					3 1f  2  0  1  0 	/* RX_CLK (CLK7) */
+					3 31  2  0  1  0 	/* RX_CLK (CLK7) */
 					3  6  2  0  1  0 	/* TX_CLK (CLK8) */
-					1 12  1  0  1  0 	/* TxD0 */
-					1 13  1  0  1  0 	/* TxD1 */
-					1 14  1  0  1  0 	/* TxD2 */
-					1 15  1  0  1  0 	/* TxD3 */
-					1 16  2  0  1  0 	/* RxD0 */
-					1 17  2  0  1  0 	/* RxD1 */
-					1 18  2  0  1  0 	/* RxD2 */
-					1 19  2  0  1  0 	/* RxD3 */
-					1 1a  2  0  1  0 	/* RX_ER */
-					1 1b  1  0  1  0 	/* TX_ER */
-					1 1c  2  0  1  0 	/* RX_DV */
-					1 1d  2  0  1  0 	/* COL */
-					1 1e  1  0  1  0 	/* TX_EN */
-					1 1f  2  0  1  0>;/* CRS */
+					1 18  1  0  1  0 	/* TxD0 */
+					1 19  1  0  1  0 	/* TxD1 */
+					1 20  1  0  1  0 	/* TxD2 */
+					1 21  1  0  1  0 	/* TxD3 */
+					1 22  2  0  1  0 	/* RxD0 */
+					1 23  2  0  1  0 	/* RxD1 */
+					1 24  2  0  1  0 	/* RxD2 */
+					1 25  2  0  1  0 	/* RxD3 */
+					1 26  2  0  1  0 	/* RX_ER */
+					1 27  1  0  1  0 	/* TX_ER */
+					1 28  2  0  1  0 	/* RX_DV */
+					1 29  2  0  1  0 	/* COL */
+					1 30  1  0  1  0 	/* TX_EN */
+					1 31  2  0  1  0>;	/* CRS */
 			};
 			pio5: ucc_pin@05 {
 				pio-map = <
@@ -207,43 +209,45 @@
 		device_type = "qe";
 		compatible = "fsl,qe";
 		model = "QE";
-		ranges = <0 e0100000 00100000>;
-		reg = <e0100000 480>;
+		ranges = <0x0 0xe0100000 0x00100000>;
+		reg = <0xe0100000 0x480>;
 		brg-frequency = <0>;
-		bus-frequency = <BCD3D80>;
+		bus-frequency = <198000000>;
 
 		muram@10000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			device_type = "muram";
-			ranges = <0 00010000 00004000>;
+			ranges = <0x0 0x00010000 0x00004000>;
 
 			data-only@0 {
-				reg = <0 4000>;
+				reg = <0x0 0x4000>;
 			};
 		};
 
 		spi@4c0 {
 			device_type = "spi";
 			compatible = "fsl_spi";
-			reg = <4c0 40>;
+			reg = <0x4c0 0x40>;
 			interrupts = <2>;
-			interrupt-parent = < &qeic >;
+			interrupt-parent = <&qeic>;
 			mode = "cpu";
 		};
 
 		spi@500 {
 			device_type = "spi";
 			compatible = "fsl_spi";
-			reg = <500 40>;
+			reg = <0x500 0x40>;
 			interrupts = <1>;
-			interrupt-parent = < &qeic >;
+			interrupt-parent = <&qeic>;
 			mode = "cpu";
 		};
 
 		usb@6c0 {
 			compatible = "qe_udc";
-			reg = <6c0 40 8B00 100>;
-			interrupts = <b>;
-			interrupt-parent = < &qeic >;
+			reg = <0x6c0 0x40 0x8b00 0x100>;
+			interrupts = <11>;
+			interrupt-parent = <&qeic>;
 			mode = "slave";
 		};
 
@@ -253,14 +257,14 @@
 			model = "UCC";
 			cell-index = <3>;
 			device-id = <3>;
-			reg = <2200 200>;
-			interrupts = <22>;
-			interrupt-parent = < &qeic >;
+			reg = <0x2200 0x200>;
+			interrupts = <34>;
+			interrupt-parent = <&qeic>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock-name = "clk9";
 			tx-clock-name = "clk10";
-			phy-handle = < &phy3 >;
-			pio-handle = < &pio3 >;
+			phy-handle = <&phy3>;
+			pio-handle = <&pio3>;
 		};
 
 		enet1: ucc@3200 {
@@ -269,14 +273,14 @@
 			model = "UCC";
 			cell-index = <4>;
 			device-id = <4>;
-			reg = <3200 200>;
-			interrupts = <23>;
-			interrupt-parent = < &qeic >;
+			reg = <0x3200 0x200>;
+			interrupts = <35>;
+			interrupt-parent = <&qeic>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock-name = "clk7";
 			tx-clock-name = "clk8";
-			phy-handle = < &phy4 >;
-			pio-handle = < &pio4 >;
+			phy-handle = <&phy4>;
+			pio-handle = <&pio4>;
 		};
 
 		ucc@2400 {
@@ -302,19 +306,19 @@
 		mdio@2320 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <2320 18>;
+			reg = <0x2320 0x18>;
 			device_type = "mdio";
 			compatible = "ucc_geth_phy";
 
 			phy3: ethernet-phy@03 {
-				interrupt-parent = < &ipic >;
-				interrupts = <11 8>;
+				interrupt-parent = <&ipic>;
+				interrupts = <17 0x8>;
 				reg = <3>;
 				device_type = "ethernet-phy";
 			};
 			phy4: ethernet-phy@04 {
-				interrupt-parent = < &ipic >;
-				interrupts = <12 8>;
+				interrupt-parent = <&ipic>;
+				interrupts = <18 0x8>;
 				reg = <4>;
 				device_type = "ethernet-phy";
 			};
@@ -325,69 +329,69 @@
 			device_type = "qeic";
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
-			reg = <80 80>;
+			reg = <0x80 0x80>;
 			big-endian;
-			interrupts = <20 8 21 8>; //high:32 low:33
-			interrupt-parent = < &ipic >;
+			interrupts = <32 0x8 33 0x8>; //high:32 low:33
+			interrupt-parent = <&ipic>;
 		};
 	};
 
 	pci0: pci@e0008500 {
 		cell-index = <1>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 				/* IDSEL 0x11 AD17 */
-				 8800 0 0 1 &ipic 14 8
-				 8800 0 0 2 &ipic 15 8
-				 8800 0 0 3 &ipic 16 8
-				 8800 0 0 4 &ipic 17 8
+				 0x8800 0x0 0x0 0x1 &ipic 20 0x8
+				 0x8800 0x0 0x0 0x2 &ipic 21 0x8
+				 0x8800 0x0 0x0 0x3 &ipic 22 0x8
+				 0x8800 0x0 0x0 0x4 &ipic 23 0x8
 
 				/* IDSEL 0x12 AD18 */
-				 9000 0 0 1 &ipic 16 8
-				 9000 0 0 2 &ipic 17 8
-				 9000 0 0 3 &ipic 14 8
-				 9000 0 0 4 &ipic 15 8
+				 0x9000 0x0 0x0 0x1 &ipic 22 0x8
+				 0x9000 0x0 0x0 0x2 &ipic 23 0x8
+				 0x9000 0x0 0x0 0x3 &ipic 20 0x8
+				 0x9000 0x0 0x0 0x4 &ipic 21 0x8
 
 				/* IDSEL 0x13 AD19 */
-				 9800 0 0 1 &ipic 17 8
-				 9800 0 0 2 &ipic 14 8
-				 9800 0 0 3 &ipic 15 8
-				 9800 0 0 4 &ipic 16 8
+				 0x9800 0x0 0x0 0x1 &ipic 23 0x8
+				 0x9800 0x0 0x0 0x2 &ipic 20 0x8
+				 0x9800 0x0 0x0 0x3 &ipic 21 0x8
+				 0x9800 0x0 0x0 0x4 &ipic 22 0x8
 
 				/* IDSEL 0x15 AD21*/
-				 a800 0 0 1 &ipic 14 8
-				 a800 0 0 2 &ipic 15 8
-				 a800 0 0 3 &ipic 16 8
-				 a800 0 0 4 &ipic 17 8
+				 0xa800 0x0 0x0 0x1 &ipic 20 0x8
+				 0xa800 0x0 0x0 0x2 &ipic 21 0x8
+				 0xa800 0x0 0x0 0x3 &ipic 22 0x8
+				 0xa800 0x0 0x0 0x4 &ipic 23 0x8
 
 				/* IDSEL 0x16 AD22*/
-				 b000 0 0 1 &ipic 17 8
-				 b000 0 0 2 &ipic 14 8
-				 b000 0 0 3 &ipic 15 8
-				 b000 0 0 4 &ipic 16 8
+				 0xb000 0x0 0x0 0x1 &ipic 23 0x8
+				 0xb000 0x0 0x0 0x2 &ipic 20 0x8
+				 0xb000 0x0 0x0 0x3 &ipic 21 0x8
+				 0xb000 0x0 0x0 0x4 &ipic 22 0x8
 
 				/* IDSEL 0x17 AD23*/
-				 b800 0 0 1 &ipic 16 8
-				 b800 0 0 2 &ipic 17 8
-				 b800 0 0 3 &ipic 14 8
-				 b800 0 0 4 &ipic 15 8
+				 0xb800 0x0 0x0 0x1 &ipic 22 0x8
+				 0xb800 0x0 0x0 0x2 &ipic 23 0x8
+				 0xb800 0x0 0x0 0x3 &ipic 20 0x8
+				 0xb800 0x0 0x0 0x4 &ipic 21 0x8
 
 				/* IDSEL 0x18 AD24*/
-				 c000 0 0 1 &ipic 15 8
-				 c000 0 0 2 &ipic 16 8
-				 c000 0 0 3 &ipic 17 8
-				 c000 0 0 4 &ipic 14 8>;
-		interrupt-parent = < &ipic >;
-		interrupts = <42 8>;
-		bus-range = <0 0>;
-		ranges = <02000000 0 90000000 90000000 0 10000000
-			  42000000 0 80000000 80000000 0 10000000
-			  01000000 0 00000000 d0000000 0 00100000>;
+				 0xc000 0x0 0x0 0x1 &ipic 21 0x8
+				 0xc000 0x0 0x0 0x2 &ipic 22 0x8
+				 0xc000 0x0 0x0 0x3 &ipic 23 0x8
+				 0xc000 0x0 0x0 0x4 &ipic 20 0x8>;
+		interrupt-parent = <&ipic>;
+		interrupts = <66 0x8>;
+		bus-range = <0x0 0x0>;
+		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
+			  0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xd0000000 0x0 0x00100000>;
 		clock-frequency = <0>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <e0008500 100>;
+		reg = <0xe0008500 0x100>;
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
-- 
1.5.4.rc4.gcab31
