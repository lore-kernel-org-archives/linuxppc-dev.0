Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0QZs5jX5zDrvR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 13:53:25 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id bd8so3996012plb.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 18:53:25 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 mail@maciej.szmigiero.name, caleb@crome.org, arnaud.mouiche@invoxia.com,
 lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v4 02/11] ASoC: fsl_ssi: Cache pdev->dev pointer
Date: Sun, 17 Dec 2017 18:52:01 -0800
Message-Id: <1513565530-33957-3-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1513565530-33957-1-git-send-email-nicoleotsuka@gmail.com>
References: <1513565530-33957-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There should be no trouble to understand dev = pdev->dev.
This can save some space to have more print info or save
some wrapped lines.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 64 ++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 84d2f7e..e903c92 100644
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
2.7.4
