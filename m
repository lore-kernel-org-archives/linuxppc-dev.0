Return-Path: <geoff@infradead.org>
Message-Id: <1e755c09926de2d9b0e239ba0ce10fdb6835551a.1335379330.git.geoff@infradead.org>
In-Reply-To: <cover.1335379330.git.geoff@infradead.org>
References: <cover.1335379330.git.geoff@infradead.org>
From: Andre Heider <a.heider@gmail.com>
Subject: [PATCH 05/10] powerpc/ps3: Use highmem region from repository
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Sender: Geoff Levand <geoff@infradead.org>
Date: Wed, 25 Apr 2012 19:19:34 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, Andre Heider <a.heider@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Nathan Whitehorn <nwhitehorn@freebsd.org>,
 Hector Martin <hector@marcansoft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use any preallocated highmem region setup by the bootloader.
This implementation only checks for the existance of a single
region at region_index=0.

This feature allows the bootloader to preallocate highmem
regions and pass the region locations to the kernel through
the repository.  Preallocated regions can be used to hold the
initrd or other large data.  If no region info exists, the
kernel retains the old behavior and attempts to allocate the
highmem region itself.

Based on Hector Martin's patch "Get lv1 high memory region from
devtree".

CC: Hector Martin <hector@marcansoft.com>
Signed-off-by: Andre Heider <a.heider@gmail.com>
CC: Nathan Whitehorn <nwhitehorn@freebsd.org>
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/mm.c |   51 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index de2aea4..05a2bcb 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -79,12 +79,14 @@ enum {
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
@@ -262,6 +264,7 @@ static int ps3_mm_region_create(struct mem_region *r, unsigned long size)
 		goto zero_region;
 	}
 
+	r->destroy = 1;
 	r->offset = r->base - map.rm.size;
 	return result;
 
@@ -279,7 +282,14 @@ static void ps3_mm_region_destroy(struct mem_region *r)
 {
 	int result;
 
+	if (!r->destroy) {
+		pr_info("%s:%d: Not destroying high region: %llxh %llxh\n",
+			__func__, __LINE__, r->base, r->size);
+		return;
+	}
+
 	DBG("%s:%d: r->base = %llxh\n", __func__, __LINE__, r->base);
+
 	if (r->base) {
 		result = lv1_release_memory(r->base);
 		BUG_ON(result);
@@ -288,6 +298,36 @@ static void ps3_mm_region_destroy(struct mem_region *r)
 	}
 }
 
+static int ps3_mm_get_repository_highmem(struct mem_region *r)
+{
+	int result;
+
+	/* Assume a single highmem region. */
+
+	result = ps3_repository_read_highmem_info(0, &r->base, &r->size);
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
+
+	DBG("%s:%d: Found high region in repository: %llxh %llxh\n",
+	    __func__, __LINE__, r->base, r->size);
+
+	return 0;
+
+zero_region:
+	DBG("%s:%d: No high region in repository.\n", __func__, __LINE__);
+
+	r->size = r->base = r->offset = 0;
+	return result;
+}
+
 /**
  * ps3_mm_add_memory - hot add memory
  */
@@ -304,6 +344,12 @@ static int __init ps3_mm_add_memory(void)
 
 	BUG_ON(!mem_init_done);
 
+	if (!map.r1.size) {
+		DBG("%s:%d: No region 1, not adding memory\n",
+		    __func__, __LINE__);
+		return 0;
+	}
+
 	start_addr = map.rm.size;
 	start_pfn = start_addr >> PAGE_SHIFT;
 	nr_pages = (map.r1.size + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -1217,9 +1263,10 @@ void __init ps3_mm_init(void)
 	BUG_ON(map.rm.base);
 	BUG_ON(!map.rm.size);
 
+	/* Check if we got the highmem region from an earlier boot step */
 
-	/* arrange to do this in ps3_mm_add_memory */
-	ps3_mm_region_create(&map.r1, map.total - map.rm.size);
+	if (ps3_mm_get_repository_highmem(&map.r1))
+		ps3_mm_region_create(&map.r1, map.total - map.rm.size);
 
 	/* correct map.total for the real total amount of memory we use */
 	map.total = map.rm.size + map.r1.size;
-- 
1.7.9.5
