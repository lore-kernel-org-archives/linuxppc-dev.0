Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PnCg4zBGzF1sj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 22:06:06 +1000 (AEST)
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_esai: Add freq check in set_dai_sysclk()" to the
 asoc tree
In-Reply-To: <1523234034-33018-1-git-send-email-nicoleotsuka@gmail.com>
Message-Id: <E1f82tQ-0000nK-OJ@debutante>
Date: Mon, 16 Apr 2018 13:05:56 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_esai: Add freq check in set_dai_sysclk()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 8a2278b7fb3df67cd415c679ba1a0e5e4a1761a7 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Sun, 8 Apr 2018 17:33:54 -0700
Subject: [PATCH] ASoC: fsl_esai: Add freq check in set_dai_sysclk()

The freq parameter indicates the physical frequency of an actual
input clock or a desired frequency of an output clock for HCKT/R.
It should never be passed 0. This might cause Division-by-zero.

So this patch adds a check to fix it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index da8fd98c7f51..d79e99ef31ad 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -226,6 +226,12 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	unsigned long clk_rate;
 	int ret;
 
+	if (freq == 0) {
+		dev_err(dai->dev, "%sput freq of HCK%c should not be 0Hz\n",
+			in ? "in" : "out", tx ? 'T' : 'R');
+		return -EINVAL;
+	}
+
 	/* Bypass divider settings if the requirement doesn't change */
 	if (freq == esai_priv->hck_rate[tx] && dir == esai_priv->hck_dir[tx])
 		return 0;
-- 
2.17.0
