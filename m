Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDy85lTlzDqBY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 34/70] powerpc/mm: Abstract early MMU init in preparation
 for radix
Date: Fri, 29 Apr 2016 23:25:57 +1000
Message-Id: <1461936393-10131-34-git-send-email-mpe@ellerman.id.au>
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

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 20 ++++++++++++++++++++
 arch/powerpc/include/asm/mmu.h           | 14 +++++++-------
 arch/powerpc/mm/hash_utils_64.c          |  6 +++---
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 593d9e3ce8e7..37943f7af60f 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -97,5 +97,25 @@ extern int mmu_vmalloc_psize;
 extern int mmu_vmemmap_psize;
 extern int mmu_io_psize;
 
+/* MMU initialization */
+extern void hash__early_init_mmu(void);
+static inline void early_init_mmu(void)
+{
+	return hash__early_init_mmu();
+}
+extern void hash__early_init_mmu_secondary(void);
+static inline void early_init_mmu_secondary(void)
+{
+	return hash__early_init_mmu_secondary();
+}
+
+extern void hash__setup_initial_memory_limit(phys_addr_t first_memblock_base,
+					 phys_addr_t first_memblock_size);
+static inline void setup_initial_memory_limit(phys_addr_t first_memblock_base,
+					      phys_addr_t first_memblock_size)
+{
+	return hash__setup_initial_memory_limit(first_memblock_base,
+					   first_memblock_size);
+}
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index decde4c4870d..34070e982f1d 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -122,13 +122,6 @@ static inline void mmu_clear_feature(unsigned long feature)
 
 extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
 
-/* MMU initialization */
-extern void early_init_mmu(void);
-extern void early_init_mmu_secondary(void);
-
-extern void setup_initial_memory_limit(phys_addr_t first_memblock_base,
-				       phys_addr_t first_memblock_size);
-
 #ifdef CONFIG_PPC64
 /* This is our real memory area size on ppc64 server, on embedded, we
  * make it match the size our of bolted TLB area
@@ -185,6 +178,13 @@ static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 #include <asm/book3s/64/mmu.h>
 #else /* CONFIG_PPC_BOOK3S_64 */
 
+#ifndef __ASSEMBLY__
+/* MMU initialization */
+extern void early_init_mmu(void);
+extern void early_init_mmu_secondary(void);
+extern void setup_initial_memory_limit(phys_addr_t first_memblock_base,
+				       phys_addr_t first_memblock_size);
+#endif /* __ASSEMBLY__ */
 #endif
 
 #if defined(CONFIG_PPC_STD_MMU_32)
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index aafc613656fc..e6b53cde676e 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -868,7 +868,7 @@ static void __init htab_initialize(void)
 #undef KB
 #undef MB
 
-void __init early_init_mmu(void)
+void __init hash__early_init_mmu(void)
 {
 	/*
 	 * initialize page table size
@@ -893,7 +893,7 @@ void __init early_init_mmu(void)
 }
 
 #ifdef CONFIG_SMP
-void early_init_mmu_secondary(void)
+void hash__early_init_mmu_secondary(void)
 {
 	/* Initialize hash table for that CPU */
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
@@ -1635,7 +1635,7 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 }
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
-void setup_initial_memory_limit(phys_addr_t first_memblock_base,
+void hash__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				phys_addr_t first_memblock_size)
 {
 	/* We don't currently support the first MEMBLOCK not mapping 0
-- 
2.5.0
