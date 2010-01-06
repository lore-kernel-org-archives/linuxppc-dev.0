Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id AA80EB6F0A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 10:34:09 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: dan.j.williams@intel.com
Subject: [PATCH 5/8] fsldma: clean up the OF subsystem routines
Date: Wed,  6 Jan 2010 15:34:03 -0800
Message-Id: <1262820846-13198-6-git-send-email-iws@ovro.caltech.edu>
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

This fixes some errors in the cleanup paths of the OF subsystem, including
missing checks for ioremap failing. Also, some variables were renamed for
brevity.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |  259 +++++++++++++++++++++++++------------------------
 drivers/dma/fsldma.h |    4 +-
 2 files changed, 134 insertions(+), 129 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index c2db754..507b297 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -40,7 +40,7 @@
 static void dma_init(struct fsldma_chan *fsl_chan)
 {
 	/* Reset the channel */
-	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, 0, 32);
+	DMA_OUT(fsl_chan, &fsl_chan->regs->mr, 0, 32);
 
 	switch (fsl_chan->feature & FSL_DMA_IP_MASK) {
 	case FSL_DMA_IP_85XX:
@@ -49,7 +49,7 @@ static void dma_init(struct fsldma_chan *fsl_chan)
 		 * EOSIE - End of segments interrupt enable (basic mode)
 		 * EOLNIE - End of links interrupt enable
 		 */
-		DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, FSL_DMA_MR_EIE
+		DMA_OUT(fsl_chan, &fsl_chan->regs->mr, FSL_DMA_MR_EIE
 				| FSL_DMA_MR_EOLNIE | FSL_DMA_MR_EOSIE, 32);
 		break;
 	case FSL_DMA_IP_83XX:
@@ -57,7 +57,7 @@ static void dma_init(struct fsldma_chan *fsl_chan)
 		 * EOTIE - End-of-transfer interrupt enable
 		 * PRC_RM - PCI read multiple
 		 */
-		DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, FSL_DMA_MR_EOTIE
+		DMA_OUT(fsl_chan, &fsl_chan->regs->mr, FSL_DMA_MR_EOTIE
 				| FSL_DMA_MR_PRC_RM, 32);
 		break;
 	}
