Return-Path: <olson@cumulusnetworks.com>
Received: from mail-pd0-x236.google.com (mail-pd0-x236.google.com
 [IPv6:2607:f8b0:400e:c02::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FD161A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 11:05:10 +1100 (AEDT)
Received: by pdbfp1 with SMTP id fp1so8558766pdb.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 16:05:07 -0800 (PST)
From: olson@cumulusnetworks.com
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] Fix missing L2 cache size in /sys/devices/system/cpu
Date: Wed, 25 Feb 2015 16:04:47 -0800
Message-Id: <1424909087-2819-1-git-send-email-olson@cumulusnetworks.com>
Cc: Dave Olson <olson@cumulusnetworks.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dave Olson <olson@cumulusnetworks.com>

This problem appears to have been introduced in 2.6.29 by
93197a36a9c16a85fb24cf5a8639f7bf9af838a3.

This caused lscpu to error out on e500v2 devices, and probably others
 error: cannot open /sys/devices/system/cpu/cpu0/cache/index2/size: No such file or directory

Some embedded powerpc systems use cache-size in DTS for the unified L2 cache
size, not d-cache-size, so we need to allow for both DTS names.  Added a
new CACHE_TYPE_UNIFIED_D cache_type_info structure to handle this.

This patch is against git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
next branch.  It is the same as the v2 patch, but against next, rather than master.
I can rebase, if desired.

Signed-off-by: Dave Olson <olson@cumulusnetworks.com>
---
 arch/powerpc/kernel/cacheinfo.c |   38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index ae77b7e..860ed54 100644
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
@@ -324,14 +335,33 @@ static bool cache_node_is_unified(const struct device_node *np)
 	return of_get_property(np, "cache-unified", NULL);
 }
 
+/*
+ * Handle unified caches that have two different types of tags.  Most embedded
+ * use cache-size, etc. for the unified cache size, but open firmware systems
+ * use d-cache-size, etc.   Since they all appear to be consistent, check on
+ * initialization for which type we are, and use the appropriate structure.
+ */
 static struct cache *cache_do_one_devnode_unified(struct device_node *node,
 						  int level)
 {
 	struct cache *cache;
+	int ucache;
 
 	pr_debug("creating L%d ucache for %s\n", level, node->full_name);
 
 	cache = new_cache(CACHE_TYPE_UNIFIED, level, node);
+	if (of_get_property(node,
+		cache_type_info[CACHE_TYPE_UNIFIED_D].size_prop, NULL)) {
+		ucache = CACHE_TYPE_UNIFIED_D;
+	} else {
+		ucache = CACHE_TYPE_UNIFIED; /* assume embedded */
+		if (of_get_property(node,
+			cache_type_info[CACHE_TYPE_UNIFIED].size_prop, NULL) ==
+			NULL)
+			printk(KERN_WARNING "Unified cache property missing\n");
+	}
+
+	cache = new_cache(ucache, level, node);
 
 	return cache;
 }
-- 
1.7.10.4
