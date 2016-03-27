Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqpw6zRGzDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:25:12 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:25:11 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id F1AF319D803F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:13:00 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8P75D30277852
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:25:07 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8P7uL028321
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:07 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 19/65] powerpc/mm: Move common pte bits and accessors to
 book3s/64/pgtable.h
Date: Sun, 27 Mar 2016 13:53:27 +0530
Message-Id: <1459067053-10835-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Now that we have moved book3s hash64 linux pte bits to match PowerISA
3.0 radix pte bit position, we move the matching pte bits to common
header.

Only code movement in this patch. No functionality change.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h    | 135 -------------------------
 arch/powerpc/include/asm/book3s/64/pgtable.h | 143 ++++++++++++++++++++++++++-
 2 files changed, 141 insertions(+), 137 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 13489dccc532..4aaee95a30fe 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -13,49 +13,12 @@
  * We could create separate kernel read-only if we used the 3 PP bits
  * combinations that newer processors provide but we currently don't.
  */
-#define _PAGE_BIT_SWAP_TYPE	0
-
-#define _PAGE_EXEC		0x00001 /* execute permission */
-#define _PAGE_WRITE		0x00002 /* write access allowed */
-#define _PAGE_READ		0x00004	/* read access allowed */
-#define _PAGE_RW		(_PAGE_READ | _PAGE_WRITE)
-#define _PAGE_RWX		(_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC)
-#define _PAGE_PRIVILEGED	0x00008 /* kernel access only */
-#define _PAGE_SAO		0x00010 /* Strong access order */
-#define _PAGE_NON_IDEMPOTENT	0x00020 /* non idempotent memory */
-#define _PAGE_TOLERANT		0x00030 /* tolerant memory, cache inhibited */
-#define _PAGE_DIRTY		0x00080 /* C: page changed */
-#define _PAGE_ACCESSED		0x00100 /* R: page referenced */
-/*
- * Software bits
- */
-#ifdef CONFIG_MEM_SOFT_DIRTY
-#define _PAGE_SOFT_DIRTY	0x00200 /* software: software dirty tracking */
-#else
-#define _PAGE_SOFT_DIRTY	0x00000
-#endif
-#define _PAGE_SPECIAL		0x00400 /* software: special page */
 #define H_PAGE_BUSY		0x00800 /* software: PTE & hash are busy */
 #define H_PTE_NONE_MASK		_PAGE_HPTEFLAGS
 #define H_PAGE_F_GIX_SHIFT	57
 #define H_PAGE_F_GIX		(7ul << 57)	/* HPTE index within HPTEG */
 #define H_PAGE_F_SECOND		(1ul << 60)	/* HPTE is in 2ndary HPTEG */
 #define H_PAGE_HASHPTE		(1ul << 61)	/* PTE has associated HPTE */
-#define _PAGE_PTE		(1ul << 62)	/* distinguishes PTEs from pointers */
-#define _PAGE_PRESENT		(1ul << 63)	/* pte contains a translation */
-/*
- * Drivers request for cache inhibited pte mapping using _PAGE_NO_CACHE
- * Instead of fixing all of them, add an alternate define which
- * maps CI pte mapping.
- */
-#define _PAGE_NO_CACHE		_PAGE_TOLERANT
-/*
- * set of bits not changed in pmd_modify.
- */
-#define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
-			 _PAGE_ACCESSED | H_PAGE_THP_HUGE | _PAGE_PTE | \
-			 _PAGE_SOFT_DIRTY)
-
 
 #ifdef CONFIG_PPC_64K_PAGES
 #include <asm/book3s/64/hash-64k.h>
@@ -113,16 +76,6 @@
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 #endif /* CONFIG_PPC_MM_SLICES */
 
-/*
- * user access blocked by key
- */
-#define _PAGE_KERNEL_RW		(_PAGE_PRIVILEGED | _PAGE_RW | _PAGE_DIRTY)
-#define _PAGE_KERNEL_RO		 (_PAGE_PRIVILEGED | _PAGE_READ)
-#define _PAGE_KERNEL_RWX	(_PAGE_PRIVILEGED | _PAGE_DIRTY | \
-				 _PAGE_RW | _PAGE_EXEC)
-
-/* No page size encoding in the linux PTE */
-#define _PAGE_PSIZE		0
 
 /* PTEIDX nibble */
 #define _PTEIDX_SECONDARY	0x8
@@ -130,94 +83,6 @@
 
 /* Hash table based platforms need atomic updates of the linux PTE */
 #define PTE_ATOMIC_UPDATES	1
