Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33AD0B7B65
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 17:21:58 +1000 (EST)
Subject: [PATCH-stable] powerpc/8xx: Fix regression introduced by cache
	coherency rewrite
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: stable <stable@kernel.org>
Content-Type: text/plain
Date: Thu, 24 Sep 2009 17:16:54 +1000
Message-Id: <1253776614.7103.434.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, RFeany@mrv.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rex Feany <RFeany@mrv.com>

After upgrading to the latest kernel on my mpc875 userspace started
running incredibly slow (hours to get to a shell, even!).
I tracked it down to commit 8d30c14cab30d405a05f2aaceda1e9ad57800f36,
that patch removed a work-around for the 8xx. Adding it
back makes my problem go away.

Signed-off-by: Rex Feany <rfeany@mrv.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/pgtable.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

I'm going to push an upstream variant of this patch upstream tomorrow,
it will be a bit different due to significant changes in that file
and the affected functions.

This should apply to v2.6.30 (with fuzz) and v2.6.31

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 627767d..d8e6725 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -30,6 +30,8 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 
+#include "mmu_decl.h"
+
 static DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
 static unsigned long pte_freelist_forced_free;
 
@@ -119,7 +121,7 @@ void pte_free_finish(void)
 /*
  * Handle i/d cache flushing, called from set_pte_at() or ptep_set_access_flags()
  */
-static pte_t do_dcache_icache_coherency(pte_t pte)
+static pte_t do_dcache_icache_coherency(pte_t pte, unsigned long addr)
 {
 	unsigned long pfn = pte_pfn(pte);
 	struct page *page;
@@ -128,6 +130,17 @@ static pte_t do_dcache_icache_coherency(pte_t pte)
 		return pte;
 	page = pfn_to_page(pfn);
 
+#ifdef CONFIG_8xx
+       /* On 8xx, cache control instructions (particularly
+        * "dcbst" from flush_dcache_icache) fault as write
+        * operation if there is an unpopulated TLB entry
+        * for the address in question. To workaround that,
+        * we invalidate the TLB here, thus avoiding dcbst
+        * misbehaviour.
+        */
+       _tlbil_va(addr, 0 /* 8xx doesn't care about PID */);
+#endif
+
 	if (!PageReserved(page) && !test_bit(PG_arch_1, &page->flags)) {
 		pr_devel("do_dcache_icache_coherency... flushing\n");
 		flush_dcache_icache_page(page);
@@ -198,7 +211,7 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte
 	 */
 	pte = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
 	if (pte_need_exec_flush(pte, 1))
-		pte = do_dcache_icache_coherency(pte);
+		pte = do_dcache_icache_coherency(pte, addr);
 
 	/* Perform the setting of the PTE */
 	__set_pte_at(mm, addr, ptep, pte, 0);
@@ -216,7 +229,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 {
 	int changed;
 	if (!dirty && pte_need_exec_flush(entry, 0))
-		entry = do_dcache_icache_coherency(entry);
+		entry = do_dcache_icache_coherency(entry, address);
 	changed = !pte_same(*(ptep), entry);
 	if (changed) {
 		if (!(vma->vm_flags & VM_HUGETLB))
