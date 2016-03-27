Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqqN11M5zDqHd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:25:35 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:25:34 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1CA7A19D803E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:13:26 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u2R8PWma42401902
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:25:32 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8PU3d028178
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:30 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 29/65] powerpc/mm: Abstraction for early init routines
Date: Sun, 27 Mar 2016 13:53:37 +0530
Message-Id: <1459067053-10835-29-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/book3s/64/mmu.h | 20 ++++++++++++++++++++
 arch/powerpc/include/asm/mmu.h           | 14 +++++++-------
 arch/powerpc/mm/hash_utils_64.c          |  6 +++---
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 593d9e3ce8e7..a66cd3e65a33 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -97,5 +97,25 @@ extern int mmu_vmalloc_psize;
 extern int mmu_vmemmap_psize;
 extern int mmu_io_psize;
 
+/* MMU initialization */
+extern void hlearly_init_mmu(void);
+static inline void early_init_mmu(void)
+{
+	return hlearly_init_mmu();
+}
+extern void hlearly_init_mmu_secondary(void);
+static inline void early_init_mmu_secondary(void)
+{
+	return hlearly_init_mmu_secondary();
+}
+
+extern void hlsetup_initial_memory_limit(phys_addr_t first_memblock_base,
+					 phys_addr_t first_memblock_size);
+static inline void setup_initial_memory_limit(phys_addr_t first_memblock_base,
+					      phys_addr_t first_memblock_size)
+{
+	return hlsetup_initial_memory_limit(first_memblock_base,
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
index c4a5f13997b8..8dfc6ae85d4a 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -864,7 +864,7 @@ static void __init htab_initialize(void)
 #undef KB
 #undef MB
 
-void __init early_init_mmu(void)
+void __init hlearly_init_mmu(void)
 {
 	/*
 	 * initialize page table size
@@ -889,7 +889,7 @@ void __init early_init_mmu(void)
 }
 
 #ifdef CONFIG_SMP
-void early_init_mmu_secondary(void)
+void hlearly_init_mmu_secondary(void)
 {
 	/* Initialize hash table for that CPU */
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
@@ -1631,7 +1631,7 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 }
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
-void setup_initial_memory_limit(phys_addr_t first_memblock_base,
+void hlsetup_initial_memory_limit(phys_addr_t first_memblock_base,
 				phys_addr_t first_memblock_size)
 {
 	/* We don't currently support the first MEMBLOCK not mapping 0
-- 
2.5.0
