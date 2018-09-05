Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4253B33Ht7zF31V
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 22:37:15 +1000 (AEST)
Message-Id: <801e9a003fbf5725cbb2b56f93f9efe49e8e2f1e.1535913369.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 10/17] powerpc/book3s/32: do not include pte-common.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  5 Sep 2018 12:37:11 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As done for book3s/64, add necessary flags/defines in
book3s/32/pgtable.h and do not include pte-common.h

It allows in the meantime to remove all related hash
definitions from pte-common.h and to also remove
_PAGE_EXEC default as _PAGE_EXEC is defined on all
platforms except book3s/32.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 97 ++++++++++++++++++++++++++--
 arch/powerpc/include/asm/pte-common.h        | 16 +----
 2 files changed, 96 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 90991dce63e9..6f56dfa25716 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -8,7 +8,97 @@
 #include <asm/book3s/32/hash.h>
 
 /* And here we include common definitions */
-#include <asm/pte-common.h>
+
+#define _PAGE_KERNEL_RO		0
+#define _PAGE_KERNEL_ROX	0
+#define _PAGE_KERNEL_RW		(_PAGE_DIRTY | _PAGE_RW)
+#define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW)
+
+#define _PAGE_HPTEFLAGS _PAGE_HASHPTE
+
+#ifndef __ASSEMBLY__
+
+static inline bool pte_user(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_USER;
+}
+#endif /* __ASSEMBLY__ */
+
+/* Location of the PFN in the PTE. Most 32-bit platforms use the same
+ * as _PAGE_SHIFT here (ie, naturally aligned).
+ * Platform who don't just pre-define the value so we don't override it here
+ */
+#define PTE_RPN_SHIFT	(PAGE_SHIFT)
+
+/* The mask covered by the RPN must be a ULL on 32-bit platforms with
+ * 64-bit PTEs
+ */
+#ifdef CONFIG_PTE_64BIT
+#define PTE_RPN_MASK	(~((1ULL << PTE_RPN_SHIFT) - 1))
+#else
+#define PTE_RPN_MASK	(~((1UL << PTE_RPN_SHIFT) - 1))
+#endif
+
+/* _PAGE_CHG_MASK masks of bits that are to be preserved across
+ * pgprot changes
+ */
+#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HASHPTE | _PAGE_DIRTY | \
+			 _PAGE_ACCESSED | _PAGE_SPECIAL)
+
+/* Mask of bits returned by pte_pgprot() */
+#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
+			 _PAGE_WRITETHRU | _PAGE_USER | _PAGE_ACCESSED | \
+			 _PAGE_RW | _PAGE_DIRTY)
+
+/*
+ * We define 2 sets of base prot bits, one for basic pages (ie,
+ * cacheable kernel and user pages) and one for non cacheable
+ * pages. We always set _PAGE_COHERENT when SMP is enabled or
+ * the processor might need it for DMA coherency.
+ */
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
+#define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
+
+/* Permission masks used to generate the __P and __S table,
+ *
+ * Note:__pgprot is defined in arch/powerpc/include/asm/page.h
+ *
+ * Write permissions imply read permissions for now.
+ */
+#define PAGE_NONE	__pgprot(_PAGE_BASE)
+#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
+#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
+#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER)
+
+/* Permission masks used for kernel mappings */
+#define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
+#define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | _PAGE_NO_CACHE)
+#define PAGE_KERNEL_NCG	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
+				 _PAGE_NO_CACHE | _PAGE_GUARDED)
+#define PAGE_KERNEL_X	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RWX)
+#define PAGE_KERNEL_RO	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
+#define PAGE_KERNEL_ROX	__pgprot(_PAGE_BASE | _PAGE_KERNEL_ROX)
+
+/* Protection used for kernel text. We want the debuggers to be able to
+ * set breakpoints anywhere, so don't write protect the kernel text
+ * on platforms where such control is possible.
+ */
+#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
+	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
+#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
+#else
+#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
+#endif
+
+/* Make modules code happy. We don't set RO yet */
+#define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
+
+/* Advertise special mapping type for AGP */
+#define PAGE_AGP		(PAGE_KERNEL_NC)
+#define HAVE_PAGE_AGP
 
 #define PTE_INDEX_SIZE	PTE_SHIFT
 #define PMD_INDEX_SIZE	0
@@ -219,7 +309,7 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
 {
-	pte_update(ptep, (_PAGE_RW | _PAGE_HWWRITE), _PAGE_RO);
+	pte_update(ptep, _PAGE_RW, 0);
 }
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
@@ -235,9 +325,8 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 {
 	unsigned long set = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW);
-	unsigned long clr = ~pte_val(entry) & _PAGE_RO;
 
-	pte_update(ptep, clr, set);
+	pte_update(ptep, 0, set);
 
 	flush_tlb_page(vma, address);
 }
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 4860dae76dae..3a8ec18ffd22 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -5,15 +5,9 @@
  * Some bits are only used on some cpu families... Make sure that all
  * the undefined gets a sensible default
  */
-#ifndef _PAGE_HASHPTE
-#define _PAGE_HASHPTE	0
-#endif
 #ifndef _PAGE_HWWRITE
 #define _PAGE_HWWRITE	0
 #endif
-#ifndef _PAGE_EXEC
-#define _PAGE_EXEC	0
-#endif
 #ifndef _PAGE_COHERENT
 #define _PAGE_COHERENT	0
 #endif
@@ -68,11 +62,8 @@
 #define _PAGE_KERNEL_RWX	(_PAGE_PRIVILEGED | _PAGE_DIRTY | _PAGE_RW | \
 				 _PAGE_HWWRITE | _PAGE_EXEC)
 #endif
-#ifndef _PAGE_HPTEFLAGS
-#define _PAGE_HPTEFLAGS _PAGE_HASHPTE
-#endif
 #ifndef _PTE_NONE_MASK
-#define _PTE_NONE_MASK	_PAGE_HPTEFLAGS
+#define _PTE_NONE_MASK	0
 #endif
 
 #ifndef __ASSEMBLY__
@@ -108,7 +99,7 @@ static inline bool pte_user(pte_t pte)
 /* _PAGE_CHG_MASK masks of bits that are to be preserved across
  * pgprot changes
  */
-#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
+#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_DIRTY | \
                          _PAGE_ACCESSED | _PAGE_SPECIAL)
 
 /* Mask of bits returned by pte_pgprot() */
@@ -125,8 +116,7 @@ static inline bool pte_user(pte_t pte)
  * the processor might need it for DMA coherency.
  */
 #define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC_STD_MMU) || \
-	defined(CONFIG_PPC_E500MC)
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
 #define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
 #else
 #define _PAGE_BASE	(_PAGE_BASE_NC)
-- 
2.13.3
