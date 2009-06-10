Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E6421B7195
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:25 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 33/33] ps3flash: Always read chunks of 256 KiB, and cache them
Date: Wed, 10 Jun 2009 16:39:08 +0200
Message-Id: <1244644748-24211-34-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-33-git-send-email-Geert.Uytterhoeven@sonycom.com>
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
	<1244644748-24211-33-git-send-email-Geert.Uytterhoeven@sonycom.com>
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

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
It slows down small reads, but do we care?

 drivers/char/ps3flash.c |   47 +++++++++++++++++------------------------------
 1 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/drivers/char/ps3flash.c b/drivers/char/ps3flash.c
index d884d31..f424d39 100644
--- a/drivers/char/ps3flash.c
+++ b/drivers/char/ps3flash.c
@@ -41,10 +41,11 @@ struct ps3flash_private {
 static struct ps3_storage_device *ps3flash_dev;
 
 static int ps3flash_read_write_sectors(struct ps3_storage_device *dev,
-				       u64 lpar, u64 start_sector, u64 sectors,
-				       int write)
+				       u64 start_sector, int write)
 {
-	u64 res = ps3stor_read_write_sectors(dev, lpar, start_sector, sectors,
+	struct ps3flash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
+	u64 res = ps3stor_read_write_sectors(dev, dev->bounce_lpar,
+					     start_sector, priv->chunk_sectors,
 					     write);
 	if (res) {
 		dev_err(&dev->sbd.core, "%s:%u: %s failed 0x%llx\n", __func__,
@@ -62,8 +63,7 @@ static int ps3flash_writeback(struct ps3_storage_device *dev)
 	if (!priv->dirty || priv->tag < 0)
 		return 0;
 
-	res = ps3flash_read_write_sectors(dev, dev->bounce_lpar, priv->tag,
-					  priv->chunk_sectors, 1);
+	res = ps3flash_read_write_sectors(dev, priv->tag, 1);
 	if (res)
 		return res;
 
@@ -71,17 +71,12 @@ static int ps3flash_writeback(struct ps3_storage_device *dev)
 	return 0;
 }
 
-static int ps3flash_fetch(struct ps3_storage_device *dev, u64 start_sector,
-			  u64 sectors)
+static int ps3flash_fetch(struct ps3_storage_device *dev, u64 start_sector)
 {
 	struct ps3flash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
-	unsigned int tag, offset;
-	u64 lpar;
 	int res;
 
-	offset = start_sector % priv->chunk_sectors;
-	tag = start_sector - offset;
-	if (tag == priv->tag)
+	if (start_sector == priv->tag)
 		return 0;
 
 	res = ps3flash_writeback(dev);
@@ -90,15 +85,11 @@ static int ps3flash_fetch(struct ps3_storage_device *dev, u64 start_sector,
 
 	priv->tag = -1;
 
-	lpar = dev->bounce_lpar + offset * dev->blk_size;
-	res = ps3flash_read_write_sectors(dev, lpar, start_sector, sectors, 0);
+	res = ps3flash_read_write_sectors(dev, start_sector, 0);
 	if (res)
 		return res;
 
-	/* We don't bother caching reads smaller than the chunk size */
-	if (sectors == priv->chunk_sectors)
-		priv->tag = tag;
-
+	priv->tag = start_sector;
 	return 0;
 }
 
@@ -134,7 +125,7 @@ static ssize_t ps3flash_read(char __user *userbuf, void *kernelbuf,
 {
 	struct ps3_storage_device *dev = ps3flash_dev;
 	struct ps3flash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
-	u64 size, start_sector, end_sector, offset, sectors;
+	u64 size, sector, offset;
 	int res;
 	size_t remaining, n;
 	const void *src;
@@ -154,24 +145,20 @@ static ssize_t ps3flash_read(char __user *userbuf, void *kernelbuf,
 		count = size - *pos;
 	}
 
-	start_sector = *pos / dev->blk_size;
+	sector = *pos / dev->bounce_size * priv->chunk_sectors;
 	offset = *pos % dev->bounce_size;
-	end_sector = DIV_ROUND_UP(*pos + count, dev->blk_size);
 
 	remaining = count;
 	do {
-		sectors = min(end_sector - start_sector,
-			      priv->chunk_sectors -
-			      start_sector % priv->chunk_sectors);
+		n = min_t(u64, remaining, dev->bounce_size - offset);
+		src = dev->bounce_buf + offset;
 
 		mutex_lock(&priv->mutex);
 
-		res = ps3flash_fetch(dev, start_sector, sectors);
+		res = ps3flash_fetch(dev, sector);
 		if (res)
 			goto fail;
 
-		n = min_t(u64, remaining, dev->bounce_size - offset);
-		src = dev->bounce_buf + offset;
 		dev_dbg(&dev->sbd.core,
 			"%s:%u: copy %lu bytes from 0x%p to U0x%p/K0x%p\n",
 			__func__, __LINE__, n, src, userbuf, kernelbuf);
@@ -191,7 +178,7 @@ static ssize_t ps3flash_read(char __user *userbuf, void *kernelbuf,
 
 		*pos += n;
 		remaining -= n;
-		start_sector += sectors;
+		sector += priv->chunk_sectors;
 		offset = 0;
 	} while (remaining > 0);
 
@@ -233,17 +220,17 @@ static ssize_t ps3flash_write(const char __user *userbuf,
 	remaining = count;
 	do {
 		n = min_t(u64, remaining, dev->bounce_size - offset);
+		dst = dev->bounce_buf + offset;
 
 		mutex_lock(&priv->mutex);
 
 		if (n != dev->bounce_size)
-			res = ps3flash_fetch(dev, sector, priv->chunk_sectors);
+			res = ps3flash_fetch(dev, sector);
 		else if (sector != priv->tag)
 			res = ps3flash_writeback(dev);
 		if (res)
 			goto fail;
 
-		dst = dev->bounce_buf + offset;
 		dev_dbg(&dev->sbd.core,
 			"%s:%u: copy %lu bytes from U0x%p/K0x%p to 0x%p\n",
 			__func__, __LINE__, n, userbuf, kernelbuf, dst);
-- 
1.6.2.4
