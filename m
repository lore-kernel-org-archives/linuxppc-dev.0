Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 6B3C3DDF68
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 13:52:48 +1000 (EST)
Date: Fri, 22 Aug 2008 23:52:53 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: lkml <linux-kernel@vger.kernel.org>, linuxppc-dev
	<linuxppc-dev@ozlabs.org>, wim@iguana.be
Subject: [PATCH] Pika Warp appliance watchdog timer
Message-ID: <20080822235253.129b4047@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The FPGA based watchdog timer used by the Pika Warp appliance.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index db20542..2bbb607 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -719,6 +719,14 @@ config BOOKE_WDT
 	  Please see Documentation/watchdog/watchdog-api.txt for
 	  more information.
 
+config PIKA_WDT
+	tristate "PIKA FPGA Watchdog"
+	depends on WARP
+	default y
+	help
+	 This enables the watchdog in the PIKA FPGA. Currently used on
+	 the Warp platform.
+
 # PPC64 Architecture
 
 config WATCHDOG_RTAS
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index ca3dc04..3527290 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -109,6 +109,7 @@ obj-$(CONFIG_MPC5200_WDT) += mpc5200_wdt.o
 obj-$(CONFIG_8xxx_WDT) += mpc8xxx_wdt.o
 obj-$(CONFIG_MV64X60_WDT) += mv64x60_wdt.o
 obj-$(CONFIG_BOOKE_WDT) += booke_wdt.o
+obj-$(CONFIG_PIKA_WDT) += pika_wdt.o
 
 # PPC64 Architecture
 obj-$(CONFIG_WATCHDOG_RTAS) += wdrtas.o
diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
new file mode 100644
index 0000000..32e11f7
--- /dev/null
+++ b/drivers/watchdog/pika_wdt.c
@@ -0,0 +1,113 @@
+/*
+ * PIKA FPGA based Watchdog Timer
+ *
+ * Copyright (c) 2008 PIKA Technologies
+ *   Sean MacLennan <smaclennan@pikatech.com>
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/reboot.h>
+#include <linux/uaccess.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+#include <linux/watchdog.h>
+
+
+static void __iomem *pikawdt_fpga;
+
+
+static inline void pikawdt_ping(void)
+{
+	unsigned reset = in_be32(pikawdt_fpga + 0x14);
+	reset |= 0xf80; /* enable with max timeout - 15 seconds */
+	out_be32(pikawdt_fpga + 0x14, reset);
+}
+
+static int pikawdt_open(struct inode *inode, struct file *file)
+{
+	printk(KERN_INFO "PIKA WDT started...\n");
+
+	pikawdt_ping();
+
+	return 0;
+}
+
+static int pikawdt_release(struct inode *inode, struct file *file)
+{
+	pikawdt_ping(); /* one last time */
+	return 0;
+}
+
+static ssize_t pikawdt_write(struct file *file, const char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	pikawdt_ping();
+	return count;
+}
+
+/* We support the bare minimum to be conformant. */
+static int pikawdt_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, unsigned long arg)
+{
+	if (cmd == WDIOC_KEEPALIVE) {
+		pikawdt_ping();
+		return 0;
+	} else
+		return -EINVAL;
+}
+
+static const struct file_operations pikawdt_fops = {
+	.owner		= THIS_MODULE,
+	.open		= pikawdt_open,
+	.release	= pikawdt_release,
+	.write		= pikawdt_write,
+	.ioctl		= pikawdt_ioctl,
+};
+
+static struct miscdevice pikawdt_miscdev = {
+	.minor	= WATCHDOG_MINOR,
+	.name	= "watchdog",
+	.fops	= &pikawdt_fops,
+};
+
+static int __init pikawdt_init(void)
+{
+	struct device_node *np;
+	int ret;
+
+	np = of_find_compatible_node(NULL, NULL, "pika,fpga");
+	if (np == NULL) {
+		printk(KERN_ERR "pikawdt: Unable to find fpga.\n");
+		return -ENOENT;
+	}
+
+	pikawdt_fpga = of_iomap(np, 0);
+
+	of_node_put(np);
+
+	if (pikawdt_fpga == NULL) {
+		printk(KERN_ERR "pikawdt: Unable to map fpga.\n");
+		return -ENOENT;
+	}
+
+	ret = misc_register(&pikawdt_miscdev);
+	if (ret) {
+		iounmap(pikawdt_fpga);
+		printk(KERN_ERR "pikawdt: Unable to register miscdev.\n");
+		return ret;
+	}
+
+	return 0;
+}
+module_init(pikawdt_init);
+
+
+static void __exit pikawdt_exit(void)
+{
+	misc_deregister(&pikawdt_miscdev);
+
+	iounmap(pikawdt_fpga);
+}
+module_exit(pikawdt_exit);
