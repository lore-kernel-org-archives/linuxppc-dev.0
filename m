Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id CF407DDECC
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 05:06:27 +1100 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id E31A0143F1
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 19:13:04 +0100 (CET)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06220-10 for <linuxppc-dev@ozlabs.org>;
	Thu, 17 Jan 2008 19:13:03 +0100 (CET)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id CA694143D2
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 19:13:01 +0100 (CET)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v2] [POWERPC] Update TQM5200, CM5200 and Motion-PRO .dts files
To: linuxppc-dev@ozlabs.org
Date: Thu, 17 Jan 2008 19:07:21 +0100
Message-ID: <20080117180708.17979.9172.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updates include:
- set soc mnode compatible property to "fsl,mpc5200-immr"
- update i2c device tree nodes
- add mdio node
- add lpb bus node and flash device (without partitions defined)
- add second mscan node for Motio-PRO
- add rtc i2c nodes

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
---

This patch was applied and tested against:
git://git.secretlab.ca/git/linux-2.6-mpc52xx.git#for-2.6.25

 arch/powerpc/boot/dts/cm5200.dts    |   40 +++++++++++++++++++++++++++--
 arch/powerpc/boot/dts/motionpro.dts |   49 ++++++++++++++++++++++++++++++++---
 arch/powerpc/boot/dts/tqm5200.dts   |   45 +++++++++++++++++++++++++++++++-
 3 files changed, 126 insertions(+), 8 deletions(-)


diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
index 9295083..ff01478 100644
--- a/arch/powerpc/boot/dts/cm5200.dts
+++ b/arch/powerpc/boot/dts/cm5200.dts
@@ -46,7 +46,7 @@
 
 	soc5200@f0000000 {
 		model = "fsl,mpc5200b";
-		compatible = "fsl,mpc5200b";
+		compatible = "fsl,mpc5200-immr";
 		revision = "";			// from bootloader
 		device_type = "soc";
 		ranges = <0 f0000000 0000c000>;
@@ -214,13 +214,31 @@
 		ethernet@3000 {
 			device_type = "network";
 			compatible = "mpc5200b-fec","mpc5200-fec";
-			reg = <3000 800>;
+			reg = <3000 400>;
 			local-mac-address = [ 00 00 00 00 00 00 ]; /* Filled in by U-Boot */
 			interrupts = <2 5 0>;
 			interrupt-parent = <&mpc5200_pic>;
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "mpc5200b-fec-phy";
+			reg = <3000 400>;	// fec range, since we need to setup fec interrupts
+			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
+			interrupt-parent = <&mpc5200_pic>;
+
+			phy0:ethernet-phy@0 {
+				device_type = "ethernet-phy";
+				reg = <0>;
+			};
 		};
 
 		i2c@3d40 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "mpc5200b-i2c","mpc5200-i2c","fsl-i2c";
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
@@ -233,4 +251,22 @@
 			reg = <8000 4000>;
 		};
 	};
