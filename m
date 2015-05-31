Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 9E36C1A0CA6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:17:02 +1000 (AEST)
Message-Id: <20150531010137.569476861@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:53 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC 21/24] powerpc: Adopt nvram module for PPC64
References: <20150531010132.289674310@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adopt nvram module to reduce code duplication.

The IOC_NVRAM_GET_OFFSET ioctl as implemented on PPC64 validates the offset
returned by pmac_get_partition(). Add this test to the nvram module.

Note that the old PPC32 generic_nvram module lacked this test.
So when CONFIG_PPC32 && CONFIG_PPC_PMAC, the IOC_NVRAM_GET_OFFSET ioctl
would have returned 0 (always). But when CONFIG_PPC64 && CONFIG_PPC_PMAC,
the IOC_NVRAM_GET_OFFSET ioctl would have returned -1 (which is -EPERM)
when the requested partition was not found.

With this patch, the result is now -ENOENT on both PPC32 and PPC64 when
the requested PowerMac NVRAM partition is not found.

This is a userspace-visible change, in the non-existent partition case,
which would be in an error path for an IOC_NVRAM_GET_OFFSET ioctl syscall.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---

BTW, the IOC_NVRAM_SYNC ioctl call returns -EINVAL on PPC64. This patch
retains this behaviour though it might be better to actually perform a sync.
Both PPC64 and PPC32 kernels implement ppc_md.nvram_sync() for Core99,
but on PPC64 the ioctl is unimplemented (unlike PPC32).

---
 arch/powerpc/Kconfig                     |    3 
 arch/powerpc/kernel/nvram_64.c           |  203 ++++---------------------------
 arch/powerpc/platforms/powermac/Makefile |    5 
 arch/powerpc/platforms/powermac/nvram.c  |    2 
 arch/powerpc/platforms/powermac/setup.c  |    2 
 drivers/char/nvram.c                     |    2 
 6 files changed, 38 insertions(+), 179 deletions(-)

Index: linux/arch/powerpc/Kconfig
===================================================================
--- linux.orig/arch/powerpc/Kconfig	2015-05-31 11:01:22.000000000 +1000
+++ linux/arch/powerpc/Kconfig	2015-05-31 11:01:24.000000000 +1000
@@ -177,10 +177,9 @@ config SYSVIPC_COMPAT
 	depends on COMPAT && SYSVIPC
 	default y
 
-# All PPC32s use generic nvram driver through ppc_md
 config HAVE_ARCH_NVRAM_OPS
 	bool
-	default y if PPC32
+	default y
 
 config SCHED_OMIT_FRAME_POINTER
 	bool
Index: linux/arch/powerpc/kernel/nvram_64.c
===================================================================
--- linux.orig/arch/powerpc/kernel/nvram_64.c	2015-05-31 11:00:59.000000000 +1000
+++ linux/arch/powerpc/kernel/nvram_64.c	2015-05-31 11:01:25.000000000 +1000
@@ -7,12 +7,6 @@
  *      2 of the License, or (at your option) any later version.
  *
  * /dev/nvram driver for PPC64
- *
- * This perhaps should live in drivers/char
- *
- * TODO: Split the /dev/nvram part (that one can use
- *       drivers/char/generic_nvram.c) from the arch & partition
- *       parsing code.
  */
 
 #include <linux/module.h>
@@ -731,153 +725,6 @@ static void oops_to_nvram(struct kmsg_du
 	spin_unlock_irqrestore(&lock, flags);
 }
 
