Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 14/15] ps3: Add a vflash driver for lpars other than OtherOS
Date: Mon,  1 Aug 2011 22:03:05 +0200
Message-Id: <1312228986-32307-15-git-send-email-a.heider@gmail.com>
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

This driver refuses to work on OtherOS, and hence complements the
ps3flash driver - which only works on OtherOS.
A gendisk for each accessible region is created, and a default set
of region flags is provided - overwritable via a module param array.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/powerpc/platforms/ps3/Kconfig |   16 +-
 drivers/block/Makefile             |    1 +
 drivers/block/ps3vflash.c          |  508 ++++++++++++++++++++++++++++++++++++
 3 files changed, 524 insertions(+), 1 deletions(-)
 create mode 100644 drivers/block/ps3vflash.c

diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
index 5eb956a..f8d865c 100644
--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -121,13 +121,27 @@ config PS3_FLASH
 
 	  This support is required to access the PS3 FLASH ROM, which
 	  contains the boot loader and some boot options.
-	  This driver only supports the deprecated OtherOS LPAR.
+	  This driver only supports the deprecated OtherOS LPAR, select
+	  PS3_VFLASH below for all other LPARs.
 	  In general, all users will say Y or M.
 
 	  As this driver needs a fixed buffer of 256 KiB of memory, it can
 	  be disabled on the kernel command line using "ps3flash=off", to
 	  not allocate this fixed buffer.
 
+config PS3_VFLASH
+	tristate "PS3 VFLASH Storage Driver"
+	depends on PPC_PS3 && BLOCK
+	select PS3_STORAGE
+	help
+	  Include support for the PS3 virtual FLASH Storage.
+
+	  This support is required to access the PS3 virtual FLASH ROM, which
+	  contains the boot loader and some boot options.
+	  This driver only supports LPARs other than the deprecated OtherOS,
+	  select PS3_FLASH above to add support for FLASH ROM for the
+	  OtherOS LPAR.
+
 config PS3_VRAM
 	tristate "PS3 Video RAM Storage Driver"
 	depends on FB_PS3=y && BLOCK && m
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 40528ba..8b02899 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_BLK_DEV_SWIM)	+= swim_mod.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
 obj-$(CONFIG_AMIGA_FLOPPY)	+= amiflop.o
 obj-$(CONFIG_PS3_DISK)		+= ps3disk.o
+obj-$(CONFIG_PS3_VFLASH)	+= ps3vflash.o
 obj-$(CONFIG_PS3_VRAM)		+= ps3vram.o
 obj-$(CONFIG_ATARI_FLOPPY)	+= ataflop.o
 obj-$(CONFIG_AMIGA_Z2RAM)	+= z2ram.o
