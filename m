Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id E587BDDE41
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 08:09:44 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] 83xx: Clean up / convert mpc83xx board DTS files to v1 format.
Date: Mon, 28 Jan 2008 16:09:36 -0500
Message-Id: <1201554576-32653-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <54AD0075-E36B-4A95-BFD9-C750E590513F@kernel.crashing.org>
References: <54AD0075-E36B-4A95-BFD9-C750E590513F@kernel.crashing.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch converts the remaining 83xx boards to the dts-v1 format.
This includes the mpc8313_rdb, mpc832x_mds, mpc8323_rdb, mpc8349emitx,
mpc8349emitxgp and the mpc836x_mds.

The mpc8315_rdb mpc834x_mds, mpc837[789]_*, and sbc8349 were already
dts-v1 and only undergo minor changes for the sake of formatting
consistency across the whole group of boards; i.e.  the idea being
that you can do a "diff -u board_A.dts board_B.dts" and see something
meaningful.

The general rule I've applied is that entries for values normally
parsed by humans are left in decimal (i.e. IRQ, cache size, clock
rates, basic counts and indexes) and all other data (i.e. reg and
ranges, IRQ flags etc.) remain in hex.

I've used dtc to confirm that the output prior to this changeset
matches the output after this changeset is applied for all boards.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/mpc8313erdb.dts    |  152 +++++++++---------
 arch/powerpc/boot/dts/mpc8315erdb.dts    |  100 ++++++------
 arch/powerpc/boot/dts/mpc832x_mds.dts    |  252 +++++++++++++++--------------
 arch/powerpc/boot/dts/mpc832x_rdb.dts    |  154 +++++++++---------
 arch/powerpc/boot/dts/mpc8349emitx.dts   |  155 +++++++++---------
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |  109 +++++++------
 arch/powerpc/boot/dts/mpc834x_mds.dts    |   36 ++--
 arch/powerpc/boot/dts/mpc836x_mds.dts    |  260 +++++++++++++++---------------
 arch/powerpc/boot/dts/mpc8377_mds.dts    |  138 ++++++++--------
 arch/powerpc/boot/dts/mpc8377_rdb.dts    |  102 ++++++------
 arch/powerpc/boot/dts/mpc8378_mds.dts    |  130 ++++++++--------
 arch/powerpc/boot/dts/mpc8378_rdb.dts    |   94 ++++++------
 arch/powerpc/boot/dts/mpc8379_mds.dts    |  146 +++++++++---------
 arch/powerpc/boot/dts/mpc8379_rdb.dts    |  112 +++++++-------
 arch/powerpc/boot/dts/sbc8349.dts        |   44 +++---
 15 files changed, 999 insertions(+), 985 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 20a03f5..2d6653f 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -9,6 +9,8 @@
  * option) any later version.
  */
 
+/dts-v1/;
+
 / {
 	model = "MPC8313ERDB";
 	compatible = "MPC8313ERDB", "MPC831xRDB", "MPC83xxRDB";
@@ -29,11 +31,11 @@
 
 		PowerPC,8313@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
-			d-cache-size = <4000>;		// L1, 16K
-			i-cache-size = <4000>;		// L1, 16K
+			reg = <0x0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <16384>;
+			i-cache-size = <16384>;
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
@@ -42,30 +44,30 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 08000000>;	// 128MB at 0
+		reg = <0x00000000 0x08000000>;	// 128MB at 0
 	};
 
 	localbus@e0005000 {
 		#address-cells = <2>;
 		#size-cells = <1>;
 		compatible = "fsl,mpc8313-elbc", "fsl,elbc", "simple-bus";
-		reg = <e0005000 1000>;
-		interrupts = <d#77 8>;
+		reg = <0xe0005000 0x1000>;
+		interrupts = <77 0x8>;
 		interrupt-parent = <&ipic>;
 
 		// CS0 and CS1 are swapped when
 		// booting from nand, but the
 		// addresses are the same.
-		ranges = <0 0 fe000000 00800000
-		          1 0 e2800000 00008000
-		          2 0 f0000000 00020000
-		          3 0 fa000000 00008000>;
+		ranges = <0x0 0x0 0xfe000000 0x00800000
+		          0x1 0x0 0xe2800000 0x00008000
+		          0x2 0x0 0xf0000000 0x00020000
+		          0x3 0x0 0xfa000000 0x00008000>;
 
 		flash@0,0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "cfi-flash";
-			reg = <0 0 800000>;
+			reg = <0x0 0x0 0x800000>;
 			bank-width = <2>;
 			device-width = <1>;
 		};
@@ -75,19 +77,19 @@
 			#size-cells = <1>;
 			compatible = "fsl,mpc8313-fcm-nand",
 			             "fsl,elbc-fcm-nand";
-			reg = <1 0 2000>;
+			reg = <0x1 0x0 0x2000>;
 
 			u-boot@0 {
-				reg = <0 100000>;
+				reg = <0x0 0x100000>;
 				read-only;
 			};
 
 			kernel@100000 {
-				reg = <100000 300000>;
+				reg = <0x100000 0x300000>;
 			};
 
 			fs@400000 {
-				reg = <400000 1c00000>;
+				reg = <0x400000 0x1c00000>;
 			};
 		};
 	};
@@ -97,14 +99,14 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		compatible = "simple-bus";
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
@@ -112,9 +114,9 @@
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
 		};
 
@@ -123,29 +125,29 @@
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
 			cell-index = <0>;
 			compatible = "fsl,spi";
-			reg = <7000 1000>;
-			interrupts = <10 8>;
-			interrupt-parent = < &ipic >;
+			reg = <0x7000 0x1000>;
+			interrupts = <16 0x8>;
+			interrupt-parent = <&ipic>;
 			mode = "cpu";
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
 			phy_type = "utmi_wide";
 		};
 
@@ -153,17 +155,17 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,gianfar-mdio";
-			reg = <24520 20>;
+			reg = <0x24520 0x20>;
 			phy1: ethernet-phy@1 {
-				interrupt-parent = < &ipic >;
-				interrupts = <13 8>;
-				reg = <1>;
+				interrupt-parent = <&ipic>;
+				interrupts = <19 0x8>;
+				reg = <0x1>;
 				device_type = "ethernet-phy";
 			};
 			phy4: ethernet-phy@4 {
-				interrupt-parent = < &ipic >;
-				interrupts = <14 8>;
-				reg = <4>;
+				interrupt-parent = <&ipic>;
+				interrupts = <20 0x8>;
+				reg = <0x4>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -173,10 +175,10 @@
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
-			reg = <24000 1000>;
+			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <25 8 24 8 23 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <37 0x8 36 0x8 35 0x8>;
+			interrupt-parent = <&ipic>;
 			phy-handle = < &phy1 >;
 		};
 
@@ -185,10 +187,10 @@
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
-			reg = <25000 1000>;
+			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <22 8 21 8 20 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <34 0x8 33 0x8 32 0x8>;
+			interrupt-parent = <&ipic>;
 			phy-handle = < &phy4 >;
 		};
 
@@ -196,34 +198,34 @@
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
+			channel-fifo-len = <24>;
+			exec-units-mask = <0x0000004c>;
+			descriptor-types-mask = <0x0122003f>;
 		};
 
 		/* IPIC
@@ -236,38 +238,38 @@
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
 
 				/* IDSEL 0x0E -mini PCI */
-				 7000 0 0 1 &ipic 12 8
-				 7000 0 0 2 &ipic 12 8
-				 7000 0 0 3 &ipic 12 8
-				 7000 0 0 4 &ipic 12 8
+				 0x7000 0x0 0x0 0x1 &ipic 18 0x8
+				 0x7000 0x0 0x0 0x2 &ipic 18 0x8
+				 0x7000 0x0 0x0 0x3 &ipic 18 0x8
+				 0x7000 0x0 0x0 0x4 &ipic 18 0x8
 
 				/* IDSEL 0x0F - PCI slot */
-				 7800 0 0 1 &ipic 11 8
-				 7800 0 0 2 &ipic 12 8
-				 7800 0 0 3 &ipic 11 8
-				 7800 0 0 4 &ipic 12 8>;
-		interrupt-parent = < &ipic >;
-		interrupts = <42 8>;
-		bus-range = <0 0>;
-		ranges = <02000000 0 90000000 90000000 0 10000000
-			  42000000 0 80000000 80000000 0 10000000
-			  01000000 0 00000000 e2000000 0 00100000>;
-		clock-frequency = <3f940aa>;
+				 0x7800 0x0 0x0 0x1 &ipic 17 0x8
+				 0x7800 0x0 0x0 0x2 &ipic 18 0x8
+				 0x7800 0x0 0x0 0x3 &ipic 17 0x8
+				 0x7800 0x0 0x0 0x4 &ipic 18 0x8>;
+		interrupt-parent = <&ipic>;
+		interrupts = <66 0x8>;
+		bus-range = <0x0 0x0>;
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
diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index e157f23..b582032 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -30,7 +30,7 @@
 
 		PowerPC,8315@0 {
 			device_type = "cpu";
-			reg = <0>;
+			reg = <0x0>;
 			d-cache-line-size = <32>;
 			i-cache-line-size = <32>;
 			d-cache-size = <16384>;
@@ -51,22 +51,22 @@
 		#size-cells = <1>;
 		compatible = "fsl,mpc8315-elbc", "fsl,elbc", "simple-bus";
 		reg = <0xe0005000 0x1000>;
-		interrupts = <77 8>;
+		interrupts = <77 0x8>;
 		interrupt-parent = <&ipic>;
 
 		// CS0 and CS1 are swapped when
 		// booting from nand, but the
 		// addresses are the same.
-		ranges = <0 0 0xfe000000 0x00800000
-		          1 0 0xe0600000 0x00002000
-		          2 0 0xf0000000 0x00020000
-		          3 0 0xfa000000 0x00008000>;
+		ranges = <0x0 0x0 0xfe000000 0x00800000
+		          0x1 0x0 0xe0600000 0x00002000
+		          0x2 0x0 0xf0000000 0x00020000
+		          0x3 0x0 0xfa000000 0x00008000>;
 
 		flash@0,0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "cfi-flash";
-			reg = <0 0 0x800000>;
+			reg = <0x0 0x0 0x800000>;
 			bank-width = <2>;
 			device-width = <1>;
 		};
@@ -76,7 +76,7 @@
 			#size-cells = <1>;
 			compatible = "fsl,mpc8315-fcm-nand",
 			             "fsl,elbc-fcm-nand";
-			reg = <1 0 0x2000>;
+			reg = <0x1 0x0 0x2000>;
 
 			u-boot@0 {
 				reg = <0x0 0x100000>;
@@ -113,8 +113,8 @@
 			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <14 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <14 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 			rtc@68 {
 				device_type = "rtc";
@@ -127,8 +127,8 @@
 			cell-index = <0>;
 			compatible = "fsl,spi";
 			reg = <0x7000 0x1000>;
-			interrupts = <16 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <16 0x8>;
+			interrupt-parent = <&ipic>;
 			mode = "cpu";
 		};
 
@@ -137,8 +137,8 @@
 			reg = <0x23000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = < &ipic >;
-			interrupts = <38 8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <38 0x8>;
 			phy_type = "utmi";
 		};
 
