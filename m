Return-Path: <olson@cumulusnetworks.com>
Received: from mail-pd0-x233.google.com (mail-pd0-x233.google.com
 [IPv6:2607:f8b0:400e:c02::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DCD1A03D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 15:29:07 +1100 (AEDT)
Received: by pdea3 with SMTP id a3so58724247pde.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2015 21:29:05 -0700 (PDT)
From: olson@cumulusnetworks.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCHv5 1/1] Fix missing L2 cache size in /sys/devices/system/cpu
Date: Thu,  2 Apr 2015 21:28:45 -0700
Message-Id: <1428035325-16477-1-git-send-email-olson@cumulusnetworks.com>
In-Reply-To: <20150326194914.GC23655@cumulusnetworks.com>
References: <20150326194914.GC23655@cumulusnetworks.com>
Cc: Dave Olson <olson@cumulusnetworks.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dave Olson <olson@cumulusnetworks.com>

This is version 5 of the patch, incorporating Michael Ellerman's 
suggested changes from March 26, 2015.  v5 removes the __cpuinit
that had crept in from my patch based on an older kernel, but is
otherwise the same as v4.
================

This problem appears to have been introduced in 2.6.29 by
the commit in the Fixes line below.

This caused lscpu to error out on e500v2 devices, and probably others
 error: cannot open /sys/devices/system/cpu/cpu0/cache/index2/size: No such file or directory

Some embedded powerpc systems use cache-size in DTS for the unified L2 cache
size, not d-cache-size, so we need to allow for both DTS names.  Added a
new CACHE_TYPE_UNIFIED_D cache_type_info structure to handle this.

Fixes: 93197a36a9c16a85fb24cf5a8639f7bf9af838a3
Signed-off-by: Dave Olson <olson@cumulusnetworks.com>
---
 arch/powerpc/kernel/cacheinfo.c |   44 ++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index ae77b7e..c641983 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -61,12 +61,22 @@ struct cache_type_info {
 };
 
 /* These are used to index the cache_type_info array. */
-#define CACHE_TYPE_UNIFIED     0
-#define CACHE_TYPE_INSTRUCTION 1
-#define CACHE_TYPE_DATA        2
+#define CACHE_TYPE_UNIFIED     0 /* cache-size, cache-block-size, etc. */
+#define CACHE_TYPE_UNIFIED_D   1 /* d-cache-size, d-cache-block-size, etc */
+#define CACHE_TYPE_INSTRUCTION 2
+#define CACHE_TYPE_DATA        3
 
 static const struct cache_type_info cache_type_info[] = {
 	{
+		/* Embedded systems that use cache-size, cache-block-size,
+		 * etc. for the Unified (typically L2) cache. */
+		.name            = "Unified",
+		.size_prop       = "cache-size",
+		.line_size_props = { "cache-line-size",
+				     "cache-block-size", },
+		.nr_sets_prop    = "cache-sets",
+	},
+	{
 		/* PowerPC Processor binding says the [di]-cache-*
 		 * must be equal on unified caches, so just use
 		 * d-cache properties. */
@@ -293,7 +303,8 @@ static struct cache *cache_find_first_sibling(struct cache *cache)
 {
 	struct cache *iter;
 
-	if (cache->type == CACHE_TYPE_UNIFIED)
+	if (cache->type == CACHE_TYPE_UNIFIED ||
+	    cache->type == CACHE_TYPE_UNIFIED_D)
 		return cache;
 
 	list_for_each_entry(iter, &cache_list, list)
@@ -324,16 +335,29 @@ static bool cache_node_is_unified(const struct device_node *np)
 	return of_get_property(np, "cache-unified", NULL);
 }
 
-static struct cache *cache_do_one_devnode_unified(struct device_node *node,
-						  int level)
+/*
+ * Unified caches can have two different sets of tags.  Most embedded
+ * use cache-size, etc. for the unified cache size, but open firmware systems
+ * use d-cache-size, etc.   Check on initialization for which type we have, and
+ * return the appropriate structure type.  Assume it's embedded if it isn't
+ * open firmware.  If it's yet a 3rd type, then there will be missing entries
+ * in /sys/devices/system/cpu/cpu0/cache/index2/, and this code will need
+ * to be extended further.
+ */
+static int cache_is_unified_d(const struct device_node *np)
 {
-	struct cache *cache;
+	return of_get_property(np,
+		cache_type_info[CACHE_TYPE_UNIFIED_D].size_prop, NULL) ?
+		CACHE_TYPE_UNIFIED_D : CACHE_TYPE_UNIFIED;
+}
 
+/*
+ */
+static struct cache *cache_do_one_devnode_unified(struct device_node *node, int level)
+{
 	pr_debug("creating L%d ucache for %s\n", level, node->full_name);
 
-	cache = new_cache(CACHE_TYPE_UNIFIED, level, node);
-
-	return cache;
+	return new_cache(cache_is_unified_d(node), level, node);
 }
 
 static struct cache *cache_do_one_devnode_split(struct device_node *node,
-- 
1.7.10.4
