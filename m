Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 74B5B1A04B8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 14:53:45 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 25 Feb 2016 20:53:43 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2B64E19D8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 20:41:38 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1Q3rft927590842
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 20:53:41 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1Q3reQP015622
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 20:53:41 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH] powerpc/mm: Use big endian page table for book3s 64
Date: Fri, 26 Feb 2016 09:23:34 +0530
Message-Id: <1456458814-7497-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enables us to share the same page table code for
both radix and hash. Radix use a hardware defined big endian
page table

Asm -> C conversion makes it simpler to build code for both little
and big endian page table.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Note:
Any suggestion on how we can do that pte update better so that we can build
a LE and BE page table kernel will be helpful.

 arch/powerpc/include/asm/book3s/64/hash.h   |  75 ++++++++++++--------
 arch/powerpc/include/asm/kvm_book3s_64.h    |  12 ++--
 arch/powerpc/include/asm/page.h             |   4 ++
 arch/powerpc/include/asm/pgtable-be-types.h | 104 ++++++++++++++++++++++++++++
 arch/powerpc/mm/hash64_4k.c                 |   6 +-
 arch/powerpc/mm/hash64_64k.c                |  11 +--
 arch/powerpc/mm/hugepage-hash64.c           |   5 +-
 arch/powerpc/mm/hugetlbpage-hash64.c        |   5 +-
 arch/powerpc/mm/pgtable-hash64.c            |  42 +++++------
 9 files changed, 197 insertions(+), 67 deletions(-)
 create mode 100644 arch/powerpc/include/asm/pgtable-be-types.h

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 9b451cb8294a..9153bda5f395 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -1,6 +1,9 @@
 #ifndef _ASM_POWERPC_BOOK3S_64_HASH_H
 #define _ASM_POWERPC_BOOK3S_64_HASH_H
 #ifdef __KERNEL__
+#ifndef __ASSEMBLY__
+#include <asm/cmpxchg.h>
+#endif
 
 /*
  * Common bits between 4K and 64K pages in a linux-style PTE.
@@ -249,27 +252,35 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 				       unsigned long set,
 				       int huge)
 {
-	unsigned long old, tmp;
-
-	__asm__ __volatile__(
-	"1:	ldarx	%0,0,%3		# pte_update\n\
-	andi.	%1,%0,%6\n\
-	bne-	1b \n\
-	andc	%1,%0,%4 \n\
-	or	%1,%1,%7\n\
-	stdcx.	%1,0,%3 \n\
-	bne-	1b"
-	: "=&r" (old), "=&r" (tmp), "=m" (*ptep)
-	: "r" (ptep), "r" (clr), "m" (*ptep), "i" (_PAGE_BUSY), "r" (set)
-	: "cc" );
+	pte_t pte;
+	unsigned long old_pte, new_pte;
+
+	do {
+reload:
+		pte = READ_ONCE(*ptep);
+		old_pte = pte_val(pte);
+
+		/* If PTE busy, retry */
+		if (unlikely(old_pte & _PAGE_BUSY))
+			goto reload;
+		/*
+		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
+		 * a write access. Since this is 4K insert of 64K page size
+		 * also add _PAGE_COMBO
+		 */
+		new_pte = (old_pte | set) & ~clr;
+
+	} while (cpu_to_be64(old_pte) != __cmpxchg_u64((unsigned long *)ptep,
+						   cpu_to_be64(old_pte),
+						   cpu_to_be64(new_pte)));
 	/* huge pages use the old page table lock */
 	if (!huge)
 		assert_pte_locked(mm, addr);
 
-	if (old & _PAGE_HASHPTE)
-		hpte_need_flush(mm, addr, ptep, old, huge);
+	if (old_pte & _PAGE_HASHPTE)
+		hpte_need_flush(mm, addr, ptep, old_pte, huge);
 
-	return old;
+	return old_pte;
 }
 
 /*
@@ -317,22 +328,30 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
  */
 static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 {
+	pte_t pte;
+	unsigned long old_pte, new_pte;
 	unsigned long bits = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC |
 		 _PAGE_SOFT_DIRTY);
 
