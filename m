Return-Path: <SRS0=6LlZ=IC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5886FC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 09:08:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CC964F23
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 09:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CC964F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DrlQr3XSgz3cmN
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 20:08:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=yang.lee@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DrlQT2SZcz30Lq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Mar 2021 20:08:14 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=yang.lee@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0UQMz88a_1614848882; 
Received: from
 j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0UQMz88a_1614848882) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 04 Mar 2021 17:08:03 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: timur@kernel.org
Subject: [PATCH v2] ASoC: imx-hdmi: fix platform_no_drv_owner.cocci warnings
Date: Thu,  4 Mar 2021 17:08:01 +0800
Message-Id: <1614848881-29637-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
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
 linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
 s.hauer@pengutronix.de, tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz,
 nicoleotsuka@gmail.com, broonie@kernel.org,
 Yang Li <yang.lee@linux.alibaba.com>, linux-imx@nxp.com, kernel@pengutronix.de,
 shawnguo@kernel.org, shengjiu.wang@gmail.com,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

./sound/soc/fsl/imx-hdmi.c:226:3-8: No need to set .owner here. The core
will do it.

Remove .owner field if calls are used which set it automatically

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

Change in v2:
-use imx-hdmi instead of hdmi-codec for Subject

 sound/soc/fsl/imx-hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/imx-hdmi.c b/sound/soc/fsl/imx-hdmi.c
index dbbb761..cd0235a 100644
--- a/sound/soc/fsl/imx-hdmi.c
+++ b/sound/soc/fsl/imx-hdmi.c
@@ -223,7 +223,6 @@ static int imx_hdmi_probe(struct platform_device *pdev)
 static struct platform_driver imx_hdmi_driver = {
 	.driver = {
 		.name = "imx-hdmi",
-		.owner = THIS_MODULE,
 		.pm = &snd_soc_pm_ops,
 		.of_match_table = imx_hdmi_dt_ids,
 	},
-- 
1.8.3.1

