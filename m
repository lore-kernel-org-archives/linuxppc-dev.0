Return-Path: <rmk+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0D6B4B6FBC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 07:48:53 +1100 (EST)
In-Reply-To: <20120305201411.GA17791@n2100.arm.linux.org.uk>
References: <20120305201411.GA17791@n2100.arm.linux.org.uk>
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Dan Williams <dan.j.williams@intel.com>,Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/9] dmaengine: consolidate assignment of DMA cookies
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <E1S4eKK-0000t2-Tw@rmk-PC.arm.linux.org.uk>
Sender: Russell King <rmk@arm.linux.org.uk>
Date: Mon, 05 Mar 2012 20:16:12 +0000
Cc: Viresh Kumar <viresh.kumar@st.com>, Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 Zhang Wei <zw@zh-kernel.org>, Barry Song <baohua.song@csr.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Everyone deals with assigning DMA cookies in the same way (it's part of
the API so they should be), so lets consolidate the common code into a
helper function to avoid this duplication.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c    |    9 +++------
 drivers/dma/at_hdmac.c      |   23 +----------------------
 drivers/dma/coh901318.c     |   20 +++-----------------
 drivers/dma/dmaengine.h     |   20 ++++++++++++++++++++
 drivers/dma/dw_dmac.c       |   17 +----------------
 drivers/dma/ep93xx_dma.c    |    9 +--------
 drivers/dma/fsldma.c        |    9 +--------
 drivers/dma/imx-dma.c       |   15 +--------------
 drivers/dma/imx-sdma.c      |   15 +--------------
 drivers/dma/intel_mid_dma.c |    9 +--------
 drivers/dma/ioat/dma.c      |    7 +------
 drivers/dma/ioat/dma_v2.c   |    8 ++------
 drivers/dma/iop-adma.c      |   14 +-------------
 drivers/dma/ipu/ipu_idmac.c |    9 +--------
 drivers/dma/mpc512x_dma.c   |    8 +-------
 drivers/dma/mv_xor.c        |   14 +-------------
 drivers/dma/mxs-dma.c       |   15 +--------------
 drivers/dma/pch_dma.c       |   16 +---------------
 drivers/dma/pl330.c         |   14 ++------------
 drivers/dma/ppc4xx/adma.c   |   19 +------------------
 drivers/dma/shdma.c         |    8 +-------
 drivers/dma/sirf-dma.c      |    8 +-------
 drivers/dma/ste_dma40.c     |   13 +++----------
 drivers/dma/timb_dma.c      |    7 +------
 drivers/dma/txx9dmac.c      |   17 +----------------
 25 files changed, 52 insertions(+), 271 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 87475cb..5996386 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -921,13 +921,10 @@ static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(tx->chan);
 	struct pl08x_txd *txd = to_pl08x_txd(tx);
 	unsigned long flags;
+	dma_cookie_t cookie;
 
 	spin_lock_irqsave(&plchan->lock, flags);
-
-	plchan->chan.cookie += 1;
-	if (plchan->chan.cookie < 0)
-		plchan->chan.cookie = 1;
-	tx->cookie = plchan->chan.cookie;
+	cookie = dma_cookie_assign(tx);
 
 	/* Put this onto the pending list */
 	list_add_tail(&txd->node, &plchan->pend_list);
@@ -947,7 +944,7 @@ static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
 
 	spin_unlock_irqrestore(&plchan->lock, flags);
 
