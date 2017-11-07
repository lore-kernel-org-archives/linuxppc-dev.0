Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWZW82PVnzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 03:24:02 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] watchdog: mpc8xxx: use the core worker function
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-watchdog@vger.kernel.org
Message-Id: <20171107162356.55E106C399@po15668-vm-win7.idsi0.si.c-s.fr>
Date: Tue,  7 Nov 2017 17:23:56 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The watchdog core includes a worker function which pings the
watchdog until user app starts pinging it and which also
pings it if the HW require more frequent pings.
Use that function instead of the dedicated timer.
In the mean time, we can allow the user to change the timeout.

Then change the timeout module parameter to use seconds and
use the watchdog_init_timeout() core function.

On some HW (eg: the 8xx), SWCRR contains bits unrelated to the
watchdog which have to be preserved upon write.

This driver has nothing preventing the use of the magic close, so
enable it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/watchdog/mpc8xxx_wdt.c | 86 ++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 46 deletions(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 366e5c7e650b..c2ac4b6b1253 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -22,7 +22,6 @@
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/timer.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/module.h>
@@ -31,10 +30,13 @@
 #include <linux/uaccess.h>
 #include <sysdev/fsl_soc.h>
 
+#define WATCHDOG_TIMEOUT 10
+
 struct mpc8xxx_wdt {
 	__be32 res0;
 	__be32 swcrr; /* System watchdog control register */
 #define SWCRR_SWTC 0xFFFF0000 /* Software Watchdog Time Count. */
+#define SWCRR_SWF  0x00000008 /* Software Watchdog Freeze (mpc8xx). */
 #define SWCRR_SWEN 0x00000004 /* Watchdog Enable bit. */
 #define SWCRR_SWRI 0x00000002 /* Software Watchdog Reset/Interrupt Select bit.*/
 #define SWCRR_SWPR 0x00000001 /* Software Watchdog Counter Prescale bit. */
@@ -52,14 +54,15 @@ struct mpc8xxx_wdt_type {
 struct mpc8xxx_wdt_ddata {
 	struct mpc8xxx_wdt __iomem *base;
 	struct watchdog_device wdd;
-	struct timer_list timer;
 	spinlock_t lock;
+	int prescaler;
 };
 
-static u16 timeout = 0xffff;
+static u16 timeout;
 module_param(timeout, ushort, 0);
 MODULE_PARM_DESC(timeout,
-	"Watchdog timeout in ticks. (0<timeout<65536, default=65535)");
+	"Watchdog timeout in seconds. (1<timeout<65535, default="
+	__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
 
 static bool reset = 1;
 module_param(reset, bool, 0);
@@ -80,31 +83,35 @@ static void mpc8xxx_wdt_keepalive(struct mpc8xxx_wdt_ddata *ddata)
 	spin_unlock(&ddata->lock);
 }
 
-static void mpc8xxx_wdt_timer_ping(unsigned long arg)
-{
-	struct mpc8xxx_wdt_ddata *ddata = (void *)arg;
-
-	mpc8xxx_wdt_keepalive(ddata);
-	/* We're pinging it twice faster than needed, just to be sure. */
-	mod_timer(&ddata->timer, jiffies + HZ * ddata->wdd.timeout / 2);
-}
-
 static int mpc8xxx_wdt_start(struct watchdog_device *w)
 {
 	struct mpc8xxx_wdt_ddata *ddata =
 		container_of(w, struct mpc8xxx_wdt_ddata, wdd);
-
-	u32 tmp = SWCRR_SWEN | SWCRR_SWPR;
+	u32 tmp;
+	u32 timeout;
 
 	/* Good, fire up the show */
+	tmp = in_be32(&ddata->base->swcrr);
+	tmp &= ~(SWCRR_SWTC | SWCRR_SWF | SWCRR_SWEN | SWCRR_SWRI | SWCRR_SWPR);
+	tmp |= SWCRR_SWEN | SWCRR_SWPR;
+
 	if (reset)
 		tmp |= SWCRR_SWRI;
 
-	tmp |= timeout << 16;
+	timeout = ddata->wdd.timeout * fsl_get_sys_freq() / ddata->prescaler;
+	tmp |= min(timeout, 0xffffU) << 16;
 
 	out_be32(&ddata->base->swcrr, tmp);
 
-	del_timer_sync(&ddata->timer);
+	tmp = in_be32(&ddata->base->swcrr);
+	if (!(tmp & SWCRR_SWEN))
+		return -EOPNOTSUPP;
+
+	ddata->wdd.max_hw_heartbeat_ms = ((tmp >> 16) * ddata->prescaler) /
+					 (fsl_get_sys_freq() / 1000);
+	ddata->wdd.min_timeout = ddata->wdd.max_hw_heartbeat_ms / 1000;
+	if (ddata->wdd.timeout < ddata->wdd.min_timeout)
+		ddata->wdd.timeout = ddata->wdd.min_timeout;
 
 	return 0;
 }
@@ -118,17 +125,8 @@ static int mpc8xxx_wdt_ping(struct watchdog_device *w)
 	return 0;
 }
 
-static int mpc8xxx_wdt_stop(struct watchdog_device *w)
-{
-	struct mpc8xxx_wdt_ddata *ddata =
-		container_of(w, struct mpc8xxx_wdt_ddata, wdd);
-
-	mod_timer(&ddata->timer, jiffies);
-	return 0;
-}
-
 static struct watchdog_info mpc8xxx_wdt_info = {
-	.options = WDIOF_KEEPALIVEPING,
+	.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT,
 	.firmware_version = 1,
 	.identity = "MPC8xxx",
 };
@@ -137,7 +135,6 @@ static struct watchdog_ops mpc8xxx_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = mpc8xxx_wdt_start,
 	.ping = mpc8xxx_wdt_ping,
-	.stop = mpc8xxx_wdt_stop,
 };
 
 static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
