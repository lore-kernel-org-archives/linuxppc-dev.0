Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 10/15] ps3stor_lib: Add support for multiple regions
Date: Mon,  1 Aug 2011 22:03:01 +0200
Message-Id: <1312228986-32307-11-git-send-email-a.heider@gmail.com>
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

Users (ps3disk, ps3flash and ps3rom) retain the old behavior. That is:
they still only provide access to the first accessible region.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/powerpc/include/asm/ps3stor.h |    4 ++--
 drivers/block/ps3disk.c            |   15 +++++++++++++--
 drivers/char/ps3flash.c            |   23 +++++++++++++++++------
 drivers/ps3/ps3stor_lib.c          |   25 ++++++++++++-------------
 drivers/scsi/ps3rom.c              |   11 +++++++----
 5 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3stor.h b/arch/powerpc/include/asm/ps3stor.h
index d51e53c..9871c05 100644
--- a/arch/powerpc/include/asm/ps3stor.h
+++ b/arch/powerpc/include/asm/ps3stor.h
@@ -51,7 +51,6 @@ struct ps3_storage_device {
 
 	unsigned int num_regions;
 	unsigned long accessible_regions;
-	unsigned int region_idx;		/* first accessible region */
 	struct ps3_storage_region regions[0];	/* Must be last */
 };
 
