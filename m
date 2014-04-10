Return-Path: <hongbo.zhang@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 817F9140150
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 17:11:01 +1000 (EST)
From: <hongbo.zhang@freescale.com>
To: <vkoul@infradead.org>, <dan.j.williams@intel.com>,
 <dmaengine@vger.kernel.org>
Subject: [PATCH v3 5/8] DMA: Freescale: move functions to avoid forward
 declarations
Date: Thu, 10 Apr 2014 15:10:02 +0800
Message-ID: <1397113805-24171-6-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1397113805-24171-1-git-send-email-hongbo.zhang@freescale.com>
References: <1397113805-24171-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Hongbo Zhang <hongbo.zhang@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 leo.li@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongbo Zhang <hongbo.zhang@freescale.com>

These functions will be modified in the next patch in the series. By moving the
function in a patch separate from the changes, it will make review easier.

Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
---
 drivers/dma/fsldma.c |  188 +++++++++++++++++++++++++-------------------------
 1 file changed, 94 insertions(+), 94 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index b5a0ffa..968877f 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -459,6 +459,100 @@ static struct fsl_desc_sw *fsl_dma_alloc_descriptor(struct fsldma_chan *chan)
 }
 
 /**
+ * fsl_chan_xfer_ld_queue - transfer any pending transactions
+ * @chan : Freescale DMA channel
+ *
+ * HARDWARE STATE: idle
+ * LOCKING: must hold chan->desc_lock
+ */
+static void fsl_chan_xfer_ld_queue(struct fsldma_chan *chan)
+{
+	struct fsl_desc_sw *desc;
+
+	/*
+	 * If the list of pending descriptors is empty, then we
+	 * don't need to do any work at all
+	 */
+	if (list_empty(&chan->ld_pending)) {
+		chan_dbg(chan, "no pending LDs\n");
+		return;
+	}
+
+	/*
+	 * The DMA controller is not idle, which means that the interrupt
+	 * handler will start any queued transactions when it runs after
+	 * this transaction finishes
+	 */
+	if (!chan->idle) {
+		chan_dbg(chan, "DMA controller still busy\n");
+		return;
+	}
+
+	/*
+	 * If there are some link descriptors which have not been
+	 * transferred, we need to start the controller
+	 */
+
+	/*
+	 * Move all elements from the queue of pending transactions
+	 * onto the list of running transactions
+	 */
+	chan_dbg(chan, "idle, starting controller\n");
+	desc = list_first_entry(&chan->ld_pending, struct fsl_desc_sw, node);
+	list_splice_tail_init(&chan->ld_pending, &chan->ld_running);
+
+	/*
+	 * The 85xx DMA controller doesn't clear the channel start bit
+	 * automatically at the end of a transfer. Therefore we must clear
+	 * it in software before starting the transfer.
+	 */
+	if ((chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_85XX) {
+		u32 mode;
+
+		mode = get_mr(chan);
+		mode &= ~FSL_DMA_MR_CS;
+		set_mr(chan, mode);
+	}
+
+	/*
+	 * Program the descriptor's address into the DMA controller,
+	 * then start the DMA transaction
+	 */
+	set_cdar(chan, desc->async_tx.phys);
+	get_cdar(chan);
+
+	dma_start(chan);
+	chan->idle = false;
+}
+
+/**
+ * fsldma_cleanup_descriptor - cleanup and free a single link descriptor
+ * @chan: Freescale DMA channel
+ * @desc: descriptor to cleanup and free
+ *
+ * This function is used on a descriptor which has been executed by the DMA
+ * controller. It will run any callbacks, submit any dependencies, and then
+ * free the descriptor.
+ */
+static void fsldma_cleanup_descriptor(struct fsldma_chan *chan,
+				      struct fsl_desc_sw *desc)
+{
+	struct dma_async_tx_descriptor *txd = &desc->async_tx;
+
+	/* Run the link descriptor callback function */
+	if (txd->callback) {
+		chan_dbg(chan, "LD %p callback\n", desc);
+		txd->callback(txd->callback_param);
+	}
+
+	/* Run any dependencies */
+	dma_run_dependencies(txd);
+
+	dma_descriptor_unmap(txd);
+	fsl_dma_free_descriptor(chan, desc);
+}
+
+/**
  * fsl_dma_alloc_chan_resources - Allocate resources for DMA channel.
  * @chan : Freescale DMA channel
  *
@@ -803,100 +897,6 @@ static int fsl_dma_device_control(struct dma_chan *dchan,
 }
 
 /**
- * fsldma_cleanup_descriptor - cleanup and free a single link descriptor
- * @chan: Freescale DMA channel
- * @desc: descriptor to cleanup and free
- *
- * This function is used on a descriptor which has been executed by the DMA
- * controller. It will run any callbacks, submit any dependencies, and then
- * free the descriptor.
- */
-static void fsldma_cleanup_descriptor(struct fsldma_chan *chan,
-				      struct fsl_desc_sw *desc)
-{
-	struct dma_async_tx_descriptor *txd = &desc->async_tx;
-
-	/* Run the link descriptor callback function */
-	if (txd->callback) {
-		chan_dbg(chan, "LD %p callback\n", desc);
-		txd->callback(txd->callback_param);
-	}
-
-	/* Run any dependencies */
-	dma_run_dependencies(txd);
-
-	dma_descriptor_unmap(txd);
-	fsl_dma_free_descriptor(chan, desc);
-}
-
-/**
- * fsl_chan_xfer_ld_queue - transfer any pending transactions
- * @chan : Freescale DMA channel
- *
- * HARDWARE STATE: idle
- * LOCKING: must hold chan->desc_lock
- */
-static void fsl_chan_xfer_ld_queue(struct fsldma_chan *chan)
-{
-	struct fsl_desc_sw *desc;
-
-	/*
-	 * If the list of pending descriptors is empty, then we
-	 * don't need to do any work at all
-	 */
-	if (list_empty(&chan->ld_pending)) {
-		chan_dbg(chan, "no pending LDs\n");
-		return;
-	}
-
-	/*
-	 * The DMA controller is not idle, which means that the interrupt
-	 * handler will start any queued transactions when it runs after
-	 * this transaction finishes
-	 */
-	if (!chan->idle) {
-		chan_dbg(chan, "DMA controller still busy\n");
-		return;
-	}
-
-	/*
-	 * If there are some link descriptors which have not been
-	 * transferred, we need to start the controller
-	 */
-
-	/*
-	 * Move all elements from the queue of pending transactions
-	 * onto the list of running transactions
-	 */
-	chan_dbg(chan, "idle, starting controller\n");
-	desc = list_first_entry(&chan->ld_pending, struct fsl_desc_sw, node);
-	list_splice_tail_init(&chan->ld_pending, &chan->ld_running);
-
-	/*
-	 * The 85xx DMA controller doesn't clear the channel start bit
-	 * automatically at the end of a transfer. Therefore we must clear
-	 * it in software before starting the transfer.
-	 */
-	if ((chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_85XX) {
-		u32 mode;
-
-		mode = get_mr(chan);
-		mode &= ~FSL_DMA_MR_CS;
-		set_mr(chan, mode);
-	}
-
-	/*
-	 * Program the descriptor's address into the DMA controller,
-	 * then start the DMA transaction
-	 */
-	set_cdar(chan, desc->async_tx.phys);
-	get_cdar(chan);
-
-	dma_start(chan);
-	chan->idle = false;
-}
-
-/**
  * fsl_dma_memcpy_issue_pending - Issue the DMA start command
  * @chan : Freescale DMA channel
  */
-- 
1.7.9.5
