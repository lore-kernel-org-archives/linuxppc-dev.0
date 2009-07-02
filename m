Return-Path: <martyn.welch@gefanuc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8E31DB70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 00:18:39 +1000 (EST)
Received: from exprod5og103.obsmtp.com (exprod5og103.obsmtp.com [64.18.0.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 614F7DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 00:18:36 +1000 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH] powerpc/86xx: Update GE Fanuc sbc310 DTS
To: galak@kernel.crashing.org
Date: Thu, 02 Jul 2009 15:18:25 +0100
Message-ID: <20090702141825.22330.83064.stgit@ES-J7S4D2J.amer.consind.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update GE Fanuc DTS to match the alterations suggested during the merge of the ppc9a DTS in commit 740d36ae6344f38c4da64c2ede765d7d2dd1f132

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_sbc310.dts |   29 +++++++++++++----------------
 1 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc310.dts b/arch/powerpc/boot/dts/gef_sbc310.dts
index 7810ea9..2107d3c 100644
--- a/arch/powerpc/boot/dts/gef_sbc310.dts
+++ b/arch/powerpc/boot/dts/gef_sbc310.dts
@@ -83,34 +83,34 @@
 
 		/* flash@0,0 is a mirror of part of the memory in flash@1,0
 		flash@0,0 {
-			compatible = "cfi-flash";
-			reg = <0 0 0x01000000>;
+			compatible = "gef,sbc310-firmware-mirror", "cfi-flash";
+			reg = <0x0 0x0 0x01000000>;
 			bank-width = <2>;
 			device-width = <2>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			partition@0 {
 				label = "firmware";
-				reg = <0x00000000 0x01000000>;
+				reg = <0x0 0x01000000>;
 				read-only;
 			};
 		};
 		*/
 
 		flash@1,0 {
-			compatible = "cfi-flash";
-			reg = <1 0 0x8000000>;
+			compatible = "gef,sbc310-paged-flash", "cfi-flash";
+			reg = <0x1 0x0 0x8000000>;
 			bank-width = <2>;
 			device-width = <2>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			partition@0 {
 				label = "user";
-				reg = <0x00000000 0x07800000>;
+				reg = <0x0 0x7800000>;
 			};
 			partition@7800000 {
 				label = "firmware";
-				reg = <0x07800000 0x00800000>;
+				reg = <0x7800000 0x800000>;
 				read-only;
 			};
 		};
@@ -121,18 +121,16 @@
 		};
 
 		wdt@4,2000 {
-			#interrupt-cells = <2>;
-			device_type = "watchdog";
-			compatible = "gef,fpga-wdt";
+			compatible = "gef,sbc310-fpga-wdt", "gef,fpga-wdt-1.00",
+				"gef,fpga-wdt";
 			reg = <0x4 0x2000 0x8>;
 			interrupts = <0x1a 0x4>;
 			interrupt-parent = <&gef_pic>;
 		};
 /*
 		wdt@4,2010 {
-			#interrupt-cells = <2>;
-			device_type = "watchdog";
-			compatible = "gef,fpga-wdt";
+			compatible = "gef,sbc310-fpga-wdt", "gef,fpga-wdt-1.00",
+				"gef,fpga-wdt";
 			reg = <0x4 0x2010 0x8>;
 			interrupts = <0x1b 0x4>;
 			interrupt-parent = <&gef_pic>;
@@ -141,7 +139,7 @@
 		gef_pic: pic@4,4000 {
 			#interrupt-cells = <1>;
 			interrupt-controller;
-			compatible = "gef,fpga-pic";
+			compatible = "gef,sbc310-fpga-pic", "gef,fpga-pic";
 			reg = <0x4 0x4000 0x20>;
 			interrupts = <0x8
 				      0x9>;
@@ -161,7 +159,7 @@
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
 		device_type = "soc";
-		compatible = "simple-bus";
+		compatible = "fsl,mpc8641-soc", "simple-bus";
 		ranges = <0x0 0xfef00000 0x00100000>;
 		bus-frequency = <33333333>;
 
@@ -412,5 +410,4 @@
 				  0x0 0x00400000>;
 		};
 	};
-
 };
