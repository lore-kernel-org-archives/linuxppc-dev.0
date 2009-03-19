Return-Path: <wg@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6BDC9DDE24
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 02:24:22 +1100 (EST)
From: Wolfgang Grandegger <wg@grandegger.com>
To: linux-mtd@lists.infradead.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v2 4/5] powerpc: NAND: FSL UPM: document new bindings
Date: Thu, 19 Mar 2009 16:16:07 +0100
Message-Id: <1237475768-11481-5-git-send-email-wg@grandegger.com>
In-Reply-To: <1237475768-11481-4-git-send-email-wg@grandegger.com>
References: <1237475768-11481-1-git-send-email-wg@grandegger.com>
	<1237475768-11481-2-git-send-email-wg@grandegger.com>
	<1237475768-11481-3-git-send-email-wg@grandegger.com>
	<1237475768-11481-4-git-send-email-wg@grandegger.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds documentation for the new NAND FSL UPM bindings for:

 NAND: FSL-UPM: add multi chip support
 NAND: FSL-UPM: Add wait flags to support board/chip specific delays
 NAND: FSL-UPM: add support for selecting chips via MAR

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 .../powerpc/dts-bindings/fsl/upm-nand.txt          |   42 +++++++++++++++++++-
 1 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt b/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt
index 84a04d5..3919828 100644
--- a/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt
@@ -5,9 +5,24 @@ Required properties:
 - reg : should specify localbus chip select and size used for the chip.
 - fsl,upm-addr-offset : UPM pattern offset for the address latch.
 - fsl,upm-cmd-offset : UPM pattern offset for the command latch.
-- gpios : may specify optional GPIO connected to the Ready-Not-Busy pin.
 
-Example:
+Optional properties:
+- fsl,upm-mar-offset : use the UPM machine address register to drive a
+  		       custom chip select logic using the specified
+		       offset.
+- fsl,upm-wait-flags : add chip-dependent short delays after running the
+  		       UPM pattern (0x1), after writing a data byte (0x2)
+		       or after writing out a buffer (0x4).
+- gpios : may specify optional GPIOs connected to the Ready-Not-Busy pins
+	  (R/B#). For multi-chip devices, "num-chips" GPIO definitions are
+	  required.
+- chip-delay : chip dependent delay for transfering data from array to
+	       read registers (tR). Required if property "gpios" is not
+	       used (R/B# pins not connected).
+- num-chips : number of chips per device for multi-chip support.
+- chip-offset : address offset between chips for multi-chip support.
+
+Examples:
 
 upm@1,0 {
 	compatible = "fsl,upm-nand";
@@ -26,3 +41,26 @@ upm@1,0 {
 		};
 	};
 };
+
+upm@3,0 {
+	compatible = "fsl,upm-nand";
+	reg = <3 0x0 0x800>;
+	fsl,upm-addr-offset = <0x10>;
+	fsl,upm-cmd-offset = <0x08>;
+	fsl,upm-wait-flags = <0x5>;
+	/* Multi-chip device */
+	fsl,upm-mar-chip-offset = <0x200>;
+	num-chips = <2>;
+	chip-offset = <0x200>;
+	chip-delay = <25>; // in micro-seconds
+
+	nand@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			    label = "fs";
+			    reg = <0x00000000 0x10000000>;
+		};
+	};
+};
-- 
1.6.0.6
