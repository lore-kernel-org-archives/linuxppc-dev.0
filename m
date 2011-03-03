Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 7D5D9B70EB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Mar 2011 04:55:11 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 4/9] fsldma: improve link descriptor debugging
Date: Thu,  3 Mar 2011 09:54:56 -0800
Message-Id: <1299174901-16762-5-git-send-email-iws@ovro.caltech.edu>
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

This adds better tracking to link descriptor allocations, callbacks, and
frees. This makes it much easier to track errors with link descriptors.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index e535cd1..82b8e9f 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -420,6 +420,10 @@ static struct fsl_desc_sw *fsl_dma_alloc_descriptor(
 	desc->async_tx.tx_submit = fsl_dma_tx_submit;
 	desc->async_tx.phys = pdesc;
 
+#ifdef FSL_DMA_LD_DEBUG
+	chan_dbg(chan, "LD %p allocated\n", desc);
+#endif
+
 	return desc;
 }
 
@@ -470,6 +474,9 @@ static void fsldma_free_desc_list(struct fsldma_chan *chan,
 
 	list_for_each_entry_safe(desc, _desc, list, node) {
 		list_del(&desc->node);
+#ifdef FSL_DMA_LD_DEBUG
+		chan_dbg(chan, "LD %p free\n", desc);
+#endif
 		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
 	}
 }
@@ -481,6 +488,9 @@ static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
 
 	list_for_each_entry_safe_reverse(desc, _desc, list, node) {
 		list_del(&desc->node);
+#ifdef FSL_DMA_LD_DEBUG
+		chan_dbg(chan, "LD %p free\n", desc);
+#endif
 		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
 	}
 }
@@ -557,9 +567,6 @@ static struct dma_async_tx_descriptor *fsl_dma_prep_memcpy(
 			chan_err(chan, "%s\n", msg_ld_oom);
 			goto fail;
 		}
-#ifdef FSL_DMA_LD_DEBUG
-		chan_dbg(chan, "new link desc alloc %p\n", new);
-#endif
 
 		copy = min(len, (size_t)FSL_DMA_BCR_MAX_CNT);
 
@@ -645,9 +652,6 @@ static struct dma_async_tx_descriptor *fsl_dma_prep_sg(struct dma_chan *dchan,
 			chan_err(chan, "%s\n", msg_ld_oom);
 			goto fail;
 		}
-#ifdef FSL_DMA_LD_DEBUG
-		chan_dbg(chan, "new link desc alloc %p\n", new);
-#endif
 
 		set_desc_cnt(chan, &new->hw, len);
 		set_desc_src(chan, &new->hw, src);
@@ -882,13 +886,18 @@ static void fsl_chan_ld_cleanup(struct fsldma_chan *chan)
 		callback_param = desc->async_tx.callback_param;
 		if (callback) {
 			spin_unlock_irqrestore(&chan->desc_lock, flags);
+#ifdef FSL_DMA_LD_DEBUG
 			chan_dbg(chan, "LD %p callback\n", desc);
+#endif
 			callback(callback_param);
 			spin_lock_irqsave(&chan->desc_lock, flags);
 		}
 
 		/* Run any dependencies, then free the descriptor */
 		dma_run_dependencies(&desc->async_tx);
+#ifdef FSL_DMA_LD_DEBUG
+		chan_dbg(chan, "LD %p free\n", desc);
+#endif
 		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
 	}
 
-- 
1.7.3.4
