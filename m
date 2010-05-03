Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C989B7D21
	for <linuxppc-dev@ozlabs.org>; Tue,  4 May 2010 09:01:56 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: broonie@opensource.wolfsonmicro.com, kumar.gala@freescale.com,
	alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] [v2] powerpc/alsa: update MPC8610 HPCD audio drivers to
	support multiple components
Date: Mon,  3 May 2010 18:01:19 -0500
Message-Id: <1272927679-6827-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the Freescale MPC8610 HPCD audio drivers to support the new multiple-
component architecture in ASoC.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_dma.c      |  299 ++++++-----
 sound/soc/fsl/fsl_dma.h      |   19 +-
 sound/soc/fsl/fsl_ssi.c      |  211 +++++----
 sound/soc/fsl/fsl_ssi.h      |   25 -
 sound/soc/fsl/mpc8610_hpcd.c | 1174 ++++++++++++++++++++----------------------
 5 files changed, 844 insertions(+), 884 deletions(-)
 rewrite sound/soc/fsl/mpc8610_hpcd.c (62%)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 857e9f7..ff0064c 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -3,10 +3,11 @@
  *
  * Author: Timur Tabi <timur@freescale.com>
  *
- * Copyright 2007-2008 Freescale Semiconductor, Inc.  This file is licensed
- * under the terms of the GNU General Public License version 2.  This
- * program is licensed "as is" without any warranty of any kind, whether
- * express or implied.
+ * Copyright 2007-2010 Freescale Semiconductor, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
  *
  * This driver implements ASoC support for the Elo DMA controller, which is
  * the DMA controller on Freescale 83xx, 85xx, and 86xx SOCs. In ALSA terms,
@@ -15,10 +16,11 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/of_platform.h>
+#include <linux/list.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -51,26 +53,16 @@
 #define FSLDMA_PCM_RATES (SNDRV_PCM_RATE_5512 | SNDRV_PCM_RATE_8000_192000 | \
 			  SNDRV_PCM_RATE_CONTINUOUS)
 
