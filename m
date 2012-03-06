Return-Path: <rmk+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7C2CCB700E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 09:35:00 +1100 (EST)
In-Reply-To: <20120306223321.GD15201@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Dan Williams <dan.j.williams@intel.com>,Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/9] dmaengine: move last completed cookie into generic
 dma_chan structure
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <E1S52xK-0002Mj-Af@rmk-PC.arm.linux.org.uk>
Sender: Russell King <rmk@arm.linux.org.uk>
Date: Tue, 06 Mar 2012 22:34:06 +0000
Cc: Viresh Kumar <viresh.kumar@st.com>, Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 Barry Song <baohua.song@csr.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Every DMA engine implementation declares a last completed dma cookie
in their private dma channel structures.  This is pointless, and
forces driver specific code.  Move this out into the common dma_chan
structure.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardware/iop_adma.h |    2 --
 drivers/dma/amba-pl08x.c                 |    8 ++++----
 drivers/dma/at_hdmac.c                   |   10 +++++-----
 drivers/dma/at_hdmac_regs.h              |    2 --
 drivers/dma/coh901318.c                  |    7 +++----
 drivers/dma/dw_dmac.c                    |   10 +++++-----
 drivers/dma/dw_dmac_regs.h               |    1 -
 drivers/dma/ep93xx_dma.c                 |    8 +++-----
 drivers/dma/fsldma.c                     |    4 ++--
 drivers/dma/fsldma.h                     |    1 -
 drivers/dma/imx-dma.c                    |    7 +++----
 drivers/dma/imx-sdma.c                   |    5 ++---
 drivers/dma/intel_mid_dma.c              |    9 ++++-----
 drivers/dma/intel_mid_dma_regs.h         |    2 --
 drivers/dma/ioat/dma.c                   |    2 +-
 drivers/dma/ioat/dma.h                   |    4 +---
 drivers/dma/ioat/dma_v2.c                |    2 +-
 drivers/dma/ioat/dma_v3.c                |    2 +-
 drivers/dma/iop-adma.c                   |   10 +++++-----
 drivers/dma/ipu/ipu_idmac.c              |   10 ++++------
 drivers/dma/mpc512x_dma.c                |    7 +++----
 drivers/dma/mv_xor.c                     |    6 +++---
 drivers/dma/mv_xor.h                     |    2 --
 drivers/dma/mxs-dma.c                    |    5 ++---
 drivers/dma/pch_dma.c                    |    5 ++---
 drivers/dma/pl330.c                      |    9 +++------
 drivers/dma/ppc4xx/adma.c                |   10 +++++-----
 drivers/dma/ppc4xx/adma.h                |    2 --
 drivers/dma/shdma.c                      |   10 +++++-----
 drivers/dma/shdma.h                      |    1 -
 drivers/dma/sirf-dma.c                   |    7 +++----
 drivers/dma/ste_dma40.c                  |   10 +++-------
 drivers/dma/timb_dma.c                   |    7 +++----
 drivers/dma/txx9dmac.c                   |   10 +++++-----
 drivers/dma/txx9dmac.h                   |    1 -
 include/linux/amba/pl08x.h               |    2 --
 include/linux/dmaengine.h                |    2 ++
 37 files changed, 83 insertions(+), 119 deletions(-)