diff --git a/drivers/block/ps3vflash.c b/drivers/block/ps3vflash.c
new file mode 100644
index 0000000..a59e9f7
--- /dev/null
+++ b/drivers/block/ps3vflash.c
@@ -0,0 +1,508 @@
+/*
+ * PS3 VFLASH Storage Driver
+ *
+ * Copyright (C) 2011 Andre Heider <a.heider@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/ata.h>
+#include <linux/blkdev.h>
+#include <linux/slab.h>
+
+#include <asm/lv1call.h>
+#include <asm/ps3stor.h>
+#include <asm/firmware.h>
+
+
+#define DEVICE_NAME		"ps3vflash"
+
+#define BOUNCE_SIZE		(64*1024)
+
+#define PS3VFLASH_MAX_DISKS	16
+#define PS3VFLASH_MINORS	16
+
+
+#define PS3VFLASH_NAME		"ps3v%c%c"
+
+
+static unsigned int region_flags[] = {
+	PS3_STORAGE_FLAG_SKIP_ACL | PS3_STORAGE_FLAG_ALT_KEY,	/* raw vflash */
+	PS3_STORAGE_FLAG_SKIP_ACL,				/* lpar 1 */
+	PS3_STORAGE_FLAG_ALT_KEY,				/* dev_flash */
+	PS3_STORAGE_FLAG_ALT_KEY,				/* dev_flash2 */
+	PS3_STORAGE_FLAG_ALT_KEY,				/* dev_flash3 */
+	PS3_STORAGE_FLAG_DEFAULT,				/* otheros */
+	PS3_STORAGE_FLAG_SKIP_ACL,				/* unknown */
+	PS3_STORAGE_FLAG_DEFAULT,				/* n/a */
+};
+module_param_array(region_flags, uint, NULL, S_IRUGO);
+MODULE_PARM_DESC(region_flags, "Region flags");
+
+struct ps3vflash_private {
+	spinlock_t lock;		/* Request queue spinlock */
+	struct request_queue *queue;
+	unsigned int blocking_factor;
+	struct request *req;
+	unsigned int devidx;
+	struct gendisk *gendisk[0];	/* Must be last */
+};
+
+
+#define LV1_STORAGE_ATA_FLUSH_CACHE	(0x31)
+
+static int ps3vflash_major;
+
+
+static const struct block_device_operations ps3vflash_fops = {
+	.owner		= THIS_MODULE,
+};
+
+
+static void ps3vflash_scatter_gather(struct ps3_storage_device *dev,
+				     struct request *req, int gather)
+{
+	unsigned int offset = 0;
+	struct req_iterator iter;
+	struct bio_vec *bvec;
+	unsigned int i = 0;
+	size_t size;
+	void *buf;
+
+	rq_for_each_segment(bvec, req, iter) {
+		unsigned long flags;
+		dev_dbg(&dev->sbd.core,
+			"%s:%u: bio %u: %u segs %u sectors from %lu\n",
+			__func__, __LINE__, i, bio_segments(iter.bio),
+			bio_sectors(iter.bio), iter.bio->bi_sector);
+
+		size = bvec->bv_len;
+		buf = bvec_kmap_irq(bvec, &flags);
+		if (gather)
+			memcpy(dev->bounce_buf+offset, buf, size);
+		else
+			memcpy(buf, dev->bounce_buf+offset, size);
+		offset += size;
+		flush_kernel_dcache_page(bvec->bv_page);
+		bvec_kunmap_irq(buf, &flags);
+		i++;
+	}
+}
+
+static int ps3vflash_submit_request_sg(struct ps3_storage_device *dev,
+				       struct request *req)
+{
+	struct ps3vflash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
+	int write = rq_data_dir(req), res;
+	const char *op = write ? "write" : "read";
+	u64 start_sector, sectors;
+	unsigned int region_idx = MINOR(disk_devt(req->rq_disk)) &
+				  (PS3VFLASH_MINORS - 1);
+	unsigned int region_id = dev->regions[region_idx].id;
+	u64 flags = dev->regions[region_idx].flags;
+
+#ifdef DEBUG
+	unsigned int n = 0;
+	struct bio_vec *bv;
+	struct req_iterator iter;
+
+	rq_for_each_segment(bv, req, iter)
+		n++;
+	dev_dbg(&dev->sbd.core,
+		"%s:%u: %s req has %u bvecs for %u sectors\n",
+		__func__, __LINE__, op, n, blk_rq_sectors(req));
+#endif
+
+	start_sector = blk_rq_pos(req) * priv->blocking_factor;
+	sectors = blk_rq_sectors(req) * priv->blocking_factor;
+	dev_dbg(&dev->sbd.core, "%s:%u: %s %llu sectors starting at %llu\n",
+		__func__, __LINE__, op, sectors, start_sector);
+
+	if (write) {
+		ps3vflash_scatter_gather(dev, req, 1);
+
+		res = lv1_storage_write(dev->sbd.dev_id, region_id,
+					start_sector, sectors, flags,
+					dev->bounce_lpar, &dev->tag);
+	} else {
+		res = lv1_storage_read(dev->sbd.dev_id, region_id,
+				       start_sector, sectors, flags,
+				       dev->bounce_lpar, &dev->tag);
+	}
+	if (res) {
+		dev_err(&dev->sbd.core, "%s:%u: %s failed %d\n", __func__,
+			__LINE__, op, res);
+		__blk_end_request_all(req, -EIO);
+		return 0;
+	}
+
+	priv->req = req;
+	return 1;
+}
+
+static int ps3vflash_submit_flush_request(struct ps3_storage_device *dev,
+					  struct request *req)
+{
+	struct ps3vflash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
+	u64 res;
+
+	dev_dbg(&dev->sbd.core, "%s:%u: flush request\n", __func__, __LINE__);
+
+	res = lv1_storage_send_device_command(dev->sbd.dev_id,
+					      LV1_STORAGE_ATA_FLUSH_CACHE,
+					      0, 0, 0, 0, &dev->tag);
+	if (res) {
+		dev_err(&dev->sbd.core, "%s:%u: sync cache failed 0x%llx\n",
+			__func__, __LINE__, res);
+		__blk_end_request_all(req, -EIO);
+		return 0;
+	}
+
+	priv->req = req;
+	return 1;
+}
+
+static void ps3vflash_do_request(struct ps3_storage_device *dev,
+				 struct request_queue *q)
+{
+	struct request *req;
+
+	dev_dbg(&dev->sbd.core, "%s:%u\n", __func__, __LINE__);
+
+	while ((req = blk_fetch_request(q))) {
+		if (req->cmd_flags & REQ_FLUSH) {
+			if (ps3vflash_submit_flush_request(dev, req))
+				break;
+		} else if (req->cmd_type == REQ_TYPE_FS) {
+			if (ps3vflash_submit_request_sg(dev, req))
+				break;
+		} else {
+			blk_dump_rq_flags(req, DEVICE_NAME " bad request");
+			__blk_end_request_all(req, -EIO);
+			continue;
+		}
+	}
+}
+
+static void ps3vflash_request(struct request_queue *q)
+{
+	struct ps3_storage_device *dev = q->queuedata;
+	struct ps3vflash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
+
+	if (priv->req) {
+		dev_dbg(&dev->sbd.core, "%s:%u busy\n", __func__, __LINE__);
+		return;
+	}
+
+	ps3vflash_do_request(dev, q);
+}
+
+static irqreturn_t ps3vflash_interrupt(int irq, void *data)
+{
+	struct ps3_storage_device *dev = data;
+	struct ps3vflash_private *priv;
+	struct request *req;
+	int res, read, error;
+	u64 tag, status;
+	const char *op;
+
+	res = lv1_storage_get_async_status(dev->sbd.dev_id, &tag, &status);
+
+	if (tag != dev->tag)
+		dev_err(&dev->sbd.core,
+			"%s:%u: tag mismatch, got %llx, expected %llx\n",
+			__func__, __LINE__, tag, dev->tag);
+
+	if (res) {
+		dev_err(&dev->sbd.core, "%s:%u: res=%d status=0x%llx\n",
+			__func__, __LINE__, res, status);
+		return IRQ_HANDLED;
+	}
+
+	priv = ps3_system_bus_get_drvdata(&dev->sbd);
+	req = priv->req;
+	if (!req) {
+		dev_dbg(&dev->sbd.core,
+			"%s:%u non-block layer request completed\n", __func__,
+			__LINE__);
+		dev->lv1_status = status;
+		complete(&dev->done);
+		return IRQ_HANDLED;
+	}
+
+	if (req->cmd_flags & REQ_FLUSH) {
+		read = 0;
+		op = "flush";
+	} else {
+		read = !rq_data_dir(req);
+		op = read ? "read" : "write";
+	}
+	if (status) {
+		dev_dbg(&dev->sbd.core, "%s:%u: %s failed 0x%llx\n", __func__,
+			__LINE__, op, status);
+		error = -EIO;
+	} else {
+		dev_dbg(&dev->sbd.core, "%s:%u: %s completed\n", __func__,
+			__LINE__, op);
+		error = 0;
+		if (read)
+			ps3vflash_scatter_gather(dev, req, 0);
+	}
+
+	spin_lock(&priv->lock);
+	__blk_end_request_all(req, error);
+	priv->req = NULL;
+	ps3vflash_do_request(dev, priv->queue);
+	spin_unlock(&priv->lock);
+
+	return IRQ_HANDLED;
+}
+
+static unsigned long ps3vflash_mask;
+
+static DEFINE_MUTEX(ps3vflash_mask_mutex);
+
+static int __devinit ps3vflash_probe(struct ps3_system_bus_device *_dev)
+{
+	struct ps3_storage_device *dev = to_ps3_storage_device(&_dev->core);
+	struct ps3vflash_private *priv;
+	int error;
+	unsigned int devidx;
+	struct request_queue *queue;
+	struct gendisk *gendisk;
+	u64 raw_capacity;
+	unsigned int region_idx;
+
+	if (dev->blk_size < 512) {
+		dev_err(&dev->sbd.core,
+			"%s:%u: cannot handle block size %llu\n", __func__,
+			__LINE__, dev->blk_size);
+		return -EINVAL;
+	}
+
+	BUILD_BUG_ON(PS3VFLASH_MAX_DISKS > BITS_PER_LONG);
+	mutex_lock(&ps3vflash_mask_mutex);
+	devidx = find_first_zero_bit(&ps3vflash_mask, PS3VFLASH_MAX_DISKS);
+	if (devidx >= PS3VFLASH_MAX_DISKS) {
+		dev_err(&dev->sbd.core, "%s:%u: Too many disks\n", __func__,
+			__LINE__);
+		mutex_unlock(&ps3vflash_mask_mutex);
+		return -ENOSPC;
+	}
+	__set_bit(devidx, &ps3vflash_mask);
+	mutex_unlock(&ps3vflash_mask_mutex);
+
+	priv = kzalloc(sizeof(*priv) +
+		       dev->num_regions * sizeof(struct gendisk),
+		       GFP_KERNEL);
+	if (!priv) {
+		error = -ENOMEM;
+		goto fail;
+	}
+
+	ps3_system_bus_set_drvdata(_dev, priv);
+	spin_lock_init(&priv->lock);
+
+	dev->bounce_size = BOUNCE_SIZE;
+	dev->bounce_buf = kmalloc(BOUNCE_SIZE, GFP_DMA);
+	if (!dev->bounce_buf) {
+		error = -ENOMEM;
+		goto fail_free_priv;
+	}
+
+	for (region_idx = 0; region_idx < dev->num_regions; region_idx++)
+		dev->regions[region_idx].flags = region_flags[region_idx];
+
+	error = ps3stor_setup(dev, ps3vflash_interrupt);
+	if (error)
+		goto fail_free_bounce;
+
+	priv->devidx = devidx;
+
+	queue = blk_init_queue(ps3vflash_request, &priv->lock);
+	if (!queue) {
+		dev_err(&dev->sbd.core, "%s:%u: blk_init_queue failed\n",
+			__func__, __LINE__);
+		error = -ENOMEM;
+		goto fail_teardown;
+	}
+
+	priv->queue = queue;
+	queue->queuedata = dev;
+
+	blk_queue_bounce_limit(queue, BLK_BOUNCE_HIGH);
+
+	blk_queue_max_hw_sectors(queue, dev->bounce_size >> 9);
+	blk_queue_segment_boundary(queue, -1UL);
+	blk_queue_dma_alignment(queue, dev->blk_size-1);
+	blk_queue_logical_block_size(queue, dev->blk_size);
+
+	blk_queue_flush(queue, REQ_FLUSH);
+
+	blk_queue_max_segments(queue, -1);
+	blk_queue_max_segment_size(queue, dev->bounce_size);
+
+	if (test_bit(0, &dev->accessible_regions) == 0) {
+		raw_capacity = 0;
+		for (region_idx = 0; region_idx < dev->num_regions;
+		     region_idx++)
+			if (test_bit(region_idx, &dev->accessible_regions))
+				raw_capacity += dev->regions[0].size;
+	} else {
+		raw_capacity = dev->regions[0].size;
+	}
+
+	dev_info(&dev->sbd.core, "%llu MiB\n", raw_capacity >> 11);
+
+	for (region_idx = 0; region_idx < dev->num_regions; region_idx++) {
+		if (test_bit(region_idx, &dev->accessible_regions) == 0)
+			continue;
+
+		gendisk = alloc_disk(PS3VFLASH_MINORS *
+				     PS3_STORAGE_MAX_REGIONS);
+		if (!gendisk) {
+			dev_err(&dev->sbd.core, "%s:%u: alloc_disk failed\n",
+				__func__, __LINE__);
+			error = -ENOMEM;
+			goto fail_cleanup_queue;
+		}
+
+		priv->gendisk[region_idx] = gendisk;
+		gendisk->major = ps3vflash_major;
+		gendisk->first_minor = devidx * PS3VFLASH_MINORS + region_idx;
+		gendisk->fops = &ps3vflash_fops;
+		gendisk->queue = queue;
+		gendisk->private_data = dev;
+		gendisk->driverfs_dev = &dev->sbd.core;
+
+		snprintf(gendisk->disk_name, sizeof(gendisk->disk_name),
+			 PS3VFLASH_NAME, '1' + devidx, 'a' + region_idx);
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
+	}
+
+	return 0;
+
+fail_cleanup_queue:
+	for (region_idx = 0; region_idx < dev->num_regions; region_idx++)
+		if (priv->gendisk[region_idx])
+			del_gendisk(priv->gendisk[region_idx]);
+
+	blk_cleanup_queue(queue);
+fail_teardown:
+	ps3stor_teardown(dev);
+fail_free_bounce:
+	kfree(dev->bounce_buf);
+fail_free_priv:
+	kfree(priv);
+	ps3_system_bus_set_drvdata(_dev, NULL);
+fail:
+	mutex_lock(&ps3vflash_mask_mutex);
+	__clear_bit(devidx, &ps3vflash_mask);
+	mutex_unlock(&ps3vflash_mask_mutex);
+	return error;
+}
+
+static int ps3vflash_remove(struct ps3_system_bus_device *_dev)
+{
+	struct ps3_storage_device *dev = to_ps3_storage_device(&_dev->core);
+	struct ps3vflash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
+	unsigned int region_idx;
+
+	mutex_lock(&ps3vflash_mask_mutex);
+	__clear_bit(priv->devidx, &ps3vflash_mask);
+	mutex_unlock(&ps3vflash_mask_mutex);
+
+	for (region_idx = 0; region_idx < dev->num_regions; region_idx++) {
+		if (test_bit(region_idx, &dev->accessible_regions) == 0)
+			continue;
+
+		del_gendisk(priv->gendisk[region_idx]);
+	}
+
+	blk_cleanup_queue(priv->queue);
+
+	for (region_idx = 0; region_idx < dev->num_regions; region_idx++) {
+		if (test_bit(region_idx, &dev->accessible_regions) == 0)
+			continue;
+
+		put_disk(priv->gendisk[region_idx]);
+	}
+
+	ps3stor_teardown(dev);
+	kfree(dev->bounce_buf);
+	kfree(priv);
+	ps3_system_bus_set_drvdata(_dev, NULL);
+	return 0;
+}
+
+static struct ps3_system_bus_driver ps3vflash = {
+	.match_id	= PS3_MATCH_ID_STOR_FLASH,
+	.core.name	= DEVICE_NAME,
+	.core.owner	= THIS_MODULE,
+	.probe		= ps3vflash_probe,
+	.remove		= ps3vflash_remove,
+	.shutdown	= ps3vflash_remove,
+};
+
+
+static int __init ps3vflash_init(void)
+{
+	int error;
+
+	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
+		return -ENODEV;
+
+	if (ps3_get_ss_laid() == PS3_SS_LAID_OTHEROS)
+		return -ENODEV;
+
+	error = register_blkdev(0, DEVICE_NAME);
+	if (error <= 0) {
+		printk(KERN_ERR "%s:%u: register_blkdev failed %d\n", __func__,
+		       __LINE__, error);
+		return error;
+	}
+	ps3vflash_major = error;
+
+	pr_info("%s:%u: registered block device major %d\n", __func__,
+		__LINE__, ps3vflash_major);
+
+	error = ps3_system_bus_driver_register(&ps3vflash);
+	if (error)
+		unregister_blkdev(ps3vflash_major, DEVICE_NAME);
+
+	return error;
+}
+
+static void __exit ps3vflash_exit(void)
+{
+	ps3_system_bus_driver_unregister(&ps3vflash);
+	unregister_blkdev(ps3vflash_major, DEVICE_NAME);
+}
+
+module_init(ps3vflash_init);
+module_exit(ps3vflash_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PS3 VFLASH Storage Driver");
+MODULE_AUTHOR("Andre Heider");
+MODULE_ALIAS(PS3_MODULE_ALIAS_STOR_FLASH);
-- 
1.7.5.4
