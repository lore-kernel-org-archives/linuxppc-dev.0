Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C2821B72E8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:27 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 32/33] ps3flash: Cache the last accessed FLASH chunk
Date: Wed, 10 Jun 2009 16:39:07 +0200
Message-Id: <1244644748-24211-33-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-32-git-send-email-Geert.Uytterhoeven@sonycom.com>
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
	<1244644748-24211-32-git-send-email-Geert.Uytterhoeven@sonycom.com>
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

Add support for caching, to reduce FLASH wear when writing using small
blocksizes. As we also don't care anymore about heads and tails in case of
partial writes, this greatly simplifies the code for handling writes.

Note: We don't bother caching reads smaller than the FLASH chunk size
(256 KiB).

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/char/ps3flash.c |  209 +++++++++++++++++++++++------------------------
 1 files changed, 104 insertions(+), 105 deletions(-)

diff --git a/drivers/char/ps3flash.c b/drivers/char/ps3flash.c
index f7f21f4..d884d31 100644
--- a/drivers/char/ps3flash.c
+++ b/drivers/char/ps3flash.c
@@ -33,13 +33,16 @@
 
 struct ps3flash_private {
 	struct mutex mutex;	/* Bounce buffer mutex */
+	u64 chunk_sectors;
+	int tag;		/* Start sector of buffer, -1 if invalid */
+	bool dirty;
 };
 
 static struct ps3_storage_device *ps3flash_dev;
 
-static ssize_t ps3flash_read_write_sectors(struct ps3_storage_device *dev,
-					   u64 lpar, u64 start_sector,
-					   u64 sectors, int write)
+static int ps3flash_read_write_sectors(struct ps3_storage_device *dev,
+				       u64 lpar, u64 start_sector, u64 sectors,
+				       int write)
 {
 	u64 res = ps3stor_read_write_sectors(dev, lpar, start_sector, sectors,
 					     write);
@@ -48,33 +51,55 @@ static ssize_t ps3flash_read_write_sectors(struct ps3_storage_device *dev,
 			__LINE__, write ? "write" : "read", res);
 		return -EIO;
 	}
-	return sectors;
+	return 0;
 }
 
-static ssize_t ps3flash_read_sectors(struct ps3_storage_device *dev,
-				     u64 start_sector, u64 sectors,
-				     unsigned int sector_offset)
+static int ps3flash_writeback(struct ps3_storage_device *dev)
 {
-	u64 max_sectors, lpar;
+	struct ps3flash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
+	int res;
 
-	max_sectors = dev->bounce_size / dev->blk_size;
-	if (sectors > max_sectors) {
-		dev_dbg(&dev->sbd.core, "%s:%u Limiting sectors to %llu\n",
-			__func__, __LINE__, max_sectors);
-		sectors = max_sectors;
-	}
+	if (!priv->dirty || priv->tag < 0)
+		return 0;
+
+	res = ps3flash_read_write_sectors(dev, dev->bounce_lpar, priv->tag,
+					  priv->chunk_sectors, 1);
+	if (res)
+		return res;
 
-	lpar = dev->bounce_lpar + sector_offset * dev->blk_size;
-	return ps3flash_read_write_sectors(dev, lpar, start_sector, sectors,
-					   0);
+	priv->dirty = false;
+	return 0;
 }
 
-static ssize_t ps3flash_write_chunk(struct ps3_storage_device *dev,
-				    u64 start_sector)
+static int ps3flash_fetch(struct ps3_storage_device *dev, u64 start_sector,
+			  u64 sectors)
 {
-       u64 sectors = dev->bounce_size / dev->blk_size;
-       return ps3flash_read_write_sectors(dev, dev->bounce_lpar, start_sector,
-					  sectors, 1);
+	struct ps3flash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
+	unsigned int tag, offset;
+	u64 lpar;
+	int res;
+
+	offset = start_sector % priv->chunk_sectors;
+	tag = start_sector - offset;
+	if (tag == priv->tag)
+		return 0;
+
+	res = ps3flash_writeback(dev);
+	if (res)
+		return res;
+
+	priv->tag = -1;
+
+	lpar = dev->bounce_lpar + offset * dev->blk_size;
+	res = ps3flash_read_write_sectors(dev, lpar, start_sector, sectors, 0);
+	if (res)
+		return res;
+
+	/* We don't bother caching reads smaller than the chunk size */
+	if (sectors == priv->chunk_sectors)
+		priv->tag = tag;
+
+	return 0;
 }
 
 static loff_t ps3flash_llseek(struct file *file, loff_t offset, int origin)