@@ -148,7 +145,6 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	struct mpc8xxx_wdt_ddata *ddata;
 	u32 freq = fsl_get_sys_freq();
 	bool enabled;
-	unsigned int timeout_sec;
 
 	wdt_type = of_device_get_match_data(&ofdev->dev);
 	if (!wdt_type)
@@ -173,35 +169,34 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	}
 
 	spin_lock_init(&ddata->lock);
-	setup_timer(&ddata->timer, mpc8xxx_wdt_timer_ping,
-		    (unsigned long)ddata);
 
 	ddata->wdd.info = &mpc8xxx_wdt_info,
 	ddata->wdd.ops = &mpc8xxx_wdt_ops,
 
-	/* Calculate the timeout in seconds */
-	timeout_sec = (timeout * wdt_type->prescaler) / freq;
-
-	ddata->wdd.timeout = timeout_sec;
+	ddata->wdd.timeout = WATCHDOG_TIMEOUT;
+	watchdog_init_timeout(&ddata->wdd, timeout, &ofdev->dev);
+	ddata->prescaler = wdt_type->prescaler;
 
 	watchdog_set_nowayout(&ddata->wdd, nowayout);
 
+	/*
+	 * If the watchdog was previously enabled or we're running on
+	 * MPC8xxx, we should ping the wdt from the kernel until the
+	 * userspace handles it.
+	 */
+	if (enabled) {
+		mpc8xxx_wdt_start(&ddata->wdd);
+		set_bit(WDOG_HW_RUNNING, &ddata->wdd.status);
+	}
+
 	ret = watchdog_register_device(&ddata->wdd);
 	if (ret) {
 		pr_err("cannot register watchdog device (err=%d)\n", ret);
 		return ret;
 	}
 
-	pr_info("WDT driver for MPC8xxx initialized. mode:%s timeout=%d (%d seconds)\n",
-		reset ? "reset" : "interrupt", timeout, timeout_sec);
-
-	/*
-	 * If the watchdog was previously enabled or we're running on
-	 * MPC8xxx, we should ping the wdt from the kernel until the
-	 * userspace handles it.
-	 */
-	if (enabled)
-		mod_timer(&ddata->timer, jiffies);
+	pr_info("WDT driver for MPC8xxx initialized. mode:%s timeout=%d sec\n",
+		reset ? "reset" : "interrupt", ddata->wdd.timeout);
 
 	platform_set_drvdata(ofdev, ddata);
 	return 0;
@@ -213,7 +208,6 @@ static int mpc8xxx_wdt_remove(struct platform_device *ofdev)
 
 	pr_crit("Watchdog removed, expect the %s soon!\n",
 		reset ? "reset" : "machine check exception");
-	del_timer_sync(&ddata->timer);
 	watchdog_unregister_device(&ddata->wdd);
 
 	return 0;
-- 
2.13.3
