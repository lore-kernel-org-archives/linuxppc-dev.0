Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3E3C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Sep 2021 07:28:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB8261164
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Sep 2021 07:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3BB8261164
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H4DJY6rd3z3c5X
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Sep 2021 17:28:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=baidu.com (client-ip=220.181.3.85; helo=baidu.com;
 envelope-from=caihuoqing@baidu.com; receiver=<UNKNOWN>)
Received: from baidu.com (mx21.baidu.com [220.181.3.85])
 by lists.ozlabs.org (Postfix) with ESMTP id 4H4DHB26wmz2xnc
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Sep 2021 17:27:12 +1000 (AEST)
Received: from BC-Mail-Ex31.internal.baidu.com (unknown [172.31.51.25])
 by Forcepoint Email with ESMTPS id 1004E927106F60D5A71A;
 Wed,  8 Sep 2021 15:11:35 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex31.internal.baidu.com (172.31.51.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 8 Sep 2021 15:11:34 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 15:11:33 +0800
From: Cai Huoqing <caihuoqing@baidu.com>
To: <caihuoqing@baidu.com>
Subject: [PATCH 1/2] soc: bcm: bcm-pmb: Make use of the helper function
 devm_platform_ioremap_resource()
Date: Wed, 8 Sep 2021 15:11:12 +0800
Message-ID: <20210908071123.348-2-caihuoqing@baidu.com>
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
 drivers/soc/bcm/bcm63xx/bcm-pmb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/bcm/bcm63xx/bcm-pmb.c b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
index 774465c119be..7bbe46ea5f94 100644
--- a/drivers/soc/bcm/bcm63xx/bcm-pmb.c
+++ b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
@@ -276,7 +276,6 @@ static int bcm_pmb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct bcm_pmb_pd_data *table;
 	const struct bcm_pmb_pd_data *e;
-	struct resource *res;
 	struct bcm_pmb *pmb;
 	int max_id;
 	int err;
@@ -287,8 +286,7 @@ static int bcm_pmb_probe(struct platform_device *pdev)
 
 	pmb->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pmb->base = devm_ioremap_resource(&pdev->dev, res);
+	pmb->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pmb->base))
 		return PTR_ERR(pmb->base);
 
-- 
2.25.1

