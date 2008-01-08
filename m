Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4EC08DDEE4
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 22:23:04 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m08BMoT8027312
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 04:22:56 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m08BMnC8015922
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 05:22:49 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] Convert MPC837x device trees to dts-v1
Date: Tue,  8 Jan 2008 19:32:37 +0800
Message-Id: <1199791957-5309-1-git-send-email-leoli@freescale.com>
Cc: Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/mpc8377_mds.dts |  148 ++++++++++++++++---------------
 arch/powerpc/boot/dts/mpc8378_mds.dts |  140 +++++++++++++++---------------
 arch/powerpc/boot/dts/mpc8379_mds.dts |  156 +++++++++++++++++----------------
 3 files changed, 225 insertions(+), 219 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index b50b5f9..d66c8ad 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -9,6 +9,8 @@
  * option) any later version.
  */
 
+/dts-v1/;
+
 / {
 	model = "fsl,mpc8377emds";
 	compatible = "fsl,mpc8377emds","fsl,mpc837xmds";
@@ -30,10 +32,10 @@
 		PowerPC,8377@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;
-			i-cache-line-size = <20>;
-			d-cache-size = <8000>;		// L1, 32K
-			i-cache-size = <8000>;		// L1, 32K
+			d-cache-line-size = <0x20>;
+			i-cache-line-size = <0x20>;
+			d-cache-size = <0x8000>;		// L1, 32K
+			i-cache-size = <0x8000>;		// L1, 32K
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
@@ -42,20 +44,20 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 20000000>;	// 512MB at 0
+		reg = <0x00000000 0x20000000>;	// 512MB at 0
 	};
 
 	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		ranges = <0 e0000000 00100000>;
-		reg = <e0000000 00000200>;
+		ranges = <0x0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;
 
 		wdt@200 {
 			compatible = "mpc83xx_wdt";
-			reg = <200 100>;
+			reg = <0x200 0x100>;
 		};
 
 		i2c@3000 {
@@ -63,8 +65,8 @@
 			#size-cells = <0>;
 			cell-index = <0>;
 			compatible = "fsl-i2c";
-			reg = <3000 100>;
-			interrupts = <e 8>;
+			reg = <0x3000 0x100>;
+			interrupts = <0xe 0x8>;
 			interrupt-parent = < &ipic >;
 			dfsrr;
 		};
@@ -74,16 +76,16 @@
 			#size-cells = <0>;
 			cell-index = <1>;
 			compatible = "fsl-i2c";
-			reg = <3100 100>;
-			interrupts = <f 8>;
+			reg = <0x3100 0x100>;
+			interrupts = <0xf 0x8>;
 			interrupt-parent = < &ipic >;
 			dfsrr;
 		};
 
 		spi@7000 {
 			compatible = "fsl_spi";
-			reg = <7000 1000>;
-			interrupts = <10 8>;
+			reg = <0x7000 0x1000>;
+			interrupts = <0x10 0x8>;
 			interrupt-parent = < &ipic >;
 			mode = "cpu";
 		};
@@ -91,11 +93,11 @@
 		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
-			reg = <23000 1000>;
+			reg = <0x23000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupt-parent = < &ipic >;
-			interrupts = <26 8>;
+			interrupts = <0x26 0x8>;
 			phy_type = "utmi_wide";
 		};
 
@@ -103,16 +105,16 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,gianfar-mdio";
-			reg = <24520 20>;
+			reg = <0x24520 0x20>;
 			phy2: ethernet-phy@2 {
 				interrupt-parent = < &ipic >;
-				interrupts = <11 8>;
+				interrupts = <0x11 0x8>;
 				reg = <2>;
 				device_type = "ethernet-phy";
 			};
 			phy3: ethernet-phy@3 {
 				interrupt-parent = < &ipic >;
-				interrupts = <12 8>;
+				interrupts = <0x12 0x8>;
 				reg = <3>;
 				device_type = "ethernet-phy";
 			};
