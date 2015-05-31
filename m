Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id A64FE1A0CAB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:17:02 +1000 (AEST)
Message-Id: <20150531010134.619479588@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:41 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC 09/24] char/nvram: Implement NVRAM read/write methods
References: <20150531010132.289674310@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Refactor the RTC "CMOS" NVRAM functions so that they can be used as
arch_nvram_ops methods. Checksumming logic is moved from the misc device
operations to the nvram read/write operations.

This makes the misc device implementation more generic. This also
preserves the locking semantics such that "read if checksum valid" and
"write and update checksum" remain atomic operations.

PPC64 implements byte-range read/write methods which are similar to
file_operations struct methods. Other platforms provide only
byte-at-a-time functions. So the misc device prefers the former but
will fall back on the latter.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 drivers/char/nvram.c |  162 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 114 insertions(+), 48 deletions(-)

Index: linux/drivers/char/nvram.c
===================================================================
--- linux.orig/drivers/char/nvram.c	2015-05-31 11:01:08.000000000 +1000
+++ linux/drivers/char/nvram.c	2015-05-31 11:01:09.000000000 +1000
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
@@ -215,69 +255,95 @@ static loff_t nvram_misc_llseek(struct f
 static ssize_t nvram_misc_read(struct file *file, char __user *buf,
                                size_t count, loff_t *ppos)
 {
-	unsigned char contents[NVRAM_BYTES];
-	unsigned i = *ppos;
-	unsigned char *tmp;
-
-	spin_lock_irq(&rtc_lock);
+	loff_t i;
+	char __user *p = buf;
 
-	if (!__nvram_check_checksum())
-		goto checksum_err;
-
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
 
-	*ppos = i;
-
-	return tmp - contents;
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
+
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
-
-	if (i >= NVRAM_BYTES)
-		return 0;	/* Past EOF */
-
-	if (count > NVRAM_BYTES - i)
-		count = NVRAM_BYTES - i;
-	if (count > NVRAM_BYTES)
-		return -EFAULT;	/* Can't happen, but prove it to gcc */
+	loff_t i;
+	const char __user *p = buf;
 
-	if (copy_from_user(contents, buf, count))
+	if (!access_ok(VERIFY_READ, buf, count))
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
-
-	__nvram_set_checksum();
+	/* If the arch provided a byte range write op, use it. Otherwise
+	 * fall back on the byte-at-a-time accessor.
+	 */
+	if (arch_nvram_ops.write != NULL) {
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
+		if (copy_from_user(tmp, buf, count)) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		ret = arch_nvram_ops.write(tmp, count, ppos);
+
+out:
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
