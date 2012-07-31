Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 015762C0090
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 09:45:58 +1000 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 4/7] fsl-dma: move functions to avoid forward declarations
Date: Tue, 31 Jul 2012 16:45:49 -0700
Message-Id: <1343778352-5549-5-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1343778352-5549-1-git-send-email-iws@ovro.caltech.edu>
References: <1343778352-5549-1-git-send-email-iws@ovro.caltech.edu>
Cc: B32616@freescale.com, linuxppc-dev@lists.ozlabs.org,
 "Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

This function will be modified in the next patch in the series. By
moving the function in a patch separate from the changes, it will make
review easier.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |   96 +++++++++++++++++++++++++-------------------------
 1 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index c34a628..80edc63 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -409,6 +409,54 @@ static void fsl_dma_free_descriptor(struct fsldma_chan *chan, struct fsl_desc_sw
 	dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
 }
 
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
+	struct device *dev = chan->common.device->dev;
+	dma_addr_t src = get_desc_src(chan, desc);
+	dma_addr_t dst = get_desc_dst(chan, desc);
+	u32 len = get_desc_cnt(chan, desc);
+
+	/* Run the link descriptor callback function */
+	if (txd->callback) {
+#ifdef FSL_DMA_LD_DEBUG
+		chan_dbg(chan, "LD %p callback\n", desc);
+#endif
+		txd->callback(txd->callback_param);
+	}
+
+	/* Run any dependencies */
+	dma_run_dependencies(txd);
+
+	/* Unmap the dst buffer, if requested */
+	if (!(txd->flags & DMA_COMPL_SKIP_DEST_UNMAP)) {
+		if (txd->flags & DMA_COMPL_DEST_UNMAP_SINGLE)
+			dma_unmap_single(dev, dst, len, DMA_FROM_DEVICE);
+		else
+			dma_unmap_page(dev, dst, len, DMA_FROM_DEVICE);
+	}
+
+	/* Unmap the src buffer, if requested */
+	if (!(txd->flags & DMA_COMPL_SKIP_SRC_UNMAP)) {
+		if (txd->flags & DMA_COMPL_SRC_UNMAP_SINGLE)
+			dma_unmap_single(dev, src, len, DMA_TO_DEVICE);
+		else
+			dma_unmap_page(dev, src, len, DMA_TO_DEVICE);
+	}
+
+	fsl_dma_free_descriptor(chan, desc);
+}
+
 static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 {
 	struct fsldma_chan *chan = to_fsl_chan(tx->chan);
@@ -807,54 +855,6 @@ static int fsl_dma_device_control(struct dma_chan *dchan,
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
-	struct device *dev = chan->common.device->dev;
-	dma_addr_t src = get_desc_src(chan, desc);
-	dma_addr_t dst = get_desc_dst(chan, desc);
-	u32 len = get_desc_cnt(chan, desc);
-
-	/* Run the link descriptor callback function */
-	if (txd->callback) {
-#ifdef FSL_DMA_LD_DEBUG
-		chan_dbg(chan, "LD %p callback\n", desc);
-#endif
-		txd->callback(txd->callback_param);
-	}
-
-	/* Run any dependencies */
-	dma_run_dependencies(txd);
-
-	/* Unmap the dst buffer, if requested */
-	if (!(txd->flags & DMA_COMPL_SKIP_DEST_UNMAP)) {
-		if (txd->flags & DMA_COMPL_DEST_UNMAP_SINGLE)
-			dma_unmap_single(dev, dst, len, DMA_FROM_DEVICE);
-		else
-			dma_unmap_page(dev, dst, len, DMA_FROM_DEVICE);
-	}
-
-	/* Unmap the src buffer, if requested */
-	if (!(txd->flags & DMA_COMPL_SKIP_SRC_UNMAP)) {
-		if (txd->flags & DMA_COMPL_SRC_UNMAP_SINGLE)
-			dma_unmap_single(dev, src, len, DMA_TO_DEVICE);
-		else
-			dma_unmap_page(dev, src, len, DMA_TO_DEVICE);
-	}
-
-	fsl_dma_free_descriptor(chan, desc);
-}
-
-/**
  * fsl_chan_xfer_ld_queue - transfer any pending transactions
  * @chan : Freescale DMA channel
  *
-- 
1.7.8.6
