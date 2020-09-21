Return-Path: <SRS0=a2eB=C6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13540C43463
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2020 02:01:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E59207BB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2020 02:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E59207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bvnjn40xWzDqcn
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2020 12:01:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.helo=cstnet.cn
 (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by lists.ozlabs.org (Postfix) with ESMTP id 4BvngX1C1xzDqcn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2020 11:59:33 +1000 (AEST)
Received: from localhost (unknown [159.226.5.99])
 by APP-05 (Coremail) with SMTP id zQCowADXPij8CGhfhanfAA--.57694S2;
 Mon, 21 Sep 2020 09:59:24 +0800 (CST)
From: Xu Wang <vulab@iscas.ac.cn>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, shengjiu.wang@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH] fsl: imx-audmix : Use devm_kcalloc() instead of devm_kzalloc()
Date: Mon, 21 Sep 2020 01:59:18 +0000
Message-Id: <20200921015918.24157-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowADXPij8CGhfhanfAA--.57694S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1UKw1fAr43Ar4rJr17trb_yoW8Aw45pa
 1ktFW0qFyjyF4Yvr1kKr4kWasxAa97Ca18t3W2gw1avwnxKr4kGFsYqr1UZFWFyF9YkF45
 K3y8Ja4YvFyUAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
 xVA2Y2ka0xkIwI1lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
 v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
 1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
 AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
 MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
 VFxhVjvjDU0xZFpf9x0JUPnYwUUUUU=
X-Originating-IP: [159.226.5.99]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCgUGA1z4jA6odQAAsx
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
Cc: linux-kernel@vger.kernel.org, Xu Wang <vulab@iscas.ac.cn>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

A multiplication for the size determination of a memory allocation
indicated that an array data structure should be processed.
Thus use the corresponding function "devm_kcalloc".

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 sound/soc/fsl/imx-audmix.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 202fb8950078..cbdc0a2c09c5 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -185,20 +185,20 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->num_dai = 2 * num_dai;
-	priv->dai = devm_kzalloc(&pdev->dev, priv->num_dai *
+	priv->dai = devm_kcalloc(&pdev->dev, priv->num_dai,
 				 sizeof(struct snd_soc_dai_link), GFP_KERNEL);
 	if (!priv->dai)
 		return -ENOMEM;
 
 	priv->num_dai_conf = num_dai;
-	priv->dai_conf = devm_kzalloc(&pdev->dev, priv->num_dai_conf *
+	priv->dai_conf = devm_kcalloc(&pdev->dev, priv->num_dai_conf,
 				      sizeof(struct snd_soc_codec_conf),
 				      GFP_KERNEL);
 	if (!priv->dai_conf)
 		return -ENOMEM;
 
 	priv->num_dapm_routes = 3 * num_dai;
-	priv->dapm_routes = devm_kzalloc(&pdev->dev, priv->num_dapm_routes *
+	priv->dapm_routes = devm_kcalloc(&pdev->dev, priv->num_dapm_routes,
 					 sizeof(struct snd_soc_dapm_route),
 					 GFP_KERNEL);
 	if (!priv->dapm_routes)
@@ -208,7 +208,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		struct snd_soc_dai_link_component *dlc;
 
 		/* for CPU/Codec/Platform x 2 */
-		dlc = devm_kzalloc(&pdev->dev, 6 * sizeof(*dlc), GFP_KERNEL);
+		dlc = devm_kcalloc(&pdev->dev, 6, sizeof(*dlc), GFP_KERNEL);
 		if (!dlc) {
 			dev_err(&pdev->dev, "failed to allocate dai_link\n");
 			return -ENOMEM;
-- 
2.17.1

