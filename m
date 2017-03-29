Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtR5V4RlfzDqGy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 22:54:54 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 nicoleotsuka@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org,
 timur@tabi.org, Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com, fabio.estevam@nxp.com,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
In-Reply-To: <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
Message-Id: <E1ctCBS-0001ci-Rs@debutante>
Date: Wed, 29 Mar 2017 12:54:38 +0100
Subject: Applied "ASoC: imx-wm8962: Fix codec_clk cleanup" to the asoc tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: imx-wm8962: Fix codec_clk cleanup

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

>From db22d189453cee666f8da2e67419f14f4b2fd9d1 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Tue, 28 Mar 2017 11:58:52 +0300
Subject: [PATCH] ASoC: imx-wm8962: Fix codec_clk cleanup

Resource managed devm_clk_get only works with platform's device dev.

Reported-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-wm8962.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index 3d894d9123e0..52659faa2eb9 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -231,7 +231,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	codec_clk = devm_clk_get(&codec_dev->dev, NULL);
+	codec_clk = clk_get(&codec_dev->dev, NULL);
 	if (IS_ERR(codec_clk)) {
 		ret = PTR_ERR(codec_clk);
 		dev_err(&codec_dev->dev, "failed to get codec clk: %d\n", ret);
@@ -239,6 +239,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 	}
 
 	data->clk_frequency = clk_get_rate(codec_clk);
+	clk_put(codec_clk);
 
 	data->dai.name = "HiFi";
 	data->dai.stream_name = "HiFi";
-- 
2.11.0
