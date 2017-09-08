Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpQpQ04bbzDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 15:28:29 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id v82so886132pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 22:28:29 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
 lgirdwood@gmail.com, fabio.estevam@nxp.com
Subject: [PATCH] ASoC: fsl-asoc-card: Don't error out if ENOTSUPP
Date: Thu,  7 Sep 2017 22:27:33 -0700
Message-Id: <1504848453-9524-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The snd_soc_component_set_sysclk() and snd_soc_dai_set_tdm_slot()
in the soc-core.c will return -ENOTSUPP if there is no function
implementation for them in the dai and component drivers.

So this patch tries to ignore this errno.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 2db4d0c..3772abb 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -166,7 +166,7 @@ static int fsl_asoc_card_hw_params(struct snd_pcm_substream *substream,
 	ret = snd_soc_dai_set_sysclk(rtd->cpu_dai, cpu_priv->sysclk_id[tx],
 				     cpu_priv->sysclk_freq[tx],
 				     cpu_priv->sysclk_dir[tx]);
-	if (ret) {
+	if (ret && ret != -ENOTSUPP) {
 		dev_err(dev, "failed to set sysclk for cpu dai\n");
 		return ret;
 	}
@@ -174,7 +174,7 @@ static int fsl_asoc_card_hw_params(struct snd_pcm_substream *substream,
 	if (cpu_priv->slot_width) {
 		ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2,
 					       cpu_priv->slot_width);
-		if (ret) {
+		if (ret && ret != -ENOTSUPP) {
 			dev_err(dev, "failed to set TDM slot for cpu dai\n");
 			return ret;
 		}
@@ -270,7 +270,7 @@ static int fsl_asoc_card_set_bias_level(struct snd_soc_card *card,
 
 		ret = snd_soc_dai_set_sysclk(codec_dai, codec_priv->fll_id,
 					     pll_out, SND_SOC_CLOCK_IN);
-		if (ret) {
+		if (ret && ret != -ENOTSUPP) {
 			dev_err(dev, "failed to set SYSCLK: %d\n", ret);
 			return ret;
 		}
@@ -283,7 +283,7 @@ static int fsl_asoc_card_set_bias_level(struct snd_soc_card *card,
 		ret = snd_soc_dai_set_sysclk(codec_dai, codec_priv->mclk_id,
 					     codec_priv->mclk_freq,
 					     SND_SOC_CLOCK_IN);
-		if (ret) {
+		if (ret && ret != -ENOTSUPP) {
 			dev_err(dev, "failed to switch away from FLL: %d\n", ret);
 			return ret;
 		}
@@ -459,7 +459,7 @@ static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, codec_priv->mclk_id,
 				     codec_priv->mclk_freq, SND_SOC_CLOCK_IN);
-	if (ret) {
+	if (ret && ret != -ENOTSUPP) {
 		dev_err(dev, "failed to set sysclk in %s\n", __func__);
 		return ret;
 	}
-- 
2.7.4
