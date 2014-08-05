Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB3F31A001A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 16:33:53 +1000 (EST)
Date: Tue, 5 Aug 2014 16:33:54 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 paulmck@linux.vnet.ibm.com, Emilian.Medve@Freescale.com
Subject: [PATCH 2/5] powerpc: Remove some old bootmem related comments
Message-ID: <20140805163354.2c93683e@kryten>
In-Reply-To: <20140805163218.47c86615@kryten>
References: <20140805163218.47c86615@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Index: b/arch/powerpc/kernel/prom.c
===================================================================
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -695,10 +695,7 @@ void __init early_init_devtree(void *par
 		reserve_crashkernel();
 	early_reserve_mem();
 
-	/*
-	 * Ensure that total memory size is page-aligned, because otherwise
-	 * mark_bootmem() gets upset.
-	 */
+	/* Ensure that total memory size is page-aligned. */
 	limit = ALIGN(memory_limit ?: memblock_phys_mem_size(), PAGE_SIZE);
 	memblock_enforce_memory_limit(limit);
 
Index: b/arch/powerpc/kernel/rtas.c
===================================================================
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1091,8 +1091,8 @@ asmlinkage int ppc_rtas(struct rtas_args
 }
 
 /*
- * Call early during boot, before mem init or bootmem, to retrieve the RTAS
- * informations from the device-tree and allocate the RMO buffer for userland
+ * Call early during boot, before mem init, to retrieve the RTAS
+ * information from the device-tree and allocate the RMO buffer for userland
  * accesses.
  */
 void __init rtas_initialize(void)
Index: b/arch/powerpc/mm/pgtable_64.c
===================================================================
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -106,10 +106,6 @@ int map_kernel_page(unsigned long ea, un
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
Index: b/arch/powerpc/kvm/book3s_hv_builtin.c
===================================================================
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -148,7 +148,7 @@ EXPORT_SYMBOL_GPL(kvm_release_hpt);
  * kvm_cma_reserve() - reserve area for kvm hash pagetable
  *
  * This function reserves memory from early allocator. It should be
- * called by arch specific code once the early allocator (memblock or bootmem)
+ * called by arch specific code once the memblock allocator
  * has been activated and all other subsystems have already allocated/reserved
  * memory.
  */
Index: b/arch/powerpc/kvm/book3s_hv_cma.c
===================================================================
--- a/arch/powerpc/kvm/book3s_hv_cma.c
+++ b/arch/powerpc/kvm/book3s_hv_cma.c
@@ -42,7 +42,7 @@ static struct kvm_cma kvm_cma_area;
  * @alignment:  Alignment for the contiguous memory area
  *
  * This function reserves memory for kvm cma area. It should be
- * called by arch code when early allocator (memblock or bootmem)
+ * called by arch code when the memblock allocator
  * is still activate.
  */
 long __init kvm_cma_declare_contiguous(phys_addr_t size, phys_addr_t alignment)
Index: b/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -276,7 +276,7 @@ pte_t *huge_pte_alloc(struct mm_struct *
 
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
