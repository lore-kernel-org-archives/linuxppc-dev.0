Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA22C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Sep 2021 07:27:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3462161164
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Sep 2021 07:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3462161164
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H4DHg6F2hz2yw0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Sep 2021 17:27:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=baidu.com (client-ip=111.202.115.85; helo=baidu.com;
 envelope-from=caihuoqing@baidu.com; receiver=<UNKNOWN>)
X-Greylist: delayed 931 seconds by postgrey-1.36 at boromir;
 Wed, 08 Sep 2021 17:27:17 AEST
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
 by lists.ozlabs.org (Postfix) with ESMTP id 4H4DH93lzmz2xgN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Sep 2021 17:27:12 +1000 (AEST)
Received: from BC-Mail-Ex30.internal.baidu.com (unknown [172.31.51.24])
 by Forcepoint Email with ESMTPS id 3224E2BA1E951A9254FA;
 Wed,  8 Sep 2021 15:11:38 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex30.internal.baidu.com (172.31.51.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 8 Sep 2021 15:11:37 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 15:11:36 +0800
From: Cai Huoqing <caihuoqing@baidu.com>
To: <caihuoqing@baidu.com>
Subject: [PATCH 1/2] soc: fsl: guts: Make use of the helper function
 devm_platform_ioremap_resource()
Date: Wed, 8 Sep 2021 15:11:13 +0800
Message-ID: <20210908071123.348-3-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908071123.348-1-caihuoqing@baidu.com>
References: <20210908071123.348-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
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
Cc: Nishanth Menon <nm@ti.com>, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Jerome Brunet <jbrunet@baylibre.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Kevin Hilman <khilman@baylibre.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@csie.org>,
 bcm-kernel-feedback-list@broadcom.com, linux-sunxi@lists.linux.dev,
 linux-pm@vger.kernel.org, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 Maxime Ripard <mripard@kernel.org>, Krzysztof Halasa <khalasa@piap.pl>,
 Santosh
 Shilimkar <ssantosh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/soc/fsl/guts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index d5e9a5f2c087..072473a16f4d 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -140,7 +140,6 @@ static int fsl_guts_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	const struct fsl_soc_die_attr *soc_die;
 	const char *machine;
 	u32 svr;
@@ -152,8 +151,7 @@ static int fsl_guts_probe(struct platform_device *pdev)
 
 	guts->little_endian = of_property_read_bool(np, "little-endian");
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	guts->regs = devm_ioremap_resource(dev, res);
+	guts->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(guts->regs))
 		return PTR_ERR(guts->regs);
 
-- 
2.25.1

