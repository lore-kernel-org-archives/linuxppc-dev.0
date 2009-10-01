Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 19C9AB7BC9
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Oct 2009 09:00:30 +1000 (EST)
Subject: patch
	powerpc-8xx-fix-regression-introduced-by-cache-coherency-rewrite.patch
	added to 2.6.31-stable tree
To: RFeany@mrv.com, benh@kernel.crashing.org, gregkh@suse.de,
	linuxppc-dev@ozlabs.org, rfeany@mrv.com, stable@kernel.org
From: <gregkh@suse.de>
Date: Thu, 01 Oct 2009 15:46:48 -0700
In-Reply-To: <1253776614.7103.434.camel@pasglop>
Message-Id: <20091001224944.60B5A48A4A@coco.kroah.org>
Cc: stable@kernel.org, stable-commits@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a note to let you know that we have just queued up the patch titled

    Subject: powerpc/8xx: Fix regression introduced by cache coherency rewrite

to the 2.6.31-stable tree.  Its filename is

    powerpc-8xx-fix-regression-introduced-by-cache-coherency-rewrite.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From benh@kernel.crashing.org  Thu Oct  1 15:35:28 2009
From: Rex Feany <RFeany@mrv.com>
Date: Thu, 24 Sep 2009 17:16:54 +1000
Subject: powerpc/8xx: Fix regression introduced by cache coherency rewrite
To: stable <stable@kernel.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, RFeany@mrv.com
Message-ID: <1253776614.7103.434.camel@pasglop>

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
 		pr_devel("do_dcache_icache_coherency... flushing\n");
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


Patches currently in stable-queue which might be from RFeany@mrv.com are

queue-2.6.31/powerpc-8xx-fix-regression-introduced-by-cache-coherency-rewrite.patch
queue-2.6.31/powerpc-fix-incorrect-setting-of-__have_arch_pte_special.patch
