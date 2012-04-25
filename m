Return-Path: <geoff@infradead.org>
Message-Id: <8ac5fd118cd137db5ca8c786778ba600f87111a0.1335379330.git.geoff@infradead.org>
In-Reply-To: <cover.1335379330.git.geoff@infradead.org>
References: <cover.1335379330.git.geoff@infradead.org>
From: Hector Martin <hector@marcansoft.com>
Subject: [PATCH 06/10] powerpc/ps3: Add highmem region memory early
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

Real mode memory can be limited and runs out quickly as memory is allocated
during kernel startup.  Having the highmem available sooner fixes this.

This change simplifies the memory management code by converting from hotplug
memory to logical memory blocks.

Signed-off-by: Hector Martin <hector@marcansoft.com>
Signed-off-by: Andre Heider <a.heider@gmail.com>
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/mm.c |   66 ++++++---------------------------------
 1 file changed, 10 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index 05a2bcb..0c9f643 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -20,7 +20,6 @@
 
 #include <linux/kernel.h>
 #include <linux/export.h>
-#include <linux/memory_hotplug.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
 
@@ -98,7 +97,7 @@ struct mem_region {
  * The HV virtual address space (vas) allows for hotplug memory regions.
  * Memory regions can be created and destroyed in the vas at runtime.
  * @rm: real mode (bootmem) region
- * @r1: hotplug memory region(s)
+ * @r1: highmem region(s)
  *
  * ps3 addresses
  * virt_addr: a cpu 'translated' effective address
@@ -224,10 +223,6 @@ void ps3_mm_vas_destroy(void)
 	}
 }
 
-/*============================================================================*/
-/* memory hotplug routines                                                    */
-/*============================================================================*/
-
 /**
  * ps3_mm_region_create - create a memory region in the vas
  * @r: pointer to a struct mem_region to accept initialized values
@@ -328,56 +323,6 @@ zero_region:
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
-		DBG("%s:%d: No region 1, not adding memory\n",
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
@@ -1271,6 +1216,15 @@ void __init ps3_mm_init(void)
 	/* correct map.total for the real total amount of memory we use */
 	map.total = map.rm.size + map.r1.size;
 
+	if (!map.r1.size) {
+		DBG("%s:%d: No highmem region found\n", __func__, __LINE__);
+	} else {
+		DBG("%s:%d: Adding highmem region: %llxh %llxh\n",
+			__func__, __LINE__, map.rm.size,
+			map.total - map.rm.size);
+		memblock_add(map.rm.size, map.total - map.rm.size);
+	}
+
 	DBG(" <- %s:%d\n", __func__, __LINE__);
 }
 
-- 
1.7.9.5
