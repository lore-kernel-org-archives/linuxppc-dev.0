Return-Path: <SRS0=Om5s=GN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BEBC433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 23:31:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BD0229C4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 23:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BD0229C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DDY4v1ZjRzDqSd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Jan 2021 10:31:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bootlin.com (client-ip=217.70.183.199;
 helo=relay9-d.mail.gandi.net; envelope-from=alexandre.belloni@bootlin.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=bootlin.com
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DDXnp5dHCzDqPR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2021 10:18:22 +1100 (AEDT)
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr
 [86.202.109.140])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 5A7B2FF80A;
 Sun, 10 Jan 2021 23:18:19 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 08/17] rtc: pcf85063: remove pcf85063_rtc_ops_alarm
Date: Mon, 11 Jan 2021 00:17:43 +0100
Message-Id: <20210110231752.1418816-9-alexandre.belloni@bootlin.com>
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

Move the alarm callbacks in pcf85063_rtc_ops and use RTC_FEATURE_ALARM to
signal to the core whether alarms are available instead of having a
supplementary struct rtc_class_ops without alarm callbacks.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85063.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index e19cf2adbc35..f7e7c9eb0781 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -307,14 +307,6 @@ static int pcf85063_ioctl(struct device *dev, unsigned int cmd,
 }
 
 static const struct rtc_class_ops pcf85063_rtc_ops = {
-	.read_time	= pcf85063_rtc_read_time,
-	.set_time	= pcf85063_rtc_set_time,
-	.read_offset	= pcf85063_read_offset,
-	.set_offset	= pcf85063_set_offset,
-	.ioctl		= pcf85063_ioctl,
-};
-
-static const struct rtc_class_ops pcf85063_rtc_ops_alarm = {
 	.read_time	= pcf85063_rtc_read_time,
 	.set_time	= pcf85063_rtc_set_time,
 	.read_offset	= pcf85063_read_offset,
@@ -587,6 +579,7 @@ static int pcf85063_probe(struct i2c_client *client)
 	pcf85063->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	pcf85063->rtc->range_max = RTC_TIMESTAMP_END_2099;
 	pcf85063->rtc->uie_unsupported = 1;
+	clear_bit(RTC_FEATURE_ALARM, pcf85063->rtc->features);
 
 	if (config->has_alarms && client->irq > 0) {
 		err = devm_request_threaded_irq(&client->dev, client->irq,
@@ -597,7 +590,7 @@ static int pcf85063_probe(struct i2c_client *client)
 			dev_warn(&pcf85063->rtc->dev,
 				 "unable to request IRQ, alarms disabled\n");
 		} else {
-			pcf85063->rtc->ops = &pcf85063_rtc_ops_alarm;
+			set_bit(RTC_FEATURE_ALARM, pcf85063->rtc->features);
 			device_init_wakeup(&client->dev, true);
 			err = dev_pm_set_wake_irq(&client->dev, client->irq);
 			if (err)
-- 
2.29.2