@@ -148,15 +148,15 @@
 			compatible = "fsl,gianfar-mdio";
 			reg = <0x24520 0x20>;
 			phy0: ethernet-phy@0 {
-				interrupt-parent = < &ipic >;
-				interrupts = <20 8>;
-				reg = <0>;
+				interrupt-parent = <&ipic>;
+				interrupts = <20 0x8>;
+				reg = <0x0>;
 				device_type = "ethernet-phy";
 			};
 			phy1: ethernet-phy@1 {
-				interrupt-parent = < &ipic >;
-				interrupts = <19 8>;
-				reg = <1>;
+				interrupt-parent = <&ipic>;
+				interrupts = <19 0x8>;
+				reg = <0x1>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -168,8 +168,8 @@
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <32 8 33 8 34 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <32 0x8 33 0x8 34 0x8>;
+			interrupt-parent = <&ipic>;
 			phy-handle = < &phy0 >;
 		};
 
@@ -180,8 +180,8 @@
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 8 36 8 37 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <35 0x8 36 0x8 37 0x8>;
+			interrupt-parent = <&ipic>;
 			phy-handle = < &phy1 >;
 		};
 
@@ -191,8 +191,8 @@
 			compatible = "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <9 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <9 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		serial1: serial@4600 {
@@ -201,8 +201,8 @@
 			compatible = "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <10 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <10 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		crypto@30000 {
@@ -210,8 +210,8 @@
 			device_type = "crypto";
 			compatible = "talitos";
 			reg = <0x30000 0x10000>;
-			interrupts = <11 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <11 0x8>;
+			interrupt-parent = <&ipic>;
 			/* Rev. 3.0 geometry */
 			num-channels = <4>;
 			channel-fifo-len = <24>;
@@ -223,16 +223,16 @@
 			compatible = "fsl,mpc8315-sata", "fsl,pq-sata";
 			reg = <0x18000 0x1000>;
 			cell-index = <1>;
-			interrupts = <44 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <44 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		sata@19000 {
 			compatible = "fsl,mpc8315-sata", "fsl,pq-sata";
 			reg = <0x19000 0x1000>;
 			cell-index = <2>;
-			interrupts = <45 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <45 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		/* IPIC
@@ -251,28 +251,28 @@
 	};
 
 	pci0: pci@e0008500 {
-		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 				/* IDSEL 0x0E -mini PCI */
-				 0x7000 0 0 1 &ipic 18 8
-				 0x7000 0 0 2 &ipic 18 8
-				 0x7000 0 0 3 &ipic 18 8
-				 0x7000 0 0 4 &ipic 18 8
+				 0x7000 0x0 0x0 0x1 &ipic 18 0x8
+				 0x7000 0x0 0x0 0x2 &ipic 18 0x8
+				 0x7000 0x0 0x0 0x3 &ipic 18 0x8
+				 0x7000 0x0 0x0 0x4 &ipic 18 0x8
 
 				/* IDSEL 0x0F -mini PCI */
-				 0x7800 0 0 1 &ipic 17 8
-				 0x7800 0 0 2 &ipic 17 8
-				 0x7800 0 0 3 &ipic 17 8
-				 0x7800 0 0 4 &ipic 17 8
+				 0x7800 0x0 0x0 0x1 &ipic 17 0x8
+				 0x7800 0x0 0x0 0x2 &ipic 17 0x8
+				 0x7800 0x0 0x0 0x3 &ipic 17 0x8
+				 0x7800 0x0 0x0 0x4 &ipic 17 0x8
 
 				/* IDSEL 0x10 - PCI slot */
-				 0x8000 0 0 1 &ipic 48 8
-				 0x8000 0 0 2 &ipic 17 8
-				 0x8000 0 0 3 &ipic 48 8
-				 0x8000 0 0 4 &ipic 17 8>;
-		interrupt-parent = < &ipic >;
-		interrupts = <66 8>;
-		bus-range = <0 0>;
+				 0x8000 0x0 0x0 0x1 &ipic 48 0x8
+				 0x8000 0x0 0x0 0x2 &ipic 17 0x8
+				 0x8000 0x0 0x0 0x3 &ipic 48 0x8
+				 0x8000 0x0 0x0 0x4 &ipic 17 0x8>;
+		interrupt-parent = <&ipic>;
+		interrupts = <66 0x8>;
+		bus-range = <0x0 0x0>;
 		ranges = <0x02000000 0 0x90000000 0x90000000 0 0x10000000
 			  0x42000000 0 0x80000000 0x80000000 0 0x10000000
 			  0x01000000 0 0x00000000 0xe0300000 0 0x00100000>;
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 7c3c52c..9bb4083 100644
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
@@ -41,11 +43,11 @@
 
 		PowerPC,8323@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
-			d-cache-size = <4000>;		// L1, 16K
-			i-cache-size = <4000>;		// L1, 16K
+			reg = <0x0>;
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
+			channel-fifo-len = <24>;
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
@@ -190,10 +192,10 @@
 					2    0    1      0    2    0  /* TxD5 */
 					2    8    2      0    2    0  /* RxD5 */
 
-					2   1d    2      0    0    0  /* CTS5 */
-					2   1f    1      0    2    0  /* RTS5 */
+					2   29    2      0    0    0  /* CTS5 */
+					2   31    1      0    2    0  /* RTS5 */
 
-					2   18    2      0    0    0  /* CD */
+					2   24    2      0    0    0  /* CD */
 
 				>;
 			};
@@ -206,47 +208,47 @@
 		#size-cells = <1>;
 		device_type = "qe";
 		compatible = "fsl,qe";
-		ranges = <0 e0100000 00100000>;
-		reg = <e0100000 480>;
+		ranges = <0x0 0xe0100000 0x00100000>;
+		reg = <0xe0100000 0x480>;
 		brg-frequency = <0>;
-		bus-frequency = <BCD3D80>;
+		bus-frequency = <198000000>;
 
 		muram@10000 {
- 			#address-cells = <1>;
- 			#size-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 			compatible = "fsl,qe-muram", "fsl,cpm-muram";
-			ranges = <0 00010000 00004000>;
+			ranges = <0x0 0x00010000 0x00004000>;
 
 			data-only@0 {
 				compatible = "fsl,qe-muram-data",
 					     "fsl,cpm-muram-data";
-				reg = <0 4000>;
+				reg = <0x0 0x4000>;
 			};
 		};
 
 		spi@4c0 {
 			cell-index = <0>;
 			compatible = "fsl,spi";
-			reg = <4c0 40>;
+			reg = <0x4c0 0x40>;
 			interrupts = <2>;
-			interrupt-parent = < &qeic >;
+			interrupt-parent = <&qeic>;
 			mode = "cpu";
 		};
 
 		spi@500 {
 			cell-index = <1>;
 			compatible = "fsl,spi";
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
 
@@ -256,14 +258,14 @@
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
@@ -272,14 +274,14 @@
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
@@ -289,8 +291,8 @@
 			device-id = <5>;	/* The UCC number, 1-7*/
 			port-number = <0>;	/* Which ttyQEx device */
 			soft-uart;		/* We need Soft-UART */
-			reg = <2400 200>;
-			interrupts = <28>;	/* From Table 18-12 */
+			reg = <0x2400 0x200>;
+			interrupts = <40>;	/* From Table 18-12 */
 			interrupt-parent = < &qeic >;
 			/*
 			 * For Soft-UART, we need to set TX to 1X, which
@@ -305,19 +307,19 @@
 		mdio@2320 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <2320 18>;
+			reg = <0x2320 0x18>;
 			compatible = "fsl,ucc-mdio";
 
 			phy3: ethernet-phy@03 {
-				interrupt-parent = < &ipic >;
-				interrupts = <11 8>;
-				reg = <3>;
+				interrupt-parent = <&ipic>;
+				interrupts = <17 0x8>;
+				reg = <0x3>;
 				device_type = "ethernet-phy";
 			};
 			phy4: ethernet-phy@04 {
-				interrupt-parent = < &ipic >;
-				interrupts = <12 8>;
-				reg = <4>;
+				interrupt-parent = <&ipic>;
+				interrupts = <18 0x8>;
+				reg = <0x4>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -327,69 +329,69 @@
 			compatible = "fsl,qe-ic";
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
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 551fc59..94f93d2 100644
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
@@ -29,11 +31,11 @@
 
 		PowerPC,8323@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
-			d-cache-size = <4000>;		// L1, 16K
-			i-cache-size = <4000>;		// L1, 16K
+			reg = <0x0>;
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
+			channel-fifo-len = <24>;
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
@@ -167,28 +169,28 @@
 		#size-cells = <1>;
 		device_type = "qe";
 		compatible = "fsl,qe";
-		ranges = <0 e0100000 00100000>;
-		reg = <e0100000 480>;
+		ranges = <0x0 0xe0100000 0x00100000>;
+		reg = <0xe0100000 0x480>;
 		brg-frequency = <0>;
-		bus-frequency = <BCD3D80>;
+		bus-frequency = <198000000>;
 
 		muram@10000 {
  			#address-cells = <1>;
  			#size-cells = <1>;
 			compatible = "fsl,qe-muram", "fsl,cpm-muram";
-			ranges = <0 00010000 00004000>;
+			ranges = <0x0 0x00010000 0x00004000>;
 
 			data-only@0 {
 				compatible = "fsl,qe-muram-data",
 					     "fsl,cpm-muram-data";
-				reg = <0 4000>;
+				reg = <0x0 0x4000>;
 			};
 		};
 
 		spi@4c0 {
 			cell-index = <0>;
 			compatible = "fsl,spi";
-			reg = <4c0 40>;
+			reg = <0x4c0 0x40>;
 			interrupts = <2>;
 			interrupt-parent = <&qeic>;
 			mode = "cpu-qe";
@@ -197,7 +199,7 @@
 		spi@500 {
 			cell-index = <1>;
 			compatible = "fsl,spi";
-			reg = <500 40>;
+			reg = <0x500 0x40>;
 			interrupts = <1>;
 			interrupt-parent = <&qeic>;
 			mode = "cpu";
@@ -209,8 +211,8 @@
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
@@ -225,8 +227,8 @@
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
@@ -238,19 +240,19 @@
 		mdio@3120 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <3120 18>;
+			reg = <0x3120 0x18>;
 			compatible = "fsl,ucc-mdio";
 
 			phy00:ethernet-phy@00 {
 				interrupt-parent = <&pic>;
 				interrupts = <0>;
-				reg = <0>;
+				reg = <0x0>;
 				device_type = "ethernet-phy";
 			};
 			phy04:ethernet-phy@04 {
 				interrupt-parent = <&pic>;
 				interrupts = <0>;
-				reg = <4>;
+				reg = <0x4>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -260,43 +262,43 @@
 			compatible = "fsl,qe-ic";
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
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 4a4ddea..9426676 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -8,6 +8,9 @@
  * Free Software Foundation; either version 2 of the License, or (at your
  * option) any later version.
  */
+
+/dts-v1/;
+
 / {
 	model = "MPC8349EMITX";
 	compatible = "MPC8349EMITX", "MPC834xMITX", "MPC83xxMITX";
@@ -29,11 +32,11 @@
 
 		PowerPC,8349@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <20>;
-			i-cache-line-size = <20>;
-			d-cache-size = <8000>;
-			i-cache-size = <8000>;
+			reg = <0x0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
@@ -42,21 +45,21 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 10000000>;
+		reg = <0x00000000 0x10000000>;
 	};
 
 	soc8349@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		ranges = <0 e0000000 00100000>;
-		reg = <e0000000 00000200>;
+		ranges = <0x0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;                    // from bootloader
 
 		wdt@200 {
 			device_type = "watchdog";
 			compatible = "mpc83xx_wdt";
-			reg = <200 100>;
+			reg = <0x200 0x100>;
 		};
 
 		i2c@3000 {
@@ -64,9 +67,9 @@
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
 		};
 
@@ -75,39 +78,39 @@
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
 			cell-index = <0>;
 			compatible = "fsl,spi";
-			reg = <7000 1000>;
-			interrupts = <10 8>;
-			interrupt-parent = < &ipic >;
+			reg = <0x7000 0x1000>;
+			interrupts = <16 0x8>;
+			interrupt-parent = <&ipic>;
 			mode = "cpu";
 		};
 
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
 			dr_mode = "peripheral";
 			phy_type = "ulpi";
 		};
