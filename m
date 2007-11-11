Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 71957DDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Nov 2007 07:10:36 +1100 (EST)
Received: from localhost (mail0.scram.de [78.47.204.202])
	by localhost (Postfix) with ESMTP id E8F9654695
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Nov 2007 21:10:23 +0100 (CET)
Received: from mail0.scram.de ([78.47.204.202])
	by localhost (amavis.colab.de [88.198.23.89]) (amavisd-new, port 10024)
	with ESMTP id 4M4xhZ9eHICo for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Nov 2007 21:10:14 +0100 (CET)
Received: from [192.168.95.6] (p54B1F75F.dip.t-dialin.net [84.177.247.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: scram287)
	by mail0.scram.de (Postfix) with ESMTP id 8BE1C56131
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Nov 2007 21:10:13 +0100 (CET)
Message-ID: <473761A5.8070507@scram.de>
Date: Sun, 11 Nov 2007 21:10:13 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: [RFC/PATCH] powerpc: Add support for 8xx style watchdog
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

this is an attempt to port the 8xx watchdog driver to ARC=powerpc. As the watchdog seems to
be similar on pq1 / pq2 and pq2pro platforms (except from the divider value), one driver
should be enough to support the whole family. Am i correct with this assumption?

Thanks,
Jochen
---
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |    5 +
 arch/powerpc/sysdev/Makefile                 |    3 +
 arch/powerpc/sysdev/pq_wdt.c                 |  195 ++++++++++++++++++++++
 arch/powerpc/sysdev/pq_wdt.h                 |   27 +++
 drivers/watchdog/Kconfig                     |   13 ++-
 drivers/watchdog/Makefile                    |    1 +
 drivers/watchdog/pq_wdt.c                    |  222 ++++++++++++++++++++++++++
 7 files changed, 465 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/sysdev/pq_wdt.c
 create mode 100644 arch/powerpc/sysdev/pq_wdt.h
 create mode 100644 drivers/watchdog/pq_wdt.c

diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index 2cf1b6a..a686747 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -41,6 +41,7 @@
 #include <asm/udbg.h>
 
 #include <sysdev/commproc.h>
+#include <sysdev/pq_wdt.h>
 
 static u32 __iomem *bcsr, *bcsr5;
 
@@ -246,6 +247,10 @@ static void __init mpc885ads_setup_arch(void)
 	m8xx_pcmcia_ops.hw_ctrl = pcmcia_hw_setup;
 	m8xx_pcmcia_ops.voltage_set = pcmcia_set_voltage;
 #endif
+
+#if defined(CONFIG_PQ_WDT) || defined(CONFIG_PQ_WDT_MODULE)
+	pq_wdt_init();
+#endif
 }
 
 static int __init mpc885ads_probe(void)
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 99a77d7..84f190e 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -35,5 +35,8 @@ obj-$(CONFIG_CPM)		+= cpm_common.o
 obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
 obj-$(CONFIG_PPC_DCR)		+= dcr.o
 obj-$(CONFIG_8xx)		+= mpc8xx_pic.o commproc.o
+ifneq ($(CONFIG_PQ_WDT),)
+obj-y				+= pq_wdt.o
+endif
 obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
 endif
