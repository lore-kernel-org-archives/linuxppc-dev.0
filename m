Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 4B88FDDFEC
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 23:38:12 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1816736ywh.39
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 06:38:11 -0700 (PDT)
Message-ID: <9e4733910807220638u5cf48424l92ba780ecd9e3d9d@mail.gmail.com>
Date: Tue, 22 Jul 2008 09:38:11 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com,
	timur@freescale.com
Subject: Re: [alsa-devel] [PATCH v3 0/3] ALSA SoC: MPC5200 audio driver
In-Reply-To: <20080722092646.GA7251@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40807212358p17c824ia1d6516a87a7aac1@mail.gmail.com>
	<20080722092646.GA7251@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/22/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jul 22, 2008 at 12:58:09AM -0600, Grant Likely wrote:
>
>  > Here is the latest series for adding MPC5200 I2S and TI AIC26 codec
>  > support to ALSA SoC.  I believe all the comments are addressed and I
>  > hope that this series is now ready to be merged.  I would really like
>  > to see these ones land in 2.6.27.
>
>
> That might be a bit of a push given how far into the merge window we
>  are and Takashi's holiday this week, though as they are new drivers
>  things could be a bit more relaxed.

These drivers are going to get hit with immediate patches.  The DMA is
not broken out so that AC97 support can be fixed for the Efika.

I haven't touched these up for the driver that was just posted.

From: Jon Smirl <jonsmirl@gmail.com>


---

 include/sound/soc-of.h          |    2 +
 sound/soc/fsl/mpc5200_psc_i2s.c |   93 ++++++++++++++++++++++++++++++++-------
 sound/soc/fsl/mpc5200_psc_i2s.h |   13 +++++
 sound/soc/soc-of.c              |   26 +++++++++--
 4 files changed, 112 insertions(+), 22 deletions(-)
 create mode 100644 sound/soc/fsl/mpc5200_psc_i2s.h