@@ -116,13 +119,13 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,gianfar-mdio";
-			reg = <24520 20>;
+			reg = <0x24520 0x20>;
 
 			/* Vitesse 8201 */
 			phy1c: ethernet-phy@1c {
-				interrupt-parent = < &ipic >;
-				interrupts = <12 8>;
-				reg = <1c>;
+				interrupt-parent = <&ipic>;
+				interrupts = <18 0x8>;
+				reg = <0x1c>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -132,11 +135,11 @@
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
-			reg = <24000 1000>;
+			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <20 8 21 8 22 8>;
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy1c >;
+			interrupts = <32 0x8 33 0x8 34 0x8>;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy1c>;
 			linux,network-index = <0>;
 		};
 
@@ -145,12 +148,12 @@
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
-			reg = <25000 1000>;
+			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <23 8 24 8 25 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <35 0x8 36 0x8 37 0x8>;
+			interrupt-parent = <&ipic>;
 			/* Vitesse 7385 isn't on the MDIO bus */
-			fixed-link = <1 1 d#1000 0 0>;
+			fixed-link = <1 1 1000 0 0>;
 			linux,network-index = <1>;
 		};
 
@@ -158,88 +161,88 @@
 			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4500 100>;
+			reg = <0x4500 0x100>;
 			clock-frequency = <0>;		// from bootloader
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
 			clock-frequency = <0>;		// from bootloader
-			interrupts = <a 8>;
-			interrupt-parent = < &ipic >;
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
-			descriptor-types-mask = <01010ebf>;
+			channel-fifo-len = <24>;
+			exec-units-mask = <0x0000007e>;
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
 	};
 
 	pci0: pci@e0008500 {
 		cell-index = <1>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 				/* IDSEL 0x10 - SATA */
-				8000 0 0 1 &ipic 16 8 /* SATA_INTA */
+				0x8000 0x0 0x0 0x1 &ipic 22 0x8 /* SATA_INTA */
 				>;
-		interrupt-parent = < &ipic >;
-		interrupts = <42 8>;
-		bus-range = <0 0>;
-		ranges = <42000000 0 80000000 80000000 0 10000000
-			  02000000 0 90000000 90000000 0 10000000
-			  01000000 0 00000000 e2000000 0 01000000>;
-		clock-frequency = <3f940aa>;
+		interrupt-parent = <&ipic>;
+		interrupts = <66 0x8>;
+		bus-range = <0x0 0x0>;
+		ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+			  0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x01000000>;
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
 				/* IDSEL 0x0E - MiniPCI Slot */
-				7000 0 0 1 &ipic 15 8 /* PCI_INTA */
+				0x7000 0x0 0x0 0x1 &ipic 21 0x8 /* PCI_INTA */
 
 				/* IDSEL 0x0F - PCI Slot */
-				7800 0 0 1 &ipic 14 8 /* PCI_INTA */
-				7800 0 0 2 &ipic 15 8 /* PCI_INTB */
-				 >;
-		interrupt-parent = < &ipic >;
-		interrupts = <43 8>;
-		bus-range = <0 0>;
-		ranges = <42000000 0 a0000000 a0000000 0 10000000
-			  02000000 0 b0000000 b0000000 0 10000000
-			  01000000 0 00000000 e3000000 0 01000000>;
-		clock-frequency = <3f940aa>;
+				0x7800 0x0 0x0 0x1 &ipic 20 0x8 /* PCI_INTA */
+				0x7800 0x0 0x0 0x2 &ipic 21 0x8 /* PCI_INTB */
+				>;
+		interrupt-parent = <&ipic>;
+		interrupts = <67 0x8>;
+		bus-range = <0x0 0x0>;
+		ranges = <0x42000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
+			  0x02000000 0x0 0xb0000000 0xb0000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xe3000000 0x0 0x01000000>;
+		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <e0008600 100>;
+		reg = <0xe0008600 0x100>;
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
@@ -249,15 +252,15 @@
 		#size-cells = <1>;
 		compatible = "fsl,mpc8349e-localbus",
 			     "fsl,pq2pro-localbus";
-		reg = <e0005000 d8>;
-		ranges = <3 0 f0000000 210>;
+		reg = <0xe0005000 0xd8>;
+		ranges = <0x3 0x0 0xf0000000 0x210>;
 
 		pata@3,0 {
 			compatible = "fsl,mpc8349emitx-pata", "ata-generic";
-			reg = <3 0 10 3 20c 4>;
+			reg = <0x3 0x0 0x10 0x3 0x20c 0x4>;
 			reg-shift = <1>;
 			pio-mode = <6>;
-			interrupts = <17 8>;
+			interrupts = <23 0x8>;
 			interrupt-parent = <&ipic>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index 79983d7..f81d735 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -8,6 +8,9 @@
  * Free Software Foundation; either version 2 of the License, or (at your
  * option) any later version.
  */
+
+/dts-v1/;
+
 / {
 	model = "MPC8349EMITXGP";
 	compatible = "MPC8349EMITXGP", "MPC834xMITX", "MPC83xxMITX";
@@ -27,11 +30,11 @@
 
 		PowerPC,8349@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <20>;
-			i-cache-line-size = <20>;
-			d-cache-size = <8000>;
-			i-cache-size = <8000>;
+			reg = <0x0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
@@ -40,21 +43,21 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 10000000>;
+		reg = <0x00000000 0x10000000>;
 	};
 
 	soc8349@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		ranges = <0 e0000000 00100000>;
-		reg = <e0000000 00000200>;
+		ranges = <0x0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;                    // from bootloader
 
 		wdt@200 {
 			device_type = "watchdog";
 			compatible = "mpc83xx_wdt";
-			reg = <200 100>;
+			reg = <0x200 0x100>;
 		};
 
 		i2c@3000 {
@@ -62,9 +65,9 @@
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
 		};
 
@@ -73,28 +76,28 @@
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
 			cell-index = <0>;
 			compatible = "fsl,spi";
-			reg = <7000 1000>;
-			interrupts = <10 8>;
-			interrupt-parent = < &ipic >;
+			reg = <0x7000 0x1000>;
+			interrupts = <16 0x8>;
+			interrupt-parent = <&ipic>;
 			mode = "cpu";
 		};
 
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
@@ -103,13 +106,13 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,gianfar-mdio";
-			reg = <24520 20>;
+			reg = <0x24520 0x20>;
 
 			/* Vitesse 8201 */
 			phy1c: ethernet-phy@1c {
-				interrupt-parent = < &ipic >;
-				interrupts = <12 8>;
-				reg = <1c>;
+				interrupt-parent = <&ipic>;
+				interrupts = <18 0x8>;
+				reg = <0x1c>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -119,11 +122,11 @@
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
-			reg = <24000 1000>;
+			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <20 8 21 8 22 8>;
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy1c >;
+			interrupts = <32 0x8 33 0x8 34 0x8>;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy1c>;
 			linux,network-index = <0>;
 		};
 
@@ -131,63 +134,63 @@
 			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4500 100>;
+			reg = <0x4500 0x100>;
 			clock-frequency = <0>;		// from bootloader
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
 			clock-frequency = <0>;		// from bootloader
-			interrupts = <a 8>;
-			interrupt-parent = < &ipic >;
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
-			descriptor-types-mask = <01010ebf>;
+			channel-fifo-len = <24>;
+			exec-units-mask = <0x0000007e>;
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
 	};
 
 	pci0: pci@e0008600 {
 		cell-index = <2>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 				/* IDSEL 0x0F - PCI Slot */
-				7800 0 0 1 &ipic 14 8 /* PCI_INTA */
-				7800 0 0 2 &ipic 15 8 /* PCI_INTB */
+				0x7800 0x0 0x0 0x1 &ipic 20 0x8 /* PCI_INTA */
+				0x7800 0x0 0x0 0x2 &ipic 21 0x8 /* PCI_INTB */
 				 >;
-		interrupt-parent = < &ipic >;
-		interrupts = <43 8>;
-		bus-range = <1 1>;
-		ranges = <42000000 0 a0000000 a0000000 0 10000000
-			  02000000 0 b0000000 b0000000 0 10000000
-			  01000000 0 00000000 e3000000 0 01000000>;
-		clock-frequency = <3f940aa>;
+		interrupt-parent = <&ipic>;
+		interrupts = <67 0x8>;
+		bus-range = <0x1 0x1>;
+		ranges = <0x42000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
+			  0x02000000 0x0 0xb0000000 0xb0000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xe3000000 0x0 0x01000000>;
+		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <e0008600 100>;
+		reg = <0xe0008600 0x100>;
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 8faa8bd..7480eda 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -32,7 +32,7 @@
 
 		PowerPC,8349@0 {
 			device_type = "cpu";
-			reg = <0>;
+			reg = <0x0>;
 			d-cache-line-size = <32>;
 			i-cache-line-size = <32>;
 			d-cache-size = <32768>;
@@ -73,7 +73,7 @@
 			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <14 8>;
+			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
 			dfsrr;
 
@@ -89,7 +89,7 @@
 			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <15 8>;
+			interrupts = <15 0x8>;
 			interrupt-parent = <&ipic>;
 			dfsrr;
 		};
@@ -98,7 +98,7 @@
 			cell-index = <0>;
 			compatible = "fsl,spi";
 			reg = <0x7000 0x1000>;
-			interrupts = <16 8>;
+			interrupts = <16 0x8>;
 			interrupt-parent = <&ipic>;
 			mode = "cpu";
 		};
