Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 3B97ADDDE9
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 18:28:07 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/9] mpc832x_rdb: Convert mpc832x_rdb to dts-v1 format.
Date: Mon, 28 Jan 2008 02:27:56 -0500
Message-Id: <53bbf9975296ba5dc57c68305079dc90d8d8a348.1201503958.git.paul.gortmaker@windriver.com>
In-Reply-To: <fa3dbfb49842f4553d619b1cf209102ca2457d62.1201503958.git.paul.gortmaker@windriver.com>
References: <1201505279-25847-1-git-send-email-paul.gortmaker@windriver.com>
	<a050480a21aef92854805e9bee517c0d65d5bd59.1201503958.git.paul.gortmaker@windriver.com>
	<51b1015cd61540df832ee5d5ee125e7326c3f0ed.1201503958.git.paul.gortmaker@windriver.com>
	<d8e187e4d4aa981109450f333658730e3408f627.1201503958.git.paul.gortmaker@windriver.com>
	<1d2d2df57a47cff00d8539194b0c997175d18170.1201503958.git.paul.gortmaker@windriver.com>
	<fa3dbfb49842f4553d619b1cf209102ca2457d62.1201503958.git.paul.gortmaker@windriver.com>
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

Convert the MPC832x RDB dts file to v1 format.  Entries for
values normally parsed by humans are left in decimal (i.e. IRQ,
cache size, clock rates, basic counts and index values).

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/mpc832x_rdb.dts |  150 +++++++++++++++++----------------
 1 files changed, 77 insertions(+), 73 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 10ff7aa..77adc18 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -9,6 +9,8 @@
  * option) any later version.
  */
 
+/dts-v1/;
+
 / {
 	model = "MPC8323ERDB";
 	compatible = "MPC8323ERDB", "MPC832xRDB", "MPC83xxRDB";
@@ -30,10 +32,10 @@
 		PowerPC,8323@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
-			d-cache-size = <4000>;		// L1, 16K
-			i-cache-size = <4000>;		// L1, 16K
+			d-cache-line-size = <0x20>;	// 32 bytes
+			i-cache-line-size = <0x20>;	// 32 bytes
+			d-cache-size = <16384>;	// L1, 16K
+			i-cache-size = <16384>;	// L1, 16K
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
@@ -42,21 +44,21 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 04000000>;
+		reg = <0x00000000 0x04000000>;
 	};
 
 	soc8323@e0000000 {
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
@@ -64,8 +66,8 @@
 			#size-cells = <0>;
 			cell-index = <0>;
 			compatible = "fsl-i2c";
-			reg = <3000 100>;
-			interrupts = <e 8>;
+			reg = <0x3000 0x100>;
+			interrupts = <14 0x8>;
 			interrupt-parent = <&pic>;
 			dfsrr;
 		};
@@ -74,9 +76,9 @@
 			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4500 100>;
+			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <9 8>;
+			interrupts = <9 0x8>;
 			interrupt-parent = <&pic>;
 		};
 
@@ -84,9 +86,9 @@
 			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4600 100>;
+			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <a 8>;
+			interrupts = <10 0x8>;
 			interrupt-parent = <&pic>;
 		};
 
@@ -94,26 +96,26 @@
 			device_type = "crypto";
 			model = "SEC2";
 			compatible = "talitos";
-			reg = <30000 7000>;
-			interrupts = <b 8>;
+			reg = <0x30000 0x7000>;
+			interrupts = <11 0x8>;
 			interrupt-parent = <&pic>;
 			/* Rev. 2.2 */
 			num-channels = <1>;
-			channel-fifo-len = <18>;
-			exec-units-mask = <0000004c>;
-			descriptor-types-mask = <0122003f>;
+			channel-fifo-len = <0x18>;
+			exec-units-mask = <0x0000004c>;
+			descriptor-types-mask = <0x0122003f>;
 		};
 
 		pic:pic@700 {
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
 
@@ -122,28 +124,28 @@
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					3  4  3  0  2  0 	/* MDIO */
 					3  5  1  0  2  0 	/* MDC */
-					3 15  2  0  1  0 	/* RX_CLK (CLK16) */
-					3 17  2  0  1  0 	/* TX_CLK (CLK3) */
-					0 12  1  0  1  0 	/* TxD0 */
-					0 13  1  0  1  0 	/* TxD1 */
-					0 14  1  0  1  0 	/* TxD2 */
-					0 15  1  0  1  0 	/* TxD3 */
-					0 16  2  0  1  0 	/* RxD0 */
-					0 17  2  0  1  0 	/* RxD1 */
-					0 18  2  0  1  0 	/* RxD2 */
-					0 19  2  0  1  0 	/* RxD3 */
-					0 1a  2  0  1  0 	/* RX_ER */
-					0 1b  1  0  1  0 	/* TX_ER */
-					0 1c  2  0  1  0 	/* RX_DV */
-					0 1d  2  0  1  0 	/* COL */
-					0 1e  1  0  1  0 	/* TX_EN */
-					0 1f  2  0  1  0>;      /* CRS */
+					3 21  2  0  1  0 	/* RX_CLK (CLK16) */
+					3 23  2  0  1  0 	/* TX_CLK (CLK3) */
+					0 18  1  0  1  0 	/* TxD0 */
+					0 19  1  0  1  0 	/* TxD1 */
+					0 20  1  0  1  0 	/* TxD2 */
+					0 21  1  0  1  0 	/* TxD3 */
+					0 22  2  0  1  0 	/* RxD0 */
+					0 23  2  0  1  0 	/* RxD1 */
+					0 24  2  0  1  0 	/* RxD2 */
+					0 25  2  0  1  0 	/* RxD3 */
+					0 26  2  0  1  0 	/* RX_ER */
+					0 27  1  0  1  0 	/* TX_ER */
+					0 28  2  0  1  0 	/* RX_DV */
+					0 29  2  0  1  0 	/* COL */
+					0 30  1  0  1  0 	/* TX_EN */
+					0 31  2  0  1  0>;      /* CRS */
 			};
 			ucc3pio:ucc_pin@03 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
