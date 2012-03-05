Return-Path: <rmk+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F1B00B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 07:48:30 +1100 (EST)
In-Reply-To: <20120305201411.GA17791@n2100.arm.linux.org.uk>
References: <20120305201411.GA17791@n2100.arm.linux.org.uk>
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Dan Williams <dan.j.williams@intel.com>,Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 6/9] dmaengine: consolidate tx_status functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <E1S4eKz-0000tE-FB@rmk-PC.arm.linux.org.uk>
Sender: Russell King <rmk@arm.linux.org.uk>
Date: Mon, 05 Mar 2012 20:16:53 +0000
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

Now that we have the completed cookie in the dma_chan structure, we
can consolidate the tx_status functions by providing a function to set
the txstate structure and returning the DMA status.  We also provide
a separate helper to set the residue for cookies which are still in
progress.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c    |   22 ++++------------------
 drivers/dma/at_hdmac.c      |   18 ++++++------------
 drivers/dma/coh901318.c     |   13 ++++---------
 drivers/dma/dmaengine.h     |   31 +++++++++++++++++++++++++++++++
 drivers/dma/dw_dmac.c       |   19 ++++---------------
 drivers/dma/ep93xx_dma.c    |    7 +------
 drivers/dma/fsldma.c        |   11 +++--------
 drivers/dma/imx-dma.c       |   11 +----------
 drivers/dma/intel_mid_dma.c |   19 +++----------------
 drivers/dma/ioat/dma.c      |    8 +++++---
 drivers/dma/ioat/dma.h      |   21 ---------------------
 drivers/dma/ioat/dma_v3.c   |    8 +++++---
 drivers/dma/iop-adma.c      |   16 +++-------------
 drivers/dma/mpc512x_dma.c   |    9 +++------
 drivers/dma/mv_xor.c        |   14 ++------------
 drivers/dma/pch_dma.c       |   11 ++---------
 drivers/dma/pl330.c         |   13 +------------
 drivers/dma/ppc4xx/adma.c   |   16 ++--------------
 drivers/dma/shdma.c         |   11 +----------
 drivers/dma/sirf-dma.c      |    9 +++------
 drivers/dma/ste_dma40.c     |   14 ++++----------
 drivers/dma/timb_dma.c      |   11 ++---------
 drivers/dma/txx9dmac.c      |   16 +++-------------
 23 files changed, 93 insertions(+), 235 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index f0888c1..2781a2b 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -964,31 +964,17 @@ static enum dma_status pl08x_dma_tx_status(struct dma_chan *chan,
 		dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
-	dma_cookie_t last_used;
-	dma_cookie_t last_complete;
 	enum dma_status ret;
-	u32 bytesleft = 0;
 
-	last_used = plchan->chan.cookie;
-	last_complete = plchan->chan.completed_cookie;
-
-	ret = dma_async_is_complete(cookie, last_complete, last_used);
-	if (ret == DMA_SUCCESS) {
-		dma_set_tx_state(txstate, last_complete, last_used, 0);
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret == DMA_SUCCESS)
 		return ret;
-	}
 
 	/*
 	 * This cookie not complete yet
+	 * Get number of bytes left in the active transactions and queue
 	 */
-	last_used = plchan->chan.cookie;
-	last_complete = plchan->chan.completed_cookie;
-
-	/* Get number of bytes left in the active transactions and queue */
-	bytesleft = pl08x_getbytes_chan(plchan);
-
-	dma_set_tx_state(txstate, last_complete, last_used,
-			 bytesleft);
+	dma_set_residue(txstate, pl08x_getbytes_chan(plchan));
 
 	if (plchan->state == PL08X_CHAN_PAUSED)
 		return DMA_PAUSED;
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index b282630..8a32974 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -996,26 +996,20 @@ atc_tx_status(struct dma_chan *chan,
 
 	spin_lock_irqsave(&atchan->lock, flags);
 
-	last_complete = chan->completed_cookie;
-	last_used = chan->cookie;
-
-	ret = dma_async_is_complete(cookie, last_complete, last_used);
+	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret != DMA_SUCCESS) {
 		atc_cleanup_descriptors(atchan);
 
-		last_complete = chan->completed_cookie;
-		last_used = chan->cookie;
-
-		ret = dma_async_is_complete(cookie, last_complete, last_used);
+		ret = dma_cookie_status(chan, cookie, txstate);
 	}
 
