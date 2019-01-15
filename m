Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662F2C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:57:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E006B20656
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E006B20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dykq75NFzDqBj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:57:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43dxyG6ZXbzDqXJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 15:22:30 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 021A729E87; Mon, 14 Jan 2019 23:22:24 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-Id: <94c2689ae1bf690a82b427d0c4f96b197865e1a7.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v9 22/22] powerpc: Adopt nvram module for PPC64
Date: Tue, 15 Jan 2019 15:18:56 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Adopt nvram module to reduce code duplication. This means CONFIG_NVRAM
becomes available to PPC64 builds. Previously it was only available to
PPC32 builds because it depended on CONFIG_GENERIC_NVRAM.

The IOC_NVRAM_GET_OFFSET ioctl as implemented on PPC64 validates the
offset returned by pmac_get_partition(). Do the same in the nvram module.

Note that the old PPC32 generic_nvram module lacked this test.
So when CONFIG_PPC32 && CONFIG_PPC_PMAC, the IOC_NVRAM_GET_OFFSET ioctl
would have returned 0 (always). But when CONFIG_PPC64 && CONFIG_PPC_PMAC,
the IOC_NVRAM_GET_OFFSET ioctl would have returned -1 (which is -EPERM)
when the requested partition was not found.

With this patch, the result is now -EINVAL on both PPC32 and PPC64 when
the requested PowerMac NVRAM partition is not found. This is a userspace-
visible change, in the non-existent partition case, which would be in
an error path for an IOC_NVRAM_GET_OFFSET ioctl syscall.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
BTW, the IOC_NVRAM_SYNC ioctl call returns an error on PPC64. This patch
retains this behaviour though it might be better to actually perform a sync
since both PPC64 and PPC32 do implement ppc_md.nvram_sync() for Core99.

Changed since v8:
 - Dropped the arch_nvram_ops struct in favour of equivalent ppc_md
method calls. Regardless of the actual implementation, the presence of
this functionality is indicated by CONFIG_HAVE_ARCH_NVRAM_OPS=y.

Changed since v7:
 - Dropped pointless comment edit.
---
 arch/powerpc/Kconfig                     |   2 +-
 arch/powerpc/kernel/nvram_64.c           | 158 +----------------------
 arch/powerpc/platforms/powermac/Makefile |   2 -
 arch/powerpc/platforms/powermac/setup.c  |   2 +-
 arch/powerpc/platforms/powermac/time.c   |   2 +-
 arch/powerpc/platforms/pseries/nvram.c   |   2 -
 drivers/char/nvram.c                     |   4 +
 7 files changed, 9 insertions(+), 163 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f62e6a3f9c4e..621912365508 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -178,7 +178,7 @@ config PPC
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
-	select HAVE_ARCH_NVRAM_OPS		if PPC32
+	select HAVE_ARCH_NVRAM_OPS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_CBPF_JIT			if !PPC64
diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 38b03a330cd2..244d2462e781 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
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
 
 #include <linux/types.h>
@@ -714,137 +708,6 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
 	spin_unlock_irqrestore(&lock, flags);
 }
 
