Return-Path: <guangyu.chen@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0EF232C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 21:44:35 +1100 (EST)
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: <broonie@kernel.org>, <timur@tabi.org>
Subject: [RFC][PATCH v1] ASoC: fsl_ssi: Add DAI master mode support for SSI on
 i.MX series
Date: Thu, 12 Dec 2013 18:44:45 +0800
Message-ID: <1386845085-21682-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 lgirdwood@gmail.com, perex@perex.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicolin Chen <b42378@freescale.com>

This patch adds three main functions for DAI master mode: set_dai_fmt(),
set_dai_sysclk() and set_dai_tdm_slot(), and one essential baud clock
accordingly. After appending this patch, the fsl_ssi driver on i.MX series
has the ability to derive LRCLK and BCLK from baud clock source so as to
support some audio Codecs which can only be used in slave mode.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 280 +++++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/fsl/fsl_ssi.h |   2 +
 2 files changed, 278 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index f9f4569..b2ebaf8 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -38,6 +38,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -139,7 +140,10 @@ struct fsl_ssi_private {
 	bool ssi_on_imx;
 	bool imx_ac97;
 	bool use_dma;
+	bool baudclk_locked;
 	u8 i2s_mode;
+	spinlock_t baudclk_lock;
+	struct clk *baudclk;
 	struct clk *clk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
@@ -434,13 +438,18 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private =
 		snd_soc_dai_get_drvdata(rtd->cpu_dai);
+	unsigned long flags;
 
 	/* First, we only do fsl_ssi_setup() when SSI is going to be active.
 	 * Second, fsl_ssi_setup was already called by ac97_init earlier if
 	 * the driver is in ac97 mode.
 	 */
-	if (!dai->active && !ssi_private->imx_ac97)
+	if (!dai->active && !ssi_private->imx_ac97) {
 		fsl_ssi_setup(ssi_private);
+		spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
+		ssi_private->baudclk_locked = false;
+		spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
+	}
 
 	return 0;
 }
