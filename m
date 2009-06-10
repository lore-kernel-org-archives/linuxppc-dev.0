Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 17920B7326
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:29 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 31/33] ps3: Replace direct file operations by callback
Date: Wed, 10 Jun 2009 16:39:06 +0200
Message-Id: <1244644748-24211-32-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-31-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-16-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-17-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-18-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-19-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-20-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-21-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-22-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-23-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-24-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-25-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-26-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-27-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-28-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-29-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-30-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-31-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the FLASH database is updated by the kernel using file operations,
meant for userspace only. While this works for us because copy_{from,to}_user()
on powerpc can handle kernel pointers, this is unportable and a bad example.
Replace the file operations by callbacks, registered by the ps3flash driver.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/include/asm/ps3.h       |    7 ++
 arch/powerpc/platforms/ps3/os-area.c |  138 ++++++++++++++++++---------------
 drivers/char/ps3flash.c              |   94 +++++++++++++++++------
 3 files changed, 152 insertions(+), 87 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
index 7660694..7f065e1 100644
--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -53,6 +53,13 @@ enum ps3_param_av_multi_out ps3_os_area_get_av_multi_out(void);
 extern u64 ps3_os_area_get_rtc_diff(void);
 extern void ps3_os_area_set_rtc_diff(u64 rtc_diff);
 
