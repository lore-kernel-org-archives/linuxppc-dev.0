Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 03/15] [PS3] Add region 1 memory early
Date: Mon,  1 Aug 2011 22:02:54 +0200
Message-Id: <1312228986-32307-4-git-send-email-a.heider@gmail.com>
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

From: Hector Martin <hector@marcansoft.com>

Signed-off-by: Hector Martin <hector@marcansoft.com>
[a.heider: Various cleanups to make checkpatch.pl happy]
Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/powerpc/platforms/ps3/mm.c |   62 +++++++--------------------------------
 1 files changed, 11 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index 30bb096..15876d6 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -331,57 +331,6 @@ static int ps3_mm_get_devtree_highmem(struct mem_region *r)
 	}
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
@@ -1280,6 +1229,17 @@ void __init ps3_mm_init(void)
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
