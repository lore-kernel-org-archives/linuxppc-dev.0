Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 13DAADE20D
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 00:15:07 +1000 (EST)
Date: Tue, 13 May 2008 18:15:02 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4/6] [WATCHDOG] mpc8xxx_wdt: various renames, mostly
	s/mpc83xx/mpc8xxx/g
Message-ID: <20080513141502.GD15717@polina.dev.rtsoft.ru>
References: <20080513141411.GA8981@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080513141411.GA8981@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mpc83xx_wdt.c renamed to mpc8xxx_wdt.c, now we can do various renames
in the file itself.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/watchdog/mpc8xxx_wdt.c |  100 ++++++++++++++++++++--------------------
 1 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 3534ae0..b582441 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -1,5 +1,5 @@
 /*
- * mpc83xx_wdt.c - MPC83xx/MPC86xx watchdog userspace interface
+ * mpc8xxx_wdt.c - MPC8xxx watchdog userspace interface
  *
  * Authors: Dave Updegraff <dave@cray.org>
  * 	    Kumar Gala <galak@kernel.crashing.org>
@@ -29,7 +29,7 @@
 #include <asm/uaccess.h>
 #include <sysdev/fsl_soc.h>
 
-struct mpc83xx_wdt {
+struct mpc8xxx_wdt {
 	__be32 res0;
 	__be32 swcrr; /* System watchdog control register */
 #define SWCRR_SWTC 0xFFFF0000 /* Software Watchdog Time Count. */
@@ -42,7 +42,7 @@ struct mpc83xx_wdt {
 	u8 res2[0xF0];
 };
 
-static struct mpc83xx_wdt __iomem *wd_base;
+static struct mpc8xxx_wdt __iomem *wd_base;
 
 static u16 timeout = 0xffff;
 module_param(timeout, ushort, 0);
@@ -67,7 +67,7 @@ static unsigned int timeout_sec;
 static unsigned long wdt_is_open;
 static DEFINE_SPINLOCK(wdt_spinlock);
 
-static void mpc83xx_wdt_keepalive(void)
+static void mpc8xxx_wdt_keepalive(void)
 {
 	/* Ping the WDT */
 	spin_lock(&wdt_spinlock);
@@ -76,31 +76,31 @@ static void mpc83xx_wdt_keepalive(void)
 	spin_unlock(&wdt_spinlock);
 }
 
-static void mpc83xx_wdt_timer_ping(unsigned long arg);
-static DEFINE_TIMER(wdt_timer, mpc83xx_wdt_timer_ping, 0, 0);
+static void mpc8xxx_wdt_timer_ping(unsigned long arg);
+static DEFINE_TIMER(wdt_timer, mpc8xxx_wdt_timer_ping, 0, 0);
 
-static void mpc83xx_wdt_timer_ping(unsigned long arg)
+static void mpc8xxx_wdt_timer_ping(unsigned long arg)
 {
-	mpc83xx_wdt_keepalive();
+	mpc8xxx_wdt_keepalive();
 	/* We're pinging it twice faster than needed, just to be sure. */
 	mod_timer(&wdt_timer, jiffies + HZ * timeout_sec / 2);
 }
 
