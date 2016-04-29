Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDy43NjkzDqBC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 29/70] powerpc/mm/radix: Add radix pte #defines
Date: Fri, 29 Apr 2016 23:25:52 +1000
Message-Id: <1461936393-10131-29-git-send-email-mpe@ellerman.id.au>
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

This adds Power ISA 3.0 specific pte defines. We share most of the
details with hash Linux page table format. This patch indicates only
things where we differ.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h   |   1 +
 arch/powerpc/include/asm/book3s/64/radix-4k.h  |  12 +++
 arch/powerpc/include/asm/book3s/64/radix-64k.h |  12 +++
 arch/powerpc/include/asm/book3s/64/radix.h     | 125 +++++++++++++++++++++++++
 4 files changed, 150 insertions(+)
 create mode 100644 arch/powerpc/include/asm/book3s/64/radix-4k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/radix-64k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/radix.h

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 2643487affac..c47c3f7fc4e0 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -205,6 +205,7 @@ extern unsigned long __pgd_table_size;
 #endif /* __ASSEMBLY__ */
 
 #include <asm/book3s/64/hash.h>
+#include <asm/book3s/64/radix.h>
 #include <asm/barrier.h>
 
 /*
diff --git a/arch/powerpc/include/asm/book3s/64/radix-4k.h b/arch/powerpc/include/asm/book3s/64/radix-4k.h
new file mode 100644
index 000000000000..7c3b1fe1619e
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/radix-4k.h
@@ -0,0 +1,12 @@
+#ifndef _ASM_POWERPC_PGTABLE_RADIX_4K_H
+#define _ASM_POWERPC_PGTABLE_RADIX_4K_H
+
+/*
+ * For 4K page size supported index is 13/9/9/9
+ */
+#define RADIX_PTE_INDEX_SIZE  9  /* 2MB huge page */
+#define RADIX_PMD_INDEX_SIZE  9  /* 1G huge page */
+#define RADIX_PUD_INDEX_SIZE	 9
+#define RADIX_PGD_INDEX_SIZE  13
+
+#endif /* _ASM_POWERPC_PGTABLE_RADIX_4K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/radix-64k.h b/arch/powerpc/include/asm/book3s/64/radix-64k.h
new file mode 100644
index 000000000000..82dc355f0b45
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/radix-64k.h
@@ -0,0 +1,12 @@
+#ifndef _ASM_POWERPC_PGTABLE_RADIX_64K_H
+#define _ASM_POWERPC_PGTABLE_RADIX_64K_H
+
+/*
+ * For 64K page size supported index is 13/9/9/5
+ */
+#define RADIX_PTE_INDEX_SIZE  5  /* 2MB huge page */
+#define RADIX_PMD_INDEX_SIZE  9  /* 1G huge page */
+#define RADIX_PUD_INDEX_SIZE	 9
+#define RADIX_PGD_INDEX_SIZE  13
+
+#endif /* _ASM_POWERPC_PGTABLE_RADIX_64K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
new file mode 100644
index 000000000000..4b581a0ebc0a
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -0,0 +1,125 @@
+#ifndef _ASM_POWERPC_PGTABLE_RADIX_H
+#define _ASM_POWERPC_PGTABLE_RADIX_H
+
+#ifndef __ASSEMBLY__
+#include <asm/cmpxchg.h>
+#endif
+
+#ifdef CONFIG_PPC_64K_PAGES
+#include <asm/book3s/64/radix-64k.h>
+#else
+#include <asm/book3s/64/radix-4k.h>
+#endif
+
+/* An empty PTE can still have a R or C writeback */
+#define RADIX_PTE_NONE_MASK		(_PAGE_DIRTY | _PAGE_ACCESSED)
+
+/* Bits to set in a RPMD/RPUD/RPGD */
+#define RADIX_PMD_VAL_BITS		(0x8000000000000000UL | RADIX_PTE_INDEX_SIZE)
+#define RADIX_PUD_VAL_BITS		(0x8000000000000000UL | RADIX_PMD_INDEX_SIZE)
+#define RADIX_PGD_VAL_BITS		(0x8000000000000000UL | RADIX_PUD_INDEX_SIZE)
+
+/* Don't have anything in the reserved bits and leaf bits */
+#define RADIX_PMD_BAD_BITS		0x60000000000000e0UL
+#define RADIX_PUD_BAD_BITS		0x60000000000000e0UL
+#define RADIX_PGD_BAD_BITS		0x60000000000000e0UL
+
+/*
+ * Size of EA range mapped by our pagetables.
+ */
+#define RADIX_PGTABLE_EADDR_SIZE (RADIX_PTE_INDEX_SIZE + RADIX_PMD_INDEX_SIZE +	\
+			      RADIX_PUD_INDEX_SIZE + RADIX_PGD_INDEX_SIZE + PAGE_SHIFT)
+#define RADIX_PGTABLE_RANGE (ASM_CONST(1) << RADIX_PGTABLE_EADDR_SIZE)
+
+#ifndef __ASSEMBLY__
+#define RADIX_PTE_TABLE_SIZE	(sizeof(pte_t) << RADIX_PTE_INDEX_SIZE)
+#define RADIX_PMD_TABLE_SIZE	(sizeof(pmd_t) << RADIX_PMD_INDEX_SIZE)
+#define RADIX_PUD_TABLE_SIZE	(sizeof(pud_t) << RADIX_PUD_INDEX_SIZE)
+#define RADIX_PGD_TABLE_SIZE	(sizeof(pgd_t) << RADIX_PGD_INDEX_SIZE)
+
+static inline unsigned long radix__pte_update(struct mm_struct *mm,
+					unsigned long addr,
+					pte_t *ptep, unsigned long clr,
+					unsigned long set,
+					int huge)
+{
+	pte_t pte;
+	unsigned long old_pte, new_pte;
+
+	do {
+		pte = READ_ONCE(*ptep);
+		old_pte = pte_val(pte);
+		new_pte = (old_pte | set) & ~clr;
+
+	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
+
+	/* We already do a sync in cmpxchg, is ptesync needed ?*/
+	asm volatile("ptesync" : : : "memory");
+	/* huge pages use the old page table lock */
+	if (!huge)
+		assert_pte_locked(mm, addr);
+
+	return old_pte;
+}
+
+/*
+ * Set the dirty and/or accessed bits atomically in a linux PTE, this
+ * function doesn't need to invalidate tlb.
+ */
+static inline void radix__ptep_set_access_flags(pte_t *ptep, pte_t entry)
+{
+	pte_t pte;
+	unsigned long old_pte, new_pte;
+	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
+					      _PAGE_RW | _PAGE_EXEC);
+	do {
+		pte = READ_ONCE(*ptep);
+		old_pte = pte_val(pte);
+		new_pte = old_pte | set;
+
+	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
+
+	/* We already do a sync in cmpxchg, is ptesync needed ?*/
+	asm volatile("ptesync" : : : "memory");
+}
+
+static inline int radix__pte_same(pte_t pte_a, pte_t pte_b)
+{
+	return ((pte_raw(pte_a) ^ pte_raw(pte_b)) == 0);
+}
+
+static inline int radix__pte_none(pte_t pte)
+{
+	return (pte_val(pte) & ~RADIX_PTE_NONE_MASK) == 0;
+}
+
+static inline void radix__set_pte_at(struct mm_struct *mm, unsigned long addr,
+				 pte_t *ptep, pte_t pte, int percpu)
+{
+	*ptep = pte;
+	asm volatile("ptesync" : : : "memory");
+}
+
+static inline int radix__pmd_bad(pmd_t pmd)
+{
+	return !!(pmd_val(pmd) & RADIX_PMD_BAD_BITS);
+}
+
+static inline int radix__pmd_same(pmd_t pmd_a, pmd_t pmd_b)
+{
+	return ((pmd_raw(pmd_a) ^ pmd_raw(pmd_b)) == 0);
+}
+
+static inline int radix__pud_bad(pud_t pud)
+{
+	return !!(pud_val(pud) & RADIX_PUD_BAD_BITS);
+}
+
+
+static inline int radix__pgd_bad(pgd_t pgd)
+{
+	return !!(pgd_val(pgd) & RADIX_PGD_BAD_BITS);
+}
+
+#endif /* __ASSEMBLY__ */
+#endif
-- 
2.5.0
