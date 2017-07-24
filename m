Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xG7fj4TKYzDrHf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 14:28:45 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/6] powerpc/mm: Use mm_is_thread_local() instread of
 open-coding
Date: Mon, 24 Jul 2017 14:28:01 +1000
Message-Id: <20170724042803.25848-4-benh@kernel.crashing.org>
In-Reply-To: <20170724042803.25848-1-benh@kernel.crashing.org>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We open-code testing for the mm being local to the current CPU
in a few places. Use our existing helper instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/hash_utils_64.c  | 6 ++----
 arch/powerpc/mm/hugetlbpage.c    | 3 +--
 arch/powerpc/mm/pgtable-hash64.c | 4 +---
 arch/powerpc/mm/tlb_hash64.c     | 7 ++-----
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 7a20669c19e7..943d9fe2b9a3 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1228,7 +1228,6 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 	unsigned long vsid;
 	pte_t *ptep;
 	unsigned hugeshift;
-	const struct cpumask *tmp;
 	int rc, user_region = 0;
 	int psize, ssize;
 
@@ -1280,8 +1279,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 	}
 
 	/* Check CPU locality */
-	tmp = cpumask_of(smp_processor_id());
-	if (user_region && cpumask_equal(mm_cpumask(mm), tmp))
+	if (user_region && mm_is_thread_local(mm))
 		flags |= HPTE_LOCAL_UPDATE;
 
 #ifndef CONFIG_PPC_64K_PAGES
@@ -1543,7 +1541,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 #endif /* CONFIG_PPC_64K_PAGES */
 
 	/* Is that local to this CPU ? */
-	if (cpumask_equal(mm_cpumask(mm), cpumask_of(smp_processor_id())))
+	if (mm_is_thread_local(mm))
 		update_flags |= HPTE_LOCAL_UPDATE;
 
 	/* Hash it in */
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index e1bf5ca397fe..122844c0734a 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -407,8 +407,7 @@ static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
 	batchp = &get_cpu_var(hugepd_freelist_cur);
 
 	if (atomic_read(&tlb->mm->mm_users) < 2 ||
-	    cpumask_equal(mm_cpumask(tlb->mm),
-			  cpumask_of(smp_processor_id()))) {
+	    mm_is_thread_local(tlb->mm)) {
 		kmem_cache_free(hugepte_cache, hugepte);
 		put_cpu_var(hugepd_freelist_cur);
 		return;
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 443a2c66a304..d89c637cb600 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -329,7 +329,6 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 	unsigned int psize;
 	unsigned long vsid;
 	unsigned long flags = 0;
-	const struct cpumask *tmp;
 
 	/* get the base page size,vsid and segment size */
 #ifdef CONFIG_DEBUG_VM
@@ -350,8 +349,7 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 		ssize = mmu_kernel_ssize;
 	}
 
-	tmp = cpumask_of(smp_processor_id());
-	if (cpumask_equal(mm_cpumask(mm), tmp))
+	if (mm_is_thread_local(mm))
 		flags |= HPTE_LOCAL_UPDATE;
 
 	return flush_hash_hugepage(vsid, addr, pmdp, psize, ssize, flags);
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index b5b0fb97b9c0..4dde13d7452d 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -138,13 +138,10 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
  */
 void __flush_tlb_pending(struct ppc64_tlb_batch *batch)
 {
-	const struct cpumask *tmp;
-	int i, local = 0;
+	int i, local;
 
 	i = batch->index;
-	tmp = cpumask_of(smp_processor_id());
-	if (cpumask_equal(mm_cpumask(batch->mm), tmp))
-		local = 1;
+	local = mm_is_thread_local(batch->mm);
 	if (i == 1)
 		flush_hash_page(batch->vpn[0], batch->pte[0],
 				batch->psize, batch->ssize, local);
-- 
2.13.3
