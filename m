Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAC8C001B0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Jul 2023 01:49:01 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Eq4WGEHI;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R90Lh2VCDz3bTf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Jul 2023 11:49:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Eq4WGEHI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.181.12.197; helo=m12.mail.163.com; envelope-from=ruc_gongyuanjun@163.com; receiver=lists.ozlabs.org)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R90Kf24DLz304g
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2023 11:48:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=rnAsuBux8+uw9H2k7I
	ICXTXrXs07ORcpcHho3UUYWn8=; b=Eq4WGEHIso8GDzpPMHessPTbOGXsGFNR/D
	H0dZWp/4YtTCgMWOMBpCZoPNhsy1tn38EoSBGecS15EN5EvynkHKIUSSjmJ8eLFB
	wpllK68A3CsJUtEvchTCox1zqagMJu0bNgCkiI98r6kuCsE2F735hXhr6YKQHytp
	L5a876blU=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wDnM6XJKb9kljDvBA--.28645S4;
	Tue, 25 Jul 2023 09:47:55 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: festevam@gmail.com
Subject: [PATCH v3 1/1] ASoC: imx-audmux: fix return value checks of clk_prepare_enable()
Date: Tue, 25 Jul 2023 09:47:51 +0800
Message-Id: <20230725014751.26365-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAOMZO5AXY7ThO0dTLc47xE7a61k9QEXMTbgSAx2Dqy_3RJxoTg@mail.gmail.com>
References: <CAOMZO5AXY7ThO0dTLc47xE7a61k9QEXMTbgSAx2Dqy_3RJxoTg@mail.gmail.com>
X-CM-TRANSID: _____wDnM6XJKb9kljDvBA--.28645S4
X-Coremail-Antispam: 1Uf129KBjvJXoWrKFyfArW3WFWkKF43ur45KFg_yoW8JrWfpr
	ZayrWjgrWrJrZ5Cw4fGr1kCF13ArWIkF47Z3sxGan2q3ZrAwnrX3WFqrnYvFs5Kr9YkF98
	GFZrGFyrAw1jyr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piBHqxUUUUU=
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiURK25WDESaD1sQABsY
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
Cc: shengjiu.wang@gmail.com, ruc_gongyuanjun@163.com, linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

check the return value of clk_prepare_enable(), and if
clk_prepare_enable() gets an unexpected return value,
imx_audmux_suspend() and imx_audmux_resume() should return
the error value.

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 sound/soc/fsl/imx-audmux.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index be003a117b39..096705ec2add 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -324,9 +324,11 @@ static void imx_audmux_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int imx_audmux_suspend(struct device *dev)
 {
-	int i;
+	int i, ret;
 
-	clk_prepare_enable(audmux_clk);
+	ret = clk_prepare_enable(audmux_clk);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < reg_max; i++)
 		regcache[i] = readl(audmux_base + i * 4);
@@ -338,9 +340,11 @@ static int imx_audmux_suspend(struct device *dev)
 
 static int imx_audmux_resume(struct device *dev)
 {
-	int i;
+	int i, ret;
 
-	clk_prepare_enable(audmux_clk);
+	ret = clk_prepare_enable(audmux_clk);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < reg_max; i++)
 		writel(regcache[i], audmux_base + i * 4);
-- 
2.17.1

