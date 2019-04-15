Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DE9C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 08:59:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4A220693
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 08:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ZWUbFz/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4A220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jMrF2LLDzDqKH
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 18:59:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="ZWUbFz/K"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jMjq64PJzDqHb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 18:53:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=xRyjMEGkpecKWUwxfivi9fyoOcEoIIfxSaZJkUJHyBg=; b=ZWUbFz/Kwgr8
 EbfhNn8BRwmPjhye9xUwrDbVi8fCbOF5kUiwC4jS9Cq1f0b3qVILzmVSW2B++ETi4ntolI7qjX5F+
 HdWEQXutDGN/jp8NKp996BlxbKgQR+S1AAbz3x11SAfeZAYvCPj6D7T+xhxiQZNKek82Xts1gWsM3
 T0yPo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1hFxMu-0007iq-HS; Mon, 15 Apr 2019 08:53:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 496361127A40; Mon, 15 Apr 2019 09:53:30 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Applied "ASoC: fsl_audmix: cache pdev->dev pointer" to the asoc tree
In-Reply-To: <1554894380-25153-5-git-send-email-viorel.suman@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190415085330.496361127A40@debutante.sirena.org.uk>
Date: Mon, 15 Apr 2019 09:53:30 +0100 (BST)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Viorel Suman <viorel.suman@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The patch

   ASoC: fsl_audmix: cache pdev->dev pointer

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

From ecf6715042cf0f738763fe34d1636b707961a58a Mon Sep 17 00:00:00 2001
From: Viorel Suman <viorel.suman@nxp.com>
Date: Wed, 10 Apr 2019 11:06:39 +0000
Subject: [PATCH] ASoC: fsl_audmix: cache pdev->dev pointer

There should be no trouble to understand dev = pdev->dev.
This can save some space to have more print info or save
some wrapped lines.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Suggested-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_audmix.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index dc802d5c4ccd..3897a54a11fe 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -456,6 +456,7 @@ MODULE_DEVICE_TABLE(of, fsl_audmix_ids);
 
 static int fsl_audmix_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct fsl_audmix *priv;
 	struct resource *res;
 	const char *mdrv;
@@ -463,52 +464,50 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 	void __iomem *regs;
 	int ret;
 
-	of_id = of_match_device(fsl_audmix_ids, &pdev->dev);
+	of_id = of_match_device(fsl_audmix_ids, dev);
 	if (!of_id || !of_id->data)
 		return -EINVAL;
 
 	mdrv = of_id->data;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	/* Get the addresses */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(&pdev->dev, res);
+	regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	priv->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "ipg", regs,
+	priv->regmap = devm_regmap_init_mmio_clk(dev, "ipg", regs,
 						 &fsl_audmix_regmap_config);
 	if (IS_ERR(priv->regmap)) {
-		dev_err(&pdev->dev, "failed to init regmap\n");
+		dev_err(dev, "failed to init regmap\n");
 		return PTR_ERR(priv->regmap);
 	}
 
-	priv->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	priv->ipg_clk = devm_clk_get(dev, "ipg");
 	if (IS_ERR(priv->ipg_clk)) {
-		dev_err(&pdev->dev, "failed to get ipg clock\n");
+		dev_err(dev, "failed to get ipg clock\n");
 		return PTR_ERR(priv->ipg_clk);
 	}
 
 	platform_set_drvdata(pdev, priv);
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_audmix_component,
+	ret = devm_snd_soc_register_component(dev, &fsl_audmix_component,
 					      fsl_audmix_dai,
 					      ARRAY_SIZE(fsl_audmix_dai));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register ASoC DAI\n");
+		dev_err(dev, "failed to register ASoC DAI\n");
 		return ret;
 	}
 
-	priv->pdev = platform_device_register_data(&pdev->dev, mdrv, 0, NULL,
-						   0);
+	priv->pdev = platform_device_register_data(dev, mdrv, 0, NULL, 0);
 	if (IS_ERR(priv->pdev)) {
 		ret = PTR_ERR(priv->pdev);
-		dev_err(&pdev->dev, "failed to register platform %s: %d\n",
-			mdrv, ret);
+		dev_err(dev, "failed to register platform %s: %d\n", mdrv, ret);
 	}
 
 	return ret;
-- 
2.20.1

