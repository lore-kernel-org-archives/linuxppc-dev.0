Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7032FDE05F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 02:48:39 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: add SSI-to-DMA properties to Freescale MPC8610 HPCD
	device tree
Date: Wed,  6 Aug 2008 11:48:25 -0500
Message-Id: <1218041305-5298-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the fsl,playback-dma and fsl,capture-dma properties to the Freescale
MPC8610 HPCD device tree.  These properties connect the SSI nodes to the
DMA nodes for the DMA channels that the SSI should use.  Also update the
ssi.txt documentation.

These properties will be needed when the ASoC V2 version of the Freescale
MPC8610 device drivers are merged into the mainline.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 Documentation/powerpc/dts-bindings/fsl/ssi.txt |   15 +++++++++++++++
 arch/powerpc/boot/dts/mpc8610_hpcd.dts         |    8 +++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/ssi.txt b/Documentation/powerpc/dts-bindings/fsl/ssi.txt
index d100555..5d98413 100644
--- a/Documentation/powerpc/dts-bindings/fsl/ssi.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/ssi.txt
@@ -24,6 +24,12 @@ Required properties:
 		    "rj-master" - r.j., SSI is clock master
 		    "ac97-slave" - AC97 mode, SSI is clock slave
 		    "ac97-master" - AC97 mode, SSI is clock master
+- fsl,playback-dma: phandle to a DMA node for the DMA channel to use for
+		    playback of audio.  This is typically dictated by SOC
+		    design.  See the notes below.
+- fsl,capture-dma:  phandle to a DMA node for the DMA channel to use for
+		    capture (recording) of audio.  This is typically dictated
+		    by SOC design.  See the notes below.
 
 Optional properties:
 - codec-handle	  : phandle to a 'codec' node that defines an audio
@@ -36,3 +42,12 @@ Child 'codec' node required properties:
 Child 'codec' node optional properties:
 - clock-frequency  : The frequency of the input clock, which typically
                      comes from an on-board dedicated oscillator.
+
+Notes on fsl,playback-dma and fsl,capture-dma:
+
+On SOCs that have an SSI, specific DMA channels are hard-wired for playback
+and capture.  On the MPC8610, for example, SSI1 must use DMA channel 0 for
+playback and DMA channel 1 for capture.  SSI2 must use DMA channel 2 for
+playback and DMA channel 3 for capture.  The developer can choose which
+DMA controller to use, but the channels themselves are hard-wired.  The
+purpose of these two properties is to represent this hardware design.
diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 666185f..2a2b84f 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -202,7 +202,7 @@
 			fsl,has-rstcr;
 		};
 
-		i2s@16000 {
+		ssi@16000 {
 			compatible = "fsl,mpc8610-ssi";
 			cell-index = <0>;
 			reg = <0x16000 0x100>;
@@ -210,6 +210,8 @@
 			interrupts = <62 2>;
 			fsl,mode = "i2s-slave";
 			codec-handle = <&cs4270>;
+			fsl,playback-dma = <&dma00>;
+			fsl,capture-dma = <&dma01>;
 		};
 
 		ssi@16100 {
@@ -228,7 +230,7 @@
 			reg = <0x21300 0x4>; /* DMA general status register */
 			ranges = <0x0 0x21100 0x200>;
 
-			dma-channel@0 {
+			dma00: dma-channel@0 {
 				compatible = "fsl,mpc8610-dma-channel",
 					"fsl,eloplus-dma-channel";
 				cell-index = <0>;
@@ -236,7 +238,7 @@
 				interrupt-parent = <&mpic>;
 				interrupts = <20 2>;
 			};
-			dma-channel@1 {
+			dma01: dma-channel@1 {
 				compatible = "fsl,mpc8610-dma-channel",
 					"fsl,eloplus-dma-channel";
 				cell-index = <1>;
-- 
1.5.5
