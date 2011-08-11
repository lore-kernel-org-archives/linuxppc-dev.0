Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH part1 v2 4/9] Add region 1 memory early
Date: Thu, 11 Aug 2011 21:31:08 +0200
Message-Id: <1313091073-4572-5-git-send-email-a.heider@gmail.com>
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

From: Hector Martin <hector@marcansoft.com>

Real mode memory can be limited and runs out quickly as memory is
allocated during kernel startup.
Having region1 available sooner fixes this.

Signed-off-by: Hector Martin <hector@marcansoft.com>
[a.heider: Various cleanups to make checkpatch.pl happy]
Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/powerpc/platforms/ps3/mm.c |   75 +++++++--------------------------------
 1 files changed, 13 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index 983b719..68b3879 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -20,7 +20,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/memory_hotplug.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
 
@@ -94,10 +93,8 @@ struct mem_region {
  * @vas_id - HV virtual address space id
  * @htab_size: htab size in bytes
  *
- * The HV virtual address space (vas) allows for hotplug memory regions.
- * Memory regions can be created and destroyed in the vas at runtime.
  * @rm: real mode (bootmem) region
- * @r1: hotplug memory region(s)
+ * @r1: high memory region
  *
  * ps3 addresses
  * virt_addr: a cpu 'translated' effective address
@@ -223,10 +220,6 @@ void ps3_mm_vas_destroy(void)
 	}
 }
 
-/*============================================================================*/
-/* memory hotplug routines                                                    */
-/*============================================================================*/
-
 /**
  * ps3_mm_region_create - create a memory region in the vas
  * @r: pointer to a struct mem_region to accept initialized values
@@ -319,57 +312,6 @@ zero_region:
 	return result;
 }
 
-/**
- * ps3_mm_add_memory - hot add memory
- */
-
-static int __init ps3_mm_add_memory(void)
-{
-	int result;
-	unsigned long start_addr;
-	unsigned long start_pfn;
-	unsigned long nr_pages;
-
-	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
-		return -ENODEV;
-
-	BUG_ON(!mem_init_done);
-
-	if (!map.r1.size) {
-		DBG("%s:%d: no region 1, not adding memory\n",
-		    __func__, __LINE__);
-		return 0;
-	}
-
-	start_addr = map.rm.size;
-	start_pfn = start_addr >> PAGE_SHIFT;
-	nr_pages = (map.r1.size + PAGE_SIZE - 1) >> PAGE_SHIFT;
-
-	DBG("%s:%d: start_addr %lxh, start_pfn %lxh, nr_pages %lxh\n",
-		__func__, __LINE__, start_addr, start_pfn, nr_pages);
-
-	result = add_memory(0, start_addr, map.r1.size);
-
-	if (result) {
-		pr_err("%s:%d: add_memory failed: (%d)\n",
-			__func__, __LINE__, result);
-		return result;
-	}
-
-	memblock_add(start_addr, map.r1.size);
-	memblock_analyze();
-
-	result = online_pages(start_pfn, nr_pages);
-
-	if (result)
-		pr_err("%s:%d: online_pages failed: (%d)\n",
-			__func__, __LINE__, result);
-
-	return result;
-}
-
-device_initcall(ps3_mm_add_memory);
-
 /*============================================================================*/
 /* dma routines                                                               */
 /*============================================================================*/
@@ -1256,14 +1198,23 @@ void __init ps3_mm_init(void)
 	BUG_ON(!map.rm.size);
 
 	/* check if we got the highmem region from an earlier boot step */
-	if (ps3_mm_get_repository_highmem(&map.r1)) {
-		/* arrange to do this in ps3_mm_add_memory */
+	if (ps3_mm_get_repository_highmem(&map.r1))
 		ps3_mm_region_create(&map.r1, map.total - map.rm.size);
-	}
 
 	/* correct map.total for the real total amount of memory we use */
 	map.total = map.rm.size + map.r1.size;
 
+	if (!map.r1.size) {
+		DBG("%s:%d: no region 1, not adding memory\n",
+			__func__, __LINE__);
+	} else {
+		DBG("%s:%d: adding memory: start %llxh, size %llxh\n",
+			__func__, __LINE__, map.rm.size, map.r1.size);
+
+		memblock_add(map.rm.size, map.r1.size);
+		memblock_analyze();
+	}
+
 	DBG(" <- %s:%d\n", __func__, __LINE__);
 }
 
-- 
1.7.5.4