-static loff_t dev_nvram_llseek(struct file *file, loff_t offset, int origin)
-{
-	int size;
-
-	if (ppc_md.nvram_size == NULL)
-		return -ENODEV;
-	size = ppc_md.nvram_size();
-
-	switch (origin) {
-	case 1:
-		offset += file->f_pos;
-		break;
-	case 2:
-		offset += size;
-		break;
-	}
-	if (offset < 0)
-		return -EINVAL;
-	file->f_pos = offset;
-	return file->f_pos;
-}
-
-
-static ssize_t dev_nvram_read(struct file *file, char __user *buf,
-			  size_t count, loff_t *ppos)
-{
-	ssize_t ret;
-	char *tmp = NULL;
-	ssize_t size;
-
-	if (!ppc_md.nvram_size) {
-		ret = -ENODEV;
-		goto out;
-	}
-
-	size = ppc_md.nvram_size();
-	if (size < 0) {
-		ret = size;
-		goto out;
-	}
-
-	if (*ppos >= size) {
-		ret = 0;
-		goto out;
-	}
-
-	count = min_t(size_t, count, size - *ppos);
-	count = min(count, PAGE_SIZE);
-
-	tmp = kmalloc(count, GFP_KERNEL);
-	if (!tmp) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	ret = ppc_md.nvram_read(tmp, count, ppos);
-	if (ret <= 0)
-		goto out;
-
-	if (copy_to_user(buf, tmp, ret))
-		ret = -EFAULT;
-
-out:
-	kfree(tmp);
-	return ret;
-
-}
-
-static ssize_t dev_nvram_write(struct file *file, const char __user *buf,
-			  size_t count, loff_t *ppos)
-{
-	ssize_t ret;
-	char *tmp = NULL;
-	ssize_t size;
-
-	ret = -ENODEV;
-	if (!ppc_md.nvram_size)
-		goto out;
-
-	ret = 0;
-	size = ppc_md.nvram_size();
-	if (*ppos >= size || size < 0)
-		goto out;
-
-	count = min_t(size_t, count, size - *ppos);
-	count = min(count, PAGE_SIZE);
-
-	ret = -ENOMEM;
-	tmp = kmalloc(count, GFP_KERNEL);
-	if (!tmp)
-		goto out;
-
-	ret = -EFAULT;
-	if (copy_from_user(tmp, buf, count))
-		goto out;
-
-	ret = ppc_md.nvram_write(tmp, count, ppos);
-
-out:
-	kfree(tmp);
-	return ret;
-
-}
-
-static long dev_nvram_ioctl(struct file *file, unsigned int cmd,
-			    unsigned long arg)
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
-		if (offset < 0)
-			return offset;
-		if (copy_to_user((void __user*)arg, &offset, sizeof(offset)) != 0)
-			return -EFAULT;
-		return 0;
-	}
-#endif /* CONFIG_PPC_PMAC */
-	default:
-		return -EINVAL;
-	}
-}
-
-const struct file_operations nvram_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= dev_nvram_llseek,
-	.read		= dev_nvram_read,
-	.write		= dev_nvram_write,
-	.unlocked_ioctl	= dev_nvram_ioctl,
-};
-
-static struct miscdevice nvram_dev = {
-	NVRAM_MINOR,
-	"nvram",
-	&nvram_fops
-};
-
 
 #ifdef DEBUG_NVRAM
 static void __init nvram_print_partitions(char * label)
@@ -1026,6 +873,8 @@ loff_t __init nvram_create_partition(con
 	long size = 0;
 	int rc;
 
+	BUILD_BUG_ON(NVRAM_BLOCK_LEN != 16);
+
 	/* Convert sizes from bytes to blocks */
 	req_size = _ALIGN_UP(req_size, NVRAM_BLOCK_LEN) / NVRAM_BLOCK_LEN;
 	min_size = _ALIGN_UP(min_size, NVRAM_BLOCK_LEN) / NVRAM_BLOCK_LEN;
@@ -1226,29 +1075,41 @@ int __init nvram_scan_partitions(void)
 	return err;
 }
 
-static int __init nvram_init(void)
+
+#if IS_ENABLED(CONFIG_NVRAM)
+
+static ssize_t ppc_nvram_read(char *buf, size_t count, loff_t *index)
 {
-	int rc;
-	
-	BUILD_BUG_ON(NVRAM_BLOCK_LEN != 16);
+	if (ppc_md.nvram_read)
+		return ppc_md.nvram_read(buf, count, index);
+	return -EINVAL;
+}
 
-	if (ppc_md.nvram_size == NULL || ppc_md.nvram_size() <= 0)
-		return  -ENODEV;
+static ssize_t ppc_nvram_write(char *buf, size_t count, loff_t *index)
+{
+	if (ppc_md.nvram_write)
+		return ppc_md.nvram_write(buf, count, index);
+	return -EINVAL;
+}
 