@@ -109,8 +134,8 @@ static ssize_t ps3flash_read(char __user *userbuf, void *kernelbuf,
 {
 	struct ps3_storage_device *dev = ps3flash_dev;
 	struct ps3flash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
-	u64 size, start_sector, end_sector, offset;
-	ssize_t sectors_read;
+	u64 size, start_sector, end_sector, offset, sectors;
+	int res;
 	size_t remaining, n;
 	const void *src;
 
@@ -130,30 +155,29 @@ static ssize_t ps3flash_read(char __user *userbuf, void *kernelbuf,
 	}
 
 	start_sector = *pos / dev->blk_size;
-	offset = *pos % dev->blk_size;
+	offset = *pos % dev->bounce_size;
 	end_sector = DIV_ROUND_UP(*pos + count, dev->blk_size);
 
 	remaining = count;
 	do {
+		sectors = min(end_sector - start_sector,
+			      priv->chunk_sectors -
+			      start_sector % priv->chunk_sectors);
+
 		mutex_lock(&priv->mutex);
 
-		sectors_read = ps3flash_read_sectors(dev, start_sector,
-						     end_sector-start_sector,
-						     0);
-		if (sectors_read < 0) {
-			mutex_unlock(&priv->mutex);
+		res = ps3flash_fetch(dev, start_sector, sectors);
+		if (res)
 			goto fail;
-		}
 
-		n = min_t(u64, remaining, sectors_read*dev->blk_size-offset);
-		src = dev->bounce_buf+offset;
+		n = min_t(u64, remaining, dev->bounce_size - offset);
+		src = dev->bounce_buf + offset;
 		dev_dbg(&dev->sbd.core,
 			"%s:%u: copy %lu bytes from 0x%p to U0x%p/K0x%p\n",
 			__func__, __LINE__, n, src, userbuf, kernelbuf);
 		if (userbuf) {
 			if (copy_to_user(userbuf, src, n)) {
-				mutex_unlock(&priv->mutex);
-				sectors_read = -EFAULT;
+				res = -EFAULT;
 				goto fail;
 			}
 			userbuf += n;
@@ -167,14 +191,15 @@ static ssize_t ps3flash_read(char __user *userbuf, void *kernelbuf,
 
 		*pos += n;
 		remaining -= n;
-		start_sector += sectors_read;
+		start_sector += sectors;
 		offset = 0;
 	} while (remaining > 0);
 
 	return count;
 
 fail:
-	return sectors_read;
+	mutex_unlock(&priv->mutex);
+	return res;
 }
 
 static ssize_t ps3flash_write(const char __user *userbuf,
@@ -182,11 +207,9 @@ static ssize_t ps3flash_write(const char __user *userbuf,
 {
 	struct ps3_storage_device *dev = ps3flash_dev;
 	struct ps3flash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
-	u64 size, chunk_sectors, start_write_sector, end_write_sector,
-	    end_read_sector, start_read_sector, head, tail, offset;
-	ssize_t res;
+	u64 size, sector, offset;
+	int res = 0;
 	size_t remaining, n;
-	unsigned int sec_off;
 	void *dst;
 
 	dev_dbg(&dev->sbd.core,
@@ -204,71 +227,23 @@ static ssize_t ps3flash_write(const char __user *userbuf,
 		count = size - *pos;
 	}
 
-	chunk_sectors = dev->bounce_size / dev->blk_size;
-
-	start_write_sector = *pos / dev->bounce_size * chunk_sectors;
+	sector = *pos / dev->bounce_size * priv->chunk_sectors;
 	offset = *pos % dev->bounce_size;
-	end_write_sector = DIV_ROUND_UP(*pos + count, dev->bounce_size) *
-			   chunk_sectors;
-
-	end_read_sector = DIV_ROUND_UP(*pos, dev->blk_size);
-	start_read_sector = (*pos + count) / dev->blk_size;
-
-	/*
-	 * As we have to write in 256 KiB chunks, while we can read in blk_size
-	 * (usually 512 bytes) chunks, we perform the following steps:
-	 *   1. Read from start_write_sector to end_read_sector ("head")
-	 *   2. Read from start_read_sector to end_write_sector ("tail")
-	 *   3. Copy data to buffer
-	 *   4. Write from start_write_sector to end_write_sector
-	 * All of this is complicated by using only one 256 KiB bounce buffer.
-	 */
-
-	head = end_read_sector - start_write_sector;
-	tail = end_write_sector - start_read_sector;
 
 	remaining = count;
 	do {
+		n = min_t(u64, remaining, dev->bounce_size - offset);
+
 		mutex_lock(&priv->mutex);
 
-		if (end_read_sector >= start_read_sector) {
-			/* Merge head and tail */
-			dev_dbg(&dev->sbd.core,
-				"Merged head and tail: %llu sectors at %llu\n",
-				chunk_sectors, start_write_sector);
-			res = ps3flash_read_sectors(dev, start_write_sector,
-						    chunk_sectors, 0);
-			if (res < 0)
-				goto fail;
-		} else {
-			if (head) {
-				/* Read head */
-				dev_dbg(&dev->sbd.core,
-					"head: %llu sectors at %llu\n", head,
-					start_write_sector);
-				res = ps3flash_read_sectors(dev,
-							    start_write_sector,
-							    head, 0);
-				if (res < 0)
-					goto fail;
-			}
-			if (start_read_sector <
-			    start_write_sector+chunk_sectors) {
-				/* Read tail */
-				dev_dbg(&dev->sbd.core,
-					"tail: %llu sectors at %llu\n", tail,
-					start_read_sector);
-				sec_off = start_read_sector-start_write_sector;
-				res = ps3flash_read_sectors(dev,
-							    start_read_sector,
-							    tail, sec_off);
-				if (res < 0)
-					goto fail;
-			}
-		}
+		if (n != dev->bounce_size)
+			res = ps3flash_fetch(dev, sector, priv->chunk_sectors);
+		else if (sector != priv->tag)
+			res = ps3flash_writeback(dev);
+		if (res)
+			goto fail;
 
-		n = min_t(u64, remaining, dev->bounce_size-offset);
-		dst = dev->bounce_buf+offset;
+		dst = dev->bounce_buf + offset;
 		dev_dbg(&dev->sbd.core,
 			"%s:%u: copy %lu bytes from U0x%p/K0x%p to 0x%p\n",
 			__func__, __LINE__, n, userbuf, kernelbuf, dst);
@@ -284,16 +259,14 @@ static ssize_t ps3flash_write(const char __user *userbuf,
 			kernelbuf += n;
 		}
 
-		res = ps3flash_write_chunk(dev, start_write_sector);
-		if (res < 0)
-			goto fail;
+		priv->tag = sector;
+		priv->dirty = true;
 
 		mutex_unlock(&priv->mutex);
 
 		*pos += n;
 		remaining -= n;
-		start_write_sector += chunk_sectors;
-		head = 0;
+		sector += priv->chunk_sectors;
 		offset = 0;
 	} while (remaining > 0);
 
@@ -324,9 +297,31 @@ static ssize_t ps3flash_kernel_read(void *buf, size_t count, loff_t pos)
 static ssize_t ps3flash_kernel_write(const void *buf, size_t count,
 				     loff_t pos)
 {
-	return ps3flash_write(NULL, buf, count, &pos);
+	ssize_t res;
+	int wb;
+
+	res = ps3flash_write(NULL, buf, count, &pos);
+	if (res < 0)
+		return res;
+
+	/* Make kernel writes synchronous */
+	wb = ps3flash_writeback(ps3flash_dev);
+	if (wb)
+		return wb;
+
+	return res;
 }
 
+static int ps3flash_flush(struct file *file, fl_owner_t id)
+{
+	return ps3flash_writeback(ps3flash_dev);
+}
+
+static int ps3flash_fsync(struct file *file, struct dentry *dentry,
+			  int datasync)
+{
+	return ps3flash_writeback(ps3flash_dev);
+}
 
 static irqreturn_t ps3flash_interrupt(int irq, void *data)
 {
@@ -356,6 +351,8 @@ static const struct file_operations ps3flash_fops = {
 	.llseek	= ps3flash_llseek,
 	.read	= ps3flash_user_read,
 	.write	= ps3flash_user_write,
+	.flush	= ps3flash_flush,
+	.fsync	= ps3flash_fsync,
 };
 
 static const struct ps3_os_area_flash_ops ps3flash_kernel_ops = {
@@ -411,9 +408,11 @@ static int __devinit ps3flash_probe(struct ps3_system_bus_device *_dev)
 
 	ps3_system_bus_set_drvdata(&dev->sbd, priv);
 	mutex_init(&priv->mutex);
+	priv->tag = -1;
 
 	dev->bounce_size = ps3flash_bounce_buffer.size;
 	dev->bounce_buf = ps3flash_bounce_buffer.address;
+	priv->chunk_sectors = dev->bounce_size / dev->blk_size;
 
 	error = ps3stor_setup(dev, ps3flash_interrupt);
 	if (error)
-- 
1.6.2.4
