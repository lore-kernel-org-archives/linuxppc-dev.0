Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B17D0DDFB6
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Mar 2009 07:55:42 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Subject: [PATCH] powerpc: add fsl,
	fifo-depth property to Freescale SSI device nodes
Date: Wed,  4 Mar 2009 14:55:30 -0600
Message-Id: <1236200130-12012-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Freescale Serial Synchronous Interface (SSI) is an audio device present on
some Freescale SOCs.  Various implementations of the SSI have a different
transmit and receive FIFO depth, but are otherwise identical.  To support
these variations, add a new property fsl,fifo-depth to the SSI node that
specifies the depth of the FIFOs.

Also update the MPC8610 HPCD device tree with this property.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Updates to the SSI audio driver will come later.  Currently, this driver
supports only one Freescale SOC, and so it's hard-coded to use the value 8.
If/when this driver is updated to support other SOCs (e.g. the i.MX parts
that have a FIFO depth of 15), the driver will check for this property.  I
just want to get this DTS change in now.

 Documentation/powerpc/dts-bindings/fsl/ssi.txt |    2 ++
 arch/powerpc/boot/dts/mpc8610_hpcd.dts         |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/ssi.txt b/Documentation/powerpc/dts-bindings/fsl/ssi.txt
index a2d9639..7313322 100644
--- a/Documentation/powerpc/dts-bindings/fsl/ssi.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/ssi.txt
@@ -30,6 +30,8 @@ Required properties:
 - fsl,capture-dma:  phandle to a node for the DMA channel to use for
                     capture (recording) of audio.  This is typically dictated
                     by SOC design.  See the notes below.
+- fsl,fifo-depth:   the number of elements in the transmit and receive FIFOs.
+                    This number is the maximum allowed value for SFCSR[TFWM0].
 
 Optional properties:
 - codec-handle	  : phandle to a 'codec' node that defines an audio
diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index f724d72..1bd3ebe 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -217,6 +217,7 @@
 			codec-handle = <&cs4270>;
 			fsl,playback-dma = <&dma00>;
 			fsl,capture-dma = <&dma01>;
+			fsl,fifo-depth = <8>;
 		};
 
 		ssi@16100 {
@@ -225,6 +226,7 @@
 			reg = <0x16100 0x100>;
 			interrupt-parent = <&mpic>;
 			interrupts = <63 2>;
+			fsl,fifo-depth = <8>;
 		};
 
 		dma@21300 {
-- 
1.6.1.3
