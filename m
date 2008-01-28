Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 35285DDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 18:28:05 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/9] sbc8349: convert human parseable DTS properties to decimal
Date: Mon, 28 Jan 2008 02:27:53 -0500
Message-Id: <d8e187e4d4aa981109450f333658730e3408f627.1201503958.git.paul.gortmaker@windriver.com>
In-Reply-To: <51b1015cd61540df832ee5d5ee125e7326c3f0ed.1201503958.git.paul.gortmaker@windriver.com>
References: <1201505279-25847-1-git-send-email-paul.gortmaker@windriver.com>
	<a050480a21aef92854805e9bee517c0d65d5bd59.1201503958.git.paul.gortmaker@windriver.com>
	<51b1015cd61540df832ee5d5ee125e7326c3f0ed.1201503958.git.paul.gortmaker@windriver.com>
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

To be consistent with the other DTS v1 conversions pending,
things like cache size and IRQ values should be decimal.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8349.dts |   40 ++++++++++++++++++------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sbc8349.dts
index 9c13c1a..a36ef93 100644
--- a/arch/powerpc/boot/dts/sbc8349.dts
+++ b/arch/powerpc/boot/dts/sbc8349.dts
@@ -36,10 +36,10 @@
 		PowerPC,8349@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <0x20>;	// 32 bytes
-			i-cache-line-size = <0x20>;	// 32 bytes
-			d-cache-size = <0x8000>;		// L1, 32K
-			i-cache-size = <0x8000>;		// L1, 32K
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
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
@@ -89,7 +89,7 @@
 		spi@7000 {
 			compatible = "fsl_spi";
 			reg = <0x7000 0x1000>;
-			interrupts = <0x10 0x8>;
+			interrupts = <16 0x8>;
 			interrupt-parent = <&ipic>;
 			mode = "cpu";
 		};
@@ -102,7 +102,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupt-parent = <&ipic>;
-			interrupts = <0x27 0x8>;
+			interrupts = <39 0x8>;
 			phy_type = "ulpi";
 			port1;
 		};
@@ -114,7 +114,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupt-parent = <&ipic>;
-			interrupts = <0x26 0x8>;
+			interrupts = <38 0x8>;
 			dr_mode = "otg";
 			phy_type = "ulpi";
 		};
@@ -127,13 +127,13 @@
 
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
@@ -146,7 +146,7 @@
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x20 0x8 0x21 0x8 0x22 0x8>;
+			interrupts = <32 0x8 33 0x8 34 0x8>;
 			interrupt-parent = <&ipic>;
 			phy-handle = <&phy0>;
 			linux,network-index = <0>;
@@ -159,7 +159,7 @@
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x23 0x8 0x24 0x8 0x25 0x8>;
+			interrupts = <35 0x8 36 0x8 37 0x8>;
 			interrupt-parent = <&ipic>;
 			phy-handle = <&phy1>;
 			linux,network-index = <1>;
@@ -171,7 +171,7 @@
 			compatible = "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <0x9 0x8>;
+			interrupts = <9 0x8>;
 			interrupt-parent = <&ipic>;
 		};
 
@@ -181,7 +181,7 @@
 			compatible = "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <0xa 0x8>;
+			interrupts = <10 0x8>;
 			interrupt-parent = <&ipic>;
 		};
 
@@ -190,7 +190,7 @@
 			model = "SEC2";
 			compatible = "talitos";
 			reg = <0x30000 0x10000>;
-			interrupts = <0xb 0x8>;
+			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
 			num-channels = <4>;
 			channel-fifo-len = <0x18>;
@@ -221,10 +221,10 @@
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
