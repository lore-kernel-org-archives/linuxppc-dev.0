Return-Path: <SRS0=Om5s=GN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0196AC433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 23:33:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82697229C4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 23:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82697229C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DDY6g4H1LzDqSG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Jan 2021 10:32:59 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DDXnq74ZSzDqM0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2021 10:18:23 +1100 (AEDT)
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr
 [86.202.109.140])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 47308FF80B;
 Sun, 10 Jan 2021 23:18:20 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 09/17] rtc: rx8010: drop a struct rtc_class_ops
Date: Mon, 11 Jan 2021 00:17:44 +0100
Message-Id: <20210110231752.1418816-10-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-rx8010.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 8340ab47a059..1a05e4654290 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -354,13 +354,7 @@ static int rx8010_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 	}
 }
 
-static const struct rtc_class_ops rx8010_rtc_ops_default = {
-	.read_time = rx8010_get_time,
-	.set_time = rx8010_set_time,
-	.ioctl = rx8010_ioctl,
-};
-
-static const struct rtc_class_ops rx8010_rtc_ops_alarm = {
+static const struct rtc_class_ops rx8010_rtc_ops = {
 	.read_time = rx8010_get_time,
 	.set_time = rx8010_set_time,
 	.ioctl = rx8010_ioctl,
@@ -409,12 +403,11 @@ static int rx8010_probe(struct i2c_client *client)
 			dev_err(dev, "unable to request IRQ\n");
 			return err;
 		}
-
-		rx8010->rtc->ops = &rx8010_rtc_ops_alarm;
 	} else {
-		rx8010->rtc->ops = &rx8010_rtc_ops_default;
+		clear_bit(RTC_FEATURE_ALARM, rx8010->rtc->features);
 	}
 
+	rx8010->rtc->ops = &rx8010_rtc_ops;
 	rx8010->rtc->max_user_freq = 1;
 	rx8010->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	rx8010->rtc->range_max = RTC_TIMESTAMP_END_2099;
-- 
2.29.2