@@ -66,12 +66,12 @@ static void dma_init(struct fsldma_chan *fsl_chan)
 
 static void set_sr(struct fsldma_chan *fsl_chan, u32 val)
 {
-	DMA_OUT(fsl_chan, &fsl_chan->reg_base->sr, val, 32);
+	DMA_OUT(fsl_chan, &fsl_chan->regs->sr, val, 32);
 }
 
 static u32 get_sr(struct fsldma_chan *fsl_chan)
 {
-	return DMA_IN(fsl_chan, &fsl_chan->reg_base->sr, 32);
+	return DMA_IN(fsl_chan, &fsl_chan->regs->sr, 32);
 }
 
 static void set_desc_cnt(struct fsldma_chan *fsl_chan,
@@ -112,27 +112,27 @@ static void set_desc_next(struct fsldma_chan *fsl_chan,
 
 static void set_cdar(struct fsldma_chan *fsl_chan, dma_addr_t addr)
 {
-	DMA_OUT(fsl_chan, &fsl_chan->reg_base->cdar, addr | FSL_DMA_SNEN, 64);
+	DMA_OUT(fsl_chan, &fsl_chan->regs->cdar, addr | FSL_DMA_SNEN, 64);
 }
 
 static dma_addr_t get_cdar(struct fsldma_chan *fsl_chan)
 {
-	return DMA_IN(fsl_chan, &fsl_chan->reg_base->cdar, 64) & ~FSL_DMA_SNEN;
+	return DMA_IN(fsl_chan, &fsl_chan->regs->cdar, 64) & ~FSL_DMA_SNEN;
 }
 
 static void set_ndar(struct fsldma_chan *fsl_chan, dma_addr_t addr)
 {
-	DMA_OUT(fsl_chan, &fsl_chan->reg_base->ndar, addr, 64);
+	DMA_OUT(fsl_chan, &fsl_chan->regs->ndar, addr, 64);
 }
 
 static dma_addr_t get_ndar(struct fsldma_chan *fsl_chan)
 {
-	return DMA_IN(fsl_chan, &fsl_chan->reg_base->ndar, 64);
+	return DMA_IN(fsl_chan, &fsl_chan->regs->ndar, 64);
 }
 
 static u32 get_bcr(struct fsldma_chan *fsl_chan)
 {
-	return DMA_IN(fsl_chan, &fsl_chan->reg_base->bcr, 32);
+	return DMA_IN(fsl_chan, &fsl_chan->regs->bcr, 32);
 }
 
 static int dma_is_idle(struct fsldma_chan *fsl_chan)
@@ -145,11 +145,11 @@ static void dma_start(struct fsldma_chan *fsl_chan)
 {
 	u32 mode;
 
-	mode = DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32);
+	mode = DMA_IN(fsl_chan, &fsl_chan->regs->mr, 32);
 
 	if ((fsl_chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_85XX) {
 		if (fsl_chan->feature & FSL_DMA_CHAN_PAUSE_EXT) {
-			DMA_OUT(fsl_chan, &fsl_chan->reg_base->bcr, 0, 32);
+			DMA_OUT(fsl_chan, &fsl_chan->regs->bcr, 0, 32);
 			mode |= FSL_DMA_MR_EMP_EN;
 		} else {
 			mode &= ~FSL_DMA_MR_EMP_EN;
@@ -161,7 +161,7 @@ static void dma_start(struct fsldma_chan *fsl_chan)
 	else
 		mode |= FSL_DMA_MR_CS;
 
-	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, mode, 32);
+	DMA_OUT(fsl_chan, &fsl_chan->regs->mr, mode, 32);
 }
 
 static void dma_halt(struct fsldma_chan *fsl_chan)
@@ -169,12 +169,12 @@ static void dma_halt(struct fsldma_chan *fsl_chan)
 	u32 mode;
 	int i;
 
-	mode = DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32);
+	mode = DMA_IN(fsl_chan, &fsl_chan->regs->mr, 32);
 	mode |= FSL_DMA_MR_CA;
-	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, mode, 32);
+	DMA_OUT(fsl_chan, &fsl_chan->regs->mr, mode, 32);
 
 	mode &= ~(FSL_DMA_MR_CS | FSL_DMA_MR_EMS_EN | FSL_DMA_MR_CA);
-	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, mode, 32);
+	DMA_OUT(fsl_chan, &fsl_chan->regs->mr, mode, 32);
 
 	for (i = 0; i < 100; i++) {
 		if (dma_is_idle(fsl_chan))
@@ -235,7 +235,7 @@ static void fsl_chan_set_src_loop_size(struct fsldma_chan *fsl_chan, int size)
 {
 	u32 mode;
 
-	mode = DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32);
+	mode = DMA_IN(fsl_chan, &fsl_chan->regs->mr, 32);
 
 	switch (size) {
 	case 0:
@@ -249,7 +249,7 @@ static void fsl_chan_set_src_loop_size(struct fsldma_chan *fsl_chan, int size)
 		break;
 	}
 
-	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, mode, 32);
+	DMA_OUT(fsl_chan, &fsl_chan->regs->mr, mode, 32);
 }
 
 /**
@@ -267,7 +267,7 @@ static void fsl_chan_set_dst_loop_size(struct fsldma_chan *fsl_chan, int size)
 {
 	u32 mode;
 
-	mode = DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32);
+	mode = DMA_IN(fsl_chan, &fsl_chan->regs->mr, 32);
 
 	switch (size) {
 	case 0:
@@ -281,7 +281,7 @@ static void fsl_chan_set_dst_loop_size(struct fsldma_chan *fsl_chan, int size)
 		break;
 	}
 
-	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, mode, 32);
+	DMA_OUT(fsl_chan, &fsl_chan->regs->mr, mode, 32);
 }
 
 /**
@@ -302,10 +302,10 @@ static void fsl_chan_set_request_count(struct fsldma_chan *fsl_chan, int size)
 
 	BUG_ON(size > 1024);
 
-	mode = DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32);
+	mode = DMA_IN(fsl_chan, &fsl_chan->regs->mr, 32);
 	mode |= (__ilog2(size) << 24) & 0x0f000000;
 
-	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, mode, 32);
+	DMA_OUT(fsl_chan, &fsl_chan->regs->mr, mode, 32);
 }
 
 /**
@@ -967,7 +967,7 @@ static enum dma_status fsl_dma_is_complete(struct dma_chan *chan,
 	return dma_async_is_complete(cookie, last_complete, last_used);
 }
 
-static irqreturn_t fsl_dma_chan_do_interrupt(int irq, void *data)
+static irqreturn_t fsldma_chan_irq(int irq, void *data)
 {
 	struct fsldma_chan *fsl_chan = data;
 	u32 stat;
@@ -1048,17 +1048,17 @@ static irqreturn_t fsl_dma_chan_do_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t fsl_dma_do_interrupt(int irq, void *data)
+static irqreturn_t fsldma_irq(int irq, void *data)
 {
 	struct fsldma_device *fdev = data;
 	int ch_nr;
 	u32 gsr;
 
-	gsr = (fdev->feature & FSL_DMA_BIG_ENDIAN) ? in_be32(fdev->reg_base)
-			: in_le32(fdev->reg_base);
+	gsr = (fdev->feature & FSL_DMA_BIG_ENDIAN) ? in_be32(fdev->regs)
+			: in_le32(fdev->regs);
 	ch_nr = (32 - ffs(gsr)) / 8;
 
-	return fdev->chan[ch_nr] ? fsl_dma_chan_do_interrupt(irq,
+	return fdev->chan[ch_nr] ? fsldma_chan_irq(irq,
 			fdev->chan[ch_nr]) : IRQ_NONE;
 }
 
@@ -1075,140 +1075,142 @@ static void dma_do_tasklet(unsigned long data)
 static int __devinit fsl_dma_chan_probe(struct fsldma_device *fdev,
 	struct device_node *node, u32 feature, const char *compatible)
 {
-	struct fsldma_chan *new_fsl_chan;
+	struct fsldma_chan *fchan;
 	struct resource res;
 	int err;
 
 	/* alloc channel */
