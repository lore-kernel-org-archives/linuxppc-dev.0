Return-Path: <broonie@sirena.co.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxPKR3WtpzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 23:46:02 +1000 (AEST)
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl-asoc-card: Don't error out if ENOTSUPP" to the
 asoc tree
In-Reply-To: <1504848453-9524-1-git-send-email-nicoleotsuka@gmail.com>
Message-Id: <E1duIqX-00088H-QQ@debutante>
Date: Tue, 19 Sep 2017 14:45:53 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl-asoc-card: Don't error out if ENOTSUPP

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 758a3b0183a83a4827afc892c417cd6f8d12e189 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Thu, 7 Sep 2017 22:27:33 -0700
Subject: [PATCH] ASoC: fsl-asoc-card: Don't error out if ENOTSUPP

The snd_soc_component_set_sysclk() and snd_soc_dai_set_tdm_slot()
in the soc-core.c will return -ENOTSUPP if there is no function
implementation for them in the dai and component drivers.

So this patch tries to ignore this errno.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 2db4d0c80d33..3772abbdd7b7 100644
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
2.14.1
