Return-Path: <zidan.wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0143.outbound.protection.outlook.com [207.46.100.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE42A1A0D75
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 19:22:03 +1000 (AEST)
From: Zidan Wang <zidan.wang@freescale.com>
To: <timur@tabi.org>
CC: <nicoleotsuka@gmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <perex@perex.cz>, <tiwai@suse.de>, <alsa-devel@alsa-project.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Zidan Wang
 <zidan.wang@freescale.com>
Subject: [alsa-devel][PATCH 2/2] ASoC: fsl_ssi: sound is wrong after
 suspend/resume
Date: Mon, 6 Jul 2015 16:49:17 +0800
Message-ID: <59abec18b5cf1d8e05ba3ae4aad89719bbeca052.1436172253.git.zidan.wang@freescale.com>
In-Reply-To: <dc75cce800ec7465303b94e6a18abe616a35d739.1436172253.git.zidan.wang@freescale.com>
References: <dc75cce800ec7465303b94e6a18abe616a35d739.1436172253.git.zidan.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The register SFCSR is volatile, but some bits in it need to be
recovered after suspend/resume.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 52b894f..e414f18 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -262,6 +262,9 @@ struct fsl_ssi_private {
 	unsigned int baudclk_streams;
 	unsigned int bitclk_freq;
 
+	/*regcache for SFCSR*/
+	u32 regcache_sfcsr;
+
 	/* DMA params */
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
@@ -1553,6 +1556,9 @@ static int fsl_ssi_suspend(struct device *dev)
 	struct fsl_ssi_private *ssi_private = dev_get_drvdata(dev);
 	struct regmap *regs = ssi_private->regs;
 
+	regmap_read(regs, CCSR_SSI_SFCSR,
+			&ssi_private->regcache_sfcsr);
+
 	regcache_cache_only(regs, true);
 	regcache_mark_dirty(regs);
 
@@ -1565,6 +1571,12 @@ static int fsl_ssi_resume(struct device *dev)
 	struct regmap *regs = ssi_private->regs;
 
 	regcache_cache_only(regs, false);
+
+	regmap_update_bits(regs, CCSR_SSI_SFCSR,
+			CCSR_SSI_SFCSR_RFWM1_MASK | CCSR_SSI_SFCSR_TFWM1_MASK |
+			CCSR_SSI_SFCSR_RFWM0_MASK | CCSR_SSI_SFCSR_TFWM0_MASK,
+			ssi_private->regcache_sfcsr);
+
 	return regcache_sync(regs);
 }
 #endif /* CONFIG_PM_SLEEP */
-- 
1.9.1
