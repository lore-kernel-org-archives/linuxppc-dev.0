Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 90A35100870
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 19:16:11 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 24 Jul 2009 19:15:58 +1000
Subject: [PATCH 19/20] powerpc/mm: Add support for SPARSEMEM_VMEMMAP on 64-bit
	Book3E
In-Reply-To: <1248426902.401617.944220131651.qpush@grosgo>
Message-Id: <20090724091611.82341DDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The base TLB support didn't include support for SPARSEMEM_VMEMMAP, though
we did carve out some virtual space for it, the necessary support code
wasn't there. This implements it by using 16M pages for now, though the
page size could easily be changed at runtime if necessary.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/mmu-book3e.h    |    1 
 arch/powerpc/include/asm/pgtable-ppc64.h |    3 +
 arch/powerpc/mm/init_64.c                |   55 +++++++++++++++++++++++++++----
 arch/powerpc/mm/mmu_decl.h               |    7 +++
 arch/powerpc/mm/pgtable_64.c             |    2 -
 arch/powerpc/mm/tlb_nohash.c             |   11 +++++-
 6 files changed, 68 insertions(+), 11 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/mmu-book3e.h	2009-07-24 18:15:35.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu-book3e.h	2009-07-24 18:23:51.000000000 +1000
@@ -196,6 +196,7 @@ extern struct mmu_psize_def mmu_psize_de
 #endif
 
 extern int mmu_linear_psize;
+extern int mmu_vmemmap_psize;
 
 #endif /* !__ASSEMBLY__ */
 
Index: linux-work/arch/powerpc/include/asm/pgtable-ppc64.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc64.h	2009-07-24 18:15:35.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc64.h	2009-07-24 18:23:51.000000000 +1000
@@ -46,6 +46,7 @@
 /*
  * The vmalloc space starts at the beginning of that region, and
  * occupies half of it on hash CPUs and a quarter of it on Book3E
+ * (we keep a quarter for the virtual memmap)
  */
 #define VMALLOC_START	KERN_VIRT_START
 #ifdef CONFIG_PPC_BOOK3E
@@ -83,7 +84,7 @@
 
 #define VMALLOC_REGION_ID	(REGION_ID(VMALLOC_START))
 #define KERNEL_REGION_ID	(REGION_ID(PAGE_OFFSET))