-	return tx->cookie;
+	return cookie;
 }
 
 static struct dma_async_tx_descriptor *pl08x_prep_dma_interrupt(
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index ce26ba3..df47e7d 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -193,27 +193,6 @@ static void atc_desc_chain(struct at_desc **first, struct at_desc **prev,
 }
 
 /**
- * atc_assign_cookie - compute and assign new cookie
- * @atchan: channel we work on
- * @desc: descriptor to assign cookie for
- *
- * Called with atchan->lock held and bh disabled
- */
-static dma_cookie_t
-atc_assign_cookie(struct at_dma_chan *atchan, struct at_desc *desc)
-{
-	dma_cookie_t cookie = atchan->chan_common.cookie;
-
-	if (++cookie < 0)
-		cookie = 1;
-
-	atchan->chan_common.cookie = cookie;
-	desc->txd.cookie = cookie;
-
-	return cookie;
-}
-
-/**
  * atc_dostart - starts the DMA engine for real
  * @atchan: the channel we want to start
  * @first: first descriptor in the list we want to begin with
@@ -548,7 +527,7 @@ static dma_cookie_t atc_tx_submit(struct dma_async_tx_descriptor *tx)
 	unsigned long		flags;
 
 	spin_lock_irqsave(&atchan->lock, flags);
-	cookie = atc_assign_cookie(atchan, desc);
+	cookie = dma_cookie_assign(tx);
 
 	if (list_empty(&atchan->active_list)) {
 		dev_vdbg(chan2dev(tx->chan), "tx_submit: started %u\n",
diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index fb0d124..843a1a3 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -318,20 +318,6 @@ static int coh901318_prep_linked_list(struct coh901318_chan *cohc,
 
 	return 0;
 }
-static dma_cookie_t
-coh901318_assign_cookie(struct coh901318_chan *cohc,
-			struct coh901318_desc *cohd)
-{
-	dma_cookie_t cookie = cohc->chan.cookie;
-
-	if (++cookie < 0)
-		cookie = 1;
-
-	cohc->chan.cookie = cookie;
-	cohd->desc.cookie = cookie;
-
-	return cookie;
-}
 
 static struct coh901318_desc *
 coh901318_desc_get(struct coh901318_chan *cohc)
@@ -966,16 +952,16 @@ coh901318_tx_submit(struct dma_async_tx_descriptor *tx)
 						   desc);
 	struct coh901318_chan *cohc = to_coh901318_chan(tx->chan);
 	unsigned long flags;
+	dma_cookie_t cookie;
 
 	spin_lock_irqsave(&cohc->lock, flags);
-
-	tx->cookie = coh901318_assign_cookie(cohc, cohd);
+	cookie = dma_cookie_assign(tx);
 
 	coh901318_desc_queue(cohc, cohd);
 
 	spin_unlock_irqrestore(&cohc->lock, flags);
 
-	return tx->cookie;
+	return cookie;
 }
 
 static struct dma_async_tx_descriptor *
diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index 968570d..7692c86 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -7,4 +7,24 @@
 
 #include <linux/dmaengine.h>
 
+/**
+ * dma_cookie_assign - assign a DMA engine cookie to the descriptor
+ * @tx: descriptor needing cookie
+ *
+ * Assign a unique non-zero per-channel cookie to the descriptor.
+ * Note: caller is expected to hold a lock to prevent concurrency.
+ */
+static inline dma_cookie_t dma_cookie_assign(struct dma_async_tx_descriptor *tx)
+{
+	struct dma_chan *chan = tx->chan;
+	dma_cookie_t cookie;
+
+	cookie = chan->cookie + 1;
+	if (cookie < DMA_MIN_COOKIE)
+		cookie = DMA_MIN_COOKIE;
+	tx->cookie = chan->cookie = cookie;
+
+	return cookie;
+}
+
 #endif
diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index f10dbe1..5ee9498 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -152,21 +152,6 @@ static void dwc_desc_put(struct dw_dma_chan *dwc, struct dw_desc *desc)
 	}
 }
 
