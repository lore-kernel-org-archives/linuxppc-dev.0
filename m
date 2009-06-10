Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 40A69B7156
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:19 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 06/33] ps3vram: Replace mutex by spinlock + bio_list
Date: Wed, 10 Jun 2009 16:38:41 +0200
Message-Id: <1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, Jens Axboe <axboe@kernel.dk>,
	cbe-oss-dev@ozlabs.org, Jim Paris <jim@jtan.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the mutex serializing access to the cache.
Instead, queue up new requests on a bio_list if the driver is busy.

This improves sequential write performance by ca. 2%.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Jim Paris <jim@jtan.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
v2: Use bio_list instead of homebrew single-linked list

 drivers/block/ps3vram.c |   51 +++++++++++++++++++++++++++++++++-------------
 1 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 3c9ad19..48c92ae 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -81,8 +81,8 @@ struct ps3vram_priv {
 
 	struct ps3vram_cache cache;
 
-	/* Used to serialize cache/DMA operations */
-	struct mutex lock;
+	spinlock_t lock;	/* protecting list of bios */
+	struct bio_list list;
 };
 
 
@@ -449,8 +449,6 @@ static int ps3vram_read(struct ps3_system_bus_device *dev, loff_t from,
 		offset = (unsigned int) (from & (priv->cache.page_size - 1));
 		avail  = priv->cache.page_size - offset;
 
-		mutex_lock(&priv->lock);
-
 		entry = ps3vram_cache_match(dev, from);
 		cached = CACHE_OFFSET + entry * priv->cache.page_size + offset;
 
@@ -462,8 +460,6 @@ static int ps3vram_read(struct ps3_system_bus_device *dev, loff_t from,
 			avail = count;
 		memcpy(buf, priv->xdr_buf + cached, avail);
 
-		mutex_unlock(&priv->lock);
-
 		buf += avail;
 		count -= avail;
 		from += avail;
@@ -494,8 +490,6 @@ static int ps3vram_write(struct ps3_system_bus_device *dev, loff_t to,
 		offset = (unsigned int) (to & (priv->cache.page_size - 1));
 		avail  = priv->cache.page_size - offset;
 
-		mutex_lock(&priv->lock);
-
 		entry = ps3vram_cache_match(dev, to);
 		cached = CACHE_OFFSET + entry * priv->cache.page_size + offset;
 
@@ -509,8 +503,6 @@ static int ps3vram_write(struct ps3_system_bus_device *dev, loff_t to,
 
 		priv->cache.tags[entry].flags |= CACHE_PAGE_DIRTY;
 
-		mutex_unlock(&priv->lock);
-
 		buf += avail;
 		count -= avail;
 		to += avail;
@@ -552,17 +544,17 @@ static void __devinit ps3vram_proc_init(struct ps3_system_bus_device *dev)
 		dev_warn(&dev->core, "failed to create /proc entry\n");
 }
 
-static int ps3vram_make_request(struct request_queue *q, struct bio *bio)
+static struct bio *ps3vram_do_bio(struct ps3_system_bus_device *dev,
+				  struct bio *bio)
 {
-	struct ps3_system_bus_device *dev = q->queuedata;
+	struct ps3vram_priv *priv = dev->core.driver_data;
 	int write = bio_data_dir(bio) == WRITE;
 	const char *op = write ? "write" : "read";
 	loff_t offset = bio->bi_sector << 9;
 	int error = 0;
 	struct bio_vec *bvec;
 	unsigned int i;
-
-	dev_dbg(&dev->core, "%s\n", __func__);
+	struct bio *next;
 
 	bio_for_each_segment(bvec, bio, i) {
 		/* PS3 is ppc64, so we don't handle highmem */
@@ -593,7 +585,35 @@ static int ps3vram_make_request(struct request_queue *q, struct bio *bio)
 	dev_dbg(&dev->core, "%s completed\n", op);
 
 out:
+	spin_lock_irq(&priv->lock);
+	bio_list_pop(&priv->list);
+	next = bio_list_peek(&priv->list);
+	spin_unlock_irq(&priv->lock);
+
 	bio_endio(bio, error);
+	return next;
+}
+
+static int ps3vram_make_request(struct request_queue *q, struct bio *bio)
+{
+	struct ps3_system_bus_device *dev = q->queuedata;
+	struct ps3vram_priv *priv = dev->core.driver_data;
+	int busy;
+
+	dev_dbg(&dev->core, "%s\n", __func__);
+
+	spin_lock_irq(&priv->lock);
+	busy = !bio_list_empty(&priv->list);
+	bio_list_add(&priv->list, bio);
+	spin_unlock_irq(&priv->lock);
+
+	if (busy)
+		return 0;
+
+	do {
+		bio = ps3vram_do_bio(dev, bio);
+	} while (bio);
+
 	return 0;
 }
 
@@ -613,7 +633,8 @@ static int __devinit ps3vram_probe(struct ps3_system_bus_device *dev)
 		goto fail;
 	}
 
-	mutex_init(&priv->lock);
+	spin_lock_init(&priv->lock);
+	bio_list_init(&priv->list);
 	dev->core.driver_data = priv;
 
 	priv = dev->core.driver_data;
-- 
1.6.2.4
