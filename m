Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id B4A9ADDD0A
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 18:28:06 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/9] mpc836x: Convert mpc836x_mds to dts-v1 format.
Date: Mon, 28 Jan 2008 02:27:54 -0500
Message-Id: <1d2d2df57a47cff00d8539194b0c997175d18170.1201503958.git.paul.gortmaker@windriver.com>
In-Reply-To: <d8e187e4d4aa981109450f333658730e3408f627.1201503958.git.paul.gortmaker@windriver.com>
References: <1201505279-25847-1-git-send-email-paul.gortmaker@windriver.com>
	<a050480a21aef92854805e9bee517c0d65d5bd59.1201503958.git.paul.gortmaker@windriver.com>
	<51b1015cd61540df832ee5d5ee125e7326c3f0ed.1201503958.git.paul.gortmaker@windriver.com>
	<d8e187e4d4aa981109450f333658730e3408f627.1201503958.git.paul.gortmaker@windriver.com>
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

Convert the MPC836x MDS dts file to v1 format.  Entries for
values normally parsed by humans are left in decimal (i.e. IRQ,
cache size, clock rates, basic counts and index values).

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/mpc836x_mds.dts |  254 +++++++++++++++++----------------
 1 files changed, 128 insertions(+), 126 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 10b5d6d..4260f09 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -14,6 +14,8 @@
 /memreserve/	00000000 1000000;
 */
 
+/dts-v1/;
+
 / {
 	model = "MPC8360MDS";
 	compatible = "MPC8360EMDS", "MPC836xMDS", "MPC83xxMDS";
@@ -35,38 +37,38 @@
 		PowerPC,8360@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
-			d-cache-size = <8000>;		// L1, 32K
-			i-cache-size = <8000>;		// L1, 32K
-			timebase-frequency = <3EF1480>;
-			bus-frequency = <FBC5200>;
-			clock-frequency = <1F78A400>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
+			timebase-frequency = <66000000>;
+			bus-frequency = <264000000>;
+			clock-frequency = <528000000>;
 		};
 	};
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 10000000>;
+		reg = <0x00000000 0x10000000>;
 	};
 
 	bcsr@f8000000 {
 		device_type = "board-control";
-		reg = <f8000000 8000>;
+		reg = <0xf8000000 0x8000>;
 	};
 
 	soc8360@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		ranges = <0 e0000000 00100000>;
