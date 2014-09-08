Return-Path: <p.zabel@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C8151A073D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Sep 2014 19:19:46 +1000 (EST)
From: Philipp Zabel <p.zabel@pengutronix.de>
To: devicetree@vger.kernel.org
Subject: [PATCH v2 4/5] rtc: rtc-isl12022: Change vendor prefix for Intersil
 Corporation to isil
Date: Mon,  8 Sep 2014 11:19:19 +0200
Message-Id: <1410167960-554-5-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1410167960-554-1-git-send-email-p.zabel@pengutronix.de>
References: <1410167960-554-1-git-send-email-p.zabel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alessandro Zummo <a.zummo@towertech.it>, Russell King <linux@arm.linux.org.uk>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently there is a wild mixture of isl, isil, and intersil compatibles
in the kernel. At this point, changing the vendor symbol to the most often
used variant, which is equal to the NASDAQ symbol, isil, should not hurt.

Patch db04d6284e2a (drivers/rtc/rtc-isl12022.c: device tree support)
added device tree support using the then documented isl vendor prefix,
so we keep that around for backwards compatibility.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/rtc/rtc-isl12022.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index aa55f08..df20f18 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -275,7 +275,8 @@ static int isl12022_probe(struct i2c_client *client,
 
 #ifdef CONFIG_OF
 static struct of_device_id isl12022_dt_match[] = {
-	{ .compatible = "isl,isl12022" },
+	{ .compatible = "isil,isl12022" },
+	{ .compatible = "isl,isl12022" }, /* for backwards compatibility */
 	{ },
 };
 #endif
-- 
2.1.0.rc1
