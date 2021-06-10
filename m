Return-Path: <SRS0=PqB2=LE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDB9C48BE5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jun 2021 12:52:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EF0613C1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jun 2021 12:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EF0613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G13lc34gVz308V
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jun 2021 22:52:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mPtdElz8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=163.com
 (client-ip=220.181.12.13; helo=m12-13.163.com; envelope-from=hbut_tan@163.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=mPtdElz8; dkim-atps=neutral
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
 by lists.ozlabs.org (Postfix) with ESMTP id 4G13l30hr2z3063
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jun 2021 22:51:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=R7rRZ
 DJWfcFuQCiHnx+KSuleoUfxvvGlDesqMsLVoLQ=; b=mPtdElz8voi3VV6tjW0cr
 xSM9eN0YI4LYD3DsWayu4y6NVB/T24OaHkSLWU7xNRA7ZEAuKN4DY/7Na3PgCcu8
 efNMTLlRFmgcVPllGYQ5wsdSvuMAN8x3cVZI5CLZ2VUWnv+CJxC6JCl8MzKYIWNP
 Nxil4eobj7HL6OBThyy3yc=
Received: from localhost.localdomain (unknown [218.17.89.92])
 by smtp9 (Coremail) with SMTP id DcCowAB3ebW_CsJgoBppFg--.24300S2;
 Thu, 10 Jun 2021 20:51:12 +0800 (CST)
From: =?UTF-8?q?=C2=A0Zhongjun=20Tan?= <hbut_tan@163.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, shengjiu.wang@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Subject: [PATCH] ASoC:fsl_easrc:Remove superfluous error message around
 platform_get_irq()
Date: Thu, 10 Jun 2021 20:50:52 +0800
Message-Id: <20210610125052.1280-1-hbut_tan@163.com>
X-Mailer: git-send-email 2.30.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAB3ebW_CsJgoBppFg--.24300S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1xCr1fKF45ur48AFWUJwb_yoWfJFX_J3
 4UC393XFWrAFWj9ay0va12vr47WFs7CF4jvF4qkFnFv345tw45uayDJrn7uF4F9w4I93yx
 Wa4rurWFyr15ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU50tC7UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: xkex3sxwdqqiywtou0bp/xtbBqBetxl75dLHjvgAEsv
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
 linux-kernel@vger.kernel.org, Tan Zhongjun <tanzhongjun@yulong.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Tan Zhongjun <tanzhongjun@yulong.com>

Clean up the check for irq.dev_err is superfluous as platform_get_irq()
already prints an error.Remove curly braces to confirm to styling
requirements.

Signed-off-by: Tan Zhongjun <tanzhongjun@yulong.com>
---
 sound/soc/fsl/fsl_easrc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index b1765c7d3bcd..25747433916e 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1901,10 +1901,8 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq for node %pOF\n", np);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, fsl_easrc_isr, 0,
 			       dev_name(dev), easrc);
-- 
2.17.1


