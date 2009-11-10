Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id 87BCAB831B
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 09:10:19 +1100 (EST)
Date: Tue, 10 Nov 2009 20:43:00 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [PATCH 3/3] mpc52xx/wdt: WDT uses GPT api
To: Linux PPC Development <linuxppc-dev@ozlabs.org>, Grant Likely
	<grant.likely@secretlab.ca>, devicetree-discuss@lists.ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>
Message-Id: <1257882180.14374.3@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the MPC5200 GPT api for the WDT which drastically simplifies this file.

Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
---

 drivers/watchdog/mpc5200_wdt.c |  246 +++++++++++-------------------------=
----
 1 files changed, 65 insertions(+), 181 deletions(-)

diff --git a/drivers/watchdog/mpc5200_wdt.c b/drivers/watchdog/mpc5200_wdt.=
c
index fa9c47c..5bb553c 100644
--- a/drivers/watchdog/mpc5200_wdt.c
+++ b/drivers/watchdog/mpc5200_wdt.c
@@ -2,25 +2,16 @@
 #include <linux/module.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
-#include <linux/io.h>
-#include <linux/spinlock.h>
 #include <linux/of_platform.h>
 #include <linux/uaccess.h>
 #include <asm/mpc52xx.h>
=20
=20
-#define GPT_MODE_WDT		(1 << 15)
-#define GPT_MODE_CE		(1 << 12)
-#define GPT_MODE_MS_TIMER	(0x4)
-
+#define WDT_IDENTITY        "mpc5200 watchdog on GPT0"
=20
 struct mpc5200_wdt {
-	unsigned count;	/* timer ticks before watchdog kicks in */
-	long ipb_freq;
-	struct miscdevice miscdev;
-	struct resource mem;
-	struct mpc52xx_gpt __iomem *regs;
-	spinlock_t io_lock;
+	int timeout;
+	struct mpc52xx_gpt_priv *timer;
 };
=20
 /* is_active stores wether or not the /dev/watchdog device is opened */
@@ -32,80 +23,33 @@ static unsigned long is_active;
 static struct mpc5200_wdt *wdt_global;
=20
=20
-/* helper to calculate timeout in timer counts */
-static void mpc5200_wdt_set_timeout(struct mpc5200_wdt *wdt, int timeout)
-{
-	/* use biggest prescaler of 64k */
-	wdt->count =3D (wdt->ipb_freq + 0xffff) / 0x10000 * timeout;
-
-	if (wdt->count > 0xffff)
-		wdt->count =3D 0xffff;
-}
-/* return timeout in seconds (calculated from timer count) */
-static int mpc5200_wdt_get_timeout(struct mpc5200_wdt *wdt)
-{
-	return wdt->count * 0x10000 / wdt->ipb_freq;
-}
-
-
-/* watchdog operations */
-static int mpc5200_wdt_start(struct mpc5200_wdt *wdt)
-{
-	spin_lock(&wdt->io_lock);
-	/* disable */
-	out_be32(&wdt->regs->mode, 0);
-	/* set timeout, with maximum prescaler */
-	out_be32(&wdt->regs->count, 0x0 | wdt->count);
-	/* enable watchdog */
-	out_be32(&wdt->regs->mode, GPT_MODE_CE | GPT_MODE_WDT |
-						GPT_MODE_MS_TIMER);
-	spin_unlock(&wdt->io_lock);
-
-	return 0;
-}
-static int mpc5200_wdt_ping(struct mpc5200_wdt *wdt)
-{
-	spin_lock(&wdt->io_lock);
-	/* writing A5 to OCPW resets the watchdog */
-	out_be32(&wdt->regs->mode, 0xA5000000 |
-				(0xffffff & in_be32(&wdt->regs->mode)));
-	spin_unlock(&wdt->io_lock);
-	return 0;
-}
-static int mpc5200_wdt_stop(struct mpc5200_wdt *wdt)
-{
-	spin_lock(&wdt->io_lock);
-	/* disable */
-	out_be32(&wdt->regs->mode, 0);
-	spin_unlock(&wdt->io_lock);
-	return 0;
-}
-
-
 /* file operations */
 static ssize_t mpc5200_wdt_write(struct file *file, const char __user *dat=
a,
-		size_t len, loff_t *ppos)
+				 size_t len, loff_t *ppos)
 {
 	struct mpc5200_wdt *wdt =3D file->private_data;
-	mpc5200_wdt_ping(wdt);
+	mpc52xx_gpt_wdt_ping(wdt->timer);
 	return 0;
 }
+
 static struct watchdog_info mpc5200_wdt_info =3D {
 	.options	=3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
-	.identity	=3D "mpc5200 watchdog on GPT0",
+	.identity	=3D WDT_IDENTITY,
 };
