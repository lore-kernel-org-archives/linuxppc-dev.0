Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 483A7B7BEA
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Oct 2009 09:38:29 +1000 (EST)
Message-Id: <20091001233322.677176498@mini.kroah.org>
Date: Thu, 01 Oct 2009 16:31:42 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org,
 stable@kernel.org
Subject: [patch 26/30] powerpc/8xx: Fix regression introduced by cache
	coherency rewrite
References: <20091001233116.947658905@mini.kroah.org>
In-Reply-To: <20091001233504.GA17709@kroah.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable-review@kernel.org,
	alan@lxorguk.ukuu.org.uk, Rex Feany <rfeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2.6.30-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Rex Feany <RFeany@mrv.com>

commit e0908085fc2391c85b85fb814ae1df377c8e0dcb upstream.

After upgrading to the latest kernel on my mpc875 userspace started
running incredibly slow (hours to get to a shell, even!).
I tracked it down to commit 8d30c14cab30d405a05f2aaceda1e9ad57800f36,
that patch removed a work-around for the 8xx. Adding it
back makes my problem go away.

Signed-off-by: Rex Feany <rfeany@mrv.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/powerpc/mm/pgtable.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

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
@@ -128,6 +130,17 @@ static pte_t do_dcache_icache_coherency(
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
 		pr_debug("do_dcache_icache_coherency... flushing\n");
 		flush_dcache_icache_page(page);
@@ -198,7 +211,7 @@ void set_pte_at(struct mm_struct *mm, un
 	 */
 	pte = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
 	if (pte_need_exec_flush(pte, 1))
-		pte = do_dcache_icache_coherency(pte);
+		pte = do_dcache_icache_coherency(pte, addr);
 
 	/* Perform the setting of the PTE */
 	__set_pte_at(mm, addr, ptep, pte, 0);
@@ -216,7 +229,7 @@ int ptep_set_access_flags(struct vm_area
 {
 	int changed;
 	if (!dirty && pte_need_exec_flush(entry, 0))
-		entry = do_dcache_icache_coherency(entry);
+		entry = do_dcache_icache_coherency(entry, address);
 	changed = !pte_same(*(ptep), entry);
 	if (changed) {
 		if (!(vma->vm_flags & VM_HUGETLB))
