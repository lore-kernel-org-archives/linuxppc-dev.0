Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C8790DDEEC
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 03:01:34 +1100 (EST)
Date: Fri, 16 Feb 2007 09:58:32 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [POWERPC] 83xx: Cleaned up 83xx platform dts files
Message-ID: <Pine.LNX.4.64.0702160957400.10290@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Fixed up to level compatible property for all boards
* Removed explicit linux,phandle usage. Use references and labels now
* Fixed interrupt sense attribute, some interrupts were marked edge, that are level

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 15b69cc6800ec481e766279815b7cf20121148df
tree c1e15f94082f0e44986a5c6254a39c1bed978076
parent a32525449b30dfbae804f6b05cde041f35f5a811
author Kumar Gala <galak@kernel.crashing.org> Fri, 16 Feb 2007 09:57:22 -0600
committer Kumar Gala <galak@kernel.crashing.org> Fri, 16 Feb 2007 09:57:22 -0600

 arch/powerpc/boot/dts/mpc8313erdb.dts    |   62 +++++------
 arch/powerpc/boot/dts/mpc8323emds.dts    |  119 ++++++++++------------
 arch/powerpc/boot/dts/mpc8349emitx.dts   |   60 +++++------
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |   39 +++----
 arch/powerpc/boot/dts/mpc834x_mds.dts    |  164 +++++++++++++++---------------
 arch/powerpc/boot/dts/mpc8360emds.dts    |  123 ++++++++++-------------
 6 files changed, 265 insertions(+), 302 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 3d2f5a0..6d72190 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -11,7 +11,7 @@

 / {
 	model = "MPC8313ERDB";
-	compatible = "MPC83xx";
+	compatible = "MPC8313ERDB", "MPC831xRDB", "MPC83xxRDB";
 	#address-cells = <1>;
 	#size-cells = <1>;

@@ -59,7 +59,7 @@
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			dfsrr;
 		};

@@ -68,7 +68,7 @@
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
 			interrupts = <f 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			dfsrr;
 		};

@@ -77,7 +77,7 @@
 			compatible = "mpc83xx_spi";
 			reg = <7000 1000>;
 			interrupts = <10 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			mode = <0>;
 		};

@@ -88,8 +88,8 @@
 			reg = <23000 1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = <700>;
-			interrupts = <26 2>;
+			interrupt-parent = < &ipic >;
+			interrupts = <26 8>;
 			phy_type = "utmi_wide";
 		};

@@ -99,18 +99,15 @@
 			reg = <24520 20>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			linux,phandle = <24520>;
