Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AB332B6FCC
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jun 2011 03:02:36 +1000 (EST)
Received: from mail30-db3 (localhost.localdomain [127.0.0.1])	by
	mail30-db3-R.bigfish.com (Postfix) with ESMTP id A25E718985B3	for
	<linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2011 17:02:32 +0000 (UTC)
Received: from DB3EHSMHS004.bigfish.com (unknown [10.3.81.241])	by
	mail30-db3.bigfish.com (Postfix) with ESMTP id 8731C195004F	for
	<linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2011 17:02:31 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/p1022ds: fix audio-related properties in the device
	tree
Date: Wed, 8 Jun 2011 12:02:28 -0500
Message-ID: <1307552548-740-1-git-send-email-timur@freescale.com>
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

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Without this patch, audio is broken on the P1022DS.  I don't know why I missed
this on the initial version of the device tree.  I will also post this
patch for the -stable trees.

 arch/powerpc/boot/dts/p1022ds.dts |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index 4f685a7..9255e58 100644
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
 
@@ -281,6 +283,7 @@
 			fsl,playback-dma = <&dma00>;
 			fsl,capture-dma = <&dma01>;
 			fsl,fifo-depth = <16>;
+			fsl,ssi-asynchronous;
 		};
 
 		dma@c300 {
-- 
1.7.3.4
