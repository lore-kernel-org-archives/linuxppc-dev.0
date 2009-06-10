Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 08FD9B70CA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:28 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 19/33] ps3: shorten ps3_system_bus_[gs]et_driver_data to
	ps3_system_bus_[gs]et_drvdata
Date: Wed, 10 Jun 2009 16:38:54 +0200
Message-Id: <1244644748-24211-20-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-19-git-send-email-Geert.Uytterhoeven@sonycom.com>
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
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, Jim Paris <jim@jtan.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Jim Paris <jim@jtan.com>
---
 arch/powerpc/include/asm/ps3.h |    4 +-
 drivers/block/ps3disk.c        |   23 +++++++-----------
 drivers/block/ps3vram.c        |   48 ++++++++++++++++++++--------------------
 drivers/net/ps3_gelic_net.c    |    8 +++---
 drivers/usb/host/ehci-ps3.c    |    7 ++---
 drivers/usb/host/ohci-ps3.c    |    7 ++---
 6 files changed, 45 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
index dcd302f..7660694 100644
--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -418,12 +418,12 @@ static inline struct ps3_system_bus_driver *
  * @data: Data to set
  */
 
-static inline void ps3_system_bus_set_driver_data(
+static inline void ps3_system_bus_set_drvdata(
 	struct ps3_system_bus_device *dev, void *data)
 {
 	dev_set_drvdata(&dev->core, data);
 }
-static inline void *ps3_system_bus_get_driver_data(
+static inline void *ps3_system_bus_get_drvdata(
 	struct ps3_system_bus_device *dev)
 {
 	return dev_get_drvdata(&dev->core);
diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index d5781a8..bca99da 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -120,8 +120,7 @@ static void ps3disk_scatter_gather(struct ps3_storage_device *dev,
 static int ps3disk_submit_request_sg(struct ps3_storage_device *dev,
 				     struct request *req)
 {
-	struct ps3disk_private *priv =
-		ps3_system_bus_get_driver_data(&dev->sbd);
+	struct ps3disk_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 	int write = rq_data_dir(req), res;
 	const char *op = write ? "write" : "read";
 	u64 start_sector, sectors;
@@ -170,8 +169,7 @@ static int ps3disk_submit_request_sg(struct ps3_storage_device *dev,
 static int ps3disk_submit_flush_request(struct ps3_storage_device *dev,
 					struct request *req)
 {
-	struct ps3disk_private *priv =
-		ps3_system_bus_get_driver_data(&dev->sbd);
+	struct ps3disk_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 	u64 res;
 
 	dev_dbg(&dev->sbd.core, "%s:%u: flush request\n", __func__, __LINE__);
@@ -216,8 +214,7 @@ static void ps3disk_do_request(struct ps3_storage_device *dev,
 static void ps3disk_request(struct request_queue *q)
 {
 	struct ps3_storage_device *dev = q->queuedata;
-	struct ps3disk_private *priv =
-		ps3_system_bus_get_driver_data(&dev->sbd);
+	struct ps3disk_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 
 	if (priv->req) {
 		dev_dbg(&dev->sbd.core, "%s:%u busy\n", __func__, __LINE__);
@@ -250,7 +247,7 @@ static irqreturn_t ps3disk_interrupt(int irq, void *data)
 		return IRQ_HANDLED;
 	}
 
-	priv = ps3_system_bus_get_driver_data(&dev->sbd);
+	priv = ps3_system_bus_get_drvdata(&dev->sbd);
 	req = priv->req;
 	if (!req) {
 		dev_dbg(&dev->sbd.core,
@@ -371,8 +368,7 @@ static void ata_id_c_string(const u16 *id, unsigned char *s, unsigned int ofs,
 
 static int ps3disk_identify(struct ps3_storage_device *dev)
 {
-	struct ps3disk_private *priv =
-		ps3_system_bus_get_driver_data(&dev->sbd);
+	struct ps3disk_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 	struct lv1_ata_cmnd_block ata_cmnd;
 	u16 *id = dev->bounce_buf;
 	u64 res;
@@ -453,7 +449,7 @@ static int __devinit ps3disk_probe(struct ps3_system_bus_device *_dev)
 		goto fail;
 	}
 
-	ps3_system_bus_set_driver_data(_dev, priv);
+	ps3_system_bus_set_drvdata(_dev, priv);
 	spin_lock_init(&priv->lock);
 
 	dev->bounce_size = BOUNCE_SIZE;
@@ -531,7 +527,7 @@ fail_free_bounce:
 	kfree(dev->bounce_buf);
 fail_free_priv:
 	kfree(priv);
-	ps3_system_bus_set_driver_data(_dev, NULL);
+	ps3_system_bus_set_drvdata(_dev, NULL);
 fail:
 	mutex_lock(&ps3disk_mask_mutex);
 	__clear_bit(devidx, &ps3disk_mask);
@@ -542,8 +538,7 @@ fail:
 static int ps3disk_remove(struct ps3_system_bus_device *_dev)
 {
 	struct ps3_storage_device *dev = to_ps3_storage_device(&_dev->core);
-	struct ps3disk_private *priv =
-		ps3_system_bus_get_driver_data(&dev->sbd);
+	struct ps3disk_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 
 	mutex_lock(&ps3disk_mask_mutex);
 	__clear_bit(MINOR(disk_devt(priv->gendisk)) / PS3DISK_MINORS,
@@ -557,7 +552,7 @@ static int ps3disk_remove(struct ps3_system_bus_device *_dev)
 	ps3stor_teardown(dev);
 	kfree(dev->bounce_buf);
 	kfree(priv);
-	ps3_system_bus_set_driver_data(_dev, NULL);
+	ps3_system_bus_set_drvdata(_dev, NULL);
 	return 0;
 }
 
diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index fcecc7f..095f97e 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -110,7 +110,7 @@ static u32 *ps3vram_get_notifier(void *reports, int notifier)
 
 static void ps3vram_notifier_reset(struct ps3_system_bus_device *dev)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	u32 *notify = ps3vram_get_notifier(priv->reports, NOTIFIER);
 	int i;
 
@@ -121,7 +121,7 @@ static void ps3vram_notifier_reset(struct ps3_system_bus_device *dev)
 static int ps3vram_notifier_wait(struct ps3_system_bus_device *dev,
 				 unsigned int timeout_ms)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	u32 *notify = ps3vram_get_notifier(priv->reports, NOTIFIER);
 	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
 
@@ -136,7 +136,7 @@ static int ps3vram_notifier_wait(struct ps3_system_bus_device *dev,
 
 static void ps3vram_init_ring(struct ps3_system_bus_device *dev)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 
 	priv->ctrl[CTRL_PUT] = FIFO_BASE + FIFO_OFFSET;
 	priv->ctrl[CTRL_GET] = FIFO_BASE + FIFO_OFFSET;
@@ -145,7 +145,7 @@ static void ps3vram_init_ring(struct ps3_system_bus_device *dev)
 static int ps3vram_wait_ring(struct ps3_system_bus_device *dev,
 			     unsigned int timeout_ms)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
 
 	do {
@@ -174,7 +174,7 @@ static void ps3vram_begin_ring(struct ps3vram_priv *priv, u32 chan, u32 tag,
 
 static void ps3vram_rewind_ring(struct ps3_system_bus_device *dev)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	int status;
 
 	ps3vram_out_ring(priv, 0x20000000 | (FIFO_BASE + FIFO_OFFSET));
@@ -192,7 +192,7 @@ static void ps3vram_rewind_ring(struct ps3_system_bus_device *dev)
 
 static void ps3vram_fire_ring(struct ps3_system_bus_device *dev)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	int status;
 
 	mutex_lock(&ps3_gpu_mutex);
@@ -218,7 +218,7 @@ static void ps3vram_fire_ring(struct ps3_system_bus_device *dev)
 
 static void ps3vram_bind(struct ps3_system_bus_device *dev)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 
 	ps3vram_begin_ring(priv, UPLOAD_SUBCH, 0, 1);
 	ps3vram_out_ring(priv, 0x31337303);
@@ -241,7 +241,7 @@ static int ps3vram_upload(struct ps3_system_bus_device *dev,
 			  unsigned int src_offset, unsigned int dst_offset,
 			  int len, int count)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 
 	ps3vram_begin_ring(priv, UPLOAD_SUBCH,
 			   NV_MEMORY_TO_MEMORY_FORMAT_OFFSET_IN, 8);
@@ -273,7 +273,7 @@ static int ps3vram_download(struct ps3_system_bus_device *dev,
 			    unsigned int src_offset, unsigned int dst_offset,
 			    int len, int count)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 
 	ps3vram_begin_ring(priv, DOWNLOAD_SUBCH,
 			   NV_MEMORY_TO_MEMORY_FORMAT_OFFSET_IN, 8);
@@ -303,7 +303,7 @@ static int ps3vram_download(struct ps3_system_bus_device *dev,
 
 static void ps3vram_cache_evict(struct ps3_system_bus_device *dev, int entry)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	struct ps3vram_cache *cache = &priv->cache;
 
 	if (!(cache->tags[entry].flags & CACHE_PAGE_DIRTY))
@@ -325,7 +325,7 @@ static void ps3vram_cache_evict(struct ps3_system_bus_device *dev, int entry)
 static void ps3vram_cache_load(struct ps3_system_bus_device *dev, int entry,
 			       unsigned int address)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	struct ps3vram_cache *cache = &priv->cache;
 
 	dev_dbg(&dev->core, "Fetching %d: 0x%08x\n", entry, address);
@@ -345,7 +345,7 @@ static void ps3vram_cache_load(struct ps3_system_bus_device *dev, int entry,
 
 static void ps3vram_cache_flush(struct ps3_system_bus_device *dev)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	struct ps3vram_cache *cache = &priv->cache;
 	int i;
 
@@ -359,7 +359,7 @@ static void ps3vram_cache_flush(struct ps3_system_bus_device *dev)
 static unsigned int ps3vram_cache_match(struct ps3_system_bus_device *dev,
 					loff_t address)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	struct ps3vram_cache *cache = &priv->cache;
 	unsigned int base;
 	unsigned int offset;
@@ -393,7 +393,7 @@ static unsigned int ps3vram_cache_match(struct ps3_system_bus_device *dev,
 
 static int ps3vram_cache_init(struct ps3_system_bus_device *dev)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 
 	priv->cache.page_count = CACHE_PAGE_COUNT;
 	priv->cache.page_size = CACHE_PAGE_SIZE;
@@ -412,7 +412,7 @@ static int ps3vram_cache_init(struct ps3_system_bus_device *dev)
 
 static void ps3vram_cache_cleanup(struct ps3_system_bus_device *dev)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 
 	ps3vram_cache_flush(dev);
 	kfree(priv->cache.tags);
@@ -421,7 +421,7 @@ static void ps3vram_cache_cleanup(struct ps3_system_bus_device *dev)
 static int ps3vram_read(struct ps3_system_bus_device *dev, loff_t from,
 			size_t len, size_t *retlen, u_char *buf)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	unsigned int cached, count;
 
 	dev_dbg(&dev->core, "%s: from=0x%08x len=0x%zx\n", __func__,
@@ -465,7 +465,7 @@ static int ps3vram_read(struct ps3_system_bus_device *dev, loff_t from,
 static int ps3vram_write(struct ps3_system_bus_device *dev, loff_t to,
 			 size_t len, size_t *retlen, const u_char *buf)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	unsigned int cached, count;
 
 	if (to >= priv->size)
@@ -528,7 +528,7 @@ static const struct file_operations ps3vram_proc_fops = {
 
 static void __devinit ps3vram_proc_init(struct ps3_system_bus_device *dev)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	struct proc_dir_entry *pde;
 
 	pde = proc_create_data(DEVICE_NAME, 0444, NULL, &ps3vram_proc_fops,
@@ -540,7 +540,7 @@ static void __devinit ps3vram_proc_init(struct ps3_system_bus_device *dev)
 static struct bio *ps3vram_do_bio(struct ps3_system_bus_device *dev,
 				  struct bio *bio)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	int write = bio_data_dir(bio) == WRITE;
 	const char *op = write ? "write" : "read";
 	loff_t offset = bio->bi_sector << 9;
@@ -590,7 +590,7 @@ out:
 static int ps3vram_make_request(struct request_queue *q, struct bio *bio)
 {
 	struct ps3_system_bus_device *dev = q->queuedata;
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 	int busy;
 
 	dev_dbg(&dev->core, "%s\n", __func__);
@@ -628,7 +628,7 @@ static int __devinit ps3vram_probe(struct ps3_system_bus_device *dev)
 
 	spin_lock_init(&priv->lock);
 	bio_list_init(&priv->list);
-	ps3_system_bus_set_driver_data(dev, priv);
+	ps3_system_bus_set_drvdata(dev, priv);
 
 	/* Allocate XDR buffer (1MiB aligned) */
 	priv->xdr_buf = (void *)__get_free_pages(GFP_KERNEL,
@@ -793,14 +793,14 @@ out_free_xdr_buf:
 	free_pages((unsigned long) priv->xdr_buf, get_order(XDR_BUF_SIZE));
 fail_free_priv:
 	kfree(priv);
-	ps3_system_bus_set_driver_data(dev, NULL);
+	ps3_system_bus_set_drvdata(dev, NULL);
 fail:
 	return error;
 }
 
 static int ps3vram_remove(struct ps3_system_bus_device *dev)
 {
-	struct ps3vram_priv *priv = ps3_system_bus_get_driver_data(dev);
+	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 
 	del_gendisk(priv->gendisk);
 	put_disk(priv->gendisk);
@@ -817,7 +817,7 @@ static int ps3vram_remove(struct ps3_system_bus_device *dev)
 	ps3_close_hv_device(dev);
 	free_pages((unsigned long) priv->xdr_buf, get_order(XDR_BUF_SIZE));
 	kfree(priv);
-	ps3_system_bus_set_driver_data(dev, NULL);
+	ps3_system_bus_set_drvdata(dev, NULL);
 	return 0;
 }
 
diff --git a/drivers/net/ps3_gelic_net.c b/drivers/net/ps3_gelic_net.c
index 30900b3..2b38f39 100644
--- a/drivers/net/ps3_gelic_net.c
+++ b/drivers/net/ps3_gelic_net.c
@@ -1648,7 +1648,7 @@ static int ps3_gelic_driver_probe(struct ps3_system_bus_device *dev)
 		result = -ENOMEM;
 		goto fail_alloc_card;
 	}
-	ps3_system_bus_set_driver_data(dev, card);
+	ps3_system_bus_set_drvdata(dev, card);
 	card->dev = dev;
 
 	/* get internal vlan info */
@@ -1749,7 +1749,7 @@ fail_alloc_irq:
 					       bus_id(card),
 					       0, 0);
 fail_status_indicator:
-	ps3_system_bus_set_driver_data(dev, NULL);
+	ps3_system_bus_set_drvdata(dev, NULL);
 	kfree(netdev_card(netdev)->unalign);
 	free_netdev(netdev);
 fail_alloc_card:
@@ -1766,7 +1766,7 @@ fail_open:
 
 static int ps3_gelic_driver_remove(struct ps3_system_bus_device *dev)
 {
-	struct gelic_card *card = ps3_system_bus_get_driver_data(dev);
+	struct gelic_card *card = ps3_system_bus_get_drvdata(dev);
 	struct net_device *netdev0;
 	pr_debug("%s: called\n", __func__);
 
@@ -1803,7 +1803,7 @@ static int ps3_gelic_driver_remove(struct ps3_system_bus_device *dev)
 	kfree(netdev_card(netdev0)->unalign);
 	free_netdev(netdev0);
 
-	ps3_system_bus_set_driver_data(dev, NULL);
+	ps3_system_bus_set_drvdata(dev, NULL);
 
 	ps3_dma_region_free(dev->d_region);
 
diff --git a/drivers/usb/host/ehci-ps3.c b/drivers/usb/host/ehci-ps3.c
index 1ba9f9a..bb870b8 100644
--- a/drivers/usb/host/ehci-ps3.c
+++ b/drivers/usb/host/ehci-ps3.c
@@ -162,7 +162,7 @@ static int ps3_ehci_probe(struct ps3_system_bus_device *dev)
 	dev_dbg(&dev->core, "%s:%d: virq            %lu\n", __func__, __LINE__,
 		(unsigned long)virq);
 
-	ps3_system_bus_set_driver_data(dev, hcd);
+	ps3_system_bus_set_drvdata(dev, hcd);
 
 	result = usb_add_hcd(hcd, virq, IRQF_DISABLED);
 
@@ -195,8 +195,7 @@ fail_start:
 static int ps3_ehci_remove(struct ps3_system_bus_device *dev)
 {
 	unsigned int tmp;
-	struct usb_hcd *hcd =
-		(struct usb_hcd *)ps3_system_bus_get_driver_data(dev);
+	struct usb_hcd *hcd = ps3_system_bus_get_drvdata(dev);
 
 	BUG_ON(!hcd);
 
@@ -208,7 +207,7 @@ static int ps3_ehci_remove(struct ps3_system_bus_device *dev)
 	ehci_shutdown(hcd);
 	usb_remove_hcd(hcd);
 
-	ps3_system_bus_set_driver_data(dev, NULL);
+	ps3_system_bus_set_drvdata(dev, NULL);
 
 	BUG_ON(!hcd->regs);
 	iounmap(hcd->regs);
diff --git a/drivers/usb/host/ohci-ps3.c b/drivers/usb/host/ohci-ps3.c
index 3d19103..1d56259 100644
--- a/drivers/usb/host/ohci-ps3.c
+++ b/drivers/usb/host/ohci-ps3.c
@@ -162,7 +162,7 @@ static int ps3_ohci_probe(struct ps3_system_bus_device *dev)
 	dev_dbg(&dev->core, "%s:%d: virq            %lu\n", __func__, __LINE__,
 		(unsigned long)virq);
 
-	ps3_system_bus_set_driver_data(dev, hcd);
+	ps3_system_bus_set_drvdata(dev, hcd);
 
 	result = usb_add_hcd(hcd, virq, IRQF_DISABLED);
 
@@ -195,8 +195,7 @@ fail_start:
 static int ps3_ohci_remove(struct ps3_system_bus_device *dev)
 {
 	unsigned int tmp;
-	struct usb_hcd *hcd =
-		(struct usb_hcd *)ps3_system_bus_get_driver_data(dev);
+	struct usb_hcd *hcd = ps3_system_bus_get_drvdata(dev);
 
 	BUG_ON(!hcd);
 
@@ -208,7 +207,7 @@ static int ps3_ohci_remove(struct ps3_system_bus_device *dev)
 	ohci_shutdown(hcd);
 	usb_remove_hcd(hcd);
 
-	ps3_system_bus_set_driver_data(dev, NULL);
+	ps3_system_bus_set_drvdata(dev, NULL);
 
 	BUG_ON(!hcd->regs);
 	iounmap(hcd->regs);
-- 
1.6.2.4