@@ -111,7 +111,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupt-parent = <&ipic>;
-			interrupts = <39 8>;
+			interrupts = <39 0x8>;
 			phy_type = "ulpi";
 			port1;
 		};
@@ -122,7 +122,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupt-parent = <&ipic>;
-			interrupts = <38 8>;
+			interrupts = <38 0x8>;
 			dr_mode = "otg";
 			phy_type = "ulpi";
 		};
@@ -135,13 +135,13 @@
 
 			phy0: ethernet-phy@0 {
 				interrupt-parent = <&ipic>;
-				interrupts = <17 8>;
+				interrupts = <17 0x8>;
 				reg = <0x0>;
 				device_type = "ethernet-phy";
 			};
 			phy1: ethernet-phy@1 {
 				interrupt-parent = <&ipic>;
-				interrupts = <18 8>;
+				interrupts = <18 0x8>;
 				reg = <0x1>;
 				device_type = "ethernet-phy";
 			};
@@ -154,7 +154,7 @@
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <32 8 33 8 34 8>;
+			interrupts = <32 0x8 33 0x8 34 0x8>;
 			interrupt-parent = <&ipic>;
 			phy-handle = <&phy0>;
 			linux,network-index = <0>;
@@ -167,7 +167,7 @@
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 8 36 8 37 8>;
+			interrupts = <35 0x8 36 0x8 37 0x8>;
 			interrupt-parent = <&ipic>;
 			phy-handle = <&phy1>;
 			linux,network-index = <1>;
@@ -179,7 +179,7 @@
 			compatible = "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <9 8>;
+			interrupts = <9 0x8>;
 			interrupt-parent = <&ipic>;
 		};
 
@@ -189,7 +189,7 @@
 			compatible = "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <10 8>;
+			interrupts = <10 0x8>;
 			interrupt-parent = <&ipic>;
 		};
 
@@ -199,10 +199,10 @@
 			model = "SEC2";
 			compatible = "talitos";
 			reg = <0x30000 0x10000>;
-			interrupts = <11 8>;
+			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
 			num-channels = <4>;
-			channel-fifo-len = <0x18>;
+			channel-fifo-len = <24>;
 			exec-units-mask = <0x0000007e>;
 			/* desc mask is for rev2.0,
 			 * we need runtime fixup for >2.0 */
@@ -269,9 +269,9 @@
 				 0xc000 0x0 0x0 0x1 &ipic 21 0x8
 				 0xc000 0x0 0x0 0x2 &ipic 22 0x8
 				 0xc000 0x0 0x0 0x3 &ipic 23 0x8
-				 0xc000 0x0 0x0 0x4 &ipic 20 8>;
+				 0xc000 0x0 0x0 0x4 &ipic 20 0x8>;
 		interrupt-parent = <&ipic>;
-		interrupts = <66 8>;
+		interrupts = <66 0x8>;
 		bus-range = <0 0>;
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 			  0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
@@ -330,9 +330,9 @@
 				 0xc000 0x0 0x0 0x1 &ipic 21 0x8
 				 0xc000 0x0 0x0 0x2 &ipic 22 0x8
 				 0xc000 0x0 0x0 0x3 &ipic 23 0x8
-				 0xc000 0x0 0x0 0x4 &ipic 20 8>;
+				 0xc000 0x0 0x0 0x4 &ipic 20 0x8>;
 		interrupt-parent = <&ipic>;
-		interrupts = <66 8>;
+		interrupts = <66 0x8>;
 		bus-range = <0 0>;
 		ranges = <0x02000000 0x0 0xb0000000 0xb0000000 0x0 0x10000000
 			  0x42000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index dc6caf0..55f03e8 100644
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
@@ -34,39 +36,39 @@
 
 		PowerPC,8360@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
-			d-cache-size = <8000>;		// L1, 32K
-			i-cache-size = <8000>;		// L1, 32K
-			timebase-frequency = <3EF1480>;
-			bus-frequency = <FBC5200>;
-			clock-frequency = <1F78A400>;
+			reg = <0x0>;
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
+			channel-fifo-len = <24>;
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
@@ -208,47 +210,47 @@
 		#size-cells = <1>;
 		device_type = "qe";
 		compatible = "fsl,qe";
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
 			compatible = "fsl,qe-muram", "fsl,cpm-muram";
-			ranges = <0 00010000 0000c000>;
+			ranges = <0x0 0x00010000 0x0000c000>;
 
 			data-only@0 {
 				compatible = "fsl,qe-muram-data",
 					     "fsl,cpm-muram-data";
-				reg = <0 c000>;
+				reg = <0x0 0xc000>;
 			};
 		};
 
 		spi@4c0 {
 			cell-index = <0>;
 			compatible = "fsl,spi";
-			reg = <4c0 40>;
+			reg = <0x4c0 0x40>;
 			interrupts = <2>;
-			interrupt-parent = < &qeic >;
+			interrupt-parent = <&qeic>;
 			mode = "cpu";
 		};
 
 		spi@500 {
 			cell-index = <1>;
 			compatible = "fsl,spi";
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
 
@@ -258,15 +260,15 @@
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
@@ -275,33 +277,33 @@
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
 			compatible = "fsl,ucc-mdio";
 
 			phy0: ethernet-phy@00 {
-				interrupt-parent = < &ipic >;
-				interrupts = <11 8>;
-				reg = <0>;
+				interrupt-parent = <&ipic>;
+				interrupts = <17 0x8>;
+				reg = <0x0>;
 				device_type = "ethernet-phy";
 			};
 			phy1: ethernet-phy@01 {
-				interrupt-parent = < &ipic >;
-				interrupts = <12 8>;
-				reg = <1>;
+				interrupt-parent = <&ipic>;
+				interrupts = <18 0x8>;
+				reg = <0x1>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -311,70 +313,70 @@
 			compatible = "fsl,qe-ic";
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
diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 3b9611f..a3637ff 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -31,11 +31,11 @@
 
 		PowerPC,8377@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <0x20>;
-			i-cache-line-size = <0x20>;
-			d-cache-size = <0x8000>;		// L1, 32K
-			i-cache-size = <0x8000>;		// L1, 32K
+			reg = <0x0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
@@ -66,8 +66,8 @@
 			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <0xe 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <14 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 		};
 
@@ -77,8 +77,8 @@
 			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <0xf 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <15 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 		};
 
@@ -86,8 +86,8 @@
 			cell-index = <0>;
 			compatible = "fsl,spi";
 			reg = <0x7000 0x1000>;
-			interrupts = <0x10 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <16 0x8>;
+			interrupt-parent = <&ipic>;
 			mode = "cpu";
 		};
 
@@ -97,8 +97,8 @@
 			reg = <0x23000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = < &ipic >;
-			interrupts = <0x26 0x8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <38 0x8>;
 			phy_type = "utmi_wide";
 		};
 
@@ -108,15 +108,15 @@
 			compatible = "fsl,gianfar-mdio";
 			reg = <0x24520 0x20>;
 			phy2: ethernet-phy@2 {
-				interrupt-parent = < &ipic >;
-				interrupts = <0x11 0x8>;
-				reg = <2>;
+				interrupt-parent = <&ipic>;
+				interrupts = <17 0x8>;
+				reg = <0x2>;
 				device_type = "ethernet-phy";
 			};
 			phy3: ethernet-phy@3 {
-				interrupt-parent = < &ipic >;
-				interrupts = <0x12 0x8>;
-				reg = <3>;
+				interrupt-parent = <&ipic>;
+				interrupts = <18 0x8>;
+				reg = <0x3>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -128,10 +128,10 @@
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x20 0x8 0x21 0x8 0x22 0x8>;
+			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy2 >;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy2>;
 		};
 
 		enet1: ethernet@25000 {
@@ -141,10 +141,10 @@
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x23 0x8 0x24 0x8 0x25 0x8>;
+			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy3 >;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy3>;
 		};
 
 		serial0: serial@4500 {
@@ -153,8 +153,8 @@
 			compatible = "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <0x9 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <9 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		serial1: serial@4600 {
@@ -163,19 +163,19 @@
 			compatible = "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <0xa 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <10 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		crypto@30000 {
 			model = "SEC3";
 			compatible = "talitos";
 			reg = <0x30000 0x10000>;
-			interrupts = <0xb 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <11 0x8>;
+			interrupt-parent = <&ipic>;
 			/* Rev. 3.0 geometry */
 			num-channels = <4>;
-			channel-fifo-len = <0x18>;
+			channel-fifo-len = <24>;
 			exec-units-mask = <0x000001fe>;
 			descriptor-types-mask = <0x03ab0ebf>;
 		};
@@ -184,22 +184,22 @@
 			model = "eSDHC";
 			compatible = "fsl,esdhc";
 			reg = <0x2e000 0x1000>;
