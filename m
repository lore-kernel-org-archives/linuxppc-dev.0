Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id A1990B6EF2
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 10:34:08 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: dan.j.williams@intel.com
Subject: [PATCH 3/8] fsldma: rename struct fsl_dma_chan to struct fsldma_chan
Date: Wed,  6 Jan 2010 15:34:01 -0800
Message-Id: <1262820846-13198-4-git-send-email-iws@ovro.caltech.edu>
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

This is the beginning of a cleanup which will change all instances of
"fsl_dma" to "fsldma" to match the name of the driver itself.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |  128 ++++++++++++++++++++++++++-----------------------
 drivers/dma/fsldma.h |   26 +++++-----
 2 files changed, 81 insertions(+), 73 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 0b4e638..6795d96 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -37,7 +37,7 @@
 #include <asm/fsldma.h>
 #include "fsldma.h"
 
-static void dma_init(struct fsl_dma_chan *fsl_chan)
+static void dma_init(struct fsldma_chan *fsl_chan)
 {
 	/* Reset the channel */
 	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, 0, 32);
@@ -64,23 +64,23 @@ static void dma_init(struct fsl_dma_chan *fsl_chan)
 
 }
 
-static void set_sr(struct fsl_dma_chan *fsl_chan, u32 val)
+static void set_sr(struct fsldma_chan *fsl_chan, u32 val)
 {
 	DMA_OUT(fsl_chan, &fsl_chan->reg_base->sr, val, 32);
 }
 
-static u32 get_sr(struct fsl_dma_chan *fsl_chan)
+static u32 get_sr(struct fsldma_chan *fsl_chan)
 {
 	return DMA_IN(fsl_chan, &fsl_chan->reg_base->sr, 32);
 }
 
