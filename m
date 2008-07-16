Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 464A7DDFAE
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 07:28:16 +1000 (EST)
Date: Wed, 16 Jul 2008 16:24:01 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Fixes for CONFIG_PTE_64BIT for SMP support
Message-ID: <Pine.LNX.4.64.0807161622350.13167@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are some minor issues with support 64-bit PTEs on a 32-bit processor
when dealing with SMP.

* We need to order the stores in set_pte_at to make sure the flag word
  is set second.
* We want to ensure that set_pte_at is always called w/a pte that is not
  valid.  Change kunmap_atomic to always clear the pte.
* Change pte_clear to use pte_update so only the flag word is cleared

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Do we want to unconditionally change kunmap_atomic or not?

- k

 include/asm-powerpc/highmem.h       |    4 ++--
 include/asm-powerpc/pgtable-ppc32.h |   14 ++++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/asm-powerpc/highmem.h b/include/asm-powerpc/highmem.h
index 5d99b64..7f101d1 100644
--- a/include/asm-powerpc/highmem.h
+++ b/include/asm-powerpc/highmem.h
@@ -97,7 +97,6 @@ static inline void *kmap_atomic(struct page *page, enum km_type type)

 static inline void kunmap_atomic(void *kvaddr, enum km_type type)
 {
-#ifdef CONFIG_DEBUG_HIGHMEM
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();

@@ -106,7 +105,9 @@ static inline void kunmap_atomic(void *kvaddr, enum km_type type)
 		return;
 	}

+#ifdef CONFIG_DEBUG_HIGHMEM
 	BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
+#endif

 	/*
 	 * force other mappings to Oops if they'll try to access
@@ -114,7 +115,6 @@ static inline void kunmap_atomic(void *kvaddr, enum km_type type)
 	 */
 	pte_clear(&init_mm, vaddr, kmap_pte-idx);
 	flush_tlb_page(NULL, vaddr);
-#endif
 	pagefault_enable();
 }

diff --git a/include/asm-powerpc/pgtable-ppc32.h b/include/asm-powerpc/pgtable-ppc32.h
index 3a96d00..2436eab 100644
--- a/include/asm-powerpc/pgtable-ppc32.h
+++ b/include/asm-powerpc/pgtable-ppc32.h
@@ -502,7 +502,7 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);

 #define pte_none(pte)		((pte_val(pte) & ~_PTE_NONE_MASK) == 0)
 #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
-#define pte_clear(mm,addr,ptep)	do { set_pte_at((mm), (addr), (ptep), __pte(0)); } while (0)
+#define pte_clear(mm,addr,ptep)	do { pte_update(ptep, ~0, 0); } while (0)

 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
@@ -593,9 +593,6 @@ static inline unsigned long pte_update(pte_t *p,
 	return old;
 }
 #else /* CONFIG_PTE_64BIT */
-/* TODO: Change that to only modify the low word and move set_pte_at()
- * out of line
- */
 static inline unsigned long long pte_update(pte_t *p,
 					    unsigned long clr,
 					    unsigned long set)
@@ -639,8 +636,17 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 #if _PAGE_HASHPTE != 0
 	pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte) & ~_PAGE_HASHPTE);
 #else
+#if defined(CONFIG_PTE_64BIT) && defined(CONFIG_SMP)
+	__asm__ __volatile__("\
+		stw%U0%X0 %2,%0\n\
+		eieio\n\
+		stw%U0%X0 %L2,%1"
+	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
+	: "r" (pte) : "memory");
+#else
 	*ptep = pte;
 #endif
+#endif
 }

 /*
-- 
1.5.5.1