-			interrupts = <0x2a 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <42 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		sata@18000 {
 			compatible = "fsl,mpc8379-sata";
 			reg = <0x18000 0x1000>;
-			interrupts = <0x2c 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <44 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		sata@19000 {
 			compatible = "fsl,mpc8379-sata";
 			reg = <0x19000 0x1000>;
-			interrupts = <0x2d 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <45 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		/* IPIC
@@ -223,49 +223,49 @@
 		interrupt-map = <
 
 				/* IDSEL 0x11 */
-				 0x8800 0x0 0x0 0x1 &ipic 0x14 0x8
-				 0x8800 0x0 0x0 0x2 &ipic 0x15 0x8
-				 0x8800 0x0 0x0 0x3 &ipic 0x16 0x8
-				 0x8800 0x0 0x0 0x4 &ipic 0x17 0x8
+				 0x8800 0x0 0x0 0x1 &ipic 20 0x8
+				 0x8800 0x0 0x0 0x2 &ipic 21 0x8
+				 0x8800 0x0 0x0 0x3 &ipic 22 0x8
+				 0x8800 0x0 0x0 0x4 &ipic 23 0x8
 
 				/* IDSEL 0x12 */
-				 0x9000 0x0 0x0 0x1 &ipic 0x16 0x8
-				 0x9000 0x0 0x0 0x2 &ipic 0x17 0x8
-				 0x9000 0x0 0x0 0x3 &ipic 0x14 0x8
-				 0x9000 0x0 0x0 0x4 &ipic 0x15 0x8
+				 0x9000 0x0 0x0 0x1 &ipic 22 0x8
+				 0x9000 0x0 0x0 0x2 &ipic 23 0x8
+				 0x9000 0x0 0x0 0x3 &ipic 20 0x8
+				 0x9000 0x0 0x0 0x4 &ipic 21 0x8
 
 				/* IDSEL 0x13 */
-				 0x9800 0x0 0x0 0x1 &ipic 0x17 0x8
-				 0x9800 0x0 0x0 0x2 &ipic 0x14 0x8
-				 0x9800 0x0 0x0 0x3 &ipic 0x15 0x8
-				 0x9800 0x0 0x0 0x4 &ipic 0x16 0x8
+				 0x9800 0x0 0x0 0x1 &ipic 23 0x8
+				 0x9800 0x0 0x0 0x2 &ipic 20 0x8
+				 0x9800 0x0 0x0 0x3 &ipic 21 0x8
+				 0x9800 0x0 0x0 0x4 &ipic 22 0x8
 
 				/* IDSEL 0x15 */
-				 0xa800 0x0 0x0 0x1 &ipic 0x14 0x8
-				 0xa800 0x0 0x0 0x2 &ipic 0x15 0x8
-				 0xa800 0x0 0x0 0x3 &ipic 0x16 0x8
-				 0xa800 0x0 0x0 0x4 &ipic 0x17 0x8
+				 0xa800 0x0 0x0 0x1 &ipic 20 0x8
+				 0xa800 0x0 0x0 0x2 &ipic 21 0x8
+				 0xa800 0x0 0x0 0x3 &ipic 22 0x8
+				 0xa800 0x0 0x0 0x4 &ipic 23 0x8
 
 				/* IDSEL 0x16 */
-				 0xb000 0x0 0x0 0x1 &ipic 0x17 0x8
-				 0xb000 0x0 0x0 0x2 &ipic 0x14 0x8
-				 0xb000 0x0 0x0 0x3 &ipic 0x15 0x8
-				 0xb000 0x0 0x0 0x4 &ipic 0x16 0x8
+				 0xb000 0x0 0x0 0x1 &ipic 23 0x8
+				 0xb000 0x0 0x0 0x2 &ipic 20 0x8
+				 0xb000 0x0 0x0 0x3 &ipic 21 0x8
+				 0xb000 0x0 0x0 0x4 &ipic 22 0x8
 
 				/* IDSEL 0x17 */
-				 0xb800 0x0 0x0 0x1 &ipic 0x16 0x8
-				 0xb800 0x0 0x0 0x2 &ipic 0x17 0x8
-				 0xb800 0x0 0x0 0x3 &ipic 0x14 0x8
-				 0xb800 0x0 0x0 0x4 &ipic 0x15 0x8
+				 0xb800 0x0 0x0 0x1 &ipic 22 0x8
+				 0xb800 0x0 0x0 0x2 &ipic 23 0x8
+				 0xb800 0x0 0x0 0x3 &ipic 20 0x8
+				 0xb800 0x0 0x0 0x4 &ipic 21 0x8
 
 				/* IDSEL 0x18 */
-				 0xc000 0x0 0x0 0x1 &ipic 0x15 0x8
-				 0xc000 0x0 0x0 0x2 &ipic 0x16 0x8
-				 0xc000 0x0 0x0 0x3 &ipic 0x17 0x8
-				 0xc000 0x0 0x0 0x4 &ipic 0x14 0x8>;
-		interrupt-parent = < &ipic >;
-		interrupts = <0x42 0x8>;
-		bus-range = <0 0>;
+				 0xc000 0x0 0x0 0x1 &ipic 21 0x8
+				 0xc000 0x0 0x0 0x2 &ipic 22 0x8
+				 0xc000 0x0 0x0 0x3 &ipic 23 0x8
+				 0xc000 0x0 0x0 0x4 &ipic 20 0x8>;
+		interrupt-parent = <&ipic>;
+		interrupts = <66 0x8>;
+		bus-range = <0x0 0x0>;
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 		          0x01000000 0x0 0x00000000 0xe0300000 0x0 0x00100000>;
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 8fe02cc..95b9d50 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -30,7 +30,7 @@
 
 		PowerPC,8377@0 {
 			device_type = "cpu";
-			reg = <0>;
+			reg = <0x0>;
 			d-cache-line-size = <32>;
 			i-cache-line-size = <32>;
 			d-cache-size = <32768>;
@@ -51,22 +51,22 @@
 		#size-cells = <1>;
 		compatible = "fsl,mpc8377-elbc", "fsl,elbc", "simple-bus";
 		reg = <0xe0005000 0x1000>;
-		interrupts = <77 8>;
+		interrupts = <77 0x8>;
 		interrupt-parent = <&ipic>;
 
 		// CS0 and CS1 are swapped when
 		// booting from nand, but the
 		// addresses are the same.
-		ranges = <0 0 0xfe000000 0x00800000
-		          1 0 0xe0600000 0x00008000
-		          2 0 0xf0000000 0x00020000
-		          3 0 0xfa000000 0x00008000>;
+		ranges = <0x0 0x0 0xfe000000 0x00800000
+		          0x1 0x0 0xe0600000 0x00008000
+		          0x2 0x0 0xf0000000 0x00020000
+		          0x3 0x0 0xfa000000 0x00008000>;
 
 		flash@0,0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "cfi-flash";
-			reg = <0 0 0x800000>;
+			reg = <0x0 0x0 0x800000>;
 			bank-width = <2>;
 			device-width = <1>;
 		};
@@ -76,7 +76,7 @@
 			#size-cells = <1>;
 			compatible = "fsl,mpc8377-fcm-nand",
 			             "fsl,elbc-fcm-nand";
-			reg = <1 0 0x8000>;
+			reg = <0x1 0x0 0x8000>;
 
 			u-boot@0 {
 				reg = <0x0 0x100000>;
@@ -97,7 +97,7 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		compatible = "simple-bus";
-		ranges = <0 0xe0000000 0x00100000>;
+		ranges = <0x0 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;
 
@@ -113,8 +113,8 @@
 			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <14 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <14 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 			rtc@68 {
 				device_type = "rtc";
@@ -129,8 +129,8 @@
 			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <15 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <15 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 		};
 
@@ -138,8 +138,8 @@
 			cell-index = <0>;
 			compatible = "fsl,spi";
 			reg = <0x7000 0x1000>;
-			interrupts = <16 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <16 0x8>;
+			interrupt-parent = <&ipic>;
 			mode = "cpu";
 		};
 
@@ -149,8 +149,8 @@
 			reg = <0x23000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = < &ipic >;
-			interrupts = <38 8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <38 0x8>;
 			phy_type = "utmi";
 		};
 
@@ -160,15 +160,15 @@
 			compatible = "fsl,gianfar-mdio";
 			reg = <0x24520 0x20>;
 			phy2: ethernet-phy@2 {
-				interrupt-parent = < &ipic >;
-				interrupts = <17 8>;
-				reg = <2>;
+				interrupt-parent = <&ipic>;
+				interrupts = <17 0x8>;
+				reg = <0x2>;
 				device_type = "ethernet-phy";
 			};
 			phy3: ethernet-phy@3 {
-				interrupt-parent = < &ipic >;
-				interrupts = <18 8>;
-				reg = <3>;
+				interrupt-parent = <&ipic>;
+				interrupts = <18 0x8>;
+				reg = <0x3>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -180,10 +180,10 @@
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <32 8 33 8 34 8>;
+			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy2 >;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy2>;
 		};
 
 		enet1: ethernet@25000 {
@@ -193,10 +193,10 @@
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 8 36 8 37 8>;
+			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy3 >;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy3>;
 		};
 
 		serial0: serial@4500 {
@@ -205,8 +205,8 @@
 			compatible = "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <9 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <9 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		serial1: serial@4600 {
@@ -215,8 +215,8 @@
 			compatible = "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <10 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <10 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		crypto@30000 {
@@ -224,8 +224,8 @@
 			device_type = "crypto";
 			compatible = "talitos";
 			reg = <0x30000 0x10000>;
-			interrupts = <11 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <11 0x8>;
+			interrupt-parent = <&ipic>;
 			/* Rev. 3.0 geometry */
 			num-channels = <4>;
 			channel-fifo-len = <24>;
@@ -236,15 +236,15 @@
 		sata@18000 {
 			compatible = "fsl,mpc8377-sata", "fsl,pq-sata";
 			reg = <0x18000 0x1000>;
-			interrupts = <44 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <44 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		sata@19000 {
 			compatible = "fsl,mpc8377-sata", "fsl,pq-sata";
 			reg = <0x19000 0x1000>;
-			interrupts = <45 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <45 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		/* IPIC
@@ -268,23 +268,23 @@
 				/* IRQ5 = 21 = 0x15, IRQ6 = 0x16, IRQ7 = 23 = 0x17 */
 
 				/* IDSEL AD14 IRQ6 inta */
-				 0x7000 0 0 1 &ipic 22 8
+				 0x7000 0x0 0x0 0x1 &ipic 22 0x8
 
 				/* IDSEL AD15 IRQ5 inta, IRQ6 intb, IRQ7 intd */
-				 0x7800 0 0 1 &ipic 21 8
-				 0x7800 0 0 2 &ipic 22 8
-				 0x7800 0 0 4 &ipic 23 8
+				 0x7800 0x0 0x0 0x1 &ipic 21 0x8
+				 0x7800 0x0 0x0 0x2 &ipic 22 0x8
+				 0x7800 0x0 0x0 0x4 &ipic 23 0x8
 
 				/* IDSEL AD28 IRQ7 inta, IRQ5 intb IRQ6 intc*/
-				 0xE000 0 0 1 &ipic 23 8
-				 0xE000 0 0 2 &ipic 21 8
-				 0xE000 0 0 3 &ipic 22 8>;
-		interrupt-parent = < &ipic >;
-		interrupts = <66 8>;
+				 0xE000 0x0 0x0 0x1 &ipic 23 0x8
+				 0xE000 0x0 0x0 0x2 &ipic 21 0x8
+				 0xE000 0x0 0x0 0x3 &ipic 22 0x8>;
+		interrupt-parent = <&ipic>;
+		interrupts = <66 0x8>;
 		bus-range = <0 0>;
-		ranges = <0x02000000 0 0x90000000 0x90000000 0 0x10000000
-		          0x42000000 0 0x80000000 0x80000000 0 0x10000000
-		          0x01000000 0 0x00000000 0xe2000000 0 0x00100000>;
+		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
+		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+		          0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
 		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index 386f4a0..533e9b0 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -31,11 +31,11 @@
 
 		PowerPC,8378@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <0x20>;
-			i-cache-line-size = <0x20>;
-			d-cache-size = <0x8000>;		// L1, 32K
-			i-cache-size = <0x8000>;		// L1, 32K
+			reg = <0x0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
@@ -66,8 +66,8 @@
 			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <0xe 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <14 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 		};
 
@@ -77,8 +77,8 @@
 			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <0xf 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <15 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 		};
 
@@ -86,8 +86,8 @@
 			cell-index = <0>;
 			compatible = "fsl,spi";
 			reg = <0x7000 0x1000>;
-			interrupts = <0x10 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <16 0x8>;
+			interrupt-parent = <&ipic>;
 			mode = "cpu";
 		};
 
@@ -97,8 +97,8 @@
 			reg = <0x23000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = < &ipic >;
-			interrupts = <0x26 0x8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <38 0x8>;
 			phy_type = "utmi_wide";
 		};
 
