Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3F7C6DE33E
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 03:38:42 +1000 (EST)
Date: Mon, 2 Jun 2008 21:38:40 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 3/8] [WATCHDOG] mpc83xx_wdt: add support for MPC86xx CPUs
Message-ID: <20080602173840.GC30705@polina.dev.rtsoft.ru>
References: <20080602173726.GA24556@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080602173726.GA24556@polina.dev.rtsoft.ru>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On MPC86xx the watchdog could be enabled only at power-on-reset, and
could not be disabled afterwards. We must ping the watchdog from the
kernel until the userspace handles it.

MPC83xx CPUs are only differ in a way that watchdog could be disabled
once, but after it was enabled via software it becomes just the same
as MPC86xx.

Thus, to support MPC86xx I added the kernel timer which pings the
watchdog until the userspace opens it.

Since we implemented the timer, now we're able to implement proper
handling for the CONFIG_WATCHDOG_NOWAYOUT case, for MPC83xx and MPC86xx.

Also move the probe code into subsys_initcall, because we want start
pinging the watchdog ASAP, and misc devices are available in
subsys_initcall.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/watchdog/Kconfig       |    4 +-
 drivers/watchdog/mpc83xx_wdt.c |   80 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 254d115..2929055 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -683,8 +683,8 @@ config 8xx_WDT
 	depends on 8xx
 
 config 83xx_WDT
-	tristate "MPC83xx Watchdog Timer"
-	depends on PPC_83xx
+	tristate "MPC83xx/MPC86xx Watchdog Timer"
+	depends on PPC_83xx || PPC_86xx
 
 config MV64X60_WDT
 	tristate "MV64X60 (Marvell Discovery) Watchdog Timer"
