Return-Path: <nicoleotsuka@gmail.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0237.outbound.protection.outlook.com [207.46.163.237])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D5631A0941
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 21:21:34 +1000 (EST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: <broonie@kernel.org>
Subject: [PATCH 3/3] ASoC: fsl_sai: Improve enable flow in fsl_sai_trigger()
Date: Wed, 23 Jul 2014 19:23:40 +0800
Message-ID: <b567391b537690c473414304078d9090ee94954f.1406113865.git.nicoleotsuka@gmail.com>
In-Reply-To: <cover.1406113865.git.nicoleotsuka@gmail.com>
References: <cover.1406113865.git.nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, b42378@freescale.com, b02247@freescale.com,
 linux-kernel@vger.kernel.org, timur@tabi.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicolin Chen <Guangyu.Chen@freescale.com>

The previous enable flow:
1, Enable TE&RE (SAI starts to consume tx FIFO and feed rx FIFO)
2, Mask IRQ of Tx/Rx to enable its interrupt.
3, Enable DMA request of Tx/Rx.

As this flow would enable DMA request later than TERE, the Tx FIFO
would be easily emptied into underrun while Rx FIFO would be easily
stuffed into overrun due to the delayed DMA transfering.

This issue happened merely occational before the patch 'ASoC: fsl_sai:
Reset FIFOs after disabling TE/RE' because there were useless data
remaining in the FIFO for the gap. However, it manifested after FIFO
reset's implemented.

After this patch, the new flow:
1, Enable DMA request of Tx/Rx.
2, Enable TE&RE (SAI starts to consume tx FIFO and feed rx FIFO)
3, Mask IRQ of Tx/Rx to enable its interrupt.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index a79a9b0..364410b 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -346,6 +346,9 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
+				   FSL_SAI_CSR_FRDE, FSL_SAI_CSR_FRDE);
+
 		regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
 				   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
 		regmap_update_bits(sai->regmap, FSL_SAI_TCSR,
@@ -353,8 +356,6 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
 				   FSL_SAI_CSR_xIE_MASK, FSL_SAI_FLAGS);
-		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
-				   FSL_SAI_CSR_FRDE, FSL_SAI_CSR_FRDE);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-- 
1.8.4
