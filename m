Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m96q3rbVzF1QP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 20:05:39 +1000 (AEST)
Message-Id: <a1f9c5a76b4c64eccf79dc394ae8169973be2b36.1526464250.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1526464250.git.christophe.leroy@c-s.fr>
References: <cover.1526464250.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 06/14] powerpc/nohash32: allow setting GUARDED attribute in
 the PMD directly
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 16 May 2018 12:05:35 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On the 8xx, the GUARDED attribute of the pages is managed in the
L1 entry, therefore to avoid having to copy it into L1 entry
at each TLB miss, we have to set it in the PMD

In order to allow this, this patch splits the VM alloc space in two
parts, one for VM alloc and non Guarded IO, and one for Guarded IO.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 12 ++++++++++++
 arch/powerpc/include/asm/nohash/32/pgtable.h | 18 ++++++++++++++++--
 arch/powerpc/mm/dump_linuxpagetables.c       | 26 ++++++++++++++++++++++++--
 arch/powerpc/mm/ioremap.c                    | 13 ++++++++++---
 arch/powerpc/mm/mem.c                        |  9 +++++++++
 arch/powerpc/mm/pgtable_32.c                 | 28 +++++++++++++++++++++++++++-
 arch/powerpc/platforms/Kconfig.cputype       |  2 ++
 7 files changed, 100 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 29d37bd1f3b3..81c19d6460bd 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -58,6 +58,14 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
 	*pmdp = __pmd(__pa(pte) | _PMD_PRESENT);
 }
 
+#ifdef CONFIG_PPC_GUARDED_PAGE_IN_PMD
+static inline void pmd_populate_kernel_g(struct mm_struct *mm, pmd_t *pmdp,
+					 pte_t *pte)
+{
+	*pmdp = __pmd(__pa(pte) | _PMD_PRESENT | _PMD_GUARDED);
+}
+#endif
+
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 				pgtable_t pte_page)
 {
@@ -83,6 +91,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 #define pmd_pgtable(pmd) pmd_page(pmd)
 #endif
 
+#define pte_alloc_kernel_g(pmd, address)			\
+	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel_g(pmd, address))? \
+		NULL: pte_offset_kernel(pmd, address))
+
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
 extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
 
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 810945afe677..7873722198e1 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -80,9 +80,14 @@ extern int icache_44x_need_flush;
 #else
 #define PKMAP_BASE	((FIXADDR_START - PAGE_SIZE*(LAST_PKMAP + 1)) & PMD_MASK)
 #endif
-#define KVIRT_TOP	PKMAP_BASE
+#define _KVIRT_TOP	PKMAP_BASE
 #else