diff --git a/arch/powerpc/sysdev/pq_wdt.c b/arch/powerpc/sysdev/pq_wdt.c
new file mode 100644
index 0000000..10a196f
--- /dev/null
+++ b/arch/powerpc/sysdev/pq_wdt.c
@@ -0,0 +1,195 @@
+/*
+ * pq_wdt.c - Freescale PowerQUICC watchdog driver
+ *
+ * Author: Florian Schirmer <jolt@tuxbox.org>
+ *
+ * 2002 (c) Florian Schirmer <jolt@tuxbox.org> This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * 2007 (c) Jochen Friedrich <jochen@scram.de> ported to ARCH=powerpc and
+ * extended to be useful on any Power QUICC 1/2/2pro which have the same
+ * style of watchdog.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+
+#include "pq_wdt.h"
+
+struct pq_wdt {
+	__be32 res0;
+	__be32 swcrr; /* System watchdog control register */
+	__be32 swcnr; /* System watchdog count register */
+	u8 res1[2];
+	__be16 swsrr; /* System watchdog service register */
+};
+
+static int wdt_timeout;
+static int wdt_freq;
+static struct pq_wdt __iomem *wdt_reg;
+static int wdt_scale;
+static int wdt_timerun;
+static DEFINE_SPINLOCK(wdt_spinlock);
+
+void pq_wdt_reset(void)
+{
+	if (!wdt_reg)
+		return;
+
+	spin_lock(&wdt_spinlock);
+	out_be16(&wdt_reg->swsrr, 0x556c);	/* write magic1 */
+	out_be16(&wdt_reg->swsrr, 0xaa39);	/* write magic2 */
+	spin_unlock(&wdt_spinlock);
+}
+EXPORT_SYMBOL(pq_wdt_reset);
+
+static void wdt_timer_func(unsigned long data);
+
+static struct timer_list wdt_timer =
+	TIMER_INITIALIZER(wdt_timer_func, 0, 0);
+
+void pq_wdt_stop_timer(void)
+{
+	spin_lock(&wdt_spinlock);
+	if (wdt_timerun)
+		del_timer(&wdt_timer);
+	wdt_timerun = 0;
+	spin_unlock(&wdt_spinlock);
+}
+EXPORT_SYMBOL(pq_wdt_stop_timer);
+
+void pq_wdt_install_timer(void)
+{
+	pq_wdt_reset();
+	spin_lock(&wdt_spinlock);
+	if (!wdt_timerun) {
+		wdt_timer.expires = jiffies + (HZ/2);
+		add_timer(&wdt_timer);
+	}
+	wdt_timerun = 1;
+	spin_unlock(&wdt_spinlock);
+}
+EXPORT_SYMBOL(pq_wdt_install_timer);
+
+static void wdt_timer_func(unsigned long data)
+{
+	pq_wdt_install_timer();
+}
+
+int pq_wdt_get_timeout(void)
+{
+	return wdt_timeout / wdt_freq;
+}
+EXPORT_SYMBOL(pq_wdt_get_timeout);
+
+static int wdt_readparam(void)
+{
+	u32 swcrr;
+
+	wdt_timeout = 0;
+
+	swcrr = in_be32(&wdt_reg->swcrr);
+
+	if (!(swcrr & SWCRR_SWEN)) {
+		printk(KERN_NOTICE "pq_wdt: wdt disabled (SWCRR: 0x%08X)\n",
+		       swcrr);
+		return -EINVAL;
+	}
+
+	pq_wdt_reset();
+
+	printk(KERN_NOTICE
+	       "pq_wdt: active wdt found (SWTC: 0x%04X, SWP: 0x%01X)\n",
+	       (swcrr >> 16), swcrr & 0x07);
+
+	wdt_timeout = (swcrr >> 16) & 0xFFFF;
+
+	if (!wdt_timeout)
+		wdt_timeout = 0xFFFF;
+
+	if (swcrr & SWCRR_SWPR)
+		wdt_timeout *= wdt_scale;
+
+	return 0;
+}
+
+int pq_wdt_setup(int value)
+{
+	if (!wdt_reg)
+		return -ENODEV;
+		
+	out_be32(&wdt_reg->swcrr, value);
+	return wdt_readparam();
+}
+EXPORT_SYMBOL(pq_wdt_setup);
+
+int __init pq_wdt_init_timer(void)
+{
+	if (wdt_reg) {
+		pq_wdt_install_timer();
+		return 0;
+	} else
+		return -ENODEV;
+}
+arch_initcall(pq_wdt_init_timer);
+
+int pq_wdt_init(void)
+{
+	struct device_node *np, *soc;
+	int ret;
+	const u32 *data;
+
+	if (wdt_reg)
+		return 0;
+
+	wdt_scale = 2048;
+	np = of_find_compatible_node(NULL, NULL, "fsl,pq1-wdt");
+	if (np == NULL)
+		np = of_find_compatible_node(NULL, NULL, "fsl,pq2-wdt");
+	if (np == NULL) {
+		np = of_find_compatible_node(NULL, NULL, "fsl,pq2pro-wdt");
+		wdt_scale = 65536;
+	}
+	if (np == NULL) {
+		printk(KERN_ERR "Could not find fsl,pq1/2/2pro-wdt node\n");
+		return -ENODEV;
+	}
+
+	soc = of_find_node_by_type(NULL, "soc");
+	if (!soc) {
+		printk(KERN_ERR "Could not find soc node\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	data = of_get_property(soc, "bus-frequency", NULL);
+	if (!data) {
+		of_node_put(soc);
+		printk(KERN_ERR "Could not find bus-frequency in soc node\n");
+		ret = -ENODEV;
+		goto out;
+	}
+	of_node_put(soc);
+	wdt_freq = *data;
+
+	wdt_reg = of_iomap(np, 0);
+	if (wdt_reg == NULL) {
+		printk(KERN_ERR "Could not iomap wdt\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = wdt_readparam();
+out:
+	of_node_put(np);
+	return ret;
+}
+EXPORT_SYMBOL(pq_wdt_init);
diff --git a/arch/powerpc/sysdev/pq_wdt.h b/arch/powerpc/sysdev/pq_wdt.h
new file mode 100644
index 0000000..6f9e085
--- /dev/null
+++ b/arch/powerpc/sysdev/pq_wdt.h
@@ -0,0 +1,27 @@
+/*
+ * Author: Florian Schirmer <jolt@tuxbox.org>
+ *
+ * 2002 (c) Florian Schirmer <jolt@tuxbox.org> This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * 2007 (c) Jochen Friedrich <jochen@scram.de> ported to ARCH=powerpc and
+ * extended to be useful on any Power QUICC 1/2/2pro which have the same
+ * style of watchdog.
+ */
+#ifndef _POWERPC_SYSDEV_PQ_WDT_H
+#define _POWERPC_SYSDEV_PQ_WDT_H
+
+#define SWCRR_SWEN 0x00000004 /* Watchdog Enable bit. */
+#define SWCRR_SWRI 0x00000002 /* Software Watchdog Reset/Interrupt Select bit.*/
+#define SWCRR_SWPR 0x00000001 /* Software Watchdog Counter Prescale bit. */
+
+extern int pq_wdt_get_timeout(void);
+extern void pq_wdt_reset(void);
+extern void pq_wdt_install_timer(void);
+extern void pq_wdt_stop_timer(void);
+extern int pq_wdt_setup(int);
+extern int pq_wdt_init(void);
+
+#endif				/* _POWERPC_SYSDEV_PQ_WDT_H */
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 2792bc1..79ee351 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -626,7 +626,18 @@ config MPC5200_WDT
 
 config 8xx_WDT
 	tristate "MPC8xx Watchdog Timer"
-	depends on 8xx
+	depends on 8xx && ! OF
+
+config PQ_WDT
+	tristate "Power QUICC Watchdog Timer"
+	depends on (8xx || PPC_82xx || PPC_83xx) && OF
+	default y
+	help
+	  Watchdog driver for Power QUICC 1/2/2pro style watchdog drivers.
+	  You should really select this unless your boot loader turns
+	  off the watchdog. As the watchdog is turned on by default and
+	  can be turned on/off only once after reboot, your board won't
+	  run otherwise. Say 'M' if unsure.
 
 config 83xx_WDT
 	tristate "MPC83xx Watchdog Timer"
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 7d9e573..bdcf3f3 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_AR7_WDT) += ar7_wdt.o
 
 # POWERPC Architecture
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
+obj-$(CONFIG_PQ_WDT) += pq_wdt.o
 obj-$(CONFIG_MPC5200_WDT) += mpc5200_wdt.o
 obj-$(CONFIG_83xx_WDT) += mpc83xx_wdt.o
 obj-$(CONFIG_MV64X60_WDT) += mv64x60_wdt.o
diff --git a/drivers/watchdog/pq_wdt.c b/drivers/watchdog/pq_wdt.c
new file mode 100644
index 0000000..e03daa3
--- /dev/null
+++ b/drivers/watchdog/pq_wdt.c
@@ -0,0 +1,222 @@
+/*
+ * pq_wdt.c - Power QUICC watchdog userspace interface
+ *
+ * Author: Florian Schirmer <jolt@tuxbox.org>
+ *
+ * 2002 (c) Florian Schirmer <jolt@tuxbox.org> This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * 2007 (c) Jochen Friedrich <jochen@scram.de> renamed to pq_wdt.c and
+ * extended to be useful on any Power QUICC 1/2/2pro which have the same
+ * style of watchdog.
+ */
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/watchdog.h>
+#include <linux/of_platform.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <sysdev/pq_wdt.h>
+
+static unsigned long wdt_opened;
+static int wdt_status;
+
+static u16 timeout = 0xffff;
+module_param(timeout, ushort, 0);
+MODULE_PARM_DESC(timeout,
+	"Watchdog timeout in ticks. (0<timeout<65536, default=65535");
+
+static int reset = 1;
+module_param(reset, bool, 0);
+MODULE_PARM_DESC(reset,
+	"Watchdog Interrupt/Reset Mode. 0 = interrupt, 1 = reset (default)");
+
+static int prescale = 1;
+
+static void pq_wdt_handler_disable(void)
+{
+	pq_wdt_stop_timer();
+
+	pr_debug("pq_wdt: keep-alive handler deactivated\n");
+}
+
+static void pq_wdt_handler_enable(void)
+{
+	pq_wdt_install_timer();
+
+	pr_debug("pq_wdt: keep-alive handler activated\n");
+}
+
+static int pq_wdt_open(struct inode *inode, struct file *file)
+{
+	u32 tmp = SWCRR_SWEN;
+
+	if (test_and_set_bit(0, &wdt_opened))
+		return -EBUSY;
+
+	pq_wdt_reset();
+
+	if (prescale)
+		tmp |= SWCRR_SWPR;
+	if (reset)
+		tmp |= SWCRR_SWRI;
+
+	tmp |= timeout << 16;
+
+	if (pq_wdt_setup(tmp))
+		return -EBUSY;
+
+#if defined(CONFIG_WATCHDOG_NOWAYOUT)
+	/* Once we start the watchdog we can't stop it */
+	__module_get(THIS_MODULE);
+#endif
+
+	pq_wdt_handler_disable();
+
+	return nonseekable_open(inode, file);
+}
+
+static int pq_wdt_release(struct inode *inode, struct file *file)
+{
+	pq_wdt_reset();
+
+#if !defined(CONFIG_WATCHDOG_NOWAYOUT)
+	pq_wdt_handler_enable();
+#endif
+
+	clear_bit(0, &wdt_opened);
+
+	return 0;
+}
+
+static ssize_t pq_wdt_write(struct file *file, const char *data, size_t len,
+				loff_t *ppos)
+{
+	if (len)
+		pq_wdt_reset();
+
+	return len;
+}
+
+static int pq_wdt_ioctl(struct inode *inode, struct file *file,
+			    unsigned int cmd, unsigned long arg)
+{
+	int timeout;
+	static struct watchdog_info info = {
+		.options = WDIOF_KEEPALIVEPING,
+		.firmware_version = 0,
+		.identity = "PQ watchdog",
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
+		pq_wdt_reset();
+		wdt_status |= WDIOF_KEEPALIVEPING;
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		return -EOPNOTSUPP;
+
+	case WDIOC_GETTIMEOUT:
+		timeout = pq_wdt_get_timeout();
+		if (put_user(timeout, (int *)arg))
+			return -EFAULT;
+		break;
+
+	default:
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
+static const struct file_operations pq_wdt_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.write = pq_wdt_write,
+	.ioctl = pq_wdt_ioctl,
+	.open = pq_wdt_open,
+	.release = pq_wdt_release,
+};
+
+static struct miscdevice pq_wdt_miscdev = {
+	.minor = WATCHDOG_MINOR,
+	.name = "watchdog",
+	.fops = &pq_wdt_fops,
+};
+
+static int __devinit pq_wdt_probe(struct of_device *op, const struct of_device_id *match)
+{
+	int ret;
+
+	ret = pq_wdt_init();
+	if (ret)
+		return ret;
+
+	pq_wdt_handler_enable();
+
+	return misc_register(&pq_wdt_miscdev);
+}
+
+static int __devexit pq_wdt_remove(struct of_device *op)
+{
+	misc_deregister(&pq_wdt_miscdev);
+	return 0;
+}
+
+static struct of_device_id pq_wdt_match[] = {
+	{ .compatible = "fsl,pq1-wdt", },
+	{ .compatible = "fsl,pq2-wdt", },
+	{ .compatible = "fsl,pq2pro-wdt", },
+	{},
+};
+
+static struct of_platform_driver pq_wdt_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "pq-wdt",
+	.match_table	= pq_wdt_match,
+	.probe		= pq_wdt_probe,
+	.remove		= pq_wdt_remove,
+};
+
+static int __init pq_wdt_moduleinit(void)
+{
+	return of_register_platform_driver(&pq_wdt_driver);
+}
+
+static void __exit pq_wdt_moduleexit(void)
+{
+	of_unregister_platform_driver(&pq_wdt_driver);
+}
+
+module_init(pq_wdt_moduleinit);
+module_exit(pq_wdt_moduleexit);
+
+MODULE_AUTHOR("Florian Schirmer <jolt@tuxbox.org>");
+MODULE_DESCRIPTION("PQ watchdog driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-- 
1.5.3.5
