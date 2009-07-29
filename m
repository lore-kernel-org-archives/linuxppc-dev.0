Return-Path: <sr@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 17623B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jul 2009 21:41:12 +1000 (EST)
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38E2EDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2009 21:41:09 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/40x: Update Kilauea dts to support NAND,
	RTC and HWMON
Date: Wed, 29 Jul 2009 13:40:56 +0200
Message-Id: <1248867656-28147-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for the following devices to the Kilauea dts:
- PPC4xx NAND controller (NDFC)
- I2C RTC (Dallas DS1338)
- I2C HWMON (Dallas DS1775)

Additionally the partitioning of the NOR FLASH is changed. The dtb
partition has been missing. Fixed in this patch.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/kilauea.dts |   44 ++++++++++++++++++++++++++++++++++--
 1 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
index 5e6b08f..c465614 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -1,7 +1,7 @@
 /*
  * Device Tree Source for AMCC Kilauea (405EX)
  *
- * Copyright 2007 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ * Copyright 2007-2009 DENX Software Engineering, Stefan Roese <sr@denx.de>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without
@@ -150,7 +150,11 @@
 					#size-cells = <1>;
 					partition@0 {
 						label = "kernel";
-						reg = <0x00000000 0x00200000>;
+						reg = <0x00000000 0x001e0000>;
+					};
+					partition@1e0000 {
+						label = "dtb";
+						reg = <0x001e0000 0x00020000>;
 					};
 					partition@200000 {
 						label = "root";
@@ -169,6 +173,29 @@
 						reg = <0x03fa0000 0x00060000>;
 					};
 				};
+
+				ndfc@1,0 {
+					compatible = "ibm,ndfc";
+					reg = <0x00000001 0x00000000 0x00002000>;
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
 
 			UART0: serial@ef600200 {
@@ -198,6 +225,18 @@
 				reg = <0xef600400 0x00000014>;
 				interrupt-parent = <&UIC0>;
 				interrupts = <0x2 0x4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				rtc@68 {
+					compatible = "dallas,ds1338";
+					reg = <0x68>;
+				};
+
+				dtt@48 {
+					compatible = "dallas,ds1775";
+					reg = <0x48>;
+				};
 			};
 
 			IIC1: i2c@ef600500 {
@@ -207,7 +246,6 @@
 				interrupts = <0x7 0x4>;
 			};
 
-
 			RGMII0: emac-rgmii@ef600b00 {
 				compatible = "ibm,rgmii-405ex", "ibm,rgmii";
 				reg = <0xef600b00 0x00000104>;
-- 
1.6.3.4