@@ -123,9 +125,9 @@
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
-			reg = <24000 1000>;
+			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <20 8 21 8 22 8>;
+			interrupts = <0x20 0x8 0x21 0x8 0x22 0x8>;
 			phy-connection-type = "mii";
 			interrupt-parent = < &ipic >;
 			phy-handle = < &phy2 >;
@@ -136,9 +138,9 @@
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
-			reg = <25000 1000>;
+			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <23 8 24 8 25 8>;
+			interrupts = <0x23 0x8 0x24 0x8 0x25 0x8>;
 			phy-connection-type = "mii";
 			interrupt-parent = < &ipic >;
 			phy-handle = < &phy3 >;
@@ -148,9 +150,9 @@
 			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4500 100>;
+			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <9 8>;
+			interrupts = <0x9 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
@@ -158,44 +160,44 @@
 			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4600 100>;
+			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <a 8>;
+			interrupts = <0xa 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
 		crypto@30000 {
 			model = "SEC3";
 			compatible = "talitos";
-			reg = <30000 10000>;
-			interrupts = <b 8>;
+			reg = <0x30000 0x10000>;
+			interrupts = <0xb 0x8>;
 			interrupt-parent = < &ipic >;
 			/* Rev. 3.0 geometry */
 			num-channels = <4>;
-			channel-fifo-len = <18>;
-			exec-units-mask = <000001fe>;
-			descriptor-types-mask = <03ab0ebf>;
+			channel-fifo-len = <0x18>;
+			exec-units-mask = <0x000001fe>;
+			descriptor-types-mask = <0x03ab0ebf>;
 		};
 
 		sdhc@2e000 {
 			model = "eSDHC";
 			compatible = "fsl,esdhc";
-			reg = <2e000 1000>;
-			interrupts = <2a 8>;
+			reg = <0x2e000 0x1000>;
+			interrupts = <0x2a 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
 		sata@18000 {
 			compatible = "fsl,mpc8379-sata", "fsl,pq2pro-sata";
-			reg = <18000 1000>;
-			interrupts = <2c 8>;
+			reg = <0x18000 0x1000>;
+			interrupts = <0x2c 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
 		sata@19000 {
 			compatible = "fsl,mpc8379-sata", "fsl,pq2pro-sata";
-			reg = <19000 1000>;
-			interrupts = <2d 8>;
+			reg = <0x19000 0x1000>;
+			interrupts = <0x2d 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
@@ -210,67 +212,67 @@
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
-			reg = <700 100>;
+			reg = <0x700 0x100>;
 		};
 	};
 
 	pci0: pci@e0008500 {
 		cell-index = <0>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 
 				/* IDSEL 0x11 */
-				 8800 0 0 1 &ipic 14 8
-				 8800 0 0 2 &ipic 15 8
-				 8800 0 0 3 &ipic 16 8
-				 8800 0 0 4 &ipic 17 8
+				 0x8800 0x0 0x0 0x1 &ipic 0x14 0x8
+				 0x8800 0x0 0x0 0x2 &ipic 0x15 0x8
+				 0x8800 0x0 0x0 0x3 &ipic 0x16 0x8
+				 0x8800 0x0 0x0 0x4 &ipic 0x17 0x8
 
 				/* IDSEL 0x12 */
-				 9000 0 0 1 &ipic 16 8
-				 9000 0 0 2 &ipic 17 8
-				 9000 0 0 3 &ipic 14 8
-				 9000 0 0 4 &ipic 15 8
+				 0x9000 0x0 0x0 0x1 &ipic 0x16 0x8
+				 0x9000 0x0 0x0 0x2 &ipic 0x17 0x8
+				 0x9000 0x0 0x0 0x3 &ipic 0x14 0x8
+				 0x9000 0x0 0x0 0x4 &ipic 0x15 0x8
 
 				/* IDSEL 0x13 */
-				 9800 0 0 1 &ipic 17 8
-				 9800 0 0 2 &ipic 14 8
-				 9800 0 0 3 &ipic 15 8
-				 9800 0 0 4 &ipic 16 8
+				 0x9800 0x0 0x0 0x1 &ipic 0x17 0x8
+				 0x9800 0x0 0x0 0x2 &ipic 0x14 0x8
+				 0x9800 0x0 0x0 0x3 &ipic 0x15 0x8
+				 0x9800 0x0 0x0 0x4 &ipic 0x16 0x8
 
 				/* IDSEL 0x15 */
-				 a800 0 0 1 &ipic 14 8
-				 a800 0 0 2 &ipic 15 8
-				 a800 0 0 3 &ipic 16 8
-				 a800 0 0 4 &ipic 17 8
+				 0xa800 0x0 0x0 0x1 &ipic 0x14 0x8
+				 0xa800 0x0 0x0 0x2 &ipic 0x15 0x8
+				 0xa800 0x0 0x0 0x3 &ipic 0x16 0x8
+				 0xa800 0x0 0x0 0x4 &ipic 0x17 0x8
 
 				/* IDSEL 0x16 */
-				 b000 0 0 1 &ipic 17 8
-				 b000 0 0 2 &ipic 14 8
-				 b000 0 0 3 &ipic 15 8
-				 b000 0 0 4 &ipic 16 8
+				 0xb000 0x0 0x0 0x1 &ipic 0x17 0x8
+				 0xb000 0x0 0x0 0x2 &ipic 0x14 0x8
+				 0xb000 0x0 0x0 0x3 &ipic 0x15 0x8
+				 0xb000 0x0 0x0 0x4 &ipic 0x16 0x8
 
 				/* IDSEL 0x17 */
-				 b800 0 0 1 &ipic 16 8
-				 b800 0 0 2 &ipic 17 8
-				 b800 0 0 3 &ipic 14 8
-				 b800 0 0 4 &ipic 15 8
+				 0xb800 0x0 0x0 0x1 &ipic 0x16 0x8
+				 0xb800 0x0 0x0 0x2 &ipic 0x17 0x8
+				 0xb800 0x0 0x0 0x3 &ipic 0x14 0x8
+				 0xb800 0x0 0x0 0x4 &ipic 0x15 0x8
 
 				/* IDSEL 0x18 */
-				 c000 0 0 1 &ipic 15 8
-				 c000 0 0 2 &ipic 16 8
-				 c000 0 0 3 &ipic 17 8
-				 c000 0 0 4 &ipic 14 8>;
+				 0xc000 0x0 0x0 0x1 &ipic 0x15 0x8
+				 0xc000 0x0 0x0 0x2 &ipic 0x16 0x8
+				 0xc000 0x0 0x0 0x3 &ipic 0x17 0x8
+				 0xc000 0x0 0x0 0x4 &ipic 0x14 0x8>;
 		interrupt-parent = < &ipic >;
-		interrupts = <42 8>;
+		interrupts = <0x42 0x8>;
 		bus-range = <0 0>;
-		ranges = <02000000 0 90000000 90000000 0 10000000
-		          42000000 0 80000000 80000000 0 10000000
-		          01000000 0 00000000 e0300000 0 00100000>;
+		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
+		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+		          0x01000000 0x0 0x00000000 0xe0300000 0x0 0x00100000>;
 		clock-frequency = <0>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <e0008500 100>;
+		reg = <0xe0008500 0x100>;
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index bd9545d..c117a6a 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -9,6 +9,8 @@
  * option) any later version.
  */
 
+/dts-v1/;
+
 / {
 	model = "fsl,mpc8378emds";
 	compatible = "fsl,mpc8378emds","fsl,mpc837xmds";
@@ -30,10 +32,10 @@
 		PowerPC,8378@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;
-			i-cache-line-size = <20>;
-			d-cache-size = <8000>;		// L1, 32K
-			i-cache-size = <8000>;		// L1, 32K
+			d-cache-line-size = <0x20>;
+			i-cache-line-size = <0x20>;
+			d-cache-size = <0x8000>;		// L1, 32K
+			i-cache-size = <0x8000>;		// L1, 32K
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
@@ -42,20 +44,20 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 20000000>;	// 512MB at 0
+		reg = <0x00000000 0x20000000>;	// 512MB at 0
 	};
 
 	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		ranges = <0 e0000000 00100000>;
-		reg = <e0000000 00000200>;
+		ranges = <0x0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;
 
 		wdt@200 {
 			compatible = "mpc83xx_wdt";
-			reg = <200 100>;
+			reg = <0x200 0x100>;
 		};
 
 		i2c@3000 {
@@ -63,8 +65,8 @@
 			#size-cells = <0>;
 			cell-index = <0>;
 			compatible = "fsl-i2c";
-			reg = <3000 100>;
-			interrupts = <e 8>;
+			reg = <0x3000 0x100>;
+			interrupts = <0xe 0x8>;
 			interrupt-parent = < &ipic >;
 			dfsrr;
 		};
@@ -74,16 +76,16 @@
 			#size-cells = <0>;
 			cell-index = <1>;
 			compatible = "fsl-i2c";
-			reg = <3100 100>;
-			interrupts = <f 8>;
+			reg = <0x3100 0x100>;
+			interrupts = <0xf 0x8>;
 			interrupt-parent = < &ipic >;
 			dfsrr;
 		};
 
 		spi@7000 {
 			compatible = "fsl_spi";
-			reg = <7000 1000>;
-			interrupts = <10 8>;
+			reg = <0x7000 0x1000>;
+			interrupts = <0x10 0x8>;
 			interrupt-parent = < &ipic >;
 			mode = "cpu";
 		};