+
+	lpb {
+		model = "fsl,lpb";
+		compatible = "fsl,lpb";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 fc000000 2000000>;
+
+		// 16-bit flash device at LocalPlus Bus CS0
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 2000000>;
+			bank-width = <2>;
+			device-width = <2>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
index d8c316a..1a046aa 100644
--- a/arch/powerpc/boot/dts/motionpro.dts
+++ b/arch/powerpc/boot/dts/motionpro.dts
@@ -46,7 +46,7 @@
 
 	soc5200@f0000000 {
 		model = "fsl,mpc5200b";
-		compatible = "fsl,mpc5200b";
+		compatible = "fsl,mpc5200-immr";
 		revision = "";			// from bootloader
 		device_type = "soc";
 		ranges = <0 f0000000 0000c000>;
@@ -134,6 +134,13 @@
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
+		mscan@900 {
+			compatible = "mpc5200b-mscan\0mpc5200-mscan";
+			interrupts = <2 11 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			reg = <900 80>;
+		};
+
 		mscan@980 {
 			compatible = "mpc5200b-mscan","mpc5200-mscan";
 			interrupts = <2 12 0>;
@@ -155,7 +162,6 @@
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
-
 		spi@f00 {
 			compatible = "mpc5200b-spi","mpc5200-spi";
 			reg = <f00 20>;
@@ -216,10 +222,26 @@
 		ethernet@3000 {
 			device_type = "network";
 			compatible = "mpc5200b-fec","mpc5200-fec";
-			reg = <3000 800>;
+			reg = <3000 400>;
 			local-mac-address = [ 00 00 00 00 00 00 ]; /* Filled in by U-Boot */
 			interrupts = <2 5 0>;
 			interrupt-parent = <&mpc5200_pic>;
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "mpc5200b-fec-phy";
+			reg = <3000 400>;	// fec range, since we need to setup fec interrupts
+			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
+			interrupt-parent = <&mpc5200_pic>;
+
+			phy0:ethernet-phy@0 {
+				device_type = "ethernet-phy";
+				reg = <0>;
+			};
 		};
 
 		ata@3a00 {
@@ -230,11 +252,19 @@
 		};
 
 		i2c@3d40 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "mpc5200b-i2c","mpc5200-i2c","fsl-i2c";
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
+
+			rtc@68 {
+				device_type = "rtc";
+				compatible = "dallas,ds1339";
+				reg = <68>;
+			};
 		};
 
 		sram@8000 {
@@ -248,7 +278,8 @@
 		compatible = "fsl,lpb";
 		#address-cells = <2>;
 		#size-cells = <1>;
-		ranges = <1 0 50000000 00010000
+		ranges = <0 0 ff000000 01000000
+			  1 0 50000000 00010000
 			  2 0 50010000 00010000
 			  3 0 50020000 00010000>;
 
@@ -279,6 +310,16 @@
 			compatible = "promess,pro_module_dio";
 			reg = <3 800 2>;
 		};
+
+		// 16-bit flash device at LocalPlus Bus CS0
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 01000000>;
+			bank-width = <2>;
+			device-width = <2>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+		};
 	};
 
 	pci@f0000d00 {
diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tqm5200.dts
index 5017cec..54fb2a2 100644
--- a/arch/powerpc/boot/dts/tqm5200.dts
+++ b/arch/powerpc/boot/dts/tqm5200.dts
@@ -46,7 +46,7 @@
 
 	soc5200@f0000000 {
 		model = "fsl,mpc5200";
-		compatible = "fsl,mpc5200";
+		compatible = "fsl,mpc5200-immr";
 		revision = "";			// from bootloader
 		device_type = "soc";
 		ranges = <0 f0000000 0000c000>;
@@ -134,10 +134,26 @@
 		ethernet@3000 {
 			device_type = "network";
 			compatible = "mpc5200-fec";
-			reg = <3000 800>;
+			reg = <3000 400>;
 			local-mac-address = [ 00 00 00 00 00 00 ]; /* Filled in by U-Boot */
 			interrupts = <2 5 0>;
 			interrupt-parent = <&mpc5200_pic>;
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "mpc5200b-fec-phy";
+			reg = <3000 400>;	// fec range, since we need to setup fec interrupts
+			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
+			interrupt-parent = <&mpc5200_pic>;
+
+			phy0:ethernet-phy@0 {
+				device_type = "ethernet-phy";
+				reg = <0>;
+			};
 		};
 
 		ata@3a00 {
@@ -148,11 +164,19 @@
 		};
 
 		i2c@3d40 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "mpc5200-i2c","fsl-i2c";
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
+
+			rtc@68 {
+				device_type = "rtc";
+				compatible = "dallas,ds1307";
+				reg = <68>;
+			};
 		};
 
 		sram@8000 {
@@ -161,6 +185,23 @@
 		};
 	};
 
+	lpb {
+		model = "fsl,lpb";
+		compatible = "fsl,lpb";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 fc000000 02000000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 02000000>;
+			bank-width = <4>;
+			device-width = <2>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+		};
+	};
+
 	pci@f0000d00 {
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