-	new_fsl_chan = kzalloc(sizeof(*new_fsl_chan), GFP_KERNEL);
-	if (!new_fsl_chan) {
-		dev_err(fdev->dev, "No free memory for allocating "
-				"dma channels!\n");
-		return -ENOMEM;
+	fchan = kzalloc(sizeof(*fchan), GFP_KERNEL);
+	if (!fchan) {
+		dev_err(fdev->dev, "no free memory for DMA channels!\n");
+		err = -ENOMEM;
+		goto out_return;
+	}
+
+	/* ioremap registers for use */
+	fchan->regs = of_iomap(node, 0);
+	if (!fchan->regs) {
+		dev_err(fdev->dev, "unable to ioremap registers\n");
+		err = -ENOMEM;
+		goto out_free_fchan;
 	}
 
-	/* get dma channel register base */
 	err = of_address_to_resource(node, 0, &res);
 	if (err) {
-		dev_err(fdev->dev, "Can't get %s property 'reg'\n",
-				node->full_name);
-		goto err_no_reg;
+		dev_err(fdev->dev, "unable to find 'reg' property\n");
+		goto out_iounmap_regs;
 	}
 
-	new_fsl_chan->feature = feature;
-
+	fchan->feature = feature;
 	if (!fdev->feature)
-		fdev->feature = new_fsl_chan->feature;
+		fdev->feature = fchan->feature;
 
-	/* If the DMA device's feature is different than its channels',
-	 * report the bug.
+	/*
+	 * If the DMA device's feature is different than the feature
+	 * of its channels, report the bug
 	 */
-	WARN_ON(fdev->feature != new_fsl_chan->feature);
-
-	new_fsl_chan->dev = fdev->dev;
-	new_fsl_chan->reg_base = ioremap(res.start, resource_size(&res));
-	new_fsl_chan->id = ((res.start - 0x100) & 0xfff) >> 7;
-	if (new_fsl_chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
-		dev_err(fdev->dev, "There is no %d channel!\n",
-				new_fsl_chan->id);
+	WARN_ON(fdev->feature != fchan->feature);
+
+	fchan->dev = fdev->dev;
+	fchan->id = ((res.start - 0x100) & 0xfff) >> 7;
+	if (fchan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
+		dev_err(fdev->dev, "too many channels for device\n");
 		err = -EINVAL;
-		goto err_no_chan;
+		goto out_iounmap_regs;
 	}
-	fdev->chan[new_fsl_chan->id] = new_fsl_chan;
-	tasklet_init(&new_fsl_chan->tasklet, dma_do_tasklet,
-			(unsigned long)new_fsl_chan);
 
-	/* Init the channel */
-	dma_init(new_fsl_chan);
+	fdev->chan[fchan->id] = fchan;
+	tasklet_init(&fchan->tasklet, dma_do_tasklet, (unsigned long)fchan);
+
+	/* Initialize the channel */
+	dma_init(fchan);
 
 	/* Clear cdar registers */
-	set_cdar(new_fsl_chan, 0);
+	set_cdar(fchan, 0);
 
-	switch (new_fsl_chan->feature & FSL_DMA_IP_MASK) {
+	switch (fchan->feature & FSL_DMA_IP_MASK) {
 	case FSL_DMA_IP_85XX:
-		new_fsl_chan->toggle_ext_pause = fsl_chan_toggle_ext_pause;
+		fchan->toggle_ext_pause = fsl_chan_toggle_ext_pause;
 	case FSL_DMA_IP_83XX:
-		new_fsl_chan->toggle_ext_start = fsl_chan_toggle_ext_start;
-		new_fsl_chan->set_src_loop_size = fsl_chan_set_src_loop_size;
-		new_fsl_chan->set_dst_loop_size = fsl_chan_set_dst_loop_size;
-		new_fsl_chan->set_request_count = fsl_chan_set_request_count;
+		fchan->toggle_ext_start = fsl_chan_toggle_ext_start;
+		fchan->set_src_loop_size = fsl_chan_set_src_loop_size;
+		fchan->set_dst_loop_size = fsl_chan_set_dst_loop_size;
+		fchan->set_request_count = fsl_chan_set_request_count;
 	}
 
-	spin_lock_init(&new_fsl_chan->desc_lock);
-	INIT_LIST_HEAD(&new_fsl_chan->ld_queue);
+	spin_lock_init(&fchan->desc_lock);
+	INIT_LIST_HEAD(&fchan->ld_queue);
 
-	new_fsl_chan->common.device = &fdev->common;
+	fchan->common.device = &fdev->common;
 
 	/* Add the channel to DMA device channel list */
-	list_add_tail(&new_fsl_chan->common.device_node,
-			&fdev->common.channels);
+	list_add_tail(&fchan->common.device_node, &fdev->common.channels);
 	fdev->common.chancnt++;
 
-	new_fsl_chan->irq = irq_of_parse_and_map(node, 0);
-	if (new_fsl_chan->irq != NO_IRQ) {
-		err = request_irq(new_fsl_chan->irq,
-					&fsl_dma_chan_do_interrupt, IRQF_SHARED,
-					"fsldma-channel", new_fsl_chan);
+	fchan->irq = irq_of_parse_and_map(node, 0);
+	if (fchan->irq != NO_IRQ) {
+		err = request_irq(fchan->irq, &fsldma_chan_irq,
+				  IRQF_SHARED, "fsldma-channel", fchan);
 		if (err) {
-			dev_err(fdev->dev, "DMA channel %s request_irq error "
-				"with return %d\n", node->full_name, err);
-			goto err_no_irq;
+			dev_err(fdev->dev, "unable to request IRQ "
+					   "for channel %d\n", fchan->id);
+			goto out_list_del;
 		}
 	}
 
-	dev_info(fdev->dev, "#%d (%s), irq %d\n", new_fsl_chan->id,
-		 compatible,
-		 new_fsl_chan->irq != NO_IRQ ? new_fsl_chan->irq : fdev->irq);
+	dev_info(fdev->dev, "#%d (%s), irq %d\n", fchan->id, compatible,
+		 fchan->irq != NO_IRQ ? fchan->irq : fdev->irq);
 
 	return 0;
 
-err_no_irq:
-	list_del(&new_fsl_chan->common.device_node);
-err_no_chan:
-	iounmap(new_fsl_chan->reg_base);
-err_no_reg:
-	kfree(new_fsl_chan);
+out_list_del:
+	irq_dispose_mapping(fchan->irq);
+	list_del_init(&fchan->common.device_node);
+out_iounmap_regs:
+	iounmap(fchan->regs);
+out_free_fchan:
+	kfree(fchan);
+out_return:
 	return err;
 }
 
 static void fsl_dma_chan_remove(struct fsldma_chan *fchan)
 {
-	if (fchan->irq != NO_IRQ)
+	if (fchan->irq != NO_IRQ) {
 		free_irq(fchan->irq, fchan);
+		irq_dispose_mapping(fchan->irq);
+	}
+
 	list_del(&fchan->common.device_node);
-	iounmap(fchan->reg_base);
+	iounmap(fchan->regs);
 	kfree(fchan);
 }
 
-static int __devinit fsldma_of_probe(struct of_device *dev,
+static int __devinit fsldma_of_probe(struct of_device *op,
 			const struct of_device_id *match)
 {
-	int err;
 	struct fsldma_device *fdev;
 	struct device_node *child;
-	struct resource res;
+	int err;
 
 	fdev = kzalloc(sizeof(*fdev), GFP_KERNEL);
 	if (!fdev) {
-		dev_err(&dev->dev, "No enough memory for 'priv'\n");
-		return -ENOMEM;
+		dev_err(&op->dev, "No enough memory for 'priv'\n");
+		err = -ENOMEM;
+		goto out_return;
 	}
-	fdev->dev = &dev->dev;
+
+	fdev->dev = &op->dev;
 	INIT_LIST_HEAD(&fdev->common.channels);
 
-	/* get DMA controller register base */
-	err = of_address_to_resource(dev->node, 0, &res);
-	if (err) {
-		dev_err(&dev->dev, "Can't get %s property 'reg'\n",
-				dev->node->full_name);
-		goto err_no_reg;
+	/* ioremap the registers for use */
+	fdev->regs = of_iomap(op->node, 0);
+	if (!fdev->regs) {
+		dev_err(&op->dev, "unable to ioremap registers\n");
+		err = -ENOMEM;
+		goto out_free_fdev;
 	}
 
-	dev_info(&dev->dev, "Probe the Freescale DMA driver for %s "
-			"controller at 0x%llx...\n",
-			match->compatible, (unsigned long long)res.start);
-	fdev->reg_base = ioremap(res.start, resource_size(&res));
-
 	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
 	dma_cap_set(DMA_INTERRUPT, fdev->common.cap_mask);
 	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
@@ -1220,66 +1222,69 @@ static int __devinit fsldma_of_probe(struct of_device *dev,
 	fdev->common.device_issue_pending = fsl_dma_memcpy_issue_pending;
 	fdev->common.device_prep_slave_sg = fsl_dma_prep_slave_sg;
 	fdev->common.device_terminate_all = fsl_dma_device_terminate_all;
-	fdev->common.dev = &dev->dev;
+	fdev->common.dev = &op->dev;
 
-	fdev->irq = irq_of_parse_and_map(dev->node, 0);
+	fdev->irq = irq_of_parse_and_map(op->node, 0);
 	if (fdev->irq != NO_IRQ) {
-		err = request_irq(fdev->irq, &fsl_dma_do_interrupt, IRQF_SHARED,
-					"fsldma-device", fdev);
+		err = request_irq(fdev->irq, &fsldma_irq, IRQF_SHARED,
+				  "fsldma-device", fdev);
 		if (err) {
-			dev_err(&dev->dev, "DMA device request_irq error "
-				"with return %d\n", err);
-			goto err;
+			dev_err(&op->dev, "unable to request IRQ\n");
+			goto out_iounmap_regs;
 		}
 	}
 
-	dev_set_drvdata(&(dev->dev), fdev);
+	dev_set_drvdata(&op->dev, fdev);
 
-	/* We cannot use of_platform_bus_probe() because there is no
-	 * of_platform_bus_remove.  Instead, we manually instantiate every DMA
+	/*
+	 * We cannot use of_platform_bus_probe() because there is no
+	 * of_platform_bus_remove(). Instead, we manually instantiate every DMA
 	 * channel object.
 	 */
-	for_each_child_of_node(dev->node, child) {
-		if (of_device_is_compatible(child, "fsl,eloplus-dma-channel"))
+	for_each_child_of_node(op->node, child) {
+		if (of_device_is_compatible(child, "fsl,eloplus-dma-channel")) {
 			fsl_dma_chan_probe(fdev, child,
 				FSL_DMA_IP_85XX | FSL_DMA_BIG_ENDIAN,
 				"fsl,eloplus-dma-channel");
-		if (of_device_is_compatible(child, "fsl,elo-dma-channel"))
+		}
+
+		if (of_device_is_compatible(child, "fsl,elo-dma-channel")) {
 			fsl_dma_chan_probe(fdev, child,
 				FSL_DMA_IP_83XX | FSL_DMA_LITTLE_ENDIAN,
 				"fsl,elo-dma-channel");
+		}
 	}
 
 	dma_async_device_register(&fdev->common);
 	return 0;
 
-err:
-	iounmap(fdev->reg_base);
-err_no_reg:
+out_iounmap_regs:
+	iounmap(fdev->regs);
+out_free_fdev:
 	kfree(fdev);
+out_return:
 	return err;
 }
 
-static int fsldma_of_remove(struct of_device *of_dev)
+static int fsldma_of_remove(struct of_device *op)
 {
 	struct fsldma_device *fdev;
 	unsigned int i;
 
-	fdev = dev_get_drvdata(&of_dev->dev);
-
+	fdev = dev_get_drvdata(&op->dev);
 	dma_async_device_unregister(&fdev->common);
 
-	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++)
+	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
+	}
 
 	if (fdev->irq != NO_IRQ)
 		free_irq(fdev->irq, fdev);
 
-	iounmap(fdev->reg_base);
-
+	iounmap(fdev->regs);
+	dev_set_drvdata(&op->dev, NULL);
 	kfree(fdev);
-	dev_set_drvdata(&of_dev->dev, NULL);
 
 	return 0;
 }
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index a67b8e3..ea3b19c 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -108,7 +108,7 @@ struct fsldma_chan;
 #define FSL_DMA_MAX_CHANS_PER_DEVICE 4
 
 struct fsldma_device {
-	void __iomem *reg_base;	/* DGSR register base */
+	void __iomem *regs;	/* DGSR register base */
 	struct device *dev;
 	struct dma_device common;
 	struct fsldma_chan *chan[FSL_DMA_MAX_CHANS_PER_DEVICE];
@@ -128,7 +128,7 @@ struct fsldma_device {
 #define FSL_DMA_CHAN_START_EXT	0x00002000
 
 struct fsldma_chan {
-	struct fsldma_chan_regs __iomem *reg_base;
+	struct fsldma_chan_regs __iomem *regs;
 	dma_cookie_t completed_cookie;	/* The maximum cookie completed */
 	spinlock_t desc_lock;		/* Descriptor operation lock */
 	struct list_head ld_queue;	/* Link descriptors queue */
-- 
1.5.4.3
