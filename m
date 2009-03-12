Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B223DDEF7
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 11:22:33 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH v3] powerpc: clean up ssi.txt, add definition for fsl,
	ssi-asynchronous
Date: Wed, 11 Mar 2009 19:22:04 -0500
Message-Id: <1236817324-24612-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the definition of the fsl,ssi-asynchronous property to ssi.txt (documentation
of the device tree bindings for the Freescale SSI device).

Also tidy up the layout of ssi.txt.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

v3: rebased

v2: fixed typo, improved wording.

 Documentation/powerpc/dts-bindings/fsl/ssi.txt |   68 ++++++++++++++----------
 1 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/ssi.txt b/Documentation/powerpc/dts-bindings/fsl/ssi.txt
index 7313322..5ff76c9 100644
--- a/Documentation/powerpc/dts-bindings/fsl/ssi.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/ssi.txt
@@ -4,46 +4,56 @@ The SSI is a serial device that communicates with audio codecs.  It can
 be programmed in AC97, I2S, left-justified, or right-justified modes.
 
 Required properties:
-- compatible	  : compatible list, containing "fsl,ssi"
-- cell-index	  : the SSI, <0> = SSI1, <1> = SSI2, and so on
-- reg		  : offset and length of the register set for the device
-- interrupts	  : <a b> where a is the interrupt number and b is a
-                     field that represents an encoding of the sense and
-		    level information for the interrupt.  This should be
-		    encoded based on the information in section 2)
-		    depending on the type of interrupt controller you
-		    have.
-- interrupt-parent : the phandle for the interrupt controller that
-                     services interrupts for this device.
-- fsl,mode	  : the operating mode for the SSI interface
-		    "i2s-slave" - I2S mode, SSI is clock slave
-		    "i2s-master" - I2S mode, SSI is clock master
-		    "lj-slave" - left-justified mode, SSI is clock slave
-		    "lj-master" - l.j. mode, SSI is clock master
-		    "rj-slave" - right-justified mode, SSI is clock slave
-		    "rj-master" - r.j., SSI is clock master
-		    "ac97-slave" - AC97 mode, SSI is clock slave
-		    "ac97-master" - AC97 mode, SSI is clock master
-- fsl,playback-dma: phandle to a node for the DMA channel to use for
+- compatible:       Compatible list, contains "fsl,ssi".
+- cell-index:       The SSI, <0> = SSI1, <1> = SSI2, and so on.
+- reg:              Offset and length of the register set for the device.
+- interrupts:       <a b> where a is the interrupt number and b is a
+                    field that represents an encoding of the sense and
+                    level information for the interrupt.  This should be
+                    encoded based on the information in section 2)
+                    depending on the type of interrupt controller you
+                    have.
+- interrupt-parent: The phandle for the interrupt controller that
+                    services interrupts for this device.
+- fsl,mode:         The operating mode for the SSI interface.
+                    "i2s-slave" - I2S mode, SSI is clock slave
+                    "i2s-master" - I2S mode, SSI is clock master
+                    "lj-slave" - left-justified mode, SSI is clock slave
+                    "lj-master" - l.j. mode, SSI is clock master
+                    "rj-slave" - right-justified mode, SSI is clock slave
+                    "rj-master" - r.j., SSI is clock master
+                    "ac97-slave" - AC97 mode, SSI is clock slave
+                    "ac97-master" - AC97 mode, SSI is clock master
+- fsl,playback-dma: Phandle to a node for the DMA channel to use for
                     playback of audio.  This is typically dictated by SOC
                     design.  See the notes below.
-- fsl,capture-dma:  phandle to a node for the DMA channel to use for
+- fsl,capture-dma:  Phandle to a node for the DMA channel to use for
                     capture (recording) of audio.  This is typically dictated
                     by SOC design.  See the notes below.
-- fsl,fifo-depth:   the number of elements in the transmit and receive FIFOs.
+- fsl,fifo-depth:   The number of elements in the transmit and receive FIFOs.
                     This number is the maximum allowed value for SFCSR[TFWM0].
+- fsl,ssi-asynchronous:
+                    If specified, the SSI is to be programmed in asynchronous
+                    mode.  In this mode, pins SRCK, STCK, SRFS, and STFS must
+                    all be connected to valid signals.  In synchronous mode,
+                    SRCK and SRFS are ignored.  Asynchronous mode allows
+                    playback and capture to use different sample sizes and
+                    sample rates.  Some drivers may require that SRCK and STCK
+                    be connected together, and SRFS and STFS be connected
+                    together.  This would still allow different sample sizes,
+                    but not different sample rates.
 
 Optional properties:
-- codec-handle	  : phandle to a 'codec' node that defines an audio
-		    codec connected to this SSI.  This node is typically
-		    a child of an I2C or other control node.
+- codec-handle:     Phandle to a 'codec' node that defines an audio
+                    codec connected to this SSI.  This node is typically
+                    a child of an I2C or other control node.
 
 Child 'codec' node required properties:
-- compatible	  : compatible list, contains the name of the codec
+- compatible:       Compatible list, contains the name of the codec
 
 Child 'codec' node optional properties:
-- clock-frequency  : The frequency of the input clock, which typically
-                     comes from an on-board dedicated oscillator.
+- clock-frequency:  The frequency of the input clock, which typically comes
+                    from an on-board dedicated oscillator.
 
 Notes on fsl,playback-dma and fsl,capture-dma:
 
-- 
1.6.1.3