-		reg = <e0000000 00000200>;
-		bus-frequency = <FBC5200>;
+		ranges = <0x0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00000200>;
+		bus-frequency = <264000000>;
 
 		wdt@200 {
 			device_type = "watchdog";
 			compatible = "mpc83xx_wdt";
-			reg = <200 100>;
+			reg = <0x200 0x100>;
 		};
 
 		i2c@3000 {
@@ -74,14 +76,14 @@
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
 
@@ -90,9 +92,9 @@
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
 
@@ -100,46 +102,46 @@
 			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4500 100>;
-			clock-frequency = <FBC5200>;
-			interrupts = <9 8>;
-			interrupt-parent = < &ipic >;
+			reg = <0x4500 0x100>;
+			clock-frequency = <264000000>;
+			interrupts = <9 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4600 100>;
-			clock-frequency = <FBC5200>;
-			interrupts = <a 8>;
-			interrupt-parent = < &ipic >;
+			reg = <0x4600 0x100>;
+			clock-frequency = <264000000>;
+			interrupts = <10 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		crypto@30000 {
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
 			/* desc mask is for rev1.x, we need runtime fixup for >=2.x */
-			descriptor-types-mask = <01010ebf>;
+			descriptor-types-mask = <0x01010ebf>;
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
 
@@ -153,19 +155,19 @@
 					1  6  1  0  3  0 	/* TxD4 */
 					1  7  1  0  1  0 	/* TxD5 */
 					1  9  1  0  2  0 	/* TxD6 */
-					1  a  1  0  2  0 	/* TxD7 */
+					1  10 1  0  2  0 	/* TxD7 */
 					0  9  2  0  1  0 	/* RxD0 */
-					0  a  2  0  1  0 	/* RxD1 */
-					0  b  2  0  1  0 	/* RxD2 */
-					0  c  2  0  1  0 	/* RxD3 */
-					0  d  2  0  1  0 	/* RxD4 */
+					0  10 2  0  1  0 	/* RxD1 */
+					0  11 2  0  1  0 	/* RxD2 */
+					0  12 2  0  1  0 	/* RxD3 */
+					0  13 2  0  1  0 	/* RxD4 */
 					1  1  2  0  2  0 	/* RxD5 */
 					1  0  2  0  2  0 	/* RxD6 */
 					1  4  2  0  2  0 	/* RxD7 */
 					0  7  1  0  1  0 	/* TX_EN */
 					0  8  1  0  1  0 	/* TX_ER */
-					0  f  2  0  1  0 	/* RX_DV */
-					0  10 2  0  1  0 	/* RX_ER */
+					0  15 2  0  1  0 	/* RX_DV */
+					0  16 2  0  1  0 	/* RX_ER */
 					0  0  2  0  1  0 	/* RX_CLK */
 					2  9  1  0  3  0 	/* GTX_CLK - CLK10 */
 					2  8  2  0  1  0>;	/* GTX125 - CLK9 */
@@ -173,27 +175,27 @@
 			pio2: ucc_pin@02 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
-					0  11 1  0  1  0   /* TxD0 */
-					0  12 1  0  1  0   /* TxD1 */
-					0  13 1  0  1  0   /* TxD2 */
-					0  14 1  0  1  0   /* TxD3 */
+					0  17 1  0  1  0   /* TxD0 */
+					0  18 1  0  1  0   /* TxD1 */
+					0  19 1  0  1  0   /* TxD2 */
+					0  20 1  0  1  0   /* TxD3 */
 					1  2  1  0  1  0   /* TxD4 */
 					1  3  1  0  2  0   /* TxD5 */
 					1  5  1  0  3  0   /* TxD6 */
 					1  8  1  0  3  0   /* TxD7 */
-					0  17 2  0  1  0   /* RxD0 */
-					0  18 2  0  1  0   /* RxD1 */
-					0  19 2  0  1  0   /* RxD2 */
-					0  1a 2  0  1  0   /* RxD3 */
-					0  1b 2  0  1  0   /* RxD4 */
-					1  c  2  0  2  0   /* RxD5 */
-					1  d  2  0  3  0   /* RxD6 */
-					1  b  2  0  2  0   /* RxD7 */
-					0  15 1  0  1  0   /* TX_EN */
-					0  16 1  0  1  0   /* TX_ER */
-					0  1d 2  0  1  0   /* RX_DV */
-					0  1e 2  0  1  0   /* RX_ER */
-					0  1f 2  0  1  0   /* RX_CLK */
+					0  23 2  0  1  0   /* RxD0 */
+					0  24 2  0  1  0   /* RxD1 */
+					0  25 2  0  1  0   /* RxD2 */
+					0  26 2  0  1  0   /* RxD3 */
+					0  27 2  0  1  0   /* RxD4 */
+					1  12 2  0  2  0   /* RxD5 */
+					1  13 2  0  3  0   /* RxD6 */
+					1  11 2  0  2  0   /* RxD7 */
+					0  21 1  0  1  0   /* TX_EN */
+					0  22 1  0  1  0   /* TX_ER */
+					0  29 2  0  1  0   /* RX_DV */
+					0  30 2  0  1  0   /* RX_ER */
+					0  31 2  0  1  0   /* RX_CLK */
 					2  2  1  0  2  0   /* GTX_CLK - CLK10 */
 					2  3  2  0  1  0   /* GTX125 - CLK4 */
 					0  1  3  0  2  0   /* MDIO */
@@ -208,45 +210,45 @@
 		#size-cells = <1>;
 		device_type = "qe";
 		model = "QE";
-		ranges = <0 e0100000 00100000>;
-		reg = <e0100000 480>;
+		ranges = <0x0 0xe0100000 0x00100000>;
+		reg = <0xe0100000 0x480>;
 		brg-frequency = <0>;
-		bus-frequency = <179A7B00>;
+		bus-frequency = <396000000>;
 
 		muram@10000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			device_type = "muram";
-			ranges = <0 00010000 0000c000>;
+			ranges = <0x0 0x00010000 0x0000c000>;
 
 			data-only@0 {
-				reg = <0 c000>;
+				reg = <0x0 0xc000>;
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
 
@@ -256,15 +258,15 @@
 			model = "UCC";
 			cell-index = <1>;
 			device-id = <1>;
-			reg = <2000 200>;
-			interrupts = <20>;
-			interrupt-parent = < &qeic >;
+			reg = <0x2000 0x200>;
+			interrupts = <32>;
+			interrupt-parent = <&qeic>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock-name = "none";
 			tx-clock-name = "clk9";
-			phy-handle = < &phy0 >;
+			phy-handle = <&phy0>;
 			phy-connection-type = "rgmii-id";
-			pio-handle = < &pio1 >;
+			pio-handle = <&pio1>;
 		};
 
 		enet1: ucc@3000 {
@@ -273,33 +275,33 @@
 			model = "UCC";
 			cell-index = <2>;
 			device-id = <2>;
-			reg = <3000 200>;
-			interrupts = <21>;
-			interrupt-parent = < &qeic >;
+			reg = <0x3000 0x200>;
+			interrupts = <33>;
+			interrupt-parent = <&qeic>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock-name = "none";
 			tx-clock-name = "clk4";
-			phy-handle = < &phy1 >;
+			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
-			pio-handle = < &pio2 >;
+			pio-handle = <&pio2>;
 		};
 
 		mdio@2120 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <2120 18>;
+			reg = <0x2120 0x18>;
 			device_type = "mdio";
 			compatible = "ucc_geth_phy";
 
 			phy0: ethernet-phy@00 {
-				interrupt-parent = < &ipic >;
-				interrupts = <11 8>;
+				interrupt-parent = <&ipic>;
+				interrupts = <17 0x8>;
 				reg = <0>;
 				device_type = "ethernet-phy";
 			};
 			phy1: ethernet-phy@01 {
-				interrupt-parent = < &ipic >;
-				interrupts = <12 8>;
+				interrupt-parent = <&ipic>;
+				interrupts = <18 0x8>;
 				reg = <1>;
 				device_type = "ethernet-phy";
 			};
@@ -310,70 +312,70 @@
 			device_type = "qeic";
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
-			reg = <80 80>;
+			reg = <0x80 0x80>;
 			big-endian;
-			interrupts = <20 8 21 8>; //high:32 low:33
-			interrupt-parent = < &ipic >;
+			interrupts = <32 0x8 33 0x8>; // high:32 low:33
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
+				 0xc000 0x0 0x0 0x1 &ipic 21 0x8
+				 0xc000 0x0 0x0 0x2 &ipic 22 0x8
+				 0xc000 0x0 0x0 0x3 &ipic 23 0x8
+				 0xc000 0x0 0x0 0x4 &ipic 20 0x8>;
+		interrupt-parent = <&ipic>;
+		interrupts = <66 0x8>;
 		bus-range = <0 0>;
-		ranges = <02000000 0 a0000000 a0000000 0 10000000
-			  42000000 0 80000000 80000000 0 10000000
-			  01000000 0 00000000 e2000000 0 00100000>;
-		clock-frequency = <3f940aa>;
+		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
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
-- 
1.5.4.rc4.gcab31