-/* DMA global data.  This structure is used by fsl_dma_open() to determine
- * which DMA channels to assign to a substream.  Unfortunately, ASoC V1 does
- * not allow the machine driver to provide this information to the PCM
- * driver in advance, and there's no way to differentiate between the two
- * DMA controllers.  So for now, this driver only supports one SSI device
- * using two DMA channels.  We cannot support multiple DMA devices.
- *
- * ssi_stx_phys: bus address of SSI STX register
- * ssi_srx_phys: bus address of SSI SRX register
- * dma_channel: pointer to the DMA channel's registers
- * irq: IRQ for this DMA channel
- * assigned: set to 1 if that DMA channel is assigned to a substream
- */
-static struct {
+struct dma_object {
+	struct list_head list;
+	struct snd_soc_platform_driver dai;
 	dma_addr_t ssi_stx_phys;
 	dma_addr_t ssi_srx_phys;
-	struct ccsr_dma_channel __iomem *dma_channel[2];
-	unsigned int irq[2];
-	unsigned int assigned[2];
-} dma_global_data;
+	struct ccsr_dma_channel __iomem *channel;
+	unsigned int irq;
+	bool assigned;
+	char path[1];
+};
 
 /*
  * The number of DMA links to use.  Two is the bare minimum, but if you
@@ -87,8 +79,6 @@ static struct {
  * structure.
  *
  * @link[]: array of link descriptors
- * @controller_id: which DMA controller (0, 1, ...)
- * @channel_id: which DMA channel on the controller (0, 1, 2, ...)
  * @dma_channel: pointer to the DMA channel's registers
  * @irq: IRQ for this DMA channel
  * @substream: pointer to the substream object, needed by the ISR
@@ -103,8 +93,6 @@ static struct {
  */
 struct fsl_dma_private {
 	struct fsl_dma_link_descriptor link[NUM_DMA_LINKS];
-	unsigned int controller_id;
-	unsigned int channel_id;
 	struct ccsr_dma_channel __iomem *dma_channel;
 	unsigned int irq;
 	struct snd_pcm_substream *substream;
@@ -211,6 +199,9 @@ static void fsl_dma_update_pointers(struct fsl_dma_private *dma_private)
 static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
 {
 	struct fsl_dma_private *dma_private = dev_id;
+	struct snd_pcm_substream *substream = dma_private->substream;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct device *dev = rtd->platform->dev;
 	struct ccsr_dma_channel __iomem *dma_channel = dma_private->dma_channel;
 	irqreturn_t ret = IRQ_NONE;
 	u32 sr, sr2 = 0;
@@ -221,11 +212,8 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
 	sr = in_be32(&dma_channel->sr);
 
 	if (sr & CCSR_DMA_SR_TE) {
-		dev_err(dma_private->substream->pcm->card->dev,
-			"DMA transmit error (controller=%u channel=%u irq=%u\n",
-			dma_private->controller_id,
-			dma_private->channel_id, irq);
-		fsl_dma_abort_stream(dma_private->substream);
+		dev_err(dev, "dma transmit error\n");
+		fsl_dma_abort_stream(substream);
 		sr2 |= CCSR_DMA_SR_TE;
 		ret = IRQ_HANDLED;
 	}
@@ -234,11 +222,8 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
 		ret = IRQ_HANDLED;
 
 	if (sr & CCSR_DMA_SR_PE) {
-		dev_err(dma_private->substream->pcm->card->dev,
-			"DMA%u programming error (channel=%u irq=%u)\n",
-			dma_private->controller_id,
-			dma_private->channel_id, irq);
-		fsl_dma_abort_stream(dma_private->substream);
+		dev_err(dev, "dma programming error\n");
+		fsl_dma_abort_stream(substream);
 		sr2 |= CCSR_DMA_SR_PE;
 		ret = IRQ_HANDLED;
 	}
@@ -252,8 +237,6 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
 		ret = IRQ_HANDLED;
 
 	if (sr & CCSR_DMA_SR_EOSI) {
-		struct snd_pcm_substream *substream = dma_private->substream;
-
 		/* Tell ALSA we completed a period. */
 		snd_pcm_period_elapsed(substream);
 
@@ -304,10 +287,8 @@ static int fsl_dma_new(struct snd_card *card, struct snd_soc_dai *dai,
 		fsl_dma_hardware.buffer_bytes_max,
 		&pcm->streams[0].substream->dma_buffer);
 	if (ret) {
-		dev_err(card->dev,
-			"Can't allocate playback DMA buffer (size=%u)\n",
-			fsl_dma_hardware.buffer_bytes_max);
-		return -ENOMEM;
+		dev_err(card->dev, "can't allocate playback dma buffer\n");
+		return ret;
 	}
 
 	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
@@ -315,10 +296,8 @@ static int fsl_dma_new(struct snd_card *card, struct snd_soc_dai *dai,
 		&pcm->streams[1].substream->dma_buffer);
 	if (ret) {
 		snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
-		dev_err(card->dev,
-			"Can't allocate capture DMA buffer (size=%u)\n",
-			fsl_dma_hardware.buffer_bytes_max);
-		return -ENOMEM;
+		dev_err(card->dev, "can't allocate capture dma buffer\n");
+		return ret;
 	}
 
 	return 0;
@@ -389,6 +368,10 @@ static int fsl_dma_new(struct snd_card *card, struct snd_soc_dai *dai,
 static int fsl_dma_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct device *dev = rtd->platform->dev;
+	struct dma_object *dma =
+		container_of(rtd->platform->driver, struct dma_object, dai);
 	struct fsl_dma_private *dma_private;
 	struct ccsr_dma_channel __iomem *dma_channel;
 	dma_addr_t ld_buf_phys;
@@ -406,52 +389,44 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 	ret = snd_pcm_hw_constraint_integer(runtime,
 		SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0) {
-		dev_err(substream->pcm->card->dev, "invalid buffer size\n");
+		dev_err(dev, "invalid buffer size\n");
 		return ret;
 	}
 
 	channel = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
 
-	if (dma_global_data.assigned[channel]) {
-		dev_err(substream->pcm->card->dev,
-			"DMA channel already assigned\n");
+	if (dma->assigned) {
+		dev_err(dev, "dma channel already assigned\n");
 		return -EBUSY;
 	}
 
-	dma_private = dma_alloc_coherent(substream->pcm->card->dev,
-		sizeof(struct fsl_dma_private), &ld_buf_phys, GFP_KERNEL);
+	dma_private = dma_alloc_coherent(dev, sizeof(struct fsl_dma_private),
+					 &ld_buf_phys, GFP_KERNEL);
 	if (!dma_private) {
-		dev_err(substream->pcm->card->dev,
-			"can't allocate DMA private data\n");
+		dev_err(dev, "can't allocate dma private data\n");
 		return -ENOMEM;
 	}
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_private->ssi_sxx_phys = dma_global_data.ssi_stx_phys;
+		dma_private->ssi_sxx_phys = dma->ssi_stx_phys;
 	else
-		dma_private->ssi_sxx_phys = dma_global_data.ssi_srx_phys;
+		dma_private->ssi_sxx_phys = dma->ssi_srx_phys;
 
-	dma_private->dma_channel = dma_global_data.dma_channel[channel];
-	dma_private->irq = dma_global_data.irq[channel];
+	dma_private->dma_channel = dma->channel;
+	dma_private->irq = dma->irq;
 	dma_private->substream = substream;
 	dma_private->ld_buf_phys = ld_buf_phys;
 	dma_private->dma_buf_phys = substream->dma_buffer.addr;
 
-	/* We only support one DMA controller for now */
-	dma_private->controller_id = 0;
-	dma_private->channel_id = channel;
-
 	ret = request_irq(dma_private->irq, fsl_dma_isr, 0, "DMA", dma_private);
 	if (ret) {
-		dev_err(substream->pcm->card->dev,
-			"can't register ISR for IRQ %u (ret=%i)\n",
+		dev_err(dev, "can't register ISR for IRQ %u (ret=%i)\n",
 			dma_private->irq, ret);
-		dma_free_coherent(substream->pcm->card->dev,
-			sizeof(struct fsl_dma_private),
+		dma_free_coherent(dev, sizeof(struct fsl_dma_private),
 			dma_private, dma_private->ld_buf_phys);
 		return ret;
 	}
 
-	dma_global_data.assigned[channel] = 1;
+	dma->assigned = 1;
 
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 	snd_soc_set_runtime_hwparams(substream, &fsl_dma_hardware);
@@ -545,6 +520,8 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_dma_private *dma_private = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct device *dev = rtd->platform->dev;
 
 	/* Number of bits per sample */
 	unsigned int sample_size =
@@ -605,8 +582,7 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 		break;
 	default:
 		/* We should never get here */
-		dev_err(substream->pcm->card->dev,
-			"unsupported sample size %u\n", sample_size);
+		dev_err(dev, "unsupported sample size %u\n", sample_size);
 		return -EINVAL;
 	}
 
@@ -688,6 +664,8 @@ static snd_pcm_uframes_t fsl_dma_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_dma_private *dma_private = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct device *dev = rtd->platform->dev;
 	struct ccsr_dma_channel __iomem *dma_channel = dma_private->dma_channel;
 	dma_addr_t position;
 	snd_pcm_uframes_t frames;
@@ -709,8 +687,7 @@ static snd_pcm_uframes_t fsl_dma_pointer(struct snd_pcm_substream *substream)
 
 	if ((position < dma_private->dma_buf_phys) ||
 	    (position > dma_private->dma_buf_end)) {
-		dev_err(substream->pcm->card->dev,
-			"dma pointer is out of range, halting stream\n");
+		dev_err(dev, "dma pointer is out of range, halting stream\n");
 		return SNDRV_PCM_POS_XRUN;
 	}
 
@@ -771,26 +748,28 @@ static int fsl_dma_close(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_dma_private *dma_private = runtime->private_data;
-	int dir = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct device *dev = rtd->platform->dev;
+	struct dma_object *dma =
+		container_of(rtd->platform->driver, struct dma_object, dai);
 
 	if (dma_private) {
 		if (dma_private->irq)
 			free_irq(dma_private->irq, dma_private);
 
 		if (dma_private->ld_buf_phys) {
-			dma_unmap_single(substream->pcm->card->dev,
-				dma_private->ld_buf_phys,
-				sizeof(dma_private->link), DMA_TO_DEVICE);
+			dma_unmap_single(dev, dma_private->ld_buf_phys,
+					 sizeof(dma_private->link),
+					 DMA_TO_DEVICE);
 		}
 
 		/* Deallocate the fsl_dma_private structure */
-		dma_free_coherent(substream->pcm->card->dev,
-			sizeof(struct fsl_dma_private),
-			dma_private, dma_private->ld_buf_phys);
+		dma_free_coherent(dev, sizeof(struct fsl_dma_private),
+				  dma_private, dma_private->ld_buf_phys);
 		substream->runtime->private_data = NULL;
 	}
 
-	dma_global_data.assigned[dir] = 0;
+	dma->assigned = 0;
 
 	return 0;
 }
@@ -813,6 +792,41 @@ static void fsl_dma_free_dma_buffers(struct snd_pcm *pcm)
 	}
 }
 
+/* List of DMA nodes that we've probed */
+static LIST_HEAD(dma_list);
+
+/**
+ * fsl_soc_dma_to_dai - returning the DAI struct for a given DMA node
+ *
+ * When a machine driver registers itself with ASoC, it must provide the
+ * address of the DAI structures that it wants to connect.  Most drivers simply
+ * reference global data structures in the various drivers, but we PowerPC
+ * developers are better than that.  This driver keeps a list of every DMA
+ * node that it probes, and when the machine driver wants to reference a
+ * DMA DAI, this function provides that service.
+ *
+ * Hopefully one day, ASoC will just want the name of the DMA device, not
+ * some obscure pointer, and this function will go away.
+ */
+struct snd_soc_platform_driver *fsl_soc_dma_to_dai(const char *path,
+	dma_addr_t ssi_stx_phys, dma_addr_t ssi_srx_phys)
+{
+	struct list_head *ptr;
+	struct dma_object *dma;
+
+	list_for_each(ptr, &dma_list) {
+		dma = list_entry(ptr, struct dma_object, list);
+		if (strcmp(path, dma->path) == 0) {
+			dma->ssi_stx_phys = ssi_stx_phys;
+			dma->ssi_srx_phys = ssi_srx_phys;
+			return &dma->dai;
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(fsl_soc_dma_to_dai);
+
 static struct snd_pcm_ops fsl_dma_ops = {
 	.open   	= fsl_dma_open,
 	.close  	= fsl_dma_close,
@@ -822,80 +836,91 @@ static struct snd_pcm_ops fsl_dma_ops = {
 	.pointer	= fsl_dma_pointer,
 };
 
-struct snd_soc_platform_driver fsl_soc_platform = {
-	.name   	= "fsl-dma",
-	.ops	= &fsl_dma_ops,
-	.pcm_new	= fsl_dma_new,
-	.pcm_free       = fsl_dma_free_dma_buffers,
-};
-EXPORT_SYMBOL_GPL(fsl_soc_platform);
-
-/**
- * fsl_dma_configure: store the DMA parameters from the fabric driver.
- *
- * This function is called by the ASoC fabric driver to give us the DMA and
- * SSI channel information.
- *
- * Unfortunately, ASoC V1 does make it possible to determine the DMA/SSI
- * data when a substream is created, so for now we need to store this data
- * into a global variable.  This means that we can only support one DMA
- * controller, and hence only one SSI.
- */
-int fsl_dma_configure(struct fsl_dma_info *dma_info)
+static int __devinit fsl_soc_dma_probe(struct of_device *of_dev,
+				       const struct of_device_id *match)
 {
-	static int initialized;
+	struct dma_object *dma;
+	struct device_node *np = of_dev->node;
+	int ret;
 
-	/* We only support one DMA controller for now */
-	if (initialized)
-		return 0;
+	dma = kzalloc(sizeof(*dma) + strlen(np->full_name), GFP_KERNEL);
+	if (!dma) {
+		dev_err(&of_dev->dev, "could not allocate dma object\n");
+		return -ENOMEM;
+	}
 
-	dma_global_data.ssi_stx_phys = dma_info->ssi_stx_phys;
-	dma_global_data.ssi_srx_phys = dma_info->ssi_srx_phys;
-	dma_global_data.dma_channel[0] = dma_info->dma_channel[0];
-	dma_global_data.dma_channel[1] = dma_info->dma_channel[1];
-	dma_global_data.irq[0] = dma_info->dma_irq[0];
-	dma_global_data.irq[1] = dma_info->dma_irq[1];
-	dma_global_data.assigned[0] = 0;
-	dma_global_data.assigned[1] = 0;
-
-	initialized = 1;
-	return 1;
-}
-EXPORT_SYMBOL_GPL(fsl_dma_configure);
+	strcpy(dma->path, np->full_name);
+	dma->dai.name = dma->path;
+	dma->dai.ops = &fsl_dma_ops;
+	dma->dai.pcm_new = fsl_dma_new;
+	dma->dai.pcm_free = fsl_dma_free_dma_buffers;
 
-static int __devinit fsl_soc_platform_probe(struct platform_device *pdev)
-{
-	return snd_soc_register_platform(&pdev->dev, -1, &fsl_soc_platform);
+	ret = snd_soc_register_platform(&of_dev->dev, 0, &dma->dai);
+	if (ret) {
+		dev_err(&of_dev->dev, "could not register platform\n");
+		kfree(dma);
+		return ret;
+	}
+
+	dma->channel = of_iomap(np, 0);
+	dma->irq = irq_of_parse_and_map(np, 0);
+	list_add(&dma->list, &dma_list);
+
+	return 0;
 }
 
-static int __devexit fsl_soc_platform_remove(struct platform_device *pdev)
+static int __devexit fsl_soc_dma_remove(struct of_device *of_dev)
 {
-	snd_soc_unregister_platform(&pdev->dev, -1);
+	struct list_head *n, *ptr;
+	struct dma_object *dma;
+
+	list_for_each_safe(ptr, n, &dma_list) {
+		dma = list_entry(ptr, struct dma_object, list);
+		list_del_init(ptr);
+
+		snd_soc_unregister_platform(&of_dev->dev, 0);
+		iounmap(dma->channel);
+		irq_dispose_mapping(dma->irq);
+		kfree(dma);
+	}
+
 	return 0;
 }
 
-static struct platform_driver fsl_pcm_driver = {
-	.driver = {
-			.name = "fsl-pcm-audio",
-			.owner = THIS_MODULE,
-	},
 
-	.probe = fsl_soc_platform_probe,
-	.remove = __devexit_p(fsl_soc_platform_remove),
+static const struct of_device_id fsl_soc_dma_ids[] = {
+	{ .compatible = "fsl,ssi-dma-channel", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, fsl_soc_dma_ids);
+
+static struct of_platform_driver fsl_soc_dma_driver = {
+	.name = "fsl-soc-dma-dai",
+	.match_table = fsl_soc_dma_ids,
+	.probe = fsl_soc_dma_probe,
+	.remove = __devexit_p(fsl_soc_dma_remove),
 };
 
-static int __init snd_fsl_pcm_init(void)
+static int __init fsl_soc_dma_init(void)
 {
-	return platform_driver_register(&fsl_pcm_driver);
+	pr_info("Freescale Elo DMA ASoC PCM Driver\n");
+
+	return of_register_platform_driver(&fsl_soc_dma_driver);
 }
-module_init(snd_fsl_pcm_init);
 
-static void __exit snd_fsl_pcm_exit(void)
+static void __exit fsl_soc_dma_exit(void)
 {
-	platform_driver_unregister(&fsl_pcm_driver);
+	of_unregister_platform_driver(&fsl_soc_dma_driver);
 }
-module_exit(snd_fsl_pcm_exit);
+
+/* We want the DMA driver to be initialized before the SSI driver, so that
+ * when the SSI driver calls fsl_soc_dma_dai_from_node(), the DMA driver
+ * will already have been probed.  The easiest way to do that is to make the
+ * __init function called via arch_initcall().
+ */
+arch_initcall(fsl_soc_dma_init);
+module_exit(fsl_soc_dma_exit);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
-MODULE_DESCRIPTION("Freescale Elo DMA ASoC PCM module");
-MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Freescale Elo DMA ASoC PCM Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/fsl/fsl_dma.h b/sound/soc/fsl/fsl_dma.h
index 253bd3c..88c686d 100644
--- a/sound/soc/fsl/fsl_dma.h
+++ b/sound/soc/fsl/fsl_dma.h
@@ -126,24 +126,9 @@ struct fsl_dma_link_descriptor {
 	u8 res[4];      /* Reserved */
 } __attribute__ ((aligned(32), packed));
 
-/* DMA information needed to create a snd_soc_dai object
- *
- * ssi_stx_phys: bus address of SSI STX register to use
- * ssi_srx_phys: bus address of SSI SRX register to use
- * dma[0]: points to the DMA channel to use for playback
- * dma[1]: points to the DMA channel to use for capture
- * dma_irq[0]: IRQ of the DMA channel to use for playback
- * dma_irq[1]: IRQ of the DMA channel to use for capture
- */
-struct fsl_dma_info {
-	dma_addr_t ssi_stx_phys;
-	dma_addr_t ssi_srx_phys;
-	struct ccsr_dma_channel __iomem *dma_channel[2];
-	unsigned int dma_irq[2];
-};
-
 extern struct snd_soc_platform_driver fsl_soc_platform;
 
-int fsl_dma_configure(struct fsl_dma_info *dma_info);
+struct snd_soc_platform_driver *fsl_soc_dma_to_dai(const char *path,
+	dma_addr_t ssi_stx_phys, dma_addr_t ssi_srx_phys);
 
 #endif
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 780e243..56e66c2 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -3,10 +3,11 @@
  *
  * Author: Timur Tabi <timur@freescale.com>
  *
- * Copyright 2007-2008 Freescale Semiconductor, Inc.  This file is licensed
- * under the terms of the GNU General Public License version 2.  This
- * program is licensed "as is" without any warranty of any kind, whether
- * express or implied.
+ * Copyright 2007-2010 Freescale Semiconductor, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
  */
 
 #include <linux/init.h>
@@ -14,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/of_platform.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -70,33 +72,31 @@
 /**
  * fsl_ssi_private: per-SSI private data
  *
- * @name: short name for this device ("SSI0", "SSI1", etc)
  * @ssi: pointer to the SSI's registers
  * @ssi_phys: physical address of the SSI registers
  * @irq: IRQ of this SSI
  * @first_stream: pointer to the stream that was opened first
  * @second_stream: pointer to second stream
- * @dev: struct device pointer
  * @playback: the number of playback streams opened
  * @capture: the number of capture streams opened
  * @asynchronous: 0=synchronous mode, 1=asynchronous mode
  * @cpu_dai: the CPU DAI for this device
  * @dev_attr: the sysfs device attribute structure
  * @stats: SSI statistics
+ * @name: name for this device
  */
 struct fsl_ssi_private {
-	char name[8];
 	struct ccsr_ssi __iomem *ssi;
 	dma_addr_t ssi_phys;
 	unsigned int irq;
 	struct snd_pcm_substream *first_stream;
 	struct snd_pcm_substream *second_stream;
-	struct device *dev;
 	unsigned int playback;
 	unsigned int capture;
 	int asynchronous;
 	struct snd_soc_dai_driver cpu_dai_drv;
 	struct device_attribute dev_attr;
+	struct platform_device *pdev;
 
 	struct {
 		unsigned int rfrc;
@@ -121,6 +121,8 @@ struct fsl_ssi_private {
 		unsigned int tfe1;
 		unsigned int tfe0;
 	} stats;
+
+	char name[1];
 };
 
 /**
@@ -289,8 +291,10 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 		int ret;
 
+		/* The 'name' should not have any slashes in it. */
 		ret = request_irq(ssi_private->irq, fsl_ssi_isr, 0,
-				  ssi_private->name, ssi_private);
+				  strrchr(ssi_private->name, '/') + 1,
+				  ssi_private);
 		if (ret < 0) {
 			dev_err(substream->pcm->card->dev,
 				"could not claim irq %u\n", ssi_private->irq);
@@ -522,56 +526,15 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 	}
 }
 
-/**
- * fsl_ssi_set_sysclk: set the clock frequency and direction
- *
- * This function is called by the machine driver to tell us what the clock
- * frequency and direction are.
- *
- * Currently, we only support operating as a clock slave (SND_SOC_CLOCK_IN),
- * and we don't care about the frequency.  Return an error if the direction
- * is not SND_SOC_CLOCK_IN.
- *
- * @clk_id: reserved, should be zero
- * @freq: the frequency of the given clock ID, currently ignored
- * @dir: SND_SOC_CLOCK_IN (clock slave) or SND_SOC_CLOCK_OUT (clock master)
- */
-static int fsl_ssi_set_sysclk(struct snd_soc_dai *cpu_dai,
-			      int clk_id, unsigned int freq, int dir)
-{
-
-	return (dir == SND_SOC_CLOCK_IN) ? 0 : -EINVAL;
-}
-
-/**
- * fsl_ssi_set_fmt: set the serial format.
- *
- * This function is called by the machine driver to tell us what serial
- * format to use.
- *
- * Currently, we only support I2S mode.  Return an error if the format is
- * not SND_SOC_DAIFMT_I2S.
- *
- * @format: one of SND_SOC_DAIFMT_xxx
- */
-static int fsl_ssi_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int format)
-{
-	return (format == SND_SOC_DAIFMT_I2S) ? 0 : -EINVAL;
-}
-
-/**
- * fsl_ssi_dai_template: template CPU DAI for the SSI
- */
 static struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 	.startup	= fsl_ssi_startup,
 	.hw_params	= fsl_ssi_hw_params,
 	.shutdown	= fsl_ssi_shutdown,
 	.trigger	= fsl_ssi_trigger,
-	.set_sysclk	= fsl_ssi_set_sysclk,
-	.set_fmt	= fsl_ssi_set_fmt,
 };
 
-struct snd_soc_dai_driver fsl_ssi_dai = {
+/* Template for the CPU dai driver structure */
+static struct snd_soc_dai_driver fsl_ssi_dai_template = {
 	.playback = {
 		/* The SSI does not support monaural audio. */
 		.channels_min = 2,
@@ -587,7 +550,6 @@ struct snd_soc_dai_driver fsl_ssi_dai = {
 	},
 	.ops = &fsl_ssi_dai_ops,
 };
-EXPORT_SYMBOL_GPL(fsl_ssi_dai);
 
 /* Show the statistics of a flag only if its interrupt is enabled.  The
  * compiler will optimze this code to a no-op if the interrupt is not
@@ -639,92 +601,163 @@ static ssize_t fsl_sysfs_ssi_show(struct device *dev,
 	return length;
 }
 
-static int fsl_ssi_probe(struct platform_device *pdev)
+/**
+ * Make every character in a string lower-case
+ */
+static void make_lowercase(char *s)
+{
+	char *p = s;
+	char c;
+
+	while ((c = *p)) {
+		if ((c >= 'A') && (c <= 'Z'))
+			*p = c + ('a' - 'A');
+		p++;
+	}
+}
+
+static int __devinit fsl_ssi_probe(struct of_device *of_dev,
+				   const struct of_device_id *match)
 {
-	struct fsl_ssi_info *ssi_info = dev_get_platdata(&pdev->dev);
 	struct fsl_ssi_private *ssi_private;
 	int ret = 0;
 	struct device_attribute *dev_attr;
+	struct device_node *np = of_dev->node;
+	const char *sprop;
+	struct resource res;
+	char name[64];
+	struct platform_device *pdev;
+	void *platform_data;
+
+	/* We are only interested in SSIs with a codec phandle in them, so let's
+	 * make sure this SSI has one.
+	 */
+	if (!of_get_property(np, "codec-handle", NULL))
+		return -ENODEV;
+
+	/* We only support the SSI in "I2S Slave" mode */
+	sprop = of_get_property(np, "fsl,mode", NULL);
+	if (!sprop || strcmp(sprop, "i2s-slave")) {
+		dev_notice(&of_dev->dev, "mode %s is unsupported\n", sprop);
+		return -ENODEV;
+	}
 
-	ssi_private = kzalloc(sizeof(struct fsl_ssi_private), GFP_KERNEL);
+	ssi_private = kzalloc(sizeof(struct fsl_ssi_private) +
+			      strlen(np->full_name), GFP_KERNEL);
 	if (!ssi_private) {
-		dev_err(ssi_info->dev, "could not allocate DAI object\n");
+		dev_err(&of_dev->dev, "could not allocate DAI object\n");
 		return -ENOMEM;
 	}
 
-	dev_attr = &ssi_private->dev_attr;
+	/* Initialize this copy of the CPU DAI driver structure */
+	memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
+	       sizeof(fsl_ssi_dai_template));
+	ssi_private->cpu_dai_drv.name = ssi_private->name;
+
+	/* The name we register with ASoC is the full node name */
+	strlcpy(ssi_private->name, np->full_name, sizeof(ssi_private->name));
+
+	/* Get the addresses and IRQ */
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret) {
+		dev_err(&of_dev->dev, "could not determine device resources\n");
+		kfree(ssi_private);
+		return ret;
+	}
+	ssi_private->ssi = ioremap(res.start, 1 + res.end - res.start);
+	ssi_private->ssi_phys = res.start;
+	ssi_private->irq = irq_of_parse_and_map(np, 0);
 
-	sprintf(ssi_private->name, "ssi%u", (u8) ssi_info->id);
-	ssi_private->ssi = ssi_info->ssi;
-	ssi_private->ssi_phys = ssi_info->ssi_phys;
-	ssi_private->irq = ssi_info->irq;
-	ssi_private->dev = ssi_info->dev;
-	ssi_private->asynchronous = ssi_info->asynchronous;
+	/* Are the RX and the TX clocks locked? */
+	if (of_find_property(np, "fsl,ssi-asynchronous", NULL))
+		ssi_private->asynchronous = 1;
+	else
+		ssi_private->cpu_dai_drv.symmetric_rates = 1;
 
 	/* Initialize the the device_attribute structure */
-	dev_attr->attr.name = "ssi-stats";
+	dev_attr = &ssi_private->dev_attr;
+	dev_attr->attr.name = "statistics";
 	dev_attr->attr.mode = S_IRUGO;
 	dev_attr->show = fsl_sysfs_ssi_show;
 
-	ret = device_create_file(ssi_private->dev, dev_attr);
+	ret = device_create_file(&of_dev->dev, dev_attr);
 	if (ret) {
-		dev_err(ssi_info->dev, "could not create sysfs %s file\n",
+		dev_err(&of_dev->dev, "could not create sysfs %s file\n",
 			ssi_private->dev_attr.attr.name);
 		kfree(ssi_private);
 		return ret;
 	}
 
-	dev_set_drvdata(ssi_private->dev, ssi_private);
-	fsl_ssi_dai.name = ssi_private->name;
-	fsl_ssi_dai.symmetric_rates = 1;
+	/* Register with ASoC */
+	dev_set_drvdata(&of_dev->dev, ssi_private);
 
-	ret = snd_soc_register_dai(ssi_private->dev, ssi_info->id, &fsl_ssi_dai);
+	ret = snd_soc_register_dai(&of_dev->dev, 0, &ssi_private->cpu_dai_drv);
 	if (ret != 0) {
-		dev_err(ssi_info->dev, "failed to register DAI: %d\n", ret);
+		dev_err(&of_dev->dev, "failed to register DAI: %d\n", ret);
 		kfree(ssi_private);
 		return ret;
 	}
 
-	return ret;
+	/* Trigger the machine driver's probe function.  The platform driver
+	 * name of the machine driver is taken from the /model node of the
+	 * device tree.  We also pass the address of the CPU DAI driver
+	 * structure.
+	 */
+	sprop = of_get_property(of_find_node_by_path("/"), "model", NULL);
+	snprintf(name, sizeof(name), "snd-soc-%s", sprop);
+	make_lowercase(name);
+
+	platform_data = &ssi_private->cpu_dai_drv;
+	pdev = platform_device_register_data(&of_dev->dev, name, -1,
+		&platform_data, sizeof(void *));
+
+	ssi_private->pdev = pdev;
+
+	return 0;
 }
 
 /**
  * fsl_ssi_destroy_dai: destroy the snd_soc_dai object
  *
- * This function undoes the operations of fsl_ssi_create_dai()
+ * This function undoes the operations of fsl_ssi_probe()
  */
-static int  fsl_ssi_remove(struct platform_device *pdev)
+static int fsl_ssi_remove(struct of_device *of_dev)
 {
-	struct fsl_ssi_private *ssi_private = dev_get_drvdata(&pdev->dev);
-	struct fsl_ssi_info *ssi_info = dev_get_platdata(&pdev->dev);
-
-	device_remove_file(ssi_private->dev, &ssi_private->dev_attr);
+	struct fsl_ssi_private *ssi_private = dev_get_drvdata(&of_dev->dev);
 
-	snd_soc_unregister_dai(&pdev->dev, ssi_info->id);
+	platform_device_unregister(ssi_private->pdev);
+	snd_soc_unregister_dai(&of_dev->dev, 0);
+	device_remove_file(&of_dev->dev, &ssi_private->dev_attr);
 
 	kfree(ssi_private);
+	dev_set_drvdata(&of_dev->dev, NULL);
+
 	return 0;
 }
 
-static struct platform_driver fsl_ssi_driver = {
+static const struct of_device_id fsl_ssi_ids[] = {
+	{ .compatible = "fsl,mpc8610-ssi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
+
+static struct of_platform_driver fsl_ssi_driver = {
+	.name = "fsl-ssi-dai",
+	.match_table = fsl_ssi_ids,
 	.probe = fsl_ssi_probe,
-	.remove = __devexit_p(fsl_ssi_remove),
-	.driver = {
-		.name = "fsl-ssi-dai",
-		.owner = THIS_MODULE,
-	},
+	.remove = fsl_ssi_remove,
 };
 
 static int __init fsl_ssi_init(void)
 {
 	printk(KERN_INFO "Freescale Synchronous Serial Interface (SSI) ASoC Driver\n");
 
-	return platform_driver_register(&fsl_ssi_driver);
+	return of_register_platform_driver(&fsl_ssi_driver);
 }
 
 static void __exit fsl_ssi_exit(void)
 {
-	platform_driver_unregister(&fsl_ssi_driver);
+	of_unregister_platform_driver(&fsl_ssi_driver);
 }
 
 module_init(fsl_ssi_init);
@@ -732,4 +765,4 @@ module_exit(fsl_ssi_exit);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
 MODULE_DESCRIPTION("Freescale Synchronous Serial Interface (SSI) ASoC Driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 965fd86..2173000 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -196,30 +196,5 @@ struct ccsr_ssi {
 #define CCSR_SSI_SOR_WAIT(x) (((x) & 3) << CCSR_SSI_SOR_WAIT_SHIFT)
 #define CCSR_SSI_SOR_SYNRST 		0x00000001
 
-/* Instantiation data for an SSI interface
- *
- * This structure contains all the information that the the SSI driver needs
- * to instantiate an SSI interface with ALSA.  The machine driver should
- * create this structure, fill it in, call fsl_ssi_create_dai(), and then
- * delete the structure.
- *
- * id: which SSI this is (0, 1, etc. )
- * ssi: pointer to the SSI's registers
- * ssi_phys: physical address of the SSI registers
- * irq: IRQ of this SSI
- * dev: struct device, used to create the sysfs statistics file
- * asynchronous: 0=synchronous mode, 1=asynchronous mode
-*/
-struct fsl_ssi_info {
-	unsigned int id;
-	struct ccsr_ssi __iomem *ssi;
-	dma_addr_t ssi_phys;
-	unsigned int irq;
-	struct device *dev;
-	int asynchronous;
-};
-
-extern struct snd_soc_dai_driver fsl_ssi_dai;
-
 #endif
 
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
dissimilarity index 62%
index ad8d763..3e422f7 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -1,616 +1,558 @@
-/**
- * Freescale MPC8610HPCD ALSA SoC Fabric driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2007-2008 Freescale Semiconductor, Inc.  This file is licensed
- * under the terms of the GNU General Public License version 2.  This
- * program is licensed "as is" without any warranty of any kind, whether
- * express or implied.
- */
-
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
-#include <sound/soc.h>
-#include <asm/immap_86xx.h>
-
-#include "../codecs/cs4270.h"
-#include "fsl_dma.h"
-#include "fsl_ssi.h"
-
-/**
- * mpc8610_hpcd_data: fabric-specific ASoC device data
- *
- * This structure contains data for a single sound platform device on an
- * MPC8610 HPCD.  Some of the data is taken from the device tree.
- */
-struct mpc8610_hpcd_data {
-	struct snd_soc_dai_link dai;
-	struct snd_soc_card machine;
-	unsigned int dai_format;
-	unsigned int codec_clk_direction;
-	unsigned int cpu_clk_direction;
-	unsigned int clk_frequency;
-	struct ccsr_guts __iomem *guts;
-	struct ccsr_ssi __iomem *ssi;
-	unsigned int ssi_id;    	/* 0 = SSI1, 1 = SSI2, etc */
-	unsigned int ssi_irq;
-	unsigned int dma_id;    	/* 0 = DMA1, 1 = DMA2, etc */
-	unsigned int dma_irq[2];
-	struct ccsr_dma_channel __iomem *dma[2];
-	unsigned int dma_channel_id[2]; /* 0 = ch 0, 1 = ch 1, etc*/
-};
-
-/**
- * mpc8610_hpcd_machine_probe: initalize the board
- *
- * This function is called when platform_device_add() is called.  It is used
- * to initialize the board-specific hardware.
- *
- * Here we program the DMACR and PMUXCR registers.
- */
-static int mpc8610_hpcd_machine_probe(struct platform_device *sound_device)
-{
-	struct mpc8610_hpcd_data *machine_data =
-		sound_device->dev.platform_data;
-
-	/* Program the signal routing between the SSI and the DMA */
-	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[0], CCSR_GUTS_DMACR_DEV_SSI);
-	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[1], CCSR_GUTS_DMACR_DEV_SSI);
-
-	guts_set_pmuxcr_dma(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[0], 0);
-	guts_set_pmuxcr_dma(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[1], 0);
-
-	switch (machine_data->ssi_id) {
-	case 0:
-		clrsetbits_be32(&machine_data->guts->pmuxcr,
-			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_SSI);
-		break;
-	case 1:
-		clrsetbits_be32(&machine_data->guts->pmuxcr,
-			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI2_SSI);
-		break;
-	}
-
-	return 0;
-}
-
-/**
- * mpc8610_hpcd_startup: program the board with various hardware parameters
- *
- * This function takes board-specific information, like clock frequencies
- * and serial data formats, and passes that information to the codec and
- * transport drivers.
- */
-static int mpc8610_hpcd_startup(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct mpc8610_hpcd_data *machine_data =
-		rtd->card->dev->platform_data;
-	int ret = 0;
-
-	/* Tell the CPU driver what the serial protocol is. */
-	ret = snd_soc_dai_set_fmt(cpu_dai, machine_data->dai_format);
-	if (ret < 0) {
-		dev_err(substream->pcm->card->dev,
-			"could not set CPU driver audio format\n");
-		return ret;
-	}
-
-	/* Tell the codec driver what the serial protocol is. */
-	ret = snd_soc_dai_set_fmt(codec_dai, machine_data->dai_format);
-	if (ret < 0) {
-		dev_err(substream->pcm->card->dev,
-			"could not set codec driver audio format\n");
-		return ret;
-	}
-
-	/*
-	 * Tell the CPU driver what the clock frequency is, and whether it's a
-	 * slave or master.
-	 */
-	ret = snd_soc_dai_set_sysclk(cpu_dai, 0,
-					machine_data->clk_frequency,
-					machine_data->cpu_clk_direction);
-	if (ret < 0) {
-		dev_err(substream->pcm->card->dev,
-			"could not set CPU driver clock parameters\n");
-		return ret;
-	}
-
-	/*
-	 * Tell the codec driver what the MCLK frequency is, and whether it's
-	 * a slave or master.
-	 */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
-					machine_data->clk_frequency,
-					machine_data->codec_clk_direction);
-	if (ret < 0) {
-		dev_err(substream->pcm->card->dev,
-			"could not set codec driver clock params\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-/**
- * mpc8610_hpcd_machine_remove: Remove the sound device
- *
- * This function is called to remove the sound device for one SSI.  We
- * de-program the DMACR and PMUXCR register.
- */
-int mpc8610_hpcd_machine_remove(struct platform_device *sound_device)
-{
-	struct mpc8610_hpcd_data *machine_data =
-		sound_device->dev.platform_data;
-
-	/* Restore the signal routing */
-
-	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[0], 0);
-	guts_set_dmacr(machine_data->guts, machine_data->dma_id,
-		machine_data->dma_channel_id[1], 0);
-
-	switch (machine_data->ssi_id) {
-	case 0:
-		clrsetbits_be32(&machine_data->guts->pmuxcr,
-			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_LA);
-		break;
-	case 1:
-		clrsetbits_be32(&machine_data->guts->pmuxcr,
-			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI2_LA);
-		break;
-	}
-
-	return 0;
-}
-
-/**
- * mpc8610_hpcd_ops: ASoC fabric driver operations
- */
-static struct snd_soc_ops mpc8610_hpcd_ops = {
-	.startup = mpc8610_hpcd_startup,
-};
-
-/**
- * mpc8610_hpcd_probe: OF probe function for the fabric driver
- *
- * This function gets called when an SSI node is found in the device tree.
- *
- * Although this is a fabric driver, the SSI node is the "master" node with
- * respect to audio hardware connections.  Therefore, we create a new ASoC
- * device for each new SSI node that has a codec attached.
- *
- * FIXME: Currently, we only support one DMA controller, so if there are
- * multiple SSI nodes with codecs, only the first will be supported.
- *
- * FIXME: Even if we did support multiple DMA controllers, we have no
- * mechanism for assigning DMA controllers and channels to the individual
- * SSI devices.  We also probably aren't compatible with the generic Elo DMA
- * device driver.
- */
-static int mpc8610_hpcd_probe(struct of_device *ofdev,
-	const struct of_device_id *match)
-{
-	struct device_node *np = ofdev->node;
-	struct device_node *codec_np = NULL;
-	struct device_node *guts_np = NULL;
-	struct device_node *dma_np = NULL;
-	struct device_node *dma_channel_np = NULL;
-	const phandle *codec_ph;
-	const char *sprop;
-	const u32 *iprop;
-	struct resource res;
-	struct platform_device *sound_device = NULL;
-	struct mpc8610_hpcd_data *machine_data;
-	struct fsl_ssi_info ssi_info;
-	struct fsl_dma_info dma_info;
-	int ret = -ENODEV;
-	unsigned int playback_dma_channel;
-	unsigned int capture_dma_channel;
-
-	machine_data = kzalloc(sizeof(struct mpc8610_hpcd_data), GFP_KERNEL);
-	if (!machine_data)
-		return -ENOMEM;
-
-	memset(&ssi_info, 0, sizeof(ssi_info));
-	memset(&dma_info, 0, sizeof(dma_info));
-
-	ssi_info.dev = &ofdev->dev;
-
-	/*
-	 * We are only interested in SSIs with a codec phandle in them, so let's
-	 * make sure this SSI has one.
-	 */
-	codec_ph = of_get_property(np, "codec-handle", NULL);
-	if (!codec_ph)
-		goto error;
-
-	codec_np = of_find_node_by_phandle(*codec_ph);
-	if (!codec_np)
-		goto error;
-
-	/* The MPC8610 HPCD only knows about the CS4270 codec, so reject
-	   anything else. */
-	if (!of_device_is_compatible(codec_np, "cirrus,cs4270"))
-		goto error;
-
-	/* Get the device ID */
-	iprop = of_get_property(np, "cell-index", NULL);
-	if (!iprop) {
-		dev_err(&ofdev->dev, "cell-index property not found\n");
-		ret = -EINVAL;
-		goto error;
-	}
-	machine_data->ssi_id = *iprop;
-	ssi_info.id = *iprop;
-
-	/* Get the serial format and clock direction. */
-	sprop = of_get_property(np, "fsl,mode", NULL);
-	if (!sprop) {
-		dev_err(&ofdev->dev, "fsl,mode property not found\n");
-		ret = -EINVAL;
-		goto error;
-	}
-
-	if (strcasecmp(sprop, "i2s-slave") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_I2S;
-		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
-		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
-
-		/*
-		 * In i2s-slave mode, the codec has its own clock source, so we
-		 * need to get the frequency from the device tree and pass it to
-		 * the codec driver.
-		 */
-		iprop = of_get_property(codec_np, "clock-frequency", NULL);
-		if (!iprop || !*iprop) {
-			dev_err(&ofdev->dev, "codec bus-frequency property "
-				"is missing or invalid\n");
-			ret = -EINVAL;
-			goto error;
-		}
-		machine_data->clk_frequency = *iprop;
-	} else if (strcasecmp(sprop, "i2s-master") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_I2S;
-		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
-		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
-	} else if (strcasecmp(sprop, "lj-slave") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
-		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
-		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
-	} else if (strcasecmp(sprop, "lj-master") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
-		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
-		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
-	} else if (strcasecmp(sprop, "rj-slave") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
-		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
-		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
-	} else if (strcasecmp(sprop, "rj-master") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
-		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
-		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
-	} else if (strcasecmp(sprop, "ac97-slave") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_AC97;
-		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
-		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
-	} else if (strcasecmp(sprop, "ac97-master") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_AC97;
-		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
-		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
-	} else {
-		dev_err(&ofdev->dev,
-			"unrecognized fsl,mode property \"%s\"\n", sprop);
-		ret = -EINVAL;
-		goto error;
-	}
-
-	if (!machine_data->clk_frequency) {
-		dev_err(&ofdev->dev, "unknown clock frequency\n");
-		ret = -EINVAL;
-		goto error;
-	}
-
-	/* Read the SSI information from the device tree */
-	ret = of_address_to_resource(np, 0, &res);
-	if (ret) {
-		dev_err(&ofdev->dev, "could not obtain SSI address\n");
-		goto error;
-	}
-	if (!res.start) {
-		dev_err(&ofdev->dev, "invalid SSI address\n");
-		goto error;
-	}
-	ssi_info.ssi_phys = res.start;
-
-	machine_data->ssi = ioremap(ssi_info.ssi_phys, sizeof(struct ccsr_ssi));
-	if (!machine_data->ssi) {
-		dev_err(&ofdev->dev, "could not map SSI address %x\n",
-			ssi_info.ssi_phys);
-		ret = -EINVAL;
-		goto error;
-	}
-	ssi_info.ssi = machine_data->ssi;
-
-
-	/* Get the IRQ of the SSI */
-	machine_data->ssi_irq = irq_of_parse_and_map(np, 0);
-	if (!machine_data->ssi_irq) {
-		dev_err(&ofdev->dev, "could not get SSI IRQ\n");
-		ret = -EINVAL;
-		goto error;
-	}
-	ssi_info.irq = machine_data->ssi_irq;
-
-	/* Do we want to use asynchronous mode? */
-	ssi_info.asynchronous =
-		of_find_property(np, "fsl,ssi-asynchronous", NULL) ? 1 : 0;
-	if (ssi_info.asynchronous)
-		dev_info(&ofdev->dev, "using asynchronous mode\n");
-
-	/* Map the global utilities registers. */
-	guts_np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
-	if (!guts_np) {
-		dev_err(&ofdev->dev, "could not obtain address of GUTS\n");
-		ret = -EINVAL;
-		goto error;
-	}
-	machine_data->guts = of_iomap(guts_np, 0);
-	of_node_put(guts_np);
-	if (!machine_data->guts) {
-		dev_err(&ofdev->dev, "could not map GUTS\n");
-		ret = -EINVAL;
-		goto error;
-	}
-
-	/* Find the DMA channels to use.  Both SSIs need to use the same DMA
-	 * controller, so let's use DMA#1.
-	 */
-	for_each_compatible_node(dma_np, NULL, "fsl,mpc8610-dma") {
-		iprop = of_get_property(dma_np, "cell-index", NULL);
-		if (iprop && (*iprop == 0)) {
-			of_node_put(dma_np);
-			break;
-		}
-	}
-	if (!dma_np) {
-		dev_err(&ofdev->dev, "could not find DMA node\n");
-		ret = -EINVAL;
-		goto error;
-	}
-	machine_data->dma_id = *iprop;
-
-	/* SSI1 needs to use DMA Channels 0 and 1, and SSI2 needs to use DMA
-	 * channels 2 and 3.  This is just how the MPC8610 is wired
-	 * internally.
-	 */
-	playback_dma_channel = (machine_data->ssi_id == 0) ? 0 : 2;
-	capture_dma_channel = (machine_data->ssi_id == 0) ? 1 : 3;
-
-	/*
-	 * Find the DMA channels to use.
-	 */
-	while ((dma_channel_np = of_get_next_child(dma_np, dma_channel_np))) {
-		iprop = of_get_property(dma_channel_np, "cell-index", NULL);
-		if (iprop && (*iprop == playback_dma_channel)) {
-			/* dma_channel[0] and dma_irq[0] are for playback */
-			dma_info.dma_channel[0] = of_iomap(dma_channel_np, 0);
-			dma_info.dma_irq[0] =
-				irq_of_parse_and_map(dma_channel_np, 0);
-			machine_data->dma_channel_id[0] = *iprop;
-			continue;
-		}
-		if (iprop && (*iprop == capture_dma_channel)) {
-			/* dma_channel[1] and dma_irq[1] are for capture */
-			dma_info.dma_channel[1] = of_iomap(dma_channel_np, 0);
-			dma_info.dma_irq[1] =
-				irq_of_parse_and_map(dma_channel_np, 0);
-			machine_data->dma_channel_id[1] = *iprop;
-			continue;
-		}
-	}
-	if (!dma_info.dma_channel[0] || !dma_info.dma_channel[1] ||
-	    !dma_info.dma_irq[0] || !dma_info.dma_irq[1]) {
-		dev_err(&ofdev->dev, "could not find DMA channels\n");
-		ret = -EINVAL;
-		goto error;
-	}
-
-	dma_info.ssi_stx_phys = ssi_info.ssi_phys +
-		offsetof(struct ccsr_ssi, stx0);
-	dma_info.ssi_srx_phys = ssi_info.ssi_phys +
-		offsetof(struct ccsr_ssi, srx0);
-
-	/* We have the DMA information, so tell the DMA driver what it is */
-	if (!fsl_dma_configure(&dma_info)) {
-		dev_err(&ofdev->dev, "could not instantiate DMA device\n");
-		ret = -EBUSY;
-		goto error;
-	}
-
-	/*
-	 * Initialize our DAI data structure.  We should probably get this
-	 * information from the device tree.
-	 */
-	machine_data->dai.name = "CS4270";
-	machine_data->dai.stream_name = "CS4270";
-
-	iprop = of_get_property(codec_np, "reg", NULL);
-	if (!iprop) {
-		dev_err(&ofdev->dev, "codec node is missing 'reg' property\n");
-		goto error;
-	}
-	machine_data->dai.codec_id = *iprop;
-
-	machine_data->dai.cpu_dai_drv = &fsl_ssi_dai;
-	machine_data->dai.codec_dai_drv = &cs4270_dai; /* The codec_dai we want */
-	machine_data->dai.codec_drv = &soc_codec_device_cs4270;
-	machine_data->dai.ops = &mpc8610_hpcd_ops;
-	machine_data->dai.platform_drv = &fsl_soc_platform;
-
-	machine_data->machine.probe = mpc8610_hpcd_machine_probe;
-	machine_data->machine.remove = mpc8610_hpcd_machine_remove;
-	machine_data->machine.name = "MPC8610 HPCD";
-	machine_data->machine.num_links = 1;
-	machine_data->machine.dai_link = &machine_data->dai;
-
-	/* Allocate a new audio platform device structure */
-	sound_device = platform_device_alloc("soc-audio", -1);
-	if (!sound_device) {
-		dev_err(&ofdev->dev, "platform device allocation failed\n");
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	/* Set the platform device and ASoC device to point to each other */
-	platform_set_drvdata(sound_device, &machine_data->machine);
-
-	/* Tell ASoC to probe us.  This will call mpc8610_hpcd_machine.probe(),
-	   if it exists. */
-	ret = platform_device_add(sound_device);
-
-	if (ret) {
-		dev_err(&ofdev->dev, "platform device add failed\n");
-		goto error;
-	}
-
-	dev_set_drvdata(&ofdev->dev, sound_device);
-
-	return 0;
-
-error:
-	of_node_put(codec_np);
-	of_node_put(guts_np);
-	of_node_put(dma_np);
-	of_node_put(dma_channel_np);
-
-	if (sound_device)
-		platform_device_unregister(sound_device);
-
-	if (ssi_info.ssi)
-		iounmap(ssi_info.ssi);
-
-	if (ssi_info.irq)
-		irq_dispose_mapping(ssi_info.irq);
-
-	if (dma_info.dma_channel[0])
-		iounmap(dma_info.dma_channel[0]);
-
-	if (dma_info.dma_channel[1])
-		iounmap(dma_info.dma_channel[1]);
-
-	if (dma_info.dma_irq[0])
-		irq_dispose_mapping(dma_info.dma_irq[0]);
-
-	if (dma_info.dma_irq[1])
-		irq_dispose_mapping(dma_info.dma_irq[1]);
-
-	if (machine_data->guts)
-		iounmap(machine_data->guts);
-
-	kfree(machine_data);
-
-	return ret;
-}
-
-/**
- * mpc8610_hpcd_remove: remove the OF device
- *
- * This function is called when the OF device is removed.
- */
-static int mpc8610_hpcd_remove(struct of_device *ofdev)
-{
-	struct platform_device *sound_device = dev_get_drvdata(&ofdev->dev);
-	struct mpc8610_hpcd_data *machine_data =
-		sound_device->dev.platform_data;
-
-	platform_device_unregister(sound_device);
-
-	if (machine_data->ssi)
-		iounmap(machine_data->ssi);
-
-	if (machine_data->dma[0])
-		iounmap(machine_data->dma[0]);
-
-	if (machine_data->dma[1])
-		iounmap(machine_data->dma[1]);
-
-	if (machine_data->dma_irq[0])
-		irq_dispose_mapping(machine_data->dma_irq[0]);
-
-	if (machine_data->dma_irq[1])
-		irq_dispose_mapping(machine_data->dma_irq[1]);
-
-	if (machine_data->guts)
-		iounmap(machine_data->guts);
-
-	kfree(machine_data);
-	sound_device->dev.platform_data = NULL;
-
-	dev_set_drvdata(&ofdev->dev, NULL);
-
-	return 0;
-}
-
-static struct of_device_id mpc8610_hpcd_match[] = {
-	{
-		.compatible = "fsl,mpc8610-ssi",
-	},
-	{}
-};
-MODULE_DEVICE_TABLE(of, mpc8610_hpcd_match);
-
-static struct of_platform_driver mpc8610_hpcd_of_driver = {
-	.owner  	= THIS_MODULE,
-	.name   	= "mpc8610_hpcd",
-	.match_table    = mpc8610_hpcd_match,
-	.probe  	= mpc8610_hpcd_probe,
-	.remove 	= mpc8610_hpcd_remove,
-};
-
-/**
- * mpc8610_hpcd_init: fabric driver initialization.
- *
- * This function is called when this module is loaded.
- */
-static int __init mpc8610_hpcd_init(void)
-{
-	int ret;
-
-	printk(KERN_INFO "Freescale MPC8610 HPCD ALSA SoC fabric driver\n");
-
-	ret = of_register_platform_driver(&mpc8610_hpcd_of_driver);
-
-	if (ret)
-		printk(KERN_ERR
-			"mpc8610-hpcd: failed to register platform driver\n");
-
-	return ret;
-}
-
-/**
- * mpc8610_hpcd_exit: fabric driver exit
- *
- * This function is called when this driver is unloaded.
- */
-static void __exit mpc8610_hpcd_exit(void)
-{
-	of_unregister_platform_driver(&mpc8610_hpcd_of_driver);
-}
-
-module_init(mpc8610_hpcd_init);
-module_exit(mpc8610_hpcd_exit);
-
-MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
-MODULE_DESCRIPTION("Freescale MPC8610 HPCD ALSA SoC fabric driver");
-MODULE_LICENSE("GPL");
+/**
+ * Freescale MPC8610HPCD ALSA SoC Machine driver
+ *
+ * Author: Timur Tabi <timur@freescale.com>
+ *
+ * Copyright 2007-2010 Freescale Semiconductor, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/of_device.h>
+#include <sound/soc.h>
+#include <asm/immap_86xx.h>
+
+#include "../codecs/cs4270.h"
+#include "fsl_dma.h"
+#include "fsl_ssi.h"
+
+/* There's only one global utilities register */
+static phys_addr_t guts_phys;
+
+/**
+ * mpc8610_hpcd_data: machine-specific ASoC device data
+ *
+ * This structure contains data for a single sound platform device on an
+ * MPC8610 HPCD.  Some of the data is taken from the device tree.
+ */
+struct mpc8610_hpcd_data {
+	struct snd_soc_dai_link dai[2];
+	struct snd_soc_card card;
+	unsigned int dai_format;
+	unsigned int codec_clk_direction;
+	unsigned int cpu_clk_direction;
+	unsigned int clk_frequency;
+	unsigned int ssi_id;		/* 0 = SSI1, 1 = SSI2, etc */
+	unsigned int dma_id[0];		/* 0 = DMA1, 1 = DMA2, etc */
+	unsigned int dma_channel_id[2]; /* 0 = ch 0, 1 = ch 1, etc*/
+	char dai_name[32];
+};
+
+/**
+ * mpc8610_hpcd_machine_probe: initialize the board
+ *
+ * This function is used to initialize the board-specific hardware.
+ *
+ * Here we program the DMACR and PMUXCR registers.
+ */
+static int mpc8610_hpcd_machine_probe(struct platform_device *sound_device)
+{
+	struct snd_soc_card *card = platform_get_drvdata(sound_device);
+	struct mpc8610_hpcd_data *machine_data =
+		container_of(card, struct mpc8610_hpcd_data, card);
+	struct ccsr_guts __iomem *guts;
+
+	guts = ioremap(guts_phys, sizeof(struct ccsr_guts));
+	if (!guts) {
+		dev_err(card->dev, "could not map global utilities\n");
+		return -ENOMEM;
+	}
+
+	/* Program the signal routing between the SSI and the DMA */
+	guts_set_dmacr(guts, machine_data->dma_id[0],
+		       machine_data->dma_channel_id[0],
+		       CCSR_GUTS_DMACR_DEV_SSI);
+	guts_set_dmacr(guts, machine_data->dma_id[1],
+		       machine_data->dma_channel_id[1],
+		       CCSR_GUTS_DMACR_DEV_SSI);
+
+	guts_set_pmuxcr_dma(guts, machine_data->dma_id[0],
+			    machine_data->dma_channel_id[0], 0);
+	guts_set_pmuxcr_dma(guts, machine_data->dma_id[1],
+			    machine_data->dma_channel_id[1], 0);
+
+	switch (machine_data->ssi_id) {
+	case 0:
+		clrsetbits_be32(&guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_SSI);
+		break;
+	case 1:
+		clrsetbits_be32(&guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI2_SSI);
+		break;
+	}
+
+	iounmap(guts);
+
+	return 0;
+}
+
+/**
+ * mpc8610_hpcd_startup: program the board with various hardware parameters
+ *
+ * This function takes board-specific information, like clock frequencies
+ * and serial data formats, and passes that information to the codec and
+ * transport drivers.
+ */
+static int mpc8610_hpcd_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct mpc8610_hpcd_data *machine_data =
+		container_of(rtd->card, struct mpc8610_hpcd_data, card);
+	struct device *dev = rtd->card->dev;
+	int ret = 0;
+
+	/* Tell the codec driver what the serial protocol is. */
+	ret = snd_soc_dai_set_fmt(rtd->codec_dai, machine_data->dai_format);
+	if (ret < 0) {
+		dev_err(dev, "could not set codec driver audio format\n");
+		return ret;
+	}
+
+	/*
+	 * Tell the codec driver what the MCLK frequency is, and whether it's
+	 * a slave or master.
+	 */
+	ret = snd_soc_dai_set_sysclk(rtd->codec_dai, 0,
+				     machine_data->clk_frequency,
+				     machine_data->codec_clk_direction);
+	if (ret < 0) {
+		dev_err(dev, "could not set codec driver clock params\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * mpc8610_hpcd_machine_remove: Remove the sound device
+ *
+ * This function is called to remove the sound device for one SSI.  We
+ * de-program the DMACR and PMUXCR register.
+ */
+static int mpc8610_hpcd_machine_remove(struct platform_device *sound_device)
+{
+	struct snd_soc_card *card = platform_get_drvdata(sound_device);
+	struct mpc8610_hpcd_data *machine_data =
+		container_of(card, struct mpc8610_hpcd_data, card);
+	struct ccsr_guts __iomem *guts;
+
+	guts = ioremap(guts_phys, sizeof(struct ccsr_guts));
+	if (!guts) {
+		dev_err(card->dev, "could not map global utilities\n");
+		return -ENOMEM;
+	}
+
+	/* Restore the signal routing */
+
+	guts_set_dmacr(guts, machine_data->dma_id[0],
+		       machine_data->dma_channel_id[0], 0);
+	guts_set_dmacr(guts, machine_data->dma_id[1],
+		       machine_data->dma_channel_id[1], 0);
+
+	switch (machine_data->ssi_id) {
+	case 0:
+		clrsetbits_be32(&guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_LA);
+		break;
+	case 1:
+		clrsetbits_be32(&guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI2_LA);
+		break;
+	}
+
+	iounmap(guts);
+
+	return 0;
+}
+
+/**
+ * mpc8610_hpcd_ops: ASoC machine driver operations
+ */
+static struct snd_soc_ops mpc8610_hpcd_ops = {
+	.startup = mpc8610_hpcd_startup,
+};
+
+/**
+ * get_node_by_phandle_name - get a node by its phandle name
+ *
+ * This function takes a node, the name of a property in that node, and a
+ * compatible string.  Assuming the property is a phandle to another node,
+ * it returns that node, (optionally) if that node is compatible.
+ *
+ * If the property is not a phandle, or the node it points to is not compatible
+ * with the specific string, then NULL is returned.
+ */
+static struct device_node *get_node_by_phandle_name(struct device_node *np,
+					       const char *name,
+					       const char *compatible)
+{
+	const phandle *ph;
+	int len;
+
+	ph = of_get_property(np, name, &len);
+	if (!ph || (len != sizeof(phandle)))
+		return NULL;
+
+	np = of_find_node_by_phandle(*ph);
+	if (!np)
+		return NULL;
+
+	if (compatible && !of_device_is_compatible(np, compatible)) {
+		of_node_put(np);
+		return NULL;
+	}
+
+	return np;
+}
+
+/**
+ * get_parent_cell_index -- return the cell-index of the parent of a node
+ *
+ * Return the value of the cell-index property of the parent of the given
+ * node.  This is used for DMA channel nodes that need to know the DMA ID
+ * of the controller they are on.
+ */
+static int get_parent_cell_index(struct device_node *np)
+{
+	struct device_node *parent = of_get_parent(np);
+	const u32 *iprop;
+
+	if (!parent)
+		return -1;
+
+	iprop = of_get_property(parent, "cell-index", NULL);
+	of_node_put(parent);
+
+	if (!iprop)
+		return -1;
+
+	return *iprop;
+}
+
+static int get_dma_channel(struct device_node *ssi_np,
+			   const char *compatible,
+			   dma_addr_t ssi_stx_phys,
+			   dma_addr_t ssi_srx_phys,
+			   struct snd_soc_dai_link *dai,
+			   unsigned int *dma_channel_id,
+			   unsigned int *dma_id)
+{
+	struct device_node *dma_channel_np;
+	const u32 *iprop;
+
+	dma_channel_np = get_node_by_phandle_name(ssi_np, compatible,
+						  "fsl,ssi-dma-channel");
+	if (!dma_channel_np)
+		return -EINVAL;
+
+	dai->platform_drv = fsl_soc_dma_to_dai(dma_channel_np->full_name,
+					       ssi_stx_phys, ssi_srx_phys);
+
+	iprop = of_get_property(dma_channel_np, "cell-index", NULL);
+	if (!iprop) {
+		of_node_put(dma_channel_np);
+		return -EINVAL;
+	}
+
+	*dma_channel_id = *iprop;
+	*dma_id = get_parent_cell_index(dma_channel_np);
+	of_node_put(dma_channel_np);
+
+	return 0;
+}
+/**
+ * mpc8610_hpcd_probe: platform probe function for the machine driver
+ *
+ * Although this is a machine driver, the SSI node is the "master" node with
+ * respect to audio hardware connections.  Therefore, we create a new ASoC
+ * device for each new SSI node that has a codec attached.
+ */
+static int mpc8610_hpcd_probe(struct platform_device *pdev)
+{
+	struct snd_soc_dai_driver **platform_data = pdev->dev.platform_data;
+	struct snd_soc_dai_driver *cpu_dai_drv = *platform_data;
+	struct device *dev = pdev->dev.parent;
+	struct of_device *of_dev = container_of(dev, struct of_device, dev);
+	struct device_node *np = of_dev->node;
+	struct device_node *codec_np = NULL;
+	struct device_node *dma_np = NULL;
+	struct device_node *dma_channel_np = NULL;
+	struct platform_device *sound_device = NULL;
+	struct mpc8610_hpcd_data *machine_data;
+	int id;
+	dma_addr_t ssi_stx_phys;
+	dma_addr_t ssi_srx_phys;
+	int ret = -ENODEV;
+	const char *sprop;
+	const u32 *iprop;
+	struct resource res;
+
+	/* We are only interested in SSIs with a codec phandle in them,
+	 * so let's make sure this SSI has one. The MPC8610 HPCD only
+	 * knows about the CS4270 codec, so reject anything else.
+	 */
+	codec_np = get_node_by_phandle_name(np, "codec-handle",
+					    "cirrus,cs4270");
+	if (!codec_np) {
+		dev_err(dev, "invalid codec node\n");
+		return -EINVAL;
+	}
+
+	machine_data = kzalloc(sizeof(struct mpc8610_hpcd_data), GFP_KERNEL);
+	if (!machine_data)
+		return -ENOMEM;
+
+	machine_data->dai[0].cpu_dai_id = 0;
+	machine_data->dai[0].codec_dai_id = 0;
+	machine_data->dai[0].platform_id = 0;
+
+	machine_data->dai[0].name = machine_data->dai_name;
+
+	machine_data->dai[0].cpu_dai_drv = cpu_dai_drv;
+	machine_data->dai[0].codec_dai_drv = &cs4270_dai;
+	machine_data->dai[0].codec_drv = &soc_codec_device_cs4270;
+	machine_data->dai[0].ops = &mpc8610_hpcd_ops;
+
+	/* Store the codec name, it will be used as the codec DAI name */
+	of_modalias_node(codec_np, machine_data->dai_name,
+			 sizeof(machine_data->dai_name));
+
+	memcpy(&machine_data->dai[1], &machine_data->dai[0],
+	       sizeof(struct snd_soc_dai_link));
+
+	/* Get the device ID */
+	iprop = of_get_property(np, "cell-index", NULL);
+	if (!iprop) {
+		dev_err(&pdev->dev, "cell-index property not found\n");
+		ret = -EINVAL;
+		goto error;
+	}
+	machine_data->ssi_id = *iprop;
+	id = *iprop;
+
+	/* Get the serial format and clock direction. */
+	sprop = of_get_property(np, "fsl,mode", NULL);
+	if (!sprop) {
+		dev_err(&pdev->dev, "fsl,mode property not found\n");
+		ret = -EINVAL;
+		goto error;
+	}
+
+	if (strcasecmp(sprop, "i2s-slave") == 0) {
+		machine_data->dai_format = SND_SOC_DAIFMT_I2S;
+		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
+		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
+
+		/* In i2s-slave mode, the codec has its own clock source, so we
+		 * need to get the frequency from the device tree and pass it to
+		 * the codec driver.
+		 */
+		iprop = of_get_property(codec_np, "clock-frequency", NULL);
+		if (!iprop || !*iprop) {
+			dev_err(&pdev->dev, "codec bus-frequency "
+				"property is missing or invalid\n");
+			ret = -EINVAL;
+			goto error;
+		}
+		machine_data->clk_frequency = *iprop;
+	} else if (strcasecmp(sprop, "i2s-master") == 0) {
+		machine_data->dai_format = SND_SOC_DAIFMT_I2S;
+		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
+		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
+	} else if (strcasecmp(sprop, "lj-slave") == 0) {
+		machine_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
+		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
+		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
+	} else if (strcasecmp(sprop, "lj-master") == 0) {
+		machine_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
+		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
+		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
+	} else if (strcasecmp(sprop, "rj-slave") == 0) {
+		machine_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
+		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
+		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
+	} else if (strcasecmp(sprop, "rj-master") == 0) {
+		machine_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
+		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
+		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
+	} else if (strcasecmp(sprop, "ac97-slave") == 0) {
+		machine_data->dai_format = SND_SOC_DAIFMT_AC97;
+		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
+		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
+	} else if (strcasecmp(sprop, "ac97-master") == 0) {
+		machine_data->dai_format = SND_SOC_DAIFMT_AC97;
+		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
+		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
+	} else {
+		dev_err(&pdev->dev,
+			"unrecognized fsl,mode property '%s'\n", sprop);
+		ret = -EINVAL;
+		goto error;
+	}
+
+	if (!machine_data->clk_frequency) {
+		dev_err(&pdev->dev, "unknown clock frequency\n");
+		ret = -EINVAL;
+		goto error;
+	}
+
+	/* Read the SSI information from the device tree */
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret || !res.start) {
+		dev_err(&pdev->dev, "could not obtain SSI address\n");
+		goto error;
+	}
+	ssi_stx_phys = res.start + offsetof(struct ccsr_ssi, stx0);
+	ssi_srx_phys = res.start + offsetof(struct ccsr_ssi, srx0);
+
+	/* Find the playback DMA channel to use. */
+	ret = get_dma_channel(np, "fsl,playback-dma", ssi_stx_phys,
+			      ssi_srx_phys, &machine_data->dai[0],
+			      &machine_data->dma_channel_id[0],
+			      &machine_data->dma_id[0]);
+	if (ret) {
+		dev_err(&pdev->dev, "missing/invalid playback DMA phandle\n");
+		goto error;
+	}
+
+	/* Find the capture DMA channel to use. */
+	ret = get_dma_channel(np, "fsl,capture-dma", ssi_stx_phys,
+			      ssi_srx_phys, &machine_data->dai[1],
+			      &machine_data->dma_channel_id[1],
+			      &machine_data->dma_id[1]);
+	if (ret) {
+		dev_err(&pdev->dev, "missing/invalid capture DMA phandle\n");
+		goto error;
+	}
+
+	/* Initialize our DAI data structure.  */
+	iprop = of_get_property(codec_np, "reg", NULL);
+	if (!iprop) {
+		dev_err(&pdev->dev, "codec node is missing 'reg' property\n");
+		goto error;
+	}
+	machine_data->dai[0].codec_id = *iprop;
+	machine_data->dai[1].codec_id = *iprop;
+
+	machine_data->dai[0].stream_name = "playback";
+	machine_data->dai[1].stream_name = "capture";
+
+	machine_data->card.probe = mpc8610_hpcd_machine_probe;
+	machine_data->card.remove = mpc8610_hpcd_machine_remove;
+	machine_data->card.name = "MPC8610 HPCD";
+	machine_data->card.num_links = 2;
+	machine_data->card.dai_link = machine_data->dai;
+
+	/* Allocate a new audio platform device structure */
+	sound_device = platform_device_alloc("soc-audio", -1);
+	if (!sound_device) {
+		dev_err(&pdev->dev, "platform device alloc failed\n");
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	/* Associate the card data with the sound device */
+	platform_set_drvdata(sound_device, &machine_data->card);
+
+	/* Register with ASoC */
+	ret = platform_device_add(sound_device);
+	if (ret) {
+		dev_err(&pdev->dev, "platform device add failed\n");
+		goto error;
+	}
+
+	of_node_put(codec_np);
+
+	return 0;
+
+error:
+	of_node_put(codec_np);
+	of_node_put(dma_np);
+	of_node_put(dma_channel_np);
+
+	if (sound_device)
+		platform_device_unregister(sound_device);
+
+	kfree(machine_data);
+
+	return ret;
+}
+
+/**
+ * mpc8610_hpcd_remove: remove the platform device
+ *
+ * This function is called when the platform device is removed.
+ */
+static int __devexit mpc8610_hpcd_remove(struct platform_device *pdev)
+{
+	struct platform_device *sound_device = dev_get_drvdata(&pdev->dev);
+	struct snd_soc_card *card = platform_get_drvdata(sound_device);
+	struct mpc8610_hpcd_data *machine_data =
+		container_of(card, struct mpc8610_hpcd_data, card);
+
+	platform_device_unregister(sound_device);
+
+	kfree(machine_data);
+	sound_device->dev.platform_data = NULL;
+
+	dev_set_drvdata(&pdev->dev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver mpc8610_hpcd_driver = {
+	.probe = mpc8610_hpcd_probe,
+	.remove = __devexit_p(mpc8610_hpcd_remove),
+	.driver = {
+		/* The name must match the 'model' property in the device tree,
+		 * in lowercase letters.
+		 */
+		.name = "snd-soc-mpc8610hpcd",
+		.owner = THIS_MODULE,
+	},
+};
+
+/**
+ * mpc8610_hpcd_init: machine driver initialization.
+ *
+ * This function is called when this module is loaded.
+ */
+static int __init mpc8610_hpcd_init(void)
+{
+	struct device_node *guts_np;
+	struct resource res;
+
+	pr_info("Freescale MPC8610 HPCD ALSA SoC machine driver\n");
+
+	/* Get the physical address of the global utilities registers */
+	guts_np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
+	if (of_address_to_resource(guts_np, 0, &res)) {
+		pr_err("mpc8610-hpcd: missing/invalid global utilities node\n");
+		return -EINVAL;
+	}
+	guts_phys = res.start;
+
+	return platform_driver_register(&mpc8610_hpcd_driver);
+}
+
+/**
+ * mpc8610_hpcd_exit: machine driver exit
+ *
+ * This function is called when this driver is unloaded.
+ */
+static void __exit mpc8610_hpcd_exit(void)
+{
+	platform_driver_unregister(&mpc8610_hpcd_driver);
+}
+
+module_init(mpc8610_hpcd_init);
+module_exit(mpc8610_hpcd_exit);
+
+MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
+MODULE_DESCRIPTION("Freescale MPC8610 HPCD ALSA SoC machine driver");
+MODULE_LICENSE("GPL v2");
-- 
1.6.5