-static void set_desc_cnt(struct fsl_dma_chan *fsl_chan,
+static void set_desc_cnt(struct fsldma_chan *fsl_chan,
 				struct fsl_dma_ld_hw *hw, u32 count)
 {
 	hw->count = CPU_TO_DMA(fsl_chan, count, 32);
 }
 
-static void set_desc_src(struct fsl_dma_chan *fsl_chan,
+static void set_desc_src(struct fsldma_chan *fsl_chan,
 				struct fsl_dma_ld_hw *hw, dma_addr_t src)
 {
 	u64 snoop_bits;
@@ -90,7 +90,7 @@ static void set_desc_src(struct fsl_dma_chan *fsl_chan,
 	hw->src_addr = CPU_TO_DMA(fsl_chan, snoop_bits | src, 64);
 }
 
-static void set_desc_dest(struct fsl_dma_chan *fsl_chan,
+static void set_desc_dest(struct fsldma_chan *fsl_chan,
 				struct fsl_dma_ld_hw *hw, dma_addr_t dest)
 {
 	u64 snoop_bits;
@@ -100,7 +100,7 @@ static void set_desc_dest(struct fsl_dma_chan *fsl_chan,
 	hw->dst_addr = CPU_TO_DMA(fsl_chan, snoop_bits | dest, 64);
 }
 
-static void set_desc_next(struct fsl_dma_chan *fsl_chan,
+static void set_desc_next(struct fsldma_chan *fsl_chan,
 				struct fsl_dma_ld_hw *hw, dma_addr_t next)
 {
 	u64 snoop_bits;
@@ -110,38 +110,38 @@ static void set_desc_next(struct fsl_dma_chan *fsl_chan,
 	hw->next_ln_addr = CPU_TO_DMA(fsl_chan, snoop_bits | next, 64);
 }
 
-static void set_cdar(struct fsl_dma_chan *fsl_chan, dma_addr_t addr)
+static void set_cdar(struct fsldma_chan *fsl_chan, dma_addr_t addr)
 {
 	DMA_OUT(fsl_chan, &fsl_chan->reg_base->cdar, addr | FSL_DMA_SNEN, 64);
 }
 
-static dma_addr_t get_cdar(struct fsl_dma_chan *fsl_chan)
+static dma_addr_t get_cdar(struct fsldma_chan *fsl_chan)
 {
 	return DMA_IN(fsl_chan, &fsl_chan->reg_base->cdar, 64) & ~FSL_DMA_SNEN;
 }
 
-static void set_ndar(struct fsl_dma_chan *fsl_chan, dma_addr_t addr)
+static void set_ndar(struct fsldma_chan *fsl_chan, dma_addr_t addr)
 {
 	DMA_OUT(fsl_chan, &fsl_chan->reg_base->ndar, addr, 64);
 }
 
-static dma_addr_t get_ndar(struct fsl_dma_chan *fsl_chan)
+static dma_addr_t get_ndar(struct fsldma_chan *fsl_chan)
 {
 	return DMA_IN(fsl_chan, &fsl_chan->reg_base->ndar, 64);
 }
 
-static u32 get_bcr(struct fsl_dma_chan *fsl_chan)
+static u32 get_bcr(struct fsldma_chan *fsl_chan)
 {
 	return DMA_IN(fsl_chan, &fsl_chan->reg_base->bcr, 32);
 }
 
-static int dma_is_idle(struct fsl_dma_chan *fsl_chan)
+static int dma_is_idle(struct fsldma_chan *fsl_chan)
 {
 	u32 sr = get_sr(fsl_chan);
 	return (!(sr & FSL_DMA_SR_CB)) || (sr & FSL_DMA_SR_CH);
 }
 
-static void dma_start(struct fsl_dma_chan *fsl_chan)
+static void dma_start(struct fsldma_chan *fsl_chan)
 {
 	u32 mode;
 
@@ -164,7 +164,7 @@ static void dma_start(struct fsl_dma_chan *fsl_chan)
 	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, mode, 32);
 }
 
-static void dma_halt(struct fsl_dma_chan *fsl_chan)
+static void dma_halt(struct fsldma_chan *fsl_chan)
 {
 	u32 mode;
 	int i;
@@ -186,7 +186,7 @@ static void dma_halt(struct fsl_dma_chan *fsl_chan)
 		dev_err(fsl_chan->dev, "DMA halt timeout!\n");
 }
 
-static void set_ld_eol(struct fsl_dma_chan *fsl_chan,
+static void set_ld_eol(struct fsldma_chan *fsl_chan,
 			struct fsl_desc_sw *desc)
 {
 	u64 snoop_bits;
@@ -199,7 +199,7 @@ static void set_ld_eol(struct fsl_dma_chan *fsl_chan,
 			| snoop_bits, 64);
 }
 
-static void append_ld_queue(struct fsl_dma_chan *fsl_chan,
+static void append_ld_queue(struct fsldma_chan *fsl_chan,
 		struct fsl_desc_sw *new_desc)
 {
 	struct fsl_desc_sw *queue_tail = to_fsl_desc(fsl_chan->ld_queue.prev);
@@ -231,7 +231,7 @@ static void append_ld_queue(struct fsl_dma_chan *fsl_chan,
  * read data from SA, SA + 1, SA + 2, SA + 3, then loop back to SA,
  * SA + 1 ... and so on.
  */
-static void fsl_chan_set_src_loop_size(struct fsl_dma_chan *fsl_chan, int size)
+static void fsl_chan_set_src_loop_size(struct fsldma_chan *fsl_chan, int size)
 {
 	u32 mode;
 
@@ -263,7 +263,7 @@ static void fsl_chan_set_src_loop_size(struct fsl_dma_chan *fsl_chan, int size)
  * write data to TA, TA + 1, TA + 2, TA + 3, then loop back to TA,
  * TA + 1 ... and so on.
  */
-static void fsl_chan_set_dest_loop_size(struct fsl_dma_chan *fsl_chan, int size)
+static void fsl_chan_set_dest_loop_size(struct fsldma_chan *fsl_chan, int size)
 {
 	u32 mode;
 
@@ -296,7 +296,7 @@ static void fsl_chan_set_dest_loop_size(struct fsl_dma_chan *fsl_chan, int size)
  *
  * A size of 0 disables external pause control. The maximum size is 1024.
  */
-static void fsl_chan_set_request_count(struct fsl_dma_chan *fsl_chan, int size)
+static void fsl_chan_set_request_count(struct fsldma_chan *fsl_chan, int size)
 {
 	u32 mode;
 
@@ -317,7 +317,7 @@ static void fsl_chan_set_request_count(struct fsl_dma_chan *fsl_chan, int size)
  * The DMA Request Count feature should be used in addition to this feature
  * to set the number of bytes to transfer before pausing the channel.
  */
-static void fsl_chan_toggle_ext_pause(struct fsl_dma_chan *fsl_chan, int enable)
+static void fsl_chan_toggle_ext_pause(struct fsldma_chan *fsl_chan, int enable)
 {
 	if (enable)
 		fsl_chan->feature |= FSL_DMA_CHAN_PAUSE_EXT;
@@ -335,7 +335,7 @@ static void fsl_chan_toggle_ext_pause(struct fsl_dma_chan *fsl_chan, int enable)
  * transfer immediately. The DMA channel will wait for the
  * control pin asserted.
  */
-static void fsl_chan_toggle_ext_start(struct fsl_dma_chan *fsl_chan, int enable)
+static void fsl_chan_toggle_ext_start(struct fsldma_chan *fsl_chan, int enable)
 {
 	if (enable)
 		fsl_chan->feature |= FSL_DMA_CHAN_START_EXT;
@@ -345,7 +345,7 @@ static void fsl_chan_toggle_ext_start(struct fsl_dma_chan *fsl_chan, int enable)
 
 static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 {
-	struct fsl_dma_chan *fsl_chan = to_fsl_chan(tx->chan);
+	struct fsldma_chan *fsl_chan = to_fsl_chan(tx->chan);
 	struct fsl_desc_sw *desc = tx_to_fsl_desc(tx);
 	struct fsl_desc_sw *child;
 	unsigned long flags;
@@ -379,7 +379,7 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
  * Return - The descriptor allocated. NULL for failed.
  */
 static struct fsl_desc_sw *fsl_dma_alloc_descriptor(
-					struct fsl_dma_chan *fsl_chan)
+					struct fsldma_chan *fsl_chan)
 {
 	dma_addr_t pdesc;
 	struct fsl_desc_sw *desc_sw;
@@ -408,7 +408,7 @@ static struct fsl_desc_sw *fsl_dma_alloc_descriptor(
  */
 static int fsl_dma_alloc_chan_resources(struct dma_chan *chan)
 {
-	struct fsl_dma_chan *fsl_chan = to_fsl_chan(chan);
+	struct fsldma_chan *fsl_chan = to_fsl_chan(chan);
 
 	/* Has this channel already been allocated? */
 	if (fsl_chan->desc_pool)
@@ -435,7 +435,7 @@ static int fsl_dma_alloc_chan_resources(struct dma_chan *chan)
  */
 static void fsl_dma_free_chan_resources(struct dma_chan *chan)
 {
-	struct fsl_dma_chan *fsl_chan = to_fsl_chan(chan);
+	struct fsldma_chan *fsl_chan = to_fsl_chan(chan);
 	struct fsl_desc_sw *desc, *_desc;
 	unsigned long flags;
 
@@ -459,7 +459,7 @@ static void fsl_dma_free_chan_resources(struct dma_chan *chan)
 static struct dma_async_tx_descriptor *
 fsl_dma_prep_interrupt(struct dma_chan *chan, unsigned long flags)
 {
-	struct fsl_dma_chan *fsl_chan;
+	struct fsldma_chan *fsl_chan;
 	struct fsl_desc_sw *new;
 
 	if (!chan)
@@ -489,7 +489,7 @@ static struct dma_async_tx_descriptor *fsl_dma_prep_memcpy(
 	struct dma_chan *chan, dma_addr_t dma_dest, dma_addr_t dma_src,
 	size_t len, unsigned long flags)
 {
-	struct fsl_dma_chan *fsl_chan;
+	struct fsldma_chan *fsl_chan;
 	struct fsl_desc_sw *first = NULL, *prev = NULL, *new;
 	struct list_head *list;
 	size_t copy;
@@ -575,7 +575,7 @@ static struct dma_async_tx_descriptor *fsl_dma_prep_slave_sg(
 	struct dma_chan *chan, struct scatterlist *sgl, unsigned int sg_len,
 	enum dma_data_direction direction, unsigned long flags)
 {
-	struct fsl_dma_chan *fsl_chan;
+	struct fsldma_chan *fsl_chan;
 	struct fsl_desc_sw *first = NULL, *prev = NULL, *new = NULL;
 	struct fsl_dma_slave *slave;
 	struct list_head *tx_list;
@@ -759,7 +759,7 @@ fail:
 
 static void fsl_dma_device_terminate_all(struct dma_chan *chan)
 {
-	struct fsl_dma_chan *fsl_chan;
+	struct fsldma_chan *fsl_chan;
 	struct fsl_desc_sw *desc, *tmp;
 	unsigned long flags;
 
@@ -786,7 +786,7 @@ static void fsl_dma_device_terminate_all(struct dma_chan *chan)
  * fsl_dma_update_completed_cookie - Update the completed cookie.
  * @fsl_chan : Freescale DMA channel
  */
-static void fsl_dma_update_completed_cookie(struct fsl_dma_chan *fsl_chan)
+static void fsl_dma_update_completed_cookie(struct fsldma_chan *fsl_chan)
 {
 	struct fsl_desc_sw *cur_desc, *desc;
 	dma_addr_t ld_phy;
@@ -820,7 +820,7 @@ static void fsl_dma_update_completed_cookie(struct fsl_dma_chan *fsl_chan)
  * If 'in_intr' is set, the function will move the link descriptor to
  * the recycle list. Otherwise, free it directly.
  */
-static void fsl_chan_ld_cleanup(struct fsl_dma_chan *fsl_chan)
+static void fsl_chan_ld_cleanup(struct fsldma_chan *fsl_chan)
 {
 	struct fsl_desc_sw *desc, *_desc;
 	unsigned long flags;
@@ -864,7 +864,7 @@ static void fsl_chan_ld_cleanup(struct fsl_dma_chan *fsl_chan)
  * fsl_chan_xfer_ld_queue - Transfer link descriptors in channel ld_queue.
  * @fsl_chan : Freescale DMA channel
  */
-static void fsl_chan_xfer_ld_queue(struct fsl_dma_chan *fsl_chan)
+static void fsl_chan_xfer_ld_queue(struct fsldma_chan *fsl_chan)
 {
 	struct list_head *ld_node;
 	dma_addr_t next_dest_addr;
@@ -912,7 +912,7 @@ out_unlock:
  */
 static void fsl_dma_memcpy_issue_pending(struct dma_chan *chan)
 {
-	struct fsl_dma_chan *fsl_chan = to_fsl_chan(chan);
+	struct fsldma_chan *fsl_chan = to_fsl_chan(chan);
 
 #ifdef FSL_DMA_LD_DEBUG
 	struct fsl_desc_sw *ld;
@@ -949,7 +949,7 @@ static enum dma_status fsl_dma_is_complete(struct dma_chan *chan,
 					dma_cookie_t *done,
 					dma_cookie_t *used)
 {
-	struct fsl_dma_chan *fsl_chan = to_fsl_chan(chan);
+	struct fsldma_chan *fsl_chan = to_fsl_chan(chan);
 	dma_cookie_t last_used;
 	dma_cookie_t last_complete;
 
@@ -969,7 +969,7 @@ static enum dma_status fsl_dma_is_complete(struct dma_chan *chan,
 
 static irqreturn_t fsl_dma_chan_do_interrupt(int irq, void *data)
 {
-	struct fsl_dma_chan *fsl_chan = (struct fsl_dma_chan *)data;
+	struct fsldma_chan *fsl_chan = data;
 	u32 stat;
 	int update_cookie = 0;
 	int xfer_ld_q = 0;
@@ -1050,9 +1050,9 @@ static irqreturn_t fsl_dma_chan_do_interrupt(int irq, void *data)
 
 static irqreturn_t fsl_dma_do_interrupt(int irq, void *data)
 {
-	struct fsl_dma_device *fdev = (struct fsl_dma_device *)data;
-	u32 gsr;
+	struct fsldma_device *fdev = data;
 	int ch_nr;
+	u32 gsr;
 
 	gsr = (fdev->feature & FSL_DMA_BIG_ENDIAN) ? in_be32(fdev->reg_base)
 			: in_le32(fdev->reg_base);
@@ -1064,19 +1064,23 @@ static irqreturn_t fsl_dma_do_interrupt(int irq, void *data)
 
 static void dma_do_tasklet(unsigned long data)
 {
-	struct fsl_dma_chan *fsl_chan = (struct fsl_dma_chan *)data;
+	struct fsldma_chan *fsl_chan = (struct fsldma_chan *)data;
 	fsl_chan_ld_cleanup(fsl_chan);
 }
 
-static int __devinit fsl_dma_chan_probe(struct fsl_dma_device *fdev,
+/*----------------------------------------------------------------------------*/
+/* OpenFirmware Subsystem                                                     */
+/*----------------------------------------------------------------------------*/
+
+static int __devinit fsl_dma_chan_probe(struct fsldma_device *fdev,
 	struct device_node *node, u32 feature, const char *compatible)
 {
-	struct fsl_dma_chan *new_fsl_chan;
+	struct fsldma_chan *new_fsl_chan;
 	struct resource res;
 	int err;
 
 	/* alloc channel */
-	new_fsl_chan = kzalloc(sizeof(struct fsl_dma_chan), GFP_KERNEL);
+	new_fsl_chan = kzalloc(sizeof(*new_fsl_chan), GFP_KERNEL);
 	if (!new_fsl_chan) {
 		dev_err(fdev->dev, "No free memory for allocating "
 				"dma channels!\n");
@@ -1167,7 +1171,7 @@ err_no_reg:
 	return err;
 }
 
-static void fsl_dma_chan_remove(struct fsl_dma_chan *fchan)
+static void fsl_dma_chan_remove(struct fsldma_chan *fchan)
 {
 	if (fchan->irq != NO_IRQ)
 		free_irq(fchan->irq, fchan);
@@ -1176,15 +1180,15 @@ static void fsl_dma_chan_remove(struct fsl_dma_chan *fchan)
 	kfree(fchan);
 }
 
-static int __devinit of_fsl_dma_probe(struct of_device *dev,
+static int __devinit fsldma_of_probe(struct of_device *dev,
 			const struct of_device_id *match)
 {
 	int err;
-	struct fsl_dma_device *fdev;
+	struct fsldma_device *fdev;
 	struct device_node *child;
 	struct resource res;
 
-	fdev = kzalloc(sizeof(struct fsl_dma_device), GFP_KERNEL);
+	fdev = kzalloc(sizeof(*fdev), GFP_KERNEL);
 	if (!fdev) {
 		dev_err(&dev->dev, "No enough memory for 'priv'\n");
 		return -ENOMEM;
@@ -1256,9 +1260,9 @@ err_no_reg:
 	return err;
 }
 
-static int of_fsl_dma_remove(struct of_device *of_dev)
+static int fsldma_of_remove(struct of_device *of_dev)
 {
-	struct fsl_dma_device *fdev;
+	struct fsldma_device *fdev;
 	unsigned int i;
 
 	fdev = dev_get_drvdata(&of_dev->dev);
@@ -1280,39 +1284,43 @@ static int of_fsl_dma_remove(struct of_device *of_dev)
 	return 0;
 }
 
-static struct of_device_id of_fsl_dma_ids[] = {
+static struct of_device_id fsldma_of_ids[] = {
 	{ .compatible = "fsl,eloplus-dma", },
 	{ .compatible = "fsl,elo-dma", },
 	{}
 };
 
-static struct of_platform_driver of_fsl_dma_driver = {
-	.name = "fsl-elo-dma",
-	.match_table = of_fsl_dma_ids,
-	.probe = of_fsl_dma_probe,
-	.remove = of_fsl_dma_remove,
+static struct of_platform_driver fsldma_of_driver = {
+	.name		= "fsl-elo-dma",
+	.match_table	= fsldma_of_ids,
+	.probe		= fsldma_of_probe,
+	.remove		= fsldma_of_remove,
 };
 
-static __init int of_fsl_dma_init(void)
+/*----------------------------------------------------------------------------*/
+/* Module Init / Exit                                                         */
+/*----------------------------------------------------------------------------*/
+
+static __init int fsldma_init(void)
 {
 	int ret;
 
 	pr_info("Freescale Elo / Elo Plus DMA driver\n");
 
-	ret = of_register_platform_driver(&of_fsl_dma_driver);
+	ret = of_register_platform_driver(&fsldma_of_driver);
 	if (ret)
 		pr_err("fsldma: failed to register platform driver\n");
 
 	return ret;
 }
 
-static void __exit of_fsl_dma_exit(void)
+static void __exit fsldma_exit(void)
 {
-	of_unregister_platform_driver(&of_fsl_dma_driver);
+	of_unregister_platform_driver(&fsldma_of_driver);
 }
 
-subsys_initcall(of_fsl_dma_init);
-module_exit(of_fsl_dma_exit);
+subsys_initcall(fsldma_init);
+module_exit(fsldma_exit);
 
 MODULE_DESCRIPTION("Freescale Elo / Elo Plus DMA driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index dbb5b5c..f8c2baa 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -94,7 +94,7 @@ struct fsl_desc_sw {
 	struct dma_async_tx_descriptor async_tx;
 } __attribute__((aligned(32)));
 
-struct fsl_dma_chan_regs {
+struct fsldma_chan_regs {
 	u32 mr;	/* 0x00 - Mode Register */
 	u32 sr;	/* 0x04 - Status Register */
 	u64 cdar;	/* 0x08 - Current descriptor address register */
@@ -104,19 +104,19 @@ struct fsl_dma_chan_regs {
 	u64 ndar;	/* 0x24 - Next Descriptor Address Register */
 };
 
-struct fsl_dma_chan;
+struct fsldma_chan;
 #define FSL_DMA_MAX_CHANS_PER_DEVICE 4
 
-struct fsl_dma_device {
+struct fsldma_device {
 	void __iomem *reg_base;	/* DGSR register base */
 	struct device *dev;
 	struct dma_device common;
-	struct fsl_dma_chan *chan[FSL_DMA_MAX_CHANS_PER_DEVICE];
+	struct fsldma_chan *chan[FSL_DMA_MAX_CHANS_PER_DEVICE];
 	u32 feature;		/* The same as DMA channels */
 	int irq;		/* Channel IRQ */
 };
 
-/* Define macros for fsl_dma_chan->feature property */
+/* Define macros for fsldma_chan->feature property */
 #define FSL_DMA_LITTLE_ENDIAN	0x00000000
 #define FSL_DMA_BIG_ENDIAN	0x00000001
 
@@ -127,8 +127,8 @@ struct fsl_dma_device {
 #define FSL_DMA_CHAN_PAUSE_EXT	0x00001000
 #define FSL_DMA_CHAN_START_EXT	0x00002000
 
-struct fsl_dma_chan {
-	struct fsl_dma_chan_regs __iomem *reg_base;
+struct fsldma_chan {
+	struct fsldma_chan_regs __iomem *reg_base;
 	dma_cookie_t completed_cookie;	/* The maximum cookie completed */
 	spinlock_t desc_lock;		/* Descriptor operation lock */
 	struct list_head ld_queue;	/* Link descriptors queue */
@@ -140,14 +140,14 @@ struct fsl_dma_chan {
 	struct tasklet_struct tasklet;
 	u32 feature;
 
-	void (*toggle_ext_pause)(struct fsl_dma_chan *fsl_chan, int enable);
-	void (*toggle_ext_start)(struct fsl_dma_chan *fsl_chan, int enable);
-	void (*set_src_loop_size)(struct fsl_dma_chan *fsl_chan, int size);
-	void (*set_dest_loop_size)(struct fsl_dma_chan *fsl_chan, int size);
-	void (*set_request_count)(struct fsl_dma_chan *fsl_chan, int size);
+	void (*toggle_ext_pause)(struct fsldma_chan *fsl_chan, int enable);
+	void (*toggle_ext_start)(struct fsldma_chan *fsl_chan, int enable);
+	void (*set_src_loop_size)(struct fsldma_chan *fsl_chan, int size);
+	void (*set_dest_loop_size)(struct fsldma_chan *fsl_chan, int size);
+	void (*set_request_count)(struct fsldma_chan *fsl_chan, int size);
 };
 
-#define to_fsl_chan(chan) container_of(chan, struct fsl_dma_chan, common)
+#define to_fsl_chan(chan) container_of(chan, struct fsldma_chan, common)
 #define to_fsl_desc(lh) container_of(lh, struct fsl_desc_sw, node)
 #define tx_to_fsl_desc(tx) container_of(tx, struct fsl_desc_sw, async_tx)
 
-- 
1.5.4.3