@@ -91,11 +93,11 @@
 		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
-			reg = <23000 1000>;
+			reg = <0x23000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupt-parent = < &ipic >;
-			interrupts = <26 8>;
+			interrupts = <0x26 0x8>;
 			phy_type = "utmi_wide";
 		};
 
@@ -103,16 +105,16 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,gianfar-mdio";
-			reg = <24520 20>;
+			reg = <0x24520 0x20>;
 			phy2: ethernet-phy@2 {
 				interrupt-parent = < &ipic >;
-				interrupts = <11 8>;
+				interrupts = <0x11 0x8>;
 				reg = <2>;
 				device_type = "ethernet-phy";
 			};
 			phy3: ethernet-phy@3 {
 				interrupt-parent = < &ipic >;
-				interrupts = <12 8>;
+				interrupts = <0x12 0x8>;
 				reg = <3>;
 				device_type = "ethernet-phy";
 			};
@@ -123,9 +125,9 @@
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
-			reg = <24000 1000>;
+			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <20 8 21 8 22 8>;
+			interrupts = <0x20 0x8 0x21 0x8 0x22 0x8>;
 			phy-connection-type = "mii";
 			interrupt-parent = < &ipic >;
 			phy-handle = < &phy2 >;
@@ -136,9 +138,9 @@
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
-			reg = <25000 1000>;
+			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <23 8 24 8 25 8>;
+			interrupts = <0x23 0x8 0x24 0x8 0x25 0x8>;
 			phy-connection-type = "mii";
 			interrupt-parent = < &ipic >;
 			phy-handle = < &phy3 >;