+	last_complete = chan->completed_cookie;
+	last_used = chan->cookie;
+
 	spin_unlock_irqrestore(&atchan->lock, flags);
 
 	if (ret != DMA_SUCCESS)
-		dma_set_tx_state(txstate, last_complete, last_used,
-			atc_first_active(atchan)->len);
-	else
-		dma_set_tx_state(txstate, last_complete, last_used, 0);
+		dma_set_residue(txstate, atc_first_active(atchan)->len);
 
 	if (atc_chan_is_paused(atchan))
 		ret = DMA_PAUSED;
diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index 24837d7..f350517 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -1151,17 +1151,12 @@ coh901318_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 		 struct dma_tx_state *txstate)
 {
 	struct coh901318_chan *cohc = to_coh901318_chan(chan);
-	dma_cookie_t last_used;
-	dma_cookie_t last_complete;
-	int ret;
-
-	last_complete = chan->completed_cookie;
-	last_used = chan->cookie;
+	enum dma_status ret;
 
-	ret = dma_async_is_complete(cookie, last_complete, last_used);
+	ret = dma_cookie_status(chan, cookie, txstate);
+	/* FIXME: should be conditional on ret != DMA_SUCCESS? */
+	dma_set_residue(txstate, coh901318_get_bytes_left(chan));
 
-	dma_set_tx_state(txstate, last_complete, last_used,
-			 coh901318_get_bytes_left(chan));
 	if (ret == DMA_IN_PROGRESS && cohc->stopped)
 		ret = DMA_PAUSED;
 
diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index 47e0997..244a2c5 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -45,4 +45,35 @@ static inline void dma_cookie_complete(struct dma_async_tx_descriptor *tx)
 	tx->cookie = 0;
 }
 
+/**
+ * dma_cookie_status - report cookie status
+ * @chan: dma channel
+ * @cookie: cookie we are interested in
+ * @state: dma_tx_state structure to return last/used cookies
+ *
+ * Report the status of the cookie, filling in the state structure if
+ * non-NULL.  No locking is required.
+ */
+static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
+	dma_cookie_t cookie, struct dma_tx_state *state)
+{
+	dma_cookie_t used, complete;
+
+	used = chan->cookie;
+	complete = chan->complete;
+	barrier();
+	if (state) {
+		state->last = complete;
+		state->used = used;
+		state->residue = 0;
+	}
+	return dma_async_is_complete(cookie, complete, used);
+}
+
+static inline void dma_set_residue(struct dma_tx_state *state, u32 residue)
+{
+	if (state)
+		state->residue = residue;
+}
+
 #endif
diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index a190c88..acc3bc0 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -937,28 +937,17 @@ dwc_tx_status(struct dma_chan *chan,
 	      struct dma_tx_state *txstate)
 {
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
-	dma_cookie_t		last_used;
-	dma_cookie_t		last_complete;
-	int			ret;
+	enum dma_status		ret;
 
-	last_complete = chan->completed_cookie;
-	last_used = chan->cookie;
-
-	ret = dma_async_is_complete(cookie, last_complete, last_used);
+	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret != DMA_SUCCESS) {
 		dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
 
-		last_complete = chan->completed_cookie;
-		last_used = chan->cookie;
-
-		ret = dma_async_is_complete(cookie, last_complete, last_used);
+		ret = dma_cookie_status(chan, cookie, txstate);
 	}
 
 	if (ret != DMA_SUCCESS)
-		dma_set_tx_state(txstate, last_complete, last_used,
-				dwc_first_active(dwc)->len);
-	else
-		dma_set_tx_state(txstate, last_complete, last_used, 0);
+		dma_set_residue(txstate, dwc_first_active(dwc)->len);
 
 	if (dwc->paused)
 		return DMA_PAUSED;
diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 1c56f75..142ebf0 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -1241,18 +1241,13 @@ static enum dma_status ep93xx_dma_tx_status(struct dma_chan *chan,
 					    struct dma_tx_state *state)
 {
 	struct ep93xx_dma_chan *edmac = to_ep93xx_dma_chan(chan);
-	dma_cookie_t last_used, last_completed;
 	enum dma_status ret;
 	unsigned long flags;
 
 	spin_lock_irqsave(&edmac->lock, flags);
-	last_used = chan->cookie;
-	last_completed = chan->completed_cookie;
+	ret = dma_cookie_status(chan, cookie, state);
 	spin_unlock_irqrestore(&edmac->lock, flags);
 
-	ret = dma_async_is_complete(cookie, last_completed, last_used);
-	dma_set_tx_state(state, last_completed, last_used, 0);
-
 	return ret;
 }
 
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index f36e8b1..2f6c806 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -978,19 +978,14 @@ static enum dma_status fsl_tx_status(struct dma_chan *dchan,
 					struct dma_tx_state *txstate)
 {
 	struct fsldma_chan *chan = to_fsl_chan(dchan);
-	dma_cookie_t last_complete;
-	dma_cookie_t last_used;
+	enum dma_status ret;
 	unsigned long flags;
 
 	spin_lock_irqsave(&chan->desc_lock, flags);
-
-	last_complete = dchan->completed_cookie;
-	last_used = dchan->cookie;
-
+	ret = dma_cookie_status(dchan, cookie, txstate);
 	spin_unlock_irqrestore(&chan->desc_lock, flags);
 
-	dma_set_tx_state(txstate, last_complete, last_used, 0);
-	return dma_async_is_complete(cookie, last_complete, last_used);
+	return ret;
 }
 
 /*----------------------------------------------------------------------------*/
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index f1226ad..ba317e6 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -153,16 +153,7 @@ static enum dma_status imxdma_tx_status(struct dma_chan *chan,
 					    dma_cookie_t cookie,
 					    struct dma_tx_state *txstate)
 {
-	struct imxdma_channel *imxdmac = to_imxdma_chan(chan);
-	dma_cookie_t last_used;
-	enum dma_status ret;
-
-	last_used = chan->cookie;
-
-	ret = dma_async_is_complete(cookie, chan->completed_cookie, last_used);
-	dma_set_tx_state(txstate, chan->completed_cookie, last_used, 0);
-
-	return ret;
+	return dma_cookie_status(chan, cookie, txstate);
 }
 
 static dma_cookie_t imxdma_tx_submit(struct dma_async_tx_descriptor *tx)
diff --git a/drivers/dma/intel_mid_dma.c b/drivers/dma/intel_mid_dma.c
index 340509e..69ed1e6 100644
--- a/drivers/dma/intel_mid_dma.c
+++ b/drivers/dma/intel_mid_dma.c
@@ -477,30 +477,17 @@ static enum dma_status intel_mid_dma_tx_status(struct dma_chan *chan,
 						dma_cookie_t cookie,
 						struct dma_tx_state *txstate)
 {
-	dma_cookie_t		last_used;
-	dma_cookie_t		last_complete;
-	int				ret;
+	enum dma_status ret;
 
-	last_complete = chan->completed_cookie;
-	last_used = chan->cookie;
-
-	ret = dma_async_is_complete(cookie, last_complete, last_used);
+	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret != DMA_SUCCESS) {
 		spin_lock_bh(&midc->lock);
 		midc_scan_descriptors(to_middma_device(chan->device), midc);
 		spin_unlock_bh(&midc->lock);
 
-		last_complete = chan->completed_cookie;
-		last_used = chan->cookie;
-
-		ret = dma_async_is_complete(cookie, last_complete, last_used);
+		ret = dma_cookie_status(chan, cookie, txstate);
 	}
 
-	if (txstate) {
-		txstate->last = last_complete;
-		txstate->used = last_used;
-		txstate->residue = 0;
-	}
 	return ret;
 }
 
diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index b0517c8..97e100c 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -729,13 +729,15 @@ ioat_dma_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 {
 	struct ioat_chan_common *chan = to_chan_common(c);
 	struct ioatdma_device *device = chan->device;
+	enum dma_status ret;
 
-	if (ioat_tx_status(c, cookie, txstate) == DMA_SUCCESS)
-		return DMA_SUCCESS;
+	ret = dma_cookie_status(c, cookie, txstate);
+	if (ret == DMA_SUCCESS)
+		return ret;
 
 	device->cleanup_fn((unsigned long) c);
 
-	return ioat_tx_status(c, cookie, txstate);
+	return dma_cookie_status(c, cookie, txstate);
 }
 
 static void ioat1_dma_start_null_desc(struct ioat_dma_chan *ioat)
diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index 9653b6b..c7888bc 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -142,27 +142,6 @@ static inline struct ioat_dma_chan *to_ioat_chan(struct dma_chan *c)
 	return container_of(chan, struct ioat_dma_chan, base);
 }
 
-/**
- * ioat_tx_status - poll the status of an ioat transaction
- * @c: channel handle
- * @cookie: transaction identifier
- * @txstate: if set, updated with the transaction state
- */
-static inline enum dma_status
-ioat_tx_status(struct dma_chan *c, dma_cookie_t cookie,
-		 struct dma_tx_state *txstate)
-{
-	dma_cookie_t last_used;
-	dma_cookie_t last_complete;
-
-	last_used = c->cookie;
-	last_complete = c->completed_cookie;
-
-	dma_set_tx_state(txstate, last_complete, last_used, 0);
-
-	return dma_async_is_complete(cookie, last_complete, last_used);
-}
-
 /* wrapper around hardware descriptor format + additional software fields */
 
 /**
diff --git a/drivers/dma/ioat/dma_v3.c b/drivers/dma/ioat/dma_v3.c
index 1bda46c..145eda2 100644
--- a/drivers/dma/ioat/dma_v3.c
+++ b/drivers/dma/ioat/dma_v3.c
@@ -410,13 +410,15 @@ ioat3_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 		struct dma_tx_state *txstate)
 {
 	struct ioat2_dma_chan *ioat = to_ioat2_chan(c);
+	enum dma_status ret;
 
-	if (ioat_tx_status(c, cookie, txstate) == DMA_SUCCESS)
-		return DMA_SUCCESS;
+	ret = dma_cookie_status(c, cookie, txstate);
+	if (ret == DMA_SUCCESS)
+		return ret;
 
 	ioat3_cleanup(ioat);
 
-	return ioat_tx_status(c, cookie, txstate);
+	return dma_cookie_status(c, cookie, txstate);
 }
 
 static struct dma_async_tx_descriptor *
diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index f2392d5..b1e3be08 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -894,24 +894,14 @@ static enum dma_status iop_adma_status(struct dma_chan *chan,
 					struct dma_tx_state *txstate)
 {
 	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
-	dma_cookie_t last_used;
-	dma_cookie_t last_complete;
-	enum dma_status ret;
-
-	last_used = chan->cookie;
-	last_complete = chan->completed_cookie;
-	dma_set_tx_state(txstate, last_complete, last_used, 0);
-	ret = dma_async_is_complete(cookie, last_complete, last_used);
+
+	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_SUCCESS)
 		return ret;
 
 	iop_adma_slot_cleanup(iop_chan);
 
-	last_used = chan->cookie;
-	last_complete = chan->completed_cookie;
-	dma_set_tx_state(txstate, last_complete, last_used, 0);
-
-	return dma_async_is_complete(cookie, last_complete, last_used);
+	return dma_cookie_status(chan, cookie, txstate);
 }
 
 static irqreturn_t iop_adma_eot_handler(int irq, void *data)
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 0253d5a..1382715 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -557,17 +557,14 @@ mpc_dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	       struct dma_tx_state *txstate)
 {
 	struct mpc_dma_chan *mchan = dma_chan_to_mpc_dma_chan(chan);
+	enum dma_status ret;
 	unsigned long flags;
-	dma_cookie_t last_used;
-	dma_cookie_t last_complete;
 
 	spin_lock_irqsave(&mchan->lock, flags);
-	last_used = mchan->chan.cookie;
-	last_complete = mchan->chan.completed_cookie;
+	ret = dma_cookie_status(chan, cookie, txstate);
 	spin_unlock_irqrestore(&mchan->lock, flags);
 
-	dma_set_tx_state(txstate, last_complete, last_used, 0);
-	return dma_async_is_complete(cookie, last_complete, last_used);
+	return ret;
 }
 
 /* Prepare descriptor for memory to memory copy */
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index d9810ce..486353e 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -810,26 +810,16 @@ static enum dma_status mv_xor_status(struct dma_chan *chan,
 					  struct dma_tx_state *txstate)
 {
 	struct mv_xor_chan *mv_chan = to_mv_xor_chan(chan);
-	dma_cookie_t last_used;
-	dma_cookie_t last_complete;
 	enum dma_status ret;
 
-	last_used = chan->cookie;
-	last_complete = chan->completed_cookie;
-	dma_set_tx_state(txstate, last_complete, last_used, 0);
-
-	ret = dma_async_is_complete(cookie, last_complete, last_used);
+	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_SUCCESS) {
 		mv_xor_clean_completed_slots(mv_chan);
 		return ret;
 	}
 	mv_xor_slot_cleanup(mv_chan);
 
