Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 12/15] ps3stor_lib: Add support for storage access flags
Date: Mon,  1 Aug 2011 22:03:03 +0200
Message-Id: <1312228986-32307-13-git-send-email-a.heider@gmail.com>
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

Users can now set the access flags in the region struct. This is
required for accessing the first region, or selecting an alternative
decryption key for the vflash partitions.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/powerpc/include/asm/ps3stor.h       |    8 +++++++-
 arch/powerpc/platforms/ps3/device-init.c |    1 +
 drivers/block/ps3disk.c                  |    5 +++--
 drivers/ps3/ps3stor_lib.c                |    5 +++--
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3stor.h b/arch/powerpc/include/asm/ps3stor.h
index 9871c05..f29aa37 100644
--- a/arch/powerpc/include/asm/ps3stor.h
+++ b/arch/powerpc/include/asm/ps3stor.h
@@ -25,12 +25,18 @@
 
 #include <asm/ps3.h>
 
-#define PS3_STORAGE_MAX_REGIONS		(8)
+#define PS3_STORAGE_MAX_REGIONS			(8)
+
+#define PS3_STORAGE_FLAG_DEFAULT		(0)
+#define PS3_STORAGE_FLAG_SKIP_ACL		(1 << 1)
+#define PS3_STORAGE_FLAG_ALT_KEY		(1 << 2)
+#define PS3_STORAGE_FLAG_UNENCRYPTED	(1 << 5)
 
 struct ps3_storage_region {
 	unsigned int id;
 	u64 start;
 	u64 size;
+	u64 flags;
 };
 
 struct ps3_storage_device {
diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
index 830d741..7a3dbf8 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -409,6 +409,7 @@ static int ps3_setup_storage_dev(const struct ps3_repository_device *repo,
 		p->regions[i].id = id;
 		p->regions[i].start = start;
 		p->regions[i].size = size;
+		p->regions[i].flags = PS3_STORAGE_FLAG_DEFAULT;
 	}
 
 	result = ps3_system_bus_device_register(&p->sbd);
diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index cba8b45..30dae10 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -130,6 +130,7 @@ static int ps3disk_submit_request_sg(struct ps3_storage_device *dev,
 	unsigned int region_idx = MINOR(disk_devt(req->rq_disk)) &
 				  (PS3DISK_MINORS - 1);
 	unsigned int region_id = dev->regions[region_idx].id;
+	u64 flags = dev->regions[region_idx].flags;
 
 #ifdef DEBUG
 	unsigned int n = 0;
@@ -152,11 +153,11 @@ static int ps3disk_submit_request_sg(struct ps3_storage_device *dev,
 		ps3disk_scatter_gather(dev, req, 1);
 
 		res = lv1_storage_write(dev->sbd.dev_id, region_id,
-					start_sector, sectors, 0,
+					start_sector, sectors, flags,
 					dev->bounce_lpar, &dev->tag);
 	} else {
 		res = lv1_storage_read(dev->sbd.dev_id, region_id,
-				       start_sector, sectors, 0,
+				       start_sector, sectors, flags,
 				       dev->bounce_lpar, &dev->tag);
 	}
 	if (res) {
diff --git a/drivers/ps3/ps3stor_lib.c b/drivers/ps3/ps3stor_lib.c
index 5bbc023..8bb54ac 100644
--- a/drivers/ps3/ps3stor_lib.c
+++ b/drivers/ps3/ps3stor_lib.c
@@ -275,6 +275,7 @@ u64 ps3stor_read_write_sectors(struct ps3_storage_device *dev,
 			       u64 start_sector, u64 sectors, int write)
 {
 	unsigned int region_id = dev->regions[region_idx].id;
+	u64 flags = dev->regions[region_idx].flags;
 	const char *op = write ? "write" : "read";
 	int res;
 
@@ -283,10 +284,10 @@ u64 ps3stor_read_write_sectors(struct ps3_storage_device *dev,
 
 	init_completion(&dev->done);
 	res = write ? lv1_storage_write(dev->sbd.dev_id, region_id,
-					start_sector, sectors, 0, lpar,
+					start_sector, sectors, flags, lpar,
 					&dev->tag)
 		    : lv1_storage_read(dev->sbd.dev_id, region_id,
-				       start_sector, sectors, 0, lpar,
+				       start_sector, sectors, flags, lpar,
 				       &dev->tag);
 	if (res) {
 		dev_dbg(&dev->sbd.core, "%s:%u: %s failed %d\n", __func__,
-- 
1.7.5.4
