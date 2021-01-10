Return-Path: <SRS0=Om5s=GN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEC7C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 23:37:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9397229C9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 23:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9397229C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DDYDJ3dMJzDqc1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Jan 2021 10:37:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bootlin.com (client-ip=217.70.183.200;
 helo=relay7-d.mail.gandi.net; envelope-from=alexandre.belloni@bootlin.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=bootlin.com
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DDXnt2V0RzDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2021 10:18:25 +1100 (AEDT)
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr
 [86.202.109.140])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0659B20007;
 Sun, 10 Jan 2021 23:18:22 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 11/17] rtc: m41t80: constify m41t80_rtc_ops
Date: Mon, 11 Jan 2021 00:17:46 +0100
Message-Id: <20210110231752.1418816-12-alexandre.belloni@bootlin.com>
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

Use RTC_FEATURE_ALARM to signal to the core whether alarms are available
instead of changing the global struct rtc_class_ops, allowing to make it
const.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-m41t80.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 160dcf68e64e..e3ddd660d68c 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -397,10 +397,13 @@ static int m41t80_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	return 0;
 }
 
-static struct rtc_class_ops m41t80_rtc_ops = {
+static const struct rtc_class_ops m41t80_rtc_ops = {
 	.read_time = m41t80_rtc_read_time,
 	.set_time = m41t80_rtc_set_time,
 	.proc = m41t80_rtc_proc,
+	.read_alarm = m41t80_read_alarm,
+	.set_alarm = m41t80_set_alarm,
+	.alarm_irq_enable = m41t80_alarm_irq_enable,
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -913,13 +916,10 @@ static int m41t80_probe(struct i2c_client *client,
 			wakeup_source = false;
 		}
 	}
-	if (client->irq > 0 || wakeup_source) {
-		m41t80_rtc_ops.read_alarm = m41t80_read_alarm;
-		m41t80_rtc_ops.set_alarm = m41t80_set_alarm;
-		m41t80_rtc_ops.alarm_irq_enable = m41t80_alarm_irq_enable;
-		/* Enable the wakealarm */
+	if (client->irq > 0 || wakeup_source)
 		device_init_wakeup(&client->dev, true);
-	}
+	else
+		clear_bit(RTC_FEATURE_ALARM, m41t80_data->rtc->features);
 
 	m41t80_data->rtc->ops = &m41t80_rtc_ops;
 	m41t80_data->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
-- 
2.29.2

