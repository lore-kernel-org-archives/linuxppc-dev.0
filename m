Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C4B7DDDED
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 05:44:47 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	mAJIihxx018979
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 11:44:43 -0700 (MST)
From: Trent Piepho <tpiepho@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: L2 cache size wrong in 8572DS dts
Date: Wed, 19 Nov 2008 10:40:55 -0800
Message-Id: <1227120055-6459-1-git-send-email-tpiepho@freescale.com>
Cc: Gala Kumar <kumar.gala@freescale.com>, Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It's 1MB, not 512KB.  Newer U-Boots will fix this entry, but that's no
reason to have the wrong value in the dts.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
Acked-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8572ds.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index cadd465..5c69b2f 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -90,7 +90,7 @@
 			compatible = "fsl,mpc8572-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
-			cache-size = <0x80000>;	// L2, 512K
+			cache-size = <0x100000>; // L2, 1M
 			interrupt-parent = <&mpic>;
 			interrupts = <16 2>;
 		};
-- 
1.5.4.1
