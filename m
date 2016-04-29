Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDxg0C3dzDqBF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:26:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 05/70] powerpc/mm: Use big endian Linux page tables for
 book3s 64
Date: Fri, 29 Apr 2016 23:25:28 +1000
Message-Id: <1461936393-10131-5-git-send-email-mpe@ellerman.id.au>
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

Traditionally Power server machines have used the Hashed Page Table MMU
mode. In this mode Linux manages its own tree of nested page tables,
aka. "the Linux page tables", which are not used by the hardware
directly, and software loads translations into the hash page table for
use by the hardware.

Power ISA 3.0 defines a new MMU mode, known as Radix Tree Translation,
where the hardware can directly operate on the Linux page tables.
However the hardware requires that the page tables be in big endian
format.

To accommodate this, switch the pgtable types to __be64 and add
appropriate endian conversions.

Because we will be supporting a single kernel binary that boots using
either radix or hash mode, we always store the Linux page tables big
endian, even in hash mode where they are not actually used by the
hardware.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
[mpe: Fix sparse errors, flesh out change log]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash.h   | 24 ++++----
 arch/powerpc/include/asm/page.h             |  4 ++
 arch/powerpc/include/asm/pgtable-be-types.h | 92 +++++++++++++++++++++++++++++
 arch/powerpc/mm/hash64_64k.c                |  1 -
 arch/powerpc/mm/hugepage-hash64.c           |  4 +-
 arch/powerpc/mm/pgtable_64.c                | 12 ++--
 6 files changed, 120 insertions(+), 17 deletions(-)
 create mode 100644 arch/powerpc/include/asm/pgtable-be-types.h

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 8f2ae0674be9..7fc1a9a8169a 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -247,23 +247,26 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 				       unsigned long set,
 				       int huge)
 {
-	unsigned long old, tmp;
+	__be64 old_be, tmp_be;
+	unsigned long old;
 
 	__asm__ __volatile__(
 	"1:	ldarx	%0,0,%3		# pte_update\n\
-	andi.	%1,%0,%6\n\
+	and.	%1,%0,%6\n\
 	bne-	1b \n\
 	andc	%1,%0,%4 \n\
 	or	%1,%1,%7\n\
 	stdcx.	%1,0,%3 \n\
 	bne-	1b"
-	: "=&r" (old), "=&r" (tmp), "=m" (*ptep)
-	: "r" (ptep), "r" (clr), "m" (*ptep), "i" (_PAGE_BUSY), "r" (set)
+	: "=&r" (old_be), "=&r" (tmp_be), "=m" (*ptep)
+	: "r" (ptep), "r" (cpu_to_be64(clr)), "m" (*ptep),
+	  "r" (cpu_to_be64(_PAGE_BUSY)), "r" (cpu_to_be64(set))
 	: "cc" );
 	/* huge pages use the old page table lock */
 	if (!huge)
 		assert_pte_locked(mm, addr);
 
+	old = be64_to_cpu(old_be);
 	if (old & _PAGE_HASHPTE)
 		hpte_need_flush(mm, addr, ptep, old, huge);
 
@@ -344,21 +347,22 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
  */
 static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 {
-	unsigned long bits = pte_val(entry) &
-		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC |
-		 _PAGE_SOFT_DIRTY);
+	__be64 old, tmp, val, mask;
+
+	mask = cpu_to_be64(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW |
+			   _PAGE_EXEC | _PAGE_SOFT_DIRTY);
 
-	unsigned long old, tmp;
+	val = pte_raw(entry) & mask;
 
 	__asm__ __volatile__(
 	"1:	ldarx	%0,0,%4\n\
-		andi.	%1,%0,%6\n\
+		and.	%1,%0,%6\n\
 		bne-	1b \n\
 		or	%0,%3,%0\n\
 		stdcx.	%0,0,%4\n\
 		bne-	1b"
 	:"=&r" (old), "=&r" (tmp), "=m" (*ptep)
-	:"r" (bits), "r" (ptep), "m" (*ptep), "i" (_PAGE_BUSY)
+	:"r" (val), "r" (ptep), "m" (*ptep), "r" (cpu_to_be64(_PAGE_BUSY))
 	:"cc");
 }
 
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index ab3d8977bacd..158574d2acf4 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -288,7 +288,11 @@ extern long long virt_phys_offset;
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_PPC_BOOK3S_64
+#include <asm/pgtable-be-types.h>
+#else
 #include <asm/pgtable-types.h>
+#endif
 
 typedef struct { signed long pd; } hugepd_t;
 