-static void mpc83xx_wdt_pr_warn(const char *msg)
+static void mpc8xxx_wdt_pr_warn(const char *msg)
 {
-	pr_crit("mpc83xx_wdt: %s, expect the %s soon!\n", msg,
+	pr_crit("mpc8xxx_wdt: %s, expect the %s soon!\n", msg,
 		reset ? "reset" : "machine check exception");
 }
 
-static ssize_t mpc83xx_wdt_write(struct file *file, const char __user *buf,
+static ssize_t mpc8xxx_wdt_write(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 {
 	if (count)
-		mpc83xx_wdt_keepalive();
+		mpc8xxx_wdt_keepalive();
 	return count;
 }
 
-static int mpc83xx_wdt_open(struct inode *inode, struct file *file)
+static int mpc8xxx_wdt_open(struct inode *inode, struct file *file)
 {
 	u32 tmp = SWCRR_SWEN;
 	if (test_and_set_bit(0, &wdt_is_open))
@@ -125,17 +125,17 @@ static int mpc83xx_wdt_open(struct inode *inode, struct file *file)
 	return nonseekable_open(inode, file);
 }
 
-static int mpc83xx_wdt_release(struct inode *inode, struct file *file)
+static int mpc8xxx_wdt_release(struct inode *inode, struct file *file)
 {
 	if (!nowayout)
-		mpc83xx_wdt_timer_ping(0);
+		mpc8xxx_wdt_timer_ping(0);
 	else
-		mpc83xx_wdt_pr_warn("watchdog closed");
+		mpc8xxx_wdt_pr_warn("watchdog closed");
 	clear_bit(0, &wdt_is_open);
 	return 0;
 }
 
-static int mpc83xx_wdt_ioctl(struct inode *inode, struct file *file,
+static int mpc8xxx_wdt_ioctl(struct inode *inode, struct file *file,
 				unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
@@ -143,7 +143,7 @@ static int mpc83xx_wdt_ioctl(struct inode *inode, struct file *file,
 	static struct watchdog_info ident = {
 		.options = WDIOF_KEEPALIVEPING,
 		.firmware_version = 1,
-		.identity = "MPC83xx",
+		.identity = "MPC8xxx",
 	};
 
 	switch (cmd) {
@@ -153,7 +153,7 @@ static int mpc83xx_wdt_ioctl(struct inode *inode, struct file *file,
 	case WDIOC_GETBOOTSTATUS:
 		return put_user(0, p);
 	case WDIOC_KEEPALIVE:
-		mpc83xx_wdt_keepalive();
+		mpc8xxx_wdt_keepalive();
 		return 0;
 	case WDIOC_GETTIMEOUT:
 		return put_user(timeout_sec, p);
@@ -162,22 +162,22 @@ static int mpc83xx_wdt_ioctl(struct inode *inode, struct file *file,
 	}
 }
 
-static const struct file_operations mpc83xx_wdt_fops = {
+static const struct file_operations mpc8xxx_wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= mpc83xx_wdt_write,
-	.ioctl		= mpc83xx_wdt_ioctl,
-	.open		= mpc83xx_wdt_open,
-	.release	= mpc83xx_wdt_release,
+	.write		= mpc8xxx_wdt_write,
+	.ioctl		= mpc8xxx_wdt_ioctl,
+	.open		= mpc8xxx_wdt_open,
+	.release	= mpc8xxx_wdt_release,
 };
 
-static struct miscdevice mpc83xx_wdt_miscdev = {
+static struct miscdevice mpc8xxx_wdt_miscdev = {
 	.minor	= WATCHDOG_MINOR,
 	.name	= "watchdog",
-	.fops	= &mpc83xx_wdt_fops,
+	.fops	= &mpc8xxx_wdt_fops,
 };
 
-static int __devinit mpc83xx_wdt_probe(struct of_device *ofdev,
+static int __devinit mpc8xxx_wdt_probe(struct of_device *ofdev,
 				       const struct of_device_id *match)
 {
 	int ret;
@@ -194,12 +194,12 @@ static int __devinit mpc83xx_wdt_probe(struct of_device *ofdev,
 
 	enabled = in_be32(&wd_base->swcrr) & SWCRR_SWEN;
 	if (!enabled && of_device_is_compatible(np, "fsl,mpc8610-wdt")) {
-		pr_info("mpc83xx_wdt: could not be enabled in software\n");
+		pr_info("mpc8xxx_wdt: could not be enabled in software\n");
 		ret = -ENOSYS;
 		goto err_unmap;
 	}
 
-	ret = misc_register(&mpc83xx_wdt_miscdev);
+	ret = misc_register(&mpc8xxx_wdt_miscdev);
 	if (ret) {
 		pr_err("cannot register miscdev on minor=%d (err=%d)\n",
 			WATCHDOG_MINOR, ret);
@@ -212,62 +212,62 @@ static int __devinit mpc83xx_wdt_probe(struct of_device *ofdev,
 	else
 		timeout_sec = timeout / freq;
 
-	pr_info("WDT driver for MPC83xx initialized. mode:%s timeout=%d "
+	pr_info("WDT driver for MPC8xxx initialized. mode:%s timeout=%d "
 		"(%d seconds)\n", reset ? "reset" : "interrupt", timeout,
 		timeout_sec);
 
 	/*
 	 * If the watchdog was previously enabled or we're running on
-	 * MPC86xx, we should ping the wdt from the kernel until the
+	 * MPC8xxx, we should ping the wdt from the kernel until the
 	 * userspace handles it.
 	 */
 	if (enabled)
-		mpc83xx_wdt_timer_ping(0);
+		mpc8xxx_wdt_timer_ping(0);
 	return 0;
 err_unmap:
 	iounmap(wd_base);
 	return ret;
 }
 
-static int __devexit mpc83xx_wdt_remove(struct of_device *ofdev)
+static int __devexit mpc8xxx_wdt_remove(struct of_device *ofdev)
 {
-	mpc83xx_wdt_pr_warn("watchdog removed");
+	mpc8xxx_wdt_pr_warn("watchdog removed");
 	del_timer_sync(&wdt_timer);
-	misc_deregister(&mpc83xx_wdt_miscdev);
+	misc_deregister(&mpc8xxx_wdt_miscdev);
 	iounmap(wd_base);
 
 	return 0;
 }
 
-static const struct of_device_id mpc83xx_wdt_match[] = {
+static const struct of_device_id mpc8xxx_wdt_match[] = {
 	{ .compatible = "mpc83xx_wdt", },
 	{ .compatible = "fsl,mpc8610-wdt", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, mpc83xx_wdt_match);
+MODULE_DEVICE_TABLE(of, mpc8xxx_wdt_match);
 
-static struct of_platform_driver mpc83xx_wdt_driver = {
-	.name		= "mpc83xx_wdt",
-	.match_table	= mpc83xx_wdt_match,
-	.probe		= mpc83xx_wdt_probe,
-	.remove		= __devexit_p(mpc83xx_wdt_remove),
+static struct of_platform_driver mpc8xxx_wdt_driver = {
+	.name		= "mpc8xxx_wdt",
+	.match_table	= mpc8xxx_wdt_match,
+	.probe		= mpc8xxx_wdt_probe,
+	.remove		= __devexit_p(mpc8xxx_wdt_remove),
 };
 
-static int __init mpc83xx_wdt_init(void)
+static int __init mpc8xxx_wdt_init(void)
 {
-	return of_register_platform_driver(&mpc83xx_wdt_driver);
+	return of_register_platform_driver(&mpc8xxx_wdt_driver);
 }
 
-static void __exit mpc83xx_wdt_exit(void)
+static void __exit mpc8xxx_wdt_exit(void)
 {
-	of_unregister_platform_driver(&mpc83xx_wdt_driver);
+	of_unregister_platform_driver(&mpc8xxx_wdt_driver);
 }
 
-subsys_initcall(mpc83xx_wdt_init);
-module_exit(mpc83xx_wdt_exit);
+subsys_initcall(mpc8xxx_wdt_init);
+module_exit(mpc8xxx_wdt_exit);
 
 MODULE_AUTHOR("Dave Updegraff, Kumar Gala");
-MODULE_DESCRIPTION("Driver for watchdog timer in MPC83xx/MPC86xx uProcessor");
+MODULE_DESCRIPTION("Driver for watchdog timer in MPC8xxx uProcessor");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-MODULE_ALIAS("platform:mpc83xx_wdt");
+MODULE_ALIAS("platform:mpc8xxx_wdt");
-- 
1.5.5.1