@@ -148,9 +150,9 @@
 			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4500 100>;
+			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <9 8>;
+			interrupts = <0x9 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
@@ -158,30 +160,30 @@
 			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4600 100>;
+			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <a 8>;
+			interrupts = <0xa 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
 		crypto@30000 {
 			model = "SEC3";
 			compatible = "talitos";
-			reg = <30000 10000>;
-			interrupts = <b 8>;
+			reg = <0x30000 0x10000>;
+			interrupts = <0xb 0x8>;
 			interrupt-parent = < &ipic >;
 			/* Rev. 3.0 geometry */
 			num-channels = <4>;
-			channel-fifo-len = <18>;
-			exec-units-mask = <000001fe>;
-			descriptor-types-mask = <03ab0ebf>;
+			channel-fifo-len = <0x18>;
+			exec-units-mask = <0x000001fe>;
+			descriptor-types-mask = <0x03ab0ebf>;
 		};
 
 		sdhc@2e000 {
 			model = "eSDHC";
 			compatible = "fsl,esdhc";
-			reg = <2e000 1000>;
-			interrupts = <2a 8>;
+			reg = <0x2e000 0x1000>;
+			interrupts = <0x2a 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
@@ -196,67 +198,67 @@
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
-			reg = <700 100>;
+			reg = <0x700 0x100>;
 		};
 	};
 
 	pci0: pci@e0008500 {
 		cell-index = <0>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 
 				/* IDSEL 0x11 */
-				 8800 0 0 1 &ipic 14 8
-				 8800 0 0 2 &ipic 15 8
-				 8800 0 0 3 &ipic 16 8
-				 8800 0 0 4 &ipic 17 8
+				 0x8800 0x0 0x0 0x1 &ipic 0x14 0x8
+				 0x8800 0x0 0x0 0x2 &ipic 0x15 0x8
+				 0x8800 0x0 0x0 0x3 &ipic 0x16 0x8
+				 0x8800 0x0 0x0 0x4 &ipic 0x17 0x8
 
 				/* IDSEL 0x12 */
-				 9000 0 0 1 &ipic 16 8
-				 9000 0 0 2 &ipic 17 8
-				 9000 0 0 3 &ipic 14 8
-				 9000 0 0 4 &ipic 15 8
+				 0x9000 0x0 0x0 0x1 &ipic 0x16 0x8
+				 0x9000 0x0 0x0 0x2 &ipic 0x17 0x8
+				 0x9000 0x0 0x0 0x3 &ipic 0x14 0x8
+				 0x9000 0x0 0x0 0x4 &ipic 0x15 0x8
 
 				/* IDSEL 0x13 */
-				 9800 0 0 1 &ipic 17 8
-				 9800 0 0 2 &ipic 14 8
-				 9800 0 0 3 &ipic 15 8
-				 9800 0 0 4 &ipic 16 8
+				 0x9800 0x0 0x0 0x1 &ipic 0x17 0x8
+				 0x9800 0x0 0x0 0x2 &ipic 0x14 0x8
+				 0x9800 0x0 0x0 0x3 &ipic 0x15 0x8
+				 0x9800 0x0 0x0 0x4 &ipic 0x16 0x8
 
 				/* IDSEL 0x15 */
-				 a800 0 0 1 &ipic 14 8
-				 a800 0 0 2 &ipic 15 8
-				 a800 0 0 3 &ipic 16 8
-				 a800 0 0 4 &ipic 17 8
+				 0xa800 0x0 0x0 0x1 &ipic 0x14 0x8
+				 0xa800 0x0 0x0 0x2 &ipic 0x15 0x8
+				 0xa800 0x0 0x0 0x3 &ipic 0x16 0x8
+				 0xa800 0x0 0x0 0x4 &ipic 0x17 0x8
 
 				/* IDSEL 0x16 */
-				 b000 0 0 1 &ipic 17 8
-				 b000 0 0 2 &ipic 14 8
-				 b000 0 0 3 &ipic 15 8
-				 b000 0 0 4 &ipic 16 8
+				 0xb000 0x0 0x0 0x1 &ipic 0x17 0x8
+				 0xb000 0x0 0x0 0x2 &ipic 0x14 0x8
+				 0xb000 0x0 0x0 0x3 &ipic 0x15 0x8
+				 0xb000 0x0 0x0 0x4 &ipic 0x16 0x8
 
 				/* IDSEL 0x17 */
-				 b800 0 0 1 &ipic 16 8
-				 b800 0 0 2 &ipic 17 8
-				 b800 0 0 3 &ipic 14 8
-				 b800 0 0 4 &ipic 15 8
+				 0xb800 0x0 0x0 0x1 &ipic 0x16 0x8
+				 0xb800 0x0 0x0 0x2 &ipic 0x17 0x8
+				 0xb800 0x0 0x0 0x3 &ipic 0x14 0x8
+				 0xb800 0x0 0x0 0x4 &ipic 0x15 0x8
 
 				/* IDSEL 0x18 */
-				 c000 0 0 1 &ipic 15 8
-				 c000 0 0 2 &ipic 16 8
-				 c000 0 0 3 &ipic 17 8
-				 c000 0 0 4 &ipic 14 8>;
+				 0xc000 0x0 0x0 0x1 &ipic 0x15 0x8
+				 0xc000 0x0 0x0 0x2 &ipic 0x16 0x8
+				 0xc000 0x0 0x0 0x3 &ipic 0x17 0x8
+				 0xc000 0x0 0x0 0x4 &ipic 0x14 0x8>;
 		interrupt-parent = < &ipic >;
-		interrupts = <42 8>;
+		interrupts = <0x42 0x8>;
 		bus-range = <0 0>;
-		ranges = <02000000 0 90000000 90000000 0 10000000
-		          42000000 0 80000000 80000000 0 10000000
-		          01000000 0 00000000 e0300000 0 00100000>;
+		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
+		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+		          0x01000000 0x0 0x00000000 0xe0300000 0x0 0x00100000>;
 		clock-frequency = <0>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <e0008500 100>;
+		reg = <0xe0008500 0x100>;
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index 4d651a3..7510811 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -9,6 +9,8 @@
  * option) any later version.
  */
 