-#define VMEMMAP_REGION_ID	(0xfUL)
+#define VMEMMAP_REGION_ID	(0xfUL)	/* Server only */
 #define USER_REGION_ID		(0UL)
 
 /*
Index: linux-work/arch/powerpc/mm/init_64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/init_64.c	2009-07-24 18:15:35.000000000 +1000
+++ linux-work/arch/powerpc/mm/init_64.c	2009-07-24 18:23:51.000000000 +1000
@@ -205,6 +205,47 @@ static int __meminit vmemmap_populated(u
 	return 0;
 }
 
+/* On hash-based CPUs, the vmemmap is bolted in the hash table.
+ *
+ * On Book3E CPUs, the vmemmap is currently mapped in the top half of
+ * the vmalloc space using normal page tables, though the size of
+ * pages encoded in the PTEs can be different
+ */
+
+#ifdef CONFIG_PPC_BOOK3E
+static void __meminit vmemmap_create_mapping(unsigned long start,
+					     unsigned long page_size,
+					     unsigned long phys)
+{
+	/* Create a PTE encoding without page size */
+	unsigned long i, flags = _PAGE_PRESENT | _PAGE_ACCESSED |
+		_PAGE_KERNEL_RW;
+
+	/* PTEs only contain page size encodings up to 32M */
+	BUG_ON(mmu_psize_defs[mmu_vmemmap_psize].enc > 0xf);
+
+	/* Encode the size in the PTE */
+	flags |= mmu_psize_defs[mmu_vmemmap_psize].enc << 8;
+
+	/* For each PTE for that area, map things. Note that we don't
+	 * increment phys because all PTEs are of the large size and
+	 * thus must have the low bits clear
+	 */
+	for (i = 0; i < page_size; i += PAGE_SIZE)
+		BUG_ON(map_kernel_page(start + i, phys, flags));
+}
+#else /* CONFIG_PPC_BOOK3E */
+static void __meminit vmemmap_create_mapping(unsigned long start,
+					     unsigned long page_size,
+					     unsigned long phys)
+{
+	int  mapped = htab_bolt_mapping(start, start + page_size, phys,
+					PAGE_KERNEL, mmu_vmemmap_psize,
+					mmu_kernel_ssize);
+	BUG_ON(mapped < 0);
+}
+#endif /* CONFIG_PPC_BOOK3E */
+
 int __meminit vmemmap_populate(struct page *start_page,
 			       unsigned long nr_pages, int node)
 {
@@ -215,8 +256,11 @@ int __meminit vmemmap_populate(struct pa
 	/* Align to the page size of the linear mapping. */
 	start = _ALIGN_DOWN(start, page_size);
 
+	pr_debug("vmemmap_populate page %p, %ld pages, node %d\n",
+		 start_page, nr_pages, node);
+	pr_debug(" -> map %lx..%lx\n", start, end);
+
 	for (; start < end; start += page_size) {
-		int mapped;
 		void *p;
 
 		if (vmemmap_populated(start, page_size))
@@ -226,13 +270,10 @@ int __meminit vmemmap_populate(struct pa
 		if (!p)
 			return -ENOMEM;
 
-		pr_debug("vmemmap %08lx allocated at %p, physical %08lx.\n",
-			start, p, __pa(p));
+		pr_debug("      * %016lx..%016lx allocated at %p\n",
+			 start, start + page_size, p);
 
-		mapped = htab_bolt_mapping(start, start + page_size, __pa(p),
-					   pgprot_val(PAGE_KERNEL),
-					   mmu_vmemmap_psize, mmu_kernel_ssize);
-		BUG_ON(mapped < 0);
+		vmemmap_create_mapping(start, page_size, __pa(p));
 	}
 
 	return 0;
Index: linux-work/arch/powerpc/mm/tlb_nohash.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/tlb_nohash.c	2009-07-24 18:21:24.000000000 +1000
+++ linux-work/arch/powerpc/mm/tlb_nohash.c	2009-07-24 18:23:51.000000000 +1000
@@ -93,6 +93,7 @@ static inline int mmu_get_tsize(int psiz
 
 int mmu_linear_psize;		/* Page size used for the linear mapping */
 int mmu_pte_psize;		/* Page size used for PTE pages */
+int mmu_vmemmap_psize;		/* Page size used for the virtual mem map */
 int book3e_htw_enabled;		/* Is HW tablewalk enabled ? */
 unsigned long linear_map_top;	/* Top of linear mapping */
 
@@ -356,10 +357,18 @@ static void __early_init_mmu(int boot_cp
 	unsigned int mas4;
 
 	/* XXX This will have to be decided at runtime, but right
-	 * now our boot and TLB miss code hard wires it
+	 * now our boot and TLB miss code hard wires it. Ideally
+	 * we should find out a suitable page size and patch the
+	 * TLB miss code (either that or use the PACA to store
+	 * the value we want)
 	 */
 	mmu_linear_psize = MMU_PAGE_1G;
 
+	/* XXX This should be decided at runtime based on supported
+	 * page sizes in the TLB, but for now let's assume 16M is
+	 * always there and a good fit (which it probably is)
+	 */
+	mmu_vmemmap_psize = MMU_PAGE_16M;
 
 	/* Check if HW tablewalk is present, and if yes, enable it by:
 	 *
Index: linux-work/arch/powerpc/mm/mmu_decl.h
===================================================================
--- linux-work.orig/arch/powerpc/mm/mmu_decl.h	2009-07-24 18:21:24.000000000 +1000
+++ linux-work/arch/powerpc/mm/mmu_decl.h	2009-07-24 18:23:51.000000000 +1000
@@ -121,7 +121,12 @@ extern unsigned int rtas_data, rtas_size
 struct hash_pte;
 extern struct hash_pte *Hash, *Hash_end;
 extern unsigned long Hash_size, Hash_mask;
-#endif
+
+#endif /* CONFIG_PPC32 */
+
+#ifdef CONFIG_PPC64
+extern int map_kernel_page(unsigned long ea, unsigned long pa, int flags);
+#endif /* CONFIG_PPC64 */
 
 extern unsigned long ioremap_bot;
 extern unsigned long __max_low_memory;
Index: linux-work/arch/powerpc/mm/pgtable_64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/pgtable_64.c	2009-07-24 18:15:35.000000000 +1000
+++ linux-work/arch/powerpc/mm/pgtable_64.c	2009-07-24 18:23:51.000000000 +1000
@@ -79,7 +79,7 @@ static void *early_alloc_pgtable(unsigne
  * map_kernel_page adds an entry to the ioremap page table
  * and adds an entry to the HPT, possibly bolting it
  */
-static int map_kernel_page(unsigned long ea, unsigned long pa, int flags)
+int map_kernel_page(unsigned long ea, unsigned long pa, int flags)
 {
 	pgd_t *pgdp;
 	pud_t *pudp;
