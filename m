Return-Path: <laurent.du4@free.fr>
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpkwW1CxyzDrbY
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 03:34:51 +1000 (AEST)
From: Laurent Dufour <laurent.du4@free.fr>
To: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: [PATCH v3 01/20] mm: Dont assume page-table invariance during faults
Date: Fri,  8 Sep 2017 19:32:22 +0200
Message-Id: <1504891961-22990-2-git-send-email-laurent.du4@free.fr>
In-Reply-To: <1504891961-22990-1-git-send-email-laurent.du4@free.fr>
References: <1504891961-22990-1-git-send-email-laurent.du4@free.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Peter Zijlstra <peterz@infradead.org>

One of the side effects of speculating on faults (without holding
mmap_sem) is that we can race with free_pgtables() and therefore we
cannot assume the page-tables will stick around.

Remove the reliance on the pte pointer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/memory.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ec4e15494901..30bccfa00630 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2270,30 +2270,6 @@ int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(apply_to_page_range);
 
-/*
- * handle_pte_fault chooses page fault handler according to an entry which was
- * read non-atomically.  Before making any commitment, on those architectures
- * or configurations (e.g. i386 with PAE) which might give a mix of unmatched
- * parts, do_swap_page must check under lock before unmapping the pte and
- * proceeding (but do_wp_page is only called after already making such a check;
- * and do_anonymous_page can safely check later on).
- */
-static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
-				pte_t *page_table, pte_t orig_pte)
-{
-	int same = 1;
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
-	if (sizeof(pte_t) > sizeof(unsigned long)) {
-		spinlock_t *ptl = pte_lockptr(mm, pmd);
-		spin_lock(ptl);
-		same = pte_same(*page_table, orig_pte);
-		spin_unlock(ptl);
-	}
-#endif
-	pte_unmap(page_table);
-	return same;
-}
-
 static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
 {
 	debug_dma_assert_idle(src);
@@ -2854,11 +2830,6 @@ int do_swap_page(struct vm_fault *vmf)
 
 	if (vma_readahead)
 		page = swap_readahead_detect(vmf, &swap_ra);
-	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte)) {
-		if (page)
-			put_page(page);
-		goto out;
-	}
 
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
-- 
2.7.4
