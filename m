Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id 201ED2C0128
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 02:44:47 +1000 (EST)
Date: Wed, 11 Sep 2013 18:44:44 +0200
Message-Id: <201309111644.r8BGiixj016314@localhost.localdomain>
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc 8xx: Reverting commit
 e0908085fc2391c85b85fb814ae1df377c8e0dcb which has become useless
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The commit e0908085fc2391c85b85fb814ae1df377c8e0dcb is not needed anymore.
The issue was because dcbst wrongly sets the store bit when causing a DTLB
error, but this is now fixed by commit 0a2ab51ffb8dfdf51402dcfb446629648c96bc78
which handles the buggy dcbx instructions on data page faults on the 8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

diff -ur linux-3.11.org/arch/powerpc/mm/pgtable.c linux-3.11/arch/powerpc/mm/pgtable.c
--- linux-3.11.org/arch/powerpc/mm/pgtable.c	2013-09-02 22:46:10.000000000 +0200
+++ linux-3.11/arch/powerpc/mm/pgtable.c	2013-09-09 11:25:57.000000000 +0200
@@ -32,8 +32,6 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 
-#include "mmu_decl.h"
-
 static inline int is_exec_fault(void)
 {
 	return current->thread.regs && TRAP(current->thread.regs) == 0x400;
@@ -72,7 +70,7 @@
  * support falls into the same category.
  */
 
-static pte_t set_pte_filter(pte_t pte, unsigned long addr)
+static pte_t set_pte_filter(pte_t pte)
 {
 	pte = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
 	if (pte_looks_normal(pte) && !(cpu_has_feature(CPU_FTR_COHERENT_ICACHE) ||
@@ -81,17 +79,6 @@
 		if (!pg)
 			return pte;
 		if (!test_bit(PG_arch_1, &pg->flags)) {
-#ifdef CONFIG_8xx
-			/* On 8xx, cache control instructions (particularly
-			 * "dcbst" from flush_dcache_icache) fault as write
-			 * operation if there is an unpopulated TLB entry
-			 * for the address in question. To workaround that,
-			 * we invalidate the TLB here, thus avoiding dcbst
-			 * misbehaviour.
-			 */
-			/* 8xx doesn't care about PID, size or ind args */
-			_tlbil_va(addr, 0, 0, 0);
-#endif /* CONFIG_8xx */
 			flush_dcache_icache_page(pg);
 			set_bit(PG_arch_1, &pg->flags);
 		}
@@ -111,7 +98,7 @@
  * as we don't have two bits to spare for _PAGE_EXEC and _PAGE_HWEXEC so
  * instead we "filter out" the exec permission for non clean pages.
  */
-static pte_t set_pte_filter(pte_t pte, unsigned long addr)
+static pte_t set_pte_filter(pte_t pte)
 {
 	struct page *pg;
 
@@ -193,7 +180,7 @@
 	 * this context might not have been activated yet when this
 	 * is called.
 	 */
-	pte = set_pte_filter(pte, addr);
+	pte = set_pte_filter(pte);
 
 	/* Perform the setting of the PTE */
 	__set_pte_at(mm, addr, ptep, pte, 0);
Only in linux-3.11/arch/powerpc/mm/: pgtable.c.orig
