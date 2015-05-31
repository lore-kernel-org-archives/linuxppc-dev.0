Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 7EEA81A0CA3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:17:02 +1000 (AEST)
Message-Id: <20150531010137.329761042@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:52 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC 20/24] char/generic_nvram: Remove as unused
References: <20150531010132.289674310@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

And thus eliminate some twisted CONFIG_GENERIC_NVRAM logic.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 drivers/char/Makefile        |    6 -
 drivers/char/generic_nvram.c |  176 -------------------------------------------
 2 files changed, 1 insertion(+), 181 deletions(-)

Index: linux/drivers/char/Makefile
===================================================================
--- linux.orig/drivers/char/Makefile	2015-05-31 11:00:59.000000000 +1000
+++ linux/drivers/char/Makefile	2015-05-31 11:01:23.000000000 +1000
@@ -30,11 +30,7 @@ obj-$(CONFIG_GEN_RTC)		+= genrtc.o
 obj-$(CONFIG_EFI_RTC)		+= efirtc.o
 obj-$(CONFIG_DS1302)		+= ds1302.o
 obj-$(CONFIG_XILINX_HWICAP)	+= xilinx_hwicap/
-ifeq ($(CONFIG_GENERIC_NVRAM),y)
-  obj-$(CONFIG_NVRAM)	+= generic_nvram.o
-else
-  obj-$(CONFIG_NVRAM)	+= nvram.o
-endif
+obj-$(CONFIG_NVRAM)		+= nvram.o
 obj-$(CONFIG_TOSHIBA)		+= toshiba.o
 obj-$(CONFIG_I8K)		+= i8k.o
 obj-$(CONFIG_DS1620)		+= ds1620.o
Index: linux/drivers/char/generic_nvram.c
===================================================================
--- linux.orig/drivers/char/generic_nvram.c	2015-05-31 11:01:19.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,176 +0,0 @@
-/*
- * Generic /dev/nvram driver for architectures providing some
- * "generic" hooks, that is :
- *
- * nvram_read_byte, nvram_write_byte, nvram_sync, nvram_get_size
- *
- * Note that an additional hook is supported for PowerMac only
- * for getting the nvram "partition" informations
- *
- */
-
-#define NVRAM_VERSION "1.1"
-
-#include <linux/module.h>
-
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/miscdevice.h>
-#include <linux/fcntl.h>
-#include <linux/init.h>
-#include <linux/mutex.h>
-#include <linux/nvram.h>
-#include <asm/uaccess.h>
-
-#ifdef CONFIG_PPC_PMAC
-#include <asm/nvram.h>
-#include <asm/machdep.h>
-#endif
-
-static DEFINE_MUTEX(nvram_mutex);
-static ssize_t nvram_len;
-
-static loff_t nvram_llseek(struct file *file, loff_t offset, int origin)
-{
-	switch (origin) {
-	case 0:
-		break;
-	case 1:
-		offset += file->f_pos;
-		break;
-	case 2:
-		offset += nvram_len;
-		break;
-	default:
-		offset = -1;
-	}
-	if (offset < 0)
-		return -EINVAL;
-
-	file->f_pos = offset;
-
-	return file->f_pos;
-}
-
-static ssize_t read_nvram(struct file *file, char __user *buf,
-			  size_t count, loff_t *ppos)
-{
-	unsigned int i;
-	char __user *p = buf;
-
-	if (!access_ok(VERIFY_WRITE, buf, count))
-		return -EFAULT;
-	if (*ppos >= nvram_len)
-		return 0;
-	for (i = *ppos; count > 0 && i < nvram_len; ++i, ++p, --count)
-		if (__put_user(arch_nvram_ops.read_byte(i), p))
-			return -EFAULT;
-	*ppos = i;
-	return p - buf;
-}
-
-static ssize_t write_nvram(struct file *file, const char __user *buf,
-			   size_t count, loff_t *ppos)
-{
-	unsigned int i;
-	const char __user *p = buf;
-	char c;
-
-	if (!access_ok(VERIFY_READ, buf, count))
-		return -EFAULT;
-	if (*ppos >= nvram_len)
-		return 0;
-	for (i = *ppos; count > 0 && i < nvram_len; ++i, ++p, --count) {
-		if (__get_user(c, p))
-			return -EFAULT;
-		arch_nvram_ops.write_byte(c, i);
-	}
-	*ppos = i;
-	return p - buf;
-}
-
-static int nvram_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	switch(cmd) {
-#ifdef CONFIG_PPC_PMAC
-	case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
-		printk(KERN_WARNING "nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n");
-	case IOC_NVRAM_GET_OFFSET: {
-		int part, offset;
-
-		if (!machine_is(powermac))
-			return -EINVAL;
-		if (copy_from_user(&part, (void __user*)arg, sizeof(part)) != 0)
-			return -EFAULT;
-		if (part < pmac_nvram_OF || part > pmac_nvram_NR)
-			return -EINVAL;
-		offset = pmac_get_partition(part);
-		if (copy_to_user((void __user*)arg, &offset, sizeof(offset)) != 0)
-			return -EFAULT;
-		break;
-	}
-#endif /* CONFIG_PPC_PMAC */
-	case IOC_NVRAM_SYNC:
-		arch_nvram_ops.sync();
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static long nvram_unlocked_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	int ret;
-
-	mutex_lock(&nvram_mutex);
-	ret = nvram_ioctl(file, cmd, arg);
-	mutex_unlock(&nvram_mutex);
-
-	return ret;
-}
-
-const struct file_operations nvram_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= nvram_llseek,
-	.read		= read_nvram,
-	.write		= write_nvram,
-	.unlocked_ioctl	= nvram_unlocked_ioctl,
-};
-
-static struct miscdevice nvram_dev = {
-	NVRAM_MINOR,
-	"nvram",
-	&nvram_fops
-};
-
-int __init nvram_init(void)
-{
-	int ret;
-
-	if (arch_nvram_ops.get_size == NULL)
-		return -ENODEV;
-
-	nvram_len = arch_nvram_ops.get_size();
-	if (nvram_len < 0)
-		return nvram_len;
-
-	ret = misc_register(&nvram_dev);
-	if (ret)
-		return ret;
-
-	pr_info("Generic non-volatile memory driver v%s\n", NVRAM_VERSION);
-
-	return 0;
-}
-
-void __exit nvram_cleanup(void)
-{
-        misc_deregister( &nvram_dev );
-}
-
-module_init(nvram_init);
-module_exit(nvram_cleanup);
-MODULE_LICENSE("GPL");
