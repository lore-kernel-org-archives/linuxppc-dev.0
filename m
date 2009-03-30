Return-Path: <wg@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E2D10DDE07
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 21:06:00 +1100 (EST)
Message-Id: <20090330100555.428525142@denx.de>
Date: Mon, 30 Mar 2009 12:02:45 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
To: linux-mtd@lists.infradead.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH v4 4/4] powerpc/85xx: TQM8548: Update DTS file for multi-chip
	support
References: <20090330100241.346785618@denx.de>
Cc: devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds multi-chip support for the Micron MT29F8G08FAB NAND
flash memory on the TQM8548 modules.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/boot/dts/tqm8548-bigflash.dts |    7 +++++--
 arch/powerpc/boot/dts/tqm8548.dts          |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

Index: linux-2.6/arch/powerpc/boot/dts/tqm8548-bigflash.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/tqm8548-bigflash.dts	2009-03-30 12:01:22.015719619 +0200
+++ linux-2.6/arch/powerpc/boot/dts/tqm8548-bigflash.dts	2009-03-30 12:01:45.007720662 +0200
@@ -380,10 +380,13 @@
 		upm@3,0 {
 			#address-cells = <0>;
 			#size-cells = <0>;
-			compatible = "fsl,upm-nand";
+			compatible = "tqc,tqm8548-upm-nand", "fsl,upm-nand";
 			reg = <3 0x0 0x800>;
 			fsl,upm-addr-offset = <0x10>;
 			fsl,upm-cmd-offset = <0x08>;
+			/* Micron MT29F8G08FAB multi-chip device */
+			fsl,upm-addr-line-cs-offsets = <0x0 0x200>;
+			fsl,upm-wait-flags = <0x5>;
 			chip-delay = <25>; // in micro-seconds
 
 			nand@0 {
@@ -392,7 +395,7 @@
 
 				partition@0 {
 					    label = "fs";
-					    reg = <0x00000000 0x01000000>;
+					    reg = <0x00000000 0x10000000>;
 				};
 			};
 		};
Index: linux-2.6/arch/powerpc/boot/dts/tqm8548.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/tqm8548.dts	2009-03-30 12:01:22.015719619 +0200
+++ linux-2.6/arch/powerpc/boot/dts/tqm8548.dts	2009-03-30 12:01:45.008720246 +0200
@@ -380,10 +380,13 @@
 		upm@3,0 {
 			#address-cells = <0>;
 			#size-cells = <0>;
-			compatible = "fsl,upm-nand";
+			compatible = "tqc,tqm8548-upm-nand", "fsl,upm-nand";
 			reg = <3 0x0 0x800>;
 			fsl,upm-addr-offset = <0x10>;
 			fsl,upm-cmd-offset = <0x08>;
+			/* Micron MT29F8G08FAB multi-chip device */
+			fsl,upm-addr-line-cs-offsets = <0x0 0x200>;
+			fsl,upm-wait-flags = <0x5>;
 			chip-delay = <25>; // in micro-seconds
 
 			nand@0 {
@@ -392,7 +395,7 @@
 
 				partition@0 {
 					    label = "fs";
-					    reg = <0x00000000 0x01000000>;
+					    reg = <0x00000000 0x10000000>;
 				};
 			};
 		};
