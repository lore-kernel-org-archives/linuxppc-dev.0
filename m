Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE013.bigfish.com (ch1ehsobe002.messaging.microsoft.com
	[216.32.181.182]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3C1F2B6FD9
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jun 2011 05:03:12 +1000 (EST)
Received: from mail125-ch1 (localhost.localdomain [127.0.0.1])	by
	mail125-ch1-R.bigfish.com (Postfix) with ESMTP id EB37717082A0	for
	<linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2011 19:03:08 +0000 (UTC)
Received: from CH1EHSMHS011.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.248])	by mail125-ch1.bigfish.com (Postfix) with ESMTP id
	C94B41BE804B	for <linuxppc-dev@ozlabs.org>;
	Wed,  8 Jun 2011 19:03:08 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] [v2] powerpc/p1022ds: fix audio-related properties in the
	device tree
Date: Wed, 8 Jun 2011 14:03:05 -0500
Message-ID: <1307559785-11007-1-git-send-email-timur@freescale.com>
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

On the Freescale P1022DS reference board, the SSI audio controller is
connected in "asynchronous" mode to the codec's clocks, so the device tree
needs an "fsl,ssi-asynchronous" property.

Also remove the clock-frequency property from the wm8776 node, because
the clock is enabled only if U-Boot enables it, and U-Boot will set the
property if the clock is enabled.  A future version of the P1022DS audio
driver will configure the clock itself, but for now, the driver should
not be told that the clock is running when it isn't.

Also fix the FIFO depth to 15, instead of 16.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/dts/p1022ds.dts |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index 4f685a7..98d9426 100644
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -209,8 +209,10 @@
 			wm8776:codec@1a {
 				compatible = "wlf,wm8776";
 				reg = <0x1a>;
-				/* MCLK source is a stand-alone oscillator */
-				clock-frequency = <12288000>;
+				/*
+				 * clock-frequency will be set by U-Boot if
+				 * the clock is enabled.
+				 */
 			};
 		};
 
@@ -280,7 +282,8 @@
 			codec-handle = <&wm8776>;
 			fsl,playback-dma = <&dma00>;
 			fsl,capture-dma = <&dma01>;
-			fsl,fifo-depth = <16>;
+			fsl,fifo-depth = <15>;
+			fsl,ssi-asynchronous;
 		};
 
 		dma@c300 {
-- 
1.7.3.4