-	last_used = chan->cookie;
-	last_complete = chan->completed_cookie;
-
-	dma_set_tx_state(txstate, last_complete, last_used, 0);
-	return dma_async_is_complete(cookie, last_complete, last_used);
+	return dma_cookie_status(chan, cookie, txstate);
 }
 
 static void mv_dump_xor_regs(struct mv_xor_chan *chan)
diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index 5218e48..c30f63e 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -565,19 +565,12 @@ static enum dma_status pd_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 				    struct dma_tx_state *txstate)
 {
 	struct pch_dma_chan *pd_chan = to_pd_chan(chan);
-	dma_cookie_t last_used;
-	dma_cookie_t last_completed;
-	int ret;
+	enum dma_status ret;
 
 	spin_lock_irq(&pd_chan->lock);
-	last_completed = chan->completed_cookie;
-	last_used = chan->cookie;
+	ret = dma_cookie_status(chan, cookie, txstate);
 	spin_unlock_irq(&pd_chan->lock);
 
-	ret = dma_async_is_complete(cookie, last_completed, last_used);
-
-	dma_set_tx_state(txstate, last_completed, last_used, 0);
-
 	return ret;
 }
 
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 76871b8..1993286 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -395,18 +395,7 @@ static enum dma_status
 pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 		 struct dma_tx_state *txstate)
 {
-	struct dma_pl330_chan *pch = to_pchan(chan);
-	dma_cookie_t last_done, last_used;
-	int ret;
-
-	last_done = chan->completed_cookie;
-	last_used = chan->cookie;
-
-	ret = dma_async_is_complete(cookie, last_done, last_used);
-
-	dma_set_tx_state(txstate, last_done, last_used, 0);
-
-	return ret;
+	return dma_cookie_status(chan, cookie, txstate);
 }
 
 static void pl330_issue_pending(struct dma_chan *chan)
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 12e94dd..86239ea 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -3928,28 +3928,16 @@ static enum dma_status ppc440spe_adma_tx_status(struct dma_chan *chan,
 			dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
 	struct ppc440spe_adma_chan *ppc440spe_chan;
-	dma_cookie_t last_used;
-	dma_cookie_t last_complete;
 	enum dma_status ret;
 
 	ppc440spe_chan = to_ppc440spe_adma_chan(chan);
-	last_used = chan->cookie;
-	last_complete = chan->completed_cookie;
-
-	dma_set_tx_state(txstate, last_complete, last_used, 0);
-
-	ret = dma_async_is_complete(cookie, last_complete, last_used);
+	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_SUCCESS)
 		return ret;
 
 	ppc440spe_adma_slot_cleanup(ppc440spe_chan);
 
-	last_used = chan->cookie;
-	last_complete = chan->completed_cookie;
-
-	dma_set_tx_state(txstate, last_complete, last_used, 0);
-
-	return dma_async_is_complete(cookie, last_complete, last_used);
+	return dma_cookie_status(chan, cookie, txstate);
 }
 
 /**
diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 96d0a4f..50510ef 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -879,23 +879,14 @@ static enum dma_status sh_dmae_tx_status(struct dma_chan *chan,
 					struct dma_tx_state *txstate)
 {
 	struct sh_dmae_chan *sh_chan = to_sh_chan(chan);
-	dma_cookie_t last_used;
-	dma_cookie_t last_complete;
 	enum dma_status status;
 	unsigned long flags;
 
 	sh_dmae_chan_ld_cleanup(sh_chan, false);
 
-	/* First read completed cookie to avoid a skew */
-	last_complete = chan->completed_cookie;
-	rmb();
-	last_used = chan->cookie;
-	BUG_ON(last_complete < 0);
-	dma_set_tx_state(txstate, last_complete, last_used, 0);
-
 	spin_lock_irqsave(&sh_chan->desc_lock, flags);
 
