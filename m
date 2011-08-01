Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 06/15] ps3flash: Fix region align checks
Date: Mon,  1 Aug 2011 22:02:57 +0200
Message-Id: <1312228986-32307-7-git-send-email-a.heider@gmail.com>
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

The region fields used by the align checks are set in
ps3stor_setup(), so move those after that call.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 drivers/char/ps3flash.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/char/ps3flash.c b/drivers/char/ps3flash.c
index 85c004a..69c734a 100644
--- a/drivers/char/ps3flash.c
+++ b/drivers/char/ps3flash.c
@@ -360,21 +360,6 @@ static int __devinit ps3flash_probe(struct ps3_system_bus_device *_dev)
 	int error;
 	unsigned long tmp;
 
-	tmp = dev->regions[dev->region_idx].start*dev->blk_size;
-	if (tmp % FLASH_BLOCK_SIZE) {
-		dev_err(&dev->sbd.core,
-			"%s:%u region start %lu is not aligned\n", __func__,
-			__LINE__, tmp);
-		return -EINVAL;
-	}
-	tmp = dev->regions[dev->region_idx].size*dev->blk_size;
-	if (tmp % FLASH_BLOCK_SIZE) {
-		dev_err(&dev->sbd.core,
-			"%s:%u region size %lu is not aligned\n", __func__,
-			__LINE__, tmp);
-		return -EINVAL;
-	}
-
 	/* use static buffer, kmalloc cannot allocate 256 KiB */
 	if (!ps3flash_bounce_buffer.address)
 		return -ENODEV;
@@ -405,6 +390,21 @@ static int __devinit ps3flash_probe(struct ps3_system_bus_device *_dev)
 	if (error)
 		goto fail_free_priv;
 
+	tmp = dev->regions[dev->region_idx].start*dev->blk_size;
+	if (tmp % FLASH_BLOCK_SIZE) {
+		dev_err(&dev->sbd.core,
+			"%s:%u region start %lu is not aligned\n", __func__,
+			__LINE__, tmp);
+		return -EINVAL;
+	}
+	tmp = dev->regions[dev->region_idx].size*dev->blk_size;
+	if (tmp % FLASH_BLOCK_SIZE) {
+		dev_err(&dev->sbd.core,
+			"%s:%u region size %lu is not aligned\n", __func__,
+			__LINE__, tmp);
+		return -EINVAL;
+	}
+
 	ps3flash_misc.parent = &dev->sbd.core;
 	error = misc_register(&ps3flash_misc);
 	if (error) {
-- 
1.7.5.4
