Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B2B60DDE25
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 15:41:44 +1100 (EST)
Date: Tue, 13 Nov 2007 15:41:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Silence an annoying boot message
Message-Id: <20071113154149.ef77d37f.sfr@canb.auug.org.au>
In-Reply-To: <1194857556.18185.33.camel@pasglop>
References: <20071112135339.9a01b115.sfr@canb.auug.org.au>
	<20071112051532.GA28394@lixom.net>
	<1194857556.18185.33.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

vmemmap_populate will printk (with KERN_WARNING) for a lot of pages
if CONFIG_SPARSEMEM_VMEMMAP is enabled (at least it does on iSeries).
Use pr_debug for it instead.

Replace the only other use of DBG in this file with pr_debug as well.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/init_64.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index d9c82d3..c0f5cff 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -19,8 +19,6 @@
  *
  */
 
-#undef DEBUG
-
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -66,12 +64,6 @@
 
 #include "mmu_decl.h"
 
-#ifdef DEBUG
-#define DBG(fmt...) printk(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 #if PGTABLE_RANGE > USER_VSID_RANGE
 #warning Limited user VSID range means pagetable space is wasted
 #endif
@@ -175,8 +167,8 @@ void pgtable_cache_init(void)
 		int size = pgtable_cache_size[i];
 		const char *name = pgtable_cache_name[i];
 
-		DBG("Allocating page table cache %s (#%d) "
-		    "for size: %08x...\n", name, i, size);
+		pr_debug("Allocating page table cache %s (#%d) "
+			"for size: %08x...\n", name, i, size);
 		pgtable_cache[i] = kmem_cache_create(name,
 						     size, size,
 						     SLAB_PANIC,
@@ -239,8 +231,8 @@ int __meminit vmemmap_populate(struct page *start_page,
 		if (!p)
 			return -ENOMEM;
 
-		printk(KERN_WARNING "vmemmap %08lx allocated at %p, "
-		                    "physical %08lx.\n", start, p, __pa(p));
+		pr_debug("vmemmap %08lx allocated at %p, physical %08lx.\n",
+			start, p, __pa(p));
 
 		mapped = htab_bolt_mapping(start, start + page_size,
 					__pa(p), mode_rw, mmu_linear_psize,
-- 
1.5.3.5
