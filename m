Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 14 Jan 2009 17:04:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [PATCH 07/13] powerpc/ps3: printing fixups for l64 to ll64
	conversion: drivers/block
Message-Id: <20090114170448.7bffcb81.sfr@canb.auug.org.au>
In-Reply-To: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
References: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jens Axboe <axboe@kernel.dk>, ppc-dev <linuxppc-dev@ozlabs.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/block/ps3disk.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

Jens, if its OK by you, this could go in via the PowerPC tree.

diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 936466f..bccc42b 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -141,7 +141,7 @@ static int ps3disk_submit_request_sg(struct ps3_storage_device *dev,
 
 	start_sector = req->sector * priv->blocking_factor;
 	sectors = req->nr_sectors * priv->blocking_factor;
-	dev_dbg(&dev->sbd.core, "%s:%u: %s %lu sectors starting at %lu\n",
+	dev_dbg(&dev->sbd.core, "%s:%u: %s %llu sectors starting at %llu\n",
 		__func__, __LINE__, op, sectors, start_sector);
 
 	if (write) {
@@ -178,7 +178,7 @@ static int ps3disk_submit_flush_request(struct ps3_storage_device *dev,
 					      LV1_STORAGE_ATA_HDDOUT, 0, 0, 0,
 					      0, &dev->tag);
 	if (res) {
-		dev_err(&dev->sbd.core, "%s:%u: sync cache failed 0x%lx\n",
+		dev_err(&dev->sbd.core, "%s:%u: sync cache failed 0x%llx\n",
 			__func__, __LINE__, res);
 		end_request(req, 0);
 		return 0;
@@ -238,11 +238,11 @@ static irqreturn_t ps3disk_interrupt(int irq, void *data)
 
 	if (tag != dev->tag)
 		dev_err(&dev->sbd.core,
-			"%s:%u: tag mismatch, got %lx, expected %lx\n",
+			"%s:%u: tag mismatch, got %llx, expected %llx\n",
 			__func__, __LINE__, tag, dev->tag);
 
 	if (res) {
-		dev_err(&dev->sbd.core, "%s:%u: res=%d status=0x%lx\n",
+		dev_err(&dev->sbd.core, "%s:%u: res=%d status=0x%llx\n",
 			__func__, __LINE__, res, status);
 		return IRQ_HANDLED;
 	}
@@ -269,7 +269,7 @@ static irqreturn_t ps3disk_interrupt(int irq, void *data)
 		op = read ? "read" : "write";
 	}
 	if (status) {
-		dev_dbg(&dev->sbd.core, "%s:%u: %s failed 0x%lx\n", __func__,
+		dev_dbg(&dev->sbd.core, "%s:%u: %s failed 0x%llx\n", __func__,
 			__LINE__, op, status);
 		error = -EIO;
 	} else {
@@ -297,7 +297,7 @@ static int ps3disk_sync_cache(struct ps3_storage_device *dev)
 
 	res = ps3stor_send_command(dev, LV1_STORAGE_ATA_HDDOUT, 0, 0, 0, 0);
 	if (res) {
-		dev_err(&dev->sbd.core, "%s:%u: sync cache failed 0x%lx\n",
+		dev_err(&dev->sbd.core, "%s:%u: sync cache failed 0x%llx\n",
 			__func__, __LINE__, res);
 		return -EIO;
 	}
@@ -388,7 +388,7 @@ static int ps3disk_identify(struct ps3_storage_device *dev)
 				   sizeof(ata_cmnd), ata_cmnd.buffer,
 				   ata_cmnd.arglen);
 	if (res) {
-		dev_err(&dev->sbd.core, "%s:%u: identify disk failed 0x%lx\n",
+		dev_err(&dev->sbd.core, "%s:%u: identify disk failed 0x%llx\n",
 			__func__, __LINE__, res);
 		return -EIO;
 	}
@@ -426,7 +426,7 @@ static int __devinit ps3disk_probe(struct ps3_system_bus_device *_dev)
 
 	if (dev->blk_size < 512) {
 		dev_err(&dev->sbd.core,
-			"%s:%u: cannot handle block size %lu\n", __func__,
+			"%s:%u: cannot handle block size %llu\n", __func__,
 			__LINE__, dev->blk_size);
 		return -EINVAL;
 	}
@@ -512,7 +512,7 @@ static int __devinit ps3disk_probe(struct ps3_system_bus_device *_dev)
 		     dev->regions[dev->region_idx].size*priv->blocking_factor);
 
 	dev_info(&dev->sbd.core,
-		 "%s is a %s (%lu MiB total, %lu MiB for OtherOS)\n",
+		 "%s is a %s (%llu MiB total, %lu MiB for OtherOS)\n",
 		 gendisk->disk_name, priv->model, priv->raw_capacity >> 11,
 		 get_capacity(gendisk) >> 11);
 
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