-static loff_t dev_nvram_llseek(struct file *file, loff_t offset, int origin)
-{
-	if (ppc_md.nvram_size == NULL)
-		return -ENODEV;
-	return generic_file_llseek_size(file, offset, origin, MAX_LFS_FILESIZE,
-					ppc_md.nvram_size());
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
-	tmp = memdup_user(buf, count);
-	if (IS_ERR(tmp)) {
-		ret = PTR_ERR(tmp);
-		goto out;
-	}
-
-	ret = ppc_md.nvram_write(tmp, count, ppos);
-
-	kfree(tmp);
-out:
-	return ret;
-}
-
-static long dev_nvram_ioctl(struct file *file, unsigned int cmd,
-			    unsigned long arg)
-{
-	switch(cmd) {
-#ifdef CONFIG_PPC_PMAC
-	case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
-		printk(KERN_WARNING "nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n");
-		/* fall through */
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
-static const struct file_operations nvram_fops = {
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
-
 #ifdef DEBUG_NVRAM
 static void __init nvram_print_partitions(char * label)
 {
@@ -992,6 +855,8 @@ loff_t __init nvram_create_partition(const char *name, int sig,
 	long size = 0;
 	int rc;
 
+	BUILD_BUG_ON(NVRAM_BLOCK_LEN != 16);
+
 	/* Convert sizes from bytes to blocks */
 	req_size = _ALIGN_UP(req_size, NVRAM_BLOCK_LEN) / NVRAM_BLOCK_LEN;
 	min_size = _ALIGN_UP(min_size, NVRAM_BLOCK_LEN) / NVRAM_BLOCK_LEN;
@@ -1192,22 +1057,3 @@ int __init nvram_scan_partitions(void)
 	kfree(header);
 	return err;
 }
-
-static int __init nvram_init(void)
-{
-	int rc;
-	
-	BUILD_BUG_ON(NVRAM_BLOCK_LEN != 16);
-
-	if (ppc_md.nvram_size == NULL || ppc_md.nvram_size() <= 0)
-		return  -ENODEV;
-
-  	rc = misc_register(&nvram_dev);
-	if (rc != 0) {
-		printk(KERN_ERR "nvram_init: failed to register device\n");
-		return rc;
-	}
-  	
-  	return rc;
-}
-device_initcall(nvram_init);
diff --git a/arch/powerpc/platforms/powermac/Makefile b/arch/powerpc/platforms/powermac/Makefile
index 923bfb340433..20ebf35d7913 100644
--- a/arch/powerpc/platforms/powermac/Makefile
+++ b/arch/powerpc/platforms/powermac/Makefile
@@ -15,7 +15,5 @@ obj-$(CONFIG_PMAC_BACKLIGHT)	+= backlight.o
 # need this to be a bool.  Cheat here and pretend CONFIG_NVRAM=m is really
 # CONFIG_NVRAM=y
 obj-$(CONFIG_NVRAM:m=y)		+= nvram.o
-# ppc64 pmac doesn't define CONFIG_NVRAM but needs nvram stuff
-obj-$(CONFIG_PPC64)		+= nvram.o
 obj-$(CONFIG_PPC32)		+= bootx_init.o
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index b47f49cf9c4d..b7efcf336589 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -316,7 +316,7 @@ static void __init pmac_setup_arch(void)
 	find_via_pmu();
 	smu_init();
 
-#if IS_ENABLED(CONFIG_NVRAM) || defined(CONFIG_PPC64)
+#if IS_ENABLED(CONFIG_NVRAM)
 	pmac_nvram_init();
 #endif
 #ifdef CONFIG_PPC32
diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index f157e3d071f2..b36ddee17c87 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -68,7 +68,7 @@
 long __init pmac_time_init(void)
 {
 	s32 delta = 0;
-#ifdef CONFIG_NVRAM
+#if defined(CONFIG_NVRAM) && defined(CONFIG_PPC32)
 	int dst;
 	
 	delta = ((s32)pmac_xpram_read(PMAC_XPRAM_MACHINE_LOC + 0x9)) << 16;
diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 69cedc1b3b8a..1136a38ff039 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -7,8 +7,6 @@
  *      2 of the License, or (at your option) any later version.
  *
  * /dev/nvram driver for PPC64
- *
- * This perhaps should live in drivers/char
  */
 
 
diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index 944f05fddacd..eff1e3f1b3a2 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -302,6 +302,8 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 			if (part < pmac_nvram_OF || part > pmac_nvram_NR)
 				return -EINVAL;
 			offset = pmac_get_partition(part);
+			if (offset < 0)
+				return -EINVAL;
 			if (copy_to_user((void __user *)arg,
 					 &offset, sizeof(offset)) != 0)
 				return -EFAULT;
@@ -309,6 +311,7 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 		}
 #endif
 		break;
+#ifdef CONFIG_PPC32
 	case IOC_NVRAM_SYNC:
 		if (ppc_md.nvram_sync != NULL) {
 			mutex_lock(&nvram_mutex);
@@ -317,6 +320,7 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 		}
 		ret = 0;
 		break;
+#endif
 #elif defined(CONFIG_X86) || defined(CONFIG_M68K)
 	case NVRAM_INIT:
 		/* initialize NVRAM contents and checksum */
-- 
2.19.2

