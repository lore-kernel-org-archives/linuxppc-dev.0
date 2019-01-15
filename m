Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F31C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:40:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB9320859
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB9320859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dyMG1wmMzDqbC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:40:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43dxyF2rdXzDqWy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 15:22:28 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 4DB2F29E6B; Mon, 14 Jan 2019 23:22:24 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-Id: <24c1282d42d7d996cdc5c1a6c4dfd979af5a3ff7.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v9 09/22] char/nvram: Implement NVRAM read/write methods
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

Refactor the RTC "CMOS" NVRAM functions so that they can be used as
arch_nvram_ops methods. Checksumming logic is moved from the misc device
operations to the nvram read/write operations. This makes the misc device
implementation more generic.

This preserves the locking mechanism such that "read if checksum valid"
and "write and update checksum" remain atomic operations.

Some platforms implement byte-range read/write methods which are similar
to file_operations struct methods. Other platforms provide only
byte-at-a-time methods. The former are more efficient but may be
unavailable so fall back on the latter methods when necessary.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Changed since v8:
 - Renamed nvram_* functions to avoid name collisions.
 - Added nvram_read_bytes() and nvram_write_bytes() helpers for use by
those platforms which access NVRAM only one-byte-at-a-time.

Changed since v7:
 - Adopted memdup_user(), like arch/powerpc/kernel/nvram_64.c.
---
 drivers/char/nvram.c  | 120 ++++++++++++++++++++++++++----------------
 include/linux/nvram.h |  32 ++++++++++-
 2 files changed, 104 insertions(+), 48 deletions(-)

diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index f88ef41d0598..adcc213c331e 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -41,6 +41,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
@@ -161,7 +162,46 @@ static ssize_t pc_nvram_get_size(void)
 	return NVRAM_BYTES;
 }
 
