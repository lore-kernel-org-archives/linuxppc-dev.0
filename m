Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrNM2DCHzDqts
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:26:43 +1000 (AEST)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 10:26:38 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 03/10] powerpc/mm/radix: Flush page walk cache when freeing
 page table
Date: Wed,  8 Jun 2016 19:55:51 +0530
Message-Id: <1465395958-21349-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1465395958-21349-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465395958-21349-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Even though a tlb_flush() does a flush with invalidate all cache,
we can end up doing an RCU page table free before calling tlb_flush().
That means we can have page walk cache entries even after we free the
page table pages. This can result in us doing wrong page table walk.

Avoid this by doing pwc flush on every page table free. We can't batch
the pwc flush, because the rcu call back function where we free the
page table pages doesn't have information of the mmu gather. Thus we
have to do a pwc on every page table page freed.

Note: I also removed the dummy tlb_flush_pgtable call functions for
hash 32.
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h       |  1 -
 arch/powerpc/include/asm/book3s/64/pgalloc.h       | 16 ++++++++-
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  3 ++
 arch/powerpc/include/asm/book3s/64/tlbflush.h      | 15 ++++++++-
 arch/powerpc/include/asm/book3s/pgalloc.h          |  5 ---
 arch/powerpc/mm/tlb-radix.c                        | 38 ++++++++++++++++++++++
 6 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index a2350194fc76..8e21bb492dca 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -102,7 +102,6 @@ static inline void pgtable_free_tlb(struct mmu_gather *tlb,
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
-	tlb_flush_pgtable(tlb, address);
 	pgtable_page_dtor(table);
 	pgtable_free_tlb(tlb, page_address(table), 0);
 }
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 488279edb1f0..26eb2cb80c4e 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -110,6 +110,11 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
                                   unsigned long address)
 {
+	/*
+	 * By now all the pud entries should be none entries. So go
+	 * ahead and flush the page walk cache
+	 */
+	flush_tlb_pgtable(tlb, address);
         pgtable_free_tlb(tlb, pud, PUD_INDEX_SIZE);
 }
 
@@ -127,6 +132,11 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
                                   unsigned long address)
 {
+	/*
+	 * By now all the pud entries should be none entries. So go
+	 * ahead and flush the page walk cache
+	 */
+	flush_tlb_pgtable(tlb, address);
         return pgtable_free_tlb(tlb, pmd, PMD_CACHE_INDEX);
 }
 
@@ -198,7 +208,11 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
-	tlb_flush_pgtable(tlb, address);
+	/*
+	 * By now all the pud entries should be none entries. So go
+	 * ahead and flush the page walk cache
+	 */
+	flush_tlb_pgtable(tlb, address);
 	pgtable_free_tlb(tlb, table, 0);
 }
 
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index 13ef38828dfe..3fa94fcac628 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -18,16 +18,19 @@ extern void radix__local_flush_tlb_mm(struct mm_struct *mm);
 extern void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 extern void radix___local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 				    unsigned long ap, int nid);
+extern void radix__local_flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr);
 extern void radix__tlb_flush(struct mmu_gather *tlb);
 #ifdef CONFIG_SMP
 extern void radix__flush_tlb_mm(struct mm_struct *mm);
 extern void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 extern void radix___flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 			      unsigned long ap, int nid);
+extern void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr);
 #else
 #define radix__flush_tlb_mm(mm)		radix__local_flush_tlb_mm(mm)
 #define radix__flush_tlb_page(vma,addr)	radix__local_flush_tlb_page(vma,addr)
 #define radix___flush_tlb_page(mm,addr,p,i)	radix___local_flush_tlb_page(mm,addr,p,i)
+#define radix__flush_tlb_pwc(tlb, addr)	radix__local_flush_tlb_pwc(tlb, addr)
 #endif
 
 #endif
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index d98424ae356c..541cf809e38e 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -72,5 +72,18 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 #define flush_tlb_mm(mm)		local_flush_tlb_mm(mm)
 #define flush_tlb_page(vma, addr)	local_flush_tlb_page(vma, addr)
 #endif /* CONFIG_SMP */
-
+/*
+ * flush the page walk cache for the address
+ */
+static inline void flush_tlb_pgtable(struct mmu_gather *tlb, unsigned long address)
+{
+	/*
+	 * flush the page table walk cache on freeing page table. We already
+	 * have marked the upper/higher level page table entry none by now.
+	 * So it is safe to flush PWC here.
+	 */
+	if (!radix_enabled())
+		return;
+	radix__flush_tlb_pwc(tlb, address);
+}
 #endif /*  _ASM_POWERPC_BOOK3S_64_TLBFLUSH_H */
diff --git a/arch/powerpc/include/asm/book3s/pgalloc.h b/arch/powerpc/include/asm/book3s/pgalloc.h
index 54f591e9572e..c0a69ae92256 100644
--- a/arch/powerpc/include/asm/book3s/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/pgalloc.h
@@ -4,11 +4,6 @@
 #include <linux/mm.h>
 
 extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
-static inline void tlb_flush_pgtable(struct mmu_gather *tlb,
-				     unsigned long address)
-{
-
-}
 
 #ifdef CONFIG_PPC64
 #include <asm/book3s/64/pgalloc.h>
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index b33b7c77cfa3..0c0593f201e3 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -125,6 +125,19 @@ void radix__local_flush_tlb_mm(struct mm_struct *mm)
 }
 EXPORT_SYMBOL(radix__local_flush_tlb_mm);
 
+void radix__local_flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
+{
+	unsigned long pid;
+	struct mm_struct *mm = tlb->mm;
+
+	preempt_disable();
+	pid = mm->context.id;
+	if (pid != MMU_NO_CONTEXT)
+		_tlbiel_pid(pid, RIC_FLUSH_PWC);
+	preempt_enable();
+}
+EXPORT_SYMBOL(radix__local_flush_tlb_pwc);
+
 void radix___local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 			    unsigned long ap, int nid)
 {
@@ -180,6 +193,31 @@ no_context:
 }
 EXPORT_SYMBOL(radix__flush_tlb_mm);
 
+void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
+{
+	unsigned long pid;
+	struct mm_struct *mm = tlb->mm;
+
+	preempt_disable();
+	pid = mm->context.id;
+	if (unlikely(pid == MMU_NO_CONTEXT))
+		goto no_context;
+
+	if (!mm_is_core_local(mm)) {
+		int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
+
+		if (lock_tlbie)
+			raw_spin_lock(&native_tlbie_lock);
+		_tlbie_pid(pid, RIC_FLUSH_PWC);
+		if (lock_tlbie)
+			raw_spin_unlock(&native_tlbie_lock);
+	} else
+		_tlbiel_pid(pid, RIC_FLUSH_PWC);
+no_context:
+	preempt_enable();
+}
+EXPORT_SYMBOL(radix__flush_tlb_pwc);
+
 void radix___flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 		       unsigned long ap, int nid)
 {
-- 
2.7.4
