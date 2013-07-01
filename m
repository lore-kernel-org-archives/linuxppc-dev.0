Return-Path: <B45939@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B7A422C02B4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jul 2013 13:21:06 +1000 (EST)
From: <hongbo.zhang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] DMA: Freescale: update driver to support 8-channel DMA
 engine
Date: Mon, 1 Jul 2013 11:20:09 +0800
Message-ID: <1372648810-2807-2-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1372648810-2807-1-git-send-email-hongbo.zhang@freescale.com>
References: <1372648810-2807-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Hongbo Zhang <hongbo.zhang@freescale.com>,
 linux-kernel@vger.kernel.org, vakul@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongbo Zhang <hongbo.zhang@freescale.com>

This patch adds support to 8-channel DMA engine, thus the driver works for both
the new 8-channel and the legacy 4-channel DMA engines.

Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
---
 drivers/dma/fsldma.c |   48 ++++++++++++++++++++++++++++++++++--------------
 drivers/dma/fsldma.h |    4 ++--
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 4fc2980..0f453ea 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1119,27 +1119,33 @@ static irqreturn_t fsldma_ctrl_irq(int irq, void *data)
 	struct fsldma_device *fdev = data;
 	struct fsldma_chan *chan;
 	unsigned int handled = 0;
-	u32 gsr, mask;
+	u8 chan_sr[round_up(FSL_DMA_MAX_CHANS_PER_DEVICE, 4)];
+	u32 gsr;
 	int i;
 
-	gsr = (fdev->feature & FSL_DMA_BIG_ENDIAN) ? in_be32(fdev->regs)
-						   : in_le32(fdev->regs);
-	mask = 0xff000000;
-	dev_dbg(fdev->dev, "IRQ: gsr 0x%.8x\n", gsr);
+	memset(&chan_sr, 0, sizeof(chan_sr));
+	gsr = (fdev->feature & FSL_DMA_BIG_ENDIAN) ? in_be32(fdev->regs0)
+						   : in_le32(fdev->regs0);
+	memcpy(&chan_sr[0], &gsr, 4);
+	dev_dbg(fdev->dev, "IRQ: gsr0 0x%.8x\n", gsr);
+
+	if (of_device_is_compatible(fdev->dev->of_node, "fsl,eloplus-dma2")) {
+		gsr = (fdev->feature & FSL_DMA_BIG_ENDIAN) ?
+			in_be32(fdev->regs1) : in_le32(fdev->regs1);
+		memcpy(&chan_sr[4], &gsr, 4);
+		dev_dbg(fdev->dev, "IRQ: gsr1 0x%.8x\n", gsr);
+	}
 
 	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
 		chan = fdev->chan[i];
 		if (!chan)
 			continue;
 
-		if (gsr & mask) {
+		if (chan_sr[i]) {
 			dev_dbg(fdev->dev, "IRQ: chan %d\n", chan->id);
 			fsldma_chan_irq(irq, chan);
 			handled++;
 		}
-
-		gsr &= ~mask;
-		mask >>= 8;
 	}
 
 	return IRQ_RETVAL(handled);
@@ -1261,7 +1267,9 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	WARN_ON(fdev->feature != chan->feature);
 
 	chan->dev = fdev->dev;
-	chan->id = ((res.start - 0x100) & 0xfff) >> 7;
+	chan->id = (res.start & 0xfff) < 0x300 ?
+		   ((res.start - 0x100) & 0xfff) >> 7 :
+		   ((res.start - 0x200) & 0xfff) >> 7;
 	if (chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
 		dev_err(fdev->dev, "too many channels for device\n");
 		err = -EINVAL;
@@ -1341,13 +1349,22 @@ static int fsldma_of_probe(struct platform_device *op)
 	INIT_LIST_HEAD(&fdev->common.channels);
 
 	/* ioremap the registers for use */
-	fdev->regs = of_iomap(op->dev.of_node, 0);
-	if (!fdev->regs) {
-		dev_err(&op->dev, "unable to ioremap registers\n");
+	fdev->regs0 = of_iomap(op->dev.of_node, 0);
+	if (!fdev->regs0) {
+		dev_err(&op->dev, "unable to ioremap register0\n");
 		err = -ENOMEM;
 		goto out_free_fdev;
 	}
 
+	if (of_device_is_compatible(op->dev.of_node, "fsl,eloplus-dma2")) {
+		fdev->regs1 = of_iomap(op->dev.of_node, 1);
+		if (!fdev->regs1) {
+			dev_err(&op->dev, "unable to ioremap register1\n");
+			err = -ENOMEM;
+			goto out_free_fdev;
+		}
+	}
+
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
 	fdev->irq = irq_of_parse_and_map(op->dev.of_node, 0);
 
@@ -1427,7 +1444,9 @@ static int fsldma_of_remove(struct platform_device *op)
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
 
-	iounmap(fdev->regs);
+	iounmap(fdev->regs0);
+	if (of_device_is_compatible(op->dev.of_node, "fsl,eloplus-dma2"))
+		iounmap(fdev->regs1);
 	dev_set_drvdata(&op->dev, NULL);
 	kfree(fdev);
 
@@ -1436,6 +1455,7 @@ static int fsldma_of_remove(struct platform_device *op)
 
 static const struct of_device_id fsldma_of_ids[] = {
 	{ .compatible = "fsl,eloplus-dma", },
+	{ .compatible = "fsl,eloplus-dma2", },
 	{ .compatible = "fsl,elo-dma", },
 	{}
 };
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index f5c3879..880664d 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -112,10 +112,10 @@ struct fsldma_chan_regs {
 };
 
 struct fsldma_chan;
-#define FSL_DMA_MAX_CHANS_PER_DEVICE 4
+#define FSL_DMA_MAX_CHANS_PER_DEVICE 8
 
 struct fsldma_device {
-	void __iomem *regs;	/* DGSR register base */
+	void __iomem *regs0, *regs1;	/* DGSR registers */
 	struct device *dev;
 	struct dma_device common;
 	struct fsldma_chan *chan[FSL_DMA_MAX_CHANS_PER_DEVICE];
-- 
1.7.9.5