-/*
- * We support 57 bit real address in pte. Clear everything above 57, and
- * every thing below PAGE_SHIFT;
- */
-#define PTE_RPN_MASK	(((1UL << 57) - 1) & (PAGE_MASK))
-/*
- * _PAGE_CHG_MASK masks of bits that are to be preserved across
- * pgprot changes
- */
-#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
-			 _PAGE_ACCESSED | _PAGE_SPECIAL | _PAGE_PTE | \
-			 _PAGE_SOFT_DIRTY)
-/*
- * Mask of bits returned by pte_pgprot()
- */
-#define PAGE_PROT_BITS  (_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT | \
-			 H_PAGE_4K_PFN | _PAGE_PRIVILEGED | _PAGE_ACCESSED | \
-			 _PAGE_READ | _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
-			 _PAGE_SOFT_DIRTY)
-/*
- * We define 2 sets of base prot bits, one for basic pages (ie,
- * cacheable kernel and user pages) and one for non cacheable
- * pages. We always set _PAGE_COHERENT when SMP is enabled or
- * the processor might need it for DMA coherency.
- */
-#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
-#define _PAGE_BASE	(_PAGE_BASE_NC)
-
-/* Permission masks used to generate the __P and __S table,
- *
- * Note:__pgprot is defined in arch/powerpc/include/asm/page.h
- *
- * Write permissions imply read permissions for now (we could make write-only
- * pages on BookE but we don't bother for now). Execute permission control is
- * possible on platforms that define _PAGE_EXEC
- *
- * Note due to the way vm flags are laid out, the bits are XWR
- */
-#define PAGE_NONE	__pgprot(_PAGE_BASE | _PAGE_PRIVILEGED)
-#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_RW)
-#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_RW | _PAGE_EXEC)
-#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_READ)
-#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
-#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_READ)
-#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
-
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY
-#define __P100	PAGE_READONLY_X
-#define __P101	PAGE_READONLY_X
-#define __P110	PAGE_COPY_X
-#define __P111	PAGE_COPY_X
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED
-#define __S100	PAGE_READONLY_X
-#define __S101	PAGE_READONLY_X
-#define __S110	PAGE_SHARED_X
-#define __S111	PAGE_SHARED_X
-
-/* Permission masks used for kernel mappings */
-#define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
-#define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
-				 _PAGE_TOLERANT)
-#define PAGE_KERNEL_NCG	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
-				 _PAGE_NON_IDEMPOTENT)
-#define PAGE_KERNEL_X	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RWX)
-#define PAGE_KERNEL_RO	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
-#define PAGE_KERNEL_ROX	__pgprot(_PAGE_BASE | _PAGE_KERNEL_ROX)
-
-/* Protection used for kernel text. We want the debuggers to be able to
- * set breakpoints anywhere, so don't write protect the kernel text
- * on platforms where such control is possible.
- */
-#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
-	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
-#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
-#else
-#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
-#endif
-
-/* Make modules code happy. We don't set RO yet */
-#define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
-#define PAGE_AGP		(PAGE_KERNEL_NC)
 
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
 #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 65eb819609b1..b5d9019f68bb 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1,9 +1,148 @@
 #ifndef _ASM_POWERPC_BOOK3S_64_PGTABLE_H_
 #define _ASM_POWERPC_BOOK3S_64_PGTABLE_H_
+
+/*
+ * Common bits between hash and Radix page table
+ */
+#define _PAGE_BIT_SWAP_TYPE	0
+
+#define _PAGE_EXEC		0x00001 /* execute permission */
+#define _PAGE_WRITE		0x00002 /* write access allowed */
+#define _PAGE_READ		0x00004	/* read access allowed */
+#define _PAGE_RW		(_PAGE_READ | _PAGE_WRITE)
+#define _PAGE_RWX		(_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC)
+#define _PAGE_PRIVILEGED	0x00008 /* kernel access only */
+#define _PAGE_SAO		0x00010 /* Strong access order */
+#define _PAGE_NON_IDEMPOTENT	0x00020 /* non idempotent memory */
+#define _PAGE_TOLERANT		0x00030 /* tolerant memory, cache inhibited */
+#define _PAGE_DIRTY		0x00080 /* C: page changed */
+#define _PAGE_ACCESSED		0x00100 /* R: page referenced */
+/*
+ * Software bits
+ */
+#ifdef CONFIG_MEM_SOFT_DIRTY
+#define _PAGE_SOFT_DIRTY	0x00200 /* software: software dirty tracking */
+#else
+#define _PAGE_SOFT_DIRTY	0x00000
+#endif
+#define _PAGE_SPECIAL		0x00400 /* software: special page */
+
+
+#define _PAGE_PTE		(1ul << 62)	/* distinguishes PTEs from pointers */
+#define _PAGE_PRESENT		(1ul << 63)	/* pte contains a translation */
+/*
+ * Drivers request for cache inhibited pte mapping using _PAGE_NO_CACHE
+ * Instead of fixing all of them, add an alternate define which
+ * maps CI pte mapping.
+ */
+#define _PAGE_NO_CACHE		_PAGE_TOLERANT
+/*
+ * set of bits not changed in pmd_modify. Even though we have hash specific bits
+ * in here, on radix we expect them to be zero.
+ */
+#define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
+			 _PAGE_ACCESSED | H_PAGE_THP_HUGE | _PAGE_PTE | \
+			 _PAGE_SOFT_DIRTY)
+/*
+ * user access blocked by key
+ */
+#define _PAGE_KERNEL_RW		(_PAGE_PRIVILEGED | _PAGE_RW | _PAGE_DIRTY)
+#define _PAGE_KERNEL_RO		 (_PAGE_PRIVILEGED | _PAGE_READ)
+#define _PAGE_KERNEL_RWX	(_PAGE_PRIVILEGED | _PAGE_DIRTY |	\
+				 _PAGE_RW | _PAGE_EXEC)
+/*
+ * No page size encoding in the linux PTE
+ */
+#define _PAGE_PSIZE		0
 /*
- * This file contains the functions and defines necessary to modify and use
- * the ppc64 hashed page table.
+ * We support 57 bit real address in pte. Clear everything above 57, and
+ * every thing below PAGE_SHIFT;
  */