@@ -63,7 +62,8 @@ static inline struct ps3_storage_device *to_ps3_storage_device(struct device *de
 extern int ps3stor_setup(struct ps3_storage_device *dev,
 			 irq_handler_t handler);
 extern void ps3stor_teardown(struct ps3_storage_device *dev);
-extern u64 ps3stor_read_write_sectors(struct ps3_storage_device *dev, u64 lpar,
+extern u64 ps3stor_read_write_sectors(struct ps3_storage_device *dev,
+				      unsigned int region_idx, u64 lpar,
 				      u64 start_sector, u64 sectors,
 				      int write);
 extern u64 ps3stor_send_command(struct ps3_storage_device *dev, u64 cmd,
diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 8e1ce2e..96e00ff 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -42,6 +42,7 @@ struct ps3disk_private {
 	spinlock_t lock;		/* Request queue spinlock */
 	struct request_queue *queue;
 	struct gendisk *gendisk;
+	unsigned int region_idx;	/* first accessible region */
 	unsigned int blocking_factor;
 	struct request *req;
 	u64 raw_capacity;
@@ -125,7 +126,7 @@ static int ps3disk_submit_request_sg(struct ps3_storage_device *dev,
 	int write = rq_data_dir(req), res;
 	const char *op = write ? "write" : "read";
 	u64 start_sector, sectors;
-	unsigned int region_id = dev->regions[dev->region_idx].id;
+	unsigned int region_id = dev->regions[priv->region_idx].id;
 
 #ifdef DEBUG
 	unsigned int n = 0;
@@ -408,6 +409,7 @@ static int __devinit ps3disk_probe(struct ps3_system_bus_device *_dev)
 	unsigned int devidx;
 	struct request_queue *queue;
 	struct gendisk *gendisk;
+	unsigned int region_idx;
 
 	if (dev->blk_size < 512) {
 		dev_err(&dev->sbd.core,
@@ -482,6 +484,14 @@ static int __devinit ps3disk_probe(struct ps3_system_bus_device *_dev)
 	}
 
 	priv->gendisk = gendisk;
+
+	/* find first accessible region */
+	for (region_idx = 0; region_idx < dev->num_regions; region_idx++)
+		if (test_bit(region_idx, &dev->accessible_regions)) {
+			priv->region_idx = region_idx;
+			break;
+		}
+
 	gendisk->major = ps3disk_major;
 	gendisk->first_minor = devidx * PS3DISK_MINORS;
 	gendisk->fops = &ps3disk_fops;
@@ -492,7 +502,8 @@ static int __devinit ps3disk_probe(struct ps3_system_bus_device *_dev)
 		 devidx+'a');
 	priv->blocking_factor = dev->blk_size >> 9;
 	set_capacity(gendisk,
-		     dev->regions[dev->region_idx].size*priv->blocking_factor);
+		     dev->regions[priv->region_idx].size *
+				 priv->blocking_factor);
 
 	dev_info(&dev->sbd.core,
 		 "%s is a %s (%llu MiB total, %lu MiB for OtherOS)\n",
diff --git a/drivers/char/ps3flash.c b/drivers/char/ps3flash.c
index b1e8659..47b1dc7 100644
--- a/drivers/char/ps3flash.c
+++ b/drivers/char/ps3flash.c
@@ -36,6 +36,7 @@
 struct ps3flash_private {
 	struct mutex mutex;	/* Bounce buffer mutex */
 	u64 chunk_sectors;
+	unsigned int region_idx;	/* first accessible region */
 	int tag;		/* Start sector of buffer, -1 if invalid */
 	bool dirty;
 };
@@ -46,7 +47,8 @@ static int ps3flash_read_write_sectors(struct ps3_storage_device *dev,
 				       u64 start_sector, int write)
 {
 	struct ps3flash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
-	u64 res = ps3stor_read_write_sectors(dev, dev->bounce_lpar,
+	u64 res = ps3stor_read_write_sectors(dev, priv->region_idx,
+					     dev->bounce_lpar,
 					     start_sector, priv->chunk_sectors,
 					     write);
 	if (res) {
@@ -98,6 +100,7 @@ static int ps3flash_fetch(struct ps3_storage_device *dev, u64 start_sector)
 static loff_t ps3flash_llseek(struct file *file, loff_t offset, int origin)
 {
 	struct ps3_storage_device *dev = ps3flash_dev;
+	struct ps3flash_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 	loff_t res;
 
 	mutex_lock(&file->f_mapping->host->i_mutex);
@@ -106,7 +109,7 @@ static loff_t ps3flash_llseek(struct file *file, loff_t offset, int origin)
 		offset += file->f_pos;
 		break;
 	case 2:
-		offset += dev->regions[dev->region_idx].size*dev->blk_size;
+		offset += dev->regions[priv->region_idx].size*dev->blk_size;
 		break;
 	}
 	if (offset < 0) {
@@ -136,7 +139,7 @@ static ssize_t ps3flash_read(char __user *userbuf, void *kernelbuf,
 		"%s:%u: Reading %zu bytes at position %lld to U0x%p/K0x%p\n",
 		__func__, __LINE__, count, *pos, userbuf, kernelbuf);
 
-	size = dev->regions[dev->region_idx].size*dev->blk_size;
+	size = dev->regions[priv->region_idx].size*dev->blk_size;
 	if (*pos >= size || !count)
 		return 0;
 
@@ -205,7 +208,7 @@ static ssize_t ps3flash_write(const char __user *userbuf,
 		"%s:%u: Writing %zu bytes at position %lld from U0x%p/K0x%p\n",
 		__func__, __LINE__, count, *pos, userbuf, kernelbuf);
 
-	size = dev->regions[dev->region_idx].size*dev->blk_size;
+	size = dev->regions[priv->region_idx].size*dev->blk_size;
 	if (*pos >= size || !count)
 		return 0;
 
@@ -359,6 +362,7 @@ static int __devinit ps3flash_probe(struct ps3_system_bus_device *_dev)
 	struct ps3_storage_device *dev = to_ps3_storage_device(&_dev->core);
 	struct ps3flash_private *priv;
 	int error;
+	unsigned int region_idx;
 	unsigned long tmp;
 
 	/* use static buffer, kmalloc cannot allocate 256 KiB */
@@ -391,14 +395,21 @@ static int __devinit ps3flash_probe(struct ps3_system_bus_device *_dev)
 	if (error)
 		goto fail_free_priv;
 
-	tmp = dev->regions[dev->region_idx].start*dev->blk_size;
+	/* find first accessible region */
+	for (region_idx = 0; region_idx < dev->num_regions; region_idx++)
+		if (test_bit(region_idx, &dev->accessible_regions)) {
+			priv->region_idx = region_idx;
+			break;
+		}
+
+	tmp = dev->regions[priv->region_idx].start*dev->blk_size;
 	if (tmp % FLASH_BLOCK_SIZE) {
 		dev_err(&dev->sbd.core,
 			"%s:%u region start %lu is not aligned\n", __func__,
 			__LINE__, tmp);
 		return -EINVAL;
 	}
-	tmp = dev->regions[dev->region_idx].size*dev->blk_size;
+	tmp = dev->regions[priv->region_idx].size*dev->blk_size;
 	if (tmp % FLASH_BLOCK_SIZE) {
 		dev_err(&dev->sbd.core,
 			"%s:%u region size %lu is not aligned\n", __func__,
diff --git a/drivers/ps3/ps3stor_lib.c b/drivers/ps3/ps3stor_lib.c
index af0afa1..5bbc023 100644
--- a/drivers/ps3/ps3stor_lib.c
+++ b/drivers/ps3/ps3stor_lib.c
@@ -101,9 +101,8 @@ static int ps3stor_probe_access(struct ps3_storage_device *dev)
 			"%s:%u: checking accessibility of region %u\n",
 			__func__, __LINE__, i);
 
-		dev->region_idx = i;
-		res = ps3stor_read_write_sectors(dev, dev->bounce_lpar, 0, 1,
-						 0);
+		res = ps3stor_read_write_sectors(dev, i, dev->bounce_lpar,
+						 0, 1, 0);
 		if (res) {
 			dev_dbg(&dev->sbd.core, "%s:%u: read failed, "
 				"region %u is not accessible\n", __func__,
@@ -117,6 +116,11 @@ static int ps3stor_probe_access(struct ps3_storage_device *dev)
 
 		/* We can access at least one region */
 		error = 0;
+
+		dev_info(&dev->sbd.core,
+			 "Accessible region found: #%u start %llu size %llu\n",
+			 i, dev->regions[i].start, dev->regions[i].size);
+
 	}
 	if (error)
 		return error;
@@ -124,15 +128,8 @@ static int ps3stor_probe_access(struct ps3_storage_device *dev)
 	n = hweight_long(dev->accessible_regions);
 	if (n > 1)
 		dev_info(&dev->sbd.core,
-			 "%s:%u: %lu accessible regions found. Only the first "
-			 "one will be used\n",
+			 "%s:%u: %lu accessible regions found\n",
 			 __func__, __LINE__, n);
-	dev->region_idx = __ffs(dev->accessible_regions);
-	dev_info(&dev->sbd.core,
-		 "First accessible region has index %u start %llu size %llu\n",
-		 dev->region_idx, dev->regions[dev->region_idx].start,
-		 dev->regions[dev->region_idx].size);
-
 	return 0;
 }
 
@@ -264,6 +261,7 @@ EXPORT_SYMBOL_GPL(ps3stor_teardown);
 /**
  *	ps3stor_read_write_sectors - read/write from/to a storage device
  *	@dev: Pointer to a struct ps3_storage_device
+ *	@region_idx: Index of the region to access
  *	@lpar: HV logical partition address
  *	@start_sector: First sector to read/write
  *	@sectors: Number of sectors to read/write
@@ -272,10 +270,11 @@ EXPORT_SYMBOL_GPL(ps3stor_teardown);
  *	Returns 0 for success, -1 in case of failure to submit the command, or
  *	an LV1 status value in case of other errors
  */
-u64 ps3stor_read_write_sectors(struct ps3_storage_device *dev, u64 lpar,
+u64 ps3stor_read_write_sectors(struct ps3_storage_device *dev,
+			       unsigned int region_idx, u64 lpar,
 			       u64 start_sector, u64 sectors, int write)
 {
-	unsigned int region_id = dev->regions[dev->region_idx].id;
+	unsigned int region_id = dev->regions[region_idx].id;
 	const char *op = write ? "write" : "read";
 	int res;
 
diff --git a/drivers/scsi/ps3rom.c b/drivers/scsi/ps3rom.c
index cd178b9..68db03c 100644
--- a/drivers/scsi/ps3rom.c
+++ b/drivers/scsi/ps3rom.c
@@ -39,6 +39,7 @@
 
 #define PS3ROM_MAX_SECTORS		(BOUNCE_SIZE >> 9)
 
+#define PS3ROM_REGION_IDX		0
 
 struct ps3rom_private {
 	struct ps3_storage_device *dev;
@@ -177,8 +178,9 @@ static int ps3rom_read_request(struct ps3_storage_device *dev,
 		__func__, __LINE__, sectors, start_sector);
 
 	res = lv1_storage_read(dev->sbd.dev_id,
-			       dev->regions[dev->region_idx].id, start_sector,
-			       sectors, 0, dev->bounce_lpar, &dev->tag);
+			       dev->regions[PS3ROM_REGION_IDX].id,
+			       start_sector, sectors, 0,
+			       dev->bounce_lpar, &dev->tag);
 	if (res) {
 		dev_err(&dev->sbd.core, "%s:%u: read failed %d\n", __func__,
 			__LINE__, res);
@@ -200,8 +202,9 @@ static int ps3rom_write_request(struct ps3_storage_device *dev,
 	scsi_sg_copy_to_buffer(cmd, dev->bounce_buf, dev->bounce_size);
 
 	res = lv1_storage_write(dev->sbd.dev_id,
-				dev->regions[dev->region_idx].id, start_sector,
-				sectors, 0, dev->bounce_lpar, &dev->tag);
+				dev->regions[PS3ROM_REGION_IDX].id,
+				start_sector, sectors, 0,
+				dev->bounce_lpar, &dev->tag);
 	if (res) {
 		dev_err(&dev->sbd.core, "%s:%u: write failed %d\n", __func__,
 			__LINE__, res);
-- 
1.7.5.4
