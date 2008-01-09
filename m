Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id DAEE0DDF77
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 16:18:35 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/5] sbc8548: Convert device tree to be dts-v1 compatible
Date: Wed,  9 Jan 2008 00:18:29 -0500
Message-Id: <11998559133555-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <11998559133433-git-send-email-paul.gortmaker@windriver.com>
References: <1199855910574-git-send-email-paul.gortmaker@windriver.com>
	<11998559111835-git-send-email-paul.gortmaker@windriver.com>
	<11998559121892-git-send-email-paul.gortmaker@windriver.com>
	<11998559133433-git-send-email-paul.gortmaker@windriver.com>
Message-Id: <348e7ca62344d49564f55b97ec14a874b4a59905.1199854466.git.paul.gortmaker@windriver.com>
In-Reply-To: <93a0b006474cd6884392682c82b232fc2aea7794.1199854466.git.paul.gortmaker@windriver.com>
References: <93a0b006474cd6884392682c82b232fc2aea7794.1199854466.git.paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This converts the dts to be dts-v1 compatible.  Tested with the latest
git pull of dtc (Dec 21/07).

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8548.dts |  122 +++++++++++++++++++------------------
 1 files changed, 62 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index e63ed20..14be38a 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -12,6 +12,8 @@
  */
 
 
+/dts-v1/;
+
 / {
 	model = "SBC8548";
 	compatible = "SBC8548";
@@ -35,10 +37,10 @@
 		PowerPC,8548@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
-			d-cache-size = <8000>;		// L1, 32K
-			i-cache-size = <8000>;		// L1, 32K
+			d-cache-line-size = <0x20>;	// 32 bytes
+			i-cache-line-size = <0x20>;	// 32 bytes
+			d-cache-size = <0x8000>;	// L1, 32K
+			i-cache-size = <0x8000>;	// L1, 32K
 			timebase-frequency = <0>;	// From uboot
 			bus-frequency = <0>;
 			clock-frequency = <0>;
@@ -47,31 +49,31 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 10000000>;
+		reg = <0x00000000 0x10000000>;
 	};
 
 	soc8548@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		ranges = <00000000 e0000000 00100000>;
-		reg = <e0000000 00001000>;	// CCSRBAR
+		ranges = <0x00000000 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00001000>;	// CCSRBAR
 		bus-frequency = <0>;
 
 		memory-controller@2000 {
 			compatible = "fsl,8548-memory-controller";
-			reg = <2000 1000>;
+			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
-			interrupts = <12 2>;
+			interrupts = <0x12 0x2>;
 		};
 
 		l2-cache-controller@20000 {
 			compatible = "fsl,8548-l2-cache-controller";
-			reg = <20000 1000>;
-			cache-line-size = <20>;	// 32 bytes
-			cache-size = <80000>;	// L2, 512K
+			reg = <0x20000 0x1000>;
+			cache-line-size = <0x20>;	// 32 bytes
+			cache-size = <0x80000>;	// L2, 512K
 			interrupt-parent = <&mpic>;
-			interrupts = <10 2>;
+			interrupts = <0x10 0x2>;
 		};
 
 		i2c@3000 {
@@ -79,8 +81,8 @@
 			#size-cells = <0>;
 			cell-index = <0>;
 			compatible = "fsl-i2c";
-			reg = <3000 100>;
-			interrupts = <2b 2>;
+			reg = <0x3000 0x100>;
+			interrupts = <0x2b 0x2>;
 			interrupt-parent = <&mpic>;
 			dfsrr;
 		};
@@ -90,8 +92,8 @@
 			#size-cells = <0>;
 			cell-index = <1>;
 			compatible = "fsl-i2c";
-			reg = <3100 100>;
-			interrupts = <2b 2>;
+			reg = <0x3100 0x100>;
+			interrupts = <0x2b 0x2>;
 			interrupt-parent = <&mpic>;
 			dfsrr;
 		};
@@ -100,18 +102,18 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,gianfar-mdio";
-			reg = <24520 20>;
+			reg = <0x24520 0x20>;
 
 			phy0: ethernet-phy@19 {
 				interrupt-parent = <&mpic>;
-				interrupts = <6 1>;
-				reg = <19>;
+				interrupts = <0x6 0x1>;
+				reg = <0x19>;
 				device_type = "ethernet-phy";
 			};
 			phy1: ethernet-phy@1a {
 				interrupt-parent = <&mpic>;
-				interrupts = <7 1>;
-				reg = <1a>;
+				interrupts = <0x7 0x1>;
+				reg = <0x1a>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -121,9 +123,9 @@
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
-			reg = <24000 1000>;
+			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <1d 2 1e 2 22 2>;
+			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
 		};
