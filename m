Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD61C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 04:17:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3471E214C6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 04:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3471E214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Pfp40j3WzDqHZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 15:17:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43PfDG3XJ1zDqJm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2018 14:51:58 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 0D8862951E; Tue, 25 Dec 2018 19:43:56 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-Id: <9b9b4218e6a2a3da0a73a190eba085267989c0b4.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 08/25] char/nvram: Implement NVRAM read/write methods
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

Refactor the RTC "CMOS" NVRAM functions so that they can be used as
arch_nvram_ops methods. Checksumming logic is moved from the misc device
operations to the nvram read/write operations.

This makes the misc device implementation more generic. This also
preserves the locking semantics such that "read if checksum valid" and
"write and update checksum" remain atomic operations.

Some platforms implement byte-range read/write methods which are similar
to file_operations struct methods. Other platforms provide only
byte-at-a-time functions. The misc device driver prefers to use the
former but will fall back on the latter.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Changed since v7:
 - Use memdup_user(), like arch/powerpc/kernel/nvram_64.c.
---
 drivers/char/nvram.c | 149 ++++++++++++++++++++++++++++++-------------
 1 file changed, 104 insertions(+), 45 deletions(-)

diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index 33ef3b02d365..889123ddace4 100644
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
@@ -178,9 +179,48 @@ static ssize_t nvram_get_size(void)
 	return NVRAM_BYTES;
 }
 
+static ssize_t nvram_read(char *buf, size_t count, loff_t *ppos)
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
+static ssize_t nvram_write(char *buf, size_t count, loff_t *ppos)
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
 	.read_byte      = nvram_read_byte,
 	.write_byte     = nvram_write_byte,
+	.read           = nvram_read,
+	.write          = nvram_write,
 	.get_size       = nvram_get_size,
 	.set_checksum   = nvram_set_checksum,
 	.initialize     = nvram_initialize,
@@ -201,69 +241,88 @@ static loff_t nvram_misc_llseek(struct file *file, loff_t offset, int origin)
 static ssize_t nvram_misc_read(struct file *file, char __user *buf,
 			       size_t count, loff_t *ppos)
 {
-	unsigned char contents[NVRAM_BYTES];
-	unsigned i = *ppos;
-	unsigned char *tmp;
-
-	spin_lock_irq(&rtc_lock);
-
-	if (!__nvram_check_checksum())
-		goto checksum_err;
+	loff_t i;
+	char __user *p = buf;
 
-	for (tmp = contents; count-- > 0 && i < NVRAM_BYTES; ++i, ++tmp)
-		*tmp = __nvram_read_byte(i);
-
-	spin_unlock_irq(&rtc_lock);
-
-	if (copy_to_user(buf, contents, tmp - contents))
+	if (!access_ok(VERIFY_WRITE, buf, count))
 		return -EFAULT;
+	if (*ppos >= nvram_size)
+		return 0;
+
+	/* If the arch provided a byte range read op, use it. Otherwise
+	 * fall back on the byte-at-a-time accessor.
+	 */
+	if (arch_nvram_ops.read != NULL) {
+		char *tmp;
+		ssize_t ret;
+
+		count = min_t(size_t, count, nvram_size - *ppos);
+		count = min_t(size_t, count, PAGE_SIZE);
+
+		tmp = kmalloc(count, GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+
+		ret = arch_nvram_ops.read(tmp, count, ppos);
+		if (ret <= 0)
+			goto out;
+
+		if (copy_to_user(buf, tmp, ret)) {
+			*ppos -= ret;
+			ret = -EFAULT;
+		}
 
-	*ppos = i;
-
-	return tmp - contents;
+out:
+		kfree(tmp);
+		return ret;
+	}
 
-checksum_err:
-	spin_unlock_irq(&rtc_lock);
-	return -EIO;
+	for (i = *ppos; count > 0 && i < nvram_size; ++i, ++p, --count)
+		if (__put_user(arch_nvram_ops.read_byte(i), p))
+			return -EFAULT;
+	*ppos = i;
+	return p - buf;
 }
 
 static ssize_t nvram_misc_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	unsigned char contents[NVRAM_BYTES];
-	unsigned i = *ppos;
-	unsigned char *tmp;
+	loff_t i;
+	const char __user *p = buf;
 
-	if (i >= NVRAM_BYTES)
-		return 0;	/* Past EOF */
-
-	if (count > NVRAM_BYTES - i)
-		count = NVRAM_BYTES - i;
-	if (count > NVRAM_BYTES)
-		return -EFAULT;	/* Can't happen, but prove it to gcc */
-
-	if (copy_from_user(contents, buf, count))
+	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
+	if (*ppos >= nvram_size)
+		return 0;
 
-	spin_lock_irq(&rtc_lock);
+	/* If the arch provided a byte range write op, use it. Otherwise
+	 * fall back on the byte-at-a-time accessor.
+	 */
+	if (arch_nvram_ops.write != NULL) {
+		char *tmp;
+		ssize_t ret;
 
-	if (!__nvram_check_checksum())
-		goto checksum_err;
+		count = min_t(size_t, count, nvram_size - *ppos);
+		count = min_t(size_t, count, PAGE_SIZE);
 
-	for (tmp = contents; count--; ++i, ++tmp)
-		__nvram_write_byte(*tmp, i);
+		tmp = memdup_user(buf, count);
+		if (IS_ERR(tmp))
+			return PTR_ERR(tmp);
 
-	__nvram_set_checksum();
+		ret = arch_nvram_ops.write(tmp, count, ppos);
+		kfree(tmp);
+		return ret;
+	}
 
-	spin_unlock_irq(&rtc_lock);
+	for (i = *ppos; count > 0 && i < nvram_size; ++i, ++p, --count) {
+		char c;
 
+		if (__get_user(c, p))
+			return -EFAULT;
+		arch_nvram_ops.write_byte(c, i);
+	}
 	*ppos = i;
-
-	return tmp - contents;
-
-checksum_err:
-	spin_unlock_irq(&rtc_lock);
-	return -EIO;
+	return p - buf;
 }
 
 static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
-- 
2.19.2