@@ -502,6 +511,243 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 }
 
 /**
+ * fsl_ssi_set_dai_fmt - configure Digital Audio Interface Format.
+ */
+static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
+{
+	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
+	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	u32 strcr = 0, stcr, srcr, scr, mask;
+
+	scr = read_ssi(&ssi->scr) & ~(CCSR_SSI_SCR_SYN | CCSR_SSI_SCR_I2S_MODE_MASK);
+	scr |= CCSR_SSI_SCR_NET;
+
+	mask = CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFDIR | CCSR_SSI_STCR_TXDIR |
+		CCSR_SSI_STCR_TSCKP | CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TFSL |
+		CCSR_SSI_STCR_TEFS;
+	stcr = read_ssi(&ssi->stcr) & ~mask;
+	srcr = read_ssi(&ssi->srcr) & ~mask;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+		case SND_SOC_DAIFMT_CBS_CFS:
+			ssi_private->i2s_mode = CCSR_SSI_SCR_I2S_MODE_MASTER;
+			break;
+		case SND_SOC_DAIFMT_CBM_CFM:
+			ssi_private->i2s_mode = CCSR_SSI_SCR_I2S_MODE_SLAVE;
+			break;
+		default:
+			return -EINVAL;
+		}
+		scr |= ssi_private->i2s_mode;
+
+		/* Data on rising edge of bclk, frame low, 1clk before data */
+		strcr |= CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TSCKP |
+			CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TEFS;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		/* Data on rising edge of bclk, frame high */
+		strcr |= CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TSCKP;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		/* Data on rising edge of bclk, frame high, 1clk before data */
+		strcr |= CCSR_SSI_STCR_TFSL | CCSR_SSI_STCR_TSCKP |
+			CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TEFS;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		/* Data on rising edge of bclk, frame high */
+		strcr |= CCSR_SSI_STCR_TFSL | CCSR_SSI_STCR_TSCKP |
+			CCSR_SSI_STCR_TXBIT0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* DAI clock inversion */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		/* Nothing to do for both normal cases */
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Invert bit clock */
+		strcr ^= CCSR_SSI_STCR_TSCKP;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		/* Invert frame clock */
+		strcr ^= CCSR_SSI_STCR_TFSI;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		/* Invert both clocks */
+		strcr ^= CCSR_SSI_STCR_TSCKP;
+		strcr ^= CCSR_SSI_STCR_TFSI;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* DAI clock master masks */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		strcr |= CCSR_SSI_STCR_TFDIR | CCSR_SSI_STCR_TXDIR;
+		scr |= CCSR_SSI_SCR_SYS_CLK_EN;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		scr &= ~CCSR_SSI_SCR_SYS_CLK_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	stcr |= strcr;
+	srcr |= strcr;
+
+	if (ssi_private->cpu_dai_drv.symmetric_rates) {
+		/* Need to clear RXDIR when using SYNC mode */
+		srcr &= ~CCSR_SSI_SRCR_RXDIR;
+		scr |= CCSR_SSI_SCR_SYN;
+	}
+
+	write_ssi(stcr, &ssi->stcr);
+	write_ssi(srcr, &ssi->srcr);
+	write_ssi(scr, &ssi->scr);
+
+	return 0;
+}
+
+/**
+ * fsl_ssi_set_dai_sysclk - configure Digital Audio Interface bit clock
+ *
+ * Note: This function can be only called when using SSI as DAI master
+ *
+ * Quick instruction for parameters:
+ * freq: Output BCLK frequency = samplerate * 32 (fixed) * channels
+ * dir: SND_SOC_CLOCK_OUT -> TxBCLK, SND_SOC_CLOCK_IN -> RxBCLK.
+ */
+static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
+	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates, ret;
+	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
+	unsigned long flags, clkrate, baudrate, tmprate;
+	u64 sub, savesub = 100000;
+
+	/* Don't apply it to any non-baudclk circumstance */
+	if (IS_ERR(ssi_private->baudclk))
+		return -EINVAL;
+
+	/* It should be already enough to divide clock by setting pm alone */
+	psr = 0;
+	div2 = 0;
+
+	factor = (div2 + 1) * (7 * psr + 1) * 2;
+
+	for (i = 0; i < 255; i++) {
+		/* The bclk rate must be smaller than 1/5 sysclk rate */
+		if (factor * (i + 1) < 5)
+			continue;
+
+		tmprate = freq * factor * (i + 2);
+		clkrate = clk_round_rate(ssi_private->baudclk, tmprate);
+
+		do_div(clkrate, factor);
+		afreq = (u32)clkrate / (i + 1);
+
+		if (freq == afreq)
+			sub = 0;
+		else if (freq / afreq == 1)
+			sub = freq - afreq;
+		else if (afreq / freq == 1)
+			sub = afreq - freq;
+		else
+			continue;
+
+		/* Calculate the fraction */
+		sub *= 100000;
+		do_div(sub, freq);
+
+		if (sub < savesub) {
+			baudrate = tmprate;
+			savesub = sub;
+			pm = i;
+		}
+
+		/* We are lucky */
+		if (savesub == 0)
+			break;
+	}
+
+	/* No proper pm found if it is still remaining the initial value */
+	if (pm == 999) {
+		dev_err(cpu_dai->dev, "failed to handle the required sysclk\n");
+		return -EINVAL;
+	}
+
+	stccr = CCSR_SSI_SxCCR_PM(pm + 1) | (div2 ? CCSR_SSI_SxCCR_DIV2 : 0) |
+		(psr ? CCSR_SSI_SxCCR_PSR : 0);
+	mask = CCSR_SSI_SxCCR_PM_MASK | CCSR_SSI_SxCCR_DIV2 | CCSR_SSI_SxCCR_PSR;
+
+	if (dir == SND_SOC_CLOCK_OUT || synchronous)
+		write_ssi_mask(&ssi->stccr, mask, stccr);
+	else
+		write_ssi_mask(&ssi->srccr, mask, stccr);
+
+	spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
+	if (!ssi_private->baudclk_locked) {
+		ret = clk_set_rate(ssi_private->baudclk, baudrate);
+		if (ret) {
+			spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
+			dev_err(cpu_dai->dev, "failed to set baudclk rate\n");
+			return -EINVAL;
+		}
+		ssi_private->baudclk_locked = true;
+	}
+	spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
+
+	return 0;
+}
+
+/**
+ * fsl_ssi_set_dai_tdm_slot - set TDM slot number
+ *
+ * Note: This function can be only called when using SSI as DAI master
+ */
+static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
+				u32 rx_mask, int slots, int slot_width)
+{
+	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
+	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	u32 val;
+
+	/* The slot number should be >= 2 if using Network mode or I2S mode */
+	val = read_ssi(&ssi->scr) & (CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_NET);
+	if (val && slots < 2) {
+		dev_err(cpu_dai->dev, "slot number should be >= 2 in I2S or NET\n");
+		return -EINVAL;
+	}
+
+	write_ssi_mask(&ssi->stccr, CCSR_SSI_SxCCR_DC_MASK,
+			CCSR_SSI_SxCCR_DC(slots));
+	write_ssi_mask(&ssi->srccr, CCSR_SSI_SxCCR_DC_MASK,
+			CCSR_SSI_SxCCR_DC(slots));
+
+	/* The register SxMSKs needs SSI to provide essential clock due to
+	 * hardware design. So we here temporarily enable SSI to set them.
+	 */
+	val = read_ssi(&ssi->scr) & CCSR_SSI_SCR_SSIEN;
+	write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_SSIEN);
+
+	write_ssi(tx_mask, &ssi->stmsk);
+	write_ssi(rx_mask, &ssi->srmsk);
+
+	write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, val);
+
+	return 0;
+}
+
+/**
  * fsl_ssi_trigger: start and stop the DMA transfer.
  *
  * This function is called by ALSA to start, stop, pause, and resume the DMA
@@ -517,6 +763,7 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 	unsigned int sier_bits;
+	unsigned long flags;
 
 	/*
 	 *  Enable only the interrupts and DMA requests
@@ -557,8 +804,12 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_RE, 0);
 
 		if (!ssi_private->imx_ac97 && (read_ssi(&ssi->scr) &
-					(CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0)
+					(CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0) {
 			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
+			spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
+			ssi_private->baudclk_locked = false;
+			spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
+		}
 		break;
 
 	default:
@@ -585,6 +836,9 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 	.startup	= fsl_ssi_startup,
 	.hw_params	= fsl_ssi_hw_params,
+	.set_fmt	= fsl_ssi_set_dai_fmt,
+	.set_sysclk	= fsl_ssi_set_dai_sysclk,
+	.set_tdm_slot	= fsl_ssi_set_dai_tdm_slot,
 	.trigger	= fsl_ssi_trigger,
 };
 
@@ -897,6 +1151,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
                 /* Older 8610 DTs didn't have the fifo-depth property */
 		ssi_private->fifo_depth = 8;
 
