Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 4B311DDEB9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 05:03:32 +1100 (EST)
Message-ID: <4794DE73.40407@pikatech.com>
Date: Mon, 21 Jan 2008 13:03:31 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH} PIKA FPGA WDT driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PIKA FPGA has a watchdog. It is currently only used on the Warp 
board, but it could be used on other future PIKA products. We tend to 
try to reuse FPGA code as much as possible.

Cheers,
   Sean

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 52dff40..fc1b9fe 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -666,6 +666,14 @@ config BOOKE_WDT
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
index 87483cc..efa4731 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_MPC5200_WDT) += mpc5200_wdt.o
 obj-$(CONFIG_83xx_WDT) += mpc83xx_wdt.o
 obj-$(CONFIG_MV64X60_WDT) += mv64x60_wdt.o
 obj-$(CONFIG_BOOKE_WDT) += booke_wdt.o
+obj-$(CONFIG_PIKA_WDT) += pika_wdt.o
 
 # PPC64 Architecture
 obj-$(CONFIG_WATCHDOG_RTAS) += wdrtas.o
diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
new file mode 100644
index 0000000..074756b
--- /dev/null
+++ b/drivers/watchdog/pika_wdt.c
@@ -0,0 +1,124 @@
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
+{	/* Any write will do */
+	unsigned reset = in_be32(pikawdt_fpga);
+	out_be32(pikawdt_fpga, reset);
+}
+
+static int pikawdt_open(struct inode *inode, struct file *file)
+{
+	unsigned reset;
+
+	/* Enable the watchdog. Note this is an implicit ping. */
+	reset = in_be32(pikawdt_fpga);
+	reset |= 0xf80; /* enable with max timeout - 15 seconds */
+	out_be32(pikawdt_fpga, reset);
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
+static ssize_t pikawdt_write(struct file *file, const char __user *buf, size_t count,
+			     loff_t *ppos)
+{
+	pikawdt_ping();
+	return count;
+}
+
+/* We support the bare minimum to be conformant. */
+static int pikawdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+			 unsigned long arg)
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
+	struct resource res;
+	int ret;
+
+	if ((np = of_find_compatible_node(NULL, NULL, "pika,fpga")) == NULL) {
+		printk(KERN_ERR __FILE__ ": Unable to find fpga\n");
+		return -ENOENT;
+	}
+
+	/* We do not call of_iomap here since it would map in the entire
+	 * fpga space, which is over 8k.
+	 */
+	ret = of_address_to_resource(np, 0, &res);
+	of_node_put(np);
+
+	if (ret) {
+		printk(KERN_ERR __FILE__ ": Unable to get FPGA address\n");
+		return ret;
+	}
+
+	pikawdt_fpga = ioremap(res.start + 0x14, 4);
+	if (pikawdt_fpga == NULL) {
+		printk(KERN_ERR __FILE__ ": Unable to map FPGA\n");
+		return -ENOENT;
+	}
+
+	ret = misc_register(&pikawdt_miscdev);
+	if (ret) {
+		iounmap(pikawdt_fpga);
+		printk(KERN_ERR "pikawdt: cannot register miscdev on minor=%d (err=%d)\n",
+			   WATCHDOG_MINOR, ret);
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
