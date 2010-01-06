Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id A1DC8B6F0A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 10:34:08 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: dan.j.williams@intel.com
Subject: [PATCH 2/8] fsldma: remove unused structure members
Date: Wed,  6 Jan 2010 15:34:00 -0800
Message-Id: <1262820846-13198-3-git-send-email-iws@ovro.caltech.edu>
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

Remove some unused members from the fsldma data structures. A few trivial
uses of struct resource were converted to use the stack rather than keeping
the memory allocated for the lifetime of the driver.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |   17 ++++++++---------
 drivers/dma/fsldma.h |    4 ----
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 0bad741..0b4e638 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1072,6 +1072,7 @@ static int __devinit fsl_dma_chan_probe(struct fsl_dma_device *fdev,
 	struct device_node *node, u32 feature, const char *compatible)
 {
 	struct fsl_dma_chan *new_fsl_chan;
+	struct resource res;
 	int err;
 
 	/* alloc channel */
@@ -1083,7 +1084,7 @@ static int __devinit fsl_dma_chan_probe(struct fsl_dma_device *fdev,
 	}
 
 	/* get dma channel register base */
-	err = of_address_to_resource(node, 0, &new_fsl_chan->reg);
+	err = of_address_to_resource(node, 0, &res);
 	if (err) {
 		dev_err(fdev->dev, "Can't get %s property 'reg'\n",
 				node->full_name);
@@ -1101,10 +1102,8 @@ static int __devinit fsl_dma_chan_probe(struct fsl_dma_device *fdev,
 	WARN_ON(fdev->feature != new_fsl_chan->feature);
 
 	new_fsl_chan->dev = fdev->dev;
-	new_fsl_chan->reg_base = ioremap(new_fsl_chan->reg.start,
-			new_fsl_chan->reg.end - new_fsl_chan->reg.start + 1);
-
-	new_fsl_chan->id = ((new_fsl_chan->reg.start - 0x100) & 0xfff) >> 7;
+	new_fsl_chan->reg_base = ioremap(res.start, resource_size(&res));
+	new_fsl_chan->id = ((res.start - 0x100) & 0xfff) >> 7;
 	if (new_fsl_chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
 		dev_err(fdev->dev, "There is no %d channel!\n",
 				new_fsl_chan->id);
@@ -1183,6 +1182,7 @@ static int __devinit of_fsl_dma_probe(struct of_device *dev,
 	int err;
 	struct fsl_dma_device *fdev;
 	struct device_node *child;
+	struct resource res;
 
 	fdev = kzalloc(sizeof(struct fsl_dma_device), GFP_KERNEL);
 	if (!fdev) {
@@ -1193,7 +1193,7 @@ static int __devinit of_fsl_dma_probe(struct of_device *dev,
 	INIT_LIST_HEAD(&fdev->common.channels);
 
 	/* get DMA controller register base */
-	err = of_address_to_resource(dev->node, 0, &fdev->reg);
+	err = of_address_to_resource(dev->node, 0, &res);
 	if (err) {
 		dev_err(&dev->dev, "Can't get %s property 'reg'\n",
 				dev->node->full_name);
@@ -1202,9 +1202,8 @@ static int __devinit of_fsl_dma_probe(struct of_device *dev,
 
 	dev_info(&dev->dev, "Probe the Freescale DMA driver for %s "
 			"controller at 0x%llx...\n",
-			match->compatible, (unsigned long long)fdev->reg.start);
-	fdev->reg_base = ioremap(fdev->reg.start, fdev->reg.end
-						- fdev->reg.start + 1);
+			match->compatible, (unsigned long long)res.start);
+	fdev->reg_base = ioremap(res.start, resource_size(&res));
 
 	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
 	dma_cap_set(DMA_INTERRUPT, fdev->common.cap_mask);
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 0df14cb..dbb5b5c 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -92,8 +92,6 @@ struct fsl_desc_sw {
 	struct list_head node;
 	struct list_head tx_list;
 	struct dma_async_tx_descriptor async_tx;
-	struct list_head *ld;
-	void *priv;
 } __attribute__((aligned(32)));
 
 struct fsl_dma_chan_regs {
@@ -111,7 +109,6 @@ struct fsl_dma_chan;
 
 struct fsl_dma_device {
 	void __iomem *reg_base;	/* DGSR register base */
-	struct resource reg;	/* Resource for register */
 	struct device *dev;
 	struct dma_device common;
 	struct fsl_dma_chan *chan[FSL_DMA_MAX_CHANS_PER_DEVICE];
@@ -138,7 +135,6 @@ struct fsl_dma_chan {
 	struct dma_chan common;		/* DMA common channel */
 	struct dma_pool *desc_pool;	/* Descriptors pool */
 	struct device *dev;		/* Channel device */
-	struct resource reg;		/* Resource for register */
 	int irq;			/* Channel IRQ */
 	int id;				/* Raw id of this channel */
 	struct tasklet_struct tasklet;
-- 
1.5.4.3
