Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 37524B7D08
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 20:08:36 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/44x: Update Glacier dts
Date: Wed, 10 Feb 2010 10:08:28 +0100
Message-Id: <1265792908-26315-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sync Glacier dts with latest Canyonlands version:

- Add l2 cache support
- Add NDFC support
- Add RTC support
- Add AD7414 hwmon support
- Change EMAC compatible node from emac4 to emac4sync and correct the
  register size
- Add support for ISA holes on 4xx PCI/X/E
  (as done in Benjamin Herrenschmidt's patch for Canyonlands)
- Add Crypto device node

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/dts/glacier.dts |   76 ++++++++++++++++++++++++++++++++----
 1 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/boot/dts/glacier.dts b/arch/powerpc/boot/dts/glacier.dts
index f6f6189..d62a4fb 100644
--- a/arch/powerpc/boot/dts/glacier.dts
+++ b/arch/powerpc/boot/dts/glacier.dts
@@ -1,7 +1,7 @@
 /*
  * Device Tree Source for AMCC Glacier (460GT)
  *
- * Copyright 2008 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ * Copyright 2008-2010 DENX Software Engineering, Stefan Roese <sr@denx.de>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without
@@ -42,6 +42,7 @@
 			d-cache-size = <32768>;
 			dcr-controller;
 			dcr-access-method = "native";
+			next-level-cache = <&L2C0>;
 		};
 	};
 
@@ -106,6 +107,16 @@
 		dcr-reg = <0x00c 0x002>;
 	};
 
+	L2C0: l2c {
+		compatible = "ibm,l2-cache-460gt", "ibm,l2-cache";
+		dcr-reg = <0x020 0x008		/* Internal SRAM DCR's */
+			   0x030 0x008>;	/* L2 cache DCR's */
+		cache-line-size = <32>;		/* 32 bytes */
+		cache-size = <262144>;		/* L2, 256K */
+		interrupt-parent = <&UIC1>;
+		interrupts = <11 1>;
+	};
+
 	plb {
 		compatible = "ibm,plb-460gt", "ibm,plb4";
 		#address-cells = <2>;
@@ -118,6 +129,13 @@
 			dcr-reg = <0x010 0x002>;
 		};
 
+		CRYPTO: crypto@180000 {
+			compatible = "amcc,ppc460gt-crypto", "amcc,ppc4xx-crypto";
+			reg = <4 0x00180000 0x80400>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <0x1d 0x4>;
+		};
+
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-460gt", "ibm,mcmal2";
 			dcr-reg = <0x180 0x062>;
@@ -186,6 +204,29 @@
 						reg = <0x03fa0000 0x00060000>;
 					};
 				};
+
+				ndfc@3,0 {
+					compatible = "ibm,ndfc";
+					reg = <0x00000003 0x00000000 0x00002000>;
+					ccr = <0x00001000>;
+					bank-settings = <0x80002222>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					nand {
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						partition@0 {
+							label = "u-boot";
+							reg = <0x00000000 0x00100000>;
+						};
+						partition@100000 {
+							label = "user";
+							reg = <0x00000000 0x03f00000>;
+						};
+					};
+				};
 			};
 
 			UART0: serial@ef600300 {
@@ -237,6 +278,20 @@
 				reg = <0xef600700 0x00000014>;
 				interrupt-parent = <&UIC0>;
 				interrupts = <0x2 0x4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				rtc@68 {
+					compatible = "stm,m41t80";
+					reg = <0x68>;
+					interrupt-parent = <&UIC2>;
+					interrupts = <0x19 0x8>;
+				};
+				sttm@48 {
+					compatible = "ad,ad7414";
+					reg = <0x48>;
+					interrupt-parent = <&UIC1>;
+					interrupts = <0x14 0x8>;
+				};
 			};
 
 			IIC1: i2c@ef600800 {
@@ -275,7 +330,7 @@
 
 			EMAC0: ethernet@ef600e00 {
 				device_type = "network";
-				compatible = "ibm,emac-460gt", "ibm,emac4";
+				compatible = "ibm,emac-460gt", "ibm,emac4sync";
 				interrupt-parent = <&EMAC0>;
 				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
@@ -283,7 +338,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0x0 &UIC2 0x10 0x4
 						 /*Wake*/   0x1 &UIC2 0x14 0x4>;
-				reg = <0xef600e00 0x00000074>;
+				reg = <0xef600e00 0x000000c4>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
@@ -305,7 +360,7 @@
 
 			EMAC1: ethernet@ef600f00 {
 				device_type = "network";
-				compatible = "ibm,emac-460gt", "ibm,emac4";
+				compatible = "ibm,emac-460gt", "ibm,emac4sync";
 				interrupt-parent = <&EMAC1>;
 				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
@@ -313,7 +368,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0x0 &UIC2 0x11 0x4
 						 /*Wake*/   0x1 &UIC2 0x15 0x4>;
-				reg = <0xef600f00 0x00000074>;
+				reg = <0xef600f00 0x000000c4>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
@@ -336,7 +391,7 @@
 
 			EMAC2: ethernet@ef601100 {
 				device_type = "network";
-				compatible = "ibm,emac-460gt", "ibm,emac4";
+				compatible = "ibm,emac-460gt", "ibm,emac4sync";
 				interrupt-parent = <&EMAC2>;
 				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
@@ -344,7 +399,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0x0 &UIC2 0x12 0x4
 						 /*Wake*/   0x1 &UIC2 0x16 0x4>;
-				reg = <0xef601100 0x00000074>;
+				reg = <0xef601100 0x000000c4>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <2>;
@@ -366,7 +421,7 @@
 
 			EMAC3: ethernet@ef601200 {
 				device_type = "network";
-				compatible = "ibm,emac-460gt", "ibm,emac4";
+				compatible = "ibm,emac-460gt", "ibm,emac4sync";
 				interrupt-parent = <&EMAC3>;
 				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
@@ -374,7 +429,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0x0 &UIC2 0x13 0x4
 						 /*Wake*/   0x1 &UIC2 0x17 0x4>;
-				reg = <0xef601200 0x00000074>;
+				reg = <0xef601200 0x000000c4>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <3>;
@@ -414,6 +469,7 @@
 			 * later cannot be changed
 			 */
 			ranges = <0x02000000 0x00000000 0x80000000 0x0000000d 0x80000000 0x00000000 0x80000000
+				  0x02000000 0x00000000 0x00000000 0x0000000c 0x0ee00000 0x00000000 0x00100000
 				  0x01000000 0x00000000 0x00000000 0x0000000c 0x08000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
@@ -444,6 +500,7 @@
 			 * later cannot be changed
 			 */
 			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x00000000 0x00000000 0x80000000
+				  0x02000000 0x00000000 0x00000000 0x0000000f 0x00000000 0x00000000 0x00100000
 				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
@@ -485,6 +542,7 @@
 			 * later cannot be changed
 			 */
 			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x80000000 0x00000000 0x80000000
+				  0x02000000 0x00000000 0x00000000 0x0000000f 0x00100000 0x00000000 0x00100000
 				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80010000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-- 
1.6.6.1
