Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE68C1A0B57
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 00:40:19 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 7 Mar 2016 06:40:17 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 797973E4005B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 06:40:14 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u27DeEax45875390
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 06:40:14 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u27DeDFd015919
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 06:40:14 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 12/14] powerpc/mm: Move common data structure between radix
 and hash to book3s 64 generic headers
Date: Mon,  7 Mar 2016 19:09:32 +0530
Message-Id: <1457357974-20839-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We want to use mmu_context_t between radix and hash. Move that mmuh.h

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |  6 +--
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 61 ++---------------------
 arch/powerpc/include/asm/book3s/64/mmu.h      | 72 +++++++++++++++++++++++++++
 arch/powerpc/include/asm/mmu.h                | 11 ++--
 4 files changed, 85 insertions(+), 65 deletions(-)
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
index 0cea4807e26f..ce73736b42db 100644
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
@@ -613,4 +558,4 @@ unsigned htab_shift_for_mem_size(unsigned long mem_size);
 
 #endif /* __ASSEMBLY__ */
 
-#endif /* _ASM_POWERPC_MMU_HASH64_H_ */
+#endif /* _ASM_POWERPC_BOOK3S_64_MMU_HASH_H_ */
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
new file mode 100644
index 000000000000..aadb0bbc5c71
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -0,0 +1,72 @@
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
+#endif /* __ASSEMBLY__ */
+#endif /* _ASM_POWERPC_BOOK3S_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 8ca1c983bf6c..5f55024f9522 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -181,10 +181,13 @@ static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 
 #define MMU_PAGE_COUNT	15
 
-#if defined(CONFIG_PPC_STD_MMU_64)
-/* 64-bit classic hash table MMU */
-#include <asm/book3s/64/mmu-hash.h>
-#elif defined(CONFIG_PPC_STD_MMU_32)
+#ifdef CONFIG_PPC_BOOK3S_64
+#include <asm/book3s/64/mmu.h>
+#else /* CONFIG_PPC_BOOK3S_64 */
+
+#endif
+
+#if defined(CONFIG_PPC_STD_MMU_32)
 /* 32-bit classic hash table MMU */
 #include <asm/book3s/32/mmu-hash.h>
 #elif defined(CONFIG_40x)
-- 
2.5.0
