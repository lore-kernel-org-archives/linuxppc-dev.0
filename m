Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 14 Jan 2009 17:06:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [PATCH 08/13] powerpc/ps3: printing fixups for l64 to ll64
	convserion: drivers/char
Message-Id: <20090114170602.63494028.sfr@canb.auug.org.au>
In-Reply-To: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
References: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Also a couple of min -> min_t changes.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/ps3flash.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/char/ps3flash.c b/drivers/char/ps3flash.c
index 79b6f46..afbe456 100644
--- a/drivers/char/ps3flash.c
+++ b/drivers/char/ps3flash.c
@@ -44,7 +44,7 @@ static ssize_t ps3flash_read_write_sectors(struct ps3_storage_device *dev,
 	u64 res = ps3stor_read_write_sectors(dev, lpar, start_sector, sectors,
 					     write);
 	if (res) {
-		dev_err(&dev->sbd.core, "%s:%u: %s failed 0x%lx\n", __func__,
+		dev_err(&dev->sbd.core, "%s:%u: %s failed 0x%llx\n", __func__,
 			__LINE__, write ? "write" : "read", res);
 		return -EIO;
 	}
@@ -59,7 +59,7 @@ static ssize_t ps3flash_read_sectors(struct ps3_storage_device *dev,
 
 	max_sectors = dev->bounce_size / dev->blk_size;
 	if (sectors > max_sectors) {
-		dev_dbg(&dev->sbd.core, "%s:%u Limiting sectors to %lu\n",
+		dev_dbg(&dev->sbd.core, "%s:%u Limiting sectors to %llu\n",
 			__func__, __LINE__, max_sectors);
 		sectors = max_sectors;
 	}
@@ -144,7 +144,7 @@ static ssize_t ps3flash_read(struct file *file, char __user *buf, size_t count,
 			goto fail;
 		}
 
-		n = min(remaining, sectors_read*dev->blk_size-offset);
+		n = min_t(u64, remaining, sectors_read*dev->blk_size-offset);
 		dev_dbg(&dev->sbd.core,
 			"%s:%u: copy %lu bytes from 0x%p to user 0x%p\n",
 			__func__, __LINE__, n, dev->bounce_buf+offset, buf);
@@ -225,7 +225,7 @@ static ssize_t ps3flash_write(struct file *file, const char __user *buf,
 		if (end_read_sector >= start_read_sector) {
 			/* Merge head and tail */
 			dev_dbg(&dev->sbd.core,
-				"Merged head and tail: %lu sectors at %lu\n",
+				"Merged head and tail: %llu sectors at %llu\n",
 				chunk_sectors, start_write_sector);
 			res = ps3flash_read_sectors(dev, start_write_sector,
 						    chunk_sectors, 0);
@@ -235,7 +235,7 @@ static ssize_t ps3flash_write(struct file *file, const char __user *buf,
 			if (head) {
 				/* Read head */
 				dev_dbg(&dev->sbd.core,
-					"head: %lu sectors at %lu\n", head,
+					"head: %llu sectors at %llu\n", head,
 					start_write_sector);
 				res = ps3flash_read_sectors(dev,
 							    start_write_sector,
@@ -247,7 +247,7 @@ static ssize_t ps3flash_write(struct file *file, const char __user *buf,
 			    start_write_sector+chunk_sectors) {
 				/* Read tail */
 				dev_dbg(&dev->sbd.core,
-					"tail: %lu sectors at %lu\n", tail,
+					"tail: %llu sectors at %llu\n", tail,
 					start_read_sector);
 				sec_off = start_read_sector-start_write_sector;
 				res = ps3flash_read_sectors(dev,
@@ -258,7 +258,7 @@ static ssize_t ps3flash_write(struct file *file, const char __user *buf,
 			}
 		}
 
-		n = min(remaining, dev->bounce_size-offset);
+		n = min_t(u64, remaining, dev->bounce_size-offset);
 		dev_dbg(&dev->sbd.core,
 			"%s:%u: copy %lu bytes from user 0x%p to 0x%p\n",
 			__func__, __LINE__, n, buf, dev->bounce_buf+offset);
@@ -299,11 +299,11 @@ static irqreturn_t ps3flash_interrupt(int irq, void *data)
 
 	if (tag != dev->tag)
 		dev_err(&dev->sbd.core,
-			"%s:%u: tag mismatch, got %lx, expected %lx\n",
+			"%s:%u: tag mismatch, got %llx, expected %llx\n",
 			__func__, __LINE__, tag, dev->tag);
 
 	if (res) {
-		dev_err(&dev->sbd.core, "%s:%u: res=%d status=0x%lx\n",
+		dev_err(&dev->sbd.core, "%s:%u: res=%d status=0x%llx\n",
 			__func__, __LINE__, res, status);
 	} else {
 		dev->lv1_status = status;
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
