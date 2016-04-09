Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmJ81BVhzDqFq
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:14:31 +1000 (AEST)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 00:14:30 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 8A38719D8040
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 00:02:20 -0600 (MDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396ERTn37421310
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:14:27 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396ERom006906
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:14:27 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 04/68] powerpc/mm: Use big endian page table for book3s 64
Date: Sat,  9 Apr 2016 11:43:00 +0530
Message-Id: <1460182444-2468-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h   |  16 +++--
 arch/powerpc/include/asm/kvm_book3s_64.h    |  13 ++--
 arch/powerpc/include/asm/page.h             |   4 ++
 arch/powerpc/include/asm/pgtable-be-types.h | 104 ++++++++++++++++++++++++++++
 arch/powerpc/mm/hash64_4k.c                 |   7 +-
 arch/powerpc/mm/hash64_64k.c                |  14 ++--
 arch/powerpc/mm/hugepage-hash64.c           |   7 +-
 arch/powerpc/mm/hugetlbpage-hash64.c        |   7 +-
 arch/powerpc/mm/pgtable_64.c                |   9 ++-
 9 files changed, 159 insertions(+), 22 deletions(-)
 create mode 100644 arch/powerpc/include/asm/pgtable-be-types.h

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index d0ee6fcef823..2113de051824 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -250,22 +250,27 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 				       int huge)
 {
 	unsigned long old, tmp;
+	unsigned long busy = cpu_to_be64(_PAGE_BUSY);
+
+	clr = cpu_to_be64(clr);
+	set = cpu_to_be64(set);
 
 	__asm__ __volatile__(
 	"1:	ldarx	%0,0,%3		# pte_update\n\
-	andi.	%1,%0,%6\n\
+	and.	%1,%0,%6\n\
 	bne-	1b \n\
 	andc	%1,%0,%4 \n\
 	or	%1,%1,%7\n\
 	stdcx.	%1,0,%3 \n\
 	bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*ptep)
-	: "r" (ptep), "r" (clr), "m" (*ptep), "i" (_PAGE_BUSY), "r" (set)
+	: "r" (ptep), "r" (clr), "m" (*ptep), "r" (busy), "r" (set)
 	: "cc" );
 	/* huge pages use the old page table lock */
 	if (!huge)
 		assert_pte_locked(mm, addr);
 
+	old = be64_to_cpu(old);
 	if (old & _PAGE_HASHPTE)
 		hpte_need_flush(mm, addr, ptep, old, huge);
 
@@ -351,16 +356,19 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 		 _PAGE_SOFT_DIRTY);
 
 	unsigned long old, tmp;
+	unsigned long busy = cpu_to_be64(_PAGE_BUSY);
+
+	bits = cpu_to_be64(bits);
 
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
+	:"r" (bits), "r" (ptep), "m" (*ptep), "r" (busy)
 	:"cc");
 }
 
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 2aa79c864e91..f9a7a89a3e4f 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -299,6 +299,8 @@ static inline int hpte_cache_flags_ok(unsigned long ptel, unsigned long io_type)
  */
 static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing)
 {
+	__be64 opte, npte;
+	unsigned long old_ptev;
 	pte_t old_pte, new_pte = __pte(0);
 
 	while (1) {
@@ -306,24 +308,25 @@ static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing)
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
+		npte = cpu_to_be64(pte_val(new_pte));
+		opte = cpu_to_be64(old_ptev);
+		if (opte == __cmpxchg_u64((unsigned long *)ptep, opte, npte)) {
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
index 47d1b26effc6..71abd4c44c27 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -20,6 +20,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		   pte_t *ptep, unsigned long trap, unsigned long flags,
 		   int ssize, int subpg_prot)
 {
+	__be64 opte, npte;
 	unsigned long hpte_group;
 	unsigned long rflags, pa;
 	unsigned long old_pte, new_pte;
@@ -47,8 +48,10 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
-	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
-					  old_pte, new_pte));
+
+		opte = cpu_to_be64(old_pte);
+		npte = cpu_to_be64(new_pte);
+	} while (opte != __cmpxchg_u64((unsigned long *)ptep, opte, npte));
 	/*
 	 * PP bits. _PAGE_USER is already PP bit 0x2, so we only
 	 * need to add in 0x1 if it's a read-only user page
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index b2d659cf51c6..6f9b3c34a5c0 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -49,6 +49,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		   pte_t *ptep, unsigned long trap, unsigned long flags,
 		   int ssize, int subpg_prot)
 {
+	__be64 opte, npte;
 	real_pte_t rpte;
 	unsigned long *hidxp;
 	unsigned long hpte_group;
@@ -79,8 +80,10 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_COMBO;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
-	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
-					  old_pte, new_pte));
+
+		opte = cpu_to_be64(old_pte);
+		npte = cpu_to_be64(new_pte);
+	} while (opte != __cmpxchg_u64((unsigned long *)ptep, opte, npte));
 	/*
 	 * Handle the subpage protection bits
 	 */
