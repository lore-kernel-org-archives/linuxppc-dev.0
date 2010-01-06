Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id D7EBCB6F1A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 10:34:09 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: dan.j.williams@intel.com
Subject: [PATCH 8/8] fsldma: major cleanups and fixes
Date: Wed,  6 Jan 2010 15:34:06 -0800
Message-Id: <1262820846-13198-9-git-send-email-iws@ovro.caltech.edu>
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

Fix locking. Use two queues in the driver, one for pending transacions, and
one for transactions which are actually running on the hardware. Call
dma_run_dependencies() on descriptor cleanup so that the async_tx API works
correctly.

There are a number of places throughout the code where lists of descriptors
are freed in a loop. Create functions to handle this, and use them instead
of open-coding the loop each time.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |  386 ++++++++++++++++++++++++++-----------------------
 drivers/dma/fsldma.h |    3 +-
 2 files changed, 207 insertions(+), 182 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 7b5f88c..19011c2 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -61,7 +61,6 @@ static void dma_init(struct fsldma_chan *chan)
 				| FSL_DMA_MR_PRC_RM, 32);
 		break;
 	}
-
 }
 
 static void set_sr(struct fsldma_chan *chan, u32 val)
@@ -120,11 +119,6 @@ static dma_addr_t get_cdar(struct fsldma_chan *chan)
 	return DMA_IN(chan, &chan->regs->cdar, 64) & ~FSL_DMA_SNEN;
 }
 
-static void set_ndar(struct fsldma_chan *chan, dma_addr_t addr)
-{
-	DMA_OUT(chan, &chan->regs->ndar, addr, 64);
-}
-
 static dma_addr_t get_ndar(struct fsldma_chan *chan)
 {
 	return DMA_IN(chan, &chan->regs->ndar, 64);
@@ -178,11 +172,12 @@ static void dma_halt(struct fsldma_chan *chan)
 
 	for (i = 0; i < 100; i++) {
 		if (dma_is_idle(chan))
-			break;
+			return;
+
 		udelay(10);
 	}
 
-	if (i >= 100 && !dma_is_idle(chan))
+	if (!dma_is_idle(chan))
 		dev_err(chan->dev, "DMA halt timeout!\n");
 }
 
@@ -199,27 +194,6 @@ static void set_ld_eol(struct fsldma_chan *chan,
 			| snoop_bits, 64);
 }
 
