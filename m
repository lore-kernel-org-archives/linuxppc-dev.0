Return-Path: <hongbo.zhang@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F185B14012E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 14:28:28 +1100 (EST)
From: <hongbo.zhang@freescale.com>
To: <vkoul@infradead.org>, <dan.j.williams@intel.com>,
 <dmaengine@vger.kernel.org>
Subject: [PATCH v2 8/8] DMA: Freescale: add suspend resume functions for DMA
 driver
Date: Fri, 4 Apr 2014 11:27:17 +0800
Message-ID: <1396582037-23065-9-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1396582037-23065-1-git-send-email-hongbo.zhang@freescale.com>
References: <1396582037-23065-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Hongbo Zhang <hongbo.zhang@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongbo Zhang <hongbo.zhang@freescale.com>

This patch adds suspend resume functions for Freescale DMA driver.
.prepare callback is used to stop further descriptors from being added into the
pending queue, and also issue pending queues into execution if there is any.
.suspend callback makes sure all the pending jobs are cleaned up and all the
channels are idle, and save the mode registers.
.resume callback re-initializes the channels by restore the mode registers.

Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
---
 drivers/dma/fsldma.c |   99 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/fsldma.h |   16 ++++++++
 2 files changed, 115 insertions(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index c9bf54a..91482d2 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -400,6 +400,14 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 
 	spin_lock_bh(&chan->desc_lock);
 
+#ifdef CONFIG_PM
+	if (unlikely(chan->pm_state != RUNNING)) {
+		chan_dbg(chan, "cannot submit due to suspend\n");
+		spin_unlock_bh(&chan->desc_lock);
+		return -1;
+	}
+#endif
+
 	/*
 	 * assign cookies to all of the software descriptors
 	 * that make up this transaction
@@ -1311,6 +1319,9 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	INIT_LIST_HEAD(&chan->ld_running);
 	INIT_LIST_HEAD(&chan->ld_completed);
 	chan->idle = true;
+#ifdef CONFIG_PM
+	chan->pm_state = RUNNING;
+#endif
 
 	chan->common.device = &fdev->common;
 	dma_cookie_init(&chan->common);
@@ -1450,6 +1461,91 @@ static int fsldma_of_remove(struct platform_device *op)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int fsldma_prepare(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct fsldma_device *fdev = platform_get_drvdata(pdev);
+	struct fsldma_chan *chan;
+	int i;
+
+	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
+		chan = fdev->chan[i];
+		if (!chan)
+			continue;
+
+		spin_lock_bh(&chan->desc_lock);
+		chan->pm_state = SUSPENDING;
+		if (!list_empty(&chan->ld_pending))
+			fsl_chan_xfer_ld_queue(chan);
+		spin_unlock_bh(&chan->desc_lock);
+	}
+
+	return 0;
+}
+
+static int fsldma_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct fsldma_device *fdev = platform_get_drvdata(pdev);
+	struct fsldma_chan *chan;
+	int i;
+
+	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
+		chan = fdev->chan[i];
+		if (!chan)
+			continue;
+
+		spin_lock_bh(&chan->desc_lock);
+		if (!chan->idle)
+			goto out;
+		chan->regs_save.mr = DMA_IN(chan, &chan->regs->mr, 32);
+		chan->pm_state = SUSPENDED;
+		spin_unlock_bh(&chan->desc_lock);
+	}
+	return 0;
+
+out:
+	for (; i >= 0; i--) {
+		chan = fdev->chan[i];
+		if (!chan)
+			continue;
+		spin_unlock_bh(&chan->desc_lock);
+	}
+	return -EBUSY;
+}
+
+static int fsldma_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct fsldma_device *fdev = platform_get_drvdata(pdev);
+	struct fsldma_chan *chan;
+	u32 mode;
+	int i;
+
+	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
+		chan = fdev->chan[i];
+		if (!chan)
+			continue;
+
+		spin_lock_bh(&chan->desc_lock);
+		mode = chan->regs_save.mr
+			& ~FSL_DMA_MR_CS & ~FSL_DMA_MR_CC & ~FSL_DMA_MR_CA;
+		DMA_OUT(chan, &chan->regs->mr, mode, 32);
+		chan->pm_state = RUNNING;
+		spin_unlock_bh(&chan->desc_lock);
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops fsldma_pm_ops = {
+	.prepare	= fsldma_prepare,
+	.suspend	= fsldma_suspend,
+	.resume		= fsldma_resume,
+};
+#endif
+
 static const struct of_device_id fsldma_of_ids[] = {
 	{ .compatible = "fsl,elo3-dma", },
 	{ .compatible = "fsl,eloplus-dma", },
@@ -1462,6 +1558,9 @@ static struct platform_driver fsldma_of_driver = {
 		.name = "fsl-elo-dma",
 		.owner = THIS_MODULE,
 		.of_match_table = fsldma_of_ids,
+#ifdef CONFIG_PM
+		.pm = &fsldma_pm_ops,
+#endif
 	},
 	.probe = fsldma_of_probe,
 	.remove = fsldma_of_remove,
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index ec19517..eecaf9e 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -134,6 +134,18 @@ struct fsldma_device {
 #define FSL_DMA_CHAN_PAUSE_EXT	0x00001000
 #define FSL_DMA_CHAN_START_EXT	0x00002000
 
+#ifdef CONFIG_PM
+struct fsldma_chan_regs_save {
+	u32 mr;
+};
+
+enum fsldma_pm_state {
+	RUNNING = 0,
+	SUSPENDING,
+	SUSPENDED,
+};
+#endif
+
 struct fsldma_chan {
 	char name[8];			/* Channel name */
 	struct fsldma_chan_regs __iomem *regs;
@@ -161,6 +173,10 @@ struct fsldma_chan {
 	struct tasklet_struct tasklet;
 	u32 feature;
 	bool idle;			/* DMA controller is idle */
+#ifdef CONFIG_PM
+	struct fsldma_chan_regs_save regs_save;
+	enum fsldma_pm_state pm_state;
+#endif
 
 	void (*toggle_ext_pause)(struct fsldma_chan *fsl_chan, int enable);
 	void (*toggle_ext_start)(struct fsldma_chan *fsl_chan, int enable);
-- 
1.7.9.5
