Return-Path: <SRS0=Om5s=GN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B52C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 23:24:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C690227C3
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 23:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C690227C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DDXwT2ymyzDqRD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Jan 2021 10:24:09 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DDXnh28cszDqLZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2021 10:18:15 +1100 (AEDT)
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr
 [86.202.109.140])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B812420004;
 Sun, 10 Jan 2021 23:18:02 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 01/17] rtc: introduce features bitfield
Date: Mon, 11 Jan 2021 00:17:36 +0100
Message-Id: <20210110231752.1418816-2-alexandre.belloni@bootlin.com>
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

Introduce a bitfield to allow the drivers to announce the available
features for an RTC.

The main use case would be to better handle alarms, that could be present
or not or have a minute resolution or may need a correct week day to be set.

Use the newly introduced RTC_FEATURE_ALARM bit to then test whether alarms
are available instead of relying on the presence of ops->set_alarm.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/class.c      |  5 +++++
 drivers/rtc/interface.c  | 12 ++++++------
 include/linux/rtc.h      |  2 ++
 include/uapi/linux/rtc.h |  5 +++++
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 7e470fbd5e4d..03abd0aa229a 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -231,6 +231,8 @@ static struct rtc_device *rtc_allocate_device(void)
 	rtc->pie_timer.function = rtc_pie_update_irq;
 	rtc->pie_enabled = 0;
 
+	set_bit(RTC_FEATURE_ALARM, rtc->features);
+
 	return rtc;
 }
 
@@ -386,6 +388,9 @@ int __devm_rtc_register_device(struct module *owner, struct rtc_device *rtc)
 		return -EINVAL;
 	}
 
+	if (!rtc->ops->set_alarm)
+		clear_bit(RTC_FEATURE_ALARM, rtc->features);
+
 	rtc->owner = owner;
 	rtc_device_get_offset(rtc);
 
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 794a4f036b99..dcb34c73319e 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -186,7 +186,7 @@ static int rtc_read_alarm_internal(struct rtc_device *rtc,
 
 	if (!rtc->ops) {
 		err = -ENODEV;
-	} else if (!rtc->ops->read_alarm) {
+	} else if (!test_bit(RTC_FEATURE_ALARM, rtc->features) || !rtc->ops->read_alarm) {
 		err = -EINVAL;
 	} else {
 		alarm->enabled = 0;
@@ -392,7 +392,7 @@ int rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 		return err;
 	if (!rtc->ops) {
 		err = -ENODEV;
-	} else if (!rtc->ops->read_alarm) {
+	} else if (!test_bit(RTC_FEATURE_ALARM, rtc->features) || !rtc->ops->read_alarm) {
 		err = -EINVAL;
 	} else {
 		memset(alarm, 0, sizeof(struct rtc_wkalrm));
@@ -436,7 +436,7 @@ static int __rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 
 	if (!rtc->ops)
 		err = -ENODEV;
-	else if (!rtc->ops->set_alarm)
+	else if (!test_bit(RTC_FEATURE_ALARM, rtc->features))
 		err = -EINVAL;
 	else
 		err = rtc->ops->set_alarm(rtc->dev.parent, alarm);
@@ -451,7 +451,7 @@ int rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 
 	if (!rtc->ops)
 		return -ENODEV;
-	else if (!rtc->ops->set_alarm)
+	else if (!test_bit(RTC_FEATURE_ALARM, rtc->features))
 		return -EINVAL;
 
 	err = rtc_valid_tm(&alarm->time);
@@ -531,7 +531,7 @@ int rtc_alarm_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 		/* nothing */;
 	else if (!rtc->ops)
 		err = -ENODEV;
-	else if (!rtc->ops->alarm_irq_enable)
+	else if (!test_bit(RTC_FEATURE_ALARM, rtc->features) || !rtc->ops->alarm_irq_enable)
 		err = -EINVAL;
 	else
 		err = rtc->ops->alarm_irq_enable(rtc->dev.parent, enabled);
@@ -843,7 +843,7 @@ static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer)
 
 static void rtc_alarm_disable(struct rtc_device *rtc)
 {
-	if (!rtc->ops || !rtc->ops->alarm_irq_enable)
+	if (!rtc->ops || !test_bit(RTC_FEATURE_ALARM, rtc->features) || !rtc->ops->alarm_irq_enable)
 		return;
 
 	rtc->ops->alarm_irq_enable(rtc->dev.parent, false);
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 568909449c13..bd611e26291d 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -141,6 +141,8 @@ struct rtc_device {
 	 */
 	unsigned long set_offset_nsec;
 
+	unsigned long features[BITS_TO_LONGS(RTC_FEATURE_CNT)];
+
 	time64_t range_min;
 	timeu64_t range_max;
 	time64_t start_secs;
diff --git a/include/uapi/linux/rtc.h b/include/uapi/linux/rtc.h
index fa9aff91cbf2..f950bff75e97 100644
--- a/include/uapi/linux/rtc.h
+++ b/include/uapi/linux/rtc.h
@@ -110,6 +110,11 @@ struct rtc_pll_info {
 #define RTC_AF 0x20	/* Alarm interrupt */
 #define RTC_UF 0x10	/* Update interrupt for 1Hz RTC */
 
+/* feature list */
+#define RTC_FEATURE_ALARM		0
+#define RTC_FEATURE_ALARM_RES_MINUTE	1
+#define RTC_FEATURE_NEED_WEEK_DAY	2
+#define RTC_FEATURE_CNT			3
 
 #define RTC_MAX_FREQ	8192
 
-- 
2.29.2

