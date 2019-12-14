Return-Path: <SRS0=reMV=2E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0765C43603
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Dec 2019 18:20:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEAC214AF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Dec 2019 18:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwbTlKjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEAC214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Zwnz264VzDr0m
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Dec 2019 05:20:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1043;
 helo=mail-pj1-x1043.google.com; envelope-from=tiny.windzz@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jwbTlKjU"; 
 dkim-atps=neutral
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47ZwDN5YsJzDqyP
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Dec 2019 04:55:16 +1100 (AEDT)
Received: by mail-pj1-x1043.google.com with SMTP id v93so1123004pjb.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Dec 2019 09:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=p464edzUa2iPp9uHgJjpc0nSudXprxPgj9c87WZ/a/8=;
 b=jwbTlKjUlgdBEVsfFGJ0AFRM27IrT+5/nGVpeqjmCQY8Pvog9nLbJEGs3BoJShCWcc
 HUCs/NcUJEbspXufkbpSOSgpcLjHI9uSC2uL8deL98KCPLdAycltVaMbDTSY7BfErs2r
 3jb+3au9m3HLLvo5IanTkhro0u+uMh+7QnL1Kmvn6n0zxgK8PqWxjbHB9UOlTP9lJERQ
 fRA0q2rQ0Mg0I4cJZ6oR/WvAPyLLemDcLzfJOfJwdMDJDyZj6sbgdurkJ9mbvF3rvF94
 qtAuTF6Xj2R2j2anoXaTjjEStkzmzXjXeUm9O3eCz5K6gXyVi95VvTd8QtE1eKhmZ/RZ
 FutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=p464edzUa2iPp9uHgJjpc0nSudXprxPgj9c87WZ/a/8=;
 b=XvmaTSTGXSVibZUz47aj0S5k/1bALvhzKv3NYOjNm0tTOLpfOM8lNOfdUGKbQr6pPo
 Myy8tK3cyMffFE2LWqGlRTm187BLyR0jc/KHxfahKu/VPrPA1IBdOyaBUmKxUVM2yqrY
 783OGac6IuaiKcxKN8ypYShW2d96n9WY7Fny0uxscAA+Jl8jUkW7RGzdmpo+bhsZZ78L
 M/BloP2cwzJM2TbJcoz4zePOG/PNakknCHeWKRwtBrOHt9zJruH83gx2vp0Qcde2hWk0
 zOvGDyJZPWfeRNrElXeBxdMjM/2Y8neTLI71O4WB9ffVgdV7eN/WHyuVxkt+lis8bWod
 PqMg==
X-Gm-Message-State: APjAAAUqqDtv1AwAiABWJplafSsYD6njiOWtZc58nZR7VVOe6C0vCMtg
 VsVqNn9JlqjCOmLjWXt4t/4=
X-Google-Smtp-Source: APXvYqxG8GAI4f/vKneCzHJdyU3sDnTOcUKGttUJVG0Uipa0HZQ6CtNPSXlPYC7sJOX/nTAUj+QlEA==
X-Received: by 2002:a17:90a:374b:: with SMTP id
 u69mr6820565pjb.23.1576346114545; 
 Sat, 14 Dec 2019 09:55:14 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
 by smtp.gmail.com with ESMTPSA id z23sm14868517pgj.43.2019.12.14.09.55.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 14 Dec 2019 09:55:13 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: khilman@baylibre.com, leoyang.li@nxp.com, khalasa@piap.pl,
 john@phrozen.org, matthias.bgg@gmail.com, agross@kernel.org,
 bjorn.andersson@linaro.org, kgene@kernel.org, krzk@kernel.org,
 mripard@kernel.org, wens@csie.org, ssantosh@kernel.org, jun.nie@linaro.org,
 shawnguo@kernel.org
Subject: [PATCH 08/10] soc: lantiq: convert to devm_platform_ioremap_resource
Date: Sat, 14 Dec 2019 17:54:45 +0000
Message-Id: <20191214175447.25482-8-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214175447.25482-1-tiny.windzz@gmail.com>
References: <20191214175447.25482-1-tiny.windzz@gmail.com>
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
Cc: linux-samsung-soc@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/soc/lantiq/fpi-bus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/lantiq/fpi-bus.c b/drivers/soc/lantiq/fpi-bus.c
index cb0303a0fe60..dff1375851cf 100644
--- a/drivers/soc/lantiq/fpi-bus.c
+++ b/drivers/soc/lantiq/fpi-bus.c
@@ -28,14 +28,12 @@ static int ltq_fpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct resource *res_xbar;
 	struct regmap *rcu_regmap;
 	void __iomem *xbar_membase;
 	u32 rcu_ahb_endianness_reg_offset;
 	int ret;
 
-	res_xbar = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	xbar_membase = devm_ioremap_resource(dev, res_xbar);
+	xbar_membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xbar_membase))
 		return PTR_ERR(xbar_membase);
 
-- 
2.17.1

