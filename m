Return-Path: <Jeremy.McNicoll@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 4938FDDF4E
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 18:55:33 +1100 (EST)
From: Jeremy McNicoll <jeremy.mcnicoll@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] sbc8548: fix incorrect PCI-X and PCI interrupt map
Date: Fri,  7 Mar 2008 15:14:09 -0500
Message-Id: <1204920849-31741-1-git-send-email-jeremy.mcnicoll@windriver.com>
Cc: Jeremy McNicoll <jeremy.mcnicoll@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patch allows interrupts to occur on the
sbc8548. Currently PCI and PCI-X devices get assigned an IRQ
but the interrupt count never increases.  This solves the
problem and adds PCI support as well.

Signed-off-by: Jeremy McNicoll <jeremy.mcnicoll@windriver.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8548.dts |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index 14be38a..b86e65d 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -184,11 +184,17 @@
 		cell-index = <0>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
-			/* IDSEL 0x01 (PCI-X slot) */
-			0x0800 0x0 0x0 0x1 &mpic 0x0 0x1
-			0x0800 0x0 0x0 0x2 &mpic 0x1 0x1
-			0x0800 0x0 0x0 0x3 &mpic 0x2 0x1
-			0x0800 0x0 0x0 0x4 &mpic 0x3 0x1>;
+			/* IDSEL 0x01 (PCI-X slot) @66MHz */
+			0x0800 0x0 0x0 0x1 &mpic 0x2 0x1
+			0x0800 0x0 0x0 0x2 &mpic 0x3 0x1
+			0x0800 0x0 0x0 0x3 &mpic 0x4 0x1
+			0x0800 0x0 0x0 0x4 &mpic 0x1 0x1
+
+			/* IDSEL 0x11 (PCI, 3.3V 32bit) @33MHz */
+			0x8800 0x0 0x0 0x1 &mpic 0x2 0x1
+			0x8800 0x0 0x0 0x2 &mpic 0x3 0x1
+			0x8800 0x0 0x0 0x3 &mpic 0x4 0x1
+			0x8800 0x0 0x0 0x4 &mpic 0x1 0x1>;
 
 		interrupt-parent = <&mpic>;
 		interrupts = <0x18 0x2>;
-- 
1.5.3.7