-					0  d  2  0  1  0 	/* RX_CLK (CLK9) */
-					3 18  2  0  1  0 	/* TX_CLK (CLK10) */
+					0 13  2  0  1  0 	/* RX_CLK (CLK9) */
+					3 24  2  0  1  0 	/* TX_CLK (CLK10) */
 					1  0  1  0  1  0 	/* TxD0 */
 					1  1  1  0  1  0 	/* TxD1 */
 					1  2  1  0  1  0 	/* TxD2 */
@@ -154,10 +156,10 @@
 					1  7  2  0  1  0 	/* RxD3 */
 					1  8  2  0  1  0 	/* RX_ER */
 					1  9  1  0  1  0 	/* TX_ER */
-					1  a  2  0  1  0 	/* RX_DV */
-					1  b  2  0  1  0 	/* COL */
-					1  c  1  0  1  0 	/* TX_EN */
-					1  d  2  0  1  0>;      /* CRS */
+					1 10  2  0  1  0 	/* RX_DV */
+					1 11  2  0  1  0 	/* COL */
+					1 12  1  0  1  0 	/* TX_EN */
+					1 13  2  0  1  0>;      /* CRS */
 			};
 		};
 	};
@@ -167,24 +169,26 @@
 		#size-cells = <1>;
 		device_type = "qe";
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
 			interrupt-parent = <&qeic>;
 			mode = "cpu-qe";
@@ -193,7 +197,7 @@
 		spi@500 {
 			device_type = "spi";
 			compatible = "fsl_spi";
-			reg = <500 40>;
+			reg = <0x500 0x40>;
 			interrupts = <1>;
 			interrupt-parent = <&qeic>;
 			mode = "cpu";
@@ -205,8 +209,8 @@
 			model = "UCC";
 			cell-index = <2>;
 			device-id = <2>;
-			reg = <3000 200>;
-			interrupts = <21>;
+			reg = <0x3000 0x200>;
+			interrupts = <33>;
 			interrupt-parent = <&qeic>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock-name = "clk16";
@@ -221,8 +225,8 @@
 			model = "UCC";
 			cell-index = <3>;
 			device-id = <3>;
-			reg = <2200 200>;
-			interrupts = <22>;
+			reg = <0x2200 0x200>;
+			interrupts = <34>;
 			interrupt-parent = <&qeic>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock-name = "clk9";
@@ -234,7 +238,7 @@
 		mdio@3120 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <3120 18>;
+			reg = <0x3120 0x18>;
 			device_type = "mdio";
 			compatible = "ucc_geth_phy";
 
@@ -257,43 +261,43 @@
 			device_type = "qeic";
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
-			reg = <80 80>;
+			reg = <0x80 0x80>;
 			big-endian;
-			interrupts = <20 8 21 8>; //high:32 low:33
+			interrupts = <32 0x8 33 0x8>; //high:32 low:33
 			interrupt-parent = <&pic>;
 		};
 	};
 
 	pci0: pci@e0008500 {
 		cell-index = <1>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 				/* IDSEL 0x10 AD16 (USB) */
-				 8000 0 0 1 &pic 11 8
+				 0x8000 0x0 0x0 0x1 &pic 17 0x8
 
 				/* IDSEL 0x11 AD17 (Mini1)*/
-				 8800 0 0 1 &pic 12 8
-				 8800 0 0 2 &pic 13 8
-				 8800 0 0 3 &pic 14 8
-				 8800 0 0 4 &pic 30 8
+				 0x8800 0x0 0x0 0x1 &pic 18 0x8
+				 0x8800 0x0 0x0 0x2 &pic 19 0x8
+				 0x8800 0x0 0x0 0x3 &pic 20 0x8
+				 0x8800 0x0 0x0 0x4 &pic 48 0x8
 
 				/* IDSEL 0x12 AD18 (PCI/Mini2) */
-				 9000 0 0 1 &pic 13 8
-				 9000 0 0 2 &pic 14 8
-				 9000 0 0 3 &pic 30 8
-				 9000 0 0 4 &pic 11 8>;
+				 0x9000 0x0 0x0 0x1 &pic 19 0x8
+				 0x9000 0x0 0x0 0x2 &pic 20 0x8
+				 0x9000 0x0 0x0 0x3 &pic 48 0x8
+				 0x9000 0x0 0x0 0x4 &pic 17 0x8>;
 
 		interrupt-parent = <&pic>;
-		interrupts = <42 8>;
-		bus-range = <0 0>;
-		ranges = <42000000 0 80000000 80000000 0 10000000
-			  02000000 0 90000000 90000000 0 10000000
-			  01000000 0 d0000000 d0000000 0 04000000>;
+		interrupts = <66 0x8>;
+		bus-range = <0x0 0x0>;
+		ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+			  0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
+			  0x01000000 0x0 0xd0000000 0xd0000000 0x0 0x04000000>;
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
