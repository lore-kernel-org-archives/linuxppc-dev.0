Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9411C433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 10:54:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE0460F21
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 10:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4DE0460F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H1F6t05Yhz3cNl
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 20:54:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H1F4f3dSdz2y0D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Sep 2021 20:52:50 +1000 (AEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E6BCB1A3029;
 Fri,  3 Sep 2021 12:52:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AEB241A3022;
 Fri,  3 Sep 2021 12:52:47 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 49EE0183AD05;
 Fri,  3 Sep 2021 18:52:46 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org
Subject: [PATCH for-5.15 4/5] ASoC: fsl_spdif: register platform component
 before registering cpu dai
Date: Fri,  3 Sep 2021 18:30:05 +0800
Message-Id: <1630665006-31437-5-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630665006-31437-1-git-send-email-shengjiu.wang@nxp.com>
References: <1630665006-31437-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There is no defer probe when adding platform component to
snd_soc_pcm_runtime(rtd), the code is in snd_soc_add_pcm_runtime()

snd_soc_register_card()
  -> snd_soc_bind_card()
    -> snd_soc_add_pcm_runtime()
      -> adding cpu dai
      -> adding codec dai
      -> adding platform component.

So if the platform component is not ready at that time, then the
sound card still registered successfully, but platform component
is empty, the sound card can't be used.

As there is defer probe checking for cpu dai component, then register
platform component before cpu dai to avoid such issue.

Fixes: a2388a498ad2 ("ASoC: fsl: Add S/PDIF CPU DAI driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_spdif.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 8ffb1a6048d6..1c53719bb61e 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1434,16 +1434,20 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	regcache_cache_only(spdif_priv->regmap, true);
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_spdif_component,
-					      &spdif_priv->cpu_dai_drv, 1);
+	/*
+	 * Register platform component before registering cpu dai for there
+	 * is not defer probe for platform component in snd_soc_add_pcm_runtime().
+	 */
+	ret = imx_pcm_dma_init(pdev, IMX_SPDIF_DMABUF_SIZE);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register DAI: %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "imx_pcm_dma_init failed\n");
 		goto err_pm_disable;
 	}
 
-	ret = imx_pcm_dma_init(pdev, IMX_SPDIF_DMABUF_SIZE);
+	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_spdif_component,
+					      &spdif_priv->cpu_dai_drv, 1);
 	if (ret) {
-		dev_err_probe(&pdev->dev, ret, "imx_pcm_dma_init failed\n");
+		dev_err(&pdev->dev, "failed to register DAI: %d\n", ret);
 		goto err_pm_disable;
 	}
 
-- 
2.17.1

