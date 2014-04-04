Return-Path: <hongbo.zhang@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6EC3F140177
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 14:28:21 +1100 (EST)
From: <hongbo.zhang@freescale.com>
To: <vkoul@infradead.org>, <dan.j.williams@intel.com>,
 <dmaengine@vger.kernel.org>
Subject: [PATCH v2 7/8] DMA: Freescale: use spin_lock_bh instead of
 spin_lock_irqsave
Date: Fri, 4 Apr 2014 11:27:16 +0800
Message-ID: <1396582037-23065-8-git-send-email-hongbo.zhang@freescale.com>
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

The usage of spin_lock_irqsave() is a stronger locking mechanism than is
required throughout the driver. The minimum locking required should be used
instead. Interrupts will be turned off and context will be saved, it is
unnecessary to use irqsave.

This patch changes all instances of spin_lock_irqsave() to spin_lock_bh(). All
manipulation of protected fields is done using tasklet context or weaker, which
makes spin_lock_bh() the correct choice.

Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
---
 drivers/dma/fsldma.c |   25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index f8eee60..c9bf54a 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -396,10 +396,9 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	struct fsldma_chan *chan = to_fsl_chan(tx->chan);
 	struct fsl_desc_sw *desc = tx_to_fsl_desc(tx);
 	struct fsl_desc_sw *child;
-	unsigned long flags;
 	dma_cookie_t cookie = -EINVAL;
 
-	spin_lock_irqsave(&chan->desc_lock, flags);
+	spin_lock_bh(&chan->desc_lock);
 
 	/*
 	 * assign cookies to all of the software descriptors
@@ -412,7 +411,7 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	/* put this transaction onto the tail of the pending queue */
 	append_ld_queue(chan, desc);
 
-	spin_unlock_irqrestore(&chan->desc_lock, flags);
+	spin_unlock_bh(&chan->desc_lock);
 
 	return cookie;
 }
@@ -725,15 +724,14 @@ static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
 static void fsl_dma_free_chan_resources(struct dma_chan *dchan)
 {
 	struct fsldma_chan *chan = to_fsl_chan(dchan);
-	unsigned long flags;
 
 	chan_dbg(chan, "free all channel resources\n");
-	spin_lock_irqsave(&chan->desc_lock, flags);
+	spin_lock_bh(&chan->desc_lock);
 	fsldma_cleanup_descriptors(chan);
 	fsldma_free_desc_list(chan, &chan->ld_pending);
 	fsldma_free_desc_list(chan, &chan->ld_running);
 	fsldma_free_desc_list(chan, &chan->ld_completed);
-	spin_unlock_irqrestore(&chan->desc_lock, flags);
+	spin_unlock_bh(&chan->desc_lock);
 
 	dma_pool_destroy(chan->desc_pool);
 	chan->desc_pool = NULL;
@@ -952,7 +950,6 @@ static int fsl_dma_device_control(struct dma_chan *dchan,
 {
 	struct dma_slave_config *config;
 	struct fsldma_chan *chan;
-	unsigned long flags;
 	int size;
 
 	if (!dchan)
@@ -962,7 +959,7 @@ static int fsl_dma_device_control(struct dma_chan *dchan,
 
 	switch (cmd) {
 	case DMA_TERMINATE_ALL:
-		spin_lock_irqsave(&chan->desc_lock, flags);
+		spin_lock_bh(&chan->desc_lock);
 
 		/* Halt the DMA engine */
 		dma_halt(chan);
@@ -973,7 +970,7 @@ static int fsl_dma_device_control(struct dma_chan *dchan,
 		fsldma_free_desc_list(chan, &chan->ld_completed);
 		chan->idle = true;
 
-		spin_unlock_irqrestore(&chan->desc_lock, flags);
+		spin_unlock_bh(&chan->desc_lock);
 		return 0;
 
 	case DMA_SLAVE_CONFIG:
@@ -1015,11 +1012,10 @@ static int fsl_dma_device_control(struct dma_chan *dchan,
 static void fsl_dma_memcpy_issue_pending(struct dma_chan *dchan)
 {
 	struct fsldma_chan *chan = to_fsl_chan(dchan);
-	unsigned long flags;
 
-	spin_lock_irqsave(&chan->desc_lock, flags);
+	spin_lock_bh(&chan->desc_lock);
 	fsl_chan_xfer_ld_queue(chan);
-	spin_unlock_irqrestore(&chan->desc_lock, flags);
+	spin_unlock_bh(&chan->desc_lock);
 }
 
 /**
@@ -1118,11 +1114,10 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 static void dma_do_tasklet(unsigned long data)
 {
 	struct fsldma_chan *chan = (struct fsldma_chan *)data;
-	unsigned long flags;
 
 	chan_dbg(chan, "tasklet entry\n");
 
-	spin_lock_irqsave(&chan->desc_lock, flags);
+	spin_lock_bh(&chan->desc_lock);
 
 	/* the hardware is now idle and ready for more */
 	chan->idle = true;
@@ -1130,7 +1125,7 @@ static void dma_do_tasklet(unsigned long data)
 	/* Run all cleanup for descriptors which have been completed */
 	fsldma_cleanup_descriptors(chan);
 
-	spin_unlock_irqrestore(&chan->desc_lock, flags);
+	spin_unlock_bh(&chan->desc_lock);
 
 	chan_dbg(chan, "tasklet exit\n");
 }
-- 
1.7.9.5
