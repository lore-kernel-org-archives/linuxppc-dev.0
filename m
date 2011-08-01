Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 11/15] ps3disk: Provide a gendisk per accessible region
Date: Mon,  1 Aug 2011 22:03:02 +0200
Message-Id: <1312228986-32307-12-git-send-email-a.heider@gmail.com>
In-Reply-To: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
Cc: cbe-oss-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This changes the behavior to name the block devices for lpars
other than OtherOS. Instead of a single disk with an alphanumeric
suffix (/dev/ps3da), disks are now numeric, while each
accessible region gets its own alphanumeric suffix:

/dev/ps3d1a
/dev/ps3d1b

The old behavior for OtherOS is kept:
- only one region will be exposed as block device
- the block device name stays the same

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 drivers/block/ps3disk.c |  118 ++++++++++++++++++++++++++++++----------------
 1 files changed, 77 insertions(+), 41 deletions(-)

diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 96e00ff..cba8b45 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -35,18 +35,19 @@
 #define PS3DISK_MINORS		16
 
 
-#define PS3DISK_NAME		"ps3d%c"
+#define PS3DISK_NAME_OTHEROS	"ps3d%c"
+#define PS3DISK_NAME		"ps3d%c%c"
 
 
 struct ps3disk_private {
 	spinlock_t lock;		/* Request queue spinlock */
 	struct request_queue *queue;
-	struct gendisk *gendisk;
-	unsigned int region_idx;	/* first accessible region */
 	unsigned int blocking_factor;
 	struct request *req;
+	unsigned int devidx;
 	u64 raw_capacity;
 	unsigned char model[ATA_ID_PROD_LEN+1];
+	struct gendisk *gendisk[0];	/* Must be last */
 };
 
 
