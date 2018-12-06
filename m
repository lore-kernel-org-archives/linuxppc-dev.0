Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57941C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 20:29:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CBE820850
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 20:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="GibbHfDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBE820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439nHw4qzTzDqGk
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 07:29:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="GibbHfDf";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="GibbHfDf"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439nDf1WdbzDrN2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 07:26:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=YJq0/6au+7vtfyafCu5Lnbhz+mjZcCIHqpELiBIKpJA=; b=GibbHfDfUzIc
 EGpc+u5XPOixl0wEmqDcFzQia29bWUaHbt/0ryURLqLSUKs+Bu79BxaZSx5SppcNdPte1QGwPtwpX
 knKUbH1NVGXwTuoiK7wtnQeHUwY+lCiU2//ej1EfyoC3Ol0PbIOXPLFQf77eYlAZ6nZnmiqrPBPpi
 VskGU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gV0Di-0001hO-Ps; Thu, 06 Dec 2018 20:26:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 639D711252F7; Thu,  6 Dec 2018 20:26:02 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Applied "ASoC: Use of_node_name_eq for node name comparisons" to the
 asoc tree
In-Reply-To: <20181205195050.4759-33-robh@kernel.org>
X-Patchwork-Hint: ignore
Message-Id: <20181206202602.639D711252F7@debutante.sirena.org.uk>
Date: Thu,  6 Dec 2018 20:26:02 +0000 (GMT)
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The patch

   ASoC: Use of_node_name_eq for node name comparisons

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

From 1d52a74ea2300158f87196fa381cde52d98cf4e4 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Dec 2018 13:50:49 -0600
Subject: [PATCH] ASoC: Use of_node_name_eq for node name comparisons

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For the FSL ASoC card, the full node names appear to be "ssi", "esai",
and "sai", so there's not any reason to use strstr and of_node_name_eq
can be used instead.

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c       | 6 +++---
 sound/soc/generic/simple-scu-card.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 44433b20435c..81f2fe2c6d23 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -571,17 +571,17 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	}
 
 	/* Common settings for corresponding Freescale CPU DAI driver */
-	if (strstr(cpu_np->name, "ssi")) {
+	if (of_node_name_eq(cpu_np, "ssi")) {
 		/* Only SSI needs to configure AUDMUX */
 		ret = fsl_asoc_card_audmux_init(np, priv);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to init audmux\n");
 			goto asrc_fail;
 		}
-	} else if (strstr(cpu_np->name, "esai")) {
+	} else if (of_node_name_eq(cpu_np, "esai")) {
 		priv->cpu_priv.sysclk_id[1] = ESAI_HCKT_EXTAL;
 		priv->cpu_priv.sysclk_id[0] = ESAI_HCKR_EXTAL;
-	} else if (strstr(cpu_np->name, "sai")) {
+	} else if (of_node_name_eq(cpu_np, "sai")) {
 		priv->cpu_priv.sysclk_id[1] = FSL_SAI_CLK_MAST1;
 		priv->cpu_priv.sysclk_id[0] = FSL_SAI_CLK_MAST1;
 	}
diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 7ae1901b2f85..656abe2015e1 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -223,7 +223,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	i = 0;
 	for_each_child_of_node(node, np) {
 		is_fe = false;
-		if (strcmp(np->name, PREFIX "cpu") == 0)
+		if (of_node_name_eq(np, PREFIX "cpu"))
 			is_fe = true;
 
 		ret = asoc_simple_card_dai_link_of(np, priv, daifmt, i, is_fe);
-- 
2.19.0.rc2