-/* Called with dwc->lock held and bh disabled */
-static dma_cookie_t
-dwc_assign_cookie(struct dw_dma_chan *dwc, struct dw_desc *desc)
-{
-	dma_cookie_t cookie = dwc->chan.cookie;
-
-	if (++cookie < 0)
-		cookie = 1;
-
-	dwc->chan.cookie = cookie;
-	desc->txd.cookie = cookie;
-
-	return cookie;
-}
-
 static void dwc_initialize(struct dw_dma_chan *dwc)
 {
 	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
@@ -616,7 +601,7 @@ static dma_cookie_t dwc_tx_submit(struct dma_async_tx_descriptor *tx)
 	unsigned long		flags;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	cookie = dwc_assign_cookie(dwc, desc);
+	cookie = dma_cookie_assign(tx);
 
 	/*
 	 * REVISIT: We should attempt to chain as many descriptors as
diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 3260198..e5aaae8 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -783,17 +783,10 @@ static dma_cookie_t ep93xx_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	unsigned long flags;
 
 	spin_lock_irqsave(&edmac->lock, flags);
-
-	cookie = edmac->chan.cookie;
-
-	if (++cookie < 0)
-		cookie = 1;
+	cookie = dma_cookie_assign(tx);
 
 	desc = container_of(tx, struct ep93xx_dma_desc, txd);
 
-	edmac->chan.cookie = cookie;
-	desc->txd.cookie = cookie;
-
 	/*
 	 * If nothing is currently prosessed, we push this descriptor
 	 * directly to the hardware. Otherwise we put the descriptor
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 2ebbe57..04b4347 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -414,17 +414,10 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	 * assign cookies to all of the software descriptors
 	 * that make up this transaction
 	 */
-	cookie = chan->common.cookie;
 	list_for_each_entry(child, &desc->tx_list, node) {
-		cookie++;
-		if (cookie < DMA_MIN_COOKIE)
-			cookie = DMA_MIN_COOKIE;
-
-		child->async_tx.cookie = cookie;
+		cookie = dma_cookie_assign(&child->async_tx);
 	}
 
-	chan->common.cookie = cookie;
-
 	/* put this transaction onto the tail of the pending queue */
 	append_ld_queue(chan, desc);
 
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 51251a6..42154b6 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -165,19 +165,6 @@ static enum dma_status imxdma_tx_status(struct dma_chan *chan,
 	return ret;
 }
 
-static dma_cookie_t imxdma_assign_cookie(struct imxdma_channel *imxdma)
-{
-	dma_cookie_t cookie = imxdma->chan.cookie;
-
-	if (++cookie < 0)
-		cookie = 1;
-
-	imxdma->chan.cookie = cookie;
-	imxdma->desc.cookie = cookie;
-
-	return cookie;
-}
-
 static dma_cookie_t imxdma_tx_submit(struct dma_async_tx_descriptor *tx)
 {
 	struct imxdma_channel *imxdmac = to_imxdma_chan(tx->chan);
@@ -185,7 +172,7 @@ static dma_cookie_t imxdma_tx_submit(struct dma_async_tx_descriptor *tx)
 
 	spin_lock_irq(&imxdmac->lock);
 
-	cookie = imxdma_assign_cookie(imxdmac);
+	cookie = dma_cookie_assign(tx);
 
 	imx_dma_enable(imxdmac->imxdma_channel);
 
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9950ec3..4e4f40e 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -817,19 +817,6 @@ static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
 	__raw_writel(1 << channel, sdma->regs + SDMA_H_START);
 }
 
-static dma_cookie_t sdma_assign_cookie(struct sdma_channel *sdmac)
-{
-	dma_cookie_t cookie = sdmac->chan.cookie;
-
-	if (++cookie < 0)
-		cookie = 1;
-
-	sdmac->chan.cookie = cookie;
-	sdmac->desc.cookie = cookie;
-
-	return cookie;
-}
-
 static struct sdma_channel *to_sdma_chan(struct dma_chan *chan)
 {
 	return container_of(chan, struct sdma_channel, chan);
@@ -844,7 +831,7 @@ static dma_cookie_t sdma_tx_submit(struct dma_async_tx_descriptor *tx)
 
 	spin_lock_irqsave(&sdmac->lock, flags);
 
-	cookie = sdma_assign_cookie(sdmac);
+	cookie = dma_cookie_assign(tx);
 
 	sdma_enable_channel(sdma, sdmac->channel);
 
diff --git a/drivers/dma/intel_mid_dma.c b/drivers/dma/intel_mid_dma.c
index a907dd6..dfe4396 100644
--- a/drivers/dma/intel_mid_dma.c
+++ b/drivers/dma/intel_mid_dma.c
@@ -436,14 +436,7 @@ static dma_cookie_t intel_mid_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	dma_cookie_t		cookie;
 
 	spin_lock_bh(&midc->lock);
-	cookie = midc->chan.cookie;
-
-	if (++cookie < 0)
-		cookie = 1;
-
-	midc->chan.cookie = cookie;
-	desc->txd.cookie = cookie;
-
+	cookie = dma_cookie_assign(tx);
 
 	if (list_empty(&midc->active_list))
 		list_add_tail(&desc->desc_node, &midc->active_list);
diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index dfe411b..5c06117 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -237,12 +237,7 @@ static dma_cookie_t ioat1_tx_submit(struct dma_async_tx_descriptor *tx)
 
 	spin_lock_bh(&ioat->desc_lock);
 	/* cookie incr and addition to used_list must be atomic */
-	cookie = c->cookie;
-	cookie++;
-	if (cookie < 0)
-		cookie = 1;
-	c->cookie = cookie;
-	tx->cookie = cookie;
+	cookie = dma_cookie_assign(tx);
 	dev_dbg(to_dev(&ioat->base), "%s: cookie: %d\n", __func__, cookie);
 
 	/* write address into NextDescriptor field of last desc in chain */
diff --git a/drivers/dma/ioat/dma_v2.c b/drivers/dma/ioat/dma_v2.c
index 6c1e675..17ecacb 100644
--- a/drivers/dma/ioat/dma_v2.c
+++ b/drivers/dma/ioat/dma_v2.c
@@ -400,13 +400,9 @@ static dma_cookie_t ioat2_tx_submit_unlock(struct dma_async_tx_descriptor *tx)
 	struct dma_chan *c = tx->chan;
 	struct ioat2_dma_chan *ioat = to_ioat2_chan(c);
 	struct ioat_chan_common *chan = &ioat->base;
-	dma_cookie_t cookie = c->cookie;
+	dma_cookie_t cookie;
 
-	cookie++;
-	if (cookie < 0)
-		cookie = 1;
-	tx->cookie = cookie;
-	c->cookie = cookie;
+	cookie = dma_cookie_assign(tx);
 	dev_dbg(to_dev(&ioat->base), "%s: cookie: %d\n", __func__, cookie);
 
 	if (!test_and_set_bit(IOAT_COMPLETION_PENDING, &chan->state))
diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 650bf1e..f2392d5 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -440,18 +440,6 @@ iop_adma_alloc_slots(struct iop_adma_chan *iop_chan, int num_slots,
 	return NULL;
 }
 
-static dma_cookie_t
-iop_desc_assign_cookie(struct iop_adma_chan *iop_chan,
-	struct iop_adma_desc_slot *desc)
-{
-	dma_cookie_t cookie = iop_chan->common.cookie;
-	cookie++;
-	if (cookie < 0)
-		cookie = 1;
-	iop_chan->common.cookie = desc->async_tx.cookie = cookie;
-	return cookie;
-}
-
 static void iop_adma_check_threshold(struct iop_adma_chan *iop_chan)
 {
 	dev_dbg(iop_chan->device->common.dev, "pending: %d\n",
@@ -479,7 +467,7 @@ iop_adma_tx_submit(struct dma_async_tx_descriptor *tx)
 	slots_per_op = grp_start->slots_per_op;
 
 	spin_lock_bh(&iop_chan->lock);
-	cookie = iop_desc_assign_cookie(iop_chan, sw_desc);
+	cookie = dma_cookie_assign(tx);
 
 	old_chain_tail = list_entry(iop_chan->chain.prev,
 		struct iop_adma_desc_slot, chain_node);
diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index 0fcff65..d4620c5 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -867,14 +867,7 @@ static dma_cookie_t idmac_tx_submit(struct dma_async_tx_descriptor *tx)
 
 	dev_dbg(dev, "Submitting sg %p\n", &desc->sg[0]);
 
-	cookie = ichan->dma_chan.cookie;
-
-	if (++cookie < 0)
-		cookie = 1;
-
-	/* from dmaengine.h: "last cookie value returned to client" */
-	ichan->dma_chan.cookie = cookie;
-	tx->cookie = cookie;
+	cookie = dma_cookie_assign(tx);
 
 	/* ipu->lock can be taken under ichan->lock, but not v.v. */
 	spin_lock_irqsave(&ichan->lock, flags);
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index c56b3fe..0253d5a 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -439,13 +439,7 @@ static dma_cookie_t mpc_dma_tx_submit(struct dma_async_tx_descriptor *txd)
 		mpc_dma_execute(mchan);
 
 	/* Update cookie */
-	cookie = mchan->chan.cookie + 1;
-	if (cookie <= 0)
-		cookie = 1;
-
-	mchan->chan.cookie = cookie;
-	mdesc->desc.cookie = cookie;
-
+	cookie = dma_cookie_assign(txd);
 	spin_unlock_irqrestore(&mchan->lock, flags);
 
 	return cookie;
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index ee61778..d9810ce 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -536,18 +536,6 @@ mv_xor_alloc_slots(struct mv_xor_chan *mv_chan, int num_slots,
 	return NULL;
 }
 
-static dma_cookie_t
-mv_desc_assign_cookie(struct mv_xor_chan *mv_chan,
-		      struct mv_xor_desc_slot *desc)
-{
-	dma_cookie_t cookie = mv_chan->common.cookie;
-
-	if (++cookie < 0)
-		cookie = 1;
-	mv_chan->common.cookie = desc->async_tx.cookie = cookie;
-	return cookie;
-}
-
 /************************ DMA engine API functions ****************************/
 static dma_cookie_t
 mv_xor_tx_submit(struct dma_async_tx_descriptor *tx)
@@ -565,7 +553,7 @@ mv_xor_tx_submit(struct dma_async_tx_descriptor *tx)
 	grp_start = sw_desc->group_head;
 
 	spin_lock_bh(&mv_chan->lock);
-	cookie = mv_desc_assign_cookie(mv_chan, sw_desc);
+	cookie = dma_cookie_assign(tx);
 
 	if (list_empty(&mv_chan->chain))
 		list_splice_init(&sw_desc->tx_list, &mv_chan->chain);
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index daa84ee..4d3b6ff 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -194,19 +194,6 @@ static void mxs_dma_resume_chan(struct mxs_dma_chan *mxs_chan)
 	mxs_chan->status = DMA_IN_PROGRESS;
 }
 
-static dma_cookie_t mxs_dma_assign_cookie(struct mxs_dma_chan *mxs_chan)
-{
-	dma_cookie_t cookie = mxs_chan->chan.cookie;
-
-	if (++cookie < 0)
-		cookie = 1;
-
-	mxs_chan->chan.cookie = cookie;
-	mxs_chan->desc.cookie = cookie;
-
-	return cookie;
-}
-
 static struct mxs_dma_chan *to_mxs_dma_chan(struct dma_chan *chan)
 {
 	return container_of(chan, struct mxs_dma_chan, chan);
@@ -218,7 +205,7 @@ static dma_cookie_t mxs_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 
 	mxs_dma_enable_chan(mxs_chan);
 
-	return mxs_dma_assign_cookie(mxs_chan);
+	return dma_cookie_assign(tx);
 }
 
 static void mxs_dma_tasklet(unsigned long data)
diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index 2b3479d..5218e48 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -417,20 +417,6 @@ static void pdc_advance_work(struct pch_dma_chan *pd_chan)
 	}
 }
 
-static dma_cookie_t pdc_assign_cookie(struct pch_dma_chan *pd_chan,
-				      struct pch_dma_desc *desc)
-{
-	dma_cookie_t cookie = pd_chan->chan.cookie;
-
-	if (++cookie < 0)
-		cookie = 1;
-
-	pd_chan->chan.cookie = cookie;
-	desc->txd.cookie = cookie;
-
-	return cookie;
-}
-
 static dma_cookie_t pd_tx_submit(struct dma_async_tx_descriptor *txd)
 {
 	struct pch_dma_desc *desc = to_pd_desc(txd);
@@ -438,7 +424,7 @@ static dma_cookie_t pd_tx_submit(struct dma_async_tx_descriptor *txd)
 	dma_cookie_t cookie;
 
 	spin_lock(&pd_chan->lock);
-	cookie = pdc_assign_cookie(pd_chan, desc);
+	cookie = dma_cookie_assign(txd);
 
 	if (list_empty(&pd_chan->active_list)) {
 		list_add_tail(&desc->desc_node, &pd_chan->active_list);
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index d7b0af2..ec9638b 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -429,26 +429,16 @@ static dma_cookie_t pl330_tx_submit(struct dma_async_tx_descriptor *tx)
 	spin_lock_irqsave(&pch->lock, flags);
 
 	/* Assign cookies to all nodes */
-	cookie = tx->chan->cookie;
-
 	while (!list_empty(&last->node)) {
 		desc = list_entry(last->node.next, struct dma_pl330_desc, node);
 
-		if (++cookie < 0)
-			cookie = 1;
-		desc->txd.cookie = cookie;
+		dma_cookie_assign(&desc->txd);
 
 		list_move_tail(&desc->node, &pch->work_list);
 	}
 
-	if (++cookie < 0)
-		cookie = 1;
-	last->txd.cookie = cookie;
-
+	cookie = dma_cookie_assign(&last->txd);
 	list_add_tail(&last->node, &pch->work_list);
-
-	tx->chan->cookie = cookie;
-
 	spin_unlock_irqrestore(&pch->lock, flags);
 
 	return cookie;
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 40082ec..12e94dd 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -2151,22 +2151,6 @@ static int ppc440spe_adma_alloc_chan_resources(struct dma_chan *chan)
 }
 
 /**
- * ppc440spe_desc_assign_cookie - assign a cookie
- */
-static dma_cookie_t ppc440spe_desc_assign_cookie(
-		struct ppc440spe_adma_chan *chan,
-		struct ppc440spe_adma_desc_slot *desc)
-{
-	dma_cookie_t cookie = chan->common.cookie;
-
-	cookie++;
-	if (cookie < 0)
-		cookie = 1;
-	chan->common.cookie = desc->async_tx.cookie = cookie;
-	return cookie;
-}
-
-/**
  * ppc440spe_rxor_set_region_data -
  */
 static void ppc440spe_rxor_set_region(struct ppc440spe_adma_desc_slot *desc,
@@ -2236,8 +2220,7 @@ static dma_cookie_t ppc440spe_adma_tx_submit(struct dma_async_tx_descriptor *tx)
 	slots_per_op = group_start->slots_per_op;
 
 	spin_lock_bh(&chan->lock);
-
-	cookie = ppc440spe_desc_assign_cookie(chan, sw_desc);
+	cookie = dma_cookie_assign(tx);
 
 	if (unlikely(list_empty(&chan->chain))) {
 		/* first peer */
diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index c291433..96d0a4f 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -298,13 +298,7 @@ static dma_cookie_t sh_dmae_tx_submit(struct dma_async_tx_descriptor *tx)
 	else
 		power_up = false;
 
-	cookie = sh_chan->common.cookie;
-	cookie++;
-	if (cookie < 0)
-		cookie = 1;
-
-	sh_chan->common.cookie = cookie;
-	tx->cookie = cookie;
+	cookie = dma_cookie_assign(tx);
 
 	/* Mark all chunks of this descriptor as submitted, move to the queue */
 	list_for_each_entry_safe(chunk, c, desc->node.prev, node) {
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 60473f0..7bb154a 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -257,13 +257,7 @@ static dma_cookie_t sirfsoc_dma_tx_submit(struct dma_async_tx_descriptor *txd)
 	/* Move descriptor to queue */
 	list_move_tail(&sdesc->node, &schan->queued);
 
-	/* Update cookie */
-	cookie = schan->chan.cookie + 1;
-	if (cookie <= 0)
-		cookie = 1;
-
-	schan->chan.cookie = cookie;
-	sdesc->desc.cookie = cookie;
+	cookie = dma_cookie_assign(txd);
 
 	spin_unlock_irqrestore(&schan->lock, flags);
 
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 156b98f..23e2edc 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1220,21 +1220,14 @@ static dma_cookie_t d40_tx_submit(struct dma_async_tx_descriptor *tx)
 					     chan);
 	struct d40_desc *d40d = container_of(tx, struct d40_desc, txd);
 	unsigned long flags;
+	dma_cookie_t cookie;
 
 	spin_lock_irqsave(&d40c->lock, flags);
-
-	d40c->chan.cookie++;
-
-	if (d40c->chan.cookie < 0)
-		d40c->chan.cookie = 1;
-
-	d40d->txd.cookie = d40c->chan.cookie;
-
+	cookie = dma_cookie_assign(tx);
 	d40_desc_queue(d40c, d40d);
-
 	spin_unlock_irqrestore(&d40c->lock, flags);
 
-	return tx->cookie;
+	return cookie;
 }
 
 static int d40_start(struct d40_chan *d40c)
diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 4b61879..b6e83fc 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -350,12 +350,7 @@ static dma_cookie_t td_tx_submit(struct dma_async_tx_descriptor *txd)
 	dma_cookie_t cookie;
 
 	spin_lock_bh(&td_chan->lock);
-
-	cookie = txd->chan->cookie;
-	if (++cookie < 0)
-		cookie = 1;
-	txd->chan->cookie = cookie;
-	txd->cookie = cookie;
+	cookie = dma_cookie_assign(txd);
 
 	if (list_empty(&td_chan->active_list)) {
 		dev_dbg(chan2dev(txd->chan), "%s: started %u\n", __func__,
diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index db6d809..66f8fca 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -281,21 +281,6 @@ static void txx9dmac_desc_put(struct txx9dmac_chan *dc,
 	}
 }
 
-/* Called with dc->lock held and bh disabled */
-static dma_cookie_t
-txx9dmac_assign_cookie(struct txx9dmac_chan *dc, struct txx9dmac_desc *desc)
-{
-	dma_cookie_t cookie = dc->chan.cookie;
-
-	if (++cookie < 0)
-		cookie = 1;
-
-	dc->chan.cookie = cookie;
-	desc->txd.cookie = cookie;
-
-	return cookie;
-}
-
 /*----------------------------------------------------------------------*/
 
 static void txx9dmac_dump_regs(struct txx9dmac_chan *dc)
@@ -740,7 +725,7 @@ static dma_cookie_t txx9dmac_tx_submit(struct dma_async_tx_descriptor *tx)
 	dma_cookie_t cookie;
 
 	spin_lock_bh(&dc->lock);
-	cookie = txx9dmac_assign_cookie(dc, desc);
+	cookie = dma_cookie_assign(tx);
 
 	dev_vdbg(chan2dev(tx->chan), "tx_submit: queued %u %p\n",
 		 desc->txd.cookie, desc);
-- 
1.7.4.4
