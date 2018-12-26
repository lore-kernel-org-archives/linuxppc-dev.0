Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42DAC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 04:11:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCE721720
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 04:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCE721720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43PfgC0RHGzDqM6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 15:11:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43PfDG2lwLzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2018 14:51:58 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 1C87C29530; Tue, 25 Dec 2018 19:43:57 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-Id: <464cbf22659dfc5a821f7f2389f07fb4cac06f05.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 23/25] char/generic_nvram: Remove as unused
Date: Wed, 26 Dec 2018 11:37:59 +1100
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

Thereby eliminating some twisted CONFIG_NVRAM logic.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/char/Makefile        |   6 +-
 drivers/char/generic_nvram.c | 160 -----------------------------------
 2 files changed, 1 insertion(+), 165 deletions(-)
 delete mode 100644 drivers/char/generic_nvram.c

diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index b8d42b4e979b..fbea7dd12932 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -26,11 +26,7 @@ obj-$(CONFIG_RTC)		+= rtc.o
 obj-$(CONFIG_HPET)		+= hpet.o
 obj-$(CONFIG_EFI_RTC)		+= efirtc.o
 obj-$(CONFIG_XILINX_HWICAP)	+= xilinx_hwicap/
-ifeq ($(CONFIG_GENERIC_NVRAM),y)
-  obj-$(CONFIG_NVRAM)	+= generic_nvram.o
-else
-  obj-$(CONFIG_NVRAM)	+= nvram.o
-endif
+obj-$(CONFIG_NVRAM)		+= nvram.o
 obj-$(CONFIG_TOSHIBA)		+= toshiba.o
 obj-$(CONFIG_DS1620)		+= ds1620.o
 obj-$(CONFIG_HW_RANDOM)		+= hw_random/
diff --git a/drivers/char/generic_nvram.c b/drivers/char/generic_nvram.c
deleted file mode 100644
index 41b76bf9614e..000000000000
--- a/drivers/char/generic_nvram.c
+++ /dev/null
@@ -1,160 +0,0 @@
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
-#include <linux/pagemap.h>
-#include <linux/uaccess.h>
-#include <asm/nvram.h>
-#ifdef CONFIG_PPC_PMAC
-#include <asm/machdep.h>
-#endif
-
-static DEFINE_MUTEX(nvram_mutex);
-static ssize_t nvram_len;
-
-static loff_t nvram_llseek(struct file *file, loff_t offset, int origin)
-{
-	return generic_file_llseek_size(file, offset, origin,
-					MAX_LFS_FILESIZE, nvram_len);
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
-- 
2.19.2