@@ -108,15 +108,15 @@
 			compatible = "fsl,gianfar-mdio";
 			reg = <0x24520 0x20>;
 			phy2: ethernet-phy@2 {
-				interrupt-parent = < &ipic >;
-				interrupts = <0x11 0x8>;
-				reg = <2>;
+				interrupt-parent = <&ipic>;
+				interrupts = <17 0x8>;
+				reg = <0x2>;
 				device_type = "ethernet-phy";
 			};
 			phy3: ethernet-phy@3 {
-				interrupt-parent = < &ipic >;
-				interrupts = <0x12 0x8>;
-				reg = <3>;
+				interrupt-parent = <&ipic>;
+				interrupts = <18 0x8>;
+				reg = <0x3>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -128,10 +128,10 @@
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x20 0x8 0x21 0x8 0x22 0x8>;
+			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy2 >;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy2>;
 		};
 
 		enet1: ethernet@25000 {
@@ -141,10 +141,10 @@
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x23 0x8 0x24 0x8 0x25 0x8>;
+			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy3 >;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy3>;
 		};
 
 		serial0: serial@4500 {
@@ -153,8 +153,8 @@
 			compatible = "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <0x9 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <9 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		serial1: serial@4600 {
@@ -163,19 +163,19 @@
 			compatible = "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <0xa 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <10 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		crypto@30000 {
 			model = "SEC3";
 			compatible = "talitos";
 			reg = <0x30000 0x10000>;
-			interrupts = <0xb 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <11 0x8>;
+			interrupt-parent = <&ipic>;
 			/* Rev. 3.0 geometry */
 			num-channels = <4>;
-			channel-fifo-len = <0x18>;
+			channel-fifo-len = <24>;
 			exec-units-mask = <0x000001fe>;
 			descriptor-types-mask = <0x03ab0ebf>;
 		};
@@ -184,8 +184,8 @@
 			model = "eSDHC";
 			compatible = "fsl,esdhc";
 			reg = <0x2e000 0x1000>;
-			interrupts = <0x2a 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <42 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		/* IPIC
@@ -209,49 +209,49 @@
 		interrupt-map = <
 
 				/* IDSEL 0x11 */
-				 0x8800 0x0 0x0 0x1 &ipic 0x14 0x8
-				 0x8800 0x0 0x0 0x2 &ipic 0x15 0x8
-				 0x8800 0x0 0x0 0x3 &ipic 0x16 0x8
-				 0x8800 0x0 0x0 0x4 &ipic 0x17 0x8
+				 0x8800 0x0 0x0 0x1 &ipic 20 0x8
+				 0x8800 0x0 0x0 0x2 &ipic 21 0x8
+				 0x8800 0x0 0x0 0x3 &ipic 22 0x8
+				 0x8800 0x0 0x0 0x4 &ipic 23 0x8
 
 				/* IDSEL 0x12 */
-				 0x9000 0x0 0x0 0x1 &ipic 0x16 0x8
-				 0x9000 0x0 0x0 0x2 &ipic 0x17 0x8
-				 0x9000 0x0 0x0 0x3 &ipic 0x14 0x8
-				 0x9000 0x0 0x0 0x4 &ipic 0x15 0x8
+				 0x9000 0x0 0x0 0x1 &ipic 22 0x8
+				 0x9000 0x0 0x0 0x2 &ipic 23 0x8
+				 0x9000 0x0 0x0 0x3 &ipic 20 0x8
+				 0x9000 0x0 0x0 0x4 &ipic 21 0x8
 
 				/* IDSEL 0x13 */
-				 0x9800 0x0 0x0 0x1 &ipic 0x17 0x8
-				 0x9800 0x0 0x0 0x2 &ipic 0x14 0x8
-				 0x9800 0x0 0x0 0x3 &ipic 0x15 0x8
-				 0x9800 0x0 0x0 0x4 &ipic 0x16 0x8
+				 0x9800 0x0 0x0 0x1 &ipic 23 0x8
+				 0x9800 0x0 0x0 0x2 &ipic 20 0x8
+				 0x9800 0x0 0x0 0x3 &ipic 21 0x8
+				 0x9800 0x0 0x0 0x4 &ipic 22 0x8
 
 				/* IDSEL 0x15 */
-				 0xa800 0x0 0x0 0x1 &ipic 0x14 0x8
-				 0xa800 0x0 0x0 0x2 &ipic 0x15 0x8
-				 0xa800 0x0 0x0 0x3 &ipic 0x16 0x8
-				 0xa800 0x0 0x0 0x4 &ipic 0x17 0x8
+				 0xa800 0x0 0x0 0x1 &ipic 20 0x8
+				 0xa800 0x0 0x0 0x2 &ipic 21 0x8
+				 0xa800 0x0 0x0 0x3 &ipic 22 0x8
+				 0xa800 0x0 0x0 0x4 &ipic 23 0x8
 
 				/* IDSEL 0x16 */
-				 0xb000 0x0 0x0 0x1 &ipic 0x17 0x8
-				 0xb000 0x0 0x0 0x2 &ipic 0x14 0x8
-				 0xb000 0x0 0x0 0x3 &ipic 0x15 0x8
-				 0xb000 0x0 0x0 0x4 &ipic 0x16 0x8
+				 0xb000 0x0 0x0 0x1 &ipic 23 0x8
+				 0xb000 0x0 0x0 0x2 &ipic 20 0x8
+				 0xb000 0x0 0x0 0x3 &ipic 21 0x8
+				 0xb000 0x0 0x0 0x4 &ipic 22 0x8
 
 				/* IDSEL 0x17 */
-				 0xb800 0x0 0x0 0x1 &ipic 0x16 0x8
-				 0xb800 0x0 0x0 0x2 &ipic 0x17 0x8
-				 0xb800 0x0 0x0 0x3 &ipic 0x14 0x8
-				 0xb800 0x0 0x0 0x4 &ipic 0x15 0x8
+				 0xb800 0x0 0x0 0x1 &ipic 22 0x8
+				 0xb800 0x0 0x0 0x2 &ipic 23 0x8
+				 0xb800 0x0 0x0 0x3 &ipic 20 0x8
+				 0xb800 0x0 0x0 0x4 &ipic 21 0x8
 
 				/* IDSEL 0x18 */
-				 0xc000 0x0 0x0 0x1 &ipic 0x15 0x8
-				 0xc000 0x0 0x0 0x2 &ipic 0x16 0x8
-				 0xc000 0x0 0x0 0x3 &ipic 0x17 0x8
-				 0xc000 0x0 0x0 0x4 &ipic 0x14 0x8>;
-		interrupt-parent = < &ipic >;
-		interrupts = <0x42 0x8>;
-		bus-range = <0 0>;
+				 0xc000 0x0 0x0 0x1 &ipic 21 0x8
+				 0xc000 0x0 0x0 0x2 &ipic 22 0x8
+				 0xc000 0x0 0x0 0x3 &ipic 23 0x8
+				 0xc000 0x0 0x0 0x4 &ipic 20 0x8>;
+		interrupt-parent = <&ipic>;
+		interrupts = <66 0x8>;
+		bus-range = <0x0 0x0>;
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 		          0x01000000 0x0 0x00000000 0xe0300000 0x0 0x00100000>;
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 33d490b..c4fc7d6 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -30,7 +30,7 @@
 
 		PowerPC,8378@0 {
 			device_type = "cpu";
-			reg = <0>;
+			reg = <0x0>;
 			d-cache-line-size = <32>;
 			i-cache-line-size = <32>;
 			d-cache-size = <32768>;
@@ -51,22 +51,22 @@
 		#size-cells = <1>;
 		compatible = "fsl,mpc8378-elbc", "fsl,elbc", "simple-bus";
 		reg = <0xe0005000 0x1000>;
-		interrupts = <77 8>;
+		interrupts = <77 0x8>;
 		interrupt-parent = <&ipic>;
 
 		// CS0 and CS1 are swapped when
 		// booting from nand, but the
 		// addresses are the same.
-		ranges = <0 0 0xfe000000 0x00800000
-		          1 0 0xe0600000 0x00008000
-		          2 0 0xf0000000 0x00020000
-		          3 0 0xfa000000 0x00008000>;
+		ranges = <0x0 0x0 0xfe000000 0x00800000
+		          0x1 0x0 0xe0600000 0x00008000
+		          0x2 0x0 0xf0000000 0x00020000
+		          0x3 0x0 0xfa000000 0x00008000>;
 
 		flash@0,0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "cfi-flash";
-			reg = <0 0 0x800000>;
+			reg = <0x0 0x0 0x800000>;
 			bank-width = <2>;
 			device-width = <1>;
 		};
@@ -76,7 +76,7 @@
 			#size-cells = <1>;
 			compatible = "fsl,mpc8378-fcm-nand",
 			             "fsl,elbc-fcm-nand";
-			reg = <1 0 0x8000>;
+			reg = <0x1 0x0 0x8000>;
 
 			u-boot@0 {
 				reg = <0x0 0x100000>;
@@ -97,7 +97,7 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		compatible = "simple-bus";
-		ranges = <0 0xe0000000 0x00100000>;
+		ranges = <0x0 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;
 
@@ -113,8 +113,8 @@
 			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <14 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <14 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 			rtc@68 {
 				device_type = "rtc";
@@ -129,8 +129,8 @@
 			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <15 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <15 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 		};
 
@@ -138,8 +138,8 @@
 			cell-index = <0>;
 			compatible = "fsl,spi";
 			reg = <0x7000 0x1000>;
-			interrupts = <16 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <16 0x8>;
+			interrupt-parent = <&ipic>;
 			mode = "cpu";
 		};
 
@@ -149,8 +149,8 @@
 			reg = <0x23000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = < &ipic >;
-			interrupts = <38 8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <38 0x8>;
 			phy_type = "utmi";
 		};
 
