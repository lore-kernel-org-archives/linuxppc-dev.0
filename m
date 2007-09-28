Return-Path: <jacmet@sunsite.dk>
Received: from nanv.dk (vps.korsgaard.com [64.79.194.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19731DDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 00:45:40 +1000 (EST)
Message-Id: <20070928142322.907143000@sunsite.dk>
References: <20070928142113.163317000@sunsite.dk>
Date: Fri, 28 Sep 2007 16:21:15 +0200
From: jacmet@sunsite.dk
To: galak@kernel.crashing.org,
 leoli@freescale.com,
 linuxppc-dev@ozlabs.org
Subject: [patch 2/2] mpc8349emitx.dts: Setup USB-DR for peripheral mode.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Setup dr_mode for USB-DR to peripheral as the default (host mode) doesn't make
much sense for the mini-AB connector on the ITX board.
    
Peripheral mode is preferable to OTG as the fsl_usb2_udc.c driver doesn't yet
properly support it.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.23-rc8/arch/powerpc/boot/dts/mpc8349emitx.dts
===================================================================
--- linux-2.6.23-rc8.orig/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ linux-2.6.23-rc8/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -99,6 +99,7 @@
 			#size-cells = <0>;
 			interrupt-parent = < &ipic >;
 			interrupts = <26 8>;
+			dr_mode = "peripheral";
 			phy_type = "ulpi";
 		};
 

--
Bye, Peter Korsgaard