+#define PTE_RPN_MASK	(((1UL << 57) - 1) & (PAGE_MASK))
+/*
+ * _PAGE_CHG_MASK masks of bits that are to be preserved across
+ * pgprot changes
+ */
+#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
+			 _PAGE_ACCESSED | _PAGE_SPECIAL | _PAGE_PTE |	\
+			 _PAGE_SOFT_DIRTY)
+/*
+ * Mask of bits returned by pte_pgprot()
+ */
+#define PAGE_PROT_BITS  (_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT | \
+			 H_PAGE_4K_PFN | _PAGE_PRIVILEGED | _PAGE_ACCESSED | \
+			 _PAGE_READ | _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
+			 _PAGE_SOFT_DIRTY)
+/*
+ * We define 2 sets of base prot bits, one for basic pages (ie,
+ * cacheable kernel and user pages) and one for non cacheable
+ * pages. We always set _PAGE_COHERENT when SMP is enabled or
+ * the processor might need it for DMA coherency.
+ */
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
+#define _PAGE_BASE	(_PAGE_BASE_NC)
+
+/* Permission masks used to generate the __P and __S table,
+ *
+ * Note:__pgprot is defined in arch/powerpc/include/asm/page.h
+ *
+ * Write permissions imply read permissions for now (we could make write-only
+ * pages on BookE but we don't bother for now). Execute permission control is
+ * possible on platforms that define _PAGE_EXEC
+ *
+ * Note due to the way vm flags are laid out, the bits are XWR
+ */
+#define PAGE_NONE	__pgprot(_PAGE_BASE | _PAGE_PRIVILEGED)
+#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_RW)
+#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_RW | _PAGE_EXEC)
+#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_READ)
+#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
+#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_READ)
+#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
+
+#define __P000	PAGE_NONE
+#define __P001	PAGE_READONLY
+#define __P010	PAGE_COPY
+#define __P011	PAGE_COPY
+#define __P100	PAGE_READONLY_X
+#define __P101	PAGE_READONLY_X
+#define __P110	PAGE_COPY_X
+#define __P111	PAGE_COPY_X
+
+#define __S000	PAGE_NONE
+#define __S001	PAGE_READONLY
+#define __S010	PAGE_SHARED
+#define __S011	PAGE_SHARED
+#define __S100	PAGE_READONLY_X
+#define __S101	PAGE_READONLY_X
+#define __S110	PAGE_SHARED_X
+#define __S111	PAGE_SHARED_X
+
+/* Permission masks used for kernel mappings */
+#define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
+#define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
+				 _PAGE_TOLERANT)
+#define PAGE_KERNEL_NCG	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
+				 _PAGE_NON_IDEMPOTENT)
+#define PAGE_KERNEL_X	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RWX)
+#define PAGE_KERNEL_RO	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
+#define PAGE_KERNEL_ROX	__pgprot(_PAGE_BASE | _PAGE_KERNEL_ROX)
+
+/*
+ * Protection used for kernel text. We want the debuggers to be able to
+ * set breakpoints anywhere, so don't write protect the kernel text
+ * on platforms where such control is possible.
+ */
+#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) || \
+	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
+#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
+#else
+#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
+#endif
+
+/* Make modules code happy. We don't set RO yet */
+#define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
+#define PAGE_AGP		(PAGE_KERNEL_NC)
 
 #include <asm/book3s/64/hash.h>
 #include <asm/barrier.h>
-- 
2.5.0