@@ -160,15 +160,15 @@
 			compatible = "fsl,gianfar-mdio";
 			reg = <0x24520 0x20>;
 			phy2: ethernet-phy@2 {
-				interrupt-parent = < &ipic >;
-				interrupts = <17 8>;
-				reg = <2>;
+				interrupt-parent = <&ipic>;
+				interrupts = <17 0x8>;
+				reg = <0x2>;
 				device_type = "ethernet-phy";
 			};
 			phy3: ethernet-phy@3 {
-				interrupt-parent = < &ipic >;
-				interrupts = <18 8>;
-				reg = <3>;
+				interrupt-parent = <&ipic>;
+				interrupts = <18 0x8>;
+				reg = <0x3>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -180,10 +180,10 @@
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <32 8 33 8 34 8>;
+			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy2 >;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy2>;
 		};
 
 		enet1: ethernet@25000 {
@@ -193,10 +193,10 @@
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 8 36 8 37 8>;
+			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy3 >;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy3>;
 		};
 
 		serial0: serial@4500 {
@@ -205,8 +205,8 @@
 			compatible = "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <9 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <9 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		serial1: serial@4600 {
@@ -215,8 +215,8 @@
 			compatible = "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <10 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <10 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		crypto@30000 {
@@ -224,8 +224,8 @@
 			device_type = "crypto";
 			compatible = "talitos";
 			reg = <0x30000 0x10000>;
-			interrupts = <11 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <11 0x8>;
+			interrupt-parent = <&ipic>;
 			/* Rev. 3.0 geometry */
 			num-channels = <4>;
 			channel-fifo-len = <24>;
@@ -254,23 +254,23 @@
 				/* IRQ5 = 21 = 0x15, IRQ6 = 0x16, IRQ7 = 23 = 0x17 */
 
 				/* IDSEL AD14 IRQ6 inta */
-				 0x7000 0 0 1 &ipic 22 8
+				 0x7000 0x0 0x0 0x1 &ipic 22 0x8
 
 				/* IDSEL AD15 IRQ5 inta, IRQ6 intb, IRQ7 intd */
-				 0x7800 0 0 1 &ipic 21 8
-				 0x7800 0 0 2 &ipic 22 8
-				 0x7800 0 0 4 &ipic 23 8
+				 0x7800 0x0 0x0 0x1 &ipic 21 0x8
+				 0x7800 0x0 0x0 0x2 &ipic 22 0x8
+				 0x7800 0x0 0x0 0x4 &ipic 23 0x8
 
 				/* IDSEL AD28 IRQ7 inta, IRQ5 intb IRQ6 intc*/
-				 0xE000 0 0 1 &ipic 23 8
-				 0xE000 0 0 2 &ipic 21 8
-				 0xE000 0 0 3 &ipic 22 8>;
-		interrupt-parent = < &ipic >;
-		interrupts = <66 8>;
+				 0xE000 0x0 0x0 0x1 &ipic 23 0x8
+				 0xE000 0x0 0x0 0x2 &ipic 21 0x8
+				 0xE000 0x0 0x0 0x3 &ipic 22 0x8>;
+		interrupt-parent = <&ipic>;
+		interrupts = <66 0x8>;
 		bus-range = <0 0>;
-		ranges = <0x02000000 0 0x90000000 0x90000000 0 0x10000000
-		          0x42000000 0 0x80000000 0x80000000 0 0x10000000
-		          0x01000000 0 0x00000000 0xe2000000 0 0x00100000>;
+		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
+		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+		          0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
 		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index da9931b..c270685 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -31,11 +31,11 @@
 
 		PowerPC,8379@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <0x20>;
-			i-cache-line-size = <0x20>;
-			d-cache-size = <0x8000>;		// L1, 32K
-			i-cache-size = <0x8000>;		// L1, 32K
+			reg = <0x0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
@@ -66,8 +66,8 @@
 			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <0xe 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <14 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 		};
 
@@ -77,8 +77,8 @@
 			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <0xf 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <15 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 		};
 
@@ -86,8 +86,8 @@
 			cell-index = <0>;
 			compatible = "fsl,spi";
 			reg = <0x7000 0x1000>;
-			interrupts = <0x10 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <16 0x8>;
+			interrupt-parent = <&ipic>;
 			mode = "cpu";
 		};
 
@@ -97,8 +97,8 @@
 			reg = <0x23000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = < &ipic >;
-			interrupts = <0x26 0x8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <38 0x8>;
 			phy_type = "utmi_wide";
 		};
 
@@ -108,15 +108,15 @@
 			compatible = "fsl,gianfar-mdio";
 			reg = <0x24520 0x20>;
 			phy2: ethernet-phy@2 {
-				interrupt-parent = < &ipic >;
-				interrupts = <0x11 0x8>;
-				reg = <2>;
+				interrupt-parent = <&ipic>;
+				interrupts = <17 0x8>;
+				reg = <0x2>;
 				device_type = "ethernet-phy";
 			};
 			phy3: ethernet-phy@3 {
-				interrupt-parent = < &ipic >;
-				interrupts = <0x12 0x8>;
-				reg = <3>;
+				interrupt-parent = <&ipic>;
+				interrupts = <18 0x8>;
+				reg = <0x3>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -128,10 +128,10 @@
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x20 0x8 0x21 0x8 0x22 0x8>;
+			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy2 >;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy2>;
 		};
 
 		enet1: ethernet@25000 {
@@ -141,10 +141,10 @@
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x23 0x8 0x24 0x8 0x25 0x8>;
+			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy3 >;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy3>;
 		};
 
 		serial0: serial@4500 {
@@ -153,8 +153,8 @@
 			compatible = "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <0x9 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <9 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		serial1: serial@4600 {
@@ -163,19 +163,19 @@
 			compatible = "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <0xa 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <10 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		crypto@30000 {
 			model = "SEC3";
 			compatible = "talitos";
 			reg = <0x30000 0x10000>;
-			interrupts = <0xb 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <11 0x8>;
+			interrupt-parent = <&ipic>;
 			/* Rev. 3.0 geometry */
 			num-channels = <4>;
-			channel-fifo-len = <0x18>;
+			channel-fifo-len = <24>;
 			exec-units-mask = <0x000001fe>;
 			descriptor-types-mask = <0x03ab0ebf>;
 		};
@@ -184,36 +184,36 @@
 			model = "eSDHC";
 			compatible = "fsl,esdhc";
 			reg = <0x2e000 0x1000>;
