Return-Path: <jchapman@katalix.com>
Received: from ptb-relay01.plus.net (ptb-relay01.plus.net [212.159.14.212])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5A9D67A8B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 22:18:31 +1100 (EST)
Message-ID: <421DB801.9090705@katalix.com>
Date: Thu, 24 Feb 2005 11:18:25 +0000
From: James Chapman <jchapman@katalix.com>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
References: <421CF6B8.3090104@katalix.com>
	<20050224074816.GB6650@infomag.infomag.iguana.be>
In-Reply-To: <20050224074816.GB6650@infomag.infomag.iguana.be>
Content-Type: multipart/mixed; boundary="------------070806050204030105020306"
Cc: linuxppc-embedded@ozlabs.org
Subject: PATCH: mv64x60: add watchdog support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070806050204030105020306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Wim,

Please review this patch that adds mv64x60 watchdog support.

Signed-off-by: James Chapman <jchapman@katalix.com>

I'm cc'ing linuxppc-embedded to get critical review from developers
who are more likely to know this chip. The Marvell mv64x60 chips are
found on ppc and mips boards.

/james

Wim Van Sebroeck wrote:

> Hi James,
> 
>>Are you the Linux watchdog driver maintainer? I have a patch for a new 
>>watchdog driver for Marvell Discovery (mv64x60) boards and I'm trying to 
>>find the best place to post it...
>>
>>My patch is against the latest 2.6 bk tree. Should I create the patch 
>>against a different tree? Is there a mailing list?
> 
> 
> You can sent it to me and I'll review it and include it in the linux-watchdog bitkeeper tree.
> We actually work first with the -mm tree for testing, after that it goes to linus.
> 
> Hope this helps,
> Greetings,
> wim.

--------------070806050204030105020306
Content-Type: text/plain;
 name="mv64x60_wdt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mv64x60_wdt.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/24 10:40:40+00:00 jchapman@katalix.com 
#   Add mv64x60 (Marvell Discovery) watchdog support.
# 
# drivers/char/watchdog/mv64x60_wdt.c
#   2005/02/24 10:40:31+00:00 jchapman@katalix.com +252 -0
# 
# include/asm-ppc/mv64x60.h
#   2005/02/24 10:40:31+00:00 jchapman@katalix.com +8 -0
#   Add mv64x60 (Marvell Discovery) watchdog support.
# 
# drivers/char/watchdog/mv64x60_wdt.c
#   2005/02/24 10:40:31+00:00 jchapman@katalix.com +0 -0
#   BitKeeper file /home/james/bk/linux-2.6.wdt/drivers/char/watchdog/mv64x60_wdt.c
# 
# drivers/char/watchdog/Makefile
#   2005/02/24 10:40:31+00:00 jchapman@katalix.com +1 -0
#   Add mv64x60 (Marvell Discovery) watchdog support.
# 
# drivers/char/watchdog/Kconfig
#   2005/02/24 10:40:31+00:00 jchapman@katalix.com +4 -0
#   Add mv64x60 (Marvell Discovery) watchdog support.
# 
diff -Nru a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig	2005-02-24 10:45:36 +00:00
+++ b/drivers/char/watchdog/Kconfig	2005-02-24 10:45:36 +00:00
@@ -346,6 +346,10 @@
 	tristate "MPC8xx Watchdog Timer"
 	depends on WATCHDOG && 8xx
 
+config MV64X60_WDT
+	tristate "MV64X60 (Marvell Discovery) Watchdog Timer"
+	depends on WATCHDOG && MV64X60
+
 # MIPS Architecture
 
 config INDYDOG
diff -Nru a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	2005-02-24 10:45:36 +00:00
+++ b/drivers/char/watchdog/Makefile	2005-02-24 10:45:36 +00:00
@@ -39,3 +39,4 @@
 obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
 obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