-static void append_ld_queue(struct fsldma_chan *chan,
-		struct fsl_desc_sw *new_desc)
-{
-	struct fsl_desc_sw *queue_tail = to_fsl_desc(chan->ld_queue.prev);
-
-	if (list_empty(&chan->ld_queue))
-		return;
-
-	/* Link to the new descriptor physical address and
-	 * Enable End-of-segment interrupt for
-	 * the last link descriptor.
-	 * (the previous node's next link descriptor)
-	 *
-	 * For FSL_DMA_IP_83xx, the snoop enable bit need be set.
-	 */
-	queue_tail->hw.next_ln_addr = CPU_TO_DMA(chan,
-			new_desc->async_tx.phys | FSL_DMA_EOSIE |
-			(((chan->feature & FSL_DMA_IP_MASK)
-				== FSL_DMA_IP_83XX) ? FSL_DMA_SNEN : 0), 64);
-}
-
 /**
  * fsl_chan_set_src_loop_size - Set source address hold transfer size
  * @chan : Freescale DMA channel
@@ -343,6 +317,31 @@ static void fsl_chan_toggle_ext_start(struct fsldma_chan *chan, int enable)
 		chan->feature &= ~FSL_DMA_CHAN_START_EXT;
 }
 
+static void append_ld_queue(struct fsldma_chan *chan,
+			    struct fsl_desc_sw *desc)
+{
+	struct fsl_desc_sw *tail = to_fsl_desc(chan->ld_pending.prev);
+
+	if (list_empty(&chan->ld_pending))
+		goto out_splice;
+
+	/*
+	 * Add the hardware descriptor to the chain of hardware descriptors
+	 * that already exists in memory.
+	 *
+	 * This will un-set the EOL bit of the existing transaction, and the
+	 * last link in this transaction will become the EOL descriptor.
+	 */
+	set_desc_next(chan, &tail->hw, desc->async_tx.phys);
+
+	/*
+	 * Add the software descriptor and all children to the list
+	 * of pending transactions
+	 */
+out_splice:
+	list_splice_tail_init(&desc->tx_list, &chan->ld_pending);
+}
+
 static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 {
 	struct fsldma_chan *chan = to_fsl_chan(tx->chan);
@@ -351,9 +350,12 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	unsigned long flags;
 	dma_cookie_t cookie;
 
-	/* cookie increment and adding to ld_queue must be atomic */
 	spin_lock_irqsave(&chan->desc_lock, flags);
 
+	/*
+	 * assign cookies to all of the software descriptors
+	 * that make up this transaction
+	 */
 	cookie = chan->common.cookie;
 	list_for_each_entry(child, &desc->tx_list, node) {
 		cookie++;
@@ -364,8 +366,9 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	}
 
 	chan->common.cookie = cookie;
+
+	/* put this transaction onto the tail of the pending queue */
 	append_ld_queue(chan, desc);
-	list_splice_init(&desc->tx_list, chan->ld_queue.prev);
 
 	spin_unlock_irqrestore(&chan->desc_lock, flags);
 
@@ -381,20 +384,22 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 static struct fsl_desc_sw *fsl_dma_alloc_descriptor(
 					struct fsldma_chan *chan)
 {
+	struct fsl_desc_sw *desc;
 	dma_addr_t pdesc;
-	struct fsl_desc_sw *desc_sw;
-
-	desc_sw = dma_pool_alloc(chan->desc_pool, GFP_ATOMIC, &pdesc);
-	if (desc_sw) {
-		memset(desc_sw, 0, sizeof(struct fsl_desc_sw));
-		INIT_LIST_HEAD(&desc_sw->tx_list);
-		dma_async_tx_descriptor_init(&desc_sw->async_tx,
-						&chan->common);
-		desc_sw->async_tx.tx_submit = fsl_dma_tx_submit;
-		desc_sw->async_tx.phys = pdesc;
+
+	desc = dma_pool_alloc(chan->desc_pool, GFP_ATOMIC, &pdesc);
+	if (!desc) {
+		dev_dbg(chan->dev, "out of memory for link desc\n");
+		return NULL;
 	}
 
-	return desc_sw;
+	memset(desc, 0, sizeof(*desc));
+	INIT_LIST_HEAD(&desc->tx_list);
+	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
+	desc->async_tx.tx_submit = fsl_dma_tx_submit;
+	desc->async_tx.phys = pdesc;
+
+	return desc;
 }
 
 
@@ -414,45 +419,69 @@ static int fsl_dma_alloc_chan_resources(struct dma_chan *dchan)
 	if (chan->desc_pool)
 		return 1;
 
-	/* We need the descriptor to be aligned to 32bytes
+	/*
+	 * We need the descriptor to be aligned to 32bytes
 	 * for meeting FSL DMA specification requirement.
 	 */
 	chan->desc_pool = dma_pool_create("fsl_dma_engine_desc_pool",
-			chan->dev, sizeof(struct fsl_desc_sw),
-			32, 0);
+					  chan->dev,
+					  sizeof(struct fsl_desc_sw),
+					  __alignof__(struct fsl_desc_sw), 0);
 	if (!chan->desc_pool) {
-		dev_err(chan->dev, "No memory for channel %d "
-			"descriptor dma pool.\n", chan->id);
-		return 0;
+		dev_err(chan->dev, "unable to allocate channel %d "
+				   "descriptor pool\n", chan->id);
+		return -ENOMEM;
 	}
 
+	/* there is at least one descriptor free to be allocated */
 	return 1;
 }
 
 /**
+ * fsldma_free_desc_list - Free all descriptors in a queue
+ * @chan: Freescae DMA channel
+ * @list: the list to free
+ *
+ * LOCKING: must hold chan->desc_lock
+ */
+static void fsldma_free_desc_list(struct fsldma_chan *chan,
+				  struct list_head *list)
+{
+	struct fsl_desc_sw *desc, *_desc;
+
+	list_for_each_entry_safe(desc, _desc, list, node) {
+		list_del(&desc->node);
+		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
+	}
+}
+
+static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
+					  struct list_head *list)
+{
+	struct fsl_desc_sw *desc, *_desc;
+
+	list_for_each_entry_safe_reverse(desc, _desc, list, node) {
+		list_del(&desc->node);
+		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
+	}
+}
+
+/**
  * fsl_dma_free_chan_resources - Free all resources of the channel.
  * @chan : Freescale DMA channel
  */
 static void fsl_dma_free_chan_resources(struct dma_chan *dchan)
 {
 	struct fsldma_chan *chan = to_fsl_chan(dchan);
-	struct fsl_desc_sw *desc, *_desc;
 	unsigned long flags;
 
 	dev_dbg(chan->dev, "Free all channel resources.\n");
 	spin_lock_irqsave(&chan->desc_lock, flags);
-	list_for_each_entry_safe(desc, _desc, &chan->ld_queue, node) {
-#ifdef FSL_DMA_LD_DEBUG
-		dev_dbg(chan->dev,
-				"LD %p will be released.\n", desc);
-#endif
-		list_del(&desc->node);
-		/* free link descriptor */
-		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
-	}
+	fsldma_free_desc_list(chan, &chan->ld_pending);
+	fsldma_free_desc_list(chan, &chan->ld_running);
 	spin_unlock_irqrestore(&chan->desc_lock, flags);
-	dma_pool_destroy(chan->desc_pool);
 
+	dma_pool_destroy(chan->desc_pool);
 	chan->desc_pool = NULL;
 }
 