-	unsigned long old, tmp;
-
-	__asm__ __volatile__(
-	"1:	ldarx	%0,0,%4\n\
-		andi.	%1,%0,%6\n\
-		bne-	1b \n\
-		or	%0,%3,%0\n\
-		stdcx.	%0,0,%4\n\
-		bne-	1b"
-	:"=&r" (old), "=&r" (tmp), "=m" (*ptep)
-	:"r" (bits), "r" (ptep), "m" (*ptep), "i" (_PAGE_BUSY)
-	:"cc");
+	do {
+reload:
+		pte = READ_ONCE(*ptep);
+		old_pte = pte_val(pte);
+
+		/* If PTE busy, retry */
+		if (unlikely(old_pte & _PAGE_BUSY))
+			goto reload;
+		/*
+		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
+		 * a write access. Since this is 4K insert of 64K page size
+		 * also add _PAGE_COMBO
+		 */
+		new_pte = old_pte | bits;
+
+	} while (cpu_to_be64(old_pte) != __cmpxchg_u64((unsigned long *)ptep,
+						       cpu_to_be64(old_pte),
+						       cpu_to_be64(new_pte)));
 }
 
 static inline int pgd_bad(pgd_t pgd)
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 2aa79c864e91..508c3741fd6f 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -299,6 +299,7 @@ static inline int hpte_cache_flags_ok(unsigned long ptel, unsigned long io_type)
  */
 static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing)
 {
+	unsigned long old_ptev;
 	pte_t old_pte, new_pte = __pte(0);
 
 	while (1) {
@@ -306,24 +307,25 @@ static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing)
 		 * Make sure we don't reload from ptep
 		 */
 		old_pte = READ_ONCE(*ptep);
+		old_ptev = pte_val(old_pte);
 		/*
 		 * wait until _PAGE_BUSY is clear then set it atomically
 		 */
-		if (unlikely(pte_val(old_pte) & _PAGE_BUSY)) {
+		if (unlikely(old_ptev & _PAGE_BUSY)) {
 			cpu_relax();
 			continue;
 		}
 		/* If pte is not present return None */
-		if (unlikely(!(pte_val(old_pte) & _PAGE_PRESENT)))
+		if (unlikely(!(old_ptev & _PAGE_PRESENT)))
 			return __pte(0);
 
 		new_pte = pte_mkyoung(old_pte);
 		if (writing && pte_write(old_pte))
 			new_pte = pte_mkdirty(new_pte);
 
-		if (pte_val(old_pte) == __cmpxchg_u64((unsigned long *)ptep,
-						      pte_val(old_pte),
-						      pte_val(new_pte))) {
+		if (cpu_to_be64(old_ptev) == __cmpxchg_u64((unsigned long *)ptep,
+							   cpu_to_be64(old_ptev),
+							   cpu_to_be64(pte_val(new_pte)))) {
 			break;
 		}
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
index 000000000000..20527200d6ae
--- /dev/null
+++ b/arch/powerpc/include/asm/pgtable-be-types.h
@@ -0,0 +1,104 @@
+#ifndef _ASM_POWERPC_PGTABLE_BE_TYPES_H
+#define _ASM_POWERPC_PGTABLE_BE_TYPES_H
+
+#ifdef CONFIG_STRICT_MM_TYPECHECKS
+/* These are used to make use of C type-checking. */
+
+/* PTE level */
+typedef struct { __be64 pte; } pte_t;
+#define __pte(x)	((pte_t) { cpu_to_be64(x) })
+static inline unsigned long pte_val(pte_t x)
+{
+	return be64_to_cpu(x.pte);
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
+#else
+
+/*
+ * .. while these make it easier on the compiler
+ */
+
+typedef __be64 pte_t;
+#define __pte(x)	cpu_to_be64(x)
+static inline unsigned long pte_val(pte_t pte)
+{
+	return be64_to_cpu(pte);
+}
+
+#ifdef CONFIG_PPC64
+typedef __be64 pmd_t;
+#define __pmd(x)	cpu_to_be64(x)
+static inline unsigned long pmd_val(pmd_t pmd)
+{
+	return be64_to_cpu(pmd);
+}
+
+#if defined(CONFIG_PPC_BOOK3S_64) || !defined(CONFIG_PPC_64K_PAGES)
+typedef __be64 pud_t;
+#define __pud(x)	cpu_to_be64(x)
+static inline unsigned long pud_val(pud_t pud)
+{
+	return be64_to_cpu(pud);
+}
+#endif /* CONFIG_PPC_BOOK3S_64 || !CONFIG_PPC_64K_PAGES */
+#endif /* CONFIG_PPC64 */
+
+typedef __be64 pgd_t;
+#define __pgd(x)	cpu_to_be64(x)
+static inline unsigned long pgd_val(pgd_t pgd)
+{
+	return be64_to_cpu(pgd);
+}
+
+typedef unsigned long pgprot_t;
+#define pgprot_val(x)	(x)
+#define __pgprot(x)	(x)
+
+#endif /* CONFIG_STRICT_MM_TYPECHECKS */
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
+#endif /* _ASM_POWERPC_PGTABLE_TYPES_H */
diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index 47d1b26effc6..1a862eb6fef1 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -47,8 +47,10 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
-	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
-					  old_pte, new_pte));
+
+	} while (cpu_to_be64(old_pte) != __cmpxchg_u64((unsigned long *)ptep,
+						       cpu_to_be64(old_pte),
+						       cpu_to_be64(new_pte)));
 	/*
 	 * PP bits. _PAGE_USER is already PP bit 0x2, so we only
 	 * need to add in 0x1 if it's a read-only user page
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index b2d659cf51c6..976eb5f6e492 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -79,8 +79,9 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_COMBO;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
-	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
-					  old_pte, new_pte));
+	} while (cpu_to_be64(old_pte) != __cmpxchg_u64((unsigned long *)ptep,
+						       cpu_to_be64(old_pte),
+						       cpu_to_be64(new_pte)));
 	/*
 	 * Handle the subpage protection bits
 	 */
@@ -254,9 +255,9 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
-	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
-					  old_pte, new_pte));
-
+	} while (cpu_to_be64(old_pte) != __cmpxchg_u64((unsigned long *)ptep,
+						       cpu_to_be64(old_pte),
+						       cpu_to_be64(new_pte)));
 	rflags = htab_convert_pte_flags(new_pte);
 
 	if (!cpu_has_feature(CPU_FTR_NOEXECUTE) &&
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index eb2accdd76fd..d9675f1d606e 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -49,8 +49,9 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		new_pmd = old_pmd | _PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_RW)
 			new_pmd |= _PAGE_DIRTY;
