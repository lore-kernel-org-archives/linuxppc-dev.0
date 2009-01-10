Return-Path: <adrian@lisas.de>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rhlx01.hs-esslingen.de", Issuer "HE CA - G02" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9E63DE472
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jan 2009 02:38:13 +1100 (EST)
From: "Adrian Reber" <adrian@lisas.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add support to access the flash on SLOF based systems
Date: Sat, 10 Jan 2009 16:31:22 +0100
Message-Id: <1231601482-28123-1-git-send-email-adrian@lisas.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds support for a simple character device to access the
flash for SLOF based systems like the PowerStation, QS2x and
PXCAB. In the SLOF git there is a user space program with
which the content of the flash for SLOF based systems can
be displayed and modified. This can be used to add a Linux
image to the flash and then directly boot the kernel from the
flash.

Signed-off-by: Adrian Reber <adrian@lisas.de>
---

This is based on the mmio NVRAM driver. I am not sure how useful this
is for anybody else but I am posting it anyway, hoping to get some
feedback. Also hoping it can be included at one point.

 arch/powerpc/platforms/Kconfig   |    8 ++
 arch/powerpc/sysdev/Makefile     |    2 +
 arch/powerpc/sysdev/slof_flash.c |  174 ++++++++++++++++++++++++++++++++++++++
 include/linux/miscdevice.h       |    1 +
 4 files changed, 185 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/slof_flash.c

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 47fe2be..7f436e0 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -301,6 +301,14 @@ config OF_RTC
 	  Uses information from the OF or flattened device tree to instatiate
 	  platform devices for direct mapped RTC chips like the DS1742 or DS1743.
 
+config SLOF_FLASH
+	bool "SLOF flash device"
+	depends on PPC_MAPLE || PPC_IBM_CELL_BLADE
+	default y
+	help
+	  Provide a read-only device to read out the flash
+	  for SLOF based systems.
+
 source "arch/powerpc/sysdev/bestcomm/Kconfig"
 
 config MPC8xxx_GPIO
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index b33b28a..298485d 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -50,3 +50,5 @@ obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
 ifeq ($(CONFIG_SUSPEND),y)
 obj-$(CONFIG_6xx)		+= 6xx-suspend.o
 endif
+
+obj-$(CONFIG_SLOF_FLASH)	+= slof_flash.o
diff --git a/arch/powerpc/sysdev/slof_flash.c b/arch/powerpc/sysdev/slof_flash.c
new file mode 100644
index 0000000..bc94d48
--- /dev/null
+++ b/arch/powerpc/sysdev/slof_flash.c
@@ -0,0 +1,174 @@
+/*
+ * SLOF flash access
+ *
+ * (C) Copyright MATRIX VISION GmbH 2009
+ *
+ * Authors : Adrian Reber <adrian@lisas.de>
+ *
+ * Based on mmio NVRAM driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+
+#include <linux/miscdevice.h>
+#include <asm/uaccess.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+
+static void __iomem *slof_flash_start;
+static long slof_flash_len;
+static DEFINE_SPINLOCK(slof_flash_lock);
+
+static loff_t slof_flash_llseek(struct file *file, loff_t offset, int origin)
+{
+	switch (origin) {
+	case 1:
+		offset += file->f_pos;
+		break;
+	case 2:
+		offset += slof_flash_len;
+		break;
+	}
+	if (offset < 0)
+		return -EINVAL;
+	file->f_pos = offset;
+	return file->f_pos;
+}
+
+
+static ssize_t slof_flash_read(struct file *file, char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	unsigned long flags;
+	char *tmp;
+	int rc;
+
+	if (*ppos >= slof_flash_len)
+		return 0;
+	if (*ppos + count > slof_flash_len)
+		count = slof_flash_len - *ppos;
+
+	count = min(count, PAGE_SIZE);
+	tmp = kzalloc(count, GFP_KERNEL);
+
+	if (!tmp)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&slof_flash_lock, flags);
+
+	memcpy_fromio(tmp, slof_flash_start + *ppos, count);
+
+	spin_unlock_irqrestore(&slof_flash_lock, flags);
+
+	rc = count;
+	if (copy_to_user(buf, tmp, count)) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	*ppos += count;
+out:
+	kfree(tmp);
+	return rc;
+}
+
+const struct file_operations slof_flash_fops = {
+	.owner = THIS_MODULE,
+	.llseek = slof_flash_llseek,
+	.read = slof_flash_read,
+};
+
+static struct miscdevice slof_flash_dev = {
+	SLOF_FLASH_MINOR,
+	"slof_flash",
+	&slof_flash_fops
+};
+
+
+static int __init slof_flash_init(void)
+{
+	struct device_node *slof_flash;
+	struct device_node *compatible;
+	struct resource r;
+	int rc;
+	unsigned long slof_flash_addr;
+	/* SLOF is known to run on systems with following values
+	 * for the compatible property: */
+	char *compstrs[] = {"IBM,Bimini", "IBM,JS21", "IBM,JS20", "IBM,CBEA" };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(compstrs); i++) {
+		compatible = of_find_compatible_node(NULL, NULL, compstrs[i]);
+
+		if (compatible)
+			break;
+	}
+
+	/* not a system with a SLOF flash */
+	if (!compatible)
+		return -ENODEV;
+
+	of_node_put(compatible);
+
+	slof_flash = of_find_node_by_type(NULL, "flash");
+	if (!slof_flash) {
+		printk(KERN_WARNING "SLOF FLASH: "
+		       "no flash node found in device-tree\n");
+		return -ENODEV;
+	}
+	rc = of_address_to_resource(slof_flash, 0, &r);
+	if (rc) {
+		printk(KERN_WARNING "SLOF FLASH: "
+		       "failed to get address (err %d)\n", rc);
+		goto out;
+	}
+
+	slof_flash_addr =  r.start;
+	slof_flash_len = r.end - r.start + 1;
+
+	if ((slof_flash_len <= 0) || (!slof_flash_addr)) {
+		printk(KERN_WARNING "SLOF FLASH: address or length is 0\n");
+		rc = -EIO;
+		goto out;
+	}
+
+	slof_flash_start = ioremap(slof_flash_addr, slof_flash_len);
+	if (!slof_flash_start) {
+		printk(KERN_WARNING "SLOF FLASH: failed to ioremap\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	printk(KERN_INFO "SLOF FLASH: %luk at 0x%lx mapped to %p\n",
+	       slof_flash_len >> 10, slof_flash_addr, slof_flash_start);
+
+	rc = misc_register(&slof_flash_dev);
+	if (rc != 0)
+		printk(KERN_ERR "SLOF FLASH: failed to register device\n");
+
+out:
+	of_node_put(slof_flash);
+	return rc;
+}
+
+void __exit slof_flash_cleanup(void)
+{
+	misc_deregister(&slof_flash_dev);
+}
+
+module_init(slof_flash_init);
+module_exit(slof_flash_cleanup);
+MODULE_LICENSE("GPL");
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index a820f81..0887042 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -19,6 +19,7 @@
 #define SUN_OPENPROM_MINOR	139
 #define DMAPI_MINOR		140	/* DMAPI */
 #define NVRAM_MINOR		144
+#define SLOF_FLASH_MINOR	145
 #define SGI_MMTIMER		153
 #define STORE_QUEUE_MINOR	155
 #define I2O_MINOR		166
-- 
1.6.0.6
