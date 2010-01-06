Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id D7CB7B6F17
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 10:34:09 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: dan.j.williams@intel.com
Subject: [PATCH 7/8] fsldma: rename fsl_chan to chan
Date: Wed,  6 Jan 2010 15:34:05 -0800
Message-Id: <1262820846-13198-8-git-send-email-iws@ovro.caltech.edu>
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

The name fsl_chan seems too long, so it has been shortened to chan. There
are only a few places where the higher level "struct dma_chan *chan" name
conflicts. These have been changed to "struct dma_chan *dchan" instead.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |  550 +++++++++++++++++++++++++-------------------------
 1 files changed, 275 insertions(+), 275 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 6a90592..7b5f88c 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -37,19 +37,19 @@
 #include <asm/fsldma.h>
 #include "fsldma.h"
 
-static void dma_init(struct fsldma_chan *fsl_chan)
+static void dma_init(struct fsldma_chan *chan)
 {
 	/* Reset the channel */
-	DMA_OUT(fsl_chan, &fsl_chan->regs->mr, 0, 32);
+	DMA_OUT(chan, &chan->regs->mr, 0, 32);
 
-	switch (fsl_chan->feature & FSL_DMA_IP_MASK) {
+	switch (chan->feature & FSL_DMA_IP_MASK) {
 	case FSL_DMA_IP_85XX:
 		/* Set the channel to below modes:
 		 * EIE - Error interrupt enable
 		 * EOSIE - End of segments interrupt enable (basic mode)
 		 * EOLNIE - End of links interrupt enable
 		 */
-		DMA_OUT(fsl_chan, &fsl_chan->regs->mr, FSL_DMA_MR_EIE
+		DMA_OUT(chan, &chan->regs->mr, FSL_DMA_MR_EIE
 				| FSL_DMA_MR_EOLNIE | FSL_DMA_MR_EOSIE, 32);
 		break;
 	case FSL_DMA_IP_83XX:
@@ -57,154 +57,154 @@ static void dma_init(struct fsldma_chan *fsl_chan)
 		 * EOTIE - End-of-transfer interrupt enable
 		 * PRC_RM - PCI read multiple
 		 */
-		DMA_OUT(fsl_chan, &fsl_chan->regs->mr, FSL_DMA_MR_EOTIE
+		DMA_OUT(chan, &chan->regs->mr, FSL_DMA_MR_EOTIE
 				| FSL_DMA_MR_PRC_RM, 32);
 		break;
 	}
 
 }
 
-static void set_sr(struct fsldma_chan *fsl_chan, u32 val)
+static void set_sr(struct fsldma_chan *chan, u32 val)
 {
-	DMA_OUT(fsl_chan, &fsl_chan->regs->sr, val, 32);
+	DMA_OUT(chan, &chan->regs->sr, val, 32);
 }
 
-static u32 get_sr(struct fsldma_chan *fsl_chan)
+static u32 get_sr(struct fsldma_chan *chan)
 {
-	return DMA_IN(fsl_chan, &fsl_chan->regs->sr, 32);
+	return DMA_IN(chan, &chan->regs->sr, 32);
 }
 
-static void set_desc_cnt(struct fsldma_chan *fsl_chan,
+static void set_desc_cnt(struct fsldma_chan *chan,
 				struct fsl_dma_ld_hw *hw, u32 count)
 {
-	hw->count = CPU_TO_DMA(fsl_chan, count, 32);
+	hw->count = CPU_TO_DMA(chan, count, 32);
 }
 
-static void set_desc_src(struct fsldma_chan *fsl_chan,
+static void set_desc_src(struct fsldma_chan *chan,
 				struct fsl_dma_ld_hw *hw, dma_addr_t src)
 {
 	u64 snoop_bits;
 
-	snoop_bits = ((fsl_chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_85XX)
+	snoop_bits = ((chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_85XX)
 		? ((u64)FSL_DMA_SATR_SREADTYPE_SNOOP_READ << 32) : 0;
-	hw->src_addr = CPU_TO_DMA(fsl_chan, snoop_bits | src, 64);
+	hw->src_addr = CPU_TO_DMA(chan, snoop_bits | src, 64);
 }
 
-static void set_desc_dst(struct fsldma_chan *fsl_chan,
+static void set_desc_dst(struct fsldma_chan *chan,
 				struct fsl_dma_ld_hw *hw, dma_addr_t dst)
 {
 	u64 snoop_bits;
 
-	snoop_bits = ((fsl_chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_85XX)
+	snoop_bits = ((chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_85XX)
 		? ((u64)FSL_DMA_DATR_DWRITETYPE_SNOOP_WRITE << 32) : 0;
-	hw->dst_addr = CPU_TO_DMA(fsl_chan, snoop_bits | dst, 64);
+	hw->dst_addr = CPU_TO_DMA(chan, snoop_bits | dst, 64);
 }
 
-static void set_desc_next(struct fsldma_chan *fsl_chan,
+static void set_desc_next(struct fsldma_chan *chan,
 				struct fsl_dma_ld_hw *hw, dma_addr_t next)
 {
 	u64 snoop_bits;
 
-	snoop_bits = ((fsl_chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_83XX)
+	snoop_bits = ((chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_83XX)
 		? FSL_DMA_SNEN : 0;
-	hw->next_ln_addr = CPU_TO_DMA(fsl_chan, snoop_bits | next, 64);
+	hw->next_ln_addr = CPU_TO_DMA(chan, snoop_bits | next, 64);
 }
 
-static void set_cdar(struct fsldma_chan *fsl_chan, dma_addr_t addr)
+static void set_cdar(struct fsldma_chan *chan, dma_addr_t addr)
 {
-	DMA_OUT(fsl_chan, &fsl_chan->regs->cdar, addr | FSL_DMA_SNEN, 64);
+	DMA_OUT(chan, &chan->regs->cdar, addr | FSL_DMA_SNEN, 64);
 }
 
-static dma_addr_t get_cdar(struct fsldma_chan *fsl_chan)
+static dma_addr_t get_cdar(struct fsldma_chan *chan)
 {
-	return DMA_IN(fsl_chan, &fsl_chan->regs->cdar, 64) & ~FSL_DMA_SNEN;
+	return DMA_IN(chan, &chan->regs->cdar, 64) & ~FSL_DMA_SNEN;
 }
 
-static void set_ndar(struct fsldma_chan *fsl_chan, dma_addr_t addr)
+static void set_ndar(struct fsldma_chan *chan, dma_addr_t addr)
 {
-	DMA_OUT(fsl_chan, &fsl_chan->regs->ndar, addr, 64);
+	DMA_OUT(chan, &chan->regs->ndar, addr, 64);
 }
 
-static dma_addr_t get_ndar(struct fsldma_chan *fsl_chan)
+static dma_addr_t get_ndar(struct fsldma_chan *chan)
 {
-	return DMA_IN(fsl_chan, &fsl_chan->regs->ndar, 64);
+	return DMA_IN(chan, &chan->regs->ndar, 64);
 }
 
-static u32 get_bcr(struct fsldma_chan *fsl_chan)
+static u32 get_bcr(struct fsldma_chan *chan)
 {
-	return DMA_IN(fsl_chan, &fsl_chan->regs->bcr, 32);
+	return DMA_IN(chan, &chan->regs->bcr, 32);
 }
 
-static int dma_is_idle(struct fsldma_chan *fsl_chan)
+static int dma_is_idle(struct fsldma_chan *chan)
 {
-	u32 sr = get_sr(fsl_chan);
+	u32 sr = get_sr(chan);
 	return (!(sr & FSL_DMA_SR_CB)) || (sr & FSL_DMA_SR_CH);
 }
 
-static void dma_start(struct fsldma_chan *fsl_chan)
+static void dma_start(struct fsldma_chan *chan)
 {
 	u32 mode;
 
-	mode = DMA_IN(fsl_chan, &fsl_chan->regs->mr, 32);
+	mode = DMA_IN(chan, &chan->regs->mr, 32);
 
-	if ((fsl_chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_85XX) {
-		if (fsl_chan->feature & FSL_DMA_CHAN_PAUSE_EXT) {
-			DMA_OUT(fsl_chan, &fsl_chan->regs->bcr, 0, 32);
+	if ((chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_85XX) {
+		if (chan->feature & FSL_DMA_CHAN_PAUSE_EXT) {
+			DMA_OUT(chan, &chan->regs->bcr, 0, 32);
 			mode |= FSL_DMA_MR_EMP_EN;
 		} else {
 			mode &= ~FSL_DMA_MR_EMP_EN;
 		}
 	}
 
-	if (fsl_chan->feature & FSL_DMA_CHAN_START_EXT)
+	if (chan->feature & FSL_DMA_CHAN_START_EXT)
 		mode |= FSL_DMA_MR_EMS_EN;
 	else
 		mode |= FSL_DMA_MR_CS;
 
-	DMA_OUT(fsl_chan, &fsl_chan->regs->mr, mode, 32);
+	DMA_OUT(chan, &chan->regs->mr, mode, 32);
 }
 
-static void dma_halt(struct fsldma_chan *fsl_chan)
+static void dma_halt(struct fsldma_chan *chan)
 {
 	u32 mode;
 	int i;
 
-	mode = DMA_IN(fsl_chan, &fsl_chan->regs->mr, 32);
+	mode = DMA_IN(chan, &chan->regs->mr, 32);
 	mode |= FSL_DMA_MR_CA;
-	DMA_OUT(fsl_chan, &fsl_chan->regs->mr, mode, 32);
+	DMA_OUT(chan, &chan->regs->mr, mode, 32);
 
 	mode &= ~(FSL_DMA_MR_CS | FSL_DMA_MR_EMS_EN | FSL_DMA_MR_CA);
-	DMA_OUT(fsl_chan, &fsl_chan->regs->mr, mode, 32);
+	DMA_OUT(chan, &chan->regs->mr, mode, 32);
 
 	for (i = 0; i < 100; i++) {
-		if (dma_is_idle(fsl_chan))
+		if (dma_is_idle(chan))
 			break;
 		udelay(10);
 	}
 
-	if (i >= 100 && !dma_is_idle(fsl_chan))
-		dev_err(fsl_chan->dev, "DMA halt timeout!\n");
+	if (i >= 100 && !dma_is_idle(chan))
+		dev_err(chan->dev, "DMA halt timeout!\n");
 }
 
-static void set_ld_eol(struct fsldma_chan *fsl_chan,
+static void set_ld_eol(struct fsldma_chan *chan,
 			struct fsl_desc_sw *desc)
 {
 	u64 snoop_bits;
 
-	snoop_bits = ((fsl_chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_83XX)
+	snoop_bits = ((chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_83XX)
 		? FSL_DMA_SNEN : 0;
 
-	desc->hw.next_ln_addr = CPU_TO_DMA(fsl_chan,
-		DMA_TO_CPU(fsl_chan, desc->hw.next_ln_addr, 64) | FSL_DMA_EOL
+	desc->hw.next_ln_addr = CPU_TO_DMA(chan,
+		DMA_TO_CPU(chan, desc->hw.next_ln_addr, 64) | FSL_DMA_EOL
 			| snoop_bits, 64);
 }
 
-static void append_ld_queue(struct fsldma_chan *fsl_chan,
+static void append_ld_queue(struct fsldma_chan *chan,
 		struct fsl_desc_sw *new_desc)
 {
-	struct fsl_desc_sw *queue_tail = to_fsl_desc(fsl_chan->ld_queue.prev);
+	struct fsl_desc_sw *queue_tail = to_fsl_desc(chan->ld_queue.prev);
 
-	if (list_empty(&fsl_chan->ld_queue))
+	if (list_empty(&chan->ld_queue))
 		return;
 
 	/* Link to the new descriptor physical address and
@@ -214,15 +214,15 @@ static void append_ld_queue(struct fsldma_chan *fsl_chan,
 	 *
 	 * For FSL_DMA_IP_83xx, the snoop enable bit need be set.
 	 */
-	queue_tail->hw.next_ln_addr = CPU_TO_DMA(fsl_chan,
+	queue_tail->hw.next_ln_addr = CPU_TO_DMA(chan,
 			new_desc->async_tx.phys | FSL_DMA_EOSIE |
-			(((fsl_chan->feature & FSL_DMA_IP_MASK)
+			(((chan->feature & FSL_DMA_IP_MASK)
 				== FSL_DMA_IP_83XX) ? FSL_DMA_SNEN : 0), 64);
 }
 
 /**
  * fsl_chan_set_src_loop_size - Set source address hold transfer size
- * @fsl_chan : Freescale DMA channel
+ * @chan : Freescale DMA channel
  * @size     : Address loop size, 0 for disable loop
  *
  * The set source address hold transfer size. The source
@@ -231,11 +231,11 @@ static void append_ld_queue(struct fsldma_chan *fsl_chan,
  * read data from SA, SA + 1, SA + 2, SA + 3, then loop back to SA,
  * SA + 1 ... and so on.
  */
-static void fsl_chan_set_src_loop_size(struct fsldma_chan *fsl_chan, int size)
+static void fsl_chan_set_src_loop_size(struct fsldma_chan *chan, int size)
 {
 	u32 mode;
 
-	mode = DMA_IN(fsl_chan, &fsl_chan->regs->mr, 32);
+	mode = DMA_IN(chan, &chan->regs->mr, 32);
 
 	switch (size) {
 	case 0:
@@ -249,12 +249,12 @@ static void fsl_chan_set_src_loop_size(struct fsldma_chan *fsl_chan, int size)
 		break;
 	}
 
-	DMA_OUT(fsl_chan, &fsl_chan->regs->mr, mode, 32);
+	DMA_OUT(chan, &chan->regs->mr, mode, 32);
 }
 
 /**
  * fsl_chan_set_dst_loop_size - Set destination address hold transfer size
- * @fsl_chan : Freescale DMA channel
+ * @chan : Freescale DMA channel
  * @size     : Address loop size, 0 for disable loop
  *
  * The set destination address hold transfer size. The destination
@@ -263,11 +263,11 @@ static void fsl_chan_set_src_loop_size(struct fsldma_chan *fsl_chan, int size)
  * write data to TA, TA + 1, TA + 2, TA + 3, then loop back to TA,
  * TA + 1 ... and so on.
  */
-static void fsl_chan_set_dst_loop_size(struct fsldma_chan *fsl_chan, int size)
+static void fsl_chan_set_dst_loop_size(struct fsldma_chan *chan, int size)
 {
 	u32 mode;
 
-	mode = DMA_IN(fsl_chan, &fsl_chan->regs->mr, 32);
+	mode = DMA_IN(chan, &chan->regs->mr, 32);
 
 	switch (size) {
 	case 0:
@@ -281,12 +281,12 @@ static void fsl_chan_set_dst_loop_size(struct fsldma_chan *fsl_chan, int size)
 		break;
 	}
 
-	DMA_OUT(fsl_chan, &fsl_chan->regs->mr, mode, 32);
+	DMA_OUT(chan, &chan->regs->mr, mode, 32);
 }
 
 /**
  * fsl_chan_set_request_count - Set DMA Request Count for external control
- * @fsl_chan : Freescale DMA channel
+ * @chan : Freescale DMA channel
  * @size     : Number of bytes to transfer in a single request
  *
  * The Freescale DMA channel can be controlled by the external signal DREQ#.
@@ -296,38 +296,38 @@ static void fsl_chan_set_dst_loop_size(struct fsldma_chan *fsl_chan, int size)
  *
  * A size of 0 disables external pause control. The maximum size is 1024.
  */
-static void fsl_chan_set_request_count(struct fsldma_chan *fsl_chan, int size)
+static void fsl_chan_set_request_count(struct fsldma_chan *chan, int size)
 {
 	u32 mode;
 
 	BUG_ON(size > 1024);
 
-	mode = DMA_IN(fsl_chan, &fsl_chan->regs->mr, 32);
+	mode = DMA_IN(chan, &chan->regs->mr, 32);
 	mode |= (__ilog2(size) << 24) & 0x0f000000;
 
-	DMA_OUT(fsl_chan, &fsl_chan->regs->mr, mode, 32);
+	DMA_OUT(chan, &chan->regs->mr, mode, 32);
 }
 
 /**
  * fsl_chan_toggle_ext_pause - Toggle channel external pause status
- * @fsl_chan : Freescale DMA channel
+ * @chan : Freescale DMA channel
  * @enable   : 0 is disabled, 1 is enabled.
  *
  * The Freescale DMA channel can be controlled by the external signal DREQ#.
  * The DMA Request Count feature should be used in addition to this feature
  * to set the number of bytes to transfer before pausing the channel.
  */
-static void fsl_chan_toggle_ext_pause(struct fsldma_chan *fsl_chan, int enable)
+static void fsl_chan_toggle_ext_pause(struct fsldma_chan *chan, int enable)
 {
 	if (enable)
-		fsl_chan->feature |= FSL_DMA_CHAN_PAUSE_EXT;
+		chan->feature |= FSL_DMA_CHAN_PAUSE_EXT;
 	else
-		fsl_chan->feature &= ~FSL_DMA_CHAN_PAUSE_EXT;
+		chan->feature &= ~FSL_DMA_CHAN_PAUSE_EXT;
 }
 
 /**
  * fsl_chan_toggle_ext_start - Toggle channel external start status
- * @fsl_chan : Freescale DMA channel
+ * @chan : Freescale DMA channel
  * @enable   : 0 is disabled, 1 is enabled.
  *
  * If enable the external start, the channel can be started by an
@@ -335,26 +335,26 @@ static void fsl_chan_toggle_ext_pause(struct fsldma_chan *fsl_chan, int enable)
  * transfer immediately. The DMA channel will wait for the
  * control pin asserted.
  */
-static void fsl_chan_toggle_ext_start(struct fsldma_chan *fsl_chan, int enable)
+static void fsl_chan_toggle_ext_start(struct fsldma_chan *chan, int enable)
 {
 	if (enable)
-		fsl_chan->feature |= FSL_DMA_CHAN_START_EXT;
+		chan->feature |= FSL_DMA_CHAN_START_EXT;
 	else
-		fsl_chan->feature &= ~FSL_DMA_CHAN_START_EXT;
+		chan->feature &= ~FSL_DMA_CHAN_START_EXT;
 }
 
 static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 {
-	struct fsldma_chan *fsl_chan = to_fsl_chan(tx->chan);
+	struct fsldma_chan *chan = to_fsl_chan(tx->chan);
 	struct fsl_desc_sw *desc = tx_to_fsl_desc(tx);
 	struct fsl_desc_sw *child;
 	unsigned long flags;
 	dma_cookie_t cookie;
 
 	/* cookie increment and adding to ld_queue must be atomic */
-	spin_lock_irqsave(&fsl_chan->desc_lock, flags);
+	spin_lock_irqsave(&chan->desc_lock, flags);
 
-	cookie = fsl_chan->common.cookie;
+	cookie = chan->common.cookie;
 	list_for_each_entry(child, &desc->tx_list, node) {
 		cookie++;
 		if (cookie < 0)
@@ -363,33 +363,33 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 		desc->async_tx.cookie = cookie;
 	}
 
-	fsl_chan->common.cookie = cookie;
-	append_ld_queue(fsl_chan, desc);
-	list_splice_init(&desc->tx_list, fsl_chan->ld_queue.prev);
+	chan->common.cookie = cookie;
+	append_ld_queue(chan, desc);
+	list_splice_init(&desc->tx_list, chan->ld_queue.prev);
 
-	spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
+	spin_unlock_irqrestore(&chan->desc_lock, flags);
 
 	return cookie;
 }
 
 /**
  * fsl_dma_alloc_descriptor - Allocate descriptor from channel's DMA pool.
- * @fsl_chan : Freescale DMA channel
+ * @chan : Freescale DMA channel
  *
  * Return - The descriptor allocated. NULL for failed.
  */
 static struct fsl_desc_sw *fsl_dma_alloc_descriptor(
-					struct fsldma_chan *fsl_chan)
+					struct fsldma_chan *chan)
 {
 	dma_addr_t pdesc;
 	struct fsl_desc_sw *desc_sw;
 
-	desc_sw = dma_pool_alloc(fsl_chan->desc_pool, GFP_ATOMIC, &pdesc);
+	desc_sw = dma_pool_alloc(chan->desc_pool, GFP_ATOMIC, &pdesc);
 	if (desc_sw) {
 		memset(desc_sw, 0, sizeof(struct fsl_desc_sw));
 		INIT_LIST_HEAD(&desc_sw->tx_list);
 		dma_async_tx_descriptor_init(&desc_sw->async_tx,
-						&fsl_chan->common);
+						&chan->common);
 		desc_sw->async_tx.tx_submit = fsl_dma_tx_submit;
 		desc_sw->async_tx.phys = pdesc;
 	}
@@ -400,29 +400,29 @@ static struct fsl_desc_sw *fsl_dma_alloc_descriptor(
 
 /**
  * fsl_dma_alloc_chan_resources - Allocate resources for DMA channel.
- * @fsl_chan : Freescale DMA channel
+ * @chan : Freescale DMA channel
  *
  * This function will create a dma pool for descriptor allocation.
  *
  * Return - The number of descriptors allocated.
  */
-static int fsl_dma_alloc_chan_resources(struct dma_chan *chan)
+static int fsl_dma_alloc_chan_resources(struct dma_chan *dchan)
 {
-	struct fsldma_chan *fsl_chan = to_fsl_chan(chan);
+	struct fsldma_chan *chan = to_fsl_chan(dchan);
 
 	/* Has this channel already been allocated? */
-	if (fsl_chan->desc_pool)
+	if (chan->desc_pool)
 		return 1;
 
 	/* We need the descriptor to be aligned to 32bytes
 	 * for meeting FSL DMA specification requirement.
 	 */
-	fsl_chan->desc_pool = dma_pool_create("fsl_dma_engine_desc_pool",
-			fsl_chan->dev, sizeof(struct fsl_desc_sw),
+	chan->desc_pool = dma_pool_create("fsl_dma_engine_desc_pool",
+			chan->dev, sizeof(struct fsl_desc_sw),
 			32, 0);
-	if (!fsl_chan->desc_pool) {
-		dev_err(fsl_chan->dev, "No memory for channel %d "
-			"descriptor dma pool.\n", fsl_chan->id);
+	if (!chan->desc_pool) {
+		dev_err(chan->dev, "No memory for channel %d "
+			"descriptor dma pool.\n", chan->id);
 		return 0;
 	}
 
@@ -431,45 +431,45 @@ static int fsl_dma_alloc_chan_resources(struct dma_chan *chan)
 
 /**
  * fsl_dma_free_chan_resources - Free all resources of the channel.
- * @fsl_chan : Freescale DMA channel
+ * @chan : Freescale DMA channel
  */
-static void fsl_dma_free_chan_resources(struct dma_chan *chan)
+static void fsl_dma_free_chan_resources(struct dma_chan *dchan)
 {
-	struct fsldma_chan *fsl_chan = to_fsl_chan(chan);
+	struct fsldma_chan *chan = to_fsl_chan(dchan);
 	struct fsl_desc_sw *desc, *_desc;
 	unsigned long flags;
 
-	dev_dbg(fsl_chan->dev, "Free all channel resources.\n");
-	spin_lock_irqsave(&fsl_chan->desc_lock, flags);
-	list_for_each_entry_safe(desc, _desc, &fsl_chan->ld_queue, node) {
+	dev_dbg(chan->dev, "Free all channel resources.\n");
+	spin_lock_irqsave(&chan->desc_lock, flags);
+	list_for_each_entry_safe(desc, _desc, &chan->ld_queue, node) {
 #ifdef FSL_DMA_LD_DEBUG
-		dev_dbg(fsl_chan->dev,
+		dev_dbg(chan->dev,
 				"LD %p will be released.\n", desc);
 #endif
 		list_del(&desc->node);
 		/* free link descriptor */
-		dma_pool_free(fsl_chan->desc_pool, desc, desc->async_tx.phys);
+		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
 	}
-	spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
-	dma_pool_destroy(fsl_chan->desc_pool);
+	spin_unlock_irqrestore(&chan->desc_lock, flags);
+	dma_pool_destroy(chan->desc_pool);
 
-	fsl_chan->desc_pool = NULL;
+	chan->desc_pool = NULL;
 }
 
 static struct dma_async_tx_descriptor *
-fsl_dma_prep_interrupt(struct dma_chan *chan, unsigned long flags)
+fsl_dma_prep_interrupt(struct dma_chan *dchan, unsigned long flags)
 {
-	struct fsldma_chan *fsl_chan;
+	struct fsldma_chan *chan;
 	struct fsl_desc_sw *new;
 
-	if (!chan)
+	if (!dchan)
 		return NULL;
 
-	fsl_chan = to_fsl_chan(chan);
+	chan = to_fsl_chan(dchan);
 
-	new = fsl_dma_alloc_descriptor(fsl_chan);
+	new = fsl_dma_alloc_descriptor(chan);
 	if (!new) {
-		dev_err(fsl_chan->dev, "No free memory for link descriptor\n");
+		dev_err(chan->dev, "No free memory for link descriptor\n");
 		return NULL;
 	}
 
@@ -480,51 +480,51 @@ fsl_dma_prep_interrupt(struct dma_chan *chan, unsigned long flags)
 	list_add_tail(&new->node, &new->tx_list);
 
 	/* Set End-of-link to the last link descriptor of new list*/
-	set_ld_eol(fsl_chan, new);
+	set_ld_eol(chan, new);
 
 	return &new->async_tx;
 }
 
 static struct dma_async_tx_descriptor *fsl_dma_prep_memcpy(
-	struct dma_chan *chan, dma_addr_t dma_dst, dma_addr_t dma_src,
+	struct dma_chan *dchan, dma_addr_t dma_dst, dma_addr_t dma_src,
 	size_t len, unsigned long flags)
 {
-	struct fsldma_chan *fsl_chan;
+	struct fsldma_chan *chan;
 	struct fsl_desc_sw *first = NULL, *prev = NULL, *new;
 	struct list_head *list;
 	size_t copy;
 
-	if (!chan)
+	if (!dchan)
 		return NULL;
 
 	if (!len)
 		return NULL;
 
-	fsl_chan = to_fsl_chan(chan);
+	chan = to_fsl_chan(dchan);
 
 	do {
 
 		/* Allocate the link descriptor from DMA pool */
-		new = fsl_dma_alloc_descriptor(fsl_chan);
+		new = fsl_dma_alloc_descriptor(chan);
 		if (!new) {
-			dev_err(fsl_chan->dev,
+			dev_err(chan->dev,
 					"No free memory for link descriptor\n");
 			goto fail;
 		}
 #ifdef FSL_DMA_LD_DEBUG
-		dev_dbg(fsl_chan->dev, "new link desc alloc %p\n", new);
+		dev_dbg(chan->dev, "new link desc alloc %p\n", new);
 #endif
 
 		copy = min(len, (size_t)FSL_DMA_BCR_MAX_CNT);
 
-		set_desc_cnt(fsl_chan, &new->hw, copy);
-		set_desc_src(fsl_chan, &new->hw, dma_src);
-		set_desc_dst(fsl_chan, &new->hw, dma_dst);
+		set_desc_cnt(chan, &new->hw, copy);
+		set_desc_src(chan, &new->hw, dma_src);
+		set_desc_dst(chan, &new->hw, dma_dst);
 
 		if (!first)
 			first = new;
 		else
-			set_desc_next(fsl_chan, &prev->hw, new->async_tx.phys);
+			set_desc_next(chan, &prev->hw, new->async_tx.phys);
 
 		new->async_tx.cookie = 0;
 		async_tx_ack(&new->async_tx);
@@ -542,7 +542,7 @@ static struct dma_async_tx_descriptor *fsl_dma_prep_memcpy(
 	new->async_tx.cookie = -EBUSY;
 
 	/* Set End-of-link to the last link descriptor of new list*/
-	set_ld_eol(fsl_chan, new);
+	set_ld_eol(chan, new);
 
 	return &first->async_tx;
 
@@ -553,7 +553,7 @@ fail:
 	list = &first->tx_list;
 	list_for_each_entry_safe_reverse(new, prev, list, node) {
 		list_del(&new->node);
-		dma_pool_free(fsl_chan->desc_pool, new, new->async_tx.phys);
+		dma_pool_free(chan->desc_pool, new, new->async_tx.phys);
 	}
 
 	return NULL;
@@ -572,10 +572,10 @@ fail:
  * chan->private variable.
  */
 static struct dma_async_tx_descriptor *fsl_dma_prep_slave_sg(
-	struct dma_chan *chan, struct scatterlist *sgl, unsigned int sg_len,
+	struct dma_chan *dchan, struct scatterlist *sgl, unsigned int sg_len,
 	enum dma_data_direction direction, unsigned long flags)
 {
-	struct fsldma_chan *fsl_chan;
+	struct fsldma_chan *chan;
 	struct fsl_desc_sw *first = NULL, *prev = NULL, *new = NULL;
 	struct fsl_dma_slave *slave;
 	struct list_head *tx_list;
@@ -588,14 +588,14 @@ static struct dma_async_tx_descriptor *fsl_dma_prep_slave_sg(
 	struct fsl_dma_hw_addr *hw;
 	dma_addr_t dma_dst, dma_src;
 
-	if (!chan)
+	if (!dchan)
 		return NULL;
 
-	if (!chan->private)
+	if (!dchan->private)
 		return NULL;
 
-	fsl_chan = to_fsl_chan(chan);
-	slave = chan->private;
+	chan = to_fsl_chan(dchan);
+	slave = dchan->private;
 
 	if (list_empty(&slave->addresses))
 		return NULL;
@@ -644,14 +644,14 @@ static struct dma_async_tx_descriptor *fsl_dma_prep_slave_sg(
 			}
 
 			/* Allocate the link descriptor from DMA pool */
-			new = fsl_dma_alloc_descriptor(fsl_chan);
+			new = fsl_dma_alloc_descriptor(chan);
 			if (!new) {
-				dev_err(fsl_chan->dev, "No free memory for "
+				dev_err(chan->dev, "No free memory for "
 						       "link descriptor\n");
 				goto fail;
 			}
 #ifdef FSL_DMA_LD_DEBUG
-			dev_dbg(fsl_chan->dev, "new link desc alloc %p\n", new);
+			dev_dbg(chan->dev, "new link desc alloc %p\n", new);
 #endif
 
 			/*
@@ -678,9 +678,9 @@ static struct dma_async_tx_descriptor *fsl_dma_prep_slave_sg(
 			}
 
 			/* Fill in the descriptor */
-			set_desc_cnt(fsl_chan, &new->hw, copy);
-			set_desc_src(fsl_chan, &new->hw, dma_src);
-			set_desc_dst(fsl_chan, &new->hw, dma_dst);
+			set_desc_cnt(chan, &new->hw, copy);
+			set_desc_src(chan, &new->hw, dma_src);
+			set_desc_dst(chan, &new->hw, dma_dst);
 
 			/*
 			 * If this is not the first descriptor, chain the
@@ -689,7 +689,7 @@ static struct dma_async_tx_descriptor *fsl_dma_prep_slave_sg(
 			if (!first) {
 				first = new;
 			} else {
-				set_desc_next(fsl_chan, &prev->hw,
+				set_desc_next(chan, &prev->hw,
 					      new->async_tx.phys);
 			}
 
@@ -715,23 +715,23 @@ finished:
 	new->async_tx.cookie = -EBUSY;
 
 	/* Set End-of-link to the last link descriptor of new list */
-	set_ld_eol(fsl_chan, new);
+	set_ld_eol(chan, new);
 
 	/* Enable extra controller features */
-	if (fsl_chan->set_src_loop_size)
-		fsl_chan->set_src_loop_size(fsl_chan, slave->src_loop_size);
+	if (chan->set_src_loop_size)
+		chan->set_src_loop_size(chan, slave->src_loop_size);
 
-	if (fsl_chan->set_dst_loop_size)
-		fsl_chan->set_dst_loop_size(fsl_chan, slave->dst_loop_size);
+	if (chan->set_dst_loop_size)
+		chan->set_dst_loop_size(chan, slave->dst_loop_size);
 
-	if (fsl_chan->toggle_ext_start)
-		fsl_chan->toggle_ext_start(fsl_chan, slave->external_start);
+	if (chan->toggle_ext_start)
+		chan->toggle_ext_start(chan, slave->external_start);
 
-	if (fsl_chan->toggle_ext_pause)
-		fsl_chan->toggle_ext_pause(fsl_chan, slave->external_pause);
+	if (chan->toggle_ext_pause)
+		chan->toggle_ext_pause(chan, slave->external_pause);
 
-	if (fsl_chan->set_request_count)
-		fsl_chan->set_request_count(fsl_chan, slave->request_count);
+	if (chan->set_request_count)
+		chan->set_request_count(chan, slave->request_count);
 
 	return &first->async_tx;
 
@@ -751,62 +751,62 @@ fail:
 	tx_list = &first->tx_list;
 	list_for_each_entry_safe_reverse(new, prev, tx_list, node) {
 		list_del_init(&new->node);
-		dma_pool_free(fsl_chan->desc_pool, new, new->async_tx.phys);
+		dma_pool_free(chan->desc_pool, new, new->async_tx.phys);
 	}
 
 	return NULL;
 }
 
-static void fsl_dma_device_terminate_all(struct dma_chan *chan)
+static void fsl_dma_device_terminate_all(struct dma_chan *dchan)
 {
-	struct fsldma_chan *fsl_chan;
+	struct fsldma_chan *chan;
 	struct fsl_desc_sw *desc, *tmp;
 	unsigned long flags;
 
-	if (!chan)
+	if (!dchan)
 		return;
 
-	fsl_chan = to_fsl_chan(chan);
+	chan = to_fsl_chan(dchan);
 
 	/* Halt the DMA engine */
-	dma_halt(fsl_chan);
+	dma_halt(chan);
 
-	spin_lock_irqsave(&fsl_chan->desc_lock, flags);
+	spin_lock_irqsave(&chan->desc_lock, flags);
 
 	/* Remove and free all of the descriptors in the LD queue */
-	list_for_each_entry_safe(desc, tmp, &fsl_chan->ld_queue, node) {
+	list_for_each_entry_safe(desc, tmp, &chan->ld_queue, node) {
 		list_del(&desc->node);
-		dma_pool_free(fsl_chan->desc_pool, desc, desc->async_tx.phys);
+		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
 	}
 
-	spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
+	spin_unlock_irqrestore(&chan->desc_lock, flags);
 }
 
 /**
  * fsl_dma_update_completed_cookie - Update the completed cookie.
- * @fsl_chan : Freescale DMA channel
+ * @chan : Freescale DMA channel
  */
-static void fsl_dma_update_completed_cookie(struct fsldma_chan *fsl_chan)
+static void fsl_dma_update_completed_cookie(struct fsldma_chan *chan)
 {
 	struct fsl_desc_sw *cur_desc, *desc;
 	dma_addr_t ld_phy;
 
-	ld_phy = get_cdar(fsl_chan) & FSL_DMA_NLDA_MASK;
+	ld_phy = get_cdar(chan) & FSL_DMA_NLDA_MASK;
 
 	if (ld_phy) {
 		cur_desc = NULL;
-		list_for_each_entry(desc, &fsl_chan->ld_queue, node)
+		list_for_each_entry(desc, &chan->ld_queue, node)
 			if (desc->async_tx.phys == ld_phy) {
 				cur_desc = desc;
 				break;
 			}
 
 		if (cur_desc && cur_desc->async_tx.cookie) {
-			if (dma_is_idle(fsl_chan))
-				fsl_chan->completed_cookie =
+			if (dma_is_idle(chan))
+				chan->completed_cookie =
 					cur_desc->async_tx.cookie;
 			else
-				fsl_chan->completed_cookie =
+				chan->completed_cookie =
 					cur_desc->async_tx.cookie - 1;
 		}
 	}
@@ -814,27 +814,27 @@ static void fsl_dma_update_completed_cookie(struct fsldma_chan *fsl_chan)
 
 /**
  * fsl_chan_ld_cleanup - Clean up link descriptors
- * @fsl_chan : Freescale DMA channel
+ * @chan : Freescale DMA channel
  *
  * This function clean up the ld_queue of DMA channel.
  * If 'in_intr' is set, the function will move the link descriptor to
  * the recycle list. Otherwise, free it directly.
  */
-static void fsl_chan_ld_cleanup(struct fsldma_chan *fsl_chan)
+static void fsl_chan_ld_cleanup(struct fsldma_chan *chan)
 {
 	struct fsl_desc_sw *desc, *_desc;
 	unsigned long flags;
 
-	spin_lock_irqsave(&fsl_chan->desc_lock, flags);
+	spin_lock_irqsave(&chan->desc_lock, flags);
 
-	dev_dbg(fsl_chan->dev, "chan completed_cookie = %d\n",
-			fsl_chan->completed_cookie);
-	list_for_each_entry_safe(desc, _desc, &fsl_chan->ld_queue, node) {
+	dev_dbg(chan->dev, "chan completed_cookie = %d\n",
+			chan->completed_cookie);
+	list_for_each_entry_safe(desc, _desc, &chan->ld_queue, node) {
 		dma_async_tx_callback callback;
 		void *callback_param;
 
 		if (dma_async_is_complete(desc->async_tx.cookie,
-			    fsl_chan->completed_cookie, fsl_chan->common.cookie)
+			    chan->completed_cookie, chan->common.cookie)
 				== DMA_IN_PROGRESS)
 			break;
 
@@ -844,119 +844,119 @@ static void fsl_chan_ld_cleanup(struct fsldma_chan *fsl_chan)
 		/* Remove from ld_queue list */
 		list_del(&desc->node);
 
-		dev_dbg(fsl_chan->dev, "link descriptor %p will be recycle.\n",
+		dev_dbg(chan->dev, "link descriptor %p will be recycle.\n",
 				desc);
-		dma_pool_free(fsl_chan->desc_pool, desc, desc->async_tx.phys);
+		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
 
 		/* Run the link descriptor callback function */
 		if (callback) {
-			spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
-			dev_dbg(fsl_chan->dev, "link descriptor %p callback\n",
+			spin_unlock_irqrestore(&chan->desc_lock, flags);
+			dev_dbg(chan->dev, "link descriptor %p callback\n",
 					desc);
 			callback(callback_param);
-			spin_lock_irqsave(&fsl_chan->desc_lock, flags);
+			spin_lock_irqsave(&chan->desc_lock, flags);
 		}
 	}
-	spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
+	spin_unlock_irqrestore(&chan->desc_lock, flags);
 }
 
 /**
  * fsl_chan_xfer_ld_queue - Transfer link descriptors in channel ld_queue.
- * @fsl_chan : Freescale DMA channel
+ * @chan : Freescale DMA channel
  */
-static void fsl_chan_xfer_ld_queue(struct fsldma_chan *fsl_chan)
+static void fsl_chan_xfer_ld_queue(struct fsldma_chan *chan)
 {
 	struct list_head *ld_node;
 	dma_addr_t next_dst_addr;
 	unsigned long flags;
 
-	spin_lock_irqsave(&fsl_chan->desc_lock, flags);
+	spin_lock_irqsave(&chan->desc_lock, flags);
 
-	if (!dma_is_idle(fsl_chan))
+	if (!dma_is_idle(chan))
 		goto out_unlock;
 
-	dma_halt(fsl_chan);
+	dma_halt(chan);
 
 	/* If there are some link descriptors
 	 * not transfered in queue. We need to start it.
 	 */
 
 	/* Find the first un-transfer desciptor */
-	for (ld_node = fsl_chan->ld_queue.next;
-		(ld_node != &fsl_chan->ld_queue)
+	for (ld_node = chan->ld_queue.next;
+		(ld_node != &chan->ld_queue)
 			&& (dma_async_is_complete(
 				to_fsl_desc(ld_node)->async_tx.cookie,
-				fsl_chan->completed_cookie,
-				fsl_chan->common.cookie) == DMA_SUCCESS);
+				chan->completed_cookie,
+				chan->common.cookie) == DMA_SUCCESS);
 		ld_node = ld_node->next);
 
-	if (ld_node != &fsl_chan->ld_queue) {
+	if (ld_node != &chan->ld_queue) {
 		/* Get the ld start address from ld_queue */
 		next_dst_addr = to_fsl_desc(ld_node)->async_tx.phys;
-		dev_dbg(fsl_chan->dev, "xfer LDs staring from 0x%llx\n",
+		dev_dbg(chan->dev, "xfer LDs staring from 0x%llx\n",
 				(unsigned long long)next_dst_addr);
-		set_cdar(fsl_chan, next_dst_addr);
-		dma_start(fsl_chan);
+		set_cdar(chan, next_dst_addr);
+		dma_start(chan);
 	} else {
-		set_cdar(fsl_chan, 0);
-		set_ndar(fsl_chan, 0);
+		set_cdar(chan, 0);
+		set_ndar(chan, 0);
 	}
 
 out_unlock:
-	spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
+	spin_unlock_irqrestore(&chan->desc_lock, flags);
 }
 
 /**
  * fsl_dma_memcpy_issue_pending - Issue the DMA start command
- * @fsl_chan : Freescale DMA channel
+ * @chan : Freescale DMA channel
  */
-static void fsl_dma_memcpy_issue_pending(struct dma_chan *chan)
+static void fsl_dma_memcpy_issue_pending(struct dma_chan *dchan)
 {
-	struct fsldma_chan *fsl_chan = to_fsl_chan(chan);
+	struct fsldma_chan *chan = to_fsl_chan(dchan);
 
 #ifdef FSL_DMA_LD_DEBUG
 	struct fsl_desc_sw *ld;
 	unsigned long flags;
 
-	spin_lock_irqsave(&fsl_chan->desc_lock, flags);
-	if (list_empty(&fsl_chan->ld_queue)) {
-		spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
+	spin_lock_irqsave(&chan->desc_lock, flags);
+	if (list_empty(&chan->ld_queue)) {
+		spin_unlock_irqrestore(&chan->desc_lock, flags);
 		return;
 	}
 
-	dev_dbg(fsl_chan->dev, "--memcpy issue--\n");
-	list_for_each_entry(ld, &fsl_chan->ld_queue, node) {
+	dev_dbg(chan->dev, "--memcpy issue--\n");
+	list_for_each_entry(ld, &chan->ld_queue, node) {
 		int i;
-		dev_dbg(fsl_chan->dev, "Ch %d, LD %08x\n",
-				fsl_chan->id, ld->async_tx.phys);
+		dev_dbg(chan->dev, "Ch %d, LD %08x\n",
+				chan->id, ld->async_tx.phys);
 		for (i = 0; i < 8; i++)
-			dev_dbg(fsl_chan->dev, "LD offset %d: %08x\n",
+			dev_dbg(chan->dev, "LD offset %d: %08x\n",
 					i, *(((u32 *)&ld->hw) + i));
 	}
-	dev_dbg(fsl_chan->dev, "----------------\n");
-	spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
+	dev_dbg(chan->dev, "----------------\n");
+	spin_unlock_irqrestore(&chan->desc_lock, flags);
 #endif
 
-	fsl_chan_xfer_ld_queue(fsl_chan);
+	fsl_chan_xfer_ld_queue(chan);
 }
 
 /**
  * fsl_dma_is_complete - Determine the DMA status
- * @fsl_chan : Freescale DMA channel
+ * @chan : Freescale DMA channel
  */
-static enum dma_status fsl_dma_is_complete(struct dma_chan *chan,
+static enum dma_status fsl_dma_is_complete(struct dma_chan *dchan,
 					dma_cookie_t cookie,
 					dma_cookie_t *done,
 					dma_cookie_t *used)
 {
-	struct fsldma_chan *fsl_chan = to_fsl_chan(chan);
+	struct fsldma_chan *chan = to_fsl_chan(dchan);
 	dma_cookie_t last_used;
 	dma_cookie_t last_complete;
 
-	fsl_chan_ld_cleanup(fsl_chan);
+	fsl_chan_ld_cleanup(chan);
 
-	last_used = chan->cookie;
-	last_complete = fsl_chan->completed_cookie;
+	last_used = dchan->cookie;
+	last_complete = chan->completed_cookie;
 
 	if (done)
 		*done = last_complete;
@@ -973,30 +973,30 @@ static enum dma_status fsl_dma_is_complete(struct dma_chan *chan,
 
 static irqreturn_t fsldma_chan_irq(int irq, void *data)
 {
-	struct fsldma_chan *fsl_chan = data;
-	u32 stat;
+	struct fsldma_chan *chan = data;
 	int update_cookie = 0;
 	int xfer_ld_q = 0;
+	u32 stat;
 
-	stat = get_sr(fsl_chan);
-	dev_dbg(fsl_chan->dev, "event: channel %d, stat = 0x%x\n",
-						fsl_chan->id, stat);
-	set_sr(fsl_chan, stat);		/* Clear the event register */
+	stat = get_sr(chan);
+	dev_dbg(chan->dev, "event: channel %d, stat = 0x%x\n",
+						chan->id, stat);
+	set_sr(chan, stat);		/* Clear the event register */
 
 	stat &= ~(FSL_DMA_SR_CB | FSL_DMA_SR_CH);
 	if (!stat)
 		return IRQ_NONE;
 
 	if (stat & FSL_DMA_SR_TE)
-		dev_err(fsl_chan->dev, "Transfer Error!\n");
+		dev_err(chan->dev, "Transfer Error!\n");
 
 	/* Programming Error
 	 * The DMA_INTERRUPT async_tx is a NULL transfer, which will
 	 * triger a PE interrupt.
 	 */
 	if (stat & FSL_DMA_SR_PE) {
-		dev_dbg(fsl_chan->dev, "event: Programming Error INT\n");
-		if (get_bcr(fsl_chan) == 0) {
+		dev_dbg(chan->dev, "event: Programming Error INT\n");
+		if (get_bcr(chan) == 0) {
 			/* BCR register is 0, this is a DMA_INTERRUPT async_tx.
 			 * Now, update the completed cookie, and continue the
 			 * next uncompleted transfer.
@@ -1011,10 +1011,10 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 	 * we will recycle the used descriptor.
 	 */
 	if (stat & FSL_DMA_SR_EOSI) {
-		dev_dbg(fsl_chan->dev, "event: End-of-segments INT\n");
-		dev_dbg(fsl_chan->dev, "event: clndar 0x%llx, nlndar 0x%llx\n",
-			(unsigned long long)get_cdar(fsl_chan),
-			(unsigned long long)get_ndar(fsl_chan));
+		dev_dbg(chan->dev, "event: End-of-segments INT\n");
+		dev_dbg(chan->dev, "event: clndar 0x%llx, nlndar 0x%llx\n",
+			(unsigned long long)get_cdar(chan),
+			(unsigned long long)get_ndar(chan));
 		stat &= ~FSL_DMA_SR_EOSI;
 		update_cookie = 1;
 	}
@@ -1023,7 +1023,7 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 	 * and start the next transfer if it exist.
 	 */
 	if (stat & FSL_DMA_SR_EOCDI) {
-		dev_dbg(fsl_chan->dev, "event: End-of-Chain link INT\n");
+		dev_dbg(chan->dev, "event: End-of-Chain link INT\n");
 		stat &= ~FSL_DMA_SR_EOCDI;
 		update_cookie = 1;
 		xfer_ld_q = 1;
@@ -1034,28 +1034,28 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 	 * prepare next transfer.
 	 */
 	if (stat & FSL_DMA_SR_EOLNI) {
-		dev_dbg(fsl_chan->dev, "event: End-of-link INT\n");
+		dev_dbg(chan->dev, "event: End-of-link INT\n");
 		stat &= ~FSL_DMA_SR_EOLNI;
 		xfer_ld_q = 1;
 	}
 
 	if (update_cookie)
-		fsl_dma_update_completed_cookie(fsl_chan);
+		fsl_dma_update_completed_cookie(chan);
 	if (xfer_ld_q)
-		fsl_chan_xfer_ld_queue(fsl_chan);
+		fsl_chan_xfer_ld_queue(chan);
 	if (stat)
-		dev_dbg(fsl_chan->dev, "event: unhandled sr 0x%02x\n",
+		dev_dbg(chan->dev, "event: unhandled sr 0x%02x\n",
 					stat);
 
-	dev_dbg(fsl_chan->dev, "event: Exit\n");
-	tasklet_schedule(&fsl_chan->tasklet);
+	dev_dbg(chan->dev, "event: Exit\n");
+	tasklet_schedule(&chan->tasklet);
 	return IRQ_HANDLED;
 }
 
 static void dma_do_tasklet(unsigned long data)
 {
-	struct fsldma_chan *fsl_chan = (struct fsldma_chan *)data;
-	fsl_chan_ld_cleanup(fsl_chan);
+	struct fsldma_chan *chan = (struct fsldma_chan *)data;
+	fsl_chan_ld_cleanup(chan);
 }
 
 static irqreturn_t fsldma_ctrl_irq(int irq, void *data)
@@ -1171,24 +1171,24 @@ out_unwind:
 static int __devinit fsl_dma_chan_probe(struct fsldma_device *fdev,
 	struct device_node *node, u32 feature, const char *compatible)
 {
-	struct fsldma_chan *fchan;
+	struct fsldma_chan *chan;
 	struct resource res;
 	int err;
 
 	/* alloc channel */
-	fchan = kzalloc(sizeof(*fchan), GFP_KERNEL);
-	if (!fchan) {
+	chan = kzalloc(sizeof(*chan), GFP_KERNEL);
+	if (!chan) {
 		dev_err(fdev->dev, "no free memory for DMA channels!\n");
 		err = -ENOMEM;
 		goto out_return;
 	}
 
 	/* ioremap registers for use */
-	fchan->regs = of_iomap(node, 0);
-	if (!fchan->regs) {
+	chan->regs = of_iomap(node, 0);
+	if (!chan->regs) {
 		dev_err(fdev->dev, "unable to ioremap registers\n");
 		err = -ENOMEM;
-		goto out_free_fchan;
+		goto out_free_chan;
 	}
 
 	err = of_address_to_resource(node, 0, &res);
@@ -1197,74 +1197,74 @@ static int __devinit fsl_dma_chan_probe(struct fsldma_device *fdev,
 		goto out_iounmap_regs;
 	}
 
-	fchan->feature = feature;
+	chan->feature = feature;
 	if (!fdev->feature)
-		fdev->feature = fchan->feature;
+		fdev->feature = chan->feature;
 
 	/*
 	 * If the DMA device's feature is different than the feature
 	 * of its channels, report the bug
 	 */
-	WARN_ON(fdev->feature != fchan->feature);
+	WARN_ON(fdev->feature != chan->feature);
 
-	fchan->dev = fdev->dev;
-	fchan->id = ((res.start - 0x100) & 0xfff) >> 7;
-	if (fchan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
+	chan->dev = fdev->dev;
+	chan->id = ((res.start - 0x100) & 0xfff) >> 7;
+	if (chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
 		dev_err(fdev->dev, "too many channels for device\n");
 		err = -EINVAL;
 		goto out_iounmap_regs;
 	}
 
-	fdev->chan[fchan->id] = fchan;
-	tasklet_init(&fchan->tasklet, dma_do_tasklet, (unsigned long)fchan);
+	fdev->chan[chan->id] = chan;
+	tasklet_init(&chan->tasklet, dma_do_tasklet, (unsigned long)chan);
 
 	/* Initialize the channel */
-	dma_init(fchan);
+	dma_init(chan);
 
 	/* Clear cdar registers */
-	set_cdar(fchan, 0);
+	set_cdar(chan, 0);
 
-	switch (fchan->feature & FSL_DMA_IP_MASK) {
+	switch (chan->feature & FSL_DMA_IP_MASK) {
 	case FSL_DMA_IP_85XX:
-		fchan->toggle_ext_pause = fsl_chan_toggle_ext_pause;
+		chan->toggle_ext_pause = fsl_chan_toggle_ext_pause;
 	case FSL_DMA_IP_83XX:
-		fchan->toggle_ext_start = fsl_chan_toggle_ext_start;
-		fchan->set_src_loop_size = fsl_chan_set_src_loop_size;
-		fchan->set_dst_loop_size = fsl_chan_set_dst_loop_size;
-		fchan->set_request_count = fsl_chan_set_request_count;
+		chan->toggle_ext_start = fsl_chan_toggle_ext_start;
+		chan->set_src_loop_size = fsl_chan_set_src_loop_size;
+		chan->set_dst_loop_size = fsl_chan_set_dst_loop_size;
+		chan->set_request_count = fsl_chan_set_request_count;
 	}
 
-	spin_lock_init(&fchan->desc_lock);
-	INIT_LIST_HEAD(&fchan->ld_queue);
+	spin_lock_init(&chan->desc_lock);
+	INIT_LIST_HEAD(&chan->ld_queue);
 
-	fchan->common.device = &fdev->common;
+	chan->common.device = &fdev->common;
 
 	/* find the IRQ line, if it exists in the device tree */
-	fchan->irq = irq_of_parse_and_map(node, 0);
+	chan->irq = irq_of_parse_and_map(node, 0);
 
 	/* Add the channel to DMA device channel list */
-	list_add_tail(&fchan->common.device_node, &fdev->common.channels);
+	list_add_tail(&chan->common.device_node, &fdev->common.channels);
 	fdev->common.chancnt++;
 
-	dev_info(fdev->dev, "#%d (%s), irq %d\n", fchan->id, compatible,
-		 fchan->irq != NO_IRQ ? fchan->irq : fdev->irq);
+	dev_info(fdev->dev, "#%d (%s), irq %d\n", chan->id, compatible,
+		 chan->irq != NO_IRQ ? chan->irq : fdev->irq);
 
 	return 0;
 
 out_iounmap_regs:
-	iounmap(fchan->regs);
-out_free_fchan:
-	kfree(fchan);
+	iounmap(chan->regs);
+out_free_chan:
+	kfree(chan);
 out_return:
 	return err;
 }
 
-static void fsl_dma_chan_remove(struct fsldma_chan *fchan)
+static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 {
-	irq_dispose_mapping(fchan->irq);
-	list_del(&fchan->common.device_node);
-	iounmap(fchan->regs);
-	kfree(fchan);
+	irq_dispose_mapping(chan->irq);
+	list_del(&chan->common.device_node);
+	iounmap(chan->regs);
+	kfree(chan);
 }
 
 static int __devinit fsldma_of_probe(struct of_device *op,
-- 
1.5.4.3