+obj-$(CONFIG_MV64X60_WDT) += mv64x60_wdt.o
diff -Nru a/drivers/char/watchdog/mv64x60_wdt.c b/drivers/char/watchdog/mv64x60_wdt.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/char/watchdog/mv64x60_wdt.c	2005-02-24 10:45:36 +00:00
@@ -0,0 +1,252 @@
+/*
+ * mv64x60_wdt.c - MV64X60 (Marvell Discovery) watchdog userspace interface
+ *
+ * Author: James Chapman <jchapman@katalix.com>
+ *
+ * Platform-specific setup code should configure the dog to generate
+ * interrupt or reset as required.  This code only enables/disables
+ * and services the watchdog.
+ *
+ * Derived from mpc8xx_wdt.c, with the following copyright.
+ * 
+ * 2002 (c) Florian Schirmer <jolt@tuxbox.org> This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/watchdog.h>
+#include <asm/mv64x60.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+/* MV64x60 WDC (config) register access definitions */
+#define MV64x60_WDC_CTL1_MASK	(3 << 24)
+#define MV64x60_WDC_CTL1(val)	((val & 3) << 24)
+#define MV64x60_WDC_CTL2_MASK	(3 << 26)
+#define MV64x60_WDC_CTL2(val)	((val & 3) << 26)
+
+/* Flags bits */
+#define MV64x60_WDOG_FLAG_OPENED	0
+#define MV64x60_WDOG_FLAG_ENABLED	1
+
+static unsigned long wdt_flags;
+static int wdt_status;
+static void __iomem *mv64x60_regs;
+static int mv64x60_wdt_timeout;
+
+static void mv64x60_wdt_reg_write(u32 val)
+{
+	/* Allow write only to CTL1 / CTL2 fields, retaining values in
+	 * other fields.
+	 */
+	u32 data = readl(mv64x60_regs + MV64x60_WDT_WDC);
+	data &= ~(MV64x60_WDC_CTL1_MASK | MV64x60_WDC_CTL2_MASK);
+	data |= val;
+	writel(data, mv64x60_regs + MV64x60_WDT_WDC);
+}
+
+static void mv64x60_wdt_service(void)
+{
+	/* Write 01 followed by 10 to CTL2 */
+	mv64x60_wdt_reg_write(MV64x60_WDC_CTL2(0x01));
+	mv64x60_wdt_reg_write(MV64x60_WDC_CTL2(0x02));
+}
+
+static void mv64x60_wdt_handler_disable(void)
+{
+	if (test_and_clear_bit(MV64x60_WDOG_FLAG_ENABLED, &wdt_flags)) {
+		/* Write 01 followed by 10 to CTL1 */
+		mv64x60_wdt_reg_write(MV64x60_WDC_CTL1(0x01));
+		mv64x60_wdt_reg_write(MV64x60_WDC_CTL1(0x02));
+		printk(KERN_NOTICE "mv64x60_wdt: watchdog deactivated\n");
+	}
+}
+
+static void mv64x60_wdt_handler_enable(void)
+{
+	if (!test_and_set_bit(MV64x60_WDOG_FLAG_ENABLED, &wdt_flags)) {
+		/* Write 01 followed by 10 to CTL1 */
+		mv64x60_wdt_reg_write(MV64x60_WDC_CTL1(0x01));
+		mv64x60_wdt_reg_write(MV64x60_WDC_CTL1(0x02));
+		printk(KERN_NOTICE "mv64x60_wdt: watchdog activated\n");
+	}
+}
+
+static int mv64x60_wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(MV64x60_WDOG_FLAG_OPENED, &wdt_flags))
+		return -EBUSY;
+
+	mv64x60_wdt_service();
+	mv64x60_wdt_handler_enable();
+
+	return 0;
+}
+
+static int mv64x60_wdt_release(struct inode *inode, struct file *file)
+{
+	mv64x60_wdt_service();
+
+#if !defined(CONFIG_WATCHDOG_NOWAYOUT)
+	mv64x60_wdt_handler_disable();
+#endif
+
+	clear_bit(MV64x60_WDOG_FLAG_OPENED, &wdt_flags);
+
+	return 0;
+}
+
+static ssize_t mv64x60_wdt_write(struct file *file, const char *data,
+				 size_t len, loff_t * ppos)
+{
+	if (*ppos != file->f_pos)
+		return -ESPIPE;
+
+	if (len)
+		mv64x60_wdt_service();
+
+	return len;
+}
+
+static int mv64x60_wdt_ioctl(struct inode *inode, struct file *file,
+			     unsigned int cmd, unsigned long arg)
+{
+	int timeout;
+	static struct watchdog_info info = {
+		.options = WDIOF_KEEPALIVEPING,
+		.firmware_version = 0,
+		.identity = "MV64x60 watchdog",
+	};
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		if (copy_to_user((void *)arg, &info, sizeof(info)))
+			return -EFAULT;
+		break;
+
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		if (put_user(wdt_status, (int *)arg))
+			return -EFAULT;
+		wdt_status &= ~WDIOF_KEEPALIVEPING;
+		break;
+
+	case WDIOC_GETTEMP:
+		return -EOPNOTSUPP;
+
+	case WDIOC_SETOPTIONS:
+		return -EOPNOTSUPP;
+
+	case WDIOC_KEEPALIVE:
+		mv64x60_wdt_service();
+		wdt_status |= WDIOF_KEEPALIVEPING;
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		return -EOPNOTSUPP;
+
+	case WDIOC_GETTIMEOUT:
+		timeout = mv64x60_wdt_timeout * HZ;
+		if (put_user(timeout, (int *)arg))
+			return -EFAULT;
+		break;
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return 0;
+}
+
+static struct file_operations mv64x60_wdt_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.write = mv64x60_wdt_write,
+	.ioctl = mv64x60_wdt_ioctl,
+	.open = mv64x60_wdt_open,
+	.release = mv64x60_wdt_release,
+};
+
+static struct miscdevice mv64x60_wdt_miscdev = {
+	.minor = WATCHDOG_MINOR,
+	.name = "watchdog",
+	.fops = &mv64x60_wdt_fops,
+};
+
+static int __devinit mv64x60_wdt_probe(struct device *dev)
+{
+	struct platform_device *pd = to_platform_device(dev);
+	struct mv64x60_wdt_pdata *pdata = pd->dev.platform_data;
+	int bus_clk = 133;
+
+	mv64x60_wdt_timeout = 10;
+	if (pdata) {
+		mv64x60_wdt_timeout = pdata->timeout;
+		bus_clk = pdata->bus_clk;
+	}
+
+	mv64x60_regs = mv64x60_get_bridge_vbase();
+
+	writel((mv64x60_wdt_timeout * (bus_clk * 1000000)) >> 8,
+	       mv64x60_regs + MV64x60_WDT_WDC);
+
+	return misc_register(&mv64x60_wdt_miscdev);
+}
+
+static int __devexit mv64x60_wdt_remove(struct device *dev)
+{
+	misc_deregister(&mv64x60_wdt_miscdev);
+
+	mv64x60_wdt_service();
+	mv64x60_wdt_handler_disable();
+
+	return 0;
+}
+
+static struct device_driver mv64x60_wdt_driver = {
+	.name = MV64x60_WDT_NAME,
+	.bus = &platform_bus_type,
+	.probe = mv64x60_wdt_probe,
+	.remove = __devexit_p(mv64x60_wdt_remove),
+};
+
+static struct platform_device *mv64x60_wdt_dev;
+
+static int __init mv64x60_wdt_init(void)
+{
+	int ret;
+
+	printk(KERN_INFO "MV64x60 watchdog driver\n");
+
+	mv64x60_wdt_dev = platform_device_register_simple(MV64x60_WDT_NAME,
+							  -1, NULL, 0);
+	if (IS_ERR(mv64x60_wdt_dev)) {
+		ret = PTR_ERR(mv64x60_wdt_dev);
+		goto out;
+	}
+
+	ret = driver_register(&mv64x60_wdt_driver);
+      out:
+	return ret;
+}
+
+static void __exit mv64x60_wdt_exit(void)
+{
+	driver_unregister(&mv64x60_wdt_driver);
+	platform_device_unregister(mv64x60_wdt_dev);
+}
+
+module_init(mv64x60_wdt_init);
+module_exit(mv64x60_wdt_exit);
+
+MODULE_AUTHOR("James Chapman <jchapman@katalix.com>");
+MODULE_DESCRIPTION("MV64x60 watchdog driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff -Nru a/include/asm-ppc/mv64x60.h b/include/asm-ppc/mv64x60.h
--- a/include/asm-ppc/mv64x60.h	2005-02-24 10:45:36 +00:00
+++ b/include/asm-ppc/mv64x60.h	2005-02-24 10:45:36 +00:00
@@ -119,6 +119,14 @@
 
 #define	MV64x60_64BIT_WIN_COUNT			24
 
+/* Watchdog Platform Device, Driver Data */
+#define	MV64x60_WDT_NAME			"wdt"
+
+struct mv64x60_wdt_pdata {
+	int	timeout;	/* watchdog expiry in seconds, default 10 */
+	int	bus_clk;	/* bus clock in MHz, default 133 */
+};
+
 /*
  * Define a structure that's used to pass in config information to the
  * core routines.

--------------070806050204030105020306--
