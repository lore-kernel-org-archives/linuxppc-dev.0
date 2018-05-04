Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40crzY06tszDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 22:34:00 +1000 (AEST)
Message-Id: <6bfe791e70143f22b3868c9c8c60237de120931e.1525435203.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  03/17] powerpc/nohash: use IS_ENABLED() to simplify
 __set_pte_at()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  4 May 2018 14:33:56 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

By using IS_ENABLED() we can simplify __set_pte_at() by removing
redundant *ptep = pte

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/pgtable.h | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index f2fe3cbe90af..077472640b35 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -148,40 +148,33 @@ extern void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, int percpu)
 {
-#if defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
 	/* Second case is 32-bit with 64-bit PTE.  In this case, we
 	 * can just store as long as we do the two halves in the right order
 	 * with a barrier in between.
 	 * In the percpu case, we also fallback to the simple update
 	 */
-	if (percpu) {
-		*ptep = pte;
+	if (IS_ENABLED(CONFIG_PPC32) && IS_ENABLED(CONFIG_PTE_64BIT) && !percpu) {
+		__asm__ __volatile__("\
+			stw%U0%X0 %2,%0\n\
+			eieio\n\
+			stw%U0%X0 %L2,%1"
+		: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
+		: "r" (pte) : "memory");
 		return;
 	}
-	__asm__ __volatile__("\
-		stw%U0%X0 %2,%0\n\
-		eieio\n\
-		stw%U0%X0 %L2,%1"
-	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
-	: "r" (pte) : "memory");
-
-#else
 	/* Anything else just stores the PTE normally. That covers all 64-bit
 	 * cases, and 32-bit non-hash with 32-bit PTEs.
 	 */
 	*ptep = pte;
 
-#ifdef CONFIG_PPC_BOOK3E_64
 	/*
 	 * With hardware tablewalk, a sync is needed to ensure that
 	 * subsequent accesses see the PTE we just wrote.  Unlike userspace
 	 * mappings, we can't tolerate spurious faults, so make sure
 	 * the new PTE will be seen the first time.
 	 */
-	if (is_kernel_addr(addr))
+	if (IS_ENABLED(CONFIG_PPC_BOOK3E_64) && is_kernel_addr(addr))
 		mb();
-#endif
-#endif
 }
 
 
-- 
2.13.3