@@ -491,7 +520,6 @@ static struct dma_async_tx_descriptor *fsl_dma_prep_memcpy(
 {
 	struct fsldma_chan *chan;
 	struct fsl_desc_sw *first = NULL, *prev = NULL, *new;
-	struct list_head *list;
 	size_t copy;
 
 	if (!dchan)
@@ -550,12 +578,7 @@ fail:
 	if (!first)
 		return NULL;
 
-	list = &first->tx_list;
-	list_for_each_entry_safe_reverse(new, prev, list, node) {
-		list_del(&new->node);
-		dma_pool_free(chan->desc_pool, new, new->async_tx.phys);
-	}
-
+	fsldma_free_desc_list_reverse(chan, &first->tx_list);
 	return NULL;
 }
 
@@ -578,7 +601,6 @@ static struct dma_async_tx_descriptor *fsl_dma_prep_slave_sg(
 	struct fsldma_chan *chan;
 	struct fsl_desc_sw *first = NULL, *prev = NULL, *new = NULL;
 	struct fsl_dma_slave *slave;
-	struct list_head *tx_list;
 	size_t copy;
 
 	int i;
@@ -748,19 +770,13 @@ fail:
 	 *
 	 * We're re-using variables for the loop, oh well
 	 */
-	tx_list = &first->tx_list;
-	list_for_each_entry_safe_reverse(new, prev, tx_list, node) {
-		list_del_init(&new->node);
-		dma_pool_free(chan->desc_pool, new, new->async_tx.phys);
-	}
-
+	fsldma_free_desc_list_reverse(chan, &first->tx_list);
 	return NULL;
 }
 
 static void fsl_dma_device_terminate_all(struct dma_chan *dchan)
 {
 	struct fsldma_chan *chan;
-	struct fsl_desc_sw *desc, *tmp;
 	unsigned long flags;
 
 	if (!dchan)
@@ -774,10 +790,8 @@ static void fsl_dma_device_terminate_all(struct dma_chan *dchan)
 	spin_lock_irqsave(&chan->desc_lock, flags);
 
 	/* Remove and free all of the descriptors in the LD queue */
-	list_for_each_entry_safe(desc, tmp, &chan->ld_queue, node) {
-		list_del(&desc->node);
-		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
-	}
+	fsldma_free_desc_list(chan, &chan->ld_pending);
+	fsldma_free_desc_list(chan, &chan->ld_running);
 
 	spin_unlock_irqrestore(&chan->desc_lock, flags);
 }
@@ -785,31 +799,48 @@ static void fsl_dma_device_terminate_all(struct dma_chan *dchan)
 /**
  * fsl_dma_update_completed_cookie - Update the completed cookie.
  * @chan : Freescale DMA channel
+ *
+ * CONTEXT: hardirq
  */
 static void fsl_dma_update_completed_cookie(struct fsldma_chan *chan)
 {
-	struct fsl_desc_sw *cur_desc, *desc;
-	dma_addr_t ld_phy;
-
-	ld_phy = get_cdar(chan) & FSL_DMA_NLDA_MASK;
+	struct fsl_desc_sw *desc;
+	unsigned long flags;
+	dma_cookie_t cookie;
 
-	if (ld_phy) {
-		cur_desc = NULL;
-		list_for_each_entry(desc, &chan->ld_queue, node)
-			if (desc->async_tx.phys == ld_phy) {
-				cur_desc = desc;
-				break;
-			}
+	spin_lock_irqsave(&chan->desc_lock, flags);
 
-		if (cur_desc && cur_desc->async_tx.cookie) {
-			if (dma_is_idle(chan))
-				chan->completed_cookie =
-					cur_desc->async_tx.cookie;
-			else
-				chan->completed_cookie =
-					cur_desc->async_tx.cookie - 1;
-		}
+	if (list_empty(&chan->ld_running)) {
+		dev_dbg(chan->dev, "no running descriptors\n");
+		goto out_unlock;
 	}
+
+	/* Get the last descriptor, update the cookie to that */
+	desc = to_fsl_desc(chan->ld_running.prev);
+	if (dma_is_idle(chan))
+		cookie = desc->async_tx.cookie;
+	else
+		cookie = desc->async_tx.cookie - 1;
+
+	chan->completed_cookie = cookie;
+
+out_unlock:
+	spin_unlock_irqrestore(&chan->desc_lock, flags);
+}
+
+/**
+ * fsldma_desc_status - Check the status of a descriptor
+ * @chan: Freescale DMA channel
+ * @desc: DMA SW descriptor
+ *
+ * This function will return the status of the given descriptor
+ */
+static enum dma_status fsldma_desc_status(struct fsldma_chan *chan,
+					  struct fsl_desc_sw *desc)
+{
+	return dma_async_is_complete(desc->async_tx.cookie,
+				     chan->completed_cookie,
+				     chan->common.cookie);
 }
 
 /**
@@ -817,8 +848,6 @@ static void fsl_dma_update_completed_cookie(struct fsldma_chan *chan)
  * @chan : Freescale DMA channel
  *
  * This function clean up the ld_queue of DMA channel.
- * If 'in_intr' is set, the function will move the link descriptor to
- * the recycle list. Otherwise, free it directly.
  */
 static void fsl_chan_ld_cleanup(struct fsldma_chan *chan)
 {
@@ -827,80 +856,95 @@ static void fsl_chan_ld_cleanup(struct fsldma_chan *chan)
 
 	spin_lock_irqsave(&chan->desc_lock, flags);
 
-	dev_dbg(chan->dev, "chan completed_cookie = %d\n",
-			chan->completed_cookie);
-	list_for_each_entry_safe(desc, _desc, &chan->ld_queue, node) {
+	dev_dbg(chan->dev, "chan completed_cookie = %d\n", chan->completed_cookie);
+	list_for_each_entry_safe(desc, _desc, &chan->ld_running, node) {
 		dma_async_tx_callback callback;
 		void *callback_param;
 
-		if (dma_async_is_complete(desc->async_tx.cookie,
-			    chan->completed_cookie, chan->common.cookie)
-				== DMA_IN_PROGRESS)
+		if (fsldma_desc_status(chan, desc) == DMA_IN_PROGRESS)
 			break;
 
-		callback = desc->async_tx.callback;
-		callback_param = desc->async_tx.callback_param;
-
-		/* Remove from ld_queue list */
+		/* Remove from the list of running transactions */
 		list_del(&desc->node);
 
-		dev_dbg(chan->dev, "link descriptor %p will be recycle.\n",
-				desc);
-		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
-
 		/* Run the link descriptor callback function */
+		callback = desc->async_tx.callback;
+		callback_param = desc->async_tx.callback_param;
 		if (callback) {
 			spin_unlock_irqrestore(&chan->desc_lock, flags);
-			dev_dbg(chan->dev, "link descriptor %p callback\n",
-					desc);
+			dev_dbg(chan->dev, "LD %p callback\n", desc);
 			callback(callback_param);
 			spin_lock_irqsave(&chan->desc_lock, flags);
 		}
+
+		/* Run any dependencies, then free the descriptor */
+		dma_run_dependencies(&desc->async_tx);
+		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
 	}
+
 	spin_unlock_irqrestore(&chan->desc_lock, flags);
 }
 
 /**
- * fsl_chan_xfer_ld_queue - Transfer link descriptors in channel ld_queue.
+ * fsl_chan_xfer_ld_queue - transfer any pending transactions
  * @chan : Freescale DMA channel
+ *
+ * This will make sure that any pending transactions will be run.
+ * If the DMA controller is idle, it will be started. Otherwise,
+ * the DMA controller's interrupt handler will start any pending
+ * transactions when it becomes idle.
  */
 static void fsl_chan_xfer_ld_queue(struct fsldma_chan *chan)
 {
-	struct list_head *ld_node;
-	dma_addr_t next_dst_addr;
+	struct fsl_desc_sw *desc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&chan->desc_lock, flags);
 
-	if (!dma_is_idle(chan))
+	/*
+	 * If the list of pending descriptors is empty, then we
+	 * don't need to do any work at all
+	 */
+	if (list_empty(&chan->ld_pending)) {
+		dev_dbg(chan->dev, "no pending LDs\n");
 		goto out_unlock;
+	}
 
+	/*
+	 * The DMA controller is not idle, which means the interrupt
+	 * handler will start any queued transactions when it runs
+	 * at the end of the current transaction
+	 */
+	if (!dma_is_idle(chan)) {
+		dev_dbg(chan->dev, "DMA controller still busy\n");
+		goto out_unlock;
+	}
+
+	/*
+	 * TODO:
+	 * make sure the dma_halt() function really un-wedges the
+	 * controller as much as possible
+	 */
 	dma_halt(chan);
 
-	/* If there are some link descriptors
-	 * not transfered in queue. We need to start it.
+	/*
+	 * If there are some link descriptors which have not been
+	 * transferred, we need to start the controller
 	 */
 
-	/* Find the first un-transfer desciptor */
-	for (ld_node = chan->ld_queue.next;
-		(ld_node != &chan->ld_queue)
-			&& (dma_async_is_complete(
-				to_fsl_desc(ld_node)->async_tx.cookie,
-				chan->completed_cookie,
-				chan->common.cookie) == DMA_SUCCESS);
-		ld_node = ld_node->next);
-
-	if (ld_node != &chan->ld_queue) {
-		/* Get the ld start address from ld_queue */
-		next_dst_addr = to_fsl_desc(ld_node)->async_tx.phys;
-		dev_dbg(chan->dev, "xfer LDs staring from 0x%llx\n",
-				(unsigned long long)next_dst_addr);
-		set_cdar(chan, next_dst_addr);
-		dma_start(chan);
-	} else {
-		set_cdar(chan, 0);
-		set_ndar(chan, 0);
-	}
+	/*
+	 * Move all elements from the queue of pending transactions
+	 * onto the list of running transactions
+	 */
+	desc = list_first_entry(&chan->ld_pending, struct fsl_desc_sw, node);
+	list_splice_tail_init(&chan->ld_pending, &chan->ld_running);
+
+	/*
+	 * Program the descriptor's address into the DMA controller,
+	 * then start the DMA transaction
+	 */
+	set_cdar(chan, desc->async_tx.phys);
+	dma_start(chan);
 
 out_unlock:
 	spin_unlock_irqrestore(&chan->desc_lock, flags);
@@ -913,30 +957,6 @@ out_unlock:
 static void fsl_dma_memcpy_issue_pending(struct dma_chan *dchan)
 {
 	struct fsldma_chan *chan = to_fsl_chan(dchan);
-
-#ifdef FSL_DMA_LD_DEBUG
-	struct fsl_desc_sw *ld;
-	unsigned long flags;
-
-	spin_lock_irqsave(&chan->desc_lock, flags);
-	if (list_empty(&chan->ld_queue)) {
-		spin_unlock_irqrestore(&chan->desc_lock, flags);
-		return;
-	}
-
-	dev_dbg(chan->dev, "--memcpy issue--\n");
-	list_for_each_entry(ld, &chan->ld_queue, node) {
-		int i;
-		dev_dbg(chan->dev, "Ch %d, LD %08x\n",
-				chan->id, ld->async_tx.phys);
-		for (i = 0; i < 8; i++)
-			dev_dbg(chan->dev, "LD offset %d: %08x\n",
-					i, *(((u32 *)&ld->hw) + i));
-	}
-	dev_dbg(chan->dev, "----------------\n");
-	spin_unlock_irqrestore(&chan->desc_lock, flags);
-#endif
-
 	fsl_chan_xfer_ld_queue(chan);
 }
 
@@ -978,10 +998,10 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 	int xfer_ld_q = 0;
 	u32 stat;
 
+	/* save and clear the status register */
 	stat = get_sr(chan);
-	dev_dbg(chan->dev, "event: channel %d, stat = 0x%x\n",
-						chan->id, stat);
-	set_sr(chan, stat);		/* Clear the event register */
+	set_sr(chan, stat);
+	dev_dbg(chan->dev, "irq: channel %d, stat = 0x%x\n", chan->id, stat);
 
 	stat &= ~(FSL_DMA_SR_CB | FSL_DMA_SR_CH);
 	if (!stat)
@@ -990,12 +1010,13 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 	if (stat & FSL_DMA_SR_TE)
 		dev_err(chan->dev, "Transfer Error!\n");
 
-	/* Programming Error
+	/*
+	 * Programming Error
 	 * The DMA_INTERRUPT async_tx is a NULL transfer, which will
 	 * triger a PE interrupt.
 	 */
 	if (stat & FSL_DMA_SR_PE) {
-		dev_dbg(chan->dev, "event: Programming Error INT\n");
+		dev_dbg(chan->dev, "irq: Programming Error INT\n");
 		if (get_bcr(chan) == 0) {
 			/* BCR register is 0, this is a DMA_INTERRUPT async_tx.
 			 * Now, update the completed cookie, and continue the
@@ -1007,34 +1028,37 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 		stat &= ~FSL_DMA_SR_PE;
 	}
 
-	/* If the link descriptor segment transfer finishes,
+	/*
+	 * If the link descriptor segment transfer finishes,
 	 * we will recycle the used descriptor.
 	 */
 	if (stat & FSL_DMA_SR_EOSI) {
-		dev_dbg(chan->dev, "event: End-of-segments INT\n");
-		dev_dbg(chan->dev, "event: clndar 0x%llx, nlndar 0x%llx\n",
+		dev_dbg(chan->dev, "irq: End-of-segments INT\n");
+		dev_dbg(chan->dev, "irq: clndar 0x%llx, nlndar 0x%llx\n",
 			(unsigned long long)get_cdar(chan),
 			(unsigned long long)get_ndar(chan));
 		stat &= ~FSL_DMA_SR_EOSI;
 		update_cookie = 1;
 	}
 
-	/* For MPC8349, EOCDI event need to update cookie
+	/*
+	 * For MPC8349, EOCDI event need to update cookie
 	 * and start the next transfer if it exist.
 	 */
 	if (stat & FSL_DMA_SR_EOCDI) {
-		dev_dbg(chan->dev, "event: End-of-Chain link INT\n");
+		dev_dbg(chan->dev, "irq: End-of-Chain link INT\n");
 		stat &= ~FSL_DMA_SR_EOCDI;
 		update_cookie = 1;
 		xfer_ld_q = 1;
 	}
 
-	/* If it current transfer is the end-of-transfer,
+	/*
+	 * If it current transfer is the end-of-transfer,
 	 * we should clear the Channel Start bit for
 	 * prepare next transfer.
 	 */
 	if (stat & FSL_DMA_SR_EOLNI) {
-		dev_dbg(chan->dev, "event: End-of-link INT\n");
+		dev_dbg(chan->dev, "irq: End-of-link INT\n");
 		stat &= ~FSL_DMA_SR_EOLNI;
 		xfer_ld_q = 1;
 	}
@@ -1044,10 +1068,9 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 	if (xfer_ld_q)
 		fsl_chan_xfer_ld_queue(chan);
 	if (stat)
-		dev_dbg(chan->dev, "event: unhandled sr 0x%02x\n",
-					stat);
+		dev_dbg(chan->dev, "irq: unhandled sr 0x%02x\n", stat);
 
-	dev_dbg(chan->dev, "event: Exit\n");
+	dev_dbg(chan->dev, "irq: Exit\n");
 	tasklet_schedule(&chan->tasklet);
 	return IRQ_HANDLED;
 }
@@ -1235,7 +1258,8 @@ static int __devinit fsl_dma_chan_probe(struct fsldma_device *fdev,
 	}
 
 	spin_lock_init(&chan->desc_lock);
-	INIT_LIST_HEAD(&chan->ld_queue);
+	INIT_LIST_HEAD(&chan->ld_pending);
+	INIT_LIST_HEAD(&chan->ld_running);
 
 	chan->common.device = &fdev->common;
 
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index ea3b19c..cb4d6ff 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -131,7 +131,8 @@ struct fsldma_chan {
 	struct fsldma_chan_regs __iomem *regs;
 	dma_cookie_t completed_cookie;	/* The maximum cookie completed */
 	spinlock_t desc_lock;		/* Descriptor operation lock */
-	struct list_head ld_queue;	/* Link descriptors queue */
+	struct list_head ld_pending;	/* Link descriptors queue */
+	struct list_head ld_running;	/* Link descriptors queue */
 	struct dma_chan common;		/* DMA common channel */
 	struct dma_pool *desc_pool;	/* Descriptors pool */
 	struct device *dev;		/* Channel device */
-- 
1.5.4.3