diff --git a/arch/arm/include/asm/hardware/iop_adma.h b/arch/arm/include/asm/hardware/iop_adma.h
index 59b8c38..122f86d 100644
--- a/arch/arm/include/asm/hardware/iop_adma.h
+++ b/arch/arm/include/asm/hardware/iop_adma.h
@@ -49,7 +49,6 @@ struct iop_adma_device {
 /**
  * struct iop_adma_chan - internal representation of an ADMA device
  * @pending: allows batching of hardware operations
- * @completed_cookie: identifier for the most recently completed operation
  * @lock: serializes enqueue/dequeue operations to the slot pool
  * @mmr_base: memory mapped register base
  * @chain: device chain view of the descriptors
@@ -62,7 +61,6 @@ struct iop_adma_device {
  */
 struct iop_adma_chan {
 	int pending;
-	dma_cookie_t completed_cookie;
 	spinlock_t lock; /* protects the descriptor slot pool */
 	void __iomem *mmr_base;
 	struct list_head chain;
diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 8a28158..2b5121f 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -971,7 +971,7 @@ static enum dma_status pl08x_dma_tx_status(struct dma_chan *chan,
 	u32 bytesleft = 0;
 
 	last_used = plchan->chan.cookie;
-	last_complete = plchan->lc;
+	last_complete = plchan->chan.completed_cookie;
 
 	ret = dma_async_is_complete(cookie, last_complete, last_used);
 	if (ret == DMA_SUCCESS) {
@@ -983,7 +983,7 @@ static enum dma_status pl08x_dma_tx_status(struct dma_chan *chan,
 	 * This cookie not complete yet
 	 */
 	last_used = plchan->chan.cookie;
-	last_complete = plchan->lc;
+	last_complete = plchan->chan.completed_cookie;
 
 	/* Get number of bytes left in the active transactions and queue */
 	bytesleft = pl08x_getbytes_chan(plchan);
@@ -1541,7 +1541,7 @@ static void pl08x_tasklet(unsigned long data)
 
 	if (txd) {
 		/* Update last completed */
-		plchan->lc = txd->tx.cookie;
+		plchan->chan.completed_cookie = txd->tx.cookie;
 	}
 
 	/* If a new descriptor is queued, set it up plchan->at is NULL here */
@@ -1723,7 +1723,7 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 
 		chan->chan.device = dmadev;
 		chan->chan.cookie = 0;
-		chan->lc = 0;
+		chan->chan.completed_cookie = 0;
 
 		spin_lock_init(&chan->lock);
 		INIT_LIST_HEAD(&chan->pend_list);
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index f4aed5f..6baf5d7 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -269,7 +269,7 @@ atc_chain_complete(struct at_dma_chan *atchan, struct at_desc *desc)
 	dev_vdbg(chan2dev(&atchan->chan_common),
 		"descriptor %u complete\n", txd->cookie);
 
-	atchan->completed_cookie = txd->cookie;
+	atchan->chan_common.completed_cookie = txd->cookie;
 
 	/* move children to free_list */
 	list_splice_init(&desc->tx_list, &atchan->free_list);
@@ -1016,14 +1016,14 @@ atc_tx_status(struct dma_chan *chan,
 
 	spin_lock_irqsave(&atchan->lock, flags);
 
-	last_complete = atchan->completed_cookie;
+	last_complete = chan->completed_cookie;
 	last_used = chan->cookie;
 
 	ret = dma_async_is_complete(cookie, last_complete, last_used);
 	if (ret != DMA_SUCCESS) {
 		atc_cleanup_descriptors(atchan);
 
-		last_complete = atchan->completed_cookie;
+		last_complete = chan->completed_cookie;
 		last_used = chan->cookie;
 
 		ret = dma_async_is_complete(cookie, last_complete, last_used);
@@ -1129,7 +1129,7 @@ static int atc_alloc_chan_resources(struct dma_chan *chan)
 	spin_lock_irqsave(&atchan->lock, flags);
 	atchan->descs_allocated = i;
 	list_splice(&tmp_list, &atchan->free_list);
-	atchan->completed_cookie = chan->cookie = 1;
+	chan->completed_cookie = chan->cookie = 1;
 	spin_unlock_irqrestore(&atchan->lock, flags);
 
 	/* channel parameters */
@@ -1329,7 +1329,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 		struct at_dma_chan	*atchan = &atdma->chan[i];
 
 		atchan->chan_common.device = &atdma->dma_common;
-		atchan->chan_common.cookie = atchan->completed_cookie = 1;
+		atchan->chan_common.cookie = atchan->chan_common.completed_cookie = 1;
 		list_add_tail(&atchan->chan_common.device_node,
 				&atdma->dma_common.channels);
 
diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index a8d3277..08fd8a0 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -208,7 +208,6 @@ enum atc_status {
  * @save_dscr: for cyclic operations, preserve next descriptor address in
  *             the cyclic list on suspend/resume cycle
  * @lock: serializes enqueue/dequeue operations to descriptors lists
- * @completed_cookie: identifier for the most recently completed operation
  * @active_list: list of descriptors dmaengine is being running on
  * @queue: list of descriptors ready to be submitted to engine
  * @free_list: list of descriptors usable by the channel
@@ -227,7 +226,6 @@ struct at_dma_chan {
 	spinlock_t		lock;
 
 	/* these other elements are all protected by lock */
-	dma_cookie_t		completed_cookie;
 	struct list_head	active_list;
 	struct list_head	queue;
 	struct list_head	free_list;
diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index d65a718..521434b 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -59,7 +59,6 @@ struct coh901318_base {
 struct coh901318_chan {
 	spinlock_t lock;
 	int allocated;
-	int completed;
 	int id;
 	int stopped;
 
@@ -705,7 +704,7 @@ static void dma_tasklet(unsigned long data)
 	callback_param = cohd_fin->desc.callback_param;
 
 	/* sign this job as completed on the channel */
-	cohc->completed = cohd_fin->desc.cookie;
+	cohc->chan.completed_cookie = cohd_fin->desc.cookie;
 
 	/* release the lli allocation and remove the descriptor */
 	coh901318_lli_free(&cohc->base->pool, &cohd_fin->lli);
@@ -929,7 +928,7 @@ static int coh901318_alloc_chan_resources(struct dma_chan *chan)
 	coh901318_config(cohc, NULL);
 
 	cohc->allocated = 1;
-	cohc->completed = chan->cookie = 1;
+	chan->completed_cookie = chan->cookie = 1;
 
 	spin_unlock_irqrestore(&cohc->lock, flags);
 
@@ -1169,7 +1168,7 @@ coh901318_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	dma_cookie_t last_complete;
 	int ret;
 
-	last_complete = cohc->completed;
+	last_complete = chan->completed_cookie;
 	last_used = chan->cookie;
 
 	ret = dma_async_is_complete(cookie, last_complete, last_used);
diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 9b592b0..defe574 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -245,7 +245,7 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
 	dev_vdbg(chan2dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dwc->completed = txd->cookie;
+	dwc->chan.completed_cookie = txd->cookie;
 	if (callback_required) {
 		callback = txd->callback;
 		param = txd->callback_param;
@@ -955,14 +955,14 @@ dwc_tx_status(struct dma_chan *chan,
 	dma_cookie_t		last_complete;
 	int			ret;
 
-	last_complete = dwc->completed;
+	last_complete = chan->completed_cookie;
 	last_used = chan->cookie;
 
 	ret = dma_async_is_complete(cookie, last_complete, last_used);
 	if (ret != DMA_SUCCESS) {
 		dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
 
-		last_complete = dwc->completed;
+		last_complete = chan->completed_cookie;
 		last_used = chan->cookie;
 
 		ret = dma_async_is_complete(cookie, last_complete, last_used);
@@ -1004,7 +1004,7 @@ static int dwc_alloc_chan_resources(struct dma_chan *chan)
 		return -EIO;
 	}
 
-	dwc->completed = chan->cookie = 1;
+	chan->completed_cookie = chan->cookie = 1;
 
 	/*
 	 * NOTE: some controllers may have additional features that we
@@ -1423,7 +1423,7 @@ static int __init dw_probe(struct platform_device *pdev)
 		struct dw_dma_chan	*dwc = &dw->chan[i];
 
 		dwc->chan.device = &dw->dma;
-		dwc->chan.cookie = dwc->completed = 1;
+		dwc->chan.cookie = dwc->chan.completed_cookie = 1;
 		if (pdata->chan_allocation_order == CHAN_ALLOCATION_ASCENDING)
 			list_add_tail(&dwc->chan.device_node,
 					&dw->dma.channels);
diff --git a/drivers/dma/dw_dmac_regs.h b/drivers/dma/dw_dmac_regs.h
index 5eef694..cce1752 100644
--- a/drivers/dma/dw_dmac_regs.h
+++ b/drivers/dma/dw_dmac_regs.h
@@ -146,7 +146,6 @@ struct dw_dma_chan {
 
 	/* these other elements are all protected by lock */
 	unsigned long		flags;
-	dma_cookie_t		completed;
 	struct list_head	active_list;
 	struct list_head	queue;
 	struct list_head	free_list;
diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 59e7a96..bc45787 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -122,7 +122,6 @@ struct ep93xx_dma_desc {
  * @lock: lock protecting the fields following
  * @flags: flags for the channel
  * @buffer: which buffer to use next (0/1)
- * @last_completed: last completed cookie value
  * @active: flattened chain of descriptors currently being processed
  * @queue: pending descriptors which are handled next
  * @free_list: list of free descriptors which can be used
@@ -157,7 +156,6 @@ struct ep93xx_dma_chan {
 #define EP93XX_DMA_IS_CYCLIC		0
 
 	int				buffer;
-	dma_cookie_t			last_completed;
 	struct list_head		active;
 	struct list_head		queue;
 	struct list_head		free_list;
@@ -703,7 +701,7 @@ static void ep93xx_dma_tasklet(unsigned long data)
 	desc = ep93xx_dma_get_active(edmac);
 	if (desc) {
 		if (desc->complete) {
-			edmac->last_completed = desc->txd.cookie;
+			edmac->chan.completed_cookie = desc->txd.cookie;
 			list_splice_init(&edmac->active, &list);
 		}
 		callback = desc->txd.callback;
@@ -861,7 +859,7 @@ static int ep93xx_dma_alloc_chan_resources(struct dma_chan *chan)
 		goto fail_clk_disable;
 
 	spin_lock_irq(&edmac->lock);
-	edmac->last_completed = 1;
+	edmac->chan.completed_cookie = 1;
 	edmac->chan.cookie = 1;
 	ret = edmac->edma->hw_setup(edmac);
 	spin_unlock_irq(&edmac->lock);
@@ -1254,7 +1252,7 @@ static enum dma_status ep93xx_dma_tx_status(struct dma_chan *chan,
 
 	spin_lock_irqsave(&edmac->lock, flags);
 	last_used = chan->cookie;
-	last_completed = edmac->last_completed;
+	last_completed = chan->completed_cookie;
 	spin_unlock_irqrestore(&edmac->lock, flags);
 
 	ret = dma_async_is_complete(cookie, last_completed, last_used);
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index b98070c..9b5cb8a 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -990,7 +990,7 @@ static enum dma_status fsl_tx_status(struct dma_chan *dchan,
 
 	spin_lock_irqsave(&chan->desc_lock, flags);
 
-	last_complete = chan->completed_cookie;
+	last_complete = dchan->completed_cookie;
 	last_used = dchan->cookie;
 
 	spin_unlock_irqrestore(&chan->desc_lock, flags);
@@ -1088,7 +1088,7 @@ static void dma_do_tasklet(unsigned long data)
 		desc = to_fsl_desc(chan->ld_running.prev);
 		cookie = desc->async_tx.cookie;
 
-		chan->completed_cookie = cookie;
+		chan->common.completed_cookie = cookie;
 		chan_dbg(chan, "completed_cookie=%d\n", cookie);
 	}
 
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 9cb5aa5..f5c3879 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -137,7 +137,6 @@ struct fsldma_device {
 struct fsldma_chan {
 	char name[8];			/* Channel name */
 	struct fsldma_chan_regs __iomem *regs;
-	dma_cookie_t completed_cookie;	/* The maximum cookie completed */
 	spinlock_t desc_lock;		/* Descriptor operation lock */
 	struct list_head ld_pending;	/* Link descriptors queue */
 	struct list_head ld_running;	/* Link descriptors queue */
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index e4383ee..321fc1f 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -41,7 +41,6 @@ struct imxdma_channel {
 	struct dma_chan			chan;
 	spinlock_t			lock;
 	struct dma_async_tx_descriptor	desc;
-	dma_cookie_t			last_completed;
 	enum dma_status			status;
 	int				dma_request;
 	struct scatterlist		*sg_list;
@@ -65,7 +64,7 @@ static void imxdma_handle(struct imxdma_channel *imxdmac)
 {
 	if (imxdmac->desc.callback)
 		imxdmac->desc.callback(imxdmac->desc.callback_param);
-	imxdmac->last_completed = imxdmac->desc.cookie;
+	imxdmac->chan.completed_cookie = imxdmac->desc.cookie;
 }
 
 static void imxdma_irq_handler(int channel, void *data)
@@ -158,8 +157,8 @@ static enum dma_status imxdma_tx_status(struct dma_chan *chan,
 
 	last_used = chan->cookie;
 
-	ret = dma_async_is_complete(cookie, imxdmac->last_completed, last_used);
-	dma_set_tx_state(txstate, imxdmac->last_completed, last_used, 0);
+	ret = dma_async_is_complete(cookie, chan->completed_cookie, last_used);
+	dma_set_tx_state(txstate, chan->completed_cookie, last_used, 0);
 
 	return ret;
 }
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 8bc5acf..e857904 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -266,7 +266,6 @@ struct sdma_channel {
 	struct dma_chan			chan;
 	spinlock_t			lock;
 	struct dma_async_tx_descriptor	desc;
-	dma_cookie_t			last_completed;
 	enum dma_status			status;
 	unsigned int			chn_count;
 	unsigned int			chn_real_count;
@@ -523,7 +522,7 @@ static void mxc_sdma_handle_channel_normal(struct sdma_channel *sdmac)
 	else
 		sdmac->status = DMA_SUCCESS;
 
-	sdmac->last_completed = sdmac->desc.cookie;
+	sdmac->chan.completed_cookie = sdmac->desc.cookie;
 	if (sdmac->desc.callback)
 		sdmac->desc.callback(sdmac->desc.callback_param);
 }
@@ -1129,7 +1128,7 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 
 	last_used = chan->cookie;
 
-	dma_set_tx_state(txstate, sdmac->last_completed, last_used,
+	dma_set_tx_state(txstate, chan->completed_cookie, last_used,
 			sdmac->chn_count - sdmac->chn_real_count);
 
 	return sdmac->status;
diff --git a/drivers/dma/intel_mid_dma.c b/drivers/dma/intel_mid_dma.c
index 74f70aa..a27ae45 100644
--- a/drivers/dma/intel_mid_dma.c
+++ b/drivers/dma/intel_mid_dma.c
@@ -288,7 +288,7 @@ static void midc_descriptor_complete(struct intel_mid_dma_chan *midc,
 	struct intel_mid_dma_lli	*llitem;
 	void *param_txd = NULL;
 
-	midc->completed = txd->cookie;
+	midc->chan.completed_cookie = txd->cookie;
 	callback_txd = txd->callback;
 	param_txd = txd->callback_param;
 
@@ -482,12 +482,11 @@ static enum dma_status intel_mid_dma_tx_status(struct dma_chan *chan,
 						dma_cookie_t cookie,
 						struct dma_tx_state *txstate)
 {
-	struct intel_mid_dma_chan	*midc = to_intel_mid_dma_chan(chan);
 	dma_cookie_t		last_used;
 	dma_cookie_t		last_complete;
 	int				ret;
 
-	last_complete = midc->completed;
+	last_complete = chan->completed_cookie;
 	last_used = chan->cookie;
 
 	ret = dma_async_is_complete(cookie, last_complete, last_used);
@@ -496,7 +495,7 @@ static enum dma_status intel_mid_dma_tx_status(struct dma_chan *chan,
 		midc_scan_descriptors(to_middma_device(chan->device), midc);
 		spin_unlock_bh(&midc->lock);
 
-		last_complete = midc->completed;
+		last_complete = chan->completed_cookie;
 		last_used = chan->cookie;
 
 		ret = dma_async_is_complete(cookie, last_complete, last_used);
@@ -886,7 +885,7 @@ static int intel_mid_dma_alloc_chan_resources(struct dma_chan *chan)
 		pm_runtime_put(&mid->pdev->dev);
 		return -EIO;
 	}
-	midc->completed = chan->cookie = 1;
+	chan->completed_cookie = chan->cookie = 1;
 
 	spin_lock_bh(&midc->lock);
 	while (midc->descs_allocated < DESCS_PER_CHANNEL) {
diff --git a/drivers/dma/intel_mid_dma_regs.h b/drivers/dma/intel_mid_dma_regs.h
index c83d35b..1bfa926 100644
--- a/drivers/dma/intel_mid_dma_regs.h
+++ b/drivers/dma/intel_mid_dma_regs.h
@@ -165,7 +165,6 @@ union intel_mid_dma_cfg_hi {
  * @dma_base: MMIO register space DMA engine base pointer
  * @ch_id: DMA channel id
  * @lock: channel spinlock
- * @completed: DMA cookie
  * @active_list: current active descriptors
  * @queue: current queued up descriptors
  * @free_list: current free descriptors
@@ -183,7 +182,6 @@ struct intel_mid_dma_chan {
 	void __iomem		*dma_base;
 	int			ch_id;
 	spinlock_t		lock;
-	dma_cookie_t		completed;
 	struct list_head	active_list;
 	struct list_head	queue;
 	struct list_head	free_list;
diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index a4d6cb0..fab440a 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -603,7 +603,7 @@ static void __cleanup(struct ioat_dma_chan *ioat, unsigned long phys_complete)
 		 */
 		dump_desc_dbg(ioat, desc);
 		if (tx->cookie) {
-			chan->completed_cookie = tx->cookie;
+			chan->common.completed_cookie = tx->cookie;
 			tx->cookie = 0;
 			ioat_dma_unmap(chan, tx->flags, desc->len, desc->hw);
 			ioat->active -= desc->hw->tx_cnt;
diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index 5216c8a..9653b6b 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -90,7 +90,6 @@ struct ioat_chan_common {
 	void __iomem *reg_base;
 	unsigned long last_completion;
 	spinlock_t cleanup_lock;
-	dma_cookie_t completed_cookie;
 	unsigned long state;
 	#define IOAT_COMPLETION_PENDING 0
 	#define IOAT_COMPLETION_ACK 1
@@ -153,12 +152,11 @@ static inline enum dma_status
 ioat_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 		 struct dma_tx_state *txstate)
 {
-	struct ioat_chan_common *chan = to_chan_common(c);
 	dma_cookie_t last_used;
 	dma_cookie_t last_complete;
 
 	last_used = c->cookie;
-	last_complete = chan->completed_cookie;
+	last_complete = c->completed_cookie;
 
 	dma_set_tx_state(txstate, last_complete, last_used, 0);
 
diff --git a/drivers/dma/ioat/dma_v2.c b/drivers/dma/ioat/dma_v2.c
index 5d65f83..d3f0aff 100644
--- a/drivers/dma/ioat/dma_v2.c
+++ b/drivers/dma/ioat/dma_v2.c
@@ -147,7 +147,7 @@ static void __cleanup(struct ioat2_dma_chan *ioat, unsigned long phys_complete)
 		dump_desc_dbg(ioat, desc);
 		if (tx->cookie) {
 			ioat_dma_unmap(chan, tx->flags, desc->len, desc->hw);
-			chan->completed_cookie = tx->cookie;
+			chan->common.completed_cookie = tx->cookie;
 			tx->cookie = 0;
 			if (tx->callback) {
 				tx->callback(tx->callback_param);
diff --git a/drivers/dma/ioat/dma_v3.c b/drivers/dma/ioat/dma_v3.c
index f519c93..d4afac7 100644
--- a/drivers/dma/ioat/dma_v3.c
+++ b/drivers/dma/ioat/dma_v3.c
@@ -277,7 +277,7 @@ static void __cleanup(struct ioat2_dma_chan *ioat, unsigned long phys_complete)
 		dump_desc_dbg(ioat, desc);
 		tx = &desc->txd;
 		if (tx->cookie) {
-			chan->completed_cookie = tx->cookie;
+			chan->common.completed_cookie = tx->cookie;
 			ioat3_dma_unmap(ioat, desc, idx + i);
 			tx->cookie = 0;
 			if (tx->callback) {
diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 04be90b..d8027c2 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -317,7 +317,7 @@ static void __iop_adma_slot_cleanup(struct iop_adma_chan *iop_chan)
 	}
 
 	if (cookie > 0) {
-		iop_chan->completed_cookie = cookie;
+		iop_chan->common.completed_cookie = cookie;
 		pr_debug("\tcompleted cookie %d\n", cookie);
 	}
 }
@@ -909,7 +909,7 @@ static enum dma_status iop_adma_status(struct dma_chan *chan,
 	enum dma_status ret;
 
 	last_used = chan->cookie;
-	last_complete = iop_chan->completed_cookie;
+	last_complete = chan->completed_cookie;
 	dma_set_tx_state(txstate, last_complete, last_used, 0);
 	ret = dma_async_is_complete(cookie, last_complete, last_used);
 	if (ret == DMA_SUCCESS)
@@ -918,7 +918,7 @@ static enum dma_status iop_adma_status(struct dma_chan *chan,
 	iop_adma_slot_cleanup(iop_chan);
 
 	last_used = chan->cookie;
-	last_complete = iop_chan->completed_cookie;
+	last_complete = chan->completed_cookie;
 	dma_set_tx_state(txstate, last_complete, last_used, 0);
 
 	return dma_async_is_complete(cookie, last_complete, last_used);
@@ -1650,7 +1650,7 @@ static void iop_chan_start_null_memcpy(struct iop_adma_chan *iop_chan)
 		/* initialize the completed cookie to be less than
 		 * the most recently used cookie
 		 */
-		iop_chan->completed_cookie = cookie - 1;
+		iop_chan->common.completed_cookie = cookie - 1;
 		iop_chan->common.cookie = sw_desc->async_tx.cookie = cookie;
 
 		/* channel should not be busy */
@@ -1707,7 +1707,7 @@ static void iop_chan_start_null_xor(struct iop_adma_chan *iop_chan)
 		/* initialize the completed cookie to be less than
 		 * the most recently used cookie
 		 */
-		iop_chan->completed_cookie = cookie - 1;
+		iop_chan->common.completed_cookie = cookie - 1;
 		iop_chan->common.cookie = sw_desc->async_tx.cookie = cookie;
 
 		/* channel should not be busy */
diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index 6212b16..9149ade 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -1295,7 +1295,7 @@ static irqreturn_t idmac_interrupt(int irq, void *dev_id)
 	/* Flip the active buffer - even if update above failed */
 	ichan->active_buffer = !ichan->active_buffer;
 	if (done)
-		ichan->completed = desc->txd.cookie;
+		ichan->dma_chan.completed_cookie = desc->txd.cookie;
 
 	callback = desc->txd.callback;
 	callback_param = desc->txd.callback_param;
@@ -1511,7 +1511,7 @@ static int idmac_alloc_chan_resources(struct dma_chan *chan)
 	WARN_ON(ichan->status != IPU_CHANNEL_FREE);
 
 	chan->cookie		= 1;
-	ichan->completed	= -ENXIO;
+	chan->completed_cookie	= -ENXIO;
 
 	ret = ipu_irq_map(chan->chan_id);
 	if (ret < 0)
@@ -1600,9 +1600,7 @@ static void idmac_free_chan_resources(struct dma_chan *chan)
 static enum dma_status idmac_tx_status(struct dma_chan *chan,
 		       dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
-	struct idmac_channel *ichan = to_idmac_chan(chan);
-
-	dma_set_tx_state(txstate, ichan->completed, chan->cookie, 0);
+	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie, 0);
 	if (cookie != chan->cookie)
 		return DMA_ERROR;
 	return DMA_SUCCESS;
@@ -1638,11 +1636,11 @@ static int __init ipu_idmac_init(struct ipu *ipu)
 
 		ichan->status		= IPU_CHANNEL_FREE;
 		ichan->sec_chan_en	= false;
-		ichan->completed	= -ENXIO;
 		snprintf(ichan->eof_name, sizeof(ichan->eof_name), "IDMAC EOF %d", i);
 
 		dma_chan->device	= &idmac->dma;
 		dma_chan->cookie	= 1;
+		dma_chan->completed_cookie	= -ENXIO;
 		dma_chan->chan_id	= i;
 		list_add_tail(&dma_chan->device_node, &dma->channels);
 	}
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 4d6d4cf..39a5cde 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -188,7 +188,6 @@ struct mpc_dma_chan {
 	struct list_head		completed;
 	struct mpc_dma_tcd		*tcd;
 	dma_addr_t			tcd_paddr;
-	dma_cookie_t			completed_cookie;
 
 	/* Lock for this structure */
 	spinlock_t			lock;
@@ -365,7 +364,7 @@ static void mpc_dma_process_completed(struct mpc_dma *mdma)
 		/* Free descriptors */
 		spin_lock_irqsave(&mchan->lock, flags);
 		list_splice_tail_init(&list, &mchan->free);
-		mchan->completed_cookie = last_cookie;
+		mchan->chan.completed_cookie = last_cookie;
 		spin_unlock_irqrestore(&mchan->lock, flags);
 	}
 }
@@ -568,7 +567,7 @@ mpc_dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 
 	spin_lock_irqsave(&mchan->lock, flags);
 	last_used = mchan->chan.cookie;
-	last_complete = mchan->completed_cookie;
+	last_complete = mchan->chan.completed_cookie;
 	spin_unlock_irqrestore(&mchan->lock, flags);
 
 	dma_set_tx_state(txstate, last_complete, last_used, 0);
@@ -742,7 +741,7 @@ static int __devinit mpc_dma_probe(struct platform_device *op)
 
 		mchan->chan.device = dma;
 		mchan->chan.cookie = 1;
-		mchan->completed_cookie = mchan->chan.cookie;
+		mchan->chan.completed_cookie = mchan->chan.cookie;
 
 		INIT_LIST_HEAD(&mchan->free);
 		INIT_LIST_HEAD(&mchan->prepared);
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index ad7d03f..c6a84da 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -435,7 +435,7 @@ static void __mv_xor_slot_cleanup(struct mv_xor_chan *mv_chan)
 	}
 
 	if (cookie > 0)
-		mv_chan->completed_cookie = cookie;
+		mv_chan->common.completed_cookie = cookie;
 }
 
 static void
@@ -825,7 +825,7 @@ static enum dma_status mv_xor_status(struct dma_chan *chan,
 	enum dma_status ret;
 
 	last_used = chan->cookie;
-	last_complete = mv_chan->completed_cookie;
+	last_complete = chan->completed_cookie;
 	dma_set_tx_state(txstate, last_complete, last_used, 0);
 
 	ret = dma_async_is_complete(cookie, last_complete, last_used);
@@ -836,7 +836,7 @@ static enum dma_status mv_xor_status(struct dma_chan *chan,
 	mv_xor_slot_cleanup(mv_chan);
 
 	last_used = chan->cookie;
-	last_complete = mv_chan->completed_cookie;
+	last_complete = chan->completed_cookie;
 
 	dma_set_tx_state(txstate, last_complete, last_used, 0);
 	return dma_async_is_complete(cookie, last_complete, last_used);
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index da04ac2..654876b 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -78,7 +78,6 @@ struct mv_xor_device {
 /**
  * struct mv_xor_chan - internal representation of a XOR channel
  * @pending: allows batching of hardware operations
- * @completed_cookie: identifier for the most recently completed operation
  * @lock: serializes enqueue/dequeue operations to the descriptors pool
  * @mmr_base: memory mapped register base
  * @idx: the index of the xor channel
@@ -93,7 +92,6 @@ struct mv_xor_device {
  */
 struct mv_xor_chan {
 	int			pending;
-	dma_cookie_t		completed_cookie;
 	spinlock_t		lock; /* protects the descriptor slot pool */
 	void __iomem		*mmr_base;
 	unsigned int		idx;
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index b06cd4c..3696e6e 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -111,7 +111,6 @@ struct mxs_dma_chan {
 	struct mxs_dma_ccw		*ccw;
 	dma_addr_t			ccw_phys;
 	int				desc_count;
-	dma_cookie_t			last_completed;
 	enum dma_status			status;
 	unsigned int			flags;
 #define MXS_DMA_SG_LOOP			(1 << 0)
@@ -274,7 +273,7 @@ static irqreturn_t mxs_dma_int_handler(int irq, void *dev_id)
 		stat1 &= ~(1 << channel);
 
 		if (mxs_chan->status == DMA_SUCCESS)
-			mxs_chan->last_completed = mxs_chan->desc.cookie;
+			mxs_chan->chan.completed_cookie = mxs_chan->desc.cookie;
 
 		/* schedule tasklet on this channel */
 		tasklet_schedule(&mxs_chan->tasklet);
@@ -538,7 +537,7 @@ static enum dma_status mxs_dma_tx_status(struct dma_chan *chan,
 	dma_cookie_t last_used;
 
 	last_used = chan->cookie;
-	dma_set_tx_state(txstate, mxs_chan->last_completed, last_used, 0);
+	dma_set_tx_state(txstate, chan->completed_cookie, last_used, 0);
 
 	return mxs_chan->status;
 }
diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index 823f581..79a7185 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -105,7 +105,6 @@ struct pch_dma_chan {
 
 	spinlock_t		lock;
 
-	dma_cookie_t		completed_cookie;
 	struct list_head	active_list;
 	struct list_head	queue;
 	struct list_head	free_list;
@@ -544,7 +543,7 @@ static int pd_alloc_chan_resources(struct dma_chan *chan)
 	spin_lock_irq(&pd_chan->lock);
 	list_splice(&tmp_list, &pd_chan->free_list);
 	pd_chan->descs_allocated = i;
-	pd_chan->completed_cookie = chan->cookie = 1;
+	chan->completed_cookie = chan->cookie = 1;
 	spin_unlock_irq(&pd_chan->lock);
 
 	pdc_enable_irq(chan, 1);
@@ -583,7 +582,7 @@ static enum dma_status pd_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	int ret;
 
 	spin_lock_irq(&pd_chan->lock);
-	last_completed = pd_chan->completed_cookie;
+	last_completed = chan->completed_cookie;
 	last_used = chan->cookie;
 	spin_unlock_irq(&pd_chan->lock);
 
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index b8ec03e..bdf04f1 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -51,9 +51,6 @@ struct dma_pl330_chan {
 	/* DMA-Engine Channel */
 	struct dma_chan chan;
 
-	/* Last completed cookie */
-	dma_cookie_t completed;
-
 	/* List of to be xfered descriptors */
 	struct list_head work_list;
 
@@ -234,7 +231,7 @@ static void pl330_tasklet(unsigned long data)
 	/* Pick up ripe tomatoes */
 	list_for_each_entry_safe(desc, _dt, &pch->work_list, node)
 		if (desc->status == DONE) {
-			pch->completed = desc->txd.cookie;
+			pch->chan.completed_cookie = desc->txd.cookie;
 			list_move_tail(&desc->node, &list);
 		}
 
@@ -305,7 +302,7 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
 
 	spin_lock_irqsave(&pch->lock, flags);
 
-	pch->completed = chan->cookie = 1;
+	chan->completed_cookie = chan->cookie = 1;
 	pch->cyclic = false;
 
 	pch->pl330_chid = pl330_request_channel(&pdmac->pif);
@@ -400,7 +397,7 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	dma_cookie_t last_done, last_used;
 	int ret;
 
-	last_done = pch->completed;
+	last_done = chan->completed_cookie;
 	last_used = chan->cookie;
 
 	ret = dma_async_is_complete(cookie, last_done, last_used);
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index fc457a7..f878322 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -1930,7 +1930,7 @@ static void __ppc440spe_adma_slot_cleanup(struct ppc440spe_adma_chan *chan)
 				if (end_of_chain && slot_cnt) {
 					/* Should wait for ZeroSum completion */
 					if (cookie > 0)
-						chan->completed_cookie = cookie;
+						chan->common.completed_cookie = cookie;
 					return;
 				}
 
@@ -1960,7 +1960,7 @@ static void __ppc440spe_adma_slot_cleanup(struct ppc440spe_adma_chan *chan)
 	BUG_ON(!seen_current);
 
 	if (cookie > 0) {
-		chan->completed_cookie = cookie;
+		chan->common.completed_cookie = cookie;
 		pr_debug("\tcompleted cookie %d\n", cookie);
 	}
 
@@ -3950,7 +3950,7 @@ static enum dma_status ppc440spe_adma_tx_status(struct dma_chan *chan,
 
 	ppc440spe_chan = to_ppc440spe_adma_chan(chan);
 	last_used = chan->cookie;
-	last_complete = ppc440spe_chan->completed_cookie;
+	last_complete = chan->completed_cookie;
 
 	dma_set_tx_state(txstate, last_complete, last_used, 0);
 
@@ -3961,7 +3961,7 @@ static enum dma_status ppc440spe_adma_tx_status(struct dma_chan *chan,
 	ppc440spe_adma_slot_cleanup(ppc440spe_chan);
 
 	last_used = chan->cookie;
-	last_complete = ppc440spe_chan->completed_cookie;
+	last_complete = chan->completed_cookie;
 
 	dma_set_tx_state(txstate, last_complete, last_used, 0);
 
@@ -4058,7 +4058,7 @@ static void ppc440spe_chan_start_null_xor(struct ppc440spe_adma_chan *chan)
 		/* initialize the completed cookie to be less than
 		 * the most recently used cookie
 		 */
-		chan->completed_cookie = cookie - 1;
+		chan->common.completed_cookie = cookie - 1;
 		chan->common.cookie = sw_desc->async_tx.cookie = cookie;
 
 		/* channel should not be busy */
diff --git a/drivers/dma/ppc4xx/adma.h b/drivers/dma/ppc4xx/adma.h
index 8ada5a8..26b7a5e 100644
--- a/drivers/dma/ppc4xx/adma.h
+++ b/drivers/dma/ppc4xx/adma.h
@@ -81,7 +81,6 @@ struct ppc440spe_adma_device {
  * @common: common dmaengine channel object members
  * @all_slots: complete domain of slots usable by the channel
  * @pending: allows batching of hardware operations
- * @completed_cookie: identifier for the most recently completed operation
  * @slots_allocated: records the actual size of the descriptor slot pool
  * @hw_chain_inited: h/w descriptor chain initialization flag
  * @irq_tasklet: bottom half where ppc440spe_adma_slot_cleanup runs
@@ -99,7 +98,6 @@ struct ppc440spe_adma_chan {
 	struct list_head all_slots;
 	struct ppc440spe_adma_desc_slot *last_used;
 	int pending;
-	dma_cookie_t completed_cookie;
 	int slots_allocated;
 	int hw_chain_inited;
 	struct tasklet_struct irq_tasklet;
diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 812fd76..ae84c12 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -764,12 +764,12 @@ static dma_async_tx_callback __ld_cleanup(struct sh_dmae_chan *sh_chan, bool all
 			cookie = tx->cookie;
 
 		if (desc->mark == DESC_COMPLETED && desc->chunks == 1) {
-			if (sh_chan->completed_cookie != desc->cookie - 1)
+			if (sh_chan->common.completed_cookie != desc->cookie - 1)
 				dev_dbg(sh_chan->dev,
 					"Completing cookie %d, expected %d\n",
 					desc->cookie,
-					sh_chan->completed_cookie + 1);
-			sh_chan->completed_cookie = desc->cookie;
+					sh_chan->common.completed_cookie + 1);
+			sh_chan->common.completed_cookie = desc->cookie;
 		}
 
 		/* Call callback on the last chunk */
@@ -823,7 +823,7 @@ static dma_async_tx_callback __ld_cleanup(struct sh_dmae_chan *sh_chan, bool all
 		 * Terminating and the loop completed normally: forgive
 		 * uncompleted cookies
 		 */
-		sh_chan->completed_cookie = sh_chan->common.cookie;
+		sh_chan->common.completed_cookie = sh_chan->common.cookie;
 
 	spin_unlock_irqrestore(&sh_chan->desc_lock, flags);
 
@@ -891,7 +891,7 @@ static enum dma_status sh_dmae_tx_status(struct dma_chan *chan,
 	sh_dmae_chan_ld_cleanup(sh_chan, false);
 
 	/* First read completed cookie to avoid a skew */
-	last_complete = sh_chan->completed_cookie;
+	last_complete = chan->completed_cookie;
 	rmb();
 	last_used = chan->cookie;
 	BUG_ON(last_complete < 0);
diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h
index 2b55a27..0b1d2c1 100644
--- a/drivers/dma/shdma.h
+++ b/drivers/dma/shdma.h
@@ -30,7 +30,6 @@ enum dmae_pm_state {
 };
 
 struct sh_dmae_chan {
-	dma_cookie_t completed_cookie;	/* The maximum cookie completed */
 	spinlock_t desc_lock;		/* Descriptor operation lock */
 	struct list_head ld_queue;	/* Link descriptors queue */
 	struct list_head ld_free;	/* Link descriptors free */
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 2333810..60473f0 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -59,7 +59,6 @@ struct sirfsoc_dma_chan {
 	struct list_head		queued;
 	struct list_head		active;
 	struct list_head		completed;
-	dma_cookie_t			completed_cookie;
 	unsigned long			happened_cyclic;
 	unsigned long			completed_cyclic;
 
@@ -208,7 +207,7 @@ static void sirfsoc_dma_process_completed(struct sirfsoc_dma *sdma)
 			/* Free descriptors */
 			spin_lock_irqsave(&schan->lock, flags);
 			list_splice_tail_init(&list, &schan->free);
-			schan->completed_cookie = last_cookie;
+			schan->chan.completed_cookie = last_cookie;
 			spin_unlock_irqrestore(&schan->lock, flags);
 		} else {
 			/* for cyclic channel, desc is always in active list */
@@ -419,7 +418,7 @@ sirfsoc_dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 
 	spin_lock_irqsave(&schan->lock, flags);
 	last_used = schan->chan.cookie;
-	last_complete = schan->completed_cookie;
+	last_complete = schan->chan.completed_cookie;
 	spin_unlock_irqrestore(&schan->lock, flags);
 
 	dma_set_tx_state(txstate, last_complete, last_used, 0);
@@ -636,7 +635,7 @@ static int __devinit sirfsoc_dma_probe(struct platform_device *op)
 
 		schan->chan.device = dma;
 		schan->chan.cookie = 1;
-		schan->completed_cookie = schan->chan.cookie;
+		schan->chan.completed_cookie = schan->chan.cookie;
 
 		INIT_LIST_HEAD(&schan->free);
 		INIT_LIST_HEAD(&schan->prepared);
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index cc5ecbc..cfca2a0 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -220,8 +220,6 @@ struct d40_base;
  *
  * @lock: A spinlock to protect this struct.
  * @log_num: The logical number, if any of this channel.
- * @completed: Starts with 1, after first interrupt it is set to dma engine's
- * current cookie.
  * @pending_tx: The number of pending transfers. Used between interrupt handler
  * and tasklet.
  * @busy: Set to true when transfer is ongoing on this channel.
@@ -250,8 +248,6 @@ struct d40_base;
 struct d40_chan {
 	spinlock_t			 lock;
 	int				 log_num;
-	/* ID of the most recent completed transfer */
-	int				 completed;
 	int				 pending_tx;
 	bool				 busy;
 	struct d40_phy_res		*phy_chan;
@@ -1357,7 +1353,7 @@ static void dma_tasklet(unsigned long data)
 		goto err;
 
 	if (!d40d->cyclic)
-		d40c->completed = d40d->txd.cookie;
+		d40c->chan.completed_cookie = d40d->txd.cookie;
 
 	/*
 	 * If terminating a channel pending_tx is set to zero.
@@ -2182,7 +2178,7 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
 	bool is_free_phy;
 	spin_lock_irqsave(&d40c->lock, flags);
 
-	d40c->completed = chan->cookie = 1;
+	chan->completed_cookie = chan->cookie = 1;
 
 	/* If no dma configuration is set use default configuration (memcpy) */
 	if (!d40c->configured) {
@@ -2351,7 +2347,7 @@ static enum dma_status d40_tx_status(struct dma_chan *chan,
 		return -EINVAL;
 	}
 
-	last_complete = d40c->completed;
+	last_complete = chan->completed_cookie;
 	last_used = chan->cookie;
 
 	if (d40_is_paused(d40c))
diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index a6f9c16..a1d1559 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -84,7 +84,6 @@ struct timb_dma_chan {
 					especially the lists and descriptors,
 					from races between the tasklet and calls
 					from above */
-	dma_cookie_t		last_completed_cookie;
 	bool			ongoing;
 	struct list_head	active_list;
 	struct list_head	queue;
@@ -284,7 +283,7 @@ static void __td_finish(struct timb_dma_chan *td_chan)
 	else
 		iowrite32(0, td_chan->membase + TIMBDMA_OFFS_TX_DLAR);
 */
-	td_chan->last_completed_cookie = txd->cookie;
+	td_chan->chan.completed_cookie = txd->cookie;
 	td_chan->ongoing = false;
 
 	callback = txd->callback;
@@ -481,7 +480,7 @@ static int td_alloc_chan_resources(struct dma_chan *chan)
 	}
 
 	spin_lock_bh(&td_chan->lock);
-	td_chan->last_completed_cookie = 1;
+	chan->completed_cookie = 1;
 	chan->cookie = 1;
 	spin_unlock_bh(&td_chan->lock);
 
@@ -523,7 +522,7 @@ static enum dma_status td_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 
 	dev_dbg(chan2dev(chan), "%s: Entry\n", __func__);
 
-	last_complete = td_chan->last_completed_cookie;
+	last_complete = chan->completed_cookie;
 	last_used = chan->cookie;
 
 	ret = dma_async_is_complete(cookie, last_complete, last_used);
diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index 6122c36..a917b67 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -424,7 +424,7 @@ txx9dmac_descriptor_complete(struct txx9dmac_chan *dc,
 	dev_vdbg(chan2dev(&dc->chan), "descriptor %u %p complete\n",
 		 txd->cookie, desc);
 
-	dc->completed = txd->cookie;
+	dc->chan.completed_cookie = txd->cookie;
 	callback = txd->callback;
 	param = txd->callback_param;
 
@@ -976,7 +976,7 @@ txx9dmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	dma_cookie_t last_complete;
 	int ret;
 
-	last_complete = dc->completed;
+	last_complete = chan->completed_cookie;
 	last_used = chan->cookie;
 
 	ret = dma_async_is_complete(cookie, last_complete, last_used);
@@ -985,7 +985,7 @@ txx9dmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 		txx9dmac_scan_descriptors(dc);
 		spin_unlock_bh(&dc->lock);
 
-		last_complete = dc->completed;
+		last_complete = chan->completed_cookie;
 		last_used = chan->cookie;
 
 		ret = dma_async_is_complete(cookie, last_complete, last_used);
@@ -1057,7 +1057,7 @@ static int txx9dmac_alloc_chan_resources(struct dma_chan *chan)
 		return -EIO;
 	}
 
-	dc->completed = chan->cookie = 1;
+	chan->completed_cookie = chan->cookie = 1;
 
 	dc->ccr = TXX9_DMA_CCR_IMMCHN | TXX9_DMA_CCR_INTENE | CCR_LE;
 	txx9dmac_chan_set_SMPCHN(dc);
@@ -1186,7 +1186,7 @@ static int __init txx9dmac_chan_probe(struct platform_device *pdev)
 	dc->ddev->chan[ch] = dc;
 	dc->chan.device = &dc->dma;
 	list_add_tail(&dc->chan.device_node, &dc->chan.device->channels);
-	dc->chan.cookie = dc->completed = 1;
+	dc->chan.cookie = dc->chan.completed_cookie = 1;
 
 	if (is_dmac64(dc))
 		dc->ch_regs = &__txx9dmac_regs(dc->ddev)->CHAN[ch];
diff --git a/drivers/dma/txx9dmac.h b/drivers/dma/txx9dmac.h
index 365d423..f5a7605 100644
--- a/drivers/dma/txx9dmac.h
+++ b/drivers/dma/txx9dmac.h
@@ -172,7 +172,6 @@ struct txx9dmac_chan {
 	spinlock_t		lock;
 
 	/* these other elements are all protected by lock */
-	dma_cookie_t		completed;
 	struct list_head	active_list;
 	struct list_head	queue;
 	struct list_head	free_list;
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 033f6aa..1bb134b 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -176,7 +176,6 @@ enum pl08x_dma_chan_state {
  * @runtime_addr: address for RX/TX according to the runtime config
  * @runtime_direction: current direction of this channel according to
  * runtime config
- * @lc: last completed transaction on this channel
  * @pend_list: queued transactions pending on this channel
  * @at: active transaction on this channel
  * @lock: a lock for this channel data
@@ -198,7 +197,6 @@ struct pl08x_dma_chan {
 	u32 src_cctl;
 	u32 dst_cctl;
 	enum dma_transfer_direction runtime_direction;
-	dma_cookie_t lc;
 	struct list_head pend_list;
 	struct pl08x_txd *at;
 	spinlock_t lock;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 679b349..41d0f92 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -257,6 +257,7 @@ struct dma_chan_percpu {
  * struct dma_chan - devices supply DMA channels, clients use them
  * @device: ptr to the dma device who supplies this channel, always !%NULL
  * @cookie: last cookie value returned to client
+ * @completed_cookie: last completed cookie for this channel
  * @chan_id: channel ID for sysfs
  * @dev: class device for sysfs
  * @device_node: used to add this to the device chan list
@@ -268,6 +269,7 @@ struct dma_chan_percpu {
 struct dma_chan {
 	struct dma_device *device;
 	dma_cookie_t cookie;
+	dma_cookie_t completed_cookie;
 
 	/* sysfs */
 	int chan_id;
-- 
1.7.4.4
