Return-Path: <SRS0=Om5s=GN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684CBC433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 23:39:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A744D208E4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 23:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A744D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DDYG53vzyzDqS8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Jan 2021 10:39:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bootlin.com (client-ip=217.70.183.196;
 helo=relay4-d.mail.gandi.net; envelope-from=alexandre.belloni@bootlin.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=bootlin.com
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DDXnv1MKhzDqQF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2021 10:18:26 +1100 (AEDT)
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr
 [86.202.109.140])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 41E16E000B;
 Sun, 10 Jan 2021 23:18:21 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 10/17] rtc: pcf85363: drop a struct rtc_class_ops
Date: Mon, 11 Jan 2021 00:17:45 +0100
Message-Id: <20210110231752.1418816-11-alexandre.belloni@bootlin.com>
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

Merge both struct rtc_class_ops in a single one and use RTC_FEATURE_ALARM
to signal to the core whether alarms are available.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85363.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index a574c8d15a5c..8c2dcbac0d7b 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -285,11 +285,6 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, void *dev_id)
 static const struct rtc_class_ops rtc_ops = {
 	.read_time	= pcf85363_rtc_read_time,
 	.set_time	= pcf85363_rtc_set_time,
-};
-
-static const struct rtc_class_ops rtc_ops_alarm = {
-	.read_time	= pcf85363_rtc_read_time,
-	.set_time	= pcf85363_rtc_set_time,
 	.read_alarm	= pcf85363_rtc_read_alarm,
 	.set_alarm	= pcf85363_rtc_set_alarm,
 	.alarm_irq_enable = pcf85363_rtc_alarm_irq_enable,
@@ -403,6 +398,7 @@ static int pcf85363_probe(struct i2c_client *client,
 	pcf85363->rtc->ops = &rtc_ops;
 	pcf85363->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	pcf85363->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
 
 	if (client->irq > 0) {
 		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
@@ -415,7 +411,7 @@ static int pcf85363_probe(struct i2c_client *client,
 		if (ret)
 			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
 		else
-			pcf85363->rtc->ops = &rtc_ops_alarm;
+			set_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
 	}
 
 	ret = devm_rtc_register_device(pcf85363->rtc);
-- 
2.29.2

