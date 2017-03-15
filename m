Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vk0B55pRRzDqY1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 05:14:37 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, julia.lawall@lip6.fr, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com, timur@tabi.org,
 nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
In-Reply-To: <1489432342-4328-1-git-send-email-bhumirks@gmail.com>
Message-Id: <E1coDQl-0002Qk-W9@debutante>
Date: Wed, 15 Mar 2017 18:13:51 +0000
Subject: Applied "ASoC: fsl: constify snd_soc_ops structures" to the asoc tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl: constify snd_soc_ops structures

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

>From 5ace37bd7947e28dec5559a57ddc6e1d997dbec5 Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Tue, 14 Mar 2017 00:42:22 +0530
Subject: [PATCH] ASoC: fsl: constify snd_soc_ops structures

Declare snd_soc_ops structures as const as they are only stored
in the ops field of a snd_soc_dai_link structure. This field is
of type const, so snd_soc_ops structures having this property
can be made const too.

The following .o files did not compile:
sound/soc/fsl/{p1022_rdk.c/p1022_ds.c/mpc8610_hpcd.c}

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/eukrea-tlv320.c   | 2 +-
 sound/soc/fsl/imx-mc13783.c     | 2 +-
 sound/soc/fsl/mpc8610_hpcd.c    | 2 +-
 sound/soc/fsl/mx27vis-aic32x4.c | 2 +-
 sound/soc/fsl/p1022_ds.c        | 2 +-
 sound/soc/fsl/p1022_rdk.c       | 2 +-
 sound/soc/fsl/phycore-ac97.c    | 2 +-
 sound/soc/fsl/wm1133-ev1.c      | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 883087f2b092..84ef6385736c 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -64,7 +64,7 @@ static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops eukrea_tlv320_snd_ops = {
+static const struct snd_soc_ops eukrea_tlv320_snd_ops = {
 	.hw_params	= eukrea_tlv320_hw_params,
 };
 
diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index bb0459018b45..9d19b808f634 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -48,7 +48,7 @@ static int imx_mc13783_hifi_hw_params(struct snd_pcm_substream *substream,
 	return snd_soc_dai_set_tdm_slot(cpu_dai, 0x3, 0x3, 2, 16);
 }
 
-static struct snd_soc_ops imx_mc13783_hifi_ops = {
+static const struct snd_soc_ops imx_mc13783_hifi_ops = {
 	.hw_params = imx_mc13783_hifi_hw_params,
 };
 
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index ddf49f30b23f..a639b52c16f6 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -174,7 +174,7 @@ static int mpc8610_hpcd_machine_remove(struct snd_soc_card *card)
 /**
  * mpc8610_hpcd_ops: ASoC machine driver operations
  */
-static struct snd_soc_ops mpc8610_hpcd_ops = {
+static const struct snd_soc_ops mpc8610_hpcd_ops = {
 	.startup = mpc8610_hpcd_startup,
 };
 
diff --git a/sound/soc/fsl/mx27vis-aic32x4.c b/sound/soc/fsl/mx27vis-aic32x4.c
index 198eeb3f3f7a..d7ec3d20065c 100644
--- a/sound/soc/fsl/mx27vis-aic32x4.c
+++ b/sound/soc/fsl/mx27vis-aic32x4.c
@@ -73,7 +73,7 @@ static int mx27vis_aic32x4_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops mx27vis_aic32x4_snd_ops = {
+static const struct snd_soc_ops mx27vis_aic32x4_snd_ops = {
 	.hw_params	= mx27vis_aic32x4_hw_params,
 };
 
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index a1f780ecadf5..41c623c55c16 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -184,7 +184,7 @@ static int p1022_ds_machine_remove(struct snd_soc_card *card)
 /**
  * p1022_ds_ops: ASoC machine driver operations
  */
-static struct snd_soc_ops p1022_ds_ops = {
+static const struct snd_soc_ops p1022_ds_ops = {
 	.startup = p1022_ds_startup,
 };
 
diff --git a/sound/soc/fsl/p1022_rdk.c b/sound/soc/fsl/p1022_rdk.c
index d4d88a8cb9c0..4afbdd610bfa 100644
--- a/sound/soc/fsl/p1022_rdk.c
+++ b/sound/soc/fsl/p1022_rdk.c
@@ -188,7 +188,7 @@ static int p1022_rdk_machine_remove(struct snd_soc_card *card)
 /**
  * p1022_rdk_ops: ASoC machine driver operations
  */
-static struct snd_soc_ops p1022_rdk_ops = {
+static const struct snd_soc_ops p1022_rdk_ops = {
 	.startup = p1022_rdk_startup,
 };
 
diff --git a/sound/soc/fsl/phycore-ac97.c b/sound/soc/fsl/phycore-ac97.c
index ae403c29688f..66fb6c4614d2 100644
--- a/sound/soc/fsl/phycore-ac97.c
+++ b/sound/soc/fsl/phycore-ac97.c
@@ -23,7 +23,7 @@
 
 static struct snd_soc_card imx_phycore;
 
-static struct snd_soc_ops imx_phycore_hifi_ops = {
+static const struct snd_soc_ops imx_phycore_hifi_ops = {
 };
 
 static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
diff --git a/sound/soc/fsl/wm1133-ev1.c b/sound/soc/fsl/wm1133-ev1.c
index b454972dce35..cdaf16367b47 100644
--- a/sound/soc/fsl/wm1133-ev1.c
+++ b/sound/soc/fsl/wm1133-ev1.c
@@ -139,7 +139,7 @@ static int wm1133_ev1_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops wm1133_ev1_ops = {
+static const struct snd_soc_ops wm1133_ev1_ops = {
 	.hw_params = wm1133_ev1_hw_params,
 };
 
-- 
2.11.0