@@ -133,9 +135,9 @@
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
-			reg = <25000 1000>;
+			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <23 2 24 2 28 2>;
+			interrupts = <0x23 0x2 0x24 0x2 0x28 0x2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy1>;
 		};
@@ -144,9 +146,9 @@
 			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4500 100>;	// reg base, size
+			reg = <0x4500 0x100>;	// reg base, size
 			clock-frequency = <0>;	// should we fill in in uboot?
-			interrupts = <2a 2>;
+			interrupts = <0x2a 0x2>;
 			interrupt-parent = <&mpic>;
 		};
 
@@ -154,15 +156,15 @@
 			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4600 100>;	// reg base, size
+			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>;	// should we fill in in uboot?
-			interrupts = <2a 2>;
+			interrupts = <0x2a 0x2>;
 			interrupt-parent = <&mpic>;
 		};
 
 		global-utilities@e0000 {	//global utilities reg
 			compatible = "fsl,mpc8548-guts";
-			reg = <e0000 1000>;
+			reg = <0xe0000 0x1000>;
 			fsl,has-rstcr;
 		};
 
@@ -171,7 +173,7 @@
 			#address-cells = <0>;
 			#size-cells = <0>;
 			#interrupt-cells = <2>;
-			reg = <40000 40000>;
+			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
                         big-endian;
@@ -180,63 +182,63 @@
 
 	pci0: pci@e0008000 {
 		cell-index = <0>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 			/* IDSEL 0x01 (PCI-X slot) */
-			00800 0 0 1 &mpic 0 1
-			00800 0 0 2 &mpic 1 1
-			00800 0 0 3 &mpic 2 1
-			00800 0 0 4 &mpic 3 1>;
+			0x0800 0x0 0x0 0x1 &mpic 0x0 0x1
+			0x0800 0x0 0x0 0x2 &mpic 0x1 0x1
+			0x0800 0x0 0x0 0x3 &mpic 0x2 0x1
+			0x0800 0x0 0x0 0x4 &mpic 0x3 0x1>;
 
 		interrupt-parent = <&mpic>;
-		interrupts = <18 2>;
+		interrupts = <0x18 0x2>;
 		bus-range = <0 0>;
-		ranges = <02000000 0 80000000 80000000 0 10000000
-			  01000000 0 00000000 e2000000 0 00800000>;
-		clock-frequency = <3f940aa>;
+		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00800000>;
+		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <e0008000 1000>;
+		reg = <0xe0008000 0x1000>;
 		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
 		device_type = "pci";
 	};
 
 	pci2: pcie@e000a000 {
 		cell-index = <2>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 
 			/* IDSEL 0x0 (PEX) */
-			00000 0 0 1 &mpic 0 1
-			00000 0 0 2 &mpic 1 1
-			00000 0 0 3 &mpic 2 1
-			00000 0 0 4 &mpic 3 1>;
+			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
+			0x0000 0x0 0x0 0x2 &mpic 0x1 0x1
+			0x0000 0x0 0x0 0x3 &mpic 0x2 0x1
+			0x0000 0x0 0x0 0x4 &mpic 0x3 0x1>;
 
 		interrupt-parent = <&mpic>;
-		interrupts = <1a 2>;
-		bus-range = <0 ff>;
-		ranges = <02000000 0 a0000000 a0000000 0 20000000
-			  01000000 0 00000000 e3000000 0 08000000>;
-		clock-frequency = <1fca055>;
+		interrupts = <0x1a 0x2>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0xe3000000 0x0 0x08000000>;
+		clock-frequency = <33333333>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <e000a000 1000>;
+		reg = <0xe000a000 0x1000>;
 		compatible = "fsl,mpc8548-pcie";
 		device_type = "pci";
 		pcie@0 {
-			reg = <0 0 0 0 0>;
+			reg = <0x0 0x0 0x0 0x0 0x0>;
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-			ranges = <02000000 0 a0000000
-				  02000000 0 a0000000
-				  0 20000000
+			ranges = <0x02000000 0x0 0xa0000000
+				  0x02000000 0x0 0xa0000000
+				  0x0 0x20000000
 
-				  01000000 0 00000000
-				  01000000 0 00000000
-				  0 08000000>;
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x08000000>;
 		};
 	};
 };
-- 
1.5.0.rc1.gf4b6c
