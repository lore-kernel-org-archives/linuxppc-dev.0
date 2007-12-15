Return-Path: <SRS0=z9zg=RG=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 0EA3CDDD0A
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 19:16:03 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Change Kilauea PCIe bus ranges in dts file
Date: Sat, 15 Dec 2007 09:10:56 +0100
Message-Id: <1197706256-18179-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently we have some limitations in the 4xx PCIe driver and can't
support all possible PCIe busses. But the current limits in the
dts file are quite low (only 16 busses per RC). This patch increases
the number to 64 per RC.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/kilauea.dts |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
index 3814199..67c7ea1 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -284,8 +284,8 @@
 			/* Inbound 2GB range starting at 0 */
 			dma-ranges = <42000000 0 0 0 0 80000000>;
 
-			/* This drives busses 0x00 to 0x0f */
-			bus-range = <00 0f>;
+			/* This drives busses 0x00 to 0x3f */
+			bus-range = <00 3f>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
 			 * to invert PCIe legacy interrupts).
@@ -325,8 +325,8 @@
 			/* Inbound 2GB range starting at 0 */
 			dma-ranges = <42000000 0 0 0 0 80000000>;
 
-			/* This drives busses 0x10 to 0x1f */
-			bus-range = <10 1f>;
+			/* This drives busses 0x40 to 0x7f */
+			bus-range = <40 7f>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
 			 * to invert PCIe legacy interrupts).
-- 
1.5.3.7.949.g2221a6