@@ -126,7 +127,9 @@ static int ps3disk_submit_request_sg(struct ps3_storage_device *dev,
 	int write = rq_data_dir(req), res;
 	const char *op = write ? "write" : "read";
 	u64 start_sector, sectors;
-	unsigned int region_id = dev->regions[priv->region_idx].id;
+	unsigned int region_idx = MINOR(disk_devt(req->rq_disk)) &
+				  (PS3DISK_MINORS - 1);
+	unsigned int region_id = dev->regions[region_idx].id;
 
 #ifdef DEBUG
 	unsigned int n = 0;
@@ -410,6 +413,7 @@ static int __devinit ps3disk_probe(struct ps3_system_bus_device *_dev)
 	struct request_queue *queue;
 	struct gendisk *gendisk;
 	unsigned int region_idx;
+	unsigned int otheros = ps3_get_ss_laid() == PS3_SS_LAID_OTHEROS;
 
 	if (dev->blk_size < 512) {
 		dev_err(&dev->sbd.core,
@@ -430,7 +434,9 @@ static int __devinit ps3disk_probe(struct ps3_system_bus_device *_dev)
 	__set_bit(devidx, &ps3disk_mask);
 	mutex_unlock(&ps3disk_mask_mutex);
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	priv = kzalloc(sizeof(*priv) +
+		       dev->num_regions * sizeof(struct gendisk),
+		       GFP_KERNEL);
 	if (!priv) {
 		error = -ENOMEM;
 		goto fail;
@@ -450,6 +456,7 @@ static int __devinit ps3disk_probe(struct ps3_system_bus_device *_dev)
 	if (error)
 		goto fail_free_bounce;
 
+	priv->devidx = devidx;
 	ps3disk_identify(dev);
 
 	queue = blk_init_queue(ps3disk_request, &priv->lock);
@@ -475,45 +482,60 @@ static int __devinit ps3disk_probe(struct ps3_system_bus_device *_dev)
 	blk_queue_max_segments(queue, -1);
 	blk_queue_max_segment_size(queue, dev->bounce_size);
 
-	gendisk = alloc_disk(PS3DISK_MINORS);
-	if (!gendisk) {
-		dev_err(&dev->sbd.core, "%s:%u: alloc_disk failed\n", __func__,
-			__LINE__);
-		error = -ENOMEM;
-		goto fail_cleanup_queue;
-	}
+	dev_info(&dev->sbd.core, "%s (%llu MiB)\n",
+		 priv->model, priv->raw_capacity >> 11);
 
-	priv->gendisk = gendisk;
+	for (region_idx = 0; region_idx < dev->num_regions; region_idx++) {
+		if (test_bit(region_idx, &dev->accessible_regions) == 0)
+			continue;
 
-	/* find first accessible region */
-	for (region_idx = 0; region_idx < dev->num_regions; region_idx++)
-		if (test_bit(region_idx, &dev->accessible_regions)) {
-			priv->region_idx = region_idx;
-			break;
+		gendisk = alloc_disk(PS3DISK_MINORS * PS3_STORAGE_MAX_REGIONS);
+		if (!gendisk) {
+			dev_err(&dev->sbd.core, "%s:%u: alloc_disk failed\n",
+				__func__, __LINE__);
+			error = -ENOMEM;
+			goto fail_cleanup_queue;
 		}
 
-	gendisk->major = ps3disk_major;
-	gendisk->first_minor = devidx * PS3DISK_MINORS;
-	gendisk->fops = &ps3disk_fops;
-	gendisk->queue = queue;
-	gendisk->private_data = dev;
-	gendisk->driverfs_dev = &dev->sbd.core;
-	snprintf(gendisk->disk_name, sizeof(gendisk->disk_name), PS3DISK_NAME,
-		 devidx+'a');
-	priv->blocking_factor = dev->blk_size >> 9;
-	set_capacity(gendisk,
-		     dev->regions[priv->region_idx].size *
-				 priv->blocking_factor);
-
-	dev_info(&dev->sbd.core,
-		 "%s is a %s (%llu MiB total, %lu MiB for OtherOS)\n",
-		 gendisk->disk_name, priv->model, priv->raw_capacity >> 11,
-		 get_capacity(gendisk) >> 11);
-
-	add_disk(gendisk);
+		priv->gendisk[region_idx] = gendisk;
+		gendisk->major = ps3disk_major;
+		gendisk->first_minor = devidx * PS3DISK_MINORS + region_idx;
+		gendisk->fops = &ps3disk_fops;
+		gendisk->queue = queue;
+		gendisk->private_data = dev;
+		gendisk->driverfs_dev = &dev->sbd.core;
+
+		if (otheros) {
+			/* keep the old block device name for OtherOS */
+			snprintf(gendisk->disk_name, sizeof(gendisk->disk_name),
+				 PS3DISK_NAME_OTHEROS, 'a' + devidx);
+		} else {
+			snprintf(gendisk->disk_name, sizeof(gendisk->disk_name),
+				 PS3DISK_NAME, '1' + devidx, 'a' + region_idx);
+		}
+
+		priv->blocking_factor = dev->blk_size >> 9;
+		set_capacity(gendisk, dev->regions[region_idx].size *
+				      priv->blocking_factor);
+
+		dev_info(&dev->sbd.core,
+			 "%s (%lu MiB region)\n",
+			 gendisk->disk_name, get_capacity(gendisk) >> 11);
+
+		add_disk(gendisk);
+
+		/* keep old behavior for OtherOS - only one region */
+		if (otheros)
+			break;
+	}
+
 	return 0;
 
 fail_cleanup_queue:
+	for (region_idx = 0; region_idx < dev->num_regions; region_idx++)
+		if (priv->gendisk[region_idx])
+			del_gendisk(priv->gendisk[region_idx]);
+
 	blk_cleanup_queue(queue);
 fail_teardown:
 	ps3stor_teardown(dev);
@@ -533,14 +555,28 @@ static int ps3disk_remove(struct ps3_system_bus_device *_dev)
 {
 	struct ps3_storage_device *dev = to_ps3_storage_device(&_dev->core);
 	struct ps3disk_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
+	unsigned int region_idx;
 
 	mutex_lock(&ps3disk_mask_mutex);
-	__clear_bit(MINOR(disk_devt(priv->gendisk)) / PS3DISK_MINORS,
-		    &ps3disk_mask);
+	__clear_bit(priv->devidx, &ps3disk_mask);
 	mutex_unlock(&ps3disk_mask_mutex);
-	del_gendisk(priv->gendisk);
+
+	for (region_idx = 0; region_idx < dev->num_regions; region_idx++) {
+		if (test_bit(region_idx, &dev->accessible_regions) == 0)
+			continue;
+
+		del_gendisk(priv->gendisk[region_idx]);
+	}
+
 	blk_cleanup_queue(priv->queue);
-	put_disk(priv->gendisk);
+
+	for (region_idx = 0; region_idx < dev->num_regions; region_idx++) {
+		if (test_bit(region_idx, &dev->accessible_regions) == 0)
+			continue;
+
+		put_disk(priv->gendisk[region_idx]);
+	}
+
 	dev_notice(&dev->sbd.core, "Synchronizing disk cache\n");
 	ps3disk_sync_cache(dev);
 	ps3stor_teardown(dev);
-- 
1.7.5.4