+static ssize_t pc_nvram_read(char *buf, size_t count, loff_t *ppos)
+{
+	char *p = buf;
+	loff_t i;
+
+	spin_lock_irq(&rtc_lock);
+	if (!__nvram_check_checksum()) {
+		spin_unlock_irq(&rtc_lock);
+		return -EIO;
+	}
+	for (i = *ppos; count > 0 && i < NVRAM_BYTES; --count, ++i, ++p)
+		*p = __nvram_read_byte(i);
+	spin_unlock_irq(&rtc_lock);
+
+	*ppos = i;
+	return p - buf;
+}
+
+static ssize_t pc_nvram_write(char *buf, size_t count, loff_t *ppos)
+{
+	char *p = buf;
+	loff_t i;
+
+	spin_lock_irq(&rtc_lock);
+	if (!__nvram_check_checksum()) {
+		spin_unlock_irq(&rtc_lock);
+		return -EIO;
+	}
+	for (i = *ppos; count > 0 && i < NVRAM_BYTES; --count, ++i, ++p)
+		__nvram_write_byte(*p, i);
+	__nvram_set_checksum();
+	spin_unlock_irq(&rtc_lock);
+
+	*ppos = i;
+	return p - buf;
+}
+
 const struct nvram_ops arch_nvram_ops = {
+	.read           = pc_nvram_read,
+	.write          = pc_nvram_write,
 	.read_byte      = pc_nvram_read_byte,
 	.write_byte     = pc_nvram_write_byte,
 	.get_size       = pc_nvram_get_size,
@@ -184,69 +224,57 @@ static loff_t nvram_misc_llseek(struct file *file, loff_t offset, int origin)
 static ssize_t nvram_misc_read(struct file *file, char __user *buf,
 			       size_t count, loff_t *ppos)
 {
-	unsigned char contents[NVRAM_BYTES];
-	unsigned i = *ppos;
-	unsigned char *tmp;
-
-	spin_lock_irq(&rtc_lock);
+	char *tmp;
+	ssize_t ret;
 
-	if (!__nvram_check_checksum())
-		goto checksum_err;
 
-	for (tmp = contents; count-- > 0 && i < NVRAM_BYTES; ++i, ++tmp)
-		*tmp = __nvram_read_byte(i);
+	if (!access_ok(buf, count))
+		return -EFAULT;
+	if (*ppos >= nvram_size)
+		return 0;
 
-	spin_unlock_irq(&rtc_lock);
+	count = min_t(size_t, count, nvram_size - *ppos);
+	count = min_t(size_t, count, PAGE_SIZE);
 
-	if (copy_to_user(buf, contents, tmp - contents))
-		return -EFAULT;
+	tmp = kmalloc(count, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
 
-	*ppos = i;
+	ret = nvram_read(tmp, count, ppos);
+	if (ret <= 0)
+		goto out;
 
-	return tmp - contents;
+	if (copy_to_user(buf, tmp, ret)) {
+		*ppos -= ret;
+		ret = -EFAULT;
+	}
 
-checksum_err:
-	spin_unlock_irq(&rtc_lock);
-	return -EIO;
+out:
+	kfree(tmp);
+	return ret;
 }
 
 static ssize_t nvram_misc_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	unsigned char contents[NVRAM_BYTES];
-	unsigned i = *ppos;
-	unsigned char *tmp;
-
-	if (i >= NVRAM_BYTES)
-		return 0;	/* Past EOF */
-
-	if (count > NVRAM_BYTES - i)
-		count = NVRAM_BYTES - i;
-	if (count > NVRAM_BYTES)
-		return -EFAULT;	/* Can't happen, but prove it to gcc */
+	char *tmp;
+	ssize_t ret;
 
-	if (copy_from_user(contents, buf, count))
+	if (!access_ok(buf, count))
 		return -EFAULT;
+	if (*ppos >= nvram_size)
+		return 0;
 
-	spin_lock_irq(&rtc_lock);
-
-	if (!__nvram_check_checksum())
-		goto checksum_err;
-
-	for (tmp = contents; count--; ++i, ++tmp)
-		__nvram_write_byte(*tmp, i);
+	count = min_t(size_t, count, nvram_size - *ppos);
+	count = min_t(size_t, count, PAGE_SIZE);
 
-	__nvram_set_checksum();
-
-	spin_unlock_irq(&rtc_lock);
+	tmp = memdup_user(buf, count);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
 
-	*ppos = i;
-
-	return tmp - contents;
-
-checksum_err:
-	spin_unlock_irq(&rtc_lock);
-	return -EIO;
+	ret = nvram_write(tmp, count, ppos);
+	kfree(tmp);
+	return ret;
 }
 
 static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
diff --git a/include/linux/nvram.h b/include/linux/nvram.h
index 31c763087746..9df85703735c 100644
--- a/include/linux/nvram.h
+++ b/include/linux/nvram.h
@@ -66,18 +66,46 @@ static inline void nvram_write_byte(unsigned char val, int addr)
 #endif
 }
 
+static inline ssize_t nvram_read_bytes(char *buf, size_t count, loff_t *ppos)
+{
+	ssize_t nvram_size = nvram_get_size();
+	loff_t i;
+	char *p = buf;
+
+	if (nvram_size < 0)
+		return nvram_size;
+	for (i = *ppos; count > 0 && i < nvram_size; ++i, ++p, --count)
+		*p = nvram_read_byte(i);
+	*ppos = i;
+	return p - buf;
+}
+
+static inline ssize_t nvram_write_bytes(char *buf, size_t count, loff_t *ppos)
+{
+	ssize_t nvram_size = nvram_get_size();
+	loff_t i;
+	char *p = buf;
+
+	if (nvram_size < 0)
+		return nvram_size;
+	for (i = *ppos; count > 0 && i < nvram_size; ++i, ++p, --count)
+		nvram_write_byte(*p, i);
+	*ppos = i;
+	return p - buf;
+}
+
 static inline ssize_t nvram_read(char *buf, size_t count, loff_t *ppos)
 {
 	if (arch_nvram_ops.read)
 		return arch_nvram_ops.read(buf, count, ppos);
-	return -ENODEV;
+	return nvram_read_bytes(buf, count, ppos);
 }
 
 static inline ssize_t nvram_write(char *buf, size_t count, loff_t *ppos)
 {
 	if (arch_nvram_ops.write)
 		return arch_nvram_ops.write(buf, count, ppos);
-	return -ENODEV;
+	return nvram_write_bytes(buf, count, ppos);
 }
 
 #endif  /* _LINUX_NVRAM_H */
-- 
2.19.2

