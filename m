Return-Path: <tnt@246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/7] powerpc: exports rheap symbol to modules
Date: Sun, 16 Sep 2007 12:53:24 +0200
Message-Id: <1189940010114-git-send-email-tnt@246tNt.com>
In-Reply-To: <11899400103383-git-send-email-tnt@246tNt.com>
References: <11899400103383-git-send-email-tnt@246tNt.com>
Cc: Grant Likely <glikely@gmail.com>, Sylvain Munaut <tnt@246tNt.com>,
	PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Theses can be useful in modules too. So we export them.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/lib/rheap.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index ada5b42..22c3b4f 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -275,6 +276,7 @@ rh_info_t *rh_create(unsigned int alignment)
 
 	return info;
 }
+EXPORT_SYMBOL_GPL(rh_create);
 
 /*
  * Destroy a dynamically created remote heap.  Deallocate only if the areas
@@ -288,6 +290,7 @@ void rh_destroy(rh_info_t * info)
 	if ((info->flags & RHIF_STATIC_INFO) == 0)
 		kfree(info);
 }
+EXPORT_SYMBOL_GPL(rh_destroy);
 
 /*
  * Initialize in place a remote heap info block.  This is needed to support
@@ -320,6 +323,7 @@ void rh_init(rh_info_t * info, unsigned int alignment, int max_blocks,
 	for (i = 0, blk = block; i < max_blocks; i++, blk++)
 		list_add(&blk->list, &info->empty_list);
 }
+EXPORT_SYMBOL_GPL(rh_init);
 
 /* Attach a free memory region, coalesces regions if adjuscent */
 int rh_attach_region(rh_info_t * info, unsigned long start, int size)
@@ -360,6 +364,7 @@ int rh_attach_region(rh_info_t * info, unsigned long start, int size)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(rh_attach_region);
 
 /* Detatch given address range, splits free block if needed. */
 unsigned long rh_detach_region(rh_info_t * info, unsigned long start, int size)
@@ -428,6 +433,7 @@ unsigned long rh_detach_region(rh_info_t * info, unsigned long start, int size)
 
 	return s;
 }
+EXPORT_SYMBOL_GPL(rh_detach_region);
 
 /* Allocate a block of memory at the specified alignment.  The value returned
  * is an offset into the buffer initialized by rh_init(), or a negative number
@@ -502,6 +508,7 @@ unsigned long rh_alloc_align(rh_info_t * info, int size, int alignment, const ch
 
 	return start;
 }
+EXPORT_SYMBOL_GPL(rh_alloc_align);
 
 /* Allocate a block of memory at the default alignment.  The value returned is
  * an offset into the buffer initialized by rh_init(), or a negative number if
@@ -511,6 +518,7 @@ unsigned long rh_alloc(rh_info_t * info, int size, const char *owner)
 {
 	return rh_alloc_align(info, size, info->alignment, owner);
 }
+EXPORT_SYMBOL_GPL(rh_alloc);
 
 /* Allocate a block of memory at the given offset, rounded up to the default
  * alignment.  The value returned is an offset into the buffer initialized by
@@ -594,6 +602,7 @@ unsigned long rh_alloc_fixed(rh_info_t * info, unsigned long start, int size, co
 
 	return start;
 }
+EXPORT_SYMBOL_GPL(rh_alloc_fixed);
 
 /* Deallocate the memory previously allocated by one of the rh_alloc functions.
  * The return value is the size of the deallocated block, or a negative number
@@ -626,6 +635,7 @@ int rh_free(rh_info_t * info, unsigned long start)
 
 	return size;
 }
+EXPORT_SYMBOL_GPL(rh_free);
 
 int rh_get_stats(rh_info_t * info, int what, int max_stats, rh_stats_t * stats)
 {
@@ -663,6 +673,7 @@ int rh_get_stats(rh_info_t * info, int what, int max_stats, rh_stats_t * stats)
 
 	return nr;
 }
+EXPORT_SYMBOL_GPL(rh_get_stats);
 
 int rh_set_owner(rh_info_t * info, unsigned long start, const char *owner)
 {
@@ -687,6 +698,7 @@ int rh_set_owner(rh_info_t * info, unsigned long start, const char *owner)
 
 	return size;
 }
+EXPORT_SYMBOL_GPL(rh_set_owner);
 
 void rh_dump(rh_info_t * info)
 {
@@ -722,6 +734,7 @@ void rh_dump(rh_info_t * info)
 		       st[i].size, st[i].owner != NULL ? st[i].owner : "");
 	printk(KERN_INFO "\n");
 }
+EXPORT_SYMBOL_GPL(rh_dump);
 
 void rh_dump_blk(rh_info_t * info, rh_block_t * blk)
 {
@@ -729,3 +742,5 @@ void rh_dump_blk(rh_info_t * info, rh_block_t * blk)
 	       "blk @0x%p: 0x%lx-0x%lx (%u)\n",
 	       blk, blk->start, blk->start + blk->size, blk->size);
 }
+EXPORT_SYMBOL_GPL(rh_dump_blk);
+
-- 
1.5.3
