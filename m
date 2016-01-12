Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 858A71A118A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 18:16:53 +1100 (AEDT)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 12:46:51 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 2DA47125805B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:47:35 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0C7GXoK44564722
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:33 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0C7GTVL013991
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:29 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 28/33] powerpc/mm: Hash linux abstractions for early
 init routines
Date: Tue, 12 Jan 2016 12:46:03 +0530
Message-Id: <1452582968-22669-29-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |  6 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 61 +-----------------
 arch/powerpc/include/asm/book3s/64/mmu.h      | 93 +++++++++++++++++++++++++++
 arch/powerpc/include/asm/mmu.h                | 25 +++----
 arch/powerpc/mm/hash_utils_64.c               |  6 +-
 5 files changed, 116 insertions(+), 75 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/mmu.h

diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index 16f513e5cbd7..b82e063494dd 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_MMU_HASH32_H_
-#define _ASM_POWERPC_MMU_HASH32_H_
+#ifndef _ASM_POWERPC_BOOK3S_32_MMU_HASH_H_
+#define _ASM_POWERPC_BOOK3S_32_MMU_HASH_H_
 /*
  * 32-bit hash table MMU support
  */
@@ -90,4 +90,4 @@ typedef struct {
 #define mmu_virtual_psize	MMU_PAGE_4K
 #define mmu_linear_psize	MMU_PAGE_256M
 
-#endif /* _ASM_POWERPC_MMU_HASH32_H_ */
+#endif /* _ASM_POWERPC_BOOK3S_32_MMU_HASH_H_ */
diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 95ee27564804..ee929cb1a150 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_MMU_HASH64_H_
-#define _ASM_POWERPC_MMU_HASH64_H_
+#ifndef _ASM_POWERPC_BOOK3S_64_MMU_HASH_H_
+#define _ASM_POWERPC_BOOK3S_64_MMU_HASH_H_
 /*
  * PowerPC64 memory management structures
  *
@@ -126,24 +126,6 @@ extern struct hash_pte *htab_address;
 extern unsigned long htab_size_bytes;
 extern unsigned long htab_hash_mask;
 
-/*
- * Page size definition
- *
- *    shift : is the "PAGE_SHIFT" value for that page size
- *    sllp  : is a bit mask with the value of SLB L || LP to be or'ed
- *            directly to a slbmte "vsid" value
- *    penc  : is the HPTE encoding mask for the "LP" field:
- *
- */
-struct mmu_psize_def
-{
-	unsigned int	shift;	/* number of bits */
-	int		penc[MMU_PAGE_COUNT];	/* HPTE encoding */
-	unsigned int	tlbiel;	/* tlbiel supported for that page size */
-	unsigned long	avpnm;	/* bits to mask out in AVPN in the HPTE */
-	unsigned long	sllp;	/* SLB L||LP (exact mask to use in slbmte) */
-};
-extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 
 static inline int shift_to_mmu_psize(unsigned int shift)
 {
@@ -209,11 +191,6 @@ static inline int segment_shift(int ssize)
 /*
  * The current system page and segment sizes
  */
-extern int mmu_linear_psize;
-extern int mmu_virtual_psize;
-extern int mmu_vmalloc_psize;
-extern int mmu_vmemmap_psize;
-extern int mmu_io_psize;
 extern int mmu_kernel_ssize;
 extern int mmu_highuser_ssize;
 extern u16 mmu_slb_size;
@@ -511,38 +488,6 @@ static inline void subpage_prot_free(struct mm_struct *mm) {}
 static inline void subpage_prot_init_new_context(struct mm_struct *mm) { }
 #endif /* CONFIG_PPC_SUBPAGE_PROT */
 
-typedef unsigned long mm_context_id_t;
-struct spinlock;
-
-typedef struct {
-	mm_context_id_t id;
-	u16 user_psize;		/* page size index */
-
-#ifdef CONFIG_PPC_MM_SLICES
-	u64 low_slices_psize;	/* SLB page size encodings */
-	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
-#else
-	u16 sllp;		/* SLB page size encoding */
-#endif
-	unsigned long vdso_base;
-#ifdef CONFIG_PPC_SUBPAGE_PROT
-	struct subpage_prot_table spt;
-#endif /* CONFIG_PPC_SUBPAGE_PROT */
-#ifdef CONFIG_PPC_ICSWX
-	struct spinlock *cop_lockp; /* guard acop and cop_pid */
-	unsigned long acop;	/* mask of enabled coprocessor types */
-	unsigned int cop_pid;	/* pid value used with coprocessors */
-#endif /* CONFIG_PPC_ICSWX */
-#ifdef CONFIG_PPC_64K_PAGES
-	/* for 4K PTE fragment support */
-	void *pte_frag;
-#endif
-#ifdef CONFIG_SPAPR_TCE_IOMMU
-	struct list_head iommu_group_mem_list;
-#endif
-} mm_context_t;
-
-
 #if 0
 /*
  * The code below is equivalent to this function for arguments
@@ -609,4 +554,4 @@ static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
 }
 #endif /* __ASSEMBLY__ */
 
-#endif /* _ASM_POWERPC_MMU_HASH64_H_ */
+#endif /* _ASM_POWERPC_BOOK3S_64_MMU_HASH_H_ */
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
new file mode 100644
index 000000000000..a2274ad0afee
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -0,0 +1,93 @@
+#ifndef _ASM_POWERPC_BOOK3S_64_MMU_H_
+#define _ASM_POWERPC_BOOK3S_64_MMU_H_
+
+#ifndef __ASSEMBLY__
+/*
+ * Page size definition
+ *
+ *    shift : is the "PAGE_SHIFT" value for that page size
+ *    sllp  : is a bit mask with the value of SLB L || LP to be or'ed
+ *            directly to a slbmte "vsid" value
+ *    penc  : is the HPTE encoding mask for the "LP" field:
+ *
+ */
+struct mmu_psize_def
+{
+	unsigned int	shift;	/* number of bits */
+	int		penc[MMU_PAGE_COUNT];	/* HPTE encoding */
+	unsigned int	tlbiel;	/* tlbiel supported for that page size */
+	unsigned long	avpnm;	/* bits to mask out in AVPN in the HPTE */
+	unsigned long	sllp;	/* SLB L||LP (exact mask to use in slbmte) */
+};
+extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
+#endif /* __ASSEMBLY__ */
+
+#ifdef CONFIG_PPC_STD_MMU_64
+/* 64-bit classic hash table MMU */
+#include <asm/book3s/64/mmu-hash.h>
+#endif
+
+#ifndef __ASSEMBLY__
+
+typedef unsigned long mm_context_id_t;
+struct spinlock;
+
+typedef struct {
+	mm_context_id_t id;
+	u16 user_psize;		/* page size index */
+
+#ifdef CONFIG_PPC_MM_SLICES
+	u64 low_slices_psize;	/* SLB page size encodings */
+	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
+#else
+	u16 sllp;		/* SLB page size encoding */
+#endif
+	unsigned long vdso_base;
+#ifdef CONFIG_PPC_SUBPAGE_PROT
+	struct subpage_prot_table spt;
+#endif /* CONFIG_PPC_SUBPAGE_PROT */
+#ifdef CONFIG_PPC_ICSWX
+	struct spinlock *cop_lockp; /* guard acop and cop_pid */
+	unsigned long acop;	/* mask of enabled coprocessor types */
+	unsigned int cop_pid;	/* pid value used with coprocessors */
+#endif /* CONFIG_PPC_ICSWX */
+#ifdef CONFIG_PPC_64K_PAGES
+	/* for 4K PTE fragment support */
+	void *pte_frag;
+#endif
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+	struct list_head iommu_group_mem_list;
+#endif
+} mm_context_t;
+
+/*
+ * The current system page and segment sizes
+ */
+extern int mmu_linear_psize;
+extern int mmu_virtual_psize;
+extern int mmu_vmalloc_psize;
+extern int mmu_vmemmap_psize;
+extern int mmu_io_psize;
+
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
+#endif /* __ASSEMBLY__ */
+#endif /* _ASM_POWERPC_BOOK3S_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 18a1b7dbf5fb..028f933fe74e 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -121,13 +121,6 @@ static inline void mmu_clear_feature(unsigned long feature)
 
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
@@ -180,10 +173,20 @@ static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 
 #define MMU_PAGE_COUNT	15
 
-#if defined(CONFIG_PPC_STD_MMU_64)
-/* 64-bit classic hash table MMU */
-#include <asm/book3s/64/mmu-hash.h>
-#elif defined(CONFIG_PPC_STD_MMU_32)
+#ifdef CONFIG_PPC_BOOK3S_64
+#include <asm/book3s/64/mmu.h>
+#else /* CONFIG_PPC_BOOK3S_64 */
+
+#ifndef __ASSEMBLY__
+/* MMU initialization */
+extern void early_init_mmu(void);
+extern void early_init_mmu_secondary(void);
+extern void setup_initial_memory_limit(phys_addr_t first_memblock_base,
+                                       phys_addr_t first_memblock_size);
+#endif /* __ASSEMBLY__ */
+#endif
+
+#if defined(CONFIG_PPC_STD_MMU_32)
 /* 32-bit classic hash table MMU */
 #include <asm/book3s/32/mmu-hash.h>
 #elif defined(CONFIG_40x)
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index a963a26b2d9d..2527c4bce871 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -798,7 +798,7 @@ static void __init htab_initialize(void)
 #undef KB
 #undef MB
 
-void __init early_init_mmu(void)
+void __init hlearly_init_mmu(void)
 {
 	/*
 	 * initialize global variables
@@ -836,7 +836,7 @@ void __init early_init_mmu(void)
 }
 
 #ifdef CONFIG_SMP
-void early_init_mmu_secondary(void)
+void hlearly_init_mmu_secondary(void)
 {
 	/* Initialize hash table for that CPU */
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
@@ -1569,7 +1569,7 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 }
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
-void setup_initial_memory_limit(phys_addr_t first_memblock_base,
+void hlsetup_initial_memory_limit(phys_addr_t first_memblock_base,
 				phys_addr_t first_memblock_size)
 {
 	/* We don't currently support the first MEMBLOCK not mapping 0
-- 
2.5.0
