Return-Path: <SRS0=Om5s=GN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5957CC433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 23:34:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B5922AAA
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 23:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B5922AAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DDY8T3b2wzDqV1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Jan 2021 10:34:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bootlin.com (client-ip=217.70.183.195;
 helo=relay3-d.mail.gandi.net; envelope-from=alexandre.belloni@bootlin.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=bootlin.com
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DDXnr2pwhzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2021 10:18:24 +1100 (AEDT)
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr
 [86.202.109.140])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 8745260006;
 Sun, 10 Jan 2021 23:18:17 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 06/17] rtc: m48t59: remove m48t02_rtc_ops
Date: Mon, 11 Jan 2021 00:17:41 +0100
Message-Id: <20210110231752.1418816-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210110231752.1418816-1-alexandre.belloni@bootlin.com>
References: <20210110231752.1418816-1-alexandre.belloni@bootlin.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Clear RTC_FEATURE_ALARM to signal that alarms are not available instead of
having a supplementary struct rtc_class_ops without alarm callbacks.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-m48t59.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
index 5f5898d3b055..1d2e99a70fce 100644
--- a/drivers/rtc/rtc-m48t59.c
+++ b/drivers/rtc/rtc-m48t59.c
@@ -313,11 +313,6 @@ static const struct rtc_class_ops m48t59_rtc_ops = {
 	.alarm_irq_enable = m48t59_rtc_alarm_irq_enable,
 };
 
-static const struct rtc_class_ops m48t02_rtc_ops = {
-	.read_time	= m48t59_rtc_read_time,
-	.set_time	= m48t59_rtc_set_time,
-};
-
 static int m48t59_nvram_read(void *priv, unsigned int offset, void *val,
 			     size_t size)
 {
@@ -366,7 +361,6 @@ static int m48t59_rtc_probe(struct platform_device *pdev)
 	struct m48t59_private *m48t59 = NULL;
 	struct resource *res;
 	int ret = -ENOMEM;
-	const struct rtc_class_ops *ops;
 	struct nvmem_config nvmem_cfg = {
 		.name = "m48t59-",
 		.word_size = 1,
@@ -438,17 +432,21 @@ static int m48t59_rtc_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 	}
+
+	m48t59->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(m48t59->rtc))
+		return PTR_ERR(m48t59->rtc);
+
 	switch (pdata->type) {
 	case M48T59RTC_TYPE_M48T59:
-		ops = &m48t59_rtc_ops;
 		pdata->offset = 0x1ff0;
 		break;
 	case M48T59RTC_TYPE_M48T02:
-		ops = &m48t02_rtc_ops;
+		clear_bit(RTC_FEATURE_ALARM, m48t59->rtc->features);
 		pdata->offset = 0x7f0;
 		break;
 	case M48T59RTC_TYPE_M48T08:
-		ops = &m48t02_rtc_ops;
+		clear_bit(RTC_FEATURE_ALARM, m48t59->rtc->features);
 		pdata->offset = 0x1ff0;
 		break;
 	default:
@@ -459,11 +457,7 @@ static int m48t59_rtc_probe(struct platform_device *pdev)
 	spin_lock_init(&m48t59->lock);
 	platform_set_drvdata(pdev, m48t59);
 
-	m48t59->rtc = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(m48t59->rtc))
-		return PTR_ERR(m48t59->rtc);
-
-	m48t59->rtc->ops = ops;
+	m48t59->rtc->ops = &m48t59_rtc_ops;
 
 	nvmem_cfg.size = pdata->offset;
 	ret = devm_rtc_nvmem_register(m48t59->rtc, &nvmem_cfg);
-- 
2.29.2