-#define KVIRT_TOP	(0xfe000000UL)	/* for now, could be FIXMAP_BASE ? */
+#define _KVIRT_TOP	(0xfe000000UL)	/* for now, could be FIXMAP_BASE ? */
+#endif
+#ifdef CONFIG_PPC_GUARDED_PAGE_IN_PMD
+#define KVIRT_TOP	_ALIGN_DOWN(_KVIRT_TOP, PGDIR_SIZE)
+#else
+#define KVIRT_TOP	_KVIRT_TOP
 #endif
 
 /*
@@ -95,7 +100,11 @@ extern int icache_44x_need_flush;
 #else
 #define IOREMAP_END	KVIRT_TOP
 #endif
+#ifdef CONFIG_PPC_GUARDED_PAGE_IN_PMD
+#define IOREMAP_BASE	_ALIGN_UP(VMALLOC_BASE + (IOREMAP_END - VMALLOC_BASE) / 2, PGDIR_SIZE)
+#else
 #define IOREMAP_BASE	VMALLOC_BASE
+#endif
 
 /*
  * Just any arbitrary offset to the start of the vmalloc VM area: the
@@ -114,8 +123,13 @@ extern int icache_44x_need_flush;
 #else
 #define VMALLOC_BASE _ALIGN_DOWN((long)high_memory + VMALLOC_OFFSET, VMALLOC_OFFSET)
 #endif
+#ifdef CONFIG_PPC_GUARDED_PAGE_IN_PMD
+#define VMALLOC_START	VMALLOC_BASE
+#define VMALLOC_END	IOREMAP_BASE
+#else
 #define VMALLOC_START	ioremap_bot
 #define VMALLOC_END	IOREMAP_END
+#endif
 
 /*
  * Bits in a linux-style PTE.  These match the bits in the
diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index 6022adb899b7..cd3797be5e05 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -74,9 +74,9 @@ struct addr_marker {
 
 static struct addr_marker address_markers[] = {
 	{ 0,	"Start of kernel VM" },
+#ifdef CONFIG_PPC64
 	{ 0,	"vmalloc() Area" },
 	{ 0,	"vmalloc() End" },
-#ifdef CONFIG_PPC64
 	{ 0,	"isa I/O start" },
 	{ 0,	"isa I/O end" },
 	{ 0,	"phb I/O start" },
@@ -85,8 +85,19 @@ static struct addr_marker address_markers[] = {
 	{ 0,	"I/O remap end" },
 	{ 0,	"vmemmap start" },
 #else
+#ifdef CONFIG_PPC_GUARDED_PAGE_IN_PMD
+	{ 0,	"vmalloc() Area" },
+	{ 0,	"vmalloc() End" },
 	{ 0,	"Early I/O remap start" },
 	{ 0,	"Early I/O remap end" },
+	{ 0,	"I/O remap start" },
+	{ 0,	"I/O remap end" },
+#else
+	{ 0,	"Early I/O remap start" },
+	{ 0,	"Early I/O remap end" },
+	{ 0,	"vmalloc() I/O remap start" },
+	{ 0,	"vmalloc() I/O remap end" },
+#endif
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	{ 0,	"Consistent mem start" },
 	{ 0,	"Consistent mem end" },
@@ -437,9 +448,9 @@ static void populate_markers(void)
 	int i = 0;
 
 	address_markers[i++].start_address = PAGE_OFFSET;
+#ifdef CONFIG_PPC64
 	address_markers[i++].start_address = VMALLOC_START;
 	address_markers[i++].start_address = VMALLOC_END;
-#ifdef CONFIG_PPC64
 	address_markers[i++].start_address = ISA_IO_BASE;
 	address_markers[i++].start_address = ISA_IO_END;
 	address_markers[i++].start_address = PHB_IO_BASE;
@@ -452,8 +463,19 @@ static void populate_markers(void)
 	address_markers[i++].start_address =  VMEMMAP_BASE;
 #endif
 #else /* !CONFIG_PPC64 */
+#ifdef CONFIG_PPC_GUARDED_PAGE_IN_PMD
+	address_markers[i++].start_address = VMALLOC_START;
+	address_markers[i++].start_address = VMALLOC_END;
 	address_markers[i++].start_address = IOREMAP_BASE;
 	address_markers[i++].start_address = ioremap_bot;
+	address_markers[i++].start_address = ioremap_bot;
+	address_markers[i++].start_address = IOREMAP_END;
+#else
+	address_markers[i++].start_address = IOREMAP_BASE;
+	address_markers[i++].start_address = ioremap_bot;
+	address_markers[i++].start_address = ioremap_bot;
+	address_markers[i++].start_address = IOREMAP_END;
+#endif
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	address_markers[i++].start_address = IOREMAP_END;
 	address_markers[i++].start_address = IOREMAP_END +
diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
index a140feec2f8a..3eecf82ff93e 100644
--- a/arch/powerpc/mm/ioremap.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -134,9 +134,16 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 	if (slab_is_available()) {
 		struct vm_struct *area;
 
-		area = __get_vm_area_caller(size, VM_IOREMAP,
-					    ioremap_bot, IOREMAP_END,
-					    caller);
+#ifdef CONFIG_PPC_GUARDED_PAGE_IN_PMD
+		if (!(flags & _PAGE_GUARDED))
+			area = __get_vm_area_caller(size, VM_IOREMAP,
+						    VMALLOC_START, VMALLOC_END,
+						    caller);
+		else
+#endif
+			area = __get_vm_area_caller(size, VM_IOREMAP,
+						    ioremap_bot, IOREMAP_END,
+						    caller);
 		if (area == NULL)
 			return NULL;
 
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index b680aa78a4ac..fd7af7af5b58 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -386,10 +386,19 @@ void __init mem_init(void)
 	pr_info("  * 0x%08lx..0x%08lx  : consistent mem\n",
 		IOREMAP_END, IOREMAP_END + CONFIG_CONSISTENT_SIZE);
 #endif /* CONFIG_NOT_COHERENT_CACHE */
+#ifdef CONFIG_PPC_GUARDED_PAGE_IN_PMD
+	pr_info("  * 0x%08lx..0x%08lx  : ioremap\n",
+		ioremap_bot, IOREMAP_END);
 	pr_info("  * 0x%08lx..0x%08lx  : early ioremap\n",
 		IOREMAP_BASE, ioremap_bot);
+	pr_info("  * 0x%08lx..0x%08lx  : vmalloc\n",
+		VMALLOC_START, VMALLOC_END);
+#else
 	pr_info("  * 0x%08lx..0x%08lx  : vmalloc & ioremap\n",
 		VMALLOC_START, VMALLOC_END);
+	pr_info("  * 0x%08lx..0x%08lx  : early ioremap\n",
+		IOREMAP_BASE, ioremap_bot);
+#endif
 #endif /* CONFIG_PPC32 */
 }
 
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 54a5bc0767a9..3aa0c78db95d 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -70,6 +70,27 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 	return ptepage;
 }
 
+#ifdef CONFIG_PPC_GUARDED_PAGE_IN_PMD
+int __pte_alloc_kernel_g(pmd_t *pmd, unsigned long address)
+{
+	pte_t *new = pte_alloc_one_kernel(&init_mm, address);
+	if (!new)
+		return -ENOMEM;
+
+	smp_wmb(); /* See comment in __pte_alloc */
+
+	spin_lock(&init_mm.page_table_lock);
+	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
+		pmd_populate_kernel_g(&init_mm, pmd, new);
+		new = NULL;
+	}
+	spin_unlock(&init_mm.page_table_lock);
+	if (new)
+		pte_free_kernel(&init_mm, new);
+	return 0;
+}
+#endif
+
 int map_kernel_page(unsigned long va, phys_addr_t pa, int flags)
 {
 	pmd_t *pd;
@@ -79,7 +100,12 @@ int map_kernel_page(unsigned long va, phys_addr_t pa, int flags)
 	/* Use upper 10 bits of VA to index the first level map */
 	pd = pmd_offset(pud_offset(pgd_offset_k(va), va), va);
 	/* Use middle 10 bits of VA to index the second-level map */
-	pg = pte_alloc_kernel(pd, va);
+#ifdef CONFIG_PPC_GUARDED_PAGE_IN_PMD
+	if (flags & _PAGE_GUARDED)
+		pg = pte_alloc_kernel_g(pd, va);
+	else
+#endif
+		pg = pte_alloc_kernel(pd, va);
 	if (pg != 0) {
 		err = 0;
 		/* The PTE should never be already set nor present in the
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 67d3125d0610..ba6b4c86b637 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -319,6 +319,8 @@ config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	def_bool y
 	depends on PPC_BOOK3S_64 && HUGETLB_PAGE && MIGRATION
 
+config PPC_GUARDED_PAGE_IN_PMD
+	bool
 
 config PPC_MMU_NOHASH
 	def_bool y
-- 
2.13.3
