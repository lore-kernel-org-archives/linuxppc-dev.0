Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF6BD474E1
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 04:09:09 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m83I96N4019156
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Sep 2008 13:09:06 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 2/4] powerpc: Fixes for CONFIG_PTE_64BIT for SMP support
Date: Wed,  3 Sep 2008 13:09:02 -0500
Message-Id: <1220465344-16753-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1220465344-16753-1-git-send-email-galak@kernel.crashing.org>
References: <1220465344-16753-1-git-send-email-galak@kernel.crashing.org>
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

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Fixed pte_clear to not break on 6xx.

- k

 arch/powerpc/include/asm/pgtable-ppc32.h |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index 6fe39e3..dff1b7e 100644
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
@@ -658,8 +656,17 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
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
