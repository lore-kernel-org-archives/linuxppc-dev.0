Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 15/15] ps3: Add a NOR FLASH driver for PS3s without NAND
Date: Mon,  1 Aug 2011 22:03:06 +0200
Message-Id: <1312228986-32307-16-git-send-email-a.heider@gmail.com>
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

A gendisk for each accessible region is created, and a default set
of region flags is provided - overwritable via a module param array.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/powerpc/include/asm/ps3.h           |    2 +
 arch/powerpc/platforms/ps3/Kconfig       |   15 +
 arch/powerpc/platforms/ps3/device-init.c |    7 +
 arch/powerpc/platforms/ps3/platform.h    |    1 +
 arch/powerpc/platforms/ps3/system-bus.c  |    2 +
 drivers/block/Makefile                   |    1 +
 drivers/block/ps3nflash.c                |  473 ++++++++++++++++++++++++++++++
 7 files changed, 501 insertions(+), 0 deletions(-)
 create mode 100644 drivers/block/ps3nflash.c

diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
index 136354a..fe84231 100644
--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -333,6 +333,7 @@ enum ps3_match_id {
 	PS3_MATCH_ID_SOUND		= 9,
 	PS3_MATCH_ID_GPU		= 10,
 	PS3_MATCH_ID_LPM		= 11,
+	PS3_MATCH_ID_STOR_NFLASH	= 12,
 };
 
 enum ps3_match_sub_id {
@@ -352,6 +353,7 @@ enum ps3_match_sub_id {
 #define PS3_MODULE_ALIAS_GPU_FB		"ps3:10:1"
 #define PS3_MODULE_ALIAS_GPU_RAMDISK	"ps3:10:2"
 #define PS3_MODULE_ALIAS_LPM		"ps3:11:0"
+#define PS3_MODULE_ALIAS_STOR_NFLASH	"ps3:12:0"
 
 enum ps3_system_bus_device_type {
 	PS3_DEVICE_TYPE_IOC0 = 1,
diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
index f8d865c..9e1f841 100644
--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -142,6 +142,21 @@ config PS3_VFLASH
 	  select PS3_FLASH above to add support for FLASH ROM for the
 	  OtherOS LPAR.
 
+config PS3_NFLASH
+	tristate "PS3 NFLASH Storage Driver"
+	depends on PPC_PS3 && BLOCK && EXPERT
+	select PS3_STORAGE
+	help
+	  Include support for the PS3 NOR FLASH Storage.
+
+	  This support is required to access the PS3 NOR flash, which can be
+	  found on SKU models starting around October 2007.
+
+	  The NOR flash contains essential boot loaders. Damaging this area
+	  will render the console unbootable.
+
+	  If unsure, say N.
+
 config PS3_VRAM
 	tristate "PS3 Video RAM Storage Driver"
 	depends on FB_PS3=y && BLOCK && m
diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
index 7a3dbf8..c2fbe33 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -601,6 +601,13 @@ static int ps3_setup_dynamic_device(const struct ps3_repository_device *repo)
 				 __func__, __LINE__);
 		break;
 
+	case PS3_DEV_TYPE_STOR_NFLASH:
+		result = ps3_setup_storage_dev(repo, PS3_MATCH_ID_STOR_NFLASH);
+		if (result)
+			pr_debug("%s:%u ps3_setup_storage_dev failed\n",
+				 __func__, __LINE__);
+		break;
+
 	default:
 		result = 0;
 		pr_debug("%s:%u: unsupported dev_type %u\n", __func__, __LINE__,
diff --git a/arch/powerpc/platforms/ps3/platform.h b/arch/powerpc/platforms/ps3/platform.h
index 1ba15b8..94b5048 100644
--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -87,6 +87,7 @@ enum ps3_dev_type {
 	PS3_DEV_TYPE_STOR_ROM = TYPE_ROM,	/* 5 */
 	PS3_DEV_TYPE_SB_GPIO = 6,
 	PS3_DEV_TYPE_STOR_FLASH = TYPE_RBC,	/* 14 */
+	PS3_DEV_TYPE_STOR_NFLASH = 254,
 };
 
 int ps3_repository_read_bus_str(unsigned int bus_index, const char *bus_str,
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 23083c3..810bbc5 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -174,6 +174,7 @@ int ps3_open_hv_device(struct ps3_system_bus_device *dev)
 	case PS3_MATCH_ID_STOR_DISK:
 	case PS3_MATCH_ID_STOR_ROM:
 	case PS3_MATCH_ID_STOR_FLASH:
+	case PS3_MATCH_ID_STOR_NFLASH:
 		return ps3_open_hv_device_sb(dev);
 
 	case PS3_MATCH_ID_SOUND:
@@ -212,6 +213,7 @@ int ps3_close_hv_device(struct ps3_system_bus_device *dev)
 	case PS3_MATCH_ID_STOR_DISK:
 	case PS3_MATCH_ID_STOR_ROM:
 	case PS3_MATCH_ID_STOR_FLASH:
+	case PS3_MATCH_ID_STOR_NFLASH:
 		return ps3_close_hv_device_sb(dev);
 
 	case PS3_MATCH_ID_SOUND:
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 8b02899..ab2bb06 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
 obj-$(CONFIG_AMIGA_FLOPPY)	+= amiflop.o
 obj-$(CONFIG_PS3_DISK)		+= ps3disk.o
 obj-$(CONFIG_PS3_VFLASH)	+= ps3vflash.o
+obj-$(CONFIG_PS3_NFLASH)	+= ps3nflash.o
 obj-$(CONFIG_PS3_VRAM)		+= ps3vram.o
 obj-$(CONFIG_ATARI_FLOPPY)	+= ataflop.o
 obj-$(CONFIG_AMIGA_Z2RAM)	+= z2ram.o
diff --git a/drivers/block/ps3nflash.c b/drivers/block/ps3nflash.c
new file mode 100644
index 0000000..5a7127e
--- /dev/null
+++ b/drivers/block/ps3nflash.c
@@ -0,0 +1,473 @@
+/*
+ * PS3 NOR FLASH Storage Driver
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
+#define DEVICE_NAME		"ps3nflash"
+
+#define BOUNCE_SIZE		(64*1024)
+
+#define PS3NFLASH_MAX_DISKS	16
+#define PS3NFLASH_MINORS	16
+
+
+#define PS3NFLASH_NAME		"ps3n%c%c"
+
+
+static unsigned int region_flags[] = {
+	PS3_STORAGE_FLAG_SKIP_ACL,
+	PS3_STORAGE_FLAG_SKIP_ACL,
+	PS3_STORAGE_FLAG_SKIP_ACL,
+	PS3_STORAGE_FLAG_SKIP_ACL,
+	PS3_STORAGE_FLAG_DEFAULT,
+	PS3_STORAGE_FLAG_DEFAULT,
+	PS3_STORAGE_FLAG_DEFAULT,
+	PS3_STORAGE_FLAG_DEFAULT,
+};
+module_param_array(region_flags, uint, NULL, S_IRUGO);
+MODULE_PARM_DESC(region_flags, "Region flags");
+
+struct ps3nflash_private {
+	spinlock_t lock;		/* Request queue spinlock */
+	struct request_queue *queue;
+	unsigned int blocking_factor;
+	struct request *req;
+	unsigned int devidx;
+	struct gendisk *gendisk[0];	/* Must be last */
+};
+
+static int ps3nflash_major;
+
+
+static const struct block_device_operations ps3nflash_fops = {
+	.owner		= THIS_MODULE,
+};
+
+
+static void ps3nflash_scatter_gather(struct ps3_storage_device *dev,
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
+static int ps3nflash_submit_request_sg(struct ps3_storage_device *dev,
+				       struct request *req)
+{
+	struct ps3nflash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
+	int write = rq_data_dir(req), res;
+	const char *op = write ? "write" : "read";
+	u64 start_sector, sectors;
+	unsigned int region_idx = MINOR(disk_devt(req->rq_disk)) &
+				  (PS3NFLASH_MINORS - 1);
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
+		ps3nflash_scatter_gather(dev, req, 1);
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
+static void ps3nflash_do_request(struct ps3_storage_device *dev,
+				 struct request_queue *q)
+{
+	struct request *req;
+
+	dev_dbg(&dev->sbd.core, "%s:%u\n", __func__, __LINE__);
+
+	while ((req = blk_fetch_request(q))) {
+		if (req->cmd_type == REQ_TYPE_FS) {
+			if (ps3nflash_submit_request_sg(dev, req))
+				break;
+		} else {
+			blk_dump_rq_flags(req, DEVICE_NAME " bad request");
+			__blk_end_request_all(req, -EIO);
+			continue;
+		}
+	}
+}
+
+static void ps3nflash_request(struct request_queue *q)
+{
+	struct ps3_storage_device *dev = q->queuedata;
+	struct ps3nflash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
+
+	if (priv->req) {
+		dev_dbg(&dev->sbd.core, "%s:%u busy\n", __func__, __LINE__);
+		return;
+	}
+
+	ps3nflash_do_request(dev, q);
+}
+
+static irqreturn_t ps3nflash_interrupt(int irq, void *data)
+{
+	struct ps3_storage_device *dev = data;
+	struct ps3nflash_private *priv;
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
+	read = !rq_data_dir(req);
+	op = read ? "read" : "write";
+
+	if (status) {
+		dev_dbg(&dev->sbd.core, "%s:%u: %s failed 0x%llx\n", __func__,
+			__LINE__, op, status);
+		error = -EIO;
+	} else {
+		dev_dbg(&dev->sbd.core, "%s:%u: %s completed\n", __func__,
+			__LINE__, op);
+		error = 0;
+		if (read)
+			ps3nflash_scatter_gather(dev, req, 0);
+	}
+
+	spin_lock(&priv->lock);
+	__blk_end_request_all(req, error);
+	priv->req = NULL;
+	ps3nflash_do_request(dev, priv->queue);
+	spin_unlock(&priv->lock);
+
+	return IRQ_HANDLED;
+}
+
+static unsigned long ps3nflash_mask;
+
+static DEFINE_MUTEX(ps3nflash_mask_mutex);
+
+static int __devinit ps3nflash_probe(struct ps3_system_bus_device *_dev)
+{
+	struct ps3_storage_device *dev = to_ps3_storage_device(&_dev->core);
+	struct ps3nflash_private *priv;
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
+	BUILD_BUG_ON(PS3NFLASH_MAX_DISKS > BITS_PER_LONG);
+	mutex_lock(&ps3nflash_mask_mutex);
+	devidx = find_first_zero_bit(&ps3nflash_mask, PS3NFLASH_MAX_DISKS);
+	if (devidx >= PS3NFLASH_MAX_DISKS) {
+		dev_err(&dev->sbd.core, "%s:%u: Too many disks\n", __func__,
+			__LINE__);
+		mutex_unlock(&ps3nflash_mask_mutex);
+		return -ENOSPC;
+	}
+	__set_bit(devidx, &ps3nflash_mask);
+	mutex_unlock(&ps3nflash_mask_mutex);
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
+	error = ps3stor_setup(dev, ps3nflash_interrupt);
+	if (error)
+		goto fail_free_bounce;
+
+	priv->devidx = devidx;
+
+	queue = blk_init_queue(ps3nflash_request, &priv->lock);
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
+		gendisk = alloc_disk(PS3NFLASH_MINORS *
+				     PS3_STORAGE_MAX_REGIONS);
+		if (!gendisk) {
+			dev_err(&dev->sbd.core, "%s:%u: alloc_disk failed\n",
+				__func__, __LINE__);
+			error = -ENOMEM;
+			goto fail_cleanup_queue;
+		}
+
+		priv->gendisk[region_idx] = gendisk;
+		gendisk->major = ps3nflash_major;
+		gendisk->first_minor = devidx * PS3NFLASH_MINORS + region_idx;
+		gendisk->fops = &ps3nflash_fops;
+		gendisk->queue = queue;
+		gendisk->private_data = dev;
+		gendisk->driverfs_dev = &dev->sbd.core;
+
+		snprintf(gendisk->disk_name, sizeof(gendisk->disk_name),
+			 PS3NFLASH_NAME, '1' + devidx, 'a' + region_idx);
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
+	mutex_lock(&ps3nflash_mask_mutex);
+	__clear_bit(devidx, &ps3nflash_mask);
+	mutex_unlock(&ps3nflash_mask_mutex);
+	return error;
+}
+
+static int ps3nflash_remove(struct ps3_system_bus_device *_dev)
+{
+	struct ps3_storage_device *dev = to_ps3_storage_device(&_dev->core);
+	struct ps3nflash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
+	unsigned int region_idx;
+
+	mutex_lock(&ps3nflash_mask_mutex);
+	__clear_bit(priv->devidx, &ps3nflash_mask);
+	mutex_unlock(&ps3nflash_mask_mutex);
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
+static struct ps3_system_bus_driver ps3nflash = {
+	.match_id	= PS3_MATCH_ID_STOR_NFLASH,
+	.core.name	= DEVICE_NAME,
+	.core.owner	= THIS_MODULE,
+	.probe		= ps3nflash_probe,
+	.remove		= ps3nflash_remove,
+	.shutdown	= ps3nflash_remove,
+};
+
+
+static int __init ps3nflash_init(void)
+{
+	int error;
+
+	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
+		return -ENODEV;
+
+	error = register_blkdev(0, DEVICE_NAME);
+	if (error <= 0) {
+		printk(KERN_ERR "%s:%u: register_blkdev failed %d\n", __func__,
+		       __LINE__, error);
+		return error;
+	}
+	ps3nflash_major = error;
+
+	pr_info("%s:%u: registered block device major %d\n", __func__,
+		__LINE__, ps3nflash_major);
+
+	error = ps3_system_bus_driver_register(&ps3nflash);
+	if (error)
+		unregister_blkdev(ps3nflash_major, DEVICE_NAME);
+
+	return error;
+}
+
+static void __exit ps3nflash_exit(void)
+{
+	ps3_system_bus_driver_unregister(&ps3nflash);
+	unregister_blkdev(ps3nflash_major, DEVICE_NAME);
+}
+
+module_init(ps3nflash_init);
+module_exit(ps3nflash_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PS3 NOR FLASH Storage Driver");
+MODULE_AUTHOR("Andre Heider");
+MODULE_ALIAS(PS3_MODULE_ALIAS_STOR_NFLASH);
-- 
1.7.5.4
