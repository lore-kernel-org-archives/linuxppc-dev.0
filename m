Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02387C433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Oct 2021 22:47:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547D660C4B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Oct 2021 22:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 547D660C4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfkN35spsz3bvH
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Oct 2021 09:47:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=luna.linkmauve.fr;
 envelope-from=linkmauve@linkmauve.fr; receiver=<UNKNOWN>)
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net
 [82.65.109.163])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfkLJ1c7Cz3bbv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Oct 2021 09:45:44 +1100 (AEDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
 id 0C0E3F40CA3; Thu, 28 Oct 2021 00:35:23 +0200 (CEST)
From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alessandro Zummo <a.zummo@towertech.it>
Subject: [PATCH v2 2/5] rtc: gamecube: Report low battery as invalid data
Date: Thu, 28 Oct 2021 00:35:12 +0200
Message-Id: <20211027223516.2031-3-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211027223516.2031-1-linkmauve@linkmauve.fr>
References: <20211014220524.9988-1-linkmauve@linkmauve.fr>
 <20211027223516.2031-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, linux-kernel@vger.kernel.org,
 rw-r-r-0644 <r.r.qwertyuiop.r.r@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Ash Logan <ash@heyquark.com>,
 linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I haven’t been able to test this patch as all of my consoles have a
working RTC battery, but according to the documentation it should work
like that.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 drivers/rtc/rtc-gamecube.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
index e8260c82c07d..1932c6fe1301 100644
--- a/drivers/rtc/rtc-gamecube.c
+++ b/drivers/rtc/rtc-gamecube.c
@@ -83,6 +83,10 @@
 #define RTC_CONTROL0	0x21000c
 #define RTC_CONTROL1	0x21000d
 
+/* RTC flags */
+#define RTC_CONTROL0_UNSTABLE_POWER	0x00000800
+#define RTC_CONTROL0_LOW_BATTERY	0x00000200
+
 struct priv {
 	struct regmap *regmap;
 	void __iomem *iob;
@@ -182,9 +186,35 @@ static int gamecube_rtc_set_time(struct device *dev, struct rtc_time *t)
 	return regmap_write(d->regmap, RTC_COUNTER, timestamp - d->rtc_bias);
 }
 
+static int gamecube_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct priv *d = dev_get_drvdata(dev);
+	int value;
+	int control0;
+	int ret;
+
+	switch (cmd) {
+	case RTC_VL_READ:
+		ret = regmap_read(d->regmap, RTC_CONTROL0, &control0);
+		if (ret)
+			return ret;
+
+		value = 0;
+		if (control0 & RTC_CONTROL0_UNSTABLE_POWER)
+			value |= RTC_VL_DATA_INVALID;
+		if (control0 & RTC_CONTROL0_LOW_BATTERY)
+			value |= RTC_VL_DATA_INVALID;
+		return put_user(value, (unsigned int __user *)arg);
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
 static const struct rtc_class_ops gamecube_rtc_ops = {
 	.read_time	= gamecube_rtc_read_time,
 	.set_time	= gamecube_rtc_set_time,
+	.ioctl		= gamecube_rtc_ioctl,
 };
 
 static int gamecube_rtc_read_offset_from_sram(struct priv *d)
-- 
2.33.1

