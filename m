Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 47798DDF0A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jun 2007 18:59:40 +1000 (EST)
Date: Tue, 12 Jun 2007 10:59:31 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] mpc5200: /dev/watchdog driver for GPT0
Message-ID: <20070612085931.GG23294@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Driver for internal mpc5200 watchdog on general purpose timer 0.
For IPB clock of 132 MHz the maximum timeout is about 32 seconds.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
Hi!

I also have some generic GPT code that one could extend with
what he/she needs. Mail me if you'd find it useful.


 drivers/char/watchdog/Kconfig       |    4 
 drivers/char/watchdog/Makefile      |    1 
 drivers/char/watchdog/mpc5200_wdt.c |  257 ++++++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+)

Index: work-powerpc.git/drivers/char/watchdog/Kconfig
===================================================================
--- work-powerpc.git.orig/drivers/char/watchdog/Kconfig
+++ work-powerpc.git/drivers/char/watchdog/Kconfig
@@ -521,6 +521,10 @@ config 8xx_WDT
 	tristate "MPC8xx Watchdog Timer"
 	depends on 8xx
 
+config MPC5200_WDT
+	tristate "MPC5200 Watchdog Timer"
+	depends on PPC_MPC52xx
+
 config 83xx_WDT
 	tristate "MPC83xx Watchdog Timer"
 	depends on PPC_83xx
Index: work-powerpc.git/drivers/char/watchdog/Makefile
===================================================================
--- work-powerpc.git.orig/drivers/char/watchdog/Makefile
+++ work-powerpc.git/drivers/char/watchdog/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc
 
 # PowerPC Architecture
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
+obj-$(CONFIG_MPC5200_WDT) += mpc5200_wdt.o
 obj-$(CONFIG_83xx_WDT) += mpc83xx_wdt.o
 obj-$(CONFIG_MV64X60_WDT) += mv64x60_wdt.o
 obj-$(CONFIG_BOOKE_WDT) += booke_wdt.o
