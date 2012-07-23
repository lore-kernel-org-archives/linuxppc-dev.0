Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 36B402C0405
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 19:14:19 +1000 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <rob.herring@calxeda.com>, Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 17/25] watchdog/mpc8xxx: add a const qualifier
Date: Mon, 23 Jul 2012 11:13:22 +0200
Message-Id: <1343034810-3386-18-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de, linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd@arndb.de>

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/watchdog/mpc8xxx_wdt.c: In function 'mpc8xxx_wdt_probe':
	drivers/watchdog/mpc8xxx_wdt.c:203:11: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[ukl: split Arnd's patch by driver and add changelog]
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/mpc8xxx_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 40f7bf1..e6a038a 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -193,7 +193,7 @@ static int __devinit mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	int ret;
 	const struct of_device_id *match;
 	struct device_node *np = ofdev->dev.of_node;
-	struct mpc8xxx_wdt_type *wdt_type;
+	const struct mpc8xxx_wdt_type *wdt_type;
 	u32 freq = fsl_get_sys_freq();
 	bool enabled;
 
-- 
1.7.10.4
