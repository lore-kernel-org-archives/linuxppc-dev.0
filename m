Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 02/15] [PS3] Get lv1 high memory region from devtree
Date: Mon,  1 Aug 2011 22:02:53 +0200
Message-Id: <1312228986-32307-3-git-send-email-a.heider@gmail.com>
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

This lets the bootloader preallocate the high lv1 region and pass its
location to the kernel through the devtree. Thus, it can be used to hold
the initrd. If the property doesn't exist, the kernel retains the old
behavior and attempts to allocate the region itself.

Signed-off-by: Hector Martin <hector@marcansoft.com>
[a.heider: Various cleanups to make checkpatch.pl happy]
Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/powerpc/platforms/ps3/mm.c |   61 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index c204588..30bb096 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -110,6 +110,7 @@ struct map {
 	u64 htab_size;
 	struct mem_region rm;
 	struct mem_region r1;
+	int destroy_r1;
 };
 
 #define debug_dump_map(x) _debug_dump_map(x, __func__, __LINE__)
@@ -287,6 +288,49 @@ static void ps3_mm_region_destroy(struct mem_region *r)
 	}
 }
 
+static int ps3_mm_scan_memory(unsigned long node, const char *uname,
+			      int depth, void *data)
+{
+	struct mem_region *r = data;
+	void *p;
+	u64 prop[2];
+	unsigned long l;
+	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
+
+	if (type == NULL)
+		return 0;
+	if (strcmp(type, "memory") != 0)
+		return 0;
+
+	p = of_get_flat_dt_prop(node, "sony,lv1-highmem", &l);
+	if (p == NULL)
+		return 0;
+
+	BUG_ON(l != sizeof(prop));
+	memcpy(prop, p, sizeof(prop));
+
+	r->base = prop[0];
+	r->size = prop[1];
+	r->offset = r->base - map.rm.size;
+
+	return -1;
+}
+
+static int ps3_mm_get_devtree_highmem(struct mem_region *r)
+{
+	r->size = r->base = r->offset = 0;
+	of_scan_flat_dt(ps3_mm_scan_memory, r);
+
+	if (r->base && r->size) {
+		DBG("%s:%d got high region from devtree: %llxh %llxh\n",
+		__func__, __LINE__, r->base, r->size);
+		return 0;
+	} else {
+		DBG("%s:%d no high region in devtree...\n", __func__, __LINE__);
+		return -1;
+	}
+}
+
 /**
  * ps3_mm_add_memory - hot add memory
  */
@@ -303,6 +347,12 @@ static int __init ps3_mm_add_memory(void)
 
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
@@ -1219,7 +1269,13 @@ void __init ps3_mm_init(void)
 
 
 	/* arrange to do this in ps3_mm_add_memory */
-	ps3_mm_region_create(&map.r1, map.total - map.rm.size);
+
+	if (ps3_mm_get_devtree_highmem(&map.r1) == 0) {
+		map.destroy_r1 = 0;
+	} else {
+		ps3_mm_region_create(&map.r1, map.total - map.rm.size);
+		map.destroy_r1 = 1;
+	}
 
 	/* correct map.total for the real total amount of memory we use */
 	map.total = map.rm.size + map.r1.size;
@@ -1233,5 +1289,6 @@ void __init ps3_mm_init(void)
 
 void ps3_mm_shutdown(void)
 {
-	ps3_mm_region_destroy(&map.r1);
+	if (map.destroy_r1)
+		ps3_mm_region_destroy(&map.r1);
 }
-- 
1.7.5.4