+struct ps3_os_area_flash_ops {
+	ssize_t (*read)(void *buf, size_t count, loff_t pos);
+	ssize_t (*write)(const void *buf, size_t count, loff_t pos);
+};
+
+extern void ps3_os_area_flash_register(const struct ps3_os_area_flash_ops *ops);
+
 /* dma routines */
 
 enum ps3_dma_page_size {
diff --git a/arch/powerpc/platforms/ps3/os-area.c b/arch/powerpc/platforms/ps3/os-area.c
index 6e4125d..d6487a9 100644
--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -226,6 +226,44 @@ static struct property property_av_multi_out = {
 	.value = &saved_params.av_multi_out,
 };
 
+
+static DEFINE_MUTEX(os_area_flash_mutex);
+
+static const struct ps3_os_area_flash_ops *os_area_flash_ops;
+
+void ps3_os_area_flash_register(const struct ps3_os_area_flash_ops *ops)
+{
+	mutex_lock(&os_area_flash_mutex);
+	os_area_flash_ops = ops;
+	mutex_unlock(&os_area_flash_mutex);
+}
+EXPORT_SYMBOL_GPL(ps3_os_area_flash_register);
+
+static ssize_t os_area_flash_read(void *buf, size_t count, loff_t pos)
+{
+	ssize_t res = -ENODEV;
+
+	mutex_lock(&os_area_flash_mutex);
+	if (os_area_flash_ops)
+		res = os_area_flash_ops->read(buf, count, pos);
+	mutex_unlock(&os_area_flash_mutex);
+
+	return res;
+}
+
+static ssize_t os_area_flash_write(const void *buf, size_t count, loff_t pos)
+{
+	ssize_t res = -ENODEV;
+
+	mutex_lock(&os_area_flash_mutex);
+	if (os_area_flash_ops)
+		res = os_area_flash_ops->write(buf, count, pos);
+	mutex_unlock(&os_area_flash_mutex);
+
+	return res;
+}
+
+
 /**
  * os_area_set_property - Add or overwrite a saved_params value to the device tree.
  *
@@ -352,12 +390,12 @@ static int db_verify(const struct os_area_db *db)
 	if (memcmp(db->magic_num, OS_AREA_DB_MAGIC_NUM,
 		sizeof(db->magic_num))) {
 		pr_debug("%s:%d magic_num failed\n", __func__, __LINE__);
-		return -1;
+		return -EINVAL;
 	}
 
 	if (db->version != 1) {
 		pr_debug("%s:%d version failed\n", __func__, __LINE__);
-		return -1;
+		return -EINVAL;
 	}
 
 	return 0;
@@ -578,59 +616,48 @@ static void os_area_db_init(struct os_area_db *db)
  *
  */
 
-static void __maybe_unused update_flash_db(void)
+static int update_flash_db(void)
 {
-	int result;
-	int file;
-	off_t offset;
+	const unsigned int buf_len = 8 * OS_AREA_SEGMENT_SIZE;
+	struct os_area_header *header;
 	ssize_t count;
-	static const unsigned int buf_len = 8 * OS_AREA_SEGMENT_SIZE;
-	const struct os_area_header *header;
+	int error;
+	loff_t pos;
 	struct os_area_db* db;
 
 	/* Read in header and db from flash. */
 
-	file = sys_open("/dev/ps3flash", O_RDWR, 0);
-
-	if (file < 0) {
-		pr_debug("%s:%d sys_open failed\n", __func__, __LINE__);
-		goto fail_open;
-	}
-
 	header = kmalloc(buf_len, GFP_KERNEL);
-
 	if (!header) {
-		pr_debug("%s:%d kmalloc failed\n", __func__, __LINE__);
-		goto fail_malloc;
+		pr_debug("%s: kmalloc failed\n", __func__);
+		return -ENOMEM;
 	}
 
-	offset = sys_lseek(file, 0, SEEK_SET);
-
-	if (offset != 0) {
-		pr_debug("%s:%d sys_lseek failed\n", __func__, __LINE__);
-		goto fail_header_seek;
+	count = os_area_flash_read(header, buf_len, 0);
+	if (count < 0) {
+		pr_debug("%s: os_area_flash_read failed %zd\n", __func__,
+			 count);
+		error = count;
+		goto fail;
 	}
 
-	count = sys_read(file, (char __user *)header, buf_len);
-
-	result = count < OS_AREA_SEGMENT_SIZE || verify_header(header)
-		|| count < header->db_area_offset * OS_AREA_SEGMENT_SIZE;
-
-	if (result) {
-		pr_debug("%s:%d verify_header failed\n", __func__, __LINE__);
+	pos = header->db_area_offset * OS_AREA_SEGMENT_SIZE;
+	if (count < OS_AREA_SEGMENT_SIZE || verify_header(header) ||
+	    count < pos) {
+		pr_debug("%s: verify_header failed\n", __func__);
 		dump_header(header);
-		goto fail_header;
+		error = -EINVAL;
+		goto fail;
 	}
 
 	/* Now got a good db offset and some maybe good db data. */
 
-	db = (void*)header + header->db_area_offset * OS_AREA_SEGMENT_SIZE;
+	db = (void *)header + pos;
 
-	result = db_verify(db);
-
-	if (result) {
-		printk(KERN_NOTICE "%s:%d: Verify of flash database failed, "
-			"formatting.\n", __func__, __LINE__);
+	error = db_verify(db);
+	if (error) {
+		pr_notice("%s: Verify of flash database failed, formatting.\n",
+			  __func__);
 		dump_db(db);
 		os_area_db_init(db);
 	}
@@ -639,29 +666,16 @@ static void __maybe_unused update_flash_db(void)
 
 	db_set_64(db, &os_area_db_id_rtc_diff, saved_params.rtc_diff);
 
-	offset = sys_lseek(file, header->db_area_offset * OS_AREA_SEGMENT_SIZE,
-		SEEK_SET);
-
-	if (offset != header->db_area_offset * OS_AREA_SEGMENT_SIZE) {
-		pr_debug("%s:%d sys_lseek failed\n", __func__, __LINE__);
-		goto fail_db_seek;
-	}
-
-	count = sys_write(file, (const char __user *)db,
-		sizeof(struct os_area_db));
-
+	count = os_area_flash_write(db, sizeof(struct os_area_db), pos);
 	if (count < sizeof(struct os_area_db)) {
-		pr_debug("%s:%d sys_write failed\n", __func__, __LINE__);
+		pr_debug("%s: os_area_flash_write failed %zd\n", __func__,
+			 count);
+		error = count < 0 ? count : -EIO;
 	}
 
-fail_db_seek:
-fail_header:
-fail_header_seek:
+fail:
 	kfree(header);
-fail_malloc:
-	sys_close(file);
-fail_open:
-	return;
+	return error;
 }
 
 /**
@@ -674,11 +688,11 @@ fail_open:
 static void os_area_queue_work_handler(struct work_struct *work)
 {
 	struct device_node *node;
+	int error;
 
 	pr_debug(" -> %s:%d\n", __func__, __LINE__);
 
 	node = of_find_node_by_path("/");
-
 	if (node) {
 		os_area_set_property(node, &property_rtc_diff);
 		of_node_put(node);
@@ -686,12 +700,10 @@ static void os_area_queue_work_handler(struct work_struct *work)
 		pr_debug("%s:%d of_find_node_by_path failed\n",
 			__func__, __LINE__);
 
-#if defined(CONFIG_PS3_FLASH) || defined(CONFIG_PS3_FLASH_MODULE)
-	update_flash_db();
-#else
-	printk(KERN_WARNING "%s:%d: No flash rom driver configured.\n",
-		__func__, __LINE__);
-#endif
+	error = update_flash_db();
+	if (error)
+		pr_warning("%s: Could not update FLASH ROM\n", __func__);
+
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
 }
 
diff --git a/drivers/char/ps3flash.c b/drivers/char/ps3flash.c
index 184e6ed..f7f21f4 100644
--- a/drivers/char/ps3flash.c
+++ b/drivers/char/ps3flash.c
@@ -104,18 +104,19 @@ out:
 	return res;
 }
 
-static ssize_t ps3flash_read(struct file *file, char __user *buf, size_t count,
-			     loff_t *pos)
+static ssize_t ps3flash_read(char __user *userbuf, void *kernelbuf,
+			     size_t count, loff_t *pos)
 {
 	struct ps3_storage_device *dev = ps3flash_dev;
 	struct ps3flash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 	u64 size, start_sector, end_sector, offset;
 	ssize_t sectors_read;
 	size_t remaining, n;
+	const void *src;
 
 	dev_dbg(&dev->sbd.core,
-		"%s:%u: Reading %zu bytes at position %lld to user 0x%p\n",
-		__func__, __LINE__, count, *pos, buf);
+		"%s:%u: Reading %zu bytes at position %lld to U0x%p/K0x%p\n",
+		__func__, __LINE__, count, *pos, userbuf, kernelbuf);
 
 	size = dev->regions[dev->region_idx].size*dev->blk_size;
 	if (*pos >= size || !count)
@@ -145,19 +146,26 @@ static ssize_t ps3flash_read(struct file *file, char __user *buf, size_t count,
 		}
 
 		n = min_t(u64, remaining, sectors_read*dev->blk_size-offset);
+		src = dev->bounce_buf+offset;
 		dev_dbg(&dev->sbd.core,
-			"%s:%u: copy %lu bytes from 0x%p to user 0x%p\n",
-			__func__, __LINE__, n, dev->bounce_buf+offset, buf);
-		if (copy_to_user(buf, dev->bounce_buf+offset, n)) {
-			mutex_unlock(&priv->mutex);
-			sectors_read = -EFAULT;
-			goto fail;
+			"%s:%u: copy %lu bytes from 0x%p to U0x%p/K0x%p\n",
+			__func__, __LINE__, n, src, userbuf, kernelbuf);
+		if (userbuf) {
+			if (copy_to_user(userbuf, src, n)) {
+				mutex_unlock(&priv->mutex);
+				sectors_read = -EFAULT;
+				goto fail;
+			}
+			userbuf += n;
+		}
+		if (kernelbuf) {
+			memcpy(kernelbuf, src, n);
+			kernelbuf += n;
 		}
 
 		mutex_unlock(&priv->mutex);
 
 		*pos += n;
-		buf += n;
 		remaining -= n;
 		start_sector += sectors_read;
 		offset = 0;
@@ -169,8 +177,8 @@ fail:
 	return sectors_read;
 }
 
-static ssize_t ps3flash_write(struct file *file, const char __user *buf,
-			      size_t count, loff_t *pos)
+static ssize_t ps3flash_write(const char __user *userbuf,
+			      const void *kernelbuf, size_t count, loff_t *pos)
 {
 	struct ps3_storage_device *dev = ps3flash_dev;
 	struct ps3flash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
@@ -179,10 +187,11 @@ static ssize_t ps3flash_write(struct file *file, const char __user *buf,
 	ssize_t res;
 	size_t remaining, n;
 	unsigned int sec_off;
+	void *dst;
 
 	dev_dbg(&dev->sbd.core,
-		"%s:%u: Writing %zu bytes at position %lld from user 0x%p\n",
-		__func__, __LINE__, count, *pos, buf);
+		"%s:%u: Writing %zu bytes at position %lld from U0x%p/K0x%p\n",
+		__func__, __LINE__, count, *pos, userbuf, kernelbuf);
 
 	size = dev->regions[dev->region_idx].size*dev->blk_size;
 	if (*pos >= size || !count)
@@ -259,12 +268,20 @@ static ssize_t ps3flash_write(struct file *file, const char __user *buf,
 		}
 
 		n = min_t(u64, remaining, dev->bounce_size-offset);
+		dst = dev->bounce_buf+offset;
 		dev_dbg(&dev->sbd.core,
-			"%s:%u: copy %lu bytes from user 0x%p to 0x%p\n",
-			__func__, __LINE__, n, buf, dev->bounce_buf+offset);
-		if (copy_from_user(dev->bounce_buf+offset, buf, n)) {
-			res = -EFAULT;
-			goto fail;
+			"%s:%u: copy %lu bytes from U0x%p/K0x%p to 0x%p\n",
+			__func__, __LINE__, n, userbuf, kernelbuf, dst);
+		if (userbuf) {
+			if (copy_from_user(dst, userbuf, n)) {
+				res = -EFAULT;
+				goto fail;
+			}
+			userbuf += n;
+		}
+		if (kernelbuf) {
+			memcpy(dst, kernelbuf, n);
+			kernelbuf += n;
 		}
 
 		res = ps3flash_write_chunk(dev, start_write_sector);
@@ -274,7 +291,6 @@ static ssize_t ps3flash_write(struct file *file, const char __user *buf,
 		mutex_unlock(&priv->mutex);
 
 		*pos += n;
-		buf += n;
 		remaining -= n;
 		start_write_sector += chunk_sectors;
 		head = 0;
@@ -288,6 +304,29 @@ fail:
 	return res;
 }
 
+static ssize_t ps3flash_user_read(struct file *file, char __user *buf,
+				  size_t count, loff_t *pos)
+{
+	return ps3flash_read(buf, NULL, count, pos);
+}
+
+static ssize_t ps3flash_user_write(struct file *file, const char __user *buf,
+				   size_t count, loff_t *pos)
+{
+	return ps3flash_write(buf, NULL, count, pos);
+}
+
+static ssize_t ps3flash_kernel_read(void *buf, size_t count, loff_t pos)
+{
+	return ps3flash_read(NULL, buf, count, &pos);
+}
+
+static ssize_t ps3flash_kernel_write(const void *buf, size_t count,
+				     loff_t pos)
+{
+	return ps3flash_write(NULL, buf, count, &pos);
+}
+
 
 static irqreturn_t ps3flash_interrupt(int irq, void *data)
 {
@@ -312,12 +351,16 @@ static irqreturn_t ps3flash_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-
 static const struct file_operations ps3flash_fops = {
 	.owner	= THIS_MODULE,
 	.llseek	= ps3flash_llseek,
-	.read	= ps3flash_read,
-	.write	= ps3flash_write,
+	.read	= ps3flash_user_read,
+	.write	= ps3flash_user_write,
+};
+
+static const struct ps3_os_area_flash_ops ps3flash_kernel_ops = {
+	.read	= ps3flash_kernel_read,
+	.write	= ps3flash_kernel_write,
 };
 
 static struct miscdevice ps3flash_misc = {
@@ -386,6 +429,8 @@ static int __devinit ps3flash_probe(struct ps3_system_bus_device *_dev)
 
 	dev_info(&dev->sbd.core, "%s:%u: registered misc device %d\n",
 		 __func__, __LINE__, ps3flash_misc.minor);
+
+	ps3_os_area_flash_register(&ps3flash_kernel_ops);
 	return 0;
 
 fail_teardown:
@@ -402,6 +447,7 @@ static int ps3flash_remove(struct ps3_system_bus_device *_dev)
 {
 	struct ps3_storage_device *dev = to_ps3_storage_device(&_dev->core);
 
+	ps3_os_area_flash_register(NULL);
 	misc_deregister(&ps3flash_misc);
 	ps3stor_teardown(dev);
 	kfree(ps3_system_bus_get_drvdata(&dev->sbd));
-- 
1.6.2.4
