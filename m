Return-Path: <tur@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 697F6DDFF8
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 01:26:16 +1100 (EST)
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by semihalf.com (8.13.1/8.13.1) with ESMTP id m32EQAlS027630
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2008 08:26:12 -0600
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 6B70D14325
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 16:38:52 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09864-02 for <linuxppc-dev@ozlabs.org>;
	Wed,  2 Apr 2008 16:38:49 +0200 (CEST)
Received: from pollux.denx.de (host-82-135-33-74.customer.m-online.net
	[82.135.33.74])
	by mail.semihalf.com (Postfix) with ESMTP id EAE7F142DF
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 16:38:48 +0200 (CEST)
From: Bartlomiej Sieka <tur@semihalf.com>
Subject: [RESEND3 PATCH] [POWERPC] mpc5200: Amalgamated DTS fixes and updates
To: linuxppc-dev@ozlabs.org
Date: Wed, 02 Apr 2008 16:26:02 +0200
Message-ID: <20080402142417.5557.90153.stgit@pollux.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

DTS updates that fix booting problems:
- change to ethernet reg property
- addition of mdio and phy nodes
- removal of pci node (Motion-Pro board)

Other DTS updates:
- update i2c device tree nodes
- add lpb bus node and flash device (without partitions defined)
- add rtc i2c nodes

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
Changes since previous submission:
- added patch description
- added a space between "phy0:" and "ethernet-phy" per David Gibson's
  suggestion.

 arch/powerpc/boot/dts/cm5200.dts    |   37 ++++++++++++++++++++-
 arch/powerpc/boot/dts/motionpro.dts |   63 +++++++++++++++++++----------------
 arch/powerpc/boot/dts/tqm5200.dts   |   42 +++++++++++++++++++++++
 3 files changed, 112 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
index 30737ea..c6ca631 100644
--- a/arch/powerpc/boot/dts/cm5200.dts
+++ b/arch/powerpc/boot/dts/cm5200.dts
@@ -212,13 +212,30 @@
 		ethernet@3000 {
 			device_type = "network";
 			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
-			reg = <3000 800>;
+			reg = <3000 400>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
 			interrupt-parent = <&mpc5200_pic>;
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
+			reg = <3000 400>;       // fec range, since we need to setup fec interrupts
+			interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
+			interrupt-parent = <&mpc5200_pic>;
+
+			phy0: ethernet-phy@0 {
+				device_type = "ethernet-phy";
+				reg = <0>;
+			};
 		};
 
 		i2c@3d40 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
@@ -231,4 +248,22 @@
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
index 76951ab..2b0dde0 100644
--- a/arch/powerpc/boot/dts/motionpro.dts
+++ b/arch/powerpc/boot/dts/motionpro.dts
@@ -148,7 +148,6 @@
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
-
 		spi@f00 {
 			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
 			reg = <f00 20>;
@@ -209,10 +208,25 @@
 		ethernet@3000 {
 			device_type = "network";
 			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
-			reg = <3000 800>;
+			reg = <3000 400>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
 			interrupt-parent = <&mpc5200_pic>;
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
+			reg = <3000 400>;       // fec range, since we need to setup fec interrupts
+			interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
+			interrupt-parent = <&mpc5200_pic>;
+
+			phy0: ethernet-phy@2 {
+				device_type = "ethernet-phy";
+				reg = <2>;
+			};
 		};
 
 		ata@3a00 {
@@ -223,11 +237,19 @@
 		};
 
 		i2c@3d40 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
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
@@ -240,7 +262,8 @@
 		compatible = "fsl,lpb";
 		#address-cells = <2>;
 		#size-cells = <1>;
-		ranges = <1 0 50000000 00010000
+		ranges = <0 0 ff000000 01000000
+			  1 0 50000000 00010000
 			  2 0 50010000 00010000
 			  3 0 50020000 00010000>;
 
@@ -271,31 +294,15 @@
 			compatible = "promess,pro_module_dio";
 			reg = <3 800 2>;
 		};
-	};
 
-	pci@f0000d00 {
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		device_type = "pci";
-		compatible = "fsl,mpc5200b-pci","fsl,mpc5200-pci";
-		reg = <f0000d00 100>;
-		interrupt-map-mask = <f800 0 0 7>;
-		interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
-				 c000 0 0 2 &mpc5200_pic 1 1 3
-				 c000 0 0 3 &mpc5200_pic 1 2 3
-				 c000 0 0 4 &mpc5200_pic 1 3 3
-
-				 c800 0 0 1 &mpc5200_pic 1 1 3 // 2nd slot
-				 c800 0 0 2 &mpc5200_pic 1 2 3
-				 c800 0 0 3 &mpc5200_pic 1 3 3
-				 c800 0 0 4 &mpc5200_pic 0 0 3>;
-		clock-frequency = <0>; // From boot loader
-		interrupts = <2 8 0 2 9 0 2 a 0>;
-		interrupt-parent = <&mpc5200_pic>;
-		bus-range = <0 0>;
-		ranges = <42000000 0 80000000 80000000 0 20000000
-			  02000000 0 a0000000 a0000000 0 10000000
-			  01000000 0 00000000 b0000000 0 01000000>;
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
 };
diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tqm5200.dts
index c86464f..65bcea6 100644
--- a/arch/powerpc/boot/dts/tqm5200.dts
+++ b/arch/powerpc/boot/dts/tqm5200.dts
@@ -127,10 +127,25 @@
 		ethernet@3000 {
 			device_type = "network";
 			compatible = "fsl,mpc5200-fec";
-			reg = <3000 800>;
+			reg = <3000 400>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
 			interrupt-parent = <&mpc5200_pic>;
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
+			reg = <3000 400>;       // fec range, since we need to setup fec interrupts
+			interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
+			interrupt-parent = <&mpc5200_pic>;
+
+			phy0: ethernet-phy@0 {
+				device_type = "ethernet-phy";
+				reg = <0>;
+			};
 		};
 
 		ata@3a00 {
@@ -141,11 +156,19 @@
 		};
 
 		i2c@3d40 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "fsl,mpc5200-i2c","fsl-i2c";
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
+
+			 rtc@68 {
+				device_type = "rtc";
+				compatible = "dallas,ds1307";
+				reg = <68>;
+			};
 		};
 
 		sram@8000 {
@@ -154,6 +177,23 @@
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
