Return-Path: <sr@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 26820B7B7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 03:05:11 +1000 (EST)
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 667A8DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 03:05:10 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/44x: Add NAND support to Canyonlands dts
Date: Wed, 29 Jul 2009 19:05:01 +0200
Message-Id: <1248887101-3508-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Also some whitespace cleanup in the USB device nodes.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/canyonlands.dts |   49 ++++++++++++++++++++++++---------
 1 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index 5fd1ad0..c920170 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -1,7 +1,7 @@
 /*
  * Device Tree Source for AMCC Canyonlands (460EX)
  *
- * Copyright 2008 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ * Copyright 2008-2009 DENX Software Engineering, Stefan Roese <sr@denx.de>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without
@@ -149,19 +149,19 @@
 					/*RXDE*/  0x5 0x4>;
 		};
 
-                USB0: ehci@bffd0400 {
-                        compatible = "ibm,usb-ehci-460ex", "usb-ehci";
-                        interrupt-parent = <&UIC2>;
-                        interrupts = <0x1d 4>;
-                        reg = <4 0xbffd0400 0x90 4 0xbffd0490 0x70>;
-                };
+		USB0: ehci@bffd0400 {
+			compatible = "ibm,usb-ehci-460ex", "usb-ehci";
+			interrupt-parent = <&UIC2>;
+			interrupts = <0x1d 4>;
+			reg = <4 0xbffd0400 0x90 4 0xbffd0490 0x70>;
+		};
 
-                USB1: usb@bffd0000 {
-                        compatible = "ohci-le";
-                        reg = <4 0xbffd0000 0x60>;
-                        interrupt-parent = <&UIC2>;
-                        interrupts = <0x1e 4>;
-                };
+		USB1: usb@bffd0000 {
+			compatible = "ohci-le";
+			reg = <4 0xbffd0000 0x60>;
+			interrupt-parent = <&UIC2>;
+			interrupts = <0x1e 4>;
+		};
 
 		POB0: opb {
 			compatible = "ibm,opb-460ex", "ibm,opb";
@@ -215,6 +215,29 @@
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
-- 
1.6.3.4
