Return-Path: <broonie@sirena.co.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyh6G1WyczDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 01:55:50 +1000 (AEST)
From: Mark Brown <broonie@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, timur@tabi.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, peter.ujfalusi@ti.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org
Subject: Applied "ASoC: omap-hdmi-audio: Handle return value of
 devm_kasprintf" to the asoc tree
In-Reply-To: <1505901971-12004-4-git-send-email-arvind.yadav.cs@gmail.com>
Message-Id: <E1dv3p8-0006N6-Or@debutante>
Date: Thu, 21 Sep 2017 16:55:34 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: omap-hdmi-audio: Handle return value of devm_kasprintf

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

>From 94a6a8e8b57a8ece33b97a6dfc5f7eae61ff96f8 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 20 Sep 2017 15:36:11 +0530
Subject: [PATCH] ASoC: omap-hdmi-audio: Handle return value of devm_kasprintf

devm_kasprintf() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/omap-hdmi-audio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-audio.c
index 3e9cc4842a1d..8eeac7cab1c1 100644
--- a/sound/soc/omap/omap-hdmi-audio.c
+++ b/sound/soc/omap/omap-hdmi-audio.c
@@ -362,6 +362,9 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 
 	card->name = devm_kasprintf(dev, GFP_KERNEL,
 				    "HDMI %s", dev_name(ad->dssdev));
+	if (!card->name)
+		return -ENOMEM;
+
 	card->owner = THIS_MODULE;
 	card->dai_link =
 		devm_kzalloc(dev, sizeof(*(card->dai_link)), GFP_KERNEL);
-- 
2.14.1
