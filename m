Return-Path: <SRS0=1bSx=7A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08629C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2020 07:47:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5F420825
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2020 07:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5F420825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49QWLz0NnPzDqWN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2020 17:47:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=cmss.chinamobile.com (client-ip=221.176.66.79;
 helo=cmccmta1.chinamobile.com; envelope-from=tangbin@cmss.chinamobile.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=cmss.chinamobile.com
Received: from cmccmta1.chinamobile.com (cmccmta1.chinamobile.com
 [221.176.66.79])
 by lists.ozlabs.org (Postfix) with ESMTP id 49QWHm5D8PzDqT9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2020 17:44:17 +1000 (AEST)
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by
 rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45ec23ca1c3a-3130b;
 Mon, 18 May 2020 15:43:29 +0800 (CST)
X-RM-TRANSID: 2ee45ec23ca1c3a-3130b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35ec23c9ef8a-3723f;
 Mon, 18 May 2020 15:43:29 +0800 (CST)
X-RM-TRANSID: 2ee35ec23c9ef8a-3723f
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: broonie@kernel.org, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, perex@perex.cz
Subject: [PATCH] ASoC: fsl_micfil: Fix format and unused assignment
Date: Mon, 18 May 2020 15:44:05 +0800
Message-Id: <20200518074405.14880-1-tangbin@cmss.chinamobile.com>
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

In the function fsl_micfil_startup(), the two lines of dev_err()
can be shortened to one line. And delete unused initialized value
of 'ret', because it will be assigned by the function
fsl_micfil_set_mclk_rate().

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/fsl/fsl_micfil.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index f7f2d29f1..a7a6118be 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -217,8 +217,7 @@ static int fsl_micfil_startup(struct snd_pcm_substream *substream,
 	struct fsl_micfil *micfil = snd_soc_dai_get_drvdata(dai);
 
 	if (!micfil) {
-		dev_err(dai->dev,
-			"micfil dai priv_data not set\n");
+		dev_err(dai->dev, "micfil dai priv_data not set\n");
 		return -EINVAL;
 	}
 
@@ -296,7 +295,7 @@ static int fsl_set_clock_params(struct device *dev, unsigned int rate)
 {
 	struct fsl_micfil *micfil = dev_get_drvdata(dev);
 	int clk_div;
-	int ret = 0;
+	int ret;
 
 	ret = fsl_micfil_set_mclk_rate(micfil, rate);
 	if (ret < 0)
-- 
2.20.1.windows.1



