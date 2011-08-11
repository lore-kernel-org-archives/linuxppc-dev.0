Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH part1 v2 3/9] ps3: Get lv1 high memory region from the
	repository
Date: Thu, 11 Aug 2011 21:31:07 +0200
Message-Id: <1313091073-4572-4-git-send-email-a.heider@gmail.com>
In-Reply-To: <1313091073-4572-1-git-send-email-a.heider@gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1313091073-4572-1-git-send-email-a.heider@gmail.com>
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

This lets the bootloader preallocate the high lv1 region and pass its
location to the kernel through the repository. Thus, it can be used to
hold the initrd. If the region info doesn't exist, the kernel retains
the old behavior and attempts to allocate the region itself.

Based on the patch
"[PS3] Get lv1 high memory region from devtree"
from Hector Martin <hector@marcansoft.com>

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/powerpc/platforms/ps3/mm.c |   46 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index c204588..983b719 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -78,12 +78,14 @@ enum {
  * @base: base address
  * @size: size in bytes
  * @offset: difference between base and rm.size
+ * @destroy: flag if region should be destroyed upon shutdown
  */
 
 struct mem_region {
 	u64 base;
 	u64 size;
 	unsigned long offset;
+	int destroy;
 };
 
 /**
@@ -261,6 +263,7 @@ static int ps3_mm_region_create(struct mem_region *r, unsigned long size)
 		goto zero_region;
 	}
 
+	r->destroy = 1;
 	r->offset = r->base - map.rm.size;
 	return result;
 
@@ -279,6 +282,12 @@ static void ps3_mm_region_destroy(struct mem_region *r)
 	int result;
 
 	DBG("%s:%d: r->base = %llxh\n", __func__, __LINE__, r->base);
+
+	if (!r->destroy) {
+		DBG("%s:%d: not destroying region\n", __func__, __LINE__);
+		return;
+	}
+
 	if (r->base) {
 		result = lv1_release_memory(r->base);
 		BUG_ON(result);
@@ -287,6 +296,29 @@ static void ps3_mm_region_destroy(struct mem_region *r)
 	}
 }
 
+static int ps3_mm_get_repository_highmem(struct mem_region *r)
+{
+	int result = ps3_repository_read_highmem_info(&r->base, &r->size);
+
+	if (result)
+		goto zero_region;
+
+	if (!r->base || !r->size) {
+		result = -1;
+		goto zero_region;
+	}
+
+	r->offset = r->base - map.rm.size;
+	DBG("%s:%d got high region from repository: %llxh %llxh\n",
+	    __func__, __LINE__, r->base, r->size);
+	return 0;
+
+zero_region:
+	DBG("%s:%d no high region in repository...\n", __func__, __LINE__);
+	r->size = r->base = r->offset = 0;
+	return result;
+}
+
 /**
  * ps3_mm_add_memory - hot add memory
  */
@@ -303,6 +335,12 @@ static int __init ps3_mm_add_memory(void)
 
 	BUG_ON(!mem_init_done);
 
+	if (!map.r1.size) {
+		DBG("%s:%d: no region 1, not adding memory\n",
+		    __func__, __LINE__);
+		return 0;
+	}
+
 	start_addr = map.rm.size;
 	start_pfn = start_addr >> PAGE_SHIFT;
 	nr_pages = (map.r1.size + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -1217,9 +1255,11 @@ void __init ps3_mm_init(void)
 	BUG_ON(map.rm.base);
 	BUG_ON(!map.rm.size);
 
-
-	/* arrange to do this in ps3_mm_add_memory */
-	ps3_mm_region_create(&map.r1, map.total - map.rm.size);
+	/* check if we got the highmem region from an earlier boot step */
+	if (ps3_mm_get_repository_highmem(&map.r1)) {
+		/* arrange to do this in ps3_mm_add_memory */
+		ps3_mm_region_create(&map.r1, map.total - map.rm.size);
+	}
 
 	/* correct map.total for the real total amount of memory we use */
 	map.total = map.rm.size + map.r1.size;
-- 
1.7.5.4
