Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id AA78FB6EF2
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 10:34:09 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: dan.j.williams@intel.com
Subject: [PATCH 6/8] fsldma: simplify IRQ probing and handling
Date: Wed,  6 Jan 2010 15:34:04 -0800
Message-Id: <1262820846-13198-7-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1262820846-13198-1-git-send-email-iws@ovro.caltech.edu>
References: <1262820846-13198-1-git-send-email-iws@ovro.caltech.edu>
Cc: R58472@freescale.com, B04825@freescale.com, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, Dipen.Dudhat@freescale.com,
	Maneesh.Gupta@freescale.com, herbert@gondor.apana.org.au
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
time. The per-controller handler will handle the first channel, and the
per-channel handler will handle the remaining channels.

Instead of this mess, we fix the bug in the per-controller handler, and
make it handle all channels that generated an interrupt. When a
per-controller handler is specified in the device tree, we prefer to use
the shared handler instead of the per-channel handler.

The 85xx/86xx controllers do not have a per-controller interrupt, and
instead use a per-channel interrupt. This behavior has not been changed.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 Documentation/powerpc/dts-bindings/fsl/dma.txt |    8 +
 drivers/dma/fsldma.c                           |  173 ++++++++++++++++++------
 2 files changed, 137 insertions(+), 44 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/dma.txt b/Documentation/powerpc/dts-bindings/fsl/dma.txt
index 0732cdd..2a4b4bc 100644
--- a/Documentation/powerpc/dts-bindings/fsl/dma.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/dma.txt
@@ -44,21 +44,29 @@ Example:
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
index 507b297..6a90592 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -967,6 +967,10 @@ static enum dma_status fsl_dma_is_complete(struct dma_chan *chan,
 	return dma_async_is_complete(cookie, last_complete, last_used);
 }
 
+/*----------------------------------------------------------------------------*/
+/* Interrupt Handling                                                         */
+/*----------------------------------------------------------------------------*/
+
 static irqreturn_t fsldma_chan_irq(int irq, void *data)
 {
 	struct fsldma_chan *fsl_chan = data;
@@ -1048,24 +1052,116 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t fsldma_irq(int irq, void *data)
+static void dma_do_tasklet(unsigned long data)
+{
+	struct fsldma_chan *fsl_chan = (struct fsldma_chan *)data;
+	fsl_chan_ld_cleanup(fsl_chan);
+}
+
+static irqreturn_t fsldma_ctrl_irq(int irq, void *data)
 {
 	struct fsldma_device *fdev = data;
-	int ch_nr;
-	u32 gsr;
+	struct fsldma_chan *chan;
+	unsigned int handled = 0;
+	u32 gsr, mask;
+	int i;
 
 	gsr = (fdev->feature & FSL_DMA_BIG_ENDIAN) ? in_be32(fdev->regs)
-			: in_le32(fdev->regs);
-	ch_nr = (32 - ffs(gsr)) / 8;
+						   : in_le32(fdev->regs);
+	mask = 0xff000000;
+	dev_dbg(fdev->dev, "IRQ: gsr 0x%.8x\n", gsr);
 
-	return fdev->chan[ch_nr] ? fsldma_chan_irq(irq,
-			fdev->chan[ch_nr]) : IRQ_NONE;
+	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
+		chan = fdev->chan[i];
+		if (!chan)
+			continue;
+
+		if (gsr & mask) {
+			dev_dbg(fdev->dev, "IRQ: chan %d\n", chan->id);
+			fsldma_chan_irq(irq, chan);
+			handled++;
+		}
+
+		gsr &= ~mask;
+		mask >>= 8;
+	}
+
+	return IRQ_RETVAL(handled);
 }
 
