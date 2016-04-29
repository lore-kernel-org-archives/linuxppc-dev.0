Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyB2mCnzDqB9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 36/70] powerpc/mm: Abstraction for vmemmap and
 map_kernel_page()
Date: Fri, 29 Apr 2016 23:25:59 +1000
Message-Id: <1461936393-10131-36-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

For hash we create vmemmap mapping using bolted hash page table entries.
For radix we fill the radix page table. The next patch will add the
radix details for creating vmemmap mappings.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash.h    |  8 ++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 20 ++++++++++++++++++++
 arch/powerpc/include/asm/nohash/64/pgtable.h |  7 +++++++
 arch/powerpc/mm/init_64.c                    |  5 -----
 arch/powerpc/mm/mmu_decl.h                   |  5 -----
 arch/powerpc/mm/pgtable-hash64.c             | 12 ++++++------
 6 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 62714399a1a0..cd3e91583c81 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -193,6 +193,14 @@ static inline void hpte_do_hugepage_flush(struct mm_struct *mm,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+
+extern int hash__map_kernel_page(unsigned long ea, unsigned long pa,
+			     unsigned long flags);
+extern int __meminit hash__vmemmap_create_mapping(unsigned long start,
+					      unsigned long page_size,
+					      unsigned long phys);
+extern void hash__vmemmap_remove_mapping(unsigned long start,
+				     unsigned long page_size);
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index a22b47844f2f..c1b787dcfbb6 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -722,6 +722,26 @@ extern struct page *pgd_page(pgd_t pgd);
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
 
+static inline int map_kernel_page(unsigned long ea, unsigned long pa,
+				  unsigned long flags)
+{
+	return hash__map_kernel_page(ea, pa, flags);
+}
+
+static inline int __meminit vmemmap_create_mapping(unsigned long start,
+						   unsigned long page_size,
+						   unsigned long phys)
+{
+	return hash__vmemmap_create_mapping(start, page_size, phys);
+}
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline void vmemmap_remove_mapping(unsigned long start,
+					  unsigned long page_size)
+{
+	return hash__vmemmap_remove_mapping(start, page_size);
+}
+#endif
 struct page *realmode_pfn_to_page(unsigned long pfn);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 10debb93c4a4..f143d6fb3576 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -362,6 +362,13 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
+extern int map_kernel_page(unsigned long ea, unsigned long pa,
+			   unsigned long flags);
+extern int __meminit vmemmap_create_mapping(unsigned long start,
+					    unsigned long page_size,
+					    unsigned long phys);
+extern void vmemmap_remove_mapping(unsigned long start,
+				   unsigned long page_size);
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_NOHASH_64_PGTABLE_H */
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 09ca65e55b58..33709bdb0419 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -240,9 +240,6 @@ static __meminit void vmemmap_list_populate(unsigned long phys,
 	vmemmap_list = vmem_back;
 }
 
-extern int __meminit vmemmap_create_mapping(unsigned long start,
-					    unsigned long page_size,
-					    unsigned long phys);
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 {
 	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
@@ -281,8 +278,6 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-extern void vmemmap_remove_mapping(unsigned long start,
-				   unsigned long page_size);
 static unsigned long vmemmap_list_free(unsigned long start)
 {
 	struct vmemmap_backing *vmem_back, *vmem_back_prev;
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index bfb7c0bcabd5..6af65327c993 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -108,11 +108,6 @@ extern unsigned long Hash_size, Hash_mask;
 
 #endif /* CONFIG_PPC32 */
 
-#ifdef CONFIG_PPC64
-extern int map_kernel_page(unsigned long ea, unsigned long pa,
-			   unsigned long flags);
-#endif /* CONFIG_PPC64 */
-
 extern unsigned long ioremap_bot;
 extern unsigned long __max_low_memory;
 extern phys_addr_t __initial_memory_limit_addr;
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 6f5fa68c784e..64975ebfc50b 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -20,9 +20,9 @@
  * On hash-based CPUs, the vmemmap is bolted in the hash table.
  *
  */
-int __meminit vmemmap_create_mapping(unsigned long start,
-				     unsigned long page_size,
-				     unsigned long phys)
+int __meminit hash__vmemmap_create_mapping(unsigned long start,
+				       unsigned long page_size,
+				       unsigned long phys)
 {
 	int rc = htab_bolt_mapping(start, start + page_size, phys,
 				   pgprot_val(PAGE_KERNEL),
@@ -37,8 +37,8 @@ int __meminit vmemmap_create_mapping(unsigned long start,
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-void vmemmap_remove_mapping(unsigned long start,
-			    unsigned long page_size)
+void hash__vmemmap_remove_mapping(unsigned long start,
+			      unsigned long page_size)
 {
 	int rc = htab_remove_mapping(start, start + page_size,
 				     mmu_vmemmap_psize,
@@ -54,7 +54,7 @@ void vmemmap_remove_mapping(unsigned long start,
  * map_kernel_page adds an entry to the ioremap page table
  * and adds an entry to the HPT, possibly bolting it
  */
-int map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
+int hash__map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
 {
 	pgd_t *pgdp;
 	pud_t *pudp;
-- 
2.5.0
