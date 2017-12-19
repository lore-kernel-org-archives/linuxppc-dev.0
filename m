Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1FLs6D44zDwP3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:00:53 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>,
 Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>,
 broonie@kernel.org, mail@maciej.szmigiero.name, timur@tabi.org,
 lgirdwood@gmail.com, alsa-devel@alsa-project.org, caleb@crome.org,
 linux-kernel@vger.kernel.org, fabio.estevam@nxp.com,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: Cache pdev->dev pointer" to the asoc tree
In-Reply-To: <1512420403-10164-4-git-send-email-nicoleotsuka@gmail.com>
Message-Id: <E1eRFdf-0001AM-Ap@debutante>
Date: Tue, 19 Dec 2017 11:00:47 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: Cache pdev->dev pointer

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

>From 8483c06797b62dbddac800b555b2fa1c689dbb1c Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Sun, 17 Dec 2017 18:52:01 -0800
Subject: [PATCH] ASoC: fsl_ssi: Cache pdev->dev pointer

There should be no trouble to understand dev = pdev->dev.
This can save some space to have more print info or save
some wrapped lines.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Acked-by: Timur Tabi <timur@tabi.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 64 ++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 84d2f7ecb5e1..e903c92d5512 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1379,23 +1379,24 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 		struct fsl_ssi *ssi, void __iomem *iomem)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	u32 dmas[4];
 	int ret;
 
 	if (ssi->has_ipg_clk_name)
-		ssi->clk = devm_clk_get(&pdev->dev, "ipg");
+		ssi->clk = devm_clk_get(dev, "ipg");
 	else
-		ssi->clk = devm_clk_get(&pdev->dev, NULL);
+		ssi->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ssi->clk)) {
 		ret = PTR_ERR(ssi->clk);
-		dev_err(&pdev->dev, "could not get clock: %d\n", ret);
+		dev_err(dev, "could not get clock: %d\n", ret);
 		return ret;
 	}
 
 	if (!ssi->has_ipg_clk_name) {
 		ret = clk_prepare_enable(ssi->clk);
 		if (ret) {
-			dev_err(&pdev->dev, "clk_prepare_enable failed: %d\n", ret);
+			dev_err(dev, "clk_prepare_enable failed: %d\n", ret);
 			return ret;
 		}
 	}
@@ -1403,9 +1404,9 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	/* For those SLAVE implementations, we ignore non-baudclk cases
 	 * and, instead, abandon MASTER mode that needs baud clock.
 	 */
-	ssi->baudclk = devm_clk_get(&pdev->dev, "baud");
+	ssi->baudclk = devm_clk_get(dev, "baud");
 	if (IS_ERR(ssi->baudclk))
