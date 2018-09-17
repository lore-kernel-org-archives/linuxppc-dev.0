Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DGJc6KM2zF12b
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 16:22:56 +1000 (AEST)
Message-Id: <c09f541d459c29aca40d54fff152d5645e24b50d.1537163776.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 1/3] watchdog: mpc8xxx: use dev_xxxx() instead of pr_xxxx()
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Radu Rendec <radu.rendec@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Date: Mon, 17 Sep 2018 06:22:47 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpc8xxx watchdog driver is a platform device drivers, it is
therefore possible to use dev_xxx() messaging rather than pr_xxx()

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/watchdog/mpc8xxx_wdt.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index aca2d6323f8a..1dcf5f10cdd9 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -17,8 +17,6 @@
  * option) any later version.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -137,26 +135,27 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	struct mpc8xxx_wdt_ddata *ddata;
 	u32 freq = fsl_get_sys_freq();
 	bool enabled;
+	struct device *dev = &ofdev->dev;
 
-	wdt_type = of_device_get_match_data(&ofdev->dev);
+	wdt_type = of_device_get_match_data(dev);
 	if (!wdt_type)
 		return -EINVAL;
 
 	if (!freq || freq == -1)
 		return -EINVAL;
 
-	ddata = devm_kzalloc(&ofdev->dev, sizeof(*ddata), GFP_KERNEL);
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
 
 	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-	ddata->base = devm_ioremap_resource(&ofdev->dev, res);
+	ddata->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ddata->base))
 		return PTR_ERR(ddata->base);
 
 	enabled = in_be32(&ddata->base->swcrr) & SWCRR_SWEN;
 	if (!enabled && wdt_type->hw_enabled) {
-		pr_info("could not be enabled in software\n");
+		dev_info(dev, "could not be enabled in software\n");
 		return -ENODEV;
 	}
 
@@ -166,7 +165,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	ddata->wdd.ops = &mpc8xxx_wdt_ops,
 
 	ddata->wdd.timeout = WATCHDOG_TIMEOUT;
-	watchdog_init_timeout(&ddata->wdd, timeout, &ofdev->dev);
+	watchdog_init_timeout(&ddata->wdd, timeout, dev);
 
 	watchdog_set_nowayout(&ddata->wdd, nowayout);
 
@@ -189,12 +188,13 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 
 	ret = watchdog_register_device(&ddata->wdd);
 	if (ret) {
-		pr_err("cannot register watchdog device (err=%d)\n", ret);
+		dev_err(dev, "cannot register watchdog device (err=%d)\n", ret);
 		return ret;
 	}
 
-	pr_info("WDT driver for MPC8xxx initialized. mode:%s timeout=%d sec\n",
-		reset ? "reset" : "interrupt", ddata->wdd.timeout);
+	dev_info(dev,
+		 "WDT driver for MPC8xxx initialized. mode:%s timeout=%d sec\n",
+		 reset ? "reset" : "interrupt", ddata->wdd.timeout);
 
 	platform_set_drvdata(ofdev, ddata);
 	return 0;
@@ -204,8 +204,8 @@ static int mpc8xxx_wdt_remove(struct platform_device *ofdev)
 {
 	struct mpc8xxx_wdt_ddata *ddata = platform_get_drvdata(ofdev);
 
-	pr_crit("Watchdog removed, expect the %s soon!\n",
-		reset ? "reset" : "machine check exception");
+	dev_crit(&ofdev->dev, "Watchdog removed, expect the %s soon!\n",
+		 reset ? "reset" : "machine check exception");
 	watchdog_unregister_device(&ddata->wdd);
 
 	return 0;
-- 
2.13.3
