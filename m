Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC79E1A1B5C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2015 08:00:11 +1100 (AEDT)
Message-ID: <56770FE1.4060202@maciej.szmigiero.name>
Date: Sun, 20 Dec 2015 21:30:25 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
MIME-Version: 1.0
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/3] ASoC: fsl_ssi: mark SACNT register volatile
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SACNT register should be marked volatile since
its WR and RD bits are cleared by SSI after
completing the relevant operation.
This unbreaks AC'97 register access.

Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e3abad5f980a..cc22354d7758 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -146,6 +146,7 @@ static bool fsl_ssi_volatile_reg(struct device *dev, unsigned int reg)
 	case CCSR_SSI_SRX1:
 	case CCSR_SSI_SISR:
 	case CCSR_SSI_SFCSR:
+	case CCSR_SSI_SACNT:
 	case CCSR_SSI_SACADD:
 	case CCSR_SSI_SACDAT:
 	case CCSR_SSI_SATAG:
@@ -239,8 +240,9 @@ struct fsl_ssi_private {
 	unsigned int baudclk_streams;
 	unsigned int bitclk_freq;
 
-	/*regcache for SFCSR*/
+	/* regcache for volatile regs */
 	u32 regcache_sfcsr;
+	u32 regcache_sacnt;
 
 	/* DMA params */
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
@@ -1587,6 +1589,8 @@ static int fsl_ssi_suspend(struct device *dev)
 
 	regmap_read(regs, CCSR_SSI_SFCSR,
 			&ssi_private->regcache_sfcsr);
+	regmap_read(regs, CCSR_SSI_SACNT,
+			&ssi_private->regcache_sacnt);
 
 	regcache_cache_only(regs, true);
 	regcache_mark_dirty(regs);
@@ -1605,6 +1609,8 @@ static int fsl_ssi_resume(struct device *dev)
 			CCSR_SSI_SFCSR_RFWM1_MASK | CCSR_SSI_SFCSR_TFWM1_MASK |
 			CCSR_SSI_SFCSR_RFWM0_MASK | CCSR_SSI_SFCSR_TFWM0_MASK,
 			ssi_private->regcache_sfcsr);
+	regmap_write(regs, CCSR_SSI_SACNT,
+			ssi_private->regcache_sacnt);
 
 	return regcache_sync(regs);
 }
