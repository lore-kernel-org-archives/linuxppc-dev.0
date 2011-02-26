Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 0A34BB7103
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Feb 2011 11:23:36 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/8] fsldma: improve link descriptor debugging
Date: Fri, 25 Feb 2011 16:23:20 -0800
Message-Id: <1298679805-14108-4-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1298679805-14108-1-git-send-email-iws@ovro.caltech.edu>
References: <1298679805-14108-1-git-send-email-iws@ovro.caltech.edu>
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
index 6e3d3d7..851993c 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -416,6 +416,10 @@ static struct fsl_desc_sw *fsl_dma_alloc_descriptor(
 	desc->async_tx.tx_submit = fsl_dma_tx_submit;
 	desc->async_tx.phys = pdesc;
 
+#ifdef FSL_DMA_LD_DEBUG
+	dev_dbg(chan->dev, "%s: LD %p allocated\n", chan->name, desc);
+#endif
+
 	return desc;
 }
 
@@ -467,6 +471,9 @@ static void fsldma_free_desc_list(struct fsldma_chan *chan,
 
 	list_for_each_entry_safe(desc, _desc, list, node) {
 		list_del(&desc->node);
+#ifdef FSL_DMA_LD_DEBUG
+		dev_dbg(chan->dev, "%s: LD %p free\n", chan->name, desc);
+#endif
 		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
 	}
 }
@@ -478,6 +485,9 @@ static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
 
 	list_for_each_entry_safe_reverse(desc, _desc, list, node) {
 		list_del(&desc->node);
+#ifdef FSL_DMA_LD_DEBUG
+		dev_dbg(chan->dev, "%s: LD %p free\n", chan->name, desc);
+#endif
 		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
 	}
 }
@@ -554,9 +564,6 @@ static struct dma_async_tx_descriptor *fsl_dma_prep_memcpy(
 			dev_err(chan->dev, "%s: %s\n", chan->name, msg_ld_oom);
 			goto fail;
 		}
-#ifdef FSL_DMA_LD_DEBUG
-		dev_dbg(chan->dev, "%s: new link desc alloc %p\n", chan->name, new);
-#endif
 
 		copy = min(len, (size_t)FSL_DMA_BCR_MAX_CNT);
 
@@ -642,9 +649,6 @@ static struct dma_async_tx_descriptor *fsl_dma_prep_sg(struct dma_chan *dchan,
 			dev_err(chan->dev, "%s: %s\n", chan->name, msg_ld_oom);
 			goto fail;
 		}
-#ifdef FSL_DMA_LD_DEBUG
-		dev_dbg(chan->dev, "%s: new link desc alloc %p\n", chan->name, new);
-#endif
 
 		set_desc_cnt(chan, &new->hw, len);
 		set_desc_src(chan, &new->hw, src);
@@ -881,13 +885,18 @@ static void fsl_chan_ld_cleanup(struct fsldma_chan *chan)
 		callback_param = desc->async_tx.callback_param;
 		if (callback) {
 			spin_unlock_irqrestore(&chan->desc_lock, flags);
+#ifdef FSL_DMA_LD_DEBUG
 			dev_dbg(chan->dev, "%s: LD %p callback\n", name, desc);
+#endif
 			callback(callback_param);
 			spin_lock_irqsave(&chan->desc_lock, flags);
 		}
 
 		/* Run any dependencies, then free the descriptor */
 		dma_run_dependencies(&desc->async_tx);
+#ifdef FSL_DMA_LD_DEBUG
+		dev_dbg(chan->dev, "%s: LD %p free\n", name, desc);
+#endif
 		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
 	}
 
-- 
1.7.3.4
