Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 981F0DDF76
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 08:45:06 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m8IMj2Nh019853
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 17:45:03 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v8 2/4] powerpc: Fixes for CONFIG_PTE_64BIT for SMP support
Date: Thu, 18 Sep 2008 17:44:59 -0500
Message-Id: <1221777901-2967-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1221777901-2967-1-git-send-email-galak@kernel.crashing.org>
References: <1221777901-2967-1-git-send-email-galak@kernel.crashing.org>
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
* Change pte_clear to use pte_update so only the flag word is cleared
* Added a WARN_ON to set_pte_at to ensure the pte isn't present for
  the 64-bit pte/SMP case (to ensure our assumption of this fact).

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
After talking to Ben we decided to go back to the WARN_ON.

- k

 arch/powerpc/include/asm/highmem.h       |    2 +-
 arch/powerpc/include/asm/pgtable-ppc32.h |   25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/highmem.h b/arch/powerpc/include/asm/highmem.h
index 5d99b64..91c5895 100644
--- a/arch/powerpc/include/asm/highmem.h
+++ b/arch/powerpc/include/asm/highmem.h
@@ -84,7 +84,7 @@ static inline void *kmap_atomic_prot(struct page *page, enum km_type type, pgpro
 #ifdef CONFIG_DEBUG_HIGHMEM
 	BUG_ON(!pte_none(*(kmap_pte-idx)));
 #endif
-	set_pte_at(&init_mm, vaddr, kmap_pte-idx, mk_pte(page, prot));
+	__set_pte_at(&init_mm, vaddr, kmap_pte-idx, mk_pte(page, prot));
 	flush_tlb_page(NULL, vaddr);
 
 	return (void*) vaddr;
diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index 6fe39e3..1b4c86d 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -517,7 +517,8 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
 
 #define pte_none(pte)		((pte_val(pte) & ~_PTE_NONE_MASK) == 0)
 #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
-#define pte_clear(mm,addr,ptep)	do { set_pte_at((mm), (addr), (ptep), __pte(0)); } while (0)
+#define pte_clear(mm, addr, ptep) \
+	do { pte_update(ptep, ~_PAGE_HASHPTE, 0); } while (0)
 
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
@@ -612,9 +613,6 @@ static inline unsigned long pte_update(pte_t *p,
 	return old;
 }
 #else /* CONFIG_PTE_64BIT */
-/* TODO: Change that to only modify the low word and move set_pte_at()
- * out of line
- */
 static inline unsigned long long pte_update(pte_t *p,
 					    unsigned long clr,
 					    unsigned long set)
@@ -652,16 +650,33 @@ static inline unsigned long long pte_update(pte_t *p,
  * On machines which use an MMU hash table we avoid changing the
  * _PAGE_HASHPTE bit.
  */
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+
+static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
 #if _PAGE_HASHPTE != 0
 	pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte) & ~_PAGE_HASHPTE);
+#elif defined(CONFIG_PTE_64BIT) && defined(CONFIG_SMP)
+	__asm__ __volatile__("\
+		stw%U0%X0 %2,%0\n\
+		eieio\n\
+		stw%U0%X0 %L2,%1"
+	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
+	: "r" (pte) : "memory");
 #else
 	*ptep = pte;
 #endif
 }
 
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pte)
+{
+#if defined(CONFIG_PTE_64BIT) && define(CONFIG_SMP)
+	WARN_ON(pte_present(*ptep));
+#endif
+	__set_pte_at(mm, addr, ptep, pte);
+}
+
 /*
  * 2.6 calls this without flushing the TLB entry; this is wrong
  * for our hash-based implementation, we fix that up here.
-- 
1.5.5.1
