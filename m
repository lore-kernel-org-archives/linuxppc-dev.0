Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 20 Mar 2009 16:34:15 +1100
Subject: [PATCH 5/6] powerpc/mm: Add option for non-atomic PTE updates to ppc64
In-Reply-To: <1237527248.890279.946079812092.qpush@grosgo>
Message-Id: <20090320053433.83087DDFCD@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ppc32 has it already, add it to ppc64 as a preliminary for adding
support for Book3E 64-bit support

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/pgtable-ppc64.h |   12 +++++++++++-
 arch/powerpc/include/asm/pte-hash64.h    |    2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc64.h	2009-03-10 15:43:26.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc64.h	2009-03-10 16:08:30.000000000 +1100
@@ -178,6 +178,7 @@ static inline unsigned long pte_update(s
 				       pte_t *ptep, unsigned long clr,
 				       int huge)
 {
+#ifdef PTE_ATOMIC_UPDATES
 	unsigned long old, tmp;
 
 	__asm__ __volatile__(
@@ -190,7 +191,10 @@ static inline unsigned long pte_update(s
 	: "=&r" (old), "=&r" (tmp), "=m" (*ptep)
 	: "r" (ptep), "r" (clr), "m" (*ptep), "i" (_PAGE_BUSY)
 	: "cc" );
-
+#else
+	unsigned long old = pte_val(*ptep);
+	*ptep = __pte(old & ~clr);
+#endif
 	/* huge pages use the old page table lock */
 	if (!huge)
 		assert_pte_locked(mm, addr);
@@ -278,6 +282,8 @@ static inline void __ptep_set_access_fla
 	unsigned long bits = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW |
 		 _PAGE_EXEC | _PAGE_HWEXEC);
+
+#ifdef PTE_ATOMIC_UPDATES
 	unsigned long old, tmp;
 
 	__asm__ __volatile__(
@@ -290,6 +296,10 @@ static inline void __ptep_set_access_fla
 	:"=&r" (old), "=&r" (tmp), "=m" (*ptep)
 	:"r" (bits), "r" (ptep), "m" (*ptep), "i" (_PAGE_BUSY)
 	:"cc");
+#else
+	unsigned long old = pte_val(*ptep);
+	*ptep = __pte(old | bits);
+#endif
 }
 
 #define __HAVE_ARCH_PTE_SAME
Index: linux-work/arch/powerpc/include/asm/pte-hash64.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pte-hash64.h	2009-03-10 15:49:50.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pte-hash64.h	2009-03-10 15:49:55.000000000 +1100
@@ -41,6 +41,8 @@
 #define _PTEIDX_SECONDARY	0x8
 #define _PTEIDX_GROUP_IX	0x7
 
+/* Hash table based platforms need atomic updates of the linux PTE */
+#define PTE_ATOMIC_UPDATES	1
 
 #ifdef CONFIG_PPC_64K_PAGES
 #include <asm/pte-hash64-64k.h>