diff --git a/arch/powerpc/include/asm/pgtable-be-types.h b/arch/powerpc/include/asm/pgtable-be-types.h
new file mode 100644
index 000000000000..e2bf208605b1
--- /dev/null
+++ b/arch/powerpc/include/asm/pgtable-be-types.h
@@ -0,0 +1,92 @@
+#ifndef _ASM_POWERPC_PGTABLE_BE_TYPES_H
+#define _ASM_POWERPC_PGTABLE_BE_TYPES_H
+
+#include <asm/cmpxchg.h>
+
+/* PTE level */
+typedef struct { __be64 pte; } pte_t;
+#define __pte(x)	((pte_t) { cpu_to_be64(x) })
+static inline unsigned long pte_val(pte_t x)
+{
+	return be64_to_cpu(x.pte);
+}
+
+static inline __be64 pte_raw(pte_t x)
+{
+	return x.pte;
+}
+
+/* PMD level */
+#ifdef CONFIG_PPC64
+typedef struct { __be64 pmd; } pmd_t;
+#define __pmd(x)	((pmd_t) { cpu_to_be64(x) })
+static inline unsigned long pmd_val(pmd_t x)
+{
+	return be64_to_cpu(x.pmd);
+}
+
+static inline __be64 pmd_raw(pmd_t x)
+{
+	return x.pmd;
+}
+
+/*
+ * 64 bit hash always use 4 level table. Everybody else use 4 level
+ * only for 4K page size.
+ */
+#if defined(CONFIG_PPC_BOOK3S_64) || !defined(CONFIG_PPC_64K_PAGES)
+typedef struct { __be64 pud; } pud_t;
+#define __pud(x)	((pud_t) { cpu_to_be64(x) })
+static inline unsigned long pud_val(pud_t x)
+{
+	return be64_to_cpu(x.pud);
+}
+#endif /* CONFIG_PPC_BOOK3S_64 || !CONFIG_PPC_64K_PAGES */
+#endif /* CONFIG_PPC64 */
+
+/* PGD level */
+typedef struct { __be64 pgd; } pgd_t;
+#define __pgd(x)	((pgd_t) { cpu_to_be64(x) })
+static inline unsigned long pgd_val(pgd_t x)
+{
+	return be64_to_cpu(x.pgd);
+}
+
+/* Page protection bits */
+typedef struct { unsigned long pgprot; } pgprot_t;
+#define pgprot_val(x)	((x).pgprot)
+#define __pgprot(x)	((pgprot_t) { (x) })
+
+/*
+ * With hash config 64k pages additionally define a bigger "real PTE" type that
+ * gathers the "second half" part of the PTE for pseudo 64k pages
+ */
+#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
+typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
+#else
+typedef struct { pte_t pte; } real_pte_t;
+#endif
+
+static inline bool pte_xchg(pte_t *ptep, pte_t old, pte_t new)
+{
+	unsigned long *p = (unsigned long *)ptep;
+	__be64 prev;
+
+	prev = (__force __be64)__cmpxchg_u64(p, (__force unsigned long)pte_raw(old),
+					     (__force unsigned long)pte_raw(new));
+
+	return pte_raw(old) == prev;
+}
+
+static inline bool pmd_xchg(pmd_t *pmdp, pmd_t old, pmd_t new)
+{
+	unsigned long *p = (unsigned long *)pmdp;
+	__be64 prev;
+
+	prev = (__force __be64)__cmpxchg_u64(p, (__force unsigned long)pmd_raw(old),
+					     (__force unsigned long)pmd_raw(new));
+
+	return pmd_raw(old) == prev;
+}
+
+#endif /* _ASM_POWERPC_PGTABLE_BE_TYPES_H */
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 6fbf983b3ae5..292f40705674 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -220,7 +220,6 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		    unsigned long vsid, pte_t *ptep, unsigned long trap,
 		    unsigned long flags, int ssize)
 {
-
 	unsigned long hpte_group;
 	unsigned long rflags, pa;
 	unsigned long old_pte, new_pte;
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index eb2accdd76fd..92c3c1858707 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -49,8 +49,8 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		new_pmd = old_pmd | _PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_RW)
 			new_pmd |= _PAGE_DIRTY;
-	} while (old_pmd != __cmpxchg_u64((unsigned long *)pmdp,
-					  old_pmd, new_pmd));
+	} while (!pmd_xchg(pmdp, __pmd(old_pmd), __pmd(new_pmd)));
+
 	rflags = htab_convert_pte_flags(new_pmd);
 
 #if 0
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index cda88b804d21..494fc111ef90 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -515,7 +515,8 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 				  unsigned long set)
 {
 
-	unsigned long old, tmp;
+	__be64 old_be, tmp;
+	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
 	WARN_ON(!pmd_trans_huge(*pmdp));
@@ -524,16 +525,19 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 
 	__asm__ __volatile__(
 	"1:	ldarx	%0,0,%3\n\
-		andi.	%1,%0,%6\n\
+		and.	%1,%0,%6\n\
 		bne-	1b \n\
 		andc	%1,%0,%4 \n\
 		or	%1,%1,%7\n\
 		stdcx.	%1,0,%3 \n\
 		bne-	1b"
-	: "=&r" (old), "=&r" (tmp), "=m" (*pmdp)
-	: "r" (pmdp), "r" (clr), "m" (*pmdp), "i" (_PAGE_BUSY), "r" (set)
+	: "=&r" (old_be), "=&r" (tmp), "=m" (*pmdp)
+	: "r" (pmdp), "r" (cpu_to_be64(clr)), "m" (*pmdp),
+	  "r" (cpu_to_be64(_PAGE_BUSY)), "r" (cpu_to_be64(set))
 	: "cc" );
 
+	old = be64_to_cpu(old_be);
+
 	trace_hugepage_update(addr, old, clr, set);
 	if (old & _PAGE_HASHPTE)
 		hpte_do_hugepage_flush(mm, addr, pmdp, old);
-- 
2.5.0