+/dts-v1/;
+
 / {
 	model = "fsl,mpc8379emds";
 	compatible = "fsl,mpc8379emds","fsl,mpc837xmds";
@@ -30,10 +32,10 @@
 		PowerPC,8379@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;
-			i-cache-line-size = <20>;
-			d-cache-size = <8000>;		// L1, 32K
-			i-cache-size = <8000>;		// L1, 32K
+			d-cache-line-size = <0x20>;
+			i-cache-line-size = <0x20>;
+			d-cache-size = <0x8000>;		// L1, 32K
+			i-cache-size = <0x8000>;		// L1, 32K
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
@@ -42,20 +44,20 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 20000000>;	// 512MB at 0
+		reg = <0x00000000 0x20000000>;	// 512MB at 0
 	};
 
 	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		ranges = <0 e0000000 00100000>;
-		reg = <e0000000 00000200>;
+		ranges = <0x0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;
 
 		wdt@200 {
 			compatible = "mpc83xx_wdt";
-			reg = <200 100>;
+			reg = <0x200 0x100>;
 		};
 
 		i2c@3000 {
@@ -63,8 +65,8 @@
 			#size-cells = <0>;
 			cell-index = <0>;
 			compatible = "fsl-i2c";
-			reg = <3000 100>;
-			interrupts = <e 8>;
+			reg = <0x3000 0x100>;
+			interrupts = <0xe 0x8>;
 			interrupt-parent = < &ipic >;
 			dfsrr;
 		};
