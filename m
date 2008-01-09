Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B86A9DDEA0
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 04:30:43 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m09HUcvT003782
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 11:30:39 -0600
Date: Wed, 9 Jan 2008 11:28:30 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Fix handling of memreserve if the range lands in
	highmem
Message-ID: <Pine.LNX.4.64.0801091127400.8069@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There were several issues if a memreserve range existed and happened
to be in highmem:

* The bootmem allocator is only aware of lowmem so calling
  reserve_bootmem with a highmem address would cause a BUG_ON
* All highmem pages were provided to the buddy allocator

Added a lmb_is_reserved() api that we now use to determine if a highem
page should continue to be PageReserved or provided to the buddy
allocator.

Also, we incorrectly reported the amount of pages reserved since all
highmem pages are initally marked reserved and we clear the
PageReserved flag as we "free" up the highmem pages.

---

As normal, posted here for review, will be pushed via my for-2.6.25 branch

 arch/powerpc/mm/lmb.c     |   13 +++++++++++++
 arch/powerpc/mm/mem.c     |   14 ++++++++++----
 include/asm-powerpc/lmb.h |    1 +
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/lmb.c b/arch/powerpc/mm/lmb.c
index 8f4d2dc..4ce23bc 100644
--- a/arch/powerpc/mm/lmb.c
+++ b/arch/powerpc/mm/lmb.c
@@ -342,3 +342,16 @@ void __init lmb_enforce_memory_limit(unsigned long memory_limit)
 		}
 	}
 }
+
+int __init lmb_is_reserved(unsigned long addr)
+{
+	int i;
+
+	for (i = 0; i < lmb.reserved.cnt; i++) {
+		unsigned long upper = lmb.reserved.region[i].base +
+				      lmb.reserved.region[i].size - 1;
+		if ((addr >= lmb.reserved.region[i].base) && (addr <= upper))
+			return 1;
+	}
+	return 0;
+}
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 5402fb6..a004032 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -218,9 +218,13 @@ void __init do_init_bootmem(void)
 #endif

 	/* reserve the sections we're already using */
-	for (i = 0; i < lmb.reserved.cnt; i++)
-		reserve_bootmem(lmb.reserved.region[i].base,
-				lmb_size_bytes(&lmb.reserved, i));
+	for (i = 0; i < lmb.reserved.cnt; i++) {
+		unsigned long addr = lmb.reserved.region[i].base +
+				     lmb_size_bytes(&lmb.reserved, i) - 1;
+		if (addr < total_lowmem)
+			reserve_bootmem(lmb.reserved.region[i].base,
+					lmb_size_bytes(&lmb.reserved, i));
+	}

 	/* XXX need to clip this if using highmem? */
 	sparse_memory_present_with_active_regions(0);
@@ -334,11 +338,13 @@ void __init mem_init(void)
 		highmem_mapnr = total_lowmem >> PAGE_SHIFT;
 		for (pfn = highmem_mapnr; pfn < max_mapnr; ++pfn) {
 			struct page *page = pfn_to_page(pfn);
-
+			if (lmb_is_reserved(pfn << PAGE_SHIFT))
+				continue;
 			ClearPageReserved(page);
 			init_page_count(page);
 			__free_page(page);
 			totalhigh_pages++;
+			reservedpages--;
 		}
 		totalram_pages += totalhigh_pages;
 		printk(KERN_DEBUG "High memory: %luk\n",
diff --git a/include/asm-powerpc/lmb.h b/include/asm-powerpc/lmb.h
index b5f9f4c..5d1dc48 100644
--- a/include/asm-powerpc/lmb.h
+++ b/include/asm-powerpc/lmb.h
@@ -51,6 +51,7 @@ extern unsigned long __init __lmb_alloc_base(unsigned long size,
 extern unsigned long __init lmb_phys_mem_size(void);
 extern unsigned long __init lmb_end_of_DRAM(void);
 extern void __init lmb_enforce_memory_limit(unsigned long memory_limit);
+extern int __init lmb_is_reserved(unsigned long addr);

 extern void lmb_dump_all(void);

-- 
1.5.3.7