-  	rc = misc_register(&nvram_dev);
-	if (rc != 0) {
-		printk(KERN_ERR "nvram_init: failed to register device\n");
-		return rc;
-	}
-  	
-  	return rc;
+static ssize_t ppc_nvram_get_size(void)
+{
+	if (ppc_md.nvram_size)
+		return ppc_md.nvram_size();
+	return -ENODEV;
 }
 
-static void __exit nvram_cleanup(void)
+static long ppc_nvram_sync(void)
 {
-        misc_deregister( &nvram_dev );
+	return -EINVAL;
 }
 
-module_init(nvram_init);
-module_exit(nvram_cleanup);
-MODULE_LICENSE("GPL");
+const struct nvram_ops arch_nvram_ops = {
+	.read           = ppc_nvram_read,
+	.write          = ppc_nvram_write,
+	.get_size       = ppc_nvram_get_size,
+	.sync           = ppc_nvram_sync,
+};
+EXPORT_SYMBOL(arch_nvram_ops);
+
+#endif /* CONFIG_NVRAM */
Index: linux/arch/powerpc/platforms/powermac/Makefile
===================================================================
--- linux.orig/arch/powerpc/platforms/powermac/Makefile	2015-05-31 11:00:59.000000000 +1000
+++ linux/arch/powerpc/platforms/powermac/Makefile	2015-05-31 11:01:25.000000000 +1000
@@ -9,11 +9,6 @@ obj-y				+= pic.o setup.o time.o feature
 				   sleep.o low_i2c.o cache.o pfunc_core.o \
 				   pfunc_base.o udbg_scc.o udbg_adb.o
 obj-$(CONFIG_PMAC_BACKLIGHT)	+= backlight.o
-# CONFIG_NVRAM is an arch. independent tristate symbol, for pmac32 we really
-# need this to be a bool.  Cheat here and pretend CONFIG_NVRAM=m is really
-# CONFIG_NVRAM=y
 obj-$(CONFIG_NVRAM:m=y)		+= nvram.o
-# ppc64 pmac doesn't define CONFIG_NVRAM but needs nvram stuff
-obj-$(CONFIG_PPC64)		+= nvram.o
 obj-$(CONFIG_PPC32)		+= bootx_init.o
 obj-$(CONFIG_SMP)		+= smp.o
Index: linux/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- linux.orig/arch/powerpc/platforms/powermac/setup.c	2015-05-31 11:01:22.000000000 +1000
+++ linux/arch/powerpc/platforms/powermac/setup.c	2015-05-31 11:01:25.000000000 +1000
@@ -321,7 +321,7 @@ static void __init pmac_setup_arch(void)
 	find_via_pmu();
 	smu_init();
 
-#if IS_ENABLED(CONFIG_NVRAM) || defined(CONFIG_PPC64)
+#if IS_ENABLED(CONFIG_NVRAM)
 	pmac_nvram_init();
 #endif
 
Index: linux/drivers/char/nvram.c
===================================================================
--- linux.orig/drivers/char/nvram.c	2015-05-31 11:01:21.000000000 +1000
+++ linux/drivers/char/nvram.c	2015-05-31 11:01:25.000000000 +1000
@@ -342,6 +342,8 @@ static long nvram_misc_ioctl(struct file
 		if (part < pmac_nvram_OF || part > pmac_nvram_NR)
 			return -EINVAL;
 		offset = pmac_get_partition(part);
+		if (offset < 0)
+			return offset;
 		if (copy_to_user((void __user *)arg,
 		                 &offset, sizeof(offset)) != 0)
 			return -EFAULT;
Index: linux/arch/powerpc/platforms/powermac/nvram.c
===================================================================
--- linux.orig/arch/powerpc/platforms/powermac/nvram.c	2015-05-31 11:01:15.000000000 +1000
+++ linux/arch/powerpc/platforms/powermac/nvram.c	2015-05-31 11:01:25.000000000 +1000
@@ -629,6 +629,8 @@ bail:
 
 int pmac_get_partition(int partition)
 {
+	if (nvram_partitions[partition] < 0)
+		return -ENOENT;
 	return nvram_partitions[partition];
 }
 