@@ -74,16 +76,16 @@
 			#size-cells = <0>;
 			cell-index = <1>;
 			compatible = "fsl-i2c";
-			reg = <3100 100>;
-			interrupts = <f 8>;
+			reg = <0x3100 0x100>;
+			interrupts = <0xf 0x8>;
 			interrupt-parent = < &ipic >;
 			dfsrr;
 		};
 
 		spi@7000 {
 			compatible = "fsl_spi";
-			reg = <7000 1000>;
-			interrupts = <10 8>;
+			reg = <0x7000 0x1000>;
+			interrupts = <0x10 0x8>;
 			interrupt-parent = < &ipic >;
 			mode = "cpu";
 		};
@@ -91,11 +93,11 @@
 		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
-			reg = <23000 1000>;
+			reg = <0x23000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupt-parent = < &ipic >;
-			interrupts = <26 8>;
+			interrupts = <0x26 0x8>;
 			phy_type = "utmi_wide";
 		};
 
@@ -103,16 +105,16 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,gianfar-mdio";
-			reg = <24520 20>;
+			reg = <0x24520 0x20>;
 			phy2: ethernet-phy@2 {
 				interrupt-parent = < &ipic >;
-				interrupts = <11 8>;
+				interrupts = <0x11 0x8>;
 				reg = <2>;
 				device_type = "ethernet-phy";
 			};
 			phy3: ethernet-phy@3 {
 				interrupt-parent = < &ipic >;
-				interrupts = <12 8>;
+				interrupts = <0x12 0x8>;
 				reg = <3>;
 				device_type = "ethernet-phy";
 			};
