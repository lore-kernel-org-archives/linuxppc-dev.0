Return-Path: <r61911@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A28C9B6F18
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2011 18:47:10 +1100 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/p1023: set IRQ[4:6,
 11] to high level sensitive for PCIe
Date: Mon, 7 Nov 2011 16:32:58 +0800
Message-ID: <1320654778-3294-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P1023 external IRQ[4:6, 11] do not pin out, but the interrupts are
shared with PCIe controller.
The silicon internally ties the interrupts to L, so change the
IRQ[4:6,11] to high level sensitive for PCIe.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/boot/dts/p1023rds.dts |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1023rds.dts b/arch/powerpc/boot/dts/p1023rds.dts
index d9b7767..66bf804 100644
--- a/arch/powerpc/boot/dts/p1023rds.dts
+++ b/arch/powerpc/boot/dts/p1023rds.dts
@@ -490,9 +490,9 @@
 			interrupt-map-mask = <0xf800 0 0 7>;
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
@@ -532,7 +532,7 @@
 				0000 0 0 1 &mpic 8 1
 				0000 0 0 2 &mpic 9 1
 				0000 0 0 3 &mpic 10 1
-				0000 0 0 4 &mpic 11 1
+				0000 0 0 4 &mpic 11 2
 				>;
 			ranges = <0x2000000 0x0 0x80000000
 				  0x2000000 0x0 0x80000000
-- 
1.6.0.6
