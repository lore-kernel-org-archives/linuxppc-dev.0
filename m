Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BCADCDE00F
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 03:52:41 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: reserve two DMA channels for audio in MPC8610 HPCD
	device tree
Date: Fri, 10 Oct 2008 11:52:32 -0500
Message-Id: <1223657552-15008-2-git-send-email-timur@freescale.com>
In-Reply-To: <1223657552-15008-1-git-send-email-timur@freescale.com>
References: <1223657552-15008-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Freescale Elo DMA driver binds to all DMA channels in the device tree that
are compatible with "fsl,eloplus-dma-channel".  This conflicts with the sound
drivers for the MPC8610 HPCD.  On this board, the SSI uses two DMA channels and
therefore those channels are not available for general purpose use.  We
change the compatible properties for these channels "fsl,ssi-dma-channel".
This works because the sound drivers don't actually check the compatible
property when it grabs channels.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/dts/mpc8610_hpcd.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 0f3a36e..3f4c610 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -237,7 +237,7 @@
 
 			dma00: dma-channel@0 {
 				compatible = "fsl,mpc8610-dma-channel",
-					"fsl,eloplus-dma-channel";
+					"fsl,ssi-dma-channel";
 				cell-index = <0>;
 				reg = <0x0 0x80>;
 				interrupt-parent = <&mpic>;
@@ -245,7 +245,7 @@
 			};
 			dma01: dma-channel@1 {
 				compatible = "fsl,mpc8610-dma-channel",
-					"fsl,eloplus-dma-channel";
+					"fsl,ssi-dma-channel";
 				cell-index = <1>;
 				reg = <0x80 0x80>;
 				interrupt-parent = <&mpic>;
-- 
1.5.5