@@ -123,9 +125,9 @@
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
-			reg = <24000 1000>;
+			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <20 8 21 8 22 8>;
+			interrupts = <0x20 0x8 0x21 0x8 0x22 0x8>;
 			phy-connection-type = "mii";
 			interrupt-parent = < &ipic >;
 			phy-handle = < &phy2 >;
@@ -136,9 +138,9 @@
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
-			reg = <25000 1000>;
+			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <23 8 24 8 25 8>;
+			interrupts = <0x23 0x8 0x24 0x8 0x25 0x8>;
 			phy-connection-type = "mii";
 			interrupt-parent = < &ipic >;
 			phy-handle = < &phy3 >;
@@ -148,9 +150,9 @@
 			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4500 100>;
+			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <9 8>;
+			interrupts = <0x9 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
@@ -158,58 +160,58 @@
 			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4600 100>;
+			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <a 8>;
+			interrupts = <0xa 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
 		crypto@30000 {
 			model = "SEC3";
 			compatible = "talitos";
-			reg = <30000 10000>;
-			interrupts = <b 8>;
+			reg = <0x30000 0x10000>;
+			interrupts = <0xb 0x8>;
 			interrupt-parent = < &ipic >;
 			/* Rev. 3.0 geometry */
 			num-channels = <4>;
-			channel-fifo-len = <18>;
-			exec-units-mask = <000001fe>;
-			descriptor-types-mask = <03ab0ebf>;
+			channel-fifo-len = <0x18>;
+			exec-units-mask = <0x000001fe>;
+			descriptor-types-mask = <0x03ab0ebf>;
 		};
 
 		sdhc@2e000 {
 			model = "eSDHC";
 			compatible = "fsl,esdhc";
-			reg = <2e000 1000>;
-			interrupts = <2a 8>;
+			reg = <0x2e000 0x1000>;
+			interrupts = <0x2a 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
 		sata@18000 {
 			compatible = "fsl,mpc8379-sata", "fsl,pq2pro-sata";
-			reg = <18000 1000>;
-			interrupts = <2c 8>;
+			reg = <0x18000 0x1000>;
+			interrupts = <0x2c 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
 		sata@19000 {
 			compatible = "fsl,mpc8379-sata", "fsl,pq2pro-sata";
-			reg = <19000 1000>;
-			interrupts = <2d 8>;
+			reg = <0x19000 0x1000>;
+			interrupts = <0x2d 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
 		sata@1a000 {
 			compatible = "fsl,mpc8379-sata", "fsl,pq2pro-sata";
-			reg = <1a000 1000>;
-			interrupts = <2e 8>;
+			reg = <0x1a000 0x1000>;
+			interrupts = <0x2e 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
 		sata@1b000 {
 			compatible = "fsl,mpc8379-sata", "fsl,pq2pro-sata";
-			reg = <1b000 1000>;
-			interrupts = <2f 8>;
+			reg = <0x1b000 0x1000>;
+			interrupts = <0x2f 0x8>;
 			interrupt-parent = < &ipic >;
 		};
 
@@ -224,67 +226,67 @@
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
-			reg = <700 100>;
+			reg = <0x700 0x100>;
 		};
 	};
 
 	pci0: pci@e0008500 {
 		cell-index = <0>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 
 				/* IDSEL 0x11 */
-				 8800 0 0 1 &ipic 14 8
-				 8800 0 0 2 &ipic 15 8
-				 8800 0 0 3 &ipic 16 8
-				 8800 0 0 4 &ipic 17 8
+				 0x8800 0x0 0x0 0x1 &ipic 0x14 0x8
+				 0x8800 0x0 0x0 0x2 &ipic 0x15 0x8
+				 0x8800 0x0 0x0 0x3 &ipic 0x16 0x8
+				 0x8800 0x0 0x0 0x4 &ipic 0x17 0x8
 
 				/* IDSEL 0x12 */
-				 9000 0 0 1 &ipic 16 8
-				 9000 0 0 2 &ipic 17 8
-				 9000 0 0 3 &ipic 14 8
-				 9000 0 0 4 &ipic 15 8
+				 0x9000 0x0 0x0 0x1 &ipic 0x16 0x8
+				 0x9000 0x0 0x0 0x2 &ipic 0x17 0x8
+				 0x9000 0x0 0x0 0x3 &ipic 0x14 0x8
+				 0x9000 0x0 0x0 0x4 &ipic 0x15 0x8
 
 				/* IDSEL 0x13 */
-				 9800 0 0 1 &ipic 17 8
-				 9800 0 0 2 &ipic 14 8
-				 9800 0 0 3 &ipic 15 8
-				 9800 0 0 4 &ipic 16 8
+				 0x9800 0x0 0x0 0x1 &ipic 0x17 0x8
+				 0x9800 0x0 0x0 0x2 &ipic 0x14 0x8
+				 0x9800 0x0 0x0 0x3 &ipic 0x15 0x8
+				 0x9800 0x0 0x0 0x4 &ipic 0x16 0x8
 
 				/* IDSEL 0x15 */
-				 a800 0 0 1 &ipic 14 8
-				 a800 0 0 2 &ipic 15 8
-				 a800 0 0 3 &ipic 16 8
-				 a800 0 0 4 &ipic 17 8
+				 0xa800 0x0 0x0 0x1 &ipic 0x14 0x8
+				 0xa800 0x0 0x0 0x2 &ipic 0x15 0x8
+				 0xa800 0x0 0x0 0x3 &ipic 0x16 0x8
+				 0xa800 0x0 0x0 0x4 &ipic 0x17 0x8
 
 				/* IDSEL 0x16 */
-				 b000 0 0 1 &ipic 17 8
-				 b000 0 0 2 &ipic 14 8
-				 b000 0 0 3 &ipic 15 8
-				 b000 0 0 4 &ipic 16 8
+				 0xb000 0x0 0x0 0x1 &ipic 0x17 0x8
+				 0xb000 0x0 0x0 0x2 &ipic 0x14 0x8
+				 0xb000 0x0 0x0 0x3 &ipic 0x15 0x8
+				 0xb000 0x0 0x0 0x4 &ipic 0x16 0x8
 
 				/* IDSEL 0x17 */
-				 b800 0 0 1 &ipic 16 8
-				 b800 0 0 2 &ipic 17 8
-				 b800 0 0 3 &ipic 14 8
-				 b800 0 0 4 &ipic 15 8
+				 0xb800 0x0 0x0 0x1 &ipic 0x16 0x8
+				 0xb800 0x0 0x0 0x2 &ipic 0x17 0x8
+				 0xb800 0x0 0x0 0x3 &ipic 0x14 0x8
+				 0xb800 0x0 0x0 0x4 &ipic 0x15 0x8
 
 				/* IDSEL 0x18 */
-				 c000 0 0 1 &ipic 15 8
-				 c000 0 0 2 &ipic 16 8
-				 c000 0 0 3 &ipic 17 8
-				 c000 0 0 4 &ipic 14 8>;
+				 0xc000 0x0 0x0 0x1 &ipic 0x15 0x8
+				 0xc000 0x0 0x0 0x2 &ipic 0x16 0x8
+				 0xc000 0x0 0x0 0x3 &ipic 0x17 0x8
+				 0xc000 0x0 0x0 0x4 &ipic 0x14 0x8>;
 		interrupt-parent = < &ipic >;
-		interrupts = <42 8>;
+		interrupts = <0x42 0x8>;
 		bus-range = <0 0>;
-		ranges = <02000000 0 90000000 90000000 0 10000000
-		          42000000 0 80000000 80000000 0 10000000
-		          01000000 0 00000000 e0300000 0 00100000>;
+		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
+		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+		          0x01000000 0x0 0x00000000 0xe0300000 0x0 0x00100000>;
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
1.5.3.5.643.g40e25