-			interrupts = <0x2a 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <42 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		sata@18000 {
 			compatible = "fsl,mpc8379-sata";
 			reg = <0x18000 0x1000>;
-			interrupts = <0x2c 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <44 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		sata@19000 {
 			compatible = "fsl,mpc8379-sata";
 			reg = <0x19000 0x1000>;
-			interrupts = <0x2d 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <45 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		sata@1a000 {
 			compatible = "fsl,mpc8379-sata";
 			reg = <0x1a000 0x1000>;
-			interrupts = <0x2e 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <46 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		sata@1b000 {
 			compatible = "fsl,mpc8379-sata";
 			reg = <0x1b000 0x1000>;
-			interrupts = <0x2f 0x8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <47 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		/* IPIC
@@ -237,49 +237,49 @@
 		interrupt-map = <
 
 				/* IDSEL 0x11 */
-				 0x8800 0x0 0x0 0x1 &ipic 0x14 0x8
-				 0x8800 0x0 0x0 0x2 &ipic 0x15 0x8
-				 0x8800 0x0 0x0 0x3 &ipic 0x16 0x8
-				 0x8800 0x0 0x0 0x4 &ipic 0x17 0x8
+				 0x8800 0x0 0x0 0x1 &ipic 20 0x8
+				 0x8800 0x0 0x0 0x2 &ipic 21 0x8
+				 0x8800 0x0 0x0 0x3 &ipic 22 0x8
+				 0x8800 0x0 0x0 0x4 &ipic 23 0x8
 
 				/* IDSEL 0x12 */
-				 0x9000 0x0 0x0 0x1 &ipic 0x16 0x8
-				 0x9000 0x0 0x0 0x2 &ipic 0x17 0x8
-				 0x9000 0x0 0x0 0x3 &ipic 0x14 0x8
-				 0x9000 0x0 0x0 0x4 &ipic 0x15 0x8
+				 0x9000 0x0 0x0 0x1 &ipic 22 0x8
+				 0x9000 0x0 0x0 0x2 &ipic 23 0x8
+				 0x9000 0x0 0x0 0x3 &ipic 20 0x8
+				 0x9000 0x0 0x0 0x4 &ipic 21 0x8
 
 				/* IDSEL 0x13 */
-				 0x9800 0x0 0x0 0x1 &ipic 0x17 0x8
-				 0x9800 0x0 0x0 0x2 &ipic 0x14 0x8
-				 0x9800 0x0 0x0 0x3 &ipic 0x15 0x8
-				 0x9800 0x0 0x0 0x4 &ipic 0x16 0x8
+				 0x9800 0x0 0x0 0x1 &ipic 23 0x8
+				 0x9800 0x0 0x0 0x2 &ipic 20 0x8
+				 0x9800 0x0 0x0 0x3 &ipic 21 0x8
+				 0x9800 0x0 0x0 0x4 &ipic 22 0x8
 
 				/* IDSEL 0x15 */
-				 0xa800 0x0 0x0 0x1 &ipic 0x14 0x8
-				 0xa800 0x0 0x0 0x2 &ipic 0x15 0x8
-				 0xa800 0x0 0x0 0x3 &ipic 0x16 0x8
-				 0xa800 0x0 0x0 0x4 &ipic 0x17 0x8
+				 0xa800 0x0 0x0 0x1 &ipic 20 0x8
+				 0xa800 0x0 0x0 0x2 &ipic 21 0x8
+				 0xa800 0x0 0x0 0x3 &ipic 22 0x8
+				 0xa800 0x0 0x0 0x4 &ipic 23 0x8
 
 				/* IDSEL 0x16 */
-				 0xb000 0x0 0x0 0x1 &ipic 0x17 0x8
-				 0xb000 0x0 0x0 0x2 &ipic 0x14 0x8
-				 0xb000 0x0 0x0 0x3 &ipic 0x15 0x8
-				 0xb000 0x0 0x0 0x4 &ipic 0x16 0x8
+				 0xb000 0x0 0x0 0x1 &ipic 23 0x8
+				 0xb000 0x0 0x0 0x2 &ipic 20 0x8
+				 0xb000 0x0 0x0 0x3 &ipic 21 0x8
+				 0xb000 0x0 0x0 0x4 &ipic 22 0x8
 
 				/* IDSEL 0x17 */
-				 0xb800 0x0 0x0 0x1 &ipic 0x16 0x8
-				 0xb800 0x0 0x0 0x2 &ipic 0x17 0x8
-				 0xb800 0x0 0x0 0x3 &ipic 0x14 0x8
-				 0xb800 0x0 0x0 0x4 &ipic 0x15 0x8
+				 0xb800 0x0 0x0 0x1 &ipic 22 0x8
+				 0xb800 0x0 0x0 0x2 &ipic 23 0x8
+				 0xb800 0x0 0x0 0x3 &ipic 20 0x8
+				 0xb800 0x0 0x0 0x4 &ipic 21 0x8
 
 				/* IDSEL 0x18 */
-				 0xc000 0x0 0x0 0x1 &ipic 0x15 0x8
-				 0xc000 0x0 0x0 0x2 &ipic 0x16 0x8
-				 0xc000 0x0 0x0 0x3 &ipic 0x17 0x8
-				 0xc000 0x0 0x0 0x4 &ipic 0x14 0x8>;
-		interrupt-parent = < &ipic >;
-		interrupts = <0x42 0x8>;
-		bus-range = <0 0>;
+				 0xc000 0x0 0x0 0x1 &ipic 21 0x8
+				 0xc000 0x0 0x0 0x2 &ipic 22 0x8
+				 0xc000 0x0 0x0 0x3 &ipic 23 0x8
+				 0xc000 0x0 0x0 0x4 &ipic 20 0x8>;
+		interrupt-parent = <&ipic>;
+		interrupts = <66 0x8>;
+		bus-range = <0x0 0x0>;
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 		          0x01000000 0x0 0x00000000 0xe0300000 0x0 0x00100000>;
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index a81e916..3e193fd 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -30,7 +30,7 @@
 
 		PowerPC,8379@0 {
 			device_type = "cpu";
-			reg = <0>;
+			reg = <0x0>;
 			d-cache-line-size = <32>;
 			i-cache-line-size = <32>;
 			d-cache-size = <32768>;
@@ -51,22 +51,22 @@
 		#size-cells = <1>;
 		compatible = "fsl,mpc8379-elbc", "fsl,elbc", "simple-bus";
 		reg = <0xe0005000 0x1000>;
-		interrupts = <77 8>;
+		interrupts = <77 0x8>;
 		interrupt-parent = <&ipic>;
 
 		// CS0 and CS1 are swapped when
 		// booting from nand, but the
 		// addresses are the same.
-		ranges = <0 0 0xfe000000 0x00800000
-		          1 0 0xe0600000 0x00008000
-		          2 0 0xf0000000 0x00020000
-		          3 0 0xfa000000 0x00008000>;
+		ranges = <0x0 0x0 0xfe000000 0x00800000
+		          0x1 0x0 0xe0600000 0x00008000
+		          0x2 0x0 0xf0000000 0x00020000
+		          0x3 0x0 0xfa000000 0x00008000>;
 
 		flash@0,0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "cfi-flash";
-			reg = <0 0 0x800000>;
+			reg = <0x0 0x0 0x800000>;
 			bank-width = <2>;
 			device-width = <1>;
 		};
@@ -76,7 +76,7 @@
 			#size-cells = <1>;
 			compatible = "fsl,mpc8379-fcm-nand",
 			             "fsl,elbc-fcm-nand";
-			reg = <1 0 0x8000>;
+			reg = <0x1 0x0 0x8000>;
 
 			u-boot@0 {
 				reg = <0x0 0x100000>;
@@ -97,7 +97,7 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		compatible = "simple-bus";
-		ranges = <0 0xe0000000 0x00100000>;
+		ranges = <0x0 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;
 
@@ -113,8 +113,8 @@
 			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <14 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <14 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 			rtc@68 {
 				device_type = "rtc";
@@ -129,8 +129,8 @@
 			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <15 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <15 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 		};
 
@@ -138,8 +138,8 @@
 			cell-index = <0>;
 			compatible = "fsl,spi";
 			reg = <0x7000 0x1000>;
-			interrupts = <16 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <16 0x8>;
+			interrupt-parent = <&ipic>;
 			mode = "cpu";
 		};
 
@@ -149,8 +149,8 @@
 			reg = <0x23000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = < &ipic >;
-			interrupts = <38 8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <38 0x8>;
 			phy_type = "utmi";
 		};
 
@@ -160,15 +160,15 @@
 			compatible = "fsl,gianfar-mdio";
 			reg = <0x24520 0x20>;
 			phy2: ethernet-phy@2 {
-				interrupt-parent = < &ipic >;
-				interrupts = <17 8>;
-				reg = <2>;
+				interrupt-parent = <&ipic>;
+				interrupts = <17 0x8>;
+				reg = <0x2>;
 				device_type = "ethernet-phy";
 			};
 			phy3: ethernet-phy@3 {
-				interrupt-parent = < &ipic >;
-				interrupts = <18 8>;
-				reg = <3>;
+				interrupt-parent = <&ipic>;
+				interrupts = <18 0x8>;
+				reg = <0x3>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -180,10 +180,10 @@
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <32 8 33 8 34 8>;
+			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy2 >;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy2>;
 		};
 
 		enet1: ethernet@25000 {
@@ -193,10 +193,10 @@
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 8 36 8 37 8>;
+			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy3 >;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy3>;
 		};
 
 		serial0: serial@4500 {
@@ -205,8 +205,8 @@
 			compatible = "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <9 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <9 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		serial1: serial@4600 {
@@ -215,8 +215,8 @@
 			compatible = "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <10 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <10 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		crypto@30000 {
@@ -224,8 +224,8 @@
 			device_type = "crypto";
 			compatible = "talitos";
 			reg = <0x30000 0x10000>;
-			interrupts = <11 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <11 0x8>;
+			interrupt-parent = <&ipic>;
 			/* Rev. 3.0 geometry */
 			num-channels = <4>;
 			channel-fifo-len = <24>;
@@ -236,29 +236,29 @@
 		sata@18000 {
 			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
 			reg = <0x18000 0x1000>;
-			interrupts = <44 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <44 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		sata@19000 {
 			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
 			reg = <0x19000 0x1000>;
-			interrupts = <45 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <45 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		sata@1a000 {
 			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
 			reg = <0x1a000 0x1000>;
-			interrupts = <46 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <46 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		sata@1b000 {
 			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
 			reg = <0x1b000 0x1000>;
-			interrupts = <47 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <47 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		/* IPIC
@@ -282,23 +282,23 @@
 				/* IRQ5 = 21 = 0x15, IRQ6 = 0x16, IRQ7 = 23 = 0x17 */
 
 				/* IDSEL AD14 IRQ6 inta */
-				 0x7000 0 0 1 &ipic 22 8
+				 0x7000 0x0 0x0 0x1 &ipic 22 0x8
 
 				/* IDSEL AD15 IRQ5 inta, IRQ6 intb, IRQ7 intd */
-				 0x7800 0 0 1 &ipic 21 8
-				 0x7800 0 0 2 &ipic 22 8
-				 0x7800 0 0 4 &ipic 23 8
+				 0x7800 0x0 0x0 0x1 &ipic 21 0x8
+				 0x7800 0x0 0x0 0x2 &ipic 22 0x8
+				 0x7800 0x0 0x0 0x4 &ipic 23 0x8
 
 				/* IDSEL AD28 IRQ7 inta, IRQ5 intb IRQ6 intc*/
-				 0xE000 0 0 1 &ipic 23 8
-				 0xE000 0 0 2 &ipic 21 8
-				 0xE000 0 0 3 &ipic 22 8>;
-		interrupt-parent = < &ipic >;
-		interrupts = <66 8>;
-		bus-range = <0 0>;
-		ranges = <0x02000000 0 0x90000000 0x90000000 0 0x10000000
-		          0x42000000 0 0x80000000 0x80000000 0 0x10000000
-		          0x01000000 0 0x00000000 0xe2000000 0 0x00100000>;
+				 0xE000 0x0 0x0 0x1 &ipic 23 0x8
+				 0xE000 0x0 0x0 0x2 &ipic 21 0x8
+				 0xE000 0x0 0x0 0x3 &ipic 22 0x8>;
+		interrupt-parent = <&ipic>;
+		interrupts = <66 0x8>;
+		bus-range = <0x0 0x0>;
+		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
+		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+		          0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
 		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sbc8349.dts
index 0934f54..6b0b699 100644
--- a/arch/powerpc/boot/dts/sbc8349.dts
+++ b/arch/powerpc/boot/dts/sbc8349.dts
@@ -35,11 +35,11 @@
 
 		PowerPC,8349@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <0x20>;	// 32 bytes
-			i-cache-line-size = <0x20>;	// 32 bytes
-			d-cache-size = <0x8000>;		// L1, 32K
-			i-cache-size = <0x8000>;		// L1, 32K
+			reg = <0x0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;	
+			i-cache-size = <32768>;
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
@@ -70,7 +70,7 @@
 			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <0xe 0x8>;
+			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
 			dfsrr;
 		};
@@ -81,7 +81,7 @@
 			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <0xf 0x8>;
+			interrupts = <15 0x8>;
 			interrupt-parent = <&ipic>;
 			dfsrr;
 		};
@@ -90,7 +90,7 @@
 			cell-index = <0>;
 			compatible = "fsl,spi";
 			reg = <0x7000 0x1000>;
-			interrupts = <0x10 0x8>;
+			interrupts = <16 0x8>;
 			interrupt-parent = <&ipic>;
 			mode = "cpu";
 		};
@@ -103,7 +103,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupt-parent = <&ipic>;
-			interrupts = <0x27 0x8>;
+			interrupts = <39 0x8>;
 			phy_type = "ulpi";
 			port1;
 		};
@@ -115,7 +115,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupt-parent = <&ipic>;
-			interrupts = <0x26 0x8>;
+			interrupts = <38 0x8>;
 			dr_mode = "otg";
 			phy_type = "ulpi";
 		};
@@ -128,13 +128,13 @@
 
 			phy0: ethernet-phy@19 {
 				interrupt-parent = <&ipic>;
-				interrupts = <0x14 0x8>;
+				interrupts = <20 0x8>;
 				reg = <0x19>;
 				device_type = "ethernet-phy";
 			};
 			phy1: ethernet-phy@1a {
 				interrupt-parent = <&ipic>;
-				interrupts = <0x15 0x8>;
+				interrupts = <21 0x8>;
 				reg = <0x1a>;
 				device_type = "ethernet-phy";
 			};
@@ -147,7 +147,7 @@
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x20 0x8 0x21 0x8 0x22 0x8>;
+			interrupts = <32 0x8 33 0x8 34 0x8>;
 			interrupt-parent = <&ipic>;
 			phy-handle = <&phy0>;
 			linux,network-index = <0>;
@@ -160,7 +160,7 @@
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x23 0x8 0x24 0x8 0x25 0x8>;
+			interrupts = <35 0x8 36 0x8 37 0x8>;
 			interrupt-parent = <&ipic>;
 			phy-handle = <&phy1>;
 			linux,network-index = <1>;
@@ -172,7 +172,7 @@
 			compatible = "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <0x9 0x8>;
+			interrupts = <9 0x8>;
 			interrupt-parent = <&ipic>;
 		};
 
@@ -182,7 +182,7 @@
 			compatible = "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <0xa 0x8>;
+			interrupts = <10 0x8>;
 			interrupt-parent = <&ipic>;
 		};
 
@@ -191,10 +191,10 @@
 			model = "SEC2";
 			compatible = "talitos";
 			reg = <0x30000 0x10000>;
-			interrupts = <0xb 0x8>;
+			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
 			num-channels = <4>;
-			channel-fifo-len = <0x18>;
+			channel-fifo-len = <24>;
 			exec-units-mask = <0x0000007e>;
 			/* desc mask is for rev2.0,
 			 * we need runtime fixup for >2.0 */
@@ -222,10 +222,10 @@
 		interrupt-map = <
 
 				/* IDSEL 0x11 */
-				 0x8800 0x0 0x0 0x1 &ipic 0x14 0x8
-				 0x8800 0x0 0x0 0x2 &ipic 0x15 0x8
-				 0x8800 0x0 0x0 0x3 &ipic 0x16 0x8
-				 0x8800 0x0 0x0 0x4 &ipic 0x17 0x8>;
+				 0x8800 0x0 0x0 0x1 &ipic 20 0x8
+				 0x8800 0x0 0x0 0x2 &ipic 21 0x8
+				 0x8800 0x0 0x0 0x3 &ipic 22 0x8
+				 0x8800 0x0 0x0 0x4 &ipic 23 0x8>;
 
 		interrupt-parent = <&ipic>;
 		interrupts = <0x42 0x8>;
-- 
1.5.4.rc4.gcab31