-		dev_dbg(&pdev->dev, "could not get baud clock: %ld\n",
+		dev_dbg(dev, "could not get baud clock: %ld\n",
 			 PTR_ERR(ssi->baudclk));
 
 	ssi->dma_params_tx.maxburst = ssi->dma_maxburst;
@@ -1469,6 +1470,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	struct fsl_ssi *ssi;
 	int ret = 0;
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	const struct of_device_id *of_id;
 	const char *p, *sprop;
 	const uint32_t *iprop;
@@ -1477,17 +1479,16 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	char name[64];
 	struct regmap_config regconfig = fsl_ssi_regconfig;
 
-	of_id = of_match_device(fsl_ssi_ids, &pdev->dev);
+	of_id = of_match_device(fsl_ssi_ids, dev);
 	if (!of_id || !of_id->data)
 		return -EINVAL;
 
-	ssi = devm_kzalloc(&pdev->dev, sizeof(*ssi),
-			GFP_KERNEL);
+	ssi = devm_kzalloc(dev, sizeof(*ssi), GFP_KERNEL);
 	if (!ssi)
 		return -ENOMEM;
 
 	ssi->soc = of_id->data;
-	ssi->dev = &pdev->dev;
+	ssi->dev = dev;
 
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (sprop) {
@@ -1507,10 +1508,10 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		memcpy(&ssi->cpu_dai_drv, &fsl_ssi_dai_template,
 		       sizeof(fsl_ssi_dai_template));
 	}
-	ssi->cpu_dai_drv.name = dev_name(&pdev->dev);
+	ssi->cpu_dai_drv.name = dev_name(dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	iomem = devm_ioremap_resource(&pdev->dev, res);
+	iomem = devm_ioremap_resource(dev, res);
 	if (IS_ERR(iomem))
 		return PTR_ERR(iomem);
 	ssi->ssi_phys = res->start;
@@ -1528,21 +1529,20 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	ret = of_property_match_string(np, "clock-names", "ipg");
 	if (ret < 0) {
 		ssi->has_ipg_clk_name = false;
-		ssi->regs = devm_regmap_init_mmio(&pdev->dev, iomem,
-			&regconfig);
+		ssi->regs = devm_regmap_init_mmio(dev, iomem, &regconfig);
 	} else {
 		ssi->has_ipg_clk_name = true;
-		ssi->regs = devm_regmap_init_mmio_clk(&pdev->dev,
-			"ipg", iomem, &regconfig);
+		ssi->regs = devm_regmap_init_mmio_clk(dev, "ipg", iomem,
+						      &regconfig);
 	}
 	if (IS_ERR(ssi->regs)) {
-		dev_err(&pdev->dev, "Failed to init register map\n");
+		dev_err(dev, "Failed to init register map\n");
 		return PTR_ERR(ssi->regs);
 	}
 
 	ssi->irq = platform_get_irq(pdev, 0);
 	if (ssi->irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+		dev_err(dev, "no irq for node %s\n", pdev->name);
 		return ssi->irq;
 	}
 
@@ -1605,7 +1605,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		break;
 	}
 
-	dev_set_drvdata(&pdev->dev, ssi);
+	dev_set_drvdata(dev, ssi);
 
 	if (ssi->soc->imx) {
 		ret = fsl_ssi_imx_probe(pdev, ssi, iomem);
@@ -1617,30 +1617,28 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		mutex_init(&ssi->ac97_reg_lock);
 		ret = snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
 		if (ret) {
-			dev_err(&pdev->dev, "could not set AC'97 ops\n");
+			dev_err(dev, "could not set AC'97 ops\n");
 			goto error_ac97_ops;
 		}
 	}
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_ssi_component,
+	ret = devm_snd_soc_register_component(dev, &fsl_ssi_component,
 					      &ssi->cpu_dai_drv, 1);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register DAI: %d\n", ret);
+		dev_err(dev, "failed to register DAI: %d\n", ret);
 		goto error_asoc_register;
 	}
 
 	if (ssi->use_dma) {
-		ret = devm_request_irq(&pdev->dev, ssi->irq,
-					fsl_ssi_isr, 0, dev_name(&pdev->dev),
-					ssi);
+		ret = devm_request_irq(dev, ssi->irq, fsl_ssi_isr, 0,
+				       dev_name(dev), ssi);
 		if (ret < 0) {
-			dev_err(&pdev->dev, "could not claim irq %u\n",
-					ssi->irq);
+			dev_err(dev, "could not claim irq %u\n", ssi->irq);
 			goto error_asoc_register;
 		}
 	}
 
-	ret = fsl_ssi_debugfs_create(&ssi->dbg_stats, &pdev->dev);
+	ret = fsl_ssi_debugfs_create(&ssi->dbg_stats, dev);
 	if (ret)
 		goto error_asoc_register;
 
@@ -1665,23 +1663,23 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	snprintf(name, sizeof(name), "snd-soc-%s", sprop);
 	make_lowercase(name);
 
-	ssi->pdev = platform_device_register_data(&pdev->dev, name, 0, NULL, 0);
+	ssi->pdev = platform_device_register_data(dev, name, 0, NULL, 0);
 	if (IS_ERR(ssi->pdev)) {
 		ret = PTR_ERR(ssi->pdev);
-		dev_err(&pdev->dev, "failed to register platform: %d\n", ret);
+		dev_err(dev, "failed to register platform: %d\n", ret);
 		goto error_sound_card;
 	}
 
 done:
 	if (ssi->dai_fmt)
-		_fsl_ssi_set_dai_fmt(&pdev->dev, ssi, ssi->dai_fmt);
+		_fsl_ssi_set_dai_fmt(dev, ssi, ssi->dai_fmt);
 
 	if (fsl_ssi_is_ac97(ssi)) {
 		u32 ssi_idx;
 
 		ret = of_property_read_u32(np, "cell-index", &ssi_idx);
 		if (ret) {
-			dev_err(&pdev->dev, "cannot get SSI index property\n");
+			dev_err(dev, "cannot get SSI index property\n");
 			goto error_sound_card;
 		}
 
@@ -1689,7 +1687,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 					"ac97-codec", ssi_idx, NULL, 0);
 		if (IS_ERR(ssi->pdev)) {
 			ret = PTR_ERR(ssi->pdev);
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"failed to register AC97 codec platform: %d\n",
 				ret);
 			goto error_sound_card;
-- 
2.15.1
