Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqqR0mSSzDqGl
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:25:38 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:25:37 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B11CA3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:35 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u2R8PZ9O26411062
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:25:35 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8PYwX028319
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:35 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 31/65] powerpc/mm: Abstraction for vmemmap and map_kernel_page
Date: Sun, 27 Mar 2016 13:53:39 +0530
Message-Id: <1459067053-10835-31-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h    |  8 ++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 20 ++++++++++++++++++++
 arch/powerpc/include/asm/nohash/64/pgtable.h |  7 +++++++
 arch/powerpc/mm/init_64.c                    |  5 -----
 arch/powerpc/mm/mmu_decl.h                   |  5 -----
 arch/powerpc/mm/pgtable-hash64.c             | 12 ++++++------
 6 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 958491f59c2a..43bd7d15f41e 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -197,6 +197,14 @@ static inline void hpte_do_hugepage_flush(struct mm_struct *mm,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+
+extern int hlmap_kernel_page(unsigned long ea, unsigned long pa,
+			     unsigned long flags);
+extern int __meminit hlvmemmap_create_mapping(unsigned long start,
+					      unsigned long page_size,
+					      unsigned long phys);
+extern void hlvmemmap_remove_mapping(unsigned long start,
+				     unsigned long page_size);
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index e3a8fc469460..bf6a600cb109 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -722,6 +722,26 @@ extern struct page *pgd_page(pgd_t pgd);
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
 
+static inline int map_kernel_page(unsigned long ea, unsigned long pa,
+				  unsigned long flags)
+{
+	return hlmap_kernel_page(ea, pa, flags);
+}
+
+static inline int __meminit vmemmap_create_mapping(unsigned long start,
+						   unsigned long page_size,
+						   unsigned long phys)
+{
+	return hlvmemmap_create_mapping(start, page_size, phys);
+}
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline void vmemmap_remove_mapping(unsigned long start,
+					  unsigned long page_size)
+{
+	return hlvmemmap_remove_mapping(start, page_size);
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
index 898d63365cdd..6360f54ef2d0 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -109,11 +109,6 @@ extern unsigned long Hash_size, Hash_mask;
 
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
index 183f80a528ba..b926b0a4ae0c 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -26,9 +26,9 @@
  * On hash-based CPUs, the vmemmap is bolted in the hash table.
  *
  */
-int __meminit vmemmap_create_mapping(unsigned long start,
-				     unsigned long page_size,
-				     unsigned long phys)
+int __meminit hlvmemmap_create_mapping(unsigned long start,
+				       unsigned long page_size,
+				       unsigned long phys)
 {
 	int rc = htab_bolt_mapping(start, start + page_size, phys,
 				   pgprot_val(PAGE_KERNEL),
@@ -43,8 +43,8 @@ int __meminit vmemmap_create_mapping(unsigned long start,
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-void vmemmap_remove_mapping(unsigned long start,
-			    unsigned long page_size)
+void hlvmemmap_remove_mapping(unsigned long start,
+			      unsigned long page_size)
 {
 	int rc = htab_remove_mapping(start, start + page_size,
 				     mmu_vmemmap_psize,
@@ -60,7 +60,7 @@ void vmemmap_remove_mapping(unsigned long start,
  * map_kernel_page adds an entry to the ioremap page table
  * and adds an entry to the HPT, possibly bolting it
  */
-int map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
+int hlmap_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
 {
 	pgd_t *pgdp;
 	pud_t *pudp;
-- 
2.5.0