-			ethernet-phy@1 {
-				linux,phandle = <2452001>;
-				interrupt-parent = <700>;
-				interrupts = <13 2>;
+			phy1: ethernet-phy@1 {
+				interrupt-parent = < &ipic >;
+				interrupts = <13 8>;
 				reg = <1>;
 				device_type = "ethernet-phy";
 			};
-			ethernet-phy@4 {
-				linux,phandle = <2452004>;
-				interrupt-parent = <700>;
-				interrupts = <14 2>;
+			phy4: ethernet-phy@4 {
+				interrupt-parent = < &ipic >;
+				interrupts = <14 8>;
 				reg = <4>;
 				device_type = "ethernet-phy";
 			};
@@ -123,8 +120,8 @@
 			reg = <24000 1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <25 8 24 8 23 8>;
-			interrupt-parent = <700>;
-			phy-handle = <2452001>;
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy1 >;
 		};

 		ethernet@25000 {
@@ -134,8 +131,8 @@
 			reg = <25000 1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <22 8 21 8 20 8>;
-			interrupt-parent = <700>;
-			phy-handle = <2452004>;
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy4 >;
 		};

 		serial@4500 {
@@ -144,7 +141,7 @@
 			reg = <4500 100>;
 			clock-frequency = <0>;
 			interrupts = <9 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 		};

 		serial@4600 {
@@ -153,7 +150,7 @@
 			reg = <4600 100>;
 			clock-frequency = <0>;
 			interrupts = <a 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 		};

 		pci@8500 {
@@ -161,17 +158,17 @@
 			interrupt-map = <

 					/* IDSEL 0x0E -mini PCI */
-					 7000 0 0 1 700 12 8
-					 7000 0 0 2 700 12 8
-					 7000 0 0 3 700 12 8
-					 7000 0 0 4 700 12 8
+					 7000 0 0 1 &ipic 12 8
+					 7000 0 0 2 &ipic 12 8
+					 7000 0 0 3 &ipic 12 8
+					 7000 0 0 4 &ipic 12 8

 					/* IDSEL 0x0F - PCI slot */
-					 7800 0 0 1 700 11 8
-					 7800 0 0 2 700 12 8
-					 7800 0 0 3 700 11 8
-					 7800 0 0 4 700 12 8>;
-			interrupt-parent = <700>;
+					 7800 0 0 1 &ipic 11 8
+					 7800 0 0 2 &ipic 12 8
+					 7800 0 0 3 &ipic 11 8
+					 7800 0 0 4 &ipic 12 8>;
+			interrupt-parent = < &ipic >;
 			interrupts = <42 8>;
 			bus-range = <0 0>;
 			ranges = <02000000 0 90000000 90000000 0 10000000
@@ -192,7 +189,7 @@
 			compatible = "talitos";
 			reg = <30000 7000>;
 			interrupts = <b 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			/* Rev. 2.2 */
 			num-channels = <1>;
 			channel-fifo-len = <18>;
@@ -206,8 +203,7 @@
 		 * sense == 8: Level, low assertion
 		 * sense == 2: Edge, high-to-low change
 		 */
-		pic@700 {
-			linux,phandle = <700>;
+		ipic: pic@700 {
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
diff --git a/arch/powerpc/boot/dts/mpc8323emds.dts b/arch/powerpc/boot/dts/mpc8323emds.dts
index 57a3665..06b3106 100644
--- a/arch/powerpc/boot/dts/mpc8323emds.dts
+++ b/arch/powerpc/boot/dts/mpc8323emds.dts
@@ -11,16 +11,14 @@

 / {
 	model = "MPC8323EMDS";
-	compatible = "MPC83xx";
+	compatible = "MPC8323EMDS", "MPC832xMDS", "MPC83xxMDS";
 	#address-cells = <1>;
 	#size-cells = <1>;
-	linux,phandle = <100>;

 	cpus {
 		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		linux,phandle = <200>;

 		PowerPC,8323@0 {
 			device_type = "cpu";
@@ -33,13 +31,11 @@
 			bus-frequency = <0>;
 			clock-frequency = <0>;
 			32-bit;
-			linux,phandle = <201>;
 		};
 	};

 	memory {
 		device_type = "memory";
-		linux,phandle = <300>;
 		reg = <00000000 08000000>;
 	};

@@ -68,7 +64,7 @@
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			dfsrr;
 		};

@@ -78,7 +74,7 @@
 			reg = <4500 100>;
 			clock-frequency = <0>;
 			interrupts = <9 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 		};

 		serial@4600 {
@@ -87,7 +83,7 @@
 			reg = <4600 100>;
 			clock-frequency = <0>;
 			interrupts = <a 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 		};

 		crypto@30000 {
@@ -96,7 +92,7 @@
 			compatible = "talitos";
 			reg = <30000 7000>;
 			interrupts = <b 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			/* Rev. 2.2 */
 			num-channels = <1>;
 			channel-fifo-len = <18>;
@@ -105,51 +101,50 @@
 		};

 		pci@8500 {
-			linux,phandle = <8500>;
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
 					/* IDSEL 0x11 AD17 */
-					 8800 0 0 1 700 14 8
-					 8800 0 0 2 700 15 8
-					 8800 0 0 3 700 16 8
-					 8800 0 0 4 700 17 8
+					 8800 0 0 1 &ipic 14 8
+					 8800 0 0 2 &ipic 15 8
+					 8800 0 0 3 &ipic 16 8
+					 8800 0 0 4 &ipic 17 8

 					/* IDSEL 0x12 AD18 */
-					 9000 0 0 1 700 16 8
-					 9000 0 0 2 700 17 8
-					 9000 0 0 3 700 14 8
-					 9000 0 0 4 700 15 8
+					 9000 0 0 1 &ipic 16 8
+					 9000 0 0 2 &ipic 17 8
+					 9000 0 0 3 &ipic 14 8
+					 9000 0 0 4 &ipic 15 8

 					/* IDSEL 0x13 AD19 */
-					 9800 0 0 1 700 17 8
-					 9800 0 0 2 700 14 8
-					 9800 0 0 3 700 15 8
-					 9800 0 0 4 700 16 8
+					 9800 0 0 1 &ipic 17 8
+					 9800 0 0 2 &ipic 14 8
+					 9800 0 0 3 &ipic 15 8
+					 9800 0 0 4 &ipic 16 8

 					/* IDSEL 0x15 AD21*/
-					 a800 0 0 1 700 14 8
-					 a800 0 0 2 700 15 8
-					 a800 0 0 3 700 16 8
-					 a800 0 0 4 700 17 8
+					 a800 0 0 1 &ipic 14 8
+					 a800 0 0 2 &ipic 15 8
+					 a800 0 0 3 &ipic 16 8
+					 a800 0 0 4 &ipic 17 8

 					/* IDSEL 0x16 AD22*/
-					 b000 0 0 1 700 17 8
-					 b000 0 0 2 700 14 8
-					 b000 0 0 3 700 15 8
-					 b000 0 0 4 700 16 8
+					 b000 0 0 1 &ipic 17 8
+					 b000 0 0 2 &ipic 14 8
+					 b000 0 0 3 &ipic 15 8
+					 b000 0 0 4 &ipic 16 8

 					/* IDSEL 0x17 AD23*/
-					 b800 0 0 1 700 16 8
-					 b800 0 0 2 700 17 8
-					 b800 0 0 3 700 14 8
-					 b800 0 0 4 700 15 8
+					 b800 0 0 1 &ipic 16 8
+					 b800 0 0 2 &ipic 17 8
+					 b800 0 0 3 &ipic 14 8
+					 b800 0 0 4 &ipic 15 8

 					/* IDSEL 0x18 AD24*/
-					 c000 0 0 1 700 15 8
-					 c000 0 0 2 700 16 8
-					 c000 0 0 3 700 17 8
-					 c000 0 0 4 700 14 8>;
-			interrupt-parent = <700>;
+					 c000 0 0 1 &ipic 15 8
+					 c000 0 0 2 &ipic 16 8
+					 c000 0 0 3 &ipic 17 8
+					 c000 0 0 4 &ipic 14 8>;
+			interrupt-parent = < &ipic >;
 			interrupts = <42 8>;
 			bus-range = <0 0>;
 			ranges = <02000000 0 a0000000 90000000 0 10000000
@@ -164,8 +159,7 @@
 			device_type = "pci";
 		};

-		pic@700 {
-			linux,phandle = <700>;
+		ipic: pic@700 {
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
@@ -179,8 +173,7 @@
 			device_type = "par_io";
 			num-ports = <7>;

-			ucc_pin@03 {
-				linux,phandle = <140003>;
+			pio3: ucc_pin@03 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					3  4  3  0  2  0  /* MDIO */
@@ -203,8 +196,7 @@
 					1  c  1  0  1  0 	/* TX_EN */
 					1  d  2  0  1  0>;/* CRS */
 			};
-			ucc_pin@04 {
-				linux,phandle = <140004>;
+			pio4: ucc_pin@04 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					3 1f  2  0  1  0 	/* RX_CLK (CLK7) */
@@ -251,7 +243,7 @@
 			compatible = "fsl_spi";
 			reg = <4c0 40>;
 			interrupts = <2>;
-			interrupt-parent = <80>;
+			interrupt-parent = < &qeic >;
 			mode = "cpu";
 		};

@@ -260,7 +252,7 @@
 			compatible = "fsl_spi";
 			reg = <500 40>;
 			interrupts = <1>;
-			interrupt-parent = <80>;
+			interrupt-parent = < &qeic >;
 			mode = "cpu";
 		};

@@ -269,7 +261,7 @@
 			compatible = "qe_udc";
 			reg = <6c0 40 8B00 100>;
 			interrupts = <b>;
-			interrupt-parent = <80>;
+			interrupt-parent = < &qeic >;
 			mode = "slave";
 		};

@@ -280,12 +272,12 @@
 			device-id = <3>;
 			reg = <2200 200>;
 			interrupts = <22>;
-			interrupt-parent = <80>;
+			interrupt-parent = < &qeic >;
 			mac-address = [ 00 04 9f 00 23 23 ];
 			rx-clock = <19>;
 			tx-clock = <1a>;
-			phy-handle = <212003>;
-			pio-handle = <140003>;
+			phy-handle = < &phy3 >;
+			pio-handle = < &pio3 >;
 		};

 		ucc@3200 {
@@ -295,12 +287,12 @@
 			device-id = <4>;
 			reg = <3000 200>;
 			interrupts = <23>;
-			interrupt-parent = <80>;
+			interrupt-parent = < &qeic >;
 			mac-address = [ 00 11 22 33 44 55 ];
 			rx-clock = <17>;
 			tx-clock = <18>;
-			phy-handle = <212004>;
-			pio-handle = <140004>;
+			phy-handle = < &phy4 >;
+			pio-handle = < &pio4 >;
 		};

 		mdio@2320 {
@@ -310,26 +302,23 @@
 			device_type = "mdio";
 			compatible = "ucc_geth_phy";

-			ethernet-phy@03 {
-				linux,phandle = <212003>;
-				interrupt-parent = <700>;
-				interrupts = <11 2>;
+			phy3: ethernet-phy@03 {
+				interrupt-parent = < &ipic >;
+				interrupts = <11 8>;
 				reg = <3>;
 				device_type = "ethernet-phy";
 				interface = <3>; //ENET_100_MII
 			};
-			ethernet-phy@04 {
-				linux,phandle = <212004>;
-				interrupt-parent = <700>;
-				interrupts = <12 2>;
+			phy4: ethernet-phy@04 {
+				interrupt-parent = < &ipic >;
+				interrupts = <12 8>;
 				reg = <4>;
 				device_type = "ethernet-phy";
 				interface = <3>;
 			};
 		};

-		qeic@80 {
-			linux,phandle = <80>;
+		qeic: qeic@80 {
 			interrupt-controller;
 			device_type = "qeic";
 			#address-cells = <0>;
@@ -338,7 +327,7 @@
 			built-in;
 			big-endian;
 			interrupts = <20 8 21 8>; //high:32 low:33
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 27807fc..61b550b 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -10,7 +10,7 @@
  */
 / {
 	model = "MPC8349EMITX";
-	compatible = "MPC834xMITX";
+	compatible = "MPC8349EMITX", "MPC834xMITX", "MPC83xxMITX";
 	#address-cells = <1>;
 	#size-cells = <1>;

@@ -58,7 +58,7 @@
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			dfsrr;
 		};

@@ -67,7 +67,7 @@
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
 			interrupts = <f 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			dfsrr;
 		};

@@ -76,7 +76,7 @@
 			compatible = "mpc83xx_spi";
 			reg = <7000 1000>;
 			interrupts = <10 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			mode = <0>;
 		};

@@ -86,8 +86,8 @@
 			reg = <22000 1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = <700>;
-			interrupts = <27 2>;
+			interrupt-parent = < &ipic >;
+			interrupts = <27 8>;
 			phy_type = "ulpi";
 			port1;
 		};
@@ -98,8 +98,8 @@
 			reg = <23000 1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = <700>;
-			interrupts = <26 2>;
+			interrupt-parent = < &ipic >;
+			interrupts = <26 8>;
 			phy_type = "ulpi";
 		};

@@ -109,22 +109,19 @@
 			reg = <24520 20>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			linux,phandle = <24520>;

 			/* Vitesse 8201 */
-			ethernet-phy@1c {
-				linux,phandle = <245201c>;
-				interrupt-parent = <700>;
-				interrupts = <12 2>;
+			phy1c: ethernet-phy@1c {
+				interrupt-parent = < &ipic >;
+				interrupts = <12 8>;
 				reg = <1c>;
 				device_type = "ethernet-phy";
 			};

 			/* Vitesse 7385 */
-			ethernet-phy@1f {
-				linux,phandle = <245201f>;
-				interrupt-parent = <700>;
-				interrupts = <12 2>;
+			phy1f: ethernet-phy@1f {
+				interrupt-parent = < &ipic >;
+				interrupts = <12 8>;
 				reg = <1f>;
 				device_type = "ethernet-phy";
 			};
@@ -138,8 +135,8 @@
 			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <20 8 21 8 22 8>;
-			interrupt-parent = <700>;
-			phy-handle = <245201c>;
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy1c >;
 		};

 		ethernet@25000 {
@@ -152,8 +149,8 @@
 			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <23 8 24 8 25 8>;
-			interrupt-parent = <700>;
-			phy-handle = <245201f>;
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy1f >;
 		};

 		serial@4500 {
@@ -162,7 +159,7 @@
 			reg = <4500 100>;
 			clock-frequency = <0>;		// from bootloader
 			interrupts = <9 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 		};

 		serial@4600 {
@@ -171,16 +168,16 @@
 			reg = <4600 100>;
 			clock-frequency = <0>;		// from bootloader
 			interrupts = <a 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 		};

 		pci@8500 {
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
 					/* IDSEL 0x10 - SATA */
-					8000 0 0 1 700 16 8 /* SATA_INTA */
+					8000 0 0 1 &ipic 16 8 /* SATA_INTA */
 					>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			interrupts = <42 8>;
 			bus-range = <0 0>;
 			ranges = <42000000 0 80000000 80000000 0 10000000
@@ -199,13 +196,13 @@
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
 					/* IDSEL 0x0E - MiniPCI Slot */
-					7000 0 0 1 700 15 8 /* PCI_INTA */
+					7000 0 0 1 &ipic 15 8 /* PCI_INTA */

 					/* IDSEL 0x0F - PCI Slot */
-					7800 0 0 1 700 14 8 /* PCI_INTA */
-					7800 0 0 2 700 15 8 /* PCI_INTB */
+					7800 0 0 1 &ipic 14 8 /* PCI_INTA */
+					7800 0 0 2 &ipic 15 8 /* PCI_INTB */
 					 >;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			interrupts = <43 8>;
 			bus-range = <1 1>;
 			ranges = <42000000 0 a0000000 a0000000 0 10000000
@@ -226,15 +223,14 @@
 			compatible = "talitos";
 			reg = <30000 10000>;
 			interrupts = <b 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			num-channels = <4>;
 			channel-fifo-len = <18>;
 			exec-units-mask = <0000007e>;
 			descriptor-types-mask = <01010ebf>;
 		};

-		pic@700 {
-			linux,phandle = <700>;
+		ipic: pic@700 {
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index 3190774..b2e1a5e 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -10,7 +10,7 @@
  */
 / {
 	model = "MPC8349EMITXGP";
-	compatible = "MPC834xMITXGP";
+	compatible = "MPC8349EMITXGP", "MPC834xMITX", "MPC83xxMITX";
 	#address-cells = <1>;
 	#size-cells = <1>;

@@ -58,7 +58,7 @@
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			dfsrr;
 		};

@@ -67,7 +67,7 @@
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
 			interrupts = <f 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			dfsrr;
 		};

@@ -76,7 +76,7 @@
 			compatible = "mpc83xx_spi";
 			reg = <7000 1000>;
 			interrupts = <10 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			mode = <0>;
 		};

@@ -86,8 +86,8 @@
 			reg = <23000 1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = <700>;
-			interrupts = <26 2>;
+			interrupt-parent = < &ipic >;
+			interrupts = <26 8>;
 			dr_mode = "otg";
 			phy_type = "ulpi";
 		};
@@ -98,13 +98,11 @@
 			reg = <24520 20>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			linux,phandle = <24520>;

 			/* Vitesse 8201 */
-			ethernet-phy@1c {
-				linux,phandle = <245201c>;
-				interrupt-parent = <700>;
-				interrupts = <12 2>;
+			phy1c: ethernet-phy@1c {
+				interrupt-parent = < &ipic >;
+				interrupts = <12 8>;
 				reg = <1c>;
 				device_type = "ethernet-phy";
 			};
@@ -117,8 +115,8 @@
 			reg = <24000 1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <20 8 21 8 22 8>;
-			interrupt-parent = <700>;
-			phy-handle = <245201c>;
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy1c >;
 		};

 		serial@4500 {
@@ -127,7 +125,7 @@
 			reg = <4500 100>;
 			clock-frequency = <0>;		// from bootloader
 			interrupts = <9 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 		};

 		serial@4600 {
@@ -136,17 +134,17 @@
 			reg = <4600 100>;
 			clock-frequency = <0>;		// from bootloader
 			interrupts = <a 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 		};

 		pci@8600 {
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
 					/* IDSEL 0x0F - PCI Slot */
-					7800 0 0 1 700 14 8 /* PCI_INTA */
-					7800 0 0 2 700 15 8 /* PCI_INTB */
+					7800 0 0 1 &ipic 14 8 /* PCI_INTA */
+					7800 0 0 2 &ipic 15 8 /* PCI_INTB */
 					 >;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			interrupts = <43 8>;
 			bus-range = <1 1>;
 			ranges = <42000000 0 a0000000 a0000000 0 10000000
@@ -167,15 +165,14 @@
 			compatible = "talitos";
 			reg = <30000 10000>;
 			interrupts = <b 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			num-channels = <4>;
 			channel-fifo-len = <18>;
 			exec-units-mask = <0000007e>;
 			descriptor-types-mask = <01010ebf>;
 		};

-		pic@700 {
-			linux,phandle = <700>;
+		ipic: pic@700 {
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index dc121b3..e4b43c2 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -11,7 +11,7 @@

 / {
 	model = "MPC8349EMDS";
-	compatible = "MPC834xMDS";
+	compatible = "MPC8349EMDS", "MPC834xMDS", "MPC83xxMDS";
 	#address-cells = <1>;
 	#size-cells = <1>;

@@ -64,7 +64,7 @@
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			dfsrr;
 		};

@@ -73,7 +73,7 @@
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
 			interrupts = <f 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			dfsrr;
 		};

@@ -82,7 +82,7 @@
 			compatible = "mpc83xx_spi";
 			reg = <7000 1000>;
 			interrupts = <10 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			mode = <0>;
 		};

@@ -94,8 +94,8 @@
 			reg = <22000 1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = <700>;
-			interrupts = <27 2>;
+			interrupt-parent = < &ipic >;
+			interrupts = <27 8>;
 			phy_type = "ulpi";
 			port1;
 		};
@@ -106,8 +106,8 @@
 			reg = <23000 1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = <700>;
-			interrupts = <26 2>;
+			interrupt-parent = < &ipic >;
+			interrupts = <26 8>;
 			dr_mode = "otg";
 			phy_type = "ulpi";
 		};