@@ -220,7 +223,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		    unsigned long vsid, pte_t *ptep, unsigned long trap,
 		    unsigned long flags, int ssize)
 {
-
+	__be64 opte, npte;
 	unsigned long hpte_group;
 	unsigned long rflags, pa;
 	unsigned long old_pte, new_pte;
@@ -254,8 +257,9 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
-	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
-					  old_pte, new_pte));
+		opte = cpu_to_be64(old_pte);
+		npte = cpu_to_be64(new_pte);
+	} while (opte != __cmpxchg_u64((unsigned long *)ptep, opte, npte));
 
 	rflags = htab_convert_pte_flags(new_pte);
 
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index eb2accdd76fd..98891139c044 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -22,6 +22,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		    pmd_t *pmdp, unsigned long trap, unsigned long flags,
 		    int ssize, unsigned int psize)
 {
+	__be64 opmd, npmd;
 	unsigned int index, valid;
 	unsigned char *hpte_slot_array;
 	unsigned long rflags, pa, hidx;
@@ -49,8 +50,10 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		new_pmd = old_pmd | _PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_RW)
 			new_pmd |= _PAGE_DIRTY;
-	} while (old_pmd != __cmpxchg_u64((unsigned long *)pmdp,
-					  old_pmd, new_pmd));
+		opmd = cpu_to_be64(old_pmd);
+		npmd = cpu_to_be64(new_pmd);
+	} while (opmd != __cmpxchg_u64((unsigned long *)pmdp, opmd, npmd));
+
 	rflags = htab_convert_pte_flags(new_pmd);
 
 #if 0
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 8555fce902fe..5bcb28606158 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -22,6 +22,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		     pte_t *ptep, unsigned long trap, unsigned long flags,
 		     int ssize, unsigned int shift, unsigned int mmu_psize)
 {
+	__be64 opte, npte;
 	unsigned long vpn;
 	unsigned long old_pte, new_pte;
 	unsigned long rflags, pa, sz;
@@ -57,8 +58,10 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
-	} while(old_pte != __cmpxchg_u64((unsigned long *)ptep,
-					 old_pte, new_pte));
+		opte = cpu_to_be64(old_pte);
+		npte = cpu_to_be64(new_pte);
+	} while (opte != __cmpxchg_u64((unsigned long *)ptep, opte, npte));
+
 	rflags = htab_convert_pte_flags(new_pte);
 
 	sz = ((1UL) << shift);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 0eb53128ca2a..aa742aa35b64 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -516,6 +516,7 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 {
 
 	unsigned long old, tmp;
+	unsigned long busy = cpu_to_be64(_PAGE_BUSY);
 
 #ifdef CONFIG_DEBUG_VM
 	WARN_ON(!pmd_trans_huge(*pmdp));
@@ -523,17 +524,21 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 #endif
 
 #ifdef PTE_ATOMIC_UPDATES
+	clr = cpu_to_be64(clr);
+	set = cpu_to_be64(set);
 	__asm__ __volatile__(
 	"1:	ldarx	%0,0,%3\n\
-		andi.	%1,%0,%6\n\
+		and.	%1,%0,%6\n\
 		bne-	1b \n\
 		andc	%1,%0,%4 \n\
 		or	%1,%1,%7\n\
 		stdcx.	%1,0,%3 \n\
 		bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*pmdp)
-	: "r" (pmdp), "r" (clr), "m" (*pmdp), "i" (_PAGE_BUSY), "r" (set)
+	: "r" (pmdp), "r" (clr), "m" (*pmdp), "r" (busy), "r" (set)
 	: "cc" );
+
+	old = be64_to_cpu(old);
 #else
 	old = pmd_val(*pmdp);
 	*pmdp = __pmd((old & ~clr) | set);
-- 
2.5.0
