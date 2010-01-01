Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id E306BB6EF5
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jan 2010 17:10:48 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: dan.j.williams@intel.com
Subject: [PATCH 6/8] fsldma: simplify IRQ probing and handling
Date: Thu, 31 Dec 2009 22:10:44 -0800
Message-Id: <1262326246-936-7-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1262326246-936-1-git-send-email-iws@ovro.caltech.edu>
References: <1262326246-936-1-git-send-email-iws@ovro.caltech.edu>
Cc: herbert@gondor.apana.org.au, B04825@freescale.com, linuxppc-dev@ozlabs.org,
	Vishnu@freescale.com, Dipen.Dudhat@freescale.com,
	Maneesh.Gupta@freescale.com, R58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The IRQ probing is needlessly complex. All off the 83xx device trees in
arch/powerpc/boot/dts/ specify 5 interrupts per DMA controller: one for the
controller, and one for each channel. These interrupts are all attached to
the same IRQ line.

This causes an interesting situation if two channels interrupt at the same
time. The controller's handler will handle the first channel, and the
channel handler will handle the remaining channels. Instead of this, just
let the channel handler handle all channels, and ignore the controller
handler completely.

The same can be accomplished on 83xx by removing the controller's interrupt
property from the device tree. Testing has not shown any problems with this
configuration. All in-tree device trees already have an interrupt property
specified for each channel.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 Documentation/powerpc/dts-bindings/fsl/dma.txt |   17 +++++---
 drivers/dma/fsldma.c                           |   49 +++++++-----------------
 2 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/dma.txt b/Documentation/powerpc/dts-bindings/fsl/dma.txt
index 0732cdd..d5d2d3d 100644
--- a/Documentation/powerpc/dts-bindings/fsl/dma.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/dma.txt
@@ -12,6 +12,9 @@ Required properties:
 - ranges		: Should be defined as specified in 1) to describe the
 		  DMA controller channels.
 - cell-index        : controller index.  0 for controller @ 0x8100
+
+Optional properties:
+
 - interrupts        : <interrupt mapping for DMA IRQ>
 - interrupt-parent  : optional, if needed for interrupt mapping
 
@@ -23,11 +26,7 @@ Required properties:
 			 "fsl,elo-dma-channel". However, see note below.
         - reg               : <registers mapping for channel>
         - cell-index        : dma channel index starts at 0.
-
-Optional properties:
         - interrupts        : <interrupt mapping for DMA channel IRQ>
-			  (on 83xx this is expected to be identical to
-			   the interrupts property of the parent node)
         - interrupt-parent  : optional, if needed for interrupt mapping
 
 Example:
@@ -37,28 +36,34 @@ Example:
 		compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
 		reg = <0x82a8 4>;
 		ranges = <0 0x8100 0x1a4>;
-		interrupt-parent = <&ipic>;
-		interrupts = <71 8>;
 		cell-index = <0>;
 		dma-channel@0 {
 			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 			cell-index = <0>;
 			reg = <0 0x80>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
 		};
 		dma-channel@80 {
 			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 			cell-index = <1>;
 			reg = <0x80 0x80>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
 		};
 		dma-channel@100 {
 			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 			cell-index = <2>;
 			reg = <0x100 0x80>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
 		};
 		dma-channel@180 {
 			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 			cell-index = <3>;
 			reg = <0x180 0x80>;
+			interrupt-parent = <&ipic>;
+			interrupts = <71 8>;
 		};
 	};
 
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 507b297..d8cc05b 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1048,20 +1048,6 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t fsldma_irq(int irq, void *data)
-{
-	struct fsldma_device *fdev = data;
-	int ch_nr;
-	u32 gsr;
-
-	gsr = (fdev->feature & FSL_DMA_BIG_ENDIAN) ? in_be32(fdev->regs)
-			: in_le32(fdev->regs);
-	ch_nr = (32 - ffs(gsr)) / 8;
-
-	return fdev->chan[ch_nr] ? fsldma_chan_irq(irq,
-			fdev->chan[ch_nr]) : IRQ_NONE;
-}
-
 static void dma_do_tasklet(unsigned long data)
 {
 	struct fsldma_chan *fsl_chan = (struct fsldma_chan *)data;
@@ -1143,19 +1129,24 @@ static int __devinit fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 	fchan->common.device = &fdev->common;
 
+	/* find the IRQ line */
+	fchan->irq = irq_of_parse_and_map(node, 0);
+	if (fchan->irq == NO_IRQ) {
+		dev_err(fdev->dev, "unable to find IRQ line\n");
+		err = -EINVAL;
+		goto out_iounmap_regs;
+	}
+
 	/* Add the channel to DMA device channel list */
 	list_add_tail(&fchan->common.device_node, &fdev->common.channels);
 	fdev->common.chancnt++;
 
-	fchan->irq = irq_of_parse_and_map(node, 0);
-	if (fchan->irq != NO_IRQ) {
-		err = request_irq(fchan->irq, &fsldma_chan_irq,
-				  IRQF_SHARED, "fsldma-channel", fchan);
-		if (err) {
-			dev_err(fdev->dev, "unable to request IRQ "
-					   "for channel %d\n", fchan->id);
-			goto out_list_del;
-		}
+	err = request_irq(fchan->irq, fsldma_chan_irq, IRQF_SHARED,
+			  "fsldma-channel", fchan);
+	if (err) {
+		dev_err(fdev->dev, "unable to request IRQ for channel %d\n",
+			fchan->id);
+		goto out_list_del;
 	}
 
 	dev_info(fdev->dev, "#%d (%s), irq %d\n", fchan->id, compatible,
@@ -1224,16 +1215,6 @@ static int __devinit fsldma_of_probe(struct of_device *op,
 	fdev->common.device_terminate_all = fsl_dma_device_terminate_all;
 	fdev->common.dev = &op->dev;
 
-	fdev->irq = irq_of_parse_and_map(op->node, 0);
-	if (fdev->irq != NO_IRQ) {
-		err = request_irq(fdev->irq, &fsldma_irq, IRQF_SHARED,
-				  "fsldma-device", fdev);
-		if (err) {
-			dev_err(&op->dev, "unable to request IRQ\n");
-			goto out_iounmap_regs;
-		}
-	}
-
 	dev_set_drvdata(&op->dev, fdev);
 
 	/*
@@ -1258,8 +1239,6 @@ static int __devinit fsldma_of_probe(struct of_device *op,
 	dma_async_device_register(&fdev->common);
 	return 0;
 
-out_iounmap_regs:
-	iounmap(fdev->regs);
 out_free_fdev:
 	kfree(fdev);
 out_return:
-- 
1.5.4.3
