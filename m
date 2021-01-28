Return-Path: <SRS0=s+PL=G7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACB5C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 11:34:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D595364DDB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 11:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D595364DDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DRJKN192DzDrQh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 22:34:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=cmss.chinamobile.com (client-ip=221.176.66.80;
 helo=cmccmta2.chinamobile.com; envelope-from=tangbin@cmss.chinamobile.com;
 receiver=<UNKNOWN>)
X-Greylist: delayed 188 seconds by postgrey-1.36 at bilbo;
 Thu, 28 Jan 2021 22:30:58 AEDT
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com
 [221.176.66.80])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DRJFG1ZqgzDqN8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2021 22:30:57 +1100 (AEDT)
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by
 rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee560129f8fdaf-37a3b;
 Thu, 28 Jan 2021 19:27:11 +0800 (CST)
X-RM-TRANSID: 2ee560129f8fdaf-37a3b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
 by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee560129f8be3a-d290f;
 Thu, 28 Jan 2021 19:27:11 +0800 (CST)
X-RM-TRANSID: 2ee560129f8be3a-d290f
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: broonie@kernel.org, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH] ASoC: fsl_spdif: Utilize the defined parameter to clear code
Date: Thu, 28 Jan 2021 19:27:14 +0800
Message-Id: <20210128112714.16324-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Tang Bin <tangbin@cmss.chinamobile.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Utilize the defined parameter 'dev' to make the code cleaner.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/fsl/fsl_spdif.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 455f96908..b6d5563df 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1215,7 +1215,7 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 
 	for (i = 0; i < STC_TXCLK_SRC_MAX; i++) {
 		sprintf(tmp, "rxtx%d", i);
-		clk = devm_clk_get(&pdev->dev, tmp);
+		clk = devm_clk_get(dev, tmp);
 		if (IS_ERR(clk)) {
 			dev_err(dev, "no rxtx%d clock in devicetree\n", i);
 			return PTR_ERR(clk);
@@ -1237,14 +1237,14 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 			break;
 	}
 
-	dev_dbg(&pdev->dev, "use rxtx%d as tx clock source for %dHz sample rate\n",
+	dev_dbg(dev, "use rxtx%d as tx clock source for %dHz sample rate\n",
 			spdif_priv->txclk_src[index], rate[index]);
-	dev_dbg(&pdev->dev, "use txclk df %d for %dHz sample rate\n",
+	dev_dbg(dev, "use txclk df %d for %dHz sample rate\n",
 			spdif_priv->txclk_df[index], rate[index]);
 	if (clk_is_match(spdif_priv->txclk[index], spdif_priv->sysclk))
-		dev_dbg(&pdev->dev, "use sysclk df %d for %dHz sample rate\n",
+		dev_dbg(dev, "use sysclk df %d for %dHz sample rate\n",
 				spdif_priv->sysclk_df[index], rate[index]);
-	dev_dbg(&pdev->dev, "the best rate for %dHz sample rate is %dHz\n",
+	dev_dbg(dev, "the best rate for %dHz sample rate is %dHz\n",
 			rate[index], spdif_priv->txrate[index]);
 
 	return 0;
-- 
2.20.1.windows.1



