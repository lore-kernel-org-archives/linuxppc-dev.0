Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id E6D1BB70F2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Mar 2011 04:55:12 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 8/9] fsldma: reduce locking during descriptor cleanup
Date: Thu,  3 Mar 2011 09:55:00 -0800
Message-Id: <1299174901-16762-9-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1299174901-16762-1-git-send-email-iws@ovro.caltech.edu>
References: <1299174901-16762-1-git-send-email-iws@ovro.caltech.edu>
Cc: dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This merges the fsl_chan_ld_cleanup() function into the dma_do_tasklet()
function to reduce locking overhead. In the best case, we will be able
to keep the DMA controller busy while we are freeing used descriptors.
In all cases, the spinlock is grabbed two times fewer than before on
each transaction.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |  108 +++++++++++++++++++++----------------------------
 1 files changed, 46 insertions(+), 62 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 526579d..d300de4 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -882,65 +882,15 @@ static void fsldma_cleanup_descriptor(struct fsldma_chan *chan,
 }
 
 /**
- * fsl_chan_ld_cleanup - Clean up link descriptors
- * @chan : Freescale DMA channel
- *
- * This function is run after the queue of running descriptors has been
- * executed by the DMA engine. It will run any callbacks, and then free
- * the descriptors.
- *
- * HARDWARE STATE: idle
- */
-static void fsl_chan_ld_cleanup(struct fsldma_chan *chan)
-{
-	struct fsl_desc_sw *desc, *_desc;
-	LIST_HEAD(ld_cleanup);
-	unsigned long flags;
-
-	spin_lock_irqsave(&chan->desc_lock, flags);
-
-	/* update the cookie if we have some descriptors to cleanup */
-	if (!list_empty(&chan->ld_running)) {
-		dma_cookie_t cookie;
-
-		desc = to_fsl_desc(chan->ld_running.prev);
-		cookie = desc->async_tx.cookie;
-
-		chan->completed_cookie = cookie;
-		chan_dbg(chan, "completed cookie=%d\n", cookie);
-	}
-
-	/*
-	 * move the descriptors to a temporary list so we can drop the lock
-	 * during the entire cleanup operation
-	 */
-	list_splice_tail_init(&chan->ld_running, &ld_cleanup);
-
-	spin_unlock_irqrestore(&chan->desc_lock, flags);
-
-	/* Run the callback for each descriptor, in order */
-	list_for_each_entry_safe(desc, _desc, &ld_cleanup, node) {
-
-		/* Remove from the list of transactions */
-		list_del(&desc->node);
-
-		/* Run all cleanup for this descriptor */
-		fsldma_cleanup_descriptor(chan, desc);
-	}
-}
-
-/**
  * fsl_chan_xfer_ld_queue - transfer any pending transactions
  * @chan : Freescale DMA channel
  *
  * HARDWARE STATE: idle
+ * LOCKING: must hold chan->desc_lock
  */
 static void fsl_chan_xfer_ld_queue(struct fsldma_chan *chan)
 {
 	struct fsl_desc_sw *desc;
-	unsigned long flags;
-
-	spin_lock_irqsave(&chan->desc_lock, flags);
 
 	/*
 	 * If the list of pending descriptors is empty, then we
@@ -948,7 +898,7 @@ static void fsl_chan_xfer_ld_queue(struct fsldma_chan *chan)
 	 */
 	if (list_empty(&chan->ld_pending)) {
 		chan_dbg(chan, "no pending LDs\n");
-		goto out_unlock;
+		return;
 	}
 
 	/*
@@ -958,7 +908,7 @@ static void fsl_chan_xfer_ld_queue(struct fsldma_chan *chan)
 	 */
 	if (!chan->idle) {
 		chan_dbg(chan, "DMA controller still busy\n");
-		goto out_unlock;
+		return;
 	}
 
 	/*
@@ -996,9 +946,6 @@ static void fsl_chan_xfer_ld_queue(struct fsldma_chan *chan)
 
 	dma_start(chan);
 	chan->idle = false;
-
-out_unlock:
-	spin_unlock_irqrestore(&chan->desc_lock, flags);
 }
 
 /**
@@ -1008,7 +955,11 @@ out_unlock:
 static void fsl_dma_memcpy_issue_pending(struct dma_chan *dchan)
 {
 	struct fsldma_chan *chan = to_fsl_chan(dchan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->desc_lock, flags);
 	fsl_chan_xfer_ld_queue(chan);
+	spin_unlock_irqrestore(&chan->desc_lock, flags);
 }
 
 /**
@@ -1109,20 +1060,53 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 static void dma_do_tasklet(unsigned long data)
 {
 	struct fsldma_chan *chan = (struct fsldma_chan *)data;
+	struct fsl_desc_sw *desc, *_desc;
+	LIST_HEAD(ld_cleanup);
 	unsigned long flags;
 
 	chan_dbg(chan, "tasklet entry\n");
 
-	/* run all callbacks, free all used descriptors */
-	fsl_chan_ld_cleanup(chan);
-
-	/* the channel is now idle */
 	spin_lock_irqsave(&chan->desc_lock, flags);
+
+	/* update the cookie if we have some descriptors to cleanup */
+	if (!list_empty(&chan->ld_running)) {
+		dma_cookie_t cookie;
+
+		desc = to_fsl_desc(chan->ld_running.prev);
+		cookie = desc->async_tx.cookie;
+
+		chan->completed_cookie = cookie;
+		chan_dbg(chan, "completed_cookie=%d\n", cookie);
+	}
+
+	/*
+	 * move the descriptors to a temporary list so we can drop the lock
+	 * during the entire cleanup operation
+	 */
+	list_splice_tail_init(&chan->ld_running, &ld_cleanup);
+
+	/* the hardware is now idle and ready for more */
 	chan->idle = true;
-	spin_unlock_irqrestore(&chan->desc_lock, flags);
 
-	/* start any pending transactions automatically */
+	/*
+	 * Start any pending transactions automatically
+	 *
+	 * In the ideal case, we keep the DMA controller busy while we go
+	 * ahead and free the descriptors below.
+	 */
 	fsl_chan_xfer_ld_queue(chan);
+	spin_unlock_irqrestore(&chan->desc_lock, flags);
+
+	/* Run the callback for each descriptor, in order */
+	list_for_each_entry_safe(desc, _desc, &ld_cleanup, node) {
+
+		/* Remove from the list of transactions */
+		list_del(&desc->node);
+
+		/* Run all cleanup for this descriptor */
+		fsldma_cleanup_descriptor(chan, desc);
+	}
+
 	chan_dbg(chan, "tasklet exit\n");
 }
 
-- 
1.7.3.4