+
 static long mpc5200_wdt_ioctl(struct file *file, unsigned int cmd,
-							unsigned long arg)
+			      unsigned long arg)
 {
 	struct mpc5200_wdt *wdt =3D file->private_data;
 	int __user *data =3D (int __user *)arg;
 	int timeout;
+	u64 real_timeout;
 	int ret =3D 0;
=20
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
 		ret =3D copy_to_user(data, &mpc5200_wdt_info,
-						sizeof(mpc5200_wdt_info));
+				   sizeof(mpc5200_wdt_info));
 		if (ret)
 			ret =3D -EFAULT;
 		break;
@@ -116,19 +60,23 @@ static long mpc5200_wdt_ioctl(struct file *file, unsig=
ned int cmd,
 		break;
=20
 	case WDIOC_KEEPALIVE:
-		mpc5200_wdt_ping(wdt);
+		mpc52xx_gpt_wdt_ping(wdt->timer);
 		break;
=20
 	case WDIOC_SETTIMEOUT:
 		ret =3D get_user(timeout, data);
 		if (ret)
 			break;
-		mpc5200_wdt_set_timeout(wdt, timeout);
-		mpc5200_wdt_start(wdt);
+		ret =3D mpc52xx_gpt_wdt_start(wdt->timer, timeout);
+		if (ret)
+			break;
+		wdt->timeout =3D timeout;
 		/* fall through and return the timeout */
=20
 	case WDIOC_GETTIMEOUT:
-		timeout =3D mpc5200_wdt_get_timeout(wdt);
+		real_timeout =3D mpc52xx_gpt_timer_period(wdt->timer);
+		do_div(real_timeout, 1000000000);
+		timeout =3D (int) real_timeout;
 		ret =3D put_user(timeout, data);
 		break;
=20
@@ -140,154 +88,90 @@ static long mpc5200_wdt_ioctl(struct file *file, unsi=
gned int cmd,
=20
 static int mpc5200_wdt_open(struct inode *inode, struct file *file)
 {
+	int ret;
+
 	/* /dev/watchdog can only be opened once */
 	if (test_and_set_bit(0, &is_active))
 		return -EBUSY;
=20
 	/* Set and activate the watchdog */
-	mpc5200_wdt_set_timeout(wdt_global, 30);
-	mpc5200_wdt_start(wdt_global);
+	ret =3D mpc52xx_gpt_wdt_start(wdt_global->timer, 30);
+	if (ret) {
+		clear_bit(0, &is_active);
+		return ret;
+	}
+	wdt_global->timeout =3D 30;
+
 	file->private_data =3D wdt_global;
 	return nonseekable_open(inode, file);
 }
+
 static int mpc5200_wdt_release(struct inode *inode, struct file *file)
 {
-#if WATCHDOG_NOWAYOUT =3D=3D 0
+#if !defined(CONFIG_WATCHDOG_NOWAYOUT)
 	struct mpc5200_wdt *wdt =3D file->private_data;
-	mpc5200_wdt_stop(wdt);
-	wdt->count =3D 0;		/* =3D=3D disabled */
+	mpc52xx_gpt_wdt_stop(wdt->timer);
+	wdt->timeout =3D 0;		/* =3D=3D disabled */
 #endif
 	clear_bit(0, &is_active);
 	return 0;
 }
=20
 static const struct file_operations mpc5200_wdt_fops =3D {
-	.owner	=3D THIS_MODULE,
-	.write	=3D mpc5200_wdt_write,
+	.owner		=3D THIS_MODULE,
+	.llseek		=3D no_llseek,
+	.write		=3D mpc5200_wdt_write,
 	.unlocked_ioctl	=3D mpc5200_wdt_ioctl,
-	.open	=3D mpc5200_wdt_open,
-	.release =3D mpc5200_wdt_release,
+	.open		=3D mpc5200_wdt_open,
+	.release	=3D mpc5200_wdt_release,
+};
+
+static struct miscdevice mpc5200_wdt_miscdev =3D {
+	.minor		=3D WATCHDOG_MINOR,
+	.name		=3D "watchdog",
+	.fops		=3D &mpc5200_wdt_fops,
 };
=20
 /* module operations */
-static int mpc5200_wdt_probe(struct of_device *op,
-					const struct of_device_id *match)
+static int __init mpc5200_wdt_init(void)
 {
-	struct mpc5200_wdt *wdt;
 	int err;
-	const void *has_wdt;
-	int size;
+	struct mpc52xx_gpt_priv *timer;
=20
-	has_wdt =3D of_get_property(op->node, "has-wdt", NULL);
-	if (!has_wdt)
-		has_wdt =3D of_get_property(op->node, "fsl,has-wdt", NULL);
-	if (!has_wdt)
+	/* grab the watchdog-capable gpt */
+	timer =3D mpc52xx_gpt_wdt_probe();
+	if (!timer) {
+		pr_err(WDT_IDENTITY ": probing failed\n");
 		return -ENODEV;
+	}
=20
-	wdt =3D kzalloc(sizeof(*wdt), GFP_KERNEL);
-	if (!wdt)
+	wdt_global =3D kzalloc(sizeof(struct mpc5200_wdt), GFP_KERNEL);
+	if (!wdt_global) {
+		mpc52xx_gpt_wdt_release(timer);
 		return -ENOMEM;
-
-	wdt->ipb_freq =3D mpc5xxx_get_bus_frequency(op->node);
-
-	err =3D of_address_to_resource(op->node, 0, &wdt->mem);
-	if (err)
-		goto out_free;
-	size =3D wdt->mem.end - wdt->mem.start + 1;
-	if (!request_mem_region(wdt->mem.start, size, "mpc5200_wdt")) {
-		err =3D -ENODEV;
-		goto out_free;
-	}
-	wdt->regs =3D ioremap(wdt->mem.start, size);
-	if (!wdt->regs) {
-		err =3D -ENODEV;
-		goto out_release;
 	}
-
-	dev_set_drvdata(&op->dev, wdt);
-	spin_lock_init(&wdt->io_lock);
-
-	wdt->miscdev =3D (struct miscdevice) {
-		.minor	=3D WATCHDOG_MINOR,
-		.name	=3D "watchdog",
-		.fops	=3D &mpc5200_wdt_fops,
-		.parent =3D &op->dev,
-	};
-	wdt_global =3D wdt;
-	err =3D misc_register(&wdt->miscdev);
+	wdt_global->timer =3D timer;
+	err =3D misc_register(&mpc5200_wdt_miscdev);
 	if (!err)
-		return 0;
-
-	iounmap(wdt->regs);
-out_release:
-	release_mem_region(wdt->mem.start, size);
-out_free:
-	kfree(wdt);
+		pr_info(WDT_IDENTITY ": registered\n");
+	else {
+		mpc52xx_gpt_wdt_release(timer);
+		kfree(wdt_global);
+	}
 	return err;
 }
=20
-static int mpc5200_wdt_remove(struct of_device *op)
-{
-	struct mpc5200_wdt *wdt =3D dev_get_drvdata(&op->dev);
-
-	mpc5200_wdt_stop(wdt);
-	misc_deregister(&wdt->miscdev);
-	iounmap(wdt->regs);
-	release_mem_region(wdt->mem.start, wdt->mem.end - wdt->mem.start + 1);
-	kfree(wdt);
-
-	return 0;
-}
-static int mpc5200_wdt_suspend(struct of_device *op, pm_message_t state)
-{
-	struct mpc5200_wdt *wdt =3D dev_get_drvdata(&op->dev);
-	mpc5200_wdt_stop(wdt);
-	return 0;
-}
-static int mpc5200_wdt_resume(struct of_device *op)
-{
-	struct mpc5200_wdt *wdt =3D dev_get_drvdata(&op->dev);
-	if (wdt->count)
-		mpc5200_wdt_start(wdt);
-	return 0;
-}
-static int mpc5200_wdt_shutdown(struct of_device *op)
-{
-	struct mpc5200_wdt *wdt =3D dev_get_drvdata(&op->dev);
-	mpc5200_wdt_stop(wdt);
-	return 0;
-}
-
-static struct of_device_id mpc5200_wdt_match[] =3D {
-	{ .compatible =3D "mpc5200-gpt", },
-	{ .compatible =3D "fsl,mpc5200-gpt", },
-	{},
-};
-static struct of_platform_driver mpc5200_wdt_driver =3D {
-	.owner		=3D THIS_MODULE,
-	.name		=3D "mpc5200-gpt-wdt",
-	.match_table	=3D mpc5200_wdt_match,
-	.probe		=3D mpc5200_wdt_probe,
-	.remove		=3D mpc5200_wdt_remove,
-	.suspend	=3D mpc5200_wdt_suspend,
-	.resume		=3D mpc5200_wdt_resume,
-	.shutdown	=3D mpc5200_wdt_shutdown,
-};
-
-
-static int __init mpc5200_wdt_init(void)
-{
-	return of_register_platform_driver(&mpc5200_wdt_driver);
-}
-
 static void __exit mpc5200_wdt_exit(void)
 {
-	of_unregister_platform_driver(&mpc5200_wdt_driver);
+	mpc52xx_gpt_wdt_release(wdt_global->timer);
+	misc_deregister(&mpc5200_wdt_miscdev);
+	kfree(wdt_global);
 }
=20
 module_init(mpc5200_wdt_init);
 module_exit(mpc5200_wdt_exit);
=20
-MODULE_AUTHOR("Domen Puncer <domen.puncer@telargo.com>");
+MODULE_AUTHOR("Domen Puncer <domen.puncer@telargo.com>, "
+	      "Albrecht Dre=DF <albrecht.dress@arcor.de>");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