-	status = dma_async_is_complete(cookie, last_complete, last_used);
+	status = dma_cookie_status(chan, cookie, txstate);
 
 	/*
 	 * If we don't find cookie on the queue, it has been aborted and we have
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 7bb154a..a760d98 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -407,16 +407,13 @@ sirfsoc_dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 {
 	struct sirfsoc_dma_chan *schan = dma_chan_to_sirfsoc_dma_chan(chan);
 	unsigned long flags;
-	dma_cookie_t last_used;
-	dma_cookie_t last_complete;
+	enum dma_status ret;
 
 	spin_lock_irqsave(&schan->lock, flags);
-	last_used = schan->chan.cookie;
-	last_complete = schan->chan.completed_cookie;
+	ret = dma_cookie_status(chan, cookie, txstate);
 	spin_unlock_irqrestore(&schan->lock, flags);
 
-	dma_set_tx_state(txstate, last_complete, last_used, 0);
-	return dma_async_is_complete(cookie, last_complete, last_used);
+	return ret;
 }
 
 static struct dma_async_tx_descriptor *sirfsoc_dma_prep_interleaved(
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index c246375..07b82e3 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2332,25 +2332,19 @@ static enum dma_status d40_tx_status(struct dma_chan *chan,
 				     struct dma_tx_state *txstate)
 {
 	struct d40_chan *d40c = container_of(chan, struct d40_chan, chan);
-	dma_cookie_t last_used;
-	dma_cookie_t last_complete;
-	int ret;
+	enum dma_status ret;
 
 	if (d40c->phy_chan == NULL) {
 		chan_err(d40c, "Cannot read status of unallocated channel\n");
 		return -EINVAL;
 	}
 
-	last_complete = chan->completed_cookie;
-	last_used = chan->cookie;
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret != DMA_SUCCESS)
+		dma_set_residue(txstate, stedma40_residue(chan));
 
 	if (d40_is_paused(d40c))
 		ret = DMA_PAUSED;
-	else
-		ret = dma_async_is_complete(cookie, last_complete, last_used);
-
-	dma_set_tx_state(txstate, last_complete, last_used,
-			 stedma40_residue(chan));
 
 	return ret;
 }
diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 1845ac9..6383abb 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -513,18 +513,11 @@ static enum dma_status td_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 {
 	struct timb_dma_chan *td_chan =
 		container_of(chan, struct timb_dma_chan, chan);
-	dma_cookie_t		last_used;
-	dma_cookie_t		last_complete;
-	int			ret;
+	enum dma_status ret;
 
 	dev_dbg(chan2dev(chan), "%s: Entry\n", __func__);
 
-	last_complete = chan->completed_cookie;
-	last_used = chan->cookie;
-
-	ret = dma_async_is_complete(cookie, last_complete, last_used);
-
-	dma_set_tx_state(txstate, last_complete, last_used, 0);
+	ret = dma_cookie_status(chan, cookie, txstate);
 
 	dev_dbg(chan2dev(chan),
 		"%s: exit, ret: %d, last_complete: %d, last_used: %d\n",
diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index 8a5225b..bb7b3d9 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -959,27 +959,17 @@ txx9dmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 		   struct dma_tx_state *txstate)
 {
 	struct txx9dmac_chan *dc = to_txx9dmac_chan(chan);
-	dma_cookie_t last_used;
-	dma_cookie_t last_complete;
-	int ret;
+	enum dma_status ret;
 
-	last_complete = chan->completed_cookie;
-	last_used = chan->cookie;
-
-	ret = dma_async_is_complete(cookie, last_complete, last_used);
+	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret != DMA_SUCCESS) {
 		spin_lock_bh(&dc->lock);
 		txx9dmac_scan_descriptors(dc);
 		spin_unlock_bh(&dc->lock);
 
-		last_complete = chan->completed_cookie;
-		last_used = chan->cookie;
-
-		ret = dma_async_is_complete(cookie, last_complete, last_used);
+		ret = dma_cookie_status(chan, cookie, txstate);
 	}
 
-	dma_set_tx_state(txstate, last_complete, last_used, 0);
-
 	return ret;
 }
 
-- 
1.7.4.4
