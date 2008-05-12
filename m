Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 2182FDDF71
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 04:52:09 +1000 (EST)
Date: Mon, 12 May 2008 22:52:06 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 1/3] [WATCHDOG] mpc83xx_wdt: add support for MPC86xx CPUs
Message-ID: <20080512185206.GA25818@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
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
 drivers/watchdog/mpc83xx_wdt.c |   63 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 59 insertions(+), 8 deletions(-)

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
index b16c5cd..14492a7 100644
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
@@ -22,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/watchdog.h>
+#include <linux/timer.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
@@ -48,6 +51,11 @@ static int reset = 1;
 module_param(reset, bool, 0);
 MODULE_PARM_DESC(reset, "Watchdog Interrupt/Reset Mode. 0 = interrupt, 1 = reset");
 
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
+		 "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
 /*
  * We always prescale, but if someone really doesn't want to they can set this
  * to 0
@@ -67,6 +75,22 @@ static void mpc83xx_wdt_keepalive(void)
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
@@ -82,7 +106,8 @@ static int mpc83xx_wdt_open(struct inode *inode, struct file *file)
 		return -EBUSY;
 
 	/* Once we start the watchdog we can't stop it */
-	__module_get(THIS_MODULE);
+	if (nowayout)
+		__module_get(THIS_MODULE);
 
 	/* Good, fire up the show */
 	if (prescale)
@@ -94,13 +119,17 @@ static int mpc83xx_wdt_open(struct inode *inode, struct file *file)
 
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
@@ -152,6 +181,7 @@ static int __devinit mpc83xx_wdt_probe(struct platform_device *dev)
 	struct resource *r;
 	int ret;
 	unsigned int *freq = dev->dev.platform_data;
+	bool enabled;
 
 	/* get a pointer to the register memory */
 	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
@@ -168,6 +198,15 @@ static int __devinit mpc83xx_wdt_probe(struct platform_device *dev)
 		goto err_out;
 	}
 
+	enabled = in_be32(&wd_base->swcrr) & SWCRR_SWEN;
+#ifdef CONFIG_PPC_86xx
+	if (!enabled) {
+		dev_info(&dev->dev, "could not be enabled by software\n");
+		ret = -ENOSYS;
+		goto err_unmap;
+	}
+#endif
+
 	ret = misc_register(&mpc83xx_wdt_miscdev);
 	if (ret) {
 		printk(KERN_ERR "cannot register miscdev on minor=%d "
@@ -185,6 +224,15 @@ static int __devinit mpc83xx_wdt_probe(struct platform_device *dev)
 	printk(KERN_INFO "WDT driver for MPC83xx initialized. "
 		"mode:%s timeout=%d (%d seconds)\n",
 		reset ? "reset":"interrupt", timeout, timeout_sec);
+
+	/*
+	 * If the watchdog was previously enabled or we're running on
+	 * MPC86xx, we should ping the wdt from the kernel until the
+	 * userspace handles it.
+	 */
+	if (enabled)
+		mpc83xx_wdt_timer_ping(0);
+
 	return 0;
 
 err_unmap:
@@ -217,14 +265,17 @@ static int __init mpc83xx_wdt_init(void)
 
 static void __exit mpc83xx_wdt_exit(void)
 {
+	/* might happen only on !nowayout */
+	mpc83xx_wdt_pr_warn("module removed");
+	del_timer_sync(&wdt_timer);
 	platform_driver_unregister(&mpc83xx_wdt_driver);
 }
 
-module_init(mpc83xx_wdt_init);
+subsys_initcall(mpc83xx_wdt_init);
 module_exit(mpc83xx_wdt_exit);
 
 MODULE_AUTHOR("Dave Updegraff, Kumar Gala");
-MODULE_DESCRIPTION("Driver for watchdog timer in MPC83xx uProcessor");
+MODULE_DESCRIPTION("Driver for watchdog timer in MPC83xx/MPC86xx uProcessor");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
 MODULE_ALIAS("platform:mpc83xx_wdt");
-- 
1.5.5.1
