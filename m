Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5CD06B7205
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 16:09:55 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH][v2] powerpc/p1023: set IRQ[4:6,
 11] to active-high level sensitive for PCIe
Date: Wed, 16 Nov 2011 23:09:35 -0600
Message-Id: <1321506575-21730-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

P1023 external IRQ[4:6, 11] are not pin out, but the interrupts are
utilized by the PCIe controllers.  As they are not exposed as pins we
need to set them as active-high (internal to the SoC these interrupts
are pulled down).

IRQs[0:3,7:10] are pulled up on the board so we have them set as
active-low.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
v2:
* cleaned up commit message & added comments to be clear about IRQ usage

 arch/powerpc/boot/dts/p1023rds.dts |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1023rds.dts b/arch/powerpc/boot/dts/p1023rds.dts
index 25f9897..319c4b4 100644
--- a/arch/powerpc/boot/dts/p1023rds.dts
+++ b/arch/powerpc/boot/dts/p1023rds.dts
@@ -698,6 +698,7 @@
 			interrupt-parent = <&mpic>;
 			interrupts = <16 2>;
 			interrupt-map-mask = <0xf800 0 0 7>;
+			/* IRQ[0:3] are pulled up on board, set to active-low */
 			interrupt-map = <
 				/* IDSEL 0x0 */
 				0000 0 0 1 &mpic 0 1
@@ -737,11 +738,15 @@
 			interrupt-parent = <&mpic>;
 			interrupts = <16 2>;
 			interrupt-map-mask = <0xf800 0 0 7>;
+			/*
+			 * IRQ[4:6] only for PCIe, set to active-high,
+			 * IRQ[7] is pulled up on board, set to active-low
+			 */
 			interrupt-map = <
 				/* IDSEL 0x0 */
-				0000 0 0 1 &mpic 4 1
-				0000 0 0 2 &mpic 5 1
-				0000 0 0 3 &mpic 6 1
+				0000 0 0 1 &mpic 4 2
+				0000 0 0 2 &mpic 5 2
+				0000 0 0 3 &mpic 6 2
 				0000 0 0 4 &mpic 7 1
 				>;
 			ranges = <0x2000000 0x0 0xa0000000
@@ -776,12 +781,16 @@
 			interrupt-parent = <&mpic>;
 			interrupts = <16 2>;
 			interrupt-map-mask = <0xf800 0 0 7>;
+			/*
+			 * IRQ[8:10] are pulled up on board, set to active-low
+			 * IRQ[11] only for PCIe, set to active-high,
+			 */
 			interrupt-map = <
 				/* IDSEL 0x0 */
 				0000 0 0 1 &mpic 8 1
 				0000 0 0 2 &mpic 9 1
 				0000 0 0 3 &mpic 10 1
-				0000 0 0 4 &mpic 11 1
+				0000 0 0 4 &mpic 11 2
 				>;
 			ranges = <0x2000000 0x0 0x80000000
 				  0x2000000 0x0 0x80000000
-- 
1.7.3.4
