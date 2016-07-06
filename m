Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rknw60hmszDqxT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 14:34:29 +1000 (AEST)
Message-ID: <1467779659.13965.101.camel@kernel.crashing.org>
Subject: [RFC/PATCH 2/4] powerpc/64/kexec: Fix MMU cleanup on radix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Anton Blanchard
 <anton@au1.ibm.com>
Date: Wed, 06 Jul 2016 14:34:19 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just using the hash ops won't work anymore since radix will have
NULL in there. Instead create an mmu_cleanup_all() function which
will do the right thing based on the MMU mode.

For Radix, for now I clear UPRT and the PTCR, effectively switching
back to Radix with no partition table setup.

Currently set it to NULL on BookE thought it might be a good idea
to wipe the TLB there (Scott ?)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Currently only compile tested

 arch/powerpc/include/asm/book3s/64/mmu.h |  3 +++
 arch/powerpc/include/asm/mmu-book3e.h    |  3 +++
 arch/powerpc/include/asm/mmu.h           |  3 +++
 arch/powerpc/kernel/machine_kexec_64.c   | 10 +---------
 arch/powerpc/mm/pgtable-book3s64.c       |  9 +++++++++
 arch/powerpc/mm/pgtable-radix.c          | 10 ++++++++++
 6 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 6a90efe..b5c97c1 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -135,5 +135,8 @@ static inline void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	return hash__setup_initial_memory_limit(first_memblock_base,
 					   first_memblock_size);
 }
+
+extern void radix__mmu_cleanup_all(void);
+
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index cd4f04a..b62a8d4 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -313,6 +313,9 @@ extern int book3e_htw_mode;
  * return 1, indicating that the tlb requires preloading.
  */
 #define HUGETLB_NEED_PRELOAD
+
+#define mmu_cleanup_all NULL
+
 #endif
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index e53ebeb..50f9aac 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -148,6 +148,9 @@ extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
  * make it match the size our of bolted TLB area
  */
 extern u64 ppc64_rma_size;
+
+/* Cleanup function used by kexec */
+extern void mmu_cleanup_all(void);
 #endif /* CONFIG_PPC64 */
 
 struct mm_struct;
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 833a79d..0595ede 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -54,9 +54,6 @@ int default_machine_kexec_prepare(struct kimage *image)
 	const unsigned long *basep;
 	const unsigned int *sizep;
 
-	if (!mmu_hash_ops.hpte_clear_all)
-		return -ENOENT;
-
 	/*
 	 * Since we use the kernel fault handlers and paging code to
 	 * handle the virtual mode, we must make sure no destination
@@ -379,12 +376,7 @@ void default_machine_kexec(struct kimage *image)
 	 */
 	kexec_sequence(&kexec_stack, image->start, image,
 			page_address(image->control_code_page),
-#ifdef CONFIG_PPC_BOOK3E
-		       NULL
-#else
-			mmu_hash_ops.hpte_clear_all
-#endif
-		       );
+		       mmu_cleanup_all);
 	/* NOTREACHED */
 }
 
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 85c6070..b654e3c 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -115,3 +115,12 @@ void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 	return;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+/* For use by kexec */
+void mmu_cleanup_all(void)
+{
+	if (radix_enabled())
+		radix__mmu_cleanup_all();
+	else if (mmu_hash_ops.hpte_clear_all)
+		mmu_hash_ops.hpte_clear_all();
+}
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 3ababda..f127baa 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -366,6 +366,16 @@ void radix__early_init_mmu_secondary(void)
 	}
 }
 
+void radix__mmu_cleanup_all(void)
+{
+	unsigned long lpcr;
+	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
+		lpcr = mfspr(SPRN_LPCR);
+		mtspr(SPRN_LPCR, lpcr & ~LPCR_UPRT);
+		mtspr(SPRN_PTCR, 0);
+	}
+}
+
 void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				phys_addr_t first_memblock_size)
 {
