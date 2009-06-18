Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3A204B7223
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 14:13:51 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <a737bdaf0661d859aa9c236c2eb6d28530babdb5.1245298429.git.michael@ellerman.id.au>
In-Reply-To: <1fdc1f0bb73b6ff2db7f9b394331d5ef5dfc4cb5.1245298429.git.michael@ellerman.id.au>
References: <1fdc1f0bb73b6ff2db7f9b394331d5ef5dfc4cb5.1245298429.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/7] powerpc: Use pr_devel() in arch/powerpc/mm/gup.c
Date: Thu, 18 Jun 2009 14:13:51 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pr_debug() can now result in code being generated even when DEBUG
is not defined. That's not really desirable in some places.

With CONFIG_DYNAMIC_DEBUG=y:

size before:
   text    data     bss     dec     hex filename
   3252     384       0    3636     e34 arch/powerpc/mm/gup.o

size after:
   text    data     bss     dec     hex filename
   2576      96       0    2672     a70 arch/powerpc/mm/gup.o

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/gup.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/gup.c b/arch/powerpc/mm/gup.c
index bc400c7..bc122a1 100644
--- a/arch/powerpc/mm/gup.c
+++ b/arch/powerpc/mm/gup.c
@@ -159,7 +159,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	int psize;
 #endif
 
-	pr_debug("%s(%lx,%x,%s)\n", __func__, start, nr_pages, write ? "write" : "read");
+	pr_devel("%s(%lx,%x,%s)\n", __func__, start, nr_pages, write ? "write" : "read");
 
 	start &= PAGE_MASK;
 	addr = start;
@@ -170,7 +170,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 					start, len)))
 		goto slow_irqon;
 
-	pr_debug("  aligned: %lx .. %lx\n", start, end);
+	pr_devel("  aligned: %lx .. %lx\n", start, end);
 
 #ifdef CONFIG_HUGETLB_PAGE
 	/* We bail out on slice boundary crossing when hugetlb is
@@ -234,7 +234,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 		do {
 			VM_BUG_ON(shift != mmu_psize_defs[get_slice_psize(mm, a)].shift);
 			ptep = huge_pte_offset(mm, a);
-			pr_debug(" %016lx: huge ptep %p\n", a, ptep);
+			pr_devel(" %016lx: huge ptep %p\n", a, ptep);
 			if (!ptep || !gup_huge_pte(ptep, hstate, &a, end, write, pages,
 						   &nr))
 				goto slow;
@@ -249,7 +249,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 #ifdef CONFIG_PPC64
 			VM_BUG_ON(shift != mmu_psize_defs[get_slice_psize(mm, addr)].shift);
 #endif
-			pr_debug("  %016lx: normal pgd %p\n", addr,
+			pr_devel("  %016lx: normal pgd %p\n", addr,
 				 (void *)pgd_val(pgd));
 			next = pgd_addr_end(addr, end);
 			if (pgd_none(pgd))
@@ -269,7 +269,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 slow:
 		local_irq_enable();
 slow_irqon:
-		pr_debug("  slow path ! nr = %d\n", nr);
+		pr_devel("  slow path ! nr = %d\n", nr);
 
 		/* Try to get the remaining pages with get_user_pages */
 		start += nr << PAGE_SHIFT;
-- 
1.6.2.1
