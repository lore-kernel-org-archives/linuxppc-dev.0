Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 0337CDDE02
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 18:28:09 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 9/9] 8313rdb: Convert mpc8313 RDB to dts-v1 format.
Date: Mon, 28 Jan 2008 02:27:59 -0500
Message-Id: <da7540d7fd569353843cbef7c354a20c80c02817.1201503958.git.paul.gortmaker@windriver.com>
In-Reply-To: <0c63d781e569dbe4126afb5ff902df4cfcae9aca.1201503958.git.paul.gortmaker@windriver.com>
References: <1201505279-25847-1-git-send-email-paul.gortmaker@windriver.com>
	<a050480a21aef92854805e9bee517c0d65d5bd59.1201503958.git.paul.gortmaker@windriver.com>
	<51b1015cd61540df832ee5d5ee125e7326c3f0ed.1201503958.git.paul.gortmaker@windriver.com>
	<d8e187e4d4aa981109450f333658730e3408f627.1201503958.git.paul.gortmaker@windriver.com>
	<1d2d2df57a47cff00d8539194b0c997175d18170.1201503958.git.paul.gortmaker@windriver.com>
	<fa3dbfb49842f4553d619b1cf209102ca2457d62.1201503958.git.paul.gortmaker@windriver.com>
	<53bbf9975296ba5dc57c68305079dc90d8d8a348.1201503958.git.paul.gortmaker@windriver.com>
	<fd274c4f37b24513b4bf8a69d79dbe1b6dea7082.1201503958.git.paul.gortmaker@windriver.com>
	<0c63d781e569dbe4126afb5ff902df4cfcae9aca.1201503958.git.paul.gortmaker@windriver.com>
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

Convert the MPC8313 RDB dts file to v1 format.  Entries for
values normally parsed by humans are left in decimal (i.e. IRQ,
cache size, clock rates, basic counts and index values).

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/mpc8313erdb.dts |  126 +++++++++++++++++----------------
 1 files changed, 64 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 9bcf2c9..38c9548 100644
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
@@ -30,10 +32,10 @@
 		PowerPC,8313@0 {
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
@@ -112,8 +114,8 @@
 			#size-cells = <0>;
 			cell-index = <0>;
 			compatible = "fsl-i2c";
-			reg = <3000 100>;
-			interrupts = <e 8>;
+			reg = <0x3000 0x100>;
+			interrupts = <14 0x8>;
 			interrupt-parent = < &ipic >;
 			dfsrr;
 		};
@@ -123,8 +125,8 @@
 			#size-cells = <0>;
 			cell-index = <1>;
 			compatible = "fsl-i2c";
-			reg = <3100 100>;
-			interrupts = <f 8>;
+			reg = <0x3100 0x100>;
+			interrupts = <15 0x8>;
 			interrupt-parent = < &ipic >;
 			dfsrr;
 		};
@@ -132,8 +134,8 @@
 		spi@7000 {
 			device_type = "spi";
 			compatible = "fsl_spi";
-			reg = <7000 1000>;
-			interrupts = <10 8>;
+			reg = <0x7000 0x1000>;
+			interrupts = <16 0x8>;
 			interrupt-parent = < &ipic >;
 			mode = "cpu";
 		};
@@ -141,11 +143,11 @@
 		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
-			reg = <23000 1000>;
+			reg = <0x23000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupt-parent = < &ipic >;
-			interrupts = <26 8>;
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
 				interrupt-parent = < &ipic >;
-				interrupts = <13 8>;
-				reg = <1>;
+				interrupts = <19 0x8>;
+				reg = <0x1>;
 				device_type = "ethernet-phy";
 			};
 			phy4: ethernet-phy@4 {
 				interrupt-parent = < &ipic >;
-				interrupts = <14 8>;
-				reg = <4>;
+				interrupts = <20 0x8>;
+				reg = <0x4>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -173,9 +175,9 @@
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
-			reg = <24000 1000>;
+			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <25 8 24 8 23 8>;
+			interrupts = <37 0x8 36 0x8 35 0x8>;
 			interrupt-parent = < &ipic >;
 			phy-handle = < &phy1 >;
 		};
@@ -185,9 +187,9 @@
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
-			reg = <25000 1000>;
+			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <22 8 21 8 20 8>;
+			interrupts = <34 0x8 33 0x8 32 0x8>;
 			interrupt-parent = < &ipic >;
 			phy-handle = < &phy4 >;
 		};
@@ -196,9 +198,9 @@
 			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4500 100>;
+			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <9 8>;
+			interrupts = <9 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
@@ -206,9 +208,9 @@
 			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4600 100>;
+			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <a 8>;
+			interrupts = <10 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
@@ -216,14 +218,14 @@
 			device_type = "crypto";
 			model = "SEC2";
 			compatible = "talitos";
-			reg = <30000 7000>;
-			interrupts = <b 8>;
+			reg = <0x30000 0x7000>;
+			interrupts = <11 0x8>;
 			interrupt-parent = < &ipic >;
 			/* Rev. 2.2 */
 			num-channels = <1>;
-			channel-fifo-len = <18>;
-			exec-units-mask = <0000004c>;
-			descriptor-types-mask = <0122003f>;
+			channel-fifo-len = <0x18>;
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
+				 0x7800 0x0 0x0 0x1 &ipic 17 0x8
+				 0x7800 0x0 0x0 0x2 &ipic 18 0x8
+				 0x7800 0x0 0x0 0x3 &ipic 17 0x8
+				 0x7800 0x0 0x0 0x4 &ipic 18 0x8>;
 		interrupt-parent = < &ipic >;
-		interrupts = <42 8>;
-		bus-range = <0 0>;
-		ranges = <02000000 0 90000000 90000000 0 10000000
-			  42000000 0 80000000 80000000 0 10000000
-			  01000000 0 00000000 e2000000 0 00100000>;
-		clock-frequency = <3f940aa>;
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
-- 
1.5.4.rc4.gcab31
