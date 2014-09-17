Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 332AA1A0396
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 15:58:27 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 2/5] powerpc: Remove some old bootmem related comments
Date: Wed, 17 Sep 2014 15:58:21 +1000
Message-Id: <1410933504-28564-2-git-send-email-anton@samba.org>
In-Reply-To: <1410933504-28564-1-git-send-email-anton@samba.org>
References: <1410933504-28564-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now bootmem is gone from powerpc we can remove comments mentioning it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/prom.c           | 5 +----
 arch/powerpc/kernel/rtas.c           | 4 ++--
 arch/powerpc/kvm/book3s_hv_builtin.c | 2 +-
 arch/powerpc/mm/hugetlbpage.c        | 4 ++--
 arch/powerpc/mm/pgtable_64.c         | 4 ----
 5 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 5957625..02e3e4c 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -698,10 +698,7 @@ void __init early_init_devtree(void *params)
 		reserve_crashkernel();
 	early_reserve_mem();
 
-	/*
-	 * Ensure that total memory size is page-aligned, because otherwise
-	 * mark_bootmem() gets upset.
-	 */
+	/* Ensure that total memory size is page-aligned. */
 	limit = ALIGN(memory_limit ?: memblock_phys_mem_size(), PAGE_SIZE);
 	memblock_enforce_memory_limit(limit);
 
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8b4c857..4af905e 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1091,8 +1091,8 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
 }
 
 /*
- * Call early during boot, before mem init or bootmem, to retrieve the RTAS
- * informations from the device-tree and allocate the RMO buffer for userland
+ * Call early during boot, before mem init, to retrieve the RTAS
+ * information from the device-tree and allocate the RMO buffer for userland
  * accesses.
  */
 void __init rtas_initialize(void)
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index b9615ba..297dbaf 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -154,7 +154,7 @@ EXPORT_SYMBOL_GPL(kvm_release_hpt);
  * kvm_cma_reserve() - reserve area for kvm hash pagetable
  *
  * This function reserves memory from early allocator. It should be
- * called by arch specific code once the early allocator (memblock or bootmem)
+ * called by arch specific code once the memblock allocator
  * has been activated and all other subsystems have already allocated/reserved
  * memory.
  */
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 7e70ae9..5215d25 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -276,7 +276,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 
 #ifdef CONFIG_PPC_FSL_BOOK3E
 /* Build list of addresses of gigantic pages.  This function is used in early
- * boot before the buddy or bootmem allocator is setup.
+ * boot before the buddy allocator is setup.
  */
 void add_gpage(u64 addr, u64 page_size, unsigned long number_of_pages)
 {
@@ -399,7 +399,7 @@ void __init reserve_hugetlb_gpages(void)
 #else /* !PPC_FSL_BOOK3E */
 
 /* Build list of addresses of gigantic pages.  This function is used in early
- * boot before the buddy or bootmem allocator is setup.
+ * boot before the buddy allocator is setup.
  */
 void add_gpage(u64 addr, u64 page_size, unsigned long number_of_pages)
 {
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index cdb19ab..aa91737 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -109,10 +109,6 @@ int map_kernel_page(unsigned long ea, unsigned long pa, int flags)
 							  __pgprot(flags)));
 	} else {
 #ifdef CONFIG_PPC_MMU_NOHASH
-		/* Warning ! This will blow up if bootmem is not initialized
-		 * which our ppc64 code is keen to do that, we'll need to
-		 * fix it and/or be more careful
-		 */
 		pgdp = pgd_offset_k(ea);
 #ifdef PUD_TABLE_SIZE
 		if (pgd_none(*pgdp)) {
-- 
1.9.1
