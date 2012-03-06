Return-Path: <rmk+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 95DA0B700D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 09:35:50 +1100 (EST)
In-Reply-To: <20120306223321.GD15201@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Dan Williams <dan.j.williams@intel.com>,Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/9] dmaengine: provide a common function for completing a
 dma descriptor
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <E1S52yJ-0002Mx-2e@rmk-PC.arm.linux.org.uk>
Sender: Russell King <rmk@arm.linux.org.uk>
Date: Tue, 06 Mar 2012 22:35:07 +0000
Cc: Viresh Kumar <viresh.kumar@st.com>, Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Provide a common function to do the cookie mechanics for completing
a DMA descriptor.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c    |    2 +-
 drivers/dma/at_hdmac.c      |    2 +-
 drivers/dma/coh901318.c     |    2 +-
 drivers/dma/dmaengine.h     |   18 ++++++++++++++++++
 drivers/dma/dw_dmac.c       |    2 +-
 drivers/dma/ep93xx_dma.c    |    2 +-
 drivers/dma/fsldma.c        |    2 +-
 drivers/dma/imx-dma.c       |    2 +-
 drivers/dma/imx-sdma.c      |    2 +-
 drivers/dma/intel_mid_dma.c |    2 +-
 drivers/dma/ioat/dma.c      |    3 +--
 drivers/dma/ioat/dma_v2.c   |    3 +--
 drivers/dma/ioat/dma_v3.c   |    3 +--
 drivers/dma/ipu/ipu_idmac.c |    2 +-
 drivers/dma/mxs-dma.c       |    2 +-
 drivers/dma/pl330.c         |    2 +-
 drivers/dma/ste_dma40.c     |    2 +-
 drivers/dma/timb_dma.c      |    2 +-
 drivers/dma/txx9dmac.c      |    2 +-
 19 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 5996386..f0888c1 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1540,7 +1540,7 @@ static void pl08x_tasklet(unsigned long data)
 
 	if (txd) {
 		/* Update last completed */
-		plchan->chan.completed_cookie = txd->tx.cookie;
+		dma_cookie_complete(&txd->tx);
 	}
 
 	/* If a new descriptor is queued, set it up plchan->at is NULL here */
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index df47e7d..b282630 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -249,7 +249,7 @@ atc_chain_complete(struct at_dma_chan *atchan, struct at_desc *desc)
 	dev_vdbg(chan2dev(&atchan->chan_common),
 		"descriptor %u complete\n", txd->cookie);
 
-	atchan->chan_common.completed_cookie = txd->cookie;
+	dma_cookie_complete(txd);
 
 	/* move children to free_list */
 	list_splice_init(&desc->tx_list, &atchan->free_list);
diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index 843a1a3..24837d7 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -691,7 +691,7 @@ static void dma_tasklet(unsigned long data)
 	callback_param = cohd_fin->desc.callback_param;
 
 	/* sign this job as completed on the channel */
-	cohc->chan.completed_cookie = cohd_fin->desc.cookie;
+	dma_cookie_complete(&cohd_fin->desc);
 
 	/* release the lli allocation and remove the descriptor */
 	coh901318_lli_free(&cohc->base->pool, &cohd_fin->lli);
diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index 7692c86..47e0997 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -5,6 +5,7 @@
 #ifndef DMAENGINE_H
 #define DMAENGINE_H
 
+#include <linux/bug.h>
 #include <linux/dmaengine.h>
 
 /**
@@ -27,4 +28,21 @@ static inline dma_cookie_t dma_cookie_assign(struct dma_async_tx_descriptor *tx)
 	return cookie;
 }
 
+/**
+ * dma_cookie_complete - complete a descriptor
+ * @tx: descriptor to complete
+ *
+ * Mark this descriptor complete by updating the channels completed
+ * cookie marker.  Zero the descriptors cookie to prevent accidental
+ * repeated completions.
+ *
+ * Note: caller is expected to hold a lock to prevent concurrency.
+ */
+static inline void dma_cookie_complete(struct dma_async_tx_descriptor *tx)
+{
+	BUG_ON(tx->cookie < DMA_MIN_COOKIE);
+	tx->chan->completed_cookie = tx->cookie;
+	tx->cookie = 0;
+}
+
 #endif
diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 5ee9498..a190c88 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -231,7 +231,7 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
 	dev_vdbg(chan2dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dwc->chan.completed_cookie = txd->cookie;
+	dma_cookie_complete(txd);
 	if (callback_required) {
 		callback = txd->callback;
 		param = txd->callback_param;
diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index e5aaae8..1c56f75 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -703,7 +703,7 @@ static void ep93xx_dma_tasklet(unsigned long data)
 	desc = ep93xx_dma_get_active(edmac);
 	if (desc) {
 		if (desc->complete) {
-			edmac->chan.completed_cookie = desc->txd.cookie;
+			dma_cookie_complete(&desc->txd);
 			list_splice_init(&edmac->active, &list);
 		}
 		callback = desc->txd.callback;
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 04b4347..f36e8b1 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1081,8 +1081,8 @@ static void dma_do_tasklet(unsigned long data)
 
 		desc = to_fsl_desc(chan->ld_running.prev);
 		cookie = desc->async_tx.cookie;
+		dma_cookie_complete(&desc->async_tx);
 
-		chan->common.completed_cookie = cookie;
 		chan_dbg(chan, "completed_cookie=%d\n", cookie);
 	}
 
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 42154b6..f1226ad 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -66,7 +66,7 @@ static void imxdma_handle(struct imxdma_channel *imxdmac)
 {
 	if (imxdmac->desc.callback)
 		imxdmac->desc.callback(imxdmac->desc.callback_param);
-	imxdmac->chan.completed_cookie = imxdmac->desc.cookie;
+	dma_cookie_complete(&imxdmac->desc);
 }
 
 static void imxdma_irq_handler(int channel, void *data)
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 4e4f40e..4406be2 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -524,7 +524,7 @@ static void mxc_sdma_handle_channel_normal(struct sdma_channel *sdmac)
 	else
 		sdmac->status = DMA_SUCCESS;
 
-	sdmac->chan.completed_cookie = sdmac->desc.cookie;
+	dma_cookie_complete(&sdmac->desc);
 	if (sdmac->desc.callback)
 		sdmac->desc.callback(sdmac->desc.callback_param);
 }
diff --git a/drivers/dma/intel_mid_dma.c b/drivers/dma/intel_mid_dma.c
index dfe4396..340509e 100644
--- a/drivers/dma/intel_mid_dma.c
+++ b/drivers/dma/intel_mid_dma.c
@@ -290,7 +290,7 @@ static void midc_descriptor_complete(struct intel_mid_dma_chan *midc,
 	struct intel_mid_dma_lli	*llitem;
 	void *param_txd = NULL;
 
-	midc->chan.completed_cookie = txd->cookie;
+	dma_cookie_complete(txd);
 	callback_txd = txd->callback;
 	param_txd = txd->callback_param;
 
diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 5c06117..b0517c8 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -600,8 +600,7 @@ static void __cleanup(struct ioat_dma_chan *ioat, unsigned long phys_complete)
 		 */
 		dump_desc_dbg(ioat, desc);
 		if (tx->cookie) {
-			chan->common.completed_cookie = tx->cookie;
-			tx->cookie = 0;
+			dma_cookie_complete(tx);
 			ioat_dma_unmap(chan, tx->flags, desc->len, desc->hw);
 			ioat->active -= desc->hw->tx_cnt;
 			if (tx->callback) {
diff --git a/drivers/dma/ioat/dma_v2.c b/drivers/dma/ioat/dma_v2.c
index 17ecacb..e8e110f 100644
--- a/drivers/dma/ioat/dma_v2.c
+++ b/drivers/dma/ioat/dma_v2.c
@@ -149,8 +149,7 @@ static void __cleanup(struct ioat2_dma_chan *ioat, unsigned long phys_complete)
 		dump_desc_dbg(ioat, desc);
 		if (tx->cookie) {
 			ioat_dma_unmap(chan, tx->flags, desc->len, desc->hw);
-			chan->common.completed_cookie = tx->cookie;
-			tx->cookie = 0;
+			dma_cookie_complete(tx);
 			if (tx->callback) {
 				tx->callback(tx->callback_param);
 				tx->callback = NULL;
diff --git a/drivers/dma/ioat/dma_v3.c b/drivers/dma/ioat/dma_v3.c
index d4afac7..1bda46c 100644
--- a/drivers/dma/ioat/dma_v3.c
+++ b/drivers/dma/ioat/dma_v3.c
@@ -277,9 +277,8 @@ static void __cleanup(struct ioat2_dma_chan *ioat, unsigned long phys_complete)
 		dump_desc_dbg(ioat, desc);
 		tx = &desc->txd;
 		if (tx->cookie) {
-			chan->common.completed_cookie = tx->cookie;
+			dma_cookie_complete(tx);
 			ioat3_dma_unmap(ioat, desc, idx + i);
-			tx->cookie = 0;
 			if (tx->callback) {
 				tx->callback(tx->callback_param);
 				tx->callback = NULL;
diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index d4620c5..bff9250 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -1289,7 +1289,7 @@ static irqreturn_t idmac_interrupt(int irq, void *dev_id)
 	/* Flip the active buffer - even if update above failed */
 	ichan->active_buffer = !ichan->active_buffer;
 	if (done)
-		ichan->dma_chan.completed_cookie = desc->txd.cookie;
+		dma_cookie_complete(&desc->txd);
 
 	callback = desc->txd.callback;
 	callback_param = desc->txd.callback_param;
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 4d3b6ff..5f3492e 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -262,7 +262,7 @@ static irqreturn_t mxs_dma_int_handler(int irq, void *dev_id)
 		stat1 &= ~(1 << channel);
 
 		if (mxs_chan->status == DMA_SUCCESS)
-			mxs_chan->chan.completed_cookie = mxs_chan->desc.cookie;
+			dma_cookie_complete(&mxs_chan->desc);
 
 		/* schedule tasklet on this channel */
 		tasklet_schedule(&mxs_chan->tasklet);
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index ec9638b..76871b8 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -233,7 +233,7 @@ static void pl330_tasklet(unsigned long data)
 	/* Pick up ripe tomatoes */
 	list_for_each_entry_safe(desc, _dt, &pch->work_list, node)
 		if (desc->status == DONE) {
-			pch->chan.completed_cookie = desc->txd.cookie;
+			dma_cookie_complete(&desc->txd);
 			list_move_tail(&desc->node, &list);
 		}
 
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 23e2edc..c246375 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1347,7 +1347,7 @@ static void dma_tasklet(unsigned long data)
 		goto err;
 
 	if (!d40d->cyclic)
-		d40c->chan.completed_cookie = d40d->txd.cookie;
+		dma_cookie_complete(&d40d->txd);
 
 	/*
 	 * If terminating a channel pending_tx is set to zero.
diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index b6e83fc..1845ac9 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -285,7 +285,7 @@ static void __td_finish(struct timb_dma_chan *td_chan)
 	else
 		iowrite32(0, td_chan->membase + TIMBDMA_OFFS_TX_DLAR);
 */
-	td_chan->chan.completed_cookie = txd->cookie;
+	dma_cookie_complete(txd);
 	td_chan->ongoing = false;
 
 	callback = txd->callback;
diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index 66f8fca..8a5225b 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -411,7 +411,7 @@ txx9dmac_descriptor_complete(struct txx9dmac_chan *dc,
 	dev_vdbg(chan2dev(&dc->chan), "descriptor %u %p complete\n",
 		 txd->cookie, desc);
 
-	dc->chan.completed_cookie = txd->cookie;
+	dma_cookie_complete(txd);
 	callback = txd->callback;
 	param = txd->callback_param;
 
-- 
1.7.4.4