diff --git a/include/sound/soc-of.h b/include/sound/soc-of.h
index a963032..15f0b8d 100644
--- a/include/sound/soc-of.h
+++ b/include/sound/soc-of.h
@@ -17,5 +17,7 @@ int of_snd_soc_register_codec(struct
snd_soc_codec_device *codec_dev,
 int of_snd_soc_register_platform(struct snd_soc_platform *platform,
 				 struct device_node *node,
 				 struct snd_soc_cpu_dai *cpu_dai);
+				
+void of_snd_soc_register_machine(char *name, struct snd_soc_ops *ops);

 #endif /* _INCLUDE_SOC_OF_H_ */
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 81d0933..a34961a 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2008 Secret Lab Technologies Ltd.
  */

+#define DEBUG
+
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -23,8 +25,12 @@

 #include <sysdev/bestcomm/bestcomm.h>
 #include <sysdev/bestcomm/gen_bd.h>
+#include <asm/time.h>
+#include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>

+#include "mpc5200_psc_i2s.h"
+
 MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
 MODULE_DESCRIPTION("Freescale MPC5200 PSC in I2S mode ASoC Driver");
 MODULE_LICENSE("GPL");
@@ -90,8 +96,10 @@ struct psc_i2s {
 	struct mpc52xx_psc_fifo __iomem *fifo_regs;
 	unsigned int irq;
 	struct device *dev;
+	u32 sicr;
 	struct snd_soc_cpu_dai dai;
 	spinlock_t lock;
+	uint sysclk;

 	/* per-stream data */
 	struct psc_i2s_stream playback_stream;
@@ -210,9 +218,7 @@ static int psc_i2s_startup(struct
snd_pcm_substream *substream)
 	out_8(&regs->command, 4 << 4); /* reset error */

 	/* Default to CODEC8 mode */
-	out_be32(&regs->sicr,
-		 MPC52xx_PSC_SICR_DTS1 | MPC52xx_PSC_SICR_I2S |
-		 MPC52xx_PSC_SICR_CLKPOL | MPC52xx_PSC_SICR_SIM_CODEC_8);
+	out_be32(&regs->sicr, psc_i2s->sicr | MPC52xx_PSC_SICR_SIM_CODEC_8);

 	/* First write: RxRdy (FIFO Alarm) generates receive FIFO interrupt */
 	/* Second write to mode: register Normal mode for non loopback */
@@ -249,7 +255,7 @@ static int psc_i2s_hw_params(struct
snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct psc_i2s *psc_i2s = rtd->dai->cpu_dai->private_data;
-	u32 sicr;
+	u32 sicr, bits, framesync, bitclk, value;

 	dev_dbg(psc_i2s->dev, "%s(substream=%p) p_size=%i p_bytes=%i"
 		" periods=%i buffer_size=%i  buffer_bytes=%i\n",
@@ -257,26 +263,46 @@ static int psc_i2s_hw_params(struct
snd_pcm_substream *substream,
 		params_period_bytes(params), params_periods(params),
 		params_buffer_size(params), params_buffer_bytes(params));

-	sicr = MPC52xx_PSC_SICR_DTS1 |
-	       MPC52xx_PSC_SICR_I2S | MPC52xx_PSC_SICR_CLKPOL;
+	sicr = psc_i2s->sicr;
 	switch (params_format(params)) {
 	 case SNDRV_PCM_FORMAT_S8:
 		sicr |= MPC52xx_PSC_SICR_SIM_CODEC_8;
+		bits = 8;
 		break;
 	 case SNDRV_PCM_FORMAT_S16_BE:
 		sicr |= MPC52xx_PSC_SICR_SIM_CODEC_16;
+		bits = 16;
 		break;
 	 case SNDRV_PCM_FORMAT_S24_BE:
 		sicr |= MPC52xx_PSC_SICR_SIM_CODEC_24;
+		bits = 24;
 		break;
 	 case SNDRV_PCM_FORMAT_S32_BE:
 		sicr |= MPC52xx_PSC_SICR_SIM_CODEC_32;
+		bits = 32;
 		break;
 	 default:
 		dev_dbg(psc_i2s->dev, "invalid format\n");
 		return -EINVAL;
 	}
 	out_be32(&psc_i2s->psc_regs->sicr, sicr);
+	
+	if (psc_i2s->sysclk) {
+		framesync = bits * 2;
+		bitclk = (psc_i2s->sysclk) / (params_rate(params) * framesync);
+		
+		/* bitclk field is byte swapped due to mpc5200/b compatibility */
+		value = ((framesync - 1) << 24) |
+			(((bitclk - 1) & 0xFF) << 16) | ((bitclk - 1) & 0xFF00);
+		
+		dev_dbg(psc_i2s->dev, "%s(substream=%p) rate=%i sysclk=%i"
+			" framesync=%i bitclk=%i reg=%X\n",
+			__FUNCTION__, substream, params_rate(params), psc_i2s->sysclk,
+			framesync, bitclk, value);
+		
+		out_be32(&psc_i2s->psc_regs->ccr, value);
+		out_8(&psc_i2s->psc_regs->ctur, bits - 1);
+	}

 	//rc = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
 	//if (rc) {
@@ -463,9 +489,29 @@ static int psc_i2s_set_sysclk(struct
snd_soc_cpu_dai *cpu_dai,
 			      int clk_id, unsigned int freq, int dir)
 {
 	struct psc_i2s *psc_i2s = cpu_dai->private_data;
-	dev_dbg(psc_i2s->dev, "psc_i2s_set_sysclk(cpu_dai=%p, dir=%i)\n",
-				cpu_dai, dir);
-	return (dir == SND_SOC_CLOCK_IN) ? 0 : -EINVAL;
+	int clkdiv, err;
+	dev_dbg(psc_i2s->dev, "psc_i2s_set_sysclk(cpu_dai=%p, freq=%u, dir=%i)\n",
+				cpu_dai, freq, dir);
+	if (dir == SND_SOC_CLOCK_OUT) {
+		psc_i2s->sysclk = freq;
+		if (clk_id == MPC52xx_CLK_CELLSLAVE) {
+			psc_i2s->sicr |= MPC52xx_PSC_SICR_CELLSLAVE | MPC52xx_PSC_SICR_GENCLK;
+		} else { /* MPC52xx_CLK_INTERNAL */
+			psc_i2s->sicr &= ~MPC52xx_PSC_SICR_CELLSLAVE;
+			psc_i2s->sicr |= MPC52xx_PSC_SICR_GENCLK;
+
+			clkdiv = ppc_proc_freq / freq;
+			err = ppc_proc_freq % freq;
+			if (err > freq / 2)
+				clkdiv++;
+
+			dev_dbg(psc_i2s->dev, "psc_i2s_set_sysclk(clkdiv %d freq error=%ldHz)\n",
+					clkdiv, (ppc_proc_freq / clkdiv - freq));
+				
+			return mpc52xx_set_psc_clkdiv(psc_i2s->dai.id + 1, clkdiv);
+		}
+	}
+	return 0;
 }

 /**
@@ -660,14 +706,15 @@ static int psc_i2s_pcm_new(struct snd_card
*card, struct snd_soc_codec_dai *dai,
 		return -ENOMEM;
 	}

-	rc = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->dev, size,
-				 &pcm->streams[1].substream->dma_buffer);
-	if (rc) {
-		snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
-		dev_err(card->dev, "Can't allocate capture DMA buffer\n");
-		return -ENOMEM;
+	if (pcm->streams[1].substream != NULL) { /* only allocate if the is
a capture stream */
+		rc = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->dev, size,
+					 &pcm->streams[1].substream->dma_buffer);
+		if (rc) {
+			snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
+			dev_err(card->dev, "Can't allocate capture DMA buffer\n");
+			return -ENOMEM;
+		}
 	}
-
 	return 0;
 }

@@ -829,6 +876,18 @@ static int __devinit psc_i2s_of_probe(struct of_device *op,
 		return -ENODEV;
 	}

+	/* Disable all interrupts and reset the PSC */
+	out_be16(&psc_i2s->psc_regs->mpc52xx_psc_imr, 0);
+	out_8(&psc_i2s->psc_regs->command, 3 << 4); /* reset transmitter */
+	out_8(&psc_i2s->psc_regs->command, 2 << 4); /* reset receiver */
+	out_8(&psc_i2s->psc_regs->command, 1 << 4); /* reset mode */
+	out_8(&psc_i2s->psc_regs->command, 4 << 4); /* reset error */
+
+	/* Default to CODEC8 mode */
+	psc_i2s->sicr = MPC52xx_PSC_SICR_DTS1 | MPC52xx_PSC_SICR_I2S |
+		 MPC52xx_PSC_SICR_CLKPOL;
+	out_be32(&psc_i2s->psc_regs->sicr, psc_i2s->sicr |
MPC52xx_PSC_SICR_SIM_CODEC_8);
+	
 	/* Save what we've done so it can be found again later */
 	dev_set_drvdata(&op->dev, psc_i2s);

@@ -865,7 +924,7 @@ static int __devexit psc_i2s_of_remove(struct of_device *op)

 /* Match table for of_platform binding */
 static struct of_device_id psc_i2s_match[] __devinitdata = {
-	{ .compatible = "fsl,mpc5200-psc-i2s", },
+	{ .compatible = "fsl,mpc5200b-psc-i2s", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, psc_i2s_match);
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.h b/sound/soc/fsl/mpc5200_psc_i2s.h
new file mode 100644
index 0000000..0e0a84e
--- /dev/null
+++ b/sound/soc/fsl/mpc5200_psc_i2s.h
@@ -0,0 +1,13 @@
+/*
+ * Freescale MPC5200 PSC in I2S mode
+ * ALSA SoC Digital Audio Interface (DAI) driver
+ *
+ */
+
+#ifndef __SOUND_SOC_FSL_MPC52xx_PSC_I2S_H__
+#define __SOUND_SOC_FSL_MPC52xx_PSC_I2S_H__
+
+#define MPC52xx_CLK_INTERNAL 0
+#define MPC52xx_CLK_CELLSLAVE 1
+
+#endif /* __SOUND_SOC_FSL_MPC52xx_PSC_I2S_H__ */
diff --git a/sound/soc/soc-of.c b/sound/soc/soc-of.c
index 9694979..3d21ed0 100644
--- a/sound/soc/soc-of.c
+++ b/sound/soc/soc-of.c
@@ -38,8 +38,8 @@ struct of_snd_soc_device {
 	struct device_node *codec_node;
 };

-static struct snd_soc_ops of_snd_soc_ops = {
-};
+static struct snd_soc_ops *machine_ops = NULL;
+static char *machine_name = NULL;

 static struct of_snd_soc_device *
 of_snd_soc_get_device(struct device_node *codec_node)
@@ -61,7 +61,7 @@ of_snd_soc_get_device(struct device_node *codec_node)
 	of_soc->machine.dai_link = &of_soc->dai_link;
 	of_soc->machine.num_links = 1;
 	of_soc->device.machine = &of_soc->machine;
-	of_soc->dai_link.ops = &of_snd_soc_ops;
+	of_soc->dai_link.ops = machine_ops;
 	list_add(&of_soc->list, &of_snd_soc_device_list);

 	return of_soc;
@@ -74,7 +74,7 @@ static void of_snd_soc_register_device(struct
of_snd_soc_device *of_soc)

 	/* Only register the device if both the codec and platform have
 	 * been registered */
-	if ((!of_soc->device.codec_data) || (!of_soc->platform_node))
+	if ((!of_soc->device.codec_data) || (!of_soc->platform_node) || !machine_name)
 		return;

 	pr_info("platform<-->codec match achieved; registering machine\n");
@@ -159,7 +159,7 @@ int of_snd_soc_register_platform(struct
snd_soc_platform *platform,
 	of_soc->platform_node = node;
 	of_soc->dai_link.cpu_dai = cpu_dai;
 	of_soc->device.platform = platform;
-	of_soc->machine.name = of_soc->dai_link.cpu_dai->name;
+	of_soc->machine.name = machine_name;

 	/* Now try to register the SoC device */
 	of_snd_soc_register_device(of_soc);
@@ -169,3 +169,19 @@ int of_snd_soc_register_platform(struct
snd_soc_platform *platform,
 	return rc;
 }
 EXPORT_SYMBOL_GPL(of_snd_soc_register_platform);
+
+void of_snd_soc_register_machine(char *name, struct snd_soc_ops *ops)
+{
+	struct of_snd_soc_device *of_soc;
+	
+	machine_name = name;
+	machine_ops = ops;
+	
+	list_for_each_entry(of_soc, &of_snd_soc_device_list, list) {
+		of_soc->dai_link.ops = machine_ops;
+		of_soc->machine.name = machine_name;
+		of_snd_soc_register_device(of_soc);
+	}
+
+}
+EXPORT_SYMBOL_GPL(of_snd_soc_register_machine);


>
>  Takashi, I'll queue these (and other ASoC patches) for submission in
>  bulk once you return.
>  _______________________________________________
>  Alsa-devel mailing list
>  Alsa-devel@alsa-project.org
>  http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


-- 
Jon Smirl
jonsmirl@gmail.com
