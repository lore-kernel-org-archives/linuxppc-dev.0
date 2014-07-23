Return-Path: <nicoleotsuka@gmail.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0203.outbound.protection.outlook.com [207.46.163.203])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EDD261A06C9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 21:21:28 +1000 (EST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: <broonie@kernel.org>
Subject: [PATCH 2/3] ASoC: fsl_sai: Don't reset FIFO until TE/RE bit is unset
Date: Wed, 23 Jul 2014 19:23:39 +0800
Message-ID: <739ffa508b41229dcfc5041df84b6ce331ae11ff.1406113865.git.nicoleotsuka@gmail.com>
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

TE/RE bit of T/RCSR will remain set untill the current frame is physically
finished. The FIFO reset operation should wait this bit's totally cleared
rather than ignoring its status which might cause TE/RE disabling failed.

This patch adds delay and timeout to wait for its completion before FIFO
reset.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index a437899..a79a9b0 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -327,7 +327,7 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
-	u32 xcsr;
+	u32 xcsr, count = 100;
 
 	/*
 	 * The transmitter bit clock and frame sync are to be
@@ -369,11 +369,20 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (!(xcsr & FSL_SAI_CSR_FRDE)) {
 			/* Disable both directions and reset their FIFOs */
 			regmap_update_bits(sai->regmap, FSL_SAI_TCSR,
-					   FSL_SAI_CSR_TERE | FSL_SAI_CSR_FR,
-					   FSL_SAI_CSR_FR);
+					   FSL_SAI_CSR_TERE, 0);
 			regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
-					   FSL_SAI_CSR_TERE | FSL_SAI_CSR_FR,
-					   FSL_SAI_CSR_FR);
+					   FSL_SAI_CSR_TERE, 0);
+
+			/* TERE will remain set till the end of current frame */
+			do {
+				udelay(10);
+				regmap_read(sai->regmap, FSL_SAI_xCSR(tx), &xcsr);
+			} while (--count && xcsr & FSL_SAI_CSR_TERE);
+
+			regmap_update_bits(sai->regmap, FSL_SAI_TCSR,
+					   FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
+			regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
+					   FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
 		}
 		break;
 	default:
-- 
1.8.4