@@ -118,18 +118,15 @@
 			reg = <24520 20>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			linux,phandle = <24520>;
-			ethernet-phy@0 {
-				linux,phandle = <2452000>;
-				interrupt-parent = <700>;
-				interrupts = <11 2>;
+			phy0: ethernet-phy@0 {
+				interrupt-parent = < &ipic >;
+				interrupts = <11 8>;
 				reg = <0>;
 				device_type = "ethernet-phy";
 			};
-			ethernet-phy@1 {
-				linux,phandle = <2452001>;
-				interrupt-parent = <700>;
-				interrupts = <12 2>;
+			phy1: ethernet-phy@1 {
+				interrupt-parent = < &ipic >;
+				interrupts = <12 8>;
 				reg = <1>;
 				device_type = "ethernet-phy";
 			};
@@ -143,8 +140,8 @@
 			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <20 8 21 8 22 8>;
-			interrupt-parent = <700>;
-			phy-handle = <2452000>;
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy0 >;
 		};

 		ethernet@25000 {
@@ -157,8 +154,8 @@
 			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <23 8 24 8 25 8>;
-			interrupt-parent = <700>;
-			phy-handle = <2452001>;
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy1 >;
 		};

 		serial@4500 {
@@ -167,7 +164,7 @@
 			reg = <4500 100>;
 			clock-frequency = <0>;
 			interrupts = <9 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 		};

 		serial@4600 {
@@ -176,7 +173,7 @@
 			reg = <4600 100>;
 			clock-frequency = <0>;
 			interrupts = <a 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 		};

 		pci@8500 {
@@ -184,47 +181,47 @@
 			interrupt-map = <

 					/* IDSEL 0x11 */
-					 8800 0 0 1 700 14 8
-					 8800 0 0 2 700 15 8
-					 8800 0 0 3 700 16 8
-					 8800 0 0 4 700 17 8
+					 8800 0 0 1 &ipic 14 8
+					 8800 0 0 2 &ipic 15 8
+					 8800 0 0 3 &ipic 16 8
+					 8800 0 0 4 &ipic 17 8

 					/* IDSEL 0x12 */
-					 9000 0 0 1 700 16 8
-					 9000 0 0 2 700 17 8
-					 9000 0 0 3 700 14 8
-					 9000 0 0 4 700 15 8
+					 9000 0 0 1 &ipic 16 8
+					 9000 0 0 2 &ipic 17 8
+					 9000 0 0 3 &ipic 14 8
+					 9000 0 0 4 &ipic 15 8

 					/* IDSEL 0x13 */
-					 9800 0 0 1 700 17 8
-					 9800 0 0 2 700 14 8
-					 9800 0 0 3 700 15 8
-					 9800 0 0 4 700 16 8
+					 9800 0 0 1 &ipic 17 8
+					 9800 0 0 2 &ipic 14 8
+					 9800 0 0 3 &ipic 15 8
+					 9800 0 0 4 &ipic 16 8

 					/* IDSEL 0x15 */
-					 a800 0 0 1 700 14 8
-					 a800 0 0 2 700 15 8
-					 a800 0 0 3 700 16 8
-					 a800 0 0 4 700 17 8
+					 a800 0 0 1 &ipic 14 8
+					 a800 0 0 2 &ipic 15 8
+					 a800 0 0 3 &ipic 16 8
+					 a800 0 0 4 &ipic 17 8

 					/* IDSEL 0x16 */
-					 b000 0 0 1 700 17 8
-					 b000 0 0 2 700 14 8
-					 b000 0 0 3 700 15 8
-					 b000 0 0 4 700 16 8
+					 b000 0 0 1 &ipic 17 8
+					 b000 0 0 2 &ipic 14 8
+					 b000 0 0 3 &ipic 15 8
+					 b000 0 0 4 &ipic 16 8

 					/* IDSEL 0x17 */
-					 b800 0 0 1 700 16 8
-					 b800 0 0 2 700 17 8
-					 b800 0 0 3 700 14 8
-					 b800 0 0 4 700 15 8
+					 b800 0 0 1 &ipic 16 8
+					 b800 0 0 2 &ipic 17 8
+					 b800 0 0 3 &ipic 14 8
+					 b800 0 0 4 &ipic 15 8

 					/* IDSEL 0x18 */
-					 c000 0 0 1 700 15 8
-					 c000 0 0 2 700 16 8
-					 c000 0 0 3 700 17 8
-					 c000 0 0 4 700 14 8>;
-			interrupt-parent = <700>;
+					 c000 0 0 1 &ipic 15 8
+					 c000 0 0 2 &ipic 16 8
+					 c000 0 0 3 &ipic 17 8
+					 c000 0 0 4 &ipic 14 8>;
+			interrupt-parent = < &ipic >;
 			interrupts = <42 8>;
 			bus-range = <0 0>;
 			ranges = <02000000 0 a0000000 a0000000 0 10000000
@@ -244,47 +241,47 @@
 			interrupt-map = <

 					/* IDSEL 0x11 */
-					 8800 0 0 1 700 14 8
-					 8800 0 0 2 700 15 8
-					 8800 0 0 3 700 16 8
-					 8800 0 0 4 700 17 8
+					 8800 0 0 1 &ipic 14 8
+					 8800 0 0 2 &ipic 15 8
+					 8800 0 0 3 &ipic 16 8
+					 8800 0 0 4 &ipic 17 8

 					/* IDSEL 0x12 */
-					 9000 0 0 1 700 16 8
-					 9000 0 0 2 700 17 8
-					 9000 0 0 3 700 14 8
-					 9000 0 0 4 700 15 8
+					 9000 0 0 1 &ipic 16 8
+					 9000 0 0 2 &ipic 17 8
+					 9000 0 0 3 &ipic 14 8
+					 9000 0 0 4 &ipic 15 8

 					/* IDSEL 0x13 */
-					 9800 0 0 1 700 17 8
-					 9800 0 0 2 700 14 8
-					 9800 0 0 3 700 15 8
-					 9800 0 0 4 700 16 8
+					 9800 0 0 1 &ipic 17 8
+					 9800 0 0 2 &ipic 14 8
+					 9800 0 0 3 &ipic 15 8
+					 9800 0 0 4 &ipic 16 8

 					/* IDSEL 0x15 */
-					 a800 0 0 1 700 14 8
-					 a800 0 0 2 700 15 8
-					 a800 0 0 3 700 16 8
-					 a800 0 0 4 700 17 8
+					 a800 0 0 1 &ipic 14 8
+					 a800 0 0 2 &ipic 15 8
+					 a800 0 0 3 &ipic 16 8
+					 a800 0 0 4 &ipic 17 8

 					/* IDSEL 0x16 */
-					 b000 0 0 1 700 17 8
-					 b000 0 0 2 700 14 8
-					 b000 0 0 3 700 15 8
-					 b000 0 0 4 700 16 8
+					 b000 0 0 1 &ipic 17 8
+					 b000 0 0 2 &ipic 14 8
+					 b000 0 0 3 &ipic 15 8
+					 b000 0 0 4 &ipic 16 8

 					/* IDSEL 0x17 */
-					 b800 0 0 1 700 16 8
-					 b800 0 0 2 700 17 8
-					 b800 0 0 3 700 14 8
-					 b800 0 0 4 700 15 8
+					 b800 0 0 1 &ipic 16 8
+					 b800 0 0 2 &ipic 17 8
+					 b800 0 0 3 &ipic 14 8
+					 b800 0 0 4 &ipic 15 8

 					/* IDSEL 0x18 */
-					 c000 0 0 1 700 15 8
-					 c000 0 0 2 700 16 8
-					 c000 0 0 3 700 17 8
-					 c000 0 0 4 700 14 8>;
-			interrupt-parent = <700>;
+					 c000 0 0 1 &ipic 15 8
+					 c000 0 0 2 &ipic 16 8
+					 c000 0 0 3 &ipic 17 8
+					 c000 0 0 4 &ipic 14 8>;
+			interrupt-parent = < &ipic >;
 			interrupts = <42 8>;
 			bus-range = <0 0>;
 			ranges = <02000000 0 b0000000 b0000000 0 10000000
@@ -306,7 +303,7 @@
 			compatible = "talitos";
 			reg = <30000 10000>;
 			interrupts = <b 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			num-channels = <4>;
 			channel-fifo-len = <18>;
 			exec-units-mask = <0000007e>;
@@ -321,8 +318,7 @@
 		 * sense == 8: Level, low assertion
 		 * sense == 2: Edge, high-to-low change
 		 */
-		pic@700 {
-			linux,phandle = <700>;
+		ipic: pic@700 {
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
diff --git a/arch/powerpc/boot/dts/mpc8360emds.dts b/arch/powerpc/boot/dts/mpc8360emds.dts
index 303bd66..4fe45c0 100644
--- a/arch/powerpc/boot/dts/mpc8360emds.dts
+++ b/arch/powerpc/boot/dts/mpc8360emds.dts
@@ -15,17 +15,15 @@
 */

 / {
-	model = "MPC8360EPB";
-	compatible = "MPC83xx";
+	model = "MPC8360MDS";
+	compatible = "MPC8360EMDS", "MPC836xMDS", "MPC83xxMDS";
 	#address-cells = <1>;
 	#size-cells = <1>;
-	linux,phandle = <100>;

 	cpus {
 		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		linux,phandle = <200>;

 		PowerPC,8360@0 {
 			device_type = "cpu";
@@ -38,13 +36,11 @@
 			bus-frequency = <FBC5200>;
 			clock-frequency = <1F78A400>;
 			32-bit;
-			linux,phandle = <201>;
 		};
 	};

 	memory {
 		device_type = "memory";
-		linux,phandle = <300>;
 		reg = <00000000 10000000>;
 	};

@@ -73,7 +69,7 @@
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			dfsrr;
 		};

@@ -82,7 +78,7 @@
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
 			interrupts = <f 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			dfsrr;
 		};

@@ -92,7 +88,7 @@
 			reg = <4500 100>;
 			clock-frequency = <FBC5200>;
 			interrupts = <9 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 		};

 		serial@4600 {
@@ -101,7 +97,7 @@
 			reg = <4600 100>;
 			clock-frequency = <FBC5200>;
 			interrupts = <a 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 		};

 		crypto@30000 {
@@ -110,7 +106,7 @@
 			compatible = "talitos";
 			reg = <30000 10000>;
 			interrupts = <b 8>;
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 			num-channels = <4>;
 			channel-fifo-len = <18>;
 			exec-units-mask = <0000007e>;
@@ -119,52 +115,51 @@
 		};

 		pci@8500 {
-			linux,phandle = <8500>;
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <

 					/* IDSEL 0x11 AD17 */
-					 8800 0 0 1 700 14 8
-					 8800 0 0 2 700 15 8
-					 8800 0 0 3 700 16 8
-					 8800 0 0 4 700 17 8
+					 8800 0 0 1 &ipic 14 8
+					 8800 0 0 2 &ipic 15 8
+					 8800 0 0 3 &ipic 16 8
+					 8800 0 0 4 &ipic 17 8

 					/* IDSEL 0x12 AD18 */
-					 9000 0 0 1 700 16 8
-					 9000 0 0 2 700 17 8
-					 9000 0 0 3 700 14 8
-					 9000 0 0 4 700 15 8
+					 9000 0 0 1 &ipic 16 8
+					 9000 0 0 2 &ipic 17 8
+					 9000 0 0 3 &ipic 14 8
+					 9000 0 0 4 &ipic 15 8

 					/* IDSEL 0x13 AD19 */
-					 9800 0 0 1 700 17 8
-					 9800 0 0 2 700 14 8
-					 9800 0 0 3 700 15 8
-					 9800 0 0 4 700 16 8
+					 9800 0 0 1 &ipic 17 8
+					 9800 0 0 2 &ipic 14 8
+					 9800 0 0 3 &ipic 15 8
+					 9800 0 0 4 &ipic 16 8

 					/* IDSEL 0x15 AD21*/
-					 a800 0 0 1 700 14 8
-					 a800 0 0 2 700 15 8
-					 a800 0 0 3 700 16 8
-					 a800 0 0 4 700 17 8
+					 a800 0 0 1 &ipic 14 8
+					 a800 0 0 2 &ipic 15 8
+					 a800 0 0 3 &ipic 16 8
+					 a800 0 0 4 &ipic 17 8

 					/* IDSEL 0x16 AD22*/
-					 b000 0 0 1 700 17 8
-					 b000 0 0 2 700 14 8
-					 b000 0 0 3 700 15 8
-					 b000 0 0 4 700 16 8
+					 b000 0 0 1 &ipic 17 8
+					 b000 0 0 2 &ipic 14 8
+					 b000 0 0 3 &ipic 15 8
+					 b000 0 0 4 &ipic 16 8

 					/* IDSEL 0x17 AD23*/
-					 b800 0 0 1 700 16 8
-					 b800 0 0 2 700 17 8
-					 b800 0 0 3 700 14 8
-					 b800 0 0 4 700 15 8
+					 b800 0 0 1 &ipic 16 8
+					 b800 0 0 2 &ipic 17 8
+					 b800 0 0 3 &ipic 14 8
+					 b800 0 0 4 &ipic 15 8

 					/* IDSEL 0x18 AD24*/
-					 c000 0 0 1 700 15 8
-					 c000 0 0 2 700 16 8
-					 c000 0 0 3 700 17 8
-					 c000 0 0 4 700 14 8>;
-			interrupt-parent = <700>;
+					 c000 0 0 1 &ipic 15 8
+					 c000 0 0 2 &ipic 16 8
+					 c000 0 0 3 &ipic 17 8
+					 c000 0 0 4 &ipic 14 8>;
+			interrupt-parent = < &ipic >;
 			interrupts = <42 8>;
 			bus-range = <0 0>;
 			ranges = <02000000 0 a0000000 a0000000 0 10000000
@@ -179,8 +174,7 @@
 			device_type = "pci";
 		};

-		pic@700 {
-			linux,phandle = <700>;
+		ipic: pic@700 {
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
@@ -194,8 +188,7 @@
 			device_type = "par_io";
 			num-ports = <7>;

-			ucc_pin@01 {
-				linux,phandle = <140001>;
+			pio1: ucc_pin@01 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					0  3  1  0  1  0 	/* TxD0 */
@@ -222,8 +215,7 @@
 					2  9  1  0  3  0 	/* GTX_CLK - CLK10 */
 					2  8  2  0  1  0>;	/* GTX125 - CLK9 */
 			};
-			ucc_pin@02 {
-				linux,phandle = <140002>;
+			pio2: ucc_pin@02 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					0  11 1  0  1  0   /* TxD0 */
@@ -280,7 +272,7 @@
 			compatible = "fsl_spi";
 			reg = <4c0 40>;
 			interrupts = <2>;
-			interrupt-parent = <80>;
+			interrupt-parent = < &qeic >;
 			mode = "cpu";
 		};

@@ -289,7 +281,7 @@
 			compatible = "fsl_spi";
 			reg = <500 40>;
 			interrupts = <1>;
-			interrupt-parent = <80>;
+			interrupt-parent = < &qeic >;
 			mode = "cpu";
 		};

@@ -298,7 +290,7 @@
 			compatible = "qe_udc";
 			reg = <6c0 40 8B00 100>;
 			interrupts = <b>;
-			interrupt-parent = <80>;
+			interrupt-parent = < &qeic >;
 			mode = "slave";
 		};

@@ -309,12 +301,12 @@
 			device-id = <1>;
 			reg = <2000 200>;
 			interrupts = <20>;
-			interrupt-parent = <80>;
+			interrupt-parent = < &qeic >;
 			mac-address = [ 00 04 9f 00 23 23 ];
 			rx-clock = <0>;
 			tx-clock = <19>;
-			phy-handle = <212000>;
-			pio-handle = <140001>;
+			phy-handle = < &phy0 >;
+			pio-handle = < &pio1 >;
 		};

 		ucc@3000 {
@@ -324,12 +316,12 @@
 			device-id = <2>;
 			reg = <3000 200>;
 			interrupts = <21>;
-			interrupt-parent = <80>;
+			interrupt-parent = < &qeic >;
 			mac-address = [ 00 11 22 33 44 55 ];
 			rx-clock = <0>;
 			tx-clock = <14>;
-			phy-handle = <212001>;
-			pio-handle = <140002>;
+			phy-handle = < &phy1 >;
+			pio-handle = < &pio2 >;
 		};

 		mdio@2120 {
@@ -339,26 +331,23 @@
 			device_type = "mdio";
 			compatible = "ucc_geth_phy";

-			ethernet-phy@00 {
-				linux,phandle = <212000>;
-				interrupt-parent = <700>;
-				interrupts = <11 2>;
+			phy0: ethernet-phy@00 {
+				interrupt-parent = < &ipic >;
+				interrupts = <11 8>;
 				reg = <0>;
 				device_type = "ethernet-phy";
 				interface = <6>; //ENET_1000_GMII
 			};
-			ethernet-phy@01 {
-				linux,phandle = <212001>;
-				interrupt-parent = <700>;
-				interrupts = <12 2>;
+			phy1: ethernet-phy@01 {
+				interrupt-parent = < &ipic >;
+				interrupts = <12 8>;
 				reg = <1>;
 				device_type = "ethernet-phy";
 				interface = <6>;
 			};
 		};

-		qeic@80 {
-			linux,phandle = <80>;
+		qeic: qeic@80 {
 			interrupt-controller;
 			device_type = "qeic";
 			#address-cells = <0>;
@@ -367,7 +356,7 @@
 			built-in;
 			big-endian;
 			interrupts = <20 8 21 8>; //high:32 low:33
-			interrupt-parent = <700>;
+			interrupt-parent = < &ipic >;
 		};

 	};
