Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2FA28B7CF0
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 00:50:21 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/44x: Add MTD support (NOR FLASH) to Katmai dts
Date: Tue, 26 Jan 2010 14:50:07 +0100
Message-Id: <1264513807-16289-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds NOR FLASH MTD support to the Katmai (440SPe) dts file.

Additionally with a small whitespace cleanup.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/dts/katmai.dts |   71 +++++++++++++++++++++++++++----------
 1 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
index 8f345de..8cf2c0c 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -156,7 +156,7 @@
 			compatible = "ibm,opb-440spe", "ibm,opb-440gp", "ibm,opb";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x00000000 0x00000004 0xe0000000 0x20000000>;
+			ranges = <0xe0000000 0x00000004 0xe0000000 0x20000000>;
 			clock-frequency = <0>; /* Filled in by zImage */
 
 			EBC0: ebc {
@@ -165,14 +165,47 @@
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; /* Filled in by zImage */
+				/* ranges property is supplied by U-Boot */
 				interrupts = <0x5 0x1>;
 				interrupt-parent = <&UIC1>;
+
+				nor_flash@0,0 {
+					compatible = "cfi-flash";
+					bank-width = <2>;
+					reg = <0x00000000 0x00000000 0x01000000>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					partition@0 {
+						label = "kernel";
+						reg = <0x00000000 0x001e0000>;
+					};
+					partition@1e0000 {
+						label = "dtb";
+						reg = <0x001e0000 0x00020000>;
+					};
+					partition@200000 {
+						label = "root";
+						reg = <0x00200000 0x00200000>;
+					};
+					partition@400000 {
+						label = "user";
+						reg = <0x00400000 0x00b60000>;
+					};
+					partition@f60000 {
+						label = "env";
+						reg = <0x00f60000 0x00040000>;
+					};
+					partition@fa0000 {
+						label = "u-boot";
+						reg = <0x00fa0000 0x00060000>;
+					};
+				};
 			};
 
-			UART0: serial@10000200 {
+			UART0: serial@f0000200 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <0x10000200 0x00000008>;
+				reg = <0xf0000200 0x00000008>;
 				virtual-reg = <0xa0000200>;
 				clock-frequency = <0>; /* Filled in by zImage */
 				current-speed = <115200>;
@@ -180,10 +213,10 @@
 				interrupts = <0x0 0x4>;
 			};
 
-			UART1: serial@10000300 {
+			UART1: serial@f0000300 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <0x10000300 0x00000008>;
+				reg = <0xf0000300 0x00000008>;
 				virtual-reg = <0xa0000300>;
 				clock-frequency = <0>;
 				current-speed = <0>;
@@ -192,10 +225,10 @@
 			};
 
 
-			UART2: serial@10000600 {
+			UART2: serial@f0000600 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <0x10000600 0x00000008>;
+				reg = <0xf0000600 0x00000008>;
 				virtual-reg = <0xa0000600>;
 				clock-frequency = <0>;
 				current-speed = <0>;
@@ -203,27 +236,27 @@
 				interrupts = <0x5 0x4>;
 			};
 
-			IIC0: i2c@10000400 {
+			IIC0: i2c@f0000400 {
 				compatible = "ibm,iic-440spe", "ibm,iic-440gp", "ibm,iic";
-				reg = <0x10000400 0x00000014>;
+				reg = <0xf0000400 0x00000014>;
 				interrupt-parent = <&UIC0>;
 				interrupts = <0x2 0x4>;
 			};
 
-			IIC1: i2c@10000500 {
+			IIC1: i2c@f0000500 {
 				compatible = "ibm,iic-440spe", "ibm,iic-440gp", "ibm,iic";
-				reg = <0x10000500 0x00000014>;
+				reg = <0xf0000500 0x00000014>;
 				interrupt-parent = <&UIC0>;
 				interrupts = <0x3 0x4>;
 			};
 
-			EMAC0: ethernet@10000800 {
+			EMAC0: ethernet@f0000800 {
 				linux,network-index = <0x0>;
 				device_type = "network";
 				compatible = "ibm,emac-440spe", "ibm,emac4";
 				interrupt-parent = <&UIC1>;
 				interrupts = <0x1c 0x4 0x1d 0x4>;
-				reg = <0x10000800 0x00000074>;
+				reg = <0xf0000800 0x00000074>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
@@ -248,11 +281,11 @@
 			primary;
 			large-inbound-windows;
 			enable-msi-hole;
-			reg = <0x0000000c 0x0ec00000   0x00000008	/* Config space access */
-			       0x00000000 0x00000000 0x00000000		/* no IACK cycles */
-			       0x0000000c 0x0ed00000   0x00000004   /* Special cycles */
-			       0x0000000c 0x0ec80000 0x00000100	/* Internal registers */
-			       0x0000000c 0x0ec80100  0x000000fc>;	/* Internal messaging registers */
+			reg = <0x0000000c 0x0ec00000 0x00000008   /* Config space access */
+			       0x00000000 0x00000000 0x00000000   /* no IACK cycles */
+			       0x0000000c 0x0ed00000 0x00000004   /* Special cycles */
+			       0x0000000c 0x0ec80000 0x00000100   /* Internal registers */
+			       0x0000000c 0x0ec80100 0x000000fc>; /* Internal messaging registers */
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
@@ -453,6 +486,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/plb/opb/serial@10000200";
+		linux,stdout-path = "/plb/opb/serial@f0000200";
 	};
 };
-- 
1.6.6.1