Index: work-powerpc.git/drivers/char/watchdog/mpc5200_wdt.c
===================================================================
--- /dev/null
+++ work-powerpc.git/drivers/char/watchdog/mpc5200_wdt.c
@@ -0,0 +1,257 @@
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/io.h>
+#include <asm/of_platform.h>
+#include <asm/uaccess.h>
+#include <asm/mpc52xx.h>
+
+
+#define GPT_MODE_WDT		(1<<15)
+#define GPT_MODE_CE		(1<<12)
+#define GPT_MODE_MS_TIMER	(0x4)
+
+
+struct mpc5200_wdt {
+	unsigned count;	/* timer ticks before watchdog kicks in */
+	long ipb_freq;
+	struct miscdevice miscdev;
+	struct resource mem;
+	struct mpc52xx_gpt __iomem *regs;
+	struct mpc52xx_gpt saved_regs;
+};
+
+
+/* misc devices don't provide a way, to get back to 'dev' or 'miscdev' from
+ * file operations, which sucks. But there can be max 1 watchdog anyway, so...
+ */
+static struct mpc5200_wdt *wdt_global;
+
+
+/* helper to calculate timeout in timer counts */
+static void mpc5200_wdt_set_timeout(struct mpc5200_wdt *wdt, int timeout)
+{
+	/* use biggest prescaler of 64k */
+	wdt->count = (wdt->ipb_freq + 0xffff) / 0x10000 * timeout;
+
+	if (wdt->count > 0xffff)
+		wdt->count = 0xffff;
+}
+/* return timeout in seconds (calculated from timer count) */
+static int mpc5200_wdt_get_timeout(struct mpc5200_wdt *wdt)
+{
+	return wdt->count * 0x10000 / wdt->ipb_freq;
+}
+
+
+/* watchdog operations */
+static int mpc5200_wdt_start(struct mpc5200_wdt *wdt)
+{
+	/* disable */
+	out_be32(&wdt->regs->mode, 0);
+	/* set timeout, with maximum prescaler */
+	out_be32(&wdt->regs->count, 0x0 | wdt->count);
+	/* enable watchdog */
+	out_be32(&wdt->regs->mode, GPT_MODE_CE | GPT_MODE_WDT | GPT_MODE_MS_TIMER);
+
+	return 0;
+}
+static int mpc5200_wdt_ping(struct mpc5200_wdt *wdt)
+{
+	/* writing A5 to OCPW resets the watchdog */
+	out_be32(&wdt->regs->mode, 0xA5000000 | (0xffffff & in_be32(&wdt->regs->mode)));
+	return 0;
+}
+static int mpc5200_wdt_stop(struct mpc5200_wdt *wdt)
+{
+	out_be32(&wdt->regs->mode, 0);
+	return 0;
+}
+
+
+/* file operations */
+static ssize_t mpc5200_wdt_write(struct file *file, const char *data,
+		size_t len, loff_t *ppos)
+{
+	struct mpc5200_wdt *wdt = file->private_data;
+	mpc5200_wdt_ping(wdt);
+	return 0;
+}
+static struct watchdog_info mpc5200_wdt_info = {
+	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity	= "mpc5200 watchdog on GPT0",
+};
+static int mpc5200_wdt_ioctl(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	struct mpc5200_wdt *wdt = file->private_data;
+	int __user *data = (int __user *)arg;
+	int timeout;
+	int ret = 0;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		ret = copy_to_user(data, &mpc5200_wdt_info, sizeof(mpc5200_wdt_info));
+		if (ret)
+			ret = -EFAULT;
+		break;
+
+	case WDIOC_KEEPALIVE:
+		mpc5200_wdt_ping(wdt);
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		ret = get_user(timeout, data);
+		if (ret)
+			break;
+		mpc5200_wdt_set_timeout(wdt, timeout);
+		mpc5200_wdt_start(wdt);
+		/* fall through and return the timeout */
+
+	case WDIOC_GETTIMEOUT:
+		timeout = mpc5200_wdt_get_timeout(wdt);
+		ret = put_user(timeout, data);
+		break;
+	}
+	return ret;
+}
+static int mpc5200_wdt_open(struct inode *inode, struct file *file)
+{
+	mpc5200_wdt_set_timeout(wdt_global, 30);
+	mpc5200_wdt_start(wdt_global);
+	file->private_data = wdt_global;
+	return 0;
+}
+static int mpc5200_wdt_release(struct inode *inode, struct file *file)
+{
+#if WATCHDOG_NOWAYOUT == 0
+	struct mpc5200_wdt *wdt = file->private_data;
+	mpc5200_wdt_stop(wdt);
+#endif
+	return 0;
+}
+
+static struct file_operations mpc5200_wdt_fops = {
+	.owner	= THIS_MODULE,
+	.write	= mpc5200_wdt_write,
+	.ioctl	= mpc5200_wdt_ioctl,
+	.open	= mpc5200_wdt_open,
+	.release = mpc5200_wdt_release,
+};
+
+/* module operations */
+static int mpc5200_wdt_probe(struct of_device *op, const struct of_device_id *match)
+{
+	struct mpc5200_wdt *wdt;
+	int err;
+	const void *has_wdt;
+	int size;
+
+	has_wdt = of_get_property(op->node, "has-wdt", NULL);
+	if (!has_wdt)
+		return -ENODEV;
+
+	wdt = kzalloc(sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->ipb_freq = mpc52xx_find_ipb_freq(op->node);
+
+	err = of_address_to_resource(op->node, 0, &wdt->mem);
+	if (err)
+		goto out_free;
+	size = wdt->mem.end - wdt->mem.start + 1;
+	if (!request_mem_region(wdt->mem.start, size, "mpc5200_wdt")) {
+		err = -ENODEV;
+		goto out_free;
+	}
+	wdt->regs = ioremap(wdt->mem.start, size);
+	if (!wdt->regs) {
+		err = -ENODEV;
+		goto out_release;
+	}
+
+	dev_set_drvdata(&op->dev, wdt);
+
+	wdt->miscdev = (struct miscdevice) {
+		.minor	= WATCHDOG_MINOR,
+		.name	= "watchdog",
+		.fops	= &mpc5200_wdt_fops,
+		.parent = &op->dev,
+	};
+	wdt_global = wdt;
+	err = misc_register(&wdt->miscdev);
+	if (!err)
+		return 0;
+
+	iounmap(wdt->regs);
+ out_release:
+	release_mem_region(wdt->mem.start, size);
+ out_free:
+	kfree(wdt);
+	return err;
+}
+
+static int mpc5200_wdt_remove(struct of_device *op)
+{
+	struct mpc5200_wdt *wdt = dev_get_drvdata(&op->dev);
+
+	mpc5200_wdt_stop(wdt);
+	misc_deregister(&wdt->miscdev);
+	iounmap(wdt->regs);
+	release_mem_region(wdt->mem.start, wdt->mem.end - wdt->mem.start + 1);
+	kfree(wdt);
+
+	return 0;
+}
+static int mpc5200_wdt_suspend(struct of_device *op, pm_message_t state)
+{
+	struct mpc5200_wdt *wdt = dev_get_drvdata(&op->dev);
+	mpc5200_wdt_stop(wdt);
+	return 0;
+}
+static int mpc5200_wdt_resume(struct of_device *op)
+{
+	struct mpc5200_wdt *wdt = dev_get_drvdata(&op->dev);
+	mpc5200_wdt_start(wdt);
+	return 0;
+}
+static int mpc5200_wdt_shutdown(struct of_device *op)
+{
+	struct mpc5200_wdt *wdt = dev_get_drvdata(&op->dev);
+	mpc5200_wdt_stop(wdt);
+	return 0;
+}
+
+static struct of_device_id mpc5200_wdt_match[] = {
+	{ .compatible = "mpc5200-gpt", },
+	{},
+};
+static struct of_platform_driver mpc5200_wdt_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "mpc5200-gpt-wdt",
+	.match_table	= mpc5200_wdt_match,
+	.probe		= mpc5200_wdt_probe,
+	.remove		= mpc5200_wdt_remove,
+	.suspend	= mpc5200_wdt_suspend,
+	.resume		= mpc5200_wdt_resume,
+	.shutdown	= mpc5200_wdt_shutdown,
+};
+
+
+static int __init mpc5200_wdt_init(void)
+{
+	return of_register_platform_driver(&mpc5200_wdt_driver);
+}
+
+static void __exit mpc5200_wdt_exit(void)
+{
+	of_unregister_platform_driver(&mpc5200_wdt_driver);
+}
+
+module_init(mpc5200_wdt_init);
+module_exit(mpc5200_wdt_exit);
+
+MODULE_AUTHOR("Domen Puncer <domen.puncer@telargo.com>");
+MODULE_LICENSE("Dual BSD/GPL");