-static void dma_do_tasklet(unsigned long data)
+static void fsldma_free_irqs(struct fsldma_device *fdev)
 {
-	struct fsldma_chan *fsl_chan = (struct fsldma_chan *)data;
-	fsl_chan_ld_cleanup(fsl_chan);
+	struct fsldma_chan *chan;
+	int i;
+
+	if (fdev->irq != NO_IRQ) {
+		dev_dbg(fdev->dev, "free per-controller IRQ\n");
+		free_irq(fdev->irq, fdev);
+		return;
+	}
+
+	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
+		chan = fdev->chan[i];
+		if (chan && chan->irq != NO_IRQ) {
+			dev_dbg(fdev->dev, "free channel %d IRQ\n", chan->id);
+			free_irq(chan->irq, chan);
+		}
+	}
+}
+
+static int fsldma_request_irqs(struct fsldma_device *fdev)
+{
+	struct fsldma_chan *chan;
+	int ret;
+	int i;
+
+	/* if we have a per-controller IRQ, use that */
+	if (fdev->irq != NO_IRQ) {
+		dev_dbg(fdev->dev, "request per-controller IRQ\n");
+		ret = request_irq(fdev->irq, fsldma_ctrl_irq, IRQF_SHARED,
+				  "fsldma-controller", fdev);
+		return ret;
+	}
+
+	/* no per-controller IRQ, use the per-channel IRQs */
+	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
+		chan = fdev->chan[i];
+		if (!chan)
+			continue;
+
+		if (chan->irq == NO_IRQ) {
+			dev_err(fdev->dev, "no interrupts property defined for "
+					   "DMA channel %d. Please fix your "
+					   "device tree\n", chan->id);
+			ret = -ENODEV;
+			goto out_unwind;
+		}
+
+		dev_dbg(fdev->dev, "request channel %d IRQ\n", chan->id);
+		ret = request_irq(chan->irq, fsldma_chan_irq, IRQF_SHARED,
+				  "fsldma-chan", chan);
+		if (ret) {
+			dev_err(fdev->dev, "unable to request IRQ for DMA "
+					   "channel %d\n", chan->id);
+			goto out_unwind;
+		}
+	}
+
+	return 0;
+
+out_unwind:
+	for (/* none */; i >= 0; i--) {
+		chan = fdev->chan[i];
+		if (!chan)
+			continue;
+
+		if (chan->irq == NO_IRQ)
+			continue;
+
+		free_irq(chan->irq, chan);
+	}
+
+	return ret;
 }
 
 /*----------------------------------------------------------------------------*/
@@ -1143,29 +1239,18 @@ static int __devinit fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 	fchan->common.device = &fdev->common;
 
+	/* find the IRQ line, if it exists in the device tree */
+	fchan->irq = irq_of_parse_and_map(node, 0);
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
-	}
-
 	dev_info(fdev->dev, "#%d (%s), irq %d\n", fchan->id, compatible,
 		 fchan->irq != NO_IRQ ? fchan->irq : fdev->irq);
 
 	return 0;
 
-out_list_del:
-	irq_dispose_mapping(fchan->irq);
-	list_del_init(&fchan->common.device_node);
 out_iounmap_regs:
 	iounmap(fchan->regs);
 out_free_fchan:
@@ -1176,11 +1261,7 @@ out_return:
 
 static void fsl_dma_chan_remove(struct fsldma_chan *fchan)
 {
-	if (fchan->irq != NO_IRQ) {
-		free_irq(fchan->irq, fchan);
-		irq_dispose_mapping(fchan->irq);
-	}
-
+	irq_dispose_mapping(fchan->irq);
 	list_del(&fchan->common.device_node);
 	iounmap(fchan->regs);
 	kfree(fchan);
@@ -1211,6 +1292,9 @@ static int __devinit fsldma_of_probe(struct of_device *op,
 		goto out_free_fdev;
 	}
 
+	/* map the channel IRQ if it exists, but don't hookup the handler yet */
+	fdev->irq = irq_of_parse_and_map(op->node, 0);
+
 	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
 	dma_cap_set(DMA_INTERRUPT, fdev->common.cap_mask);
 	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
@@ -1224,16 +1308,6 @@ static int __devinit fsldma_of_probe(struct of_device *op,
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
@@ -1255,12 +1329,24 @@ static int __devinit fsldma_of_probe(struct of_device *op,
 		}
 	}
 
+	/*
+	 * Hookup the IRQ handler(s)
+	 *
+	 * If we have a per-controller interrupt, we prefer that to the
+	 * per-channel interrupts to reduce the number of shared interrupt
+	 * handlers on the same IRQ line
+	 */
+	err = fsldma_request_irqs(fdev);
+	if (err) {
+		dev_err(fdev->dev, "unable to request IRQs\n");
+		goto out_free_fdev;
+	}
+
 	dma_async_device_register(&fdev->common);
 	return 0;
 
-out_iounmap_regs:
-	iounmap(fdev->regs);
 out_free_fdev:
+	irq_dispose_mapping(fdev->irq);
 	kfree(fdev);
 out_return:
 	return err;
@@ -1274,14 +1360,13 @@ static int fsldma_of_remove(struct of_device *op)
 	fdev = dev_get_drvdata(&op->dev);
 	dma_async_device_unregister(&fdev->common);
 
+	fsldma_free_irqs(fdev);
+
 	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
 
-	if (fdev->irq != NO_IRQ)
-		free_irq(fdev->irq, fdev);
-
 	iounmap(fdev->regs);
 	dev_set_drvdata(&op->dev, NULL);
 	kfree(fdev);
-- 
1.5.4.3
