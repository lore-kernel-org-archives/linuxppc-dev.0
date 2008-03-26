Return-Path: <tur@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ACFADDEEE4
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 08:07:23 +1100 (EST)
Date: Wed, 26 Mar 2008 22:18:49 +0100
From: Bartlomiej Sieka <tur@semihalf.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [RESEND2][POWERPC] mpc5200: Amalgamated dts fixes and updates
Message-ID: <20080326211846.GA1895@frozen.semihalf.com>
References: <47E2723D.1090101@grandegger.com> <47E281B6.20702@denx.de>
	<fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>
	<47E2FC3E.1020705@semihalf.com>
	<fa686aa40803201720l3e42c983se121ebc257c89912@mail.gmail.com>
	<20080321235633.GB345@frozen.semihalf.com>
	<fa686aa40803212014ne560615sfcdef542d59eb6cb@mail.gmail.com>
	<20080326194526.GA17424@frozen.semihalf.com>
	<fa686aa40803261335q2b8af09cw6f05dc0cf905d0b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40803261335q2b8af09cw6f05dc0cf905d0b5@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

    The bulk of this patch is taken from
    http://patchwork.ozlabs.org/linuxppc/patch?q=Balakowicz&id=16197, with few
    other updates.
    
    Signed-off-by: Marian Balakowicz <m8@semihalf.com>

diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
index 30737ea..2d25ca8 100644
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
+			phy0:ethernet-phy@0 {
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
index 76951ab..d86eba0 100644
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
+			phy0:ethernet-phy@2 {
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
index c86464f..d2dc278 100644
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
+			phy0:ethernet-phy@0 {
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