-	} while (old_pmd != __cmpxchg_u64((unsigned long *)pmdp,
-					  old_pmd, new_pmd));
+	} while (cpu_to_be64(old_pmd) != __cmpxchg_u64((unsigned long *)pmdp,
+						       cpu_to_be64(old_pmd),
+						       cpu_to_be64(new_pmd)));
 	rflags = htab_convert_pte_flags(new_pmd);
 
 #if 0
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index db17ff3f4864..0a1f87ffde8c 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -68,8 +68,9 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
-	} while(old_pte != __cmpxchg_u64((unsigned long *)ptep,
-					 old_pte, new_pte));
+	} while(cpu_to_be64(old_pte) != __cmpxchg_u64((unsigned long *)ptep,
+						      cpu_to_be64(old_pte),
+						      cpu_to_be64(new_pte)));
 	rflags = htab_convert_pte_flags(new_pte);
 
 	sz = ((1UL) << shift);
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index cbd81345fdec..b5e7e8efef1e 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -281,34 +281,30 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 				  pmd_t *pmdp, unsigned long clr,
 				  unsigned long set)
 {
-
-	unsigned long old, tmp;
+	pmd_t pmd;
+	unsigned long old_pmd, new_pmd;
 
 #ifdef CONFIG_DEBUG_VM
 	WARN_ON(!pmd_trans_huge(*pmdp));
 	assert_spin_locked(&mm->page_table_lock);
 #endif
-
-#ifdef PTE_ATOMIC_UPDATES
-	__asm__ __volatile__(
-	"1:	ldarx	%0,0,%3\n\
-		andi.	%1,%0,%6\n\
-		bne-	1b \n\
-		andc	%1,%0,%4 \n\
-		or	%1,%1,%7\n\
-		stdcx.	%1,0,%3 \n\
-		bne-	1b"
-	: "=&r" (old), "=&r" (tmp), "=m" (*pmdp)
-	: "r" (pmdp), "r" (clr), "m" (*pmdp), "i" (_PAGE_BUSY), "r" (set)
-	: "cc" );
-#else
-	old = pmd_val(*pmdp);
-	*pmdp = __pmd((old & ~clr) | set);
-#endif
-	trace_hugepage_update(addr, old, clr, set);
-	if (old & _PAGE_HASHPTE)
-		hpte_do_hugepage_flush(mm, addr, pmdp, old);
-	return old;
+	do {
+reload:
+		pmd = READ_ONCE(*pmdp);
+		old_pmd = pmd_val(pmd);
+
+		/* If PTE busy, retry */
+		if (unlikely(old_pmd & _PAGE_BUSY))
+			goto reload;
+		new_pmd = (old_pmd | set) & ~clr;
+
+	} while (cpu_to_be64(old_pmd) != __cmpxchg_u64((unsigned long *)pmdp,
+						       cpu_to_be64(old_pmd),
+						       cpu_to_be64(new_pmd)));
+	trace_hugepage_update(addr, old_pmd, clr, set);
+	if (old_pmd & _PAGE_HASHPTE)
+		hpte_do_hugepage_flush(mm, addr, pmdp, old_pmd);
+	return old_pmd;
 }
 
 pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
-- 
2.5.0
