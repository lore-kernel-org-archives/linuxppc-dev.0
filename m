Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6012BDDF18
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 03:52:41 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: document the "fsl,
	ssi-dma-channel" compatible property
Date: Fri, 10 Oct 2008 11:52:31 -0500
Message-Id: <1223657552-15008-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The "fsl,ssi-dma-channel" compatible property is used to specify a DMA channel
on the Freescale Elo DMA controller that should be used exclusively by the
Freescale SSI audio controller.  When a property is marked as such, the Elo
DMA driver will ignore it, and so it will be available for the sound drivers.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 Documentation/powerpc/dts-bindings/fsl/dma.txt |   13 +++++++++++--
 Documentation/powerpc/dts-bindings/fsl/ssi.txt |   20 ++++++++++++++------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/dma.txt b/Documentation/powerpc/dts-bindings/fsl/dma.txt
index 86826df..cc45311 100644
--- a/Documentation/powerpc/dts-bindings/fsl/dma.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/dma.txt
@@ -20,7 +20,7 @@ Required properties:
         - compatible        : compatible list, contains 2 entries, first is
 			 "fsl,CHIP-dma-channel", where CHIP is the processor
 			 (mpc8349, mpc8350, etc.) and the second is
-			 "fsl,elo-dma-channel"
+			 "fsl,elo-dma-channel". However, see note below.
         - reg               : <registers mapping for channel>
         - cell-index        : dma channel index starts at 0.
 
@@ -82,7 +82,7 @@ Required properties:
         - compatible        : compatible list, contains 2 entries, first is
 			 "fsl,CHIP-dma-channel", where CHIP is the processor
 			 (mpc8540, mpc8560, etc.) and the second is
-			 "fsl,eloplus-dma-channel"
+			 "fsl,eloplus-dma-channel". However, see note below.
         - cell-index        : dma channel index starts at 0.
         - reg               : <registers mapping for channel>
         - interrupts        : <interrupt mapping for DMA channel IRQ>
@@ -125,3 +125,12 @@ Example:
 			interrupts = <17 2>;
 		};
 	};
+
+Note on DMA channel compatible properties: The compatible property must say
+"fsl,elo-dma-channel" or "fsl,eloplus-dma-channel" to be used by the Elo DMA
+driver (fsldma).  Any DMA channel used by fsldma cannot be used by another
+DMA driver, such as the SSI sound drivers for the MPC8610.  Therefore, any DMA
+channel that should be used for another driver should not use
+"fsl,elo-dma-channel" or "fsl,eloplus-dma-channel".  For the SSI drivers, for
+example, the compatible property should be "fsl,ssi-dma-channel".  See ssi.txt
+for more information.
diff --git a/Documentation/powerpc/dts-bindings/fsl/ssi.txt b/Documentation/powerpc/dts-bindings/fsl/ssi.txt
index 5d98413..a2d9639 100644
--- a/Documentation/powerpc/dts-bindings/fsl/ssi.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/ssi.txt
@@ -24,12 +24,12 @@ Required properties:
 		    "rj-master" - r.j., SSI is clock master
 		    "ac97-slave" - AC97 mode, SSI is clock slave
 		    "ac97-master" - AC97 mode, SSI is clock master
-- fsl,playback-dma: phandle to a DMA node for the DMA channel to use for
-		    playback of audio.  This is typically dictated by SOC
-		    design.  See the notes below.
-- fsl,capture-dma:  phandle to a DMA node for the DMA channel to use for
-		    capture (recording) of audio.  This is typically dictated
-		    by SOC design.  See the notes below.
+- fsl,playback-dma: phandle to a node for the DMA channel to use for
+                    playback of audio.  This is typically dictated by SOC
+                    design.  See the notes below.
+- fsl,capture-dma:  phandle to a node for the DMA channel to use for
+                    capture (recording) of audio.  This is typically dictated
+                    by SOC design.  See the notes below.
 
 Optional properties:
 - codec-handle	  : phandle to a 'codec' node that defines an audio
@@ -51,3 +51,11 @@ playback and DMA channel 1 for capture.  SSI2 must use DMA channel 2 for
 playback and DMA channel 3 for capture.  The developer can choose which
 DMA controller to use, but the channels themselves are hard-wired.  The
 purpose of these two properties is to represent this hardware design.
+
+The device tree nodes for the DMA channels that are referenced by
+"fsl,playback-dma" and "fsl,capture-dma" must be marked as compatible with
+"fsl,ssi-dma-channel".  The SOC-specific compatible string (e.g.
+"fsl,mpc8610-dma-channel") can remain.  If these nodes are left as
+"fsl,elo-dma-channel" or "fsl,eloplus-dma-channel", then the generic Elo DMA
+drivers (fsldma) will attempt to use them, and it will conflict with the
+sound drivers.
-- 
1.5.5