diff --git a/drivers/watchdog/mpc83xx_wdt.c b/drivers/watchdog/mpc83xx_wdt.c
index 127d85e..19e3082 100644
--- a/drivers/watchdog/mpc83xx_wdt.c
+++ b/drivers/watchdog/mpc83xx_wdt.c
@@ -1,10 +1,12 @@
 /*
- * mpc83xx_wdt.c - MPC83xx watchdog userspace interface
+ * mpc83xx_wdt.c - MPC83xx/MPC86xx watchdog userspace interface
  *
  * Authors: Dave Updegraff <dave@cray.org>
  * 	    Kumar Gala <galak@kernel.crashing.org>
  * 		Attribution: from 83xx_wst: Florian Schirmer <jolt@tuxbox.org>
  * 				..and from sc520_wdt
+ * Copyright (c) 2008  MontaVista Software, Inc.
+ *                     Anton Vorontsov <avorontsov@ru.mvista.com>
  *
  * Note: it appears that you can only actually ENABLE or DISABLE the thing
  * once after POR. Once enabled, you cannot disable, and vice versa.
@@ -18,6 +20,7 @@
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/timer.h>
 #include <linux/miscdevice.h>
 #include <linux/of_platform.h>
 #include <linux/module.h>
@@ -39,6 +42,11 @@ struct mpc83xx_wdt {
 	u8 res2[0xF0];
 };
 
+struct mpc83xx_wdt_type {
+	int prescaler;
+	bool hw_enabled;
+};
+
 static struct mpc83xx_wdt __iomem *wd_base;
 
 static u16 timeout = 0xffff;
@@ -51,6 +59,11 @@ module_param(reset, bool, 0);
 MODULE_PARM_DESC(reset, "Watchdog Interrupt/Reset Mode. "
 		 "0 = interrupt, 1 = reset");
 
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
+		 "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
 /*
  * We always prescale, but if someone really doesn't want to they can set this
  * to 0
@@ -70,6 +83,22 @@ static void mpc83xx_wdt_keepalive(void)
 	spin_unlock(&wdt_spinlock);
 }
 
+static void mpc83xx_wdt_timer_ping(unsigned long arg);
+static DEFINE_TIMER(wdt_timer, mpc83xx_wdt_timer_ping, 0, 0);
+
+static void mpc83xx_wdt_timer_ping(unsigned long arg)
+{
+	mpc83xx_wdt_keepalive();
+	/* We're pinging it twice faster than needed, just to be sure. */
+	mod_timer(&wdt_timer, jiffies + HZ * timeout_sec / 2);
+}
+
+static void mpc83xx_wdt_pr_warn(const char *msg)
+{
+	pr_crit("mpc83xx_wdt: %s, expect the %s soon!\n", msg,
+		reset ? "reset" : "machine check exception");
+}
+
 static ssize_t mpc83xx_wdt_write(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 {
@@ -85,7 +114,8 @@ static int mpc83xx_wdt_open(struct inode *inode, struct file *file)
 		return -EBUSY;
 
 	/* Once we start the watchdog we can't stop it */
-	__module_get(THIS_MODULE);
+	if (nowayout)
+		__module_get(THIS_MODULE);
 
 	/* Good, fire up the show */
 	if (prescale)
@@ -97,13 +127,17 @@ static int mpc83xx_wdt_open(struct inode *inode, struct file *file)
 
 	out_be32(&wd_base->swcrr, tmp);
 
+	del_timer_sync(&wdt_timer);
+
 	return nonseekable_open(inode, file);
 }
 
 static int mpc83xx_wdt_release(struct inode *inode, struct file *file)
 {
-	printk(KERN_CRIT "Unexpected close, not stopping watchdog!\n");
-	mpc83xx_wdt_keepalive();
+	if (!nowayout)
+		mpc83xx_wdt_timer_ping(0);
+	else
+		mpc83xx_wdt_pr_warn("watchdog closed");
 	clear_bit(0, &wdt_is_open);
 	return 0;
 }
@@ -154,15 +188,25 @@ static int __devinit mpc83xx_wdt_probe(struct of_device *ofdev,
 				       const struct of_device_id *match)
 {
 	int ret;
+	struct device_node *np = ofdev->node;
+	struct mpc83xx_wdt_type *wdt_type = match->data;
 	u32 freq = fsl_get_sys_freq();
+	bool enabled;
 
 	if (!freq || freq == -1)
 		return -EINVAL;
 
-	wd_base = of_iomap(ofdev->node, 0);
+	wd_base = of_iomap(np, 0);
 	if (!wd_base)
 		return -ENOMEM;
 
+	enabled = in_be32(&wd_base->swcrr) & SWCRR_SWEN;
+	if (!enabled && wdt_type->hw_enabled) {
+		pr_info("mpc83xx_wdt: could not be enabled in software\n");
+		ret = -ENOSYS;
+		goto err_unmap;
+	}
+
 	ret = misc_register(&mpc83xx_wdt_miscdev);
 	if (ret) {
 		pr_err("cannot register miscdev on minor=%d (err=%d)\n",
@@ -172,13 +216,21 @@ static int __devinit mpc83xx_wdt_probe(struct of_device *ofdev,
 
 	/* Calculate the timeout in seconds */
 	if (prescale)
-		timeout_sec = (timeout * 0x10000) / freq;
+		timeout_sec = (timeout * wdt_type->prescaler) / freq;
 	else
 		timeout_sec = timeout / freq;
 
 	pr_info("WDT driver for MPC83xx initialized. mode:%s timeout=%d "
 		"(%d seconds)\n", reset ? "reset" : "interrupt", timeout,
 		timeout_sec);
+
+	/*
+	 * If the watchdog was previously enabled or we're running on
+	 * MPC86xx, we should ping the wdt from the kernel until the
+	 * userspace handles it.
+	 */
+	if (enabled)
+		mpc83xx_wdt_timer_ping(0);
 	return 0;
 err_unmap:
 	iounmap(wd_base);
@@ -187,6 +239,8 @@ err_unmap:
 
 static int __devexit mpc83xx_wdt_remove(struct of_device *ofdev)
 {
+	mpc83xx_wdt_pr_warn("watchdog removed");
+	del_timer_sync(&wdt_timer);
 	misc_deregister(&mpc83xx_wdt_miscdev);
 	iounmap(wd_base);
 
@@ -196,6 +250,16 @@ static int __devexit mpc83xx_wdt_remove(struct of_device *ofdev)
 static const struct of_device_id mpc83xx_wdt_match[] = {
 	{
 		.compatible = "mpc83xx_wdt",
+		.data = &(struct mpc83xx_wdt_type) {
+			.prescaler = 0x10000,
+		},
+	},
+	{
+		.compatible = "fsl,mpc8610-wdt",
+		.data = &(struct mpc83xx_wdt_type) {
+			.prescaler = 0x10000,
+			.hw_enabled = true,
+		},
 	},
 	{},
 };
@@ -221,10 +285,10 @@ static void __exit mpc83xx_wdt_exit(void)
 	of_unregister_platform_driver(&mpc83xx_wdt_driver);
 }
 
-module_init(mpc83xx_wdt_init);
+subsys_initcall(mpc83xx_wdt_init);
 module_exit(mpc83xx_wdt_exit);
 
 MODULE_AUTHOR("Dave Updegraff, Kumar Gala");
-MODULE_DESCRIPTION("Driver for watchdog timer in MPC83xx uProcessor");
+MODULE_DESCRIPTION("Driver for watchdog timer in MPC83xx/MPC86xx uProcessors");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-- 
1.5.5.1