+	ssi_private->baudclk_locked = false;
+	spin_lock_init(&ssi_private->baudclk_lock);
+
 	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx21-ssi")) {
 		u32 dma_events[2];
 		ssi_private->ssi_on_imx = true;
@@ -914,6 +1171,15 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			goto error_irqmap;
 		}
 
+		/* For those SLAVE implementations, we ingore non-baudclk cases
+		 * and, instead, abandon MASTER mode that needs baud clock.
+		 */
+		ssi_private->baudclk = devm_clk_get(&pdev->dev, "baud");
+		if (IS_ERR(ssi_private->baudclk))
+			dev_warn(&pdev->dev, "could not get baud clock: %d\n", ret);
+		else
+			clk_prepare_enable(ssi_private->baudclk);
+
 		/*
 		 * We have burstsize be "fifo_depth - 2" to match the SSI
 		 * watermark setting in fsl_ssi_startup().
@@ -1059,8 +1325,11 @@ error_dev:
 	device_remove_file(&pdev->dev, dev_attr);
 
 error_clk:
-	if (ssi_private->ssi_on_imx)
+	if (ssi_private->ssi_on_imx) {
+		if (!IS_ERR(ssi_private->baudclk))
+			clk_disable_unprepare(ssi_private->baudclk);
 		clk_disable_unprepare(ssi_private->clk);
+	}
 
 error_irqmap:
 	irq_dispose_mapping(ssi_private->irq);
@@ -1076,8 +1345,11 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 		platform_device_unregister(ssi_private->pdev);
 	snd_soc_unregister_component(&pdev->dev);
 	device_remove_file(&pdev->dev, &ssi_private->dev_attr);
-	if (ssi_private->ssi_on_imx)
+	if (ssi_private->ssi_on_imx) {
+		if (!IS_ERR(ssi_private->baudclk))
+			clk_disable_unprepare(ssi_private->baudclk);
 		clk_disable_unprepare(ssi_private->clk);
+	}
 	irq_dispose_mapping(ssi_private->irq);
 
 	return 0;
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index e6b9a69..e6b6324 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -125,7 +125,9 @@ struct ccsr_ssi {
 #define CCSR_SSI_SRCR_REFS		0x00000001
 
 /* STCCR and SRCCR */
+#define CCSR_SSI_SxCCR_DIV2_SHIFT	18
 #define CCSR_SSI_SxCCR_DIV2		0x00040000
+#define CCSR_SSI_SxCCR_PSR_SHIFT	17
 #define CCSR_SSI_SxCCR_PSR		0x00020000
 #define CCSR_SSI_SxCCR_WL_SHIFT		13
 #define CCSR_SSI_SxCCR_WL_MASK		0x0001E000
-- 
1.8.4
