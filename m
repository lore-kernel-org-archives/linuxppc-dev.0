Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C0A2D1A050A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 03:52:14 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 18 Feb 2016 09:52:13 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 431473E40052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 09:52:11 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1IGqBsa29229072
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 09:52:11 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1IGqAOW019333
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 09:52:11 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 25/30] powerpc/mm: Hash linux abstractions for early init
 routines
Date: Thu, 18 Feb 2016 22:20:49 +0530
Message-Id: <1455814254-10226-26-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1455814254-10226-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1455814254-10226-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/book3s/64/mmu.h      | 92 +++++++++++++++++++++++++++
 arch/powerpc/include/asm/mmu.h                | 25 ++++----
 arch/powerpc/mm/hash_utils_64.c               |  6 +-
 5 files changed, 115 insertions(+), 75 deletions(-)
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
index a34f3687e093..5db7c344d969 100644
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
@@ -127,24 +127,6 @@ extern struct hash_pte *htab_address;
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
@@ -210,11 +192,6 @@ static inline int segment_shift(int ssize)
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
@@ -512,38 +489,6 @@ static inline void subpage_prot_free(struct mm_struct *mm) {}
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
@@ -610,4 +555,4 @@ static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
 }
 #endif /* __ASSEMBLY__ */
 
-#endif /* _ASM_POWERPC_MMU_HASH64_H_ */
+#endif /* _ASM_POWERPC_BOOK3S_64_MMU_HASH_H_ */
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
new file mode 100644
index 000000000000..44a47bc81fb2
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -0,0 +1,92 @@
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
+struct mmu_psize_def {
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
index 8ca1c983bf6c..f6756fc139d9 100644
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
@@ -181,10 +174,20 @@ static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 
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
+				       phys_addr_t first_memblock_size);
+#endif /* __ASSEMBLY__ */
+#endif
+
+#if defined(CONFIG_PPC_STD_MMU_32)
 /* 32-bit classic hash table MMU */
 #include <asm/book3s/32/mmu-hash.h>
 #elif defined(CONFIG_40x)
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index aec47cf45db2..aac47ca6a618 100644
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
@@ -842,7 +842,7 @@ void __init early_init_mmu(void)
 }
 
 #ifdef CONFIG_SMP
-void early_init_mmu_secondary(void)
+void hlearly_init_mmu_secondary(void)
 {
 	/* Initialize hash table for that CPU */
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
@@ -1576,7 +1576,7 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 }
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
-void setup_initial_memory_limit(phys_addr_t first_memblock_base,
+void hlsetup_initial_memory_limit(phys_addr_t first_memblock_base,
 				phys_addr_t first_memblock_size)
 {
 	/* We don't currently support the first MEMBLOCK not mapping 0
-- 
2.5.0
