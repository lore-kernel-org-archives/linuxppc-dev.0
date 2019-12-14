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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E15C43603
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Dec 2019 18:12:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA4A420706
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Dec 2019 18:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwDo3TMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4A420706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47ZwcC1d5qzDqDl
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Dec 2019 05:12:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=tiny.windzz@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uwDo3TMv"; 
 dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47ZwDG43m5zDqwn
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Dec 2019 04:55:10 +1100 (AEDT)
Received: by mail-pj1-x1044.google.com with SMTP id w5so1112996pjh.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Dec 2019 09:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ng8Q0G8vgCj6uZQhSm10VUxj1CLBc6zwwLxL5iSkIvg=;
 b=uwDo3TMv8S2LoOFtW4JVpy1MDe4ohxY3mDft8b066gcYOSuhrz7Vn+cChfAtY3zyqn
 IAyetRDDXThqE289VVS2YvJOiNym3+wHdqebZAOj/+de9OBlKY5zjjmSIqBB9ae1zcyE
 QsjU0e36EmG8HlZAn2z14x2grKm00ym36TewLzHqvcoWKlXNBvO36kzVqFZ+C9rdQ5vB
 8psuuCLMuKqOqlZxA2CdL8otclGnRw8GGN4mAppdWQKbQOEHr6G//zV1s+vOZGE2ysCF
 yfb7BEDTYGm17ide1ziXmZvv3fdOSWOiBnjE8djoQeQ9JuszfdfL9RNemPFm4yVxJLYK
 IpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ng8Q0G8vgCj6uZQhSm10VUxj1CLBc6zwwLxL5iSkIvg=;
 b=jNLhyCz8R2Em5lF1vPbcq5SFFx5RBHX7P4DBaTOPP4jXNOztK1rEwB/tzSnyyWLvPo
 LmCdkwbYKgioP22wz1Y7UKh0fYvcxPmhVOX29wTaG4C7OkmdkZTFgHrGZW0kLnY/jtXS
 SvgIeKZ60YVhKo9rR3KbJqOt+dytIkDM8JZUBidihmtTpipJZ4OxpKKTKLEi0YcJLZjd
 5tpnwiUAH1HwFQh5rbVrDcGUydJI9iVFfGXlsIfCfcMw8oHhRIL5x9ndixh55CO5+9H1
 as9qR8ggeZhpfTrGiKXMq7XWwCBNzgNBZm2RUZzitsIz6GeKZ38B0W76xUvXd2ccoAu5
 ciog==
X-Gm-Message-State: APjAAAVrYN4V1DCTUdhIvSBUkOGpjaHefll0A/cCrJ/1NuOVnDA2WKZk
 nh1qPEzSb98Zld33Jo2mC2Y=
X-Google-Smtp-Source: APXvYqw4NxLBs8k/N3sZ95qNmbftyGzDAHq+3kcbBnLjVVt0Sw+VMa4Kzi1WhBK/Tx84u07Lwngzfg==
X-Received: by 2002:a17:902:8501:: with SMTP id
 bj1mr6375383plb.84.1576346108088; 
 Sat, 14 Dec 2019 09:55:08 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
 by smtp.gmail.com with ESMTPSA id u2sm15056755pgc.19.2019.12.14.09.55.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 14 Dec 2019 09:55:07 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: khilman@baylibre.com, leoyang.li@nxp.com, khalasa@piap.pl,
 john@phrozen.org, matthias.bgg@gmail.com, agross@kernel.org,
 bjorn.andersson@linaro.org, kgene@kernel.org, krzk@kernel.org,
 mripard@kernel.org, wens@csie.org, ssantosh@kernel.org, jun.nie@linaro.org,
 shawnguo@kernel.org
Subject: [PATCH 06/10] soc: mediatek: convert to devm_platform_ioremap_resource
Date: Sat, 14 Dec 2019 17:54:43 +0000
Message-Id: <20191214175447.25482-6-tiny.windzz@gmail.com>
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
 drivers/soc/mediatek/mtk-scpsys.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index f669d3754627..2aa2afdc9ccf 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -425,7 +425,6 @@ static struct scp *init_scp(struct platform_device *pdev,
 			bool bus_prot_reg_update)
 {
 	struct genpd_onecell_data *pd_data;
-	struct resource *res;
 	int i, j;
 	struct scp *scp;
 	struct clk *clk[CLK_MAX];
@@ -441,8 +440,7 @@ static struct scp *init_scp(struct platform_device *pdev,
 
 	scp->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	scp->base = devm_ioremap_resource(&pdev->dev, res);
+	scp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(scp->base))
 		return ERR_CAST(scp->base);
 
-- 
2.17.1

