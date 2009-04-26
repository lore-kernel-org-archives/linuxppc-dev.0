Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 24791DDEE3
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 05:53:09 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so978423ywt.39
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Apr 2009 12:53:09 -0700 (PDT)
Subject: [PATCH V1 3/3] Rename exports in mpc5200_dma.c
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org
From: Jon Smirl <jonsmirl@gmail.com>
Date: Sun, 26 Apr 2009 15:53:07 -0400
Message-ID: <20090426195307.4648.53704.stgit@terra>
In-Reply-To: <20090426195215.4648.62017.stgit@terra>
References: <20090426195215.4648.62017.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rename the public DMA exports into the global name space so that the DMA code can be built as a module.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 sound/soc/fsl/mpc5200_dma.c     |   18 ++++++++++++------
 sound/soc/fsl/mpc5200_dma.h     |   10 +++++-----
 sound/soc/fsl/mpc5200_psc_i2s.c |   14 +++++++-------
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index c82ef75..df73755 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -113,7 +113,7 @@ static irqreturn_t psc_dma_bcom_irq(int irq, void *_psc_dma_stream)
  * If this is the first stream open, then grab the IRQ and program most of
  * the PSC registers.
  */
-int psc_dma_startup(struct snd_pcm_substream *substream,
+int mpc5200_dma_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -145,13 +145,16 @@ int psc_dma_startup(struct snd_pcm_substream *substream,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mpc5200_dma_startup);
 
-int psc_dma_hw_free(struct snd_pcm_substream *substream,
+int mpc5200_dma_hw_free(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	snd_pcm_set_runtime_buffer(substream, NULL);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mpc5200_dma_hw_free);
+
 
 /**
  * psc_dma_trigger: start and stop the DMA transfer.
@@ -159,7 +162,7 @@ int psc_dma_hw_free(struct snd_pcm_substream *substream,
  * This function is called by ALSA to start, stop, pause, and resume the DMA
  * transfer of data.
  */
-int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd,
+int mpc5200_dma_trigger(struct snd_pcm_substream *substream, int cmd,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -269,13 +272,15 @@ int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mpc5200_dma_trigger);
+
 
 /**
  * psc_dma_shutdown: shutdown the data transfer on a stream
  *
  * Shutdown the PSC if there are no other substreams open.
  */
-void psc_dma_shutdown(struct snd_pcm_substream *substream,
+void mpc5200_dma_shutdown(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -303,6 +308,7 @@ void psc_dma_shutdown(struct snd_pcm_substream *substream,
 		free_irq(psc_dma->playback.irq, &psc_dma->playback);
 	}
 }
+EXPORT_SYMBOL_GPL(mpc5200_dma_shutdown);
 
 /* ---------------------------------------------------------------------
  * The PSC DMA 'ASoC platform' driver
@@ -448,10 +454,10 @@ static void psc_dma_pcm_free(struct snd_pcm *pcm)
 	}
 }
 
-struct snd_soc_platform psc_dma_pcm_soc_platform = {
+struct snd_soc_platform mpc5200_dma_platform = {
 	.name		= "mpc5200-psc-audio",
 	.pcm_ops	= &psc_dma_pcm_ops,
 	.pcm_new	= &psc_dma_pcm_new,
 	.pcm_free	= &psc_dma_pcm_free,
 };
-
+EXPORT_SYMBOL_GPL(mpc5200_dma_platform);
diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
index a33232c..e52b90e 100644
--- a/sound/soc/fsl/mpc5200_dma.h
+++ b/sound/soc/fsl/mpc5200_dma.h
@@ -64,18 +64,18 @@ struct psc_dma {
 };
 
 
-int psc_dma_startup(struct snd_pcm_substream *substream,
+int mpc5200_dma_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai);
 
-int psc_dma_hw_free(struct snd_pcm_substream *substream,
+int mpc5200_dma_hw_free(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai);
 
-void psc_dma_shutdown(struct snd_pcm_substream *substream,
+void mpc5200_dma_shutdown(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai);
 
-int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd,
+int mpc5200_dma_trigger(struct snd_pcm_substream *substream, int cmd,
 			   struct snd_soc_dai *dai);
 
-extern struct snd_soc_platform psc_dma_pcm_soc_platform;
+extern struct snd_soc_platform mpc5200_dma_platform;
 
 #endif /* __SOUND_SOC_FSL_MPC5200_DMA_H__ */
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 12a7917..a4a439c 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -140,11 +140,11 @@ static int psc_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int format)
  * psc_i2s_dai_template: template CPU Digital Audio Interface
  */
 static struct snd_soc_dai_ops psc_i2s_dai_ops = {
-	.startup	= psc_dma_startup,
+	.startup	= mpc5200_dma_startup,
 	.hw_params	= psc_i2s_hw_params,
-	.hw_free	= psc_dma_hw_free,
-	.shutdown	= psc_dma_shutdown,
-	.trigger	= psc_dma_trigger,
+	.hw_free	= mpc5200_dma_hw_free,
+	.shutdown	= mpc5200_dma_shutdown,
+	.trigger	= mpc5200_dma_trigger,
 	.set_sysclk	= psc_i2s_set_sysclk,
 	.set_fmt	= psc_i2s_set_fmt,
 };
@@ -350,10 +350,10 @@ static int __devinit psc_i2s_of_probe(struct of_device *op,
 	if (rc)
 		dev_info(psc_dma->dev, "error creating sysfs files\n");
 
-	snd_soc_register_platform(&psc_dma_pcm_soc_platform);
+	snd_soc_register_platform(&mpc5200_dma_platform);
 
 	/* Tell the ASoC OF helpers about it */
-	of_snd_soc_register_platform(&psc_dma_pcm_soc_platform, op->node,
+	of_snd_soc_register_platform(&mpc5200_dma_platform, op->node,
 				     &psc_dma->dai);
 
 	return 0;
@@ -365,7 +365,7 @@ static int __devexit psc_i2s_of_remove(struct of_device *op)
 
 	dev_dbg(&op->dev, "psc_i2s_remove()\n");
 
-	snd_soc_unregister_platform(&psc_dma_pcm_soc_platform);
+	snd_soc_unregister_platform(&mpc5200_dma_platform);
 
 	bcom_gen_bd_rx_release(psc_dma->capture.bcom_task);
 	bcom_gen_bd_tx_release(psc_dma->playback.bcom_task);
