Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDxd2P24zDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:26:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 03/70] powerpc/mm: Drop PTE_ATOMIC_UPDATES from
 pmd_hugepage_update()
Date: Fri, 29 Apr 2016 23:25:26 +1000
Message-Id: <1461936393-10131-3-git-send-email-mpe@ellerman.id.au>
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

pmd_hugepage_update() is inside #ifdef CONFIG_TRANSPARENT_HUGEPAGE. THP
can only be enabled if PPC_BOOK3S_64=y && PPC_64K_PAGES=y, aka. hash64.

On hash64 we always define PTE_ATOMIC_UPDATES to 1, meaning the #ifdef
in pmd_hugepage_update() is unnecessary, so drop it.

That is also the only use of PTE_ATOMIC_UPDATES in any of the hash code,
meaning we no longer need to #define it at all in the hash headers.

Note it's still #defined and used in the nohash code.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/32/hash.h | 3 ---
 arch/powerpc/include/asm/book3s/64/hash.h | 2 --
 arch/powerpc/mm/pgtable_64.c              | 6 +-----
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/hash.h b/arch/powerpc/include/asm/book3s/32/hash.h
index 264b754d65b0..880db13a2e9f 100644
--- a/arch/powerpc/include/asm/book3s/32/hash.h
+++ b/arch/powerpc/include/asm/book3s/32/hash.h
@@ -39,8 +39,5 @@
 #define _PMD_PRESENT_MASK (PAGE_MASK)
 #define _PMD_BAD	(~PAGE_MASK)
 
-/* Hash table based platforms need atomic updates of the linux PTE */
-#define PTE_ATOMIC_UPDATES	1
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_BOOK3S_32_HASH_H */
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index d0ee6fcef823..8f2ae0674be9 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -127,8 +127,6 @@
 #define _PTEIDX_SECONDARY	0x8
 #define _PTEIDX_GROUP_IX	0x7
 
-/* Hash table based platforms need atomic updates of the linux PTE */
-#define PTE_ATOMIC_UPDATES	1
 #define _PTE_NONE_MASK	_PAGE_HPTEFLAGS
 /*
  * The mask convered by the RPN must be a ULL on 32-bit platforms with
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 347106080bb1..cda88b804d21 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -522,7 +522,6 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 	assert_spin_locked(&mm->page_table_lock);
 #endif
 
-#ifdef PTE_ATOMIC_UPDATES
 	__asm__ __volatile__(
 	"1:	ldarx	%0,0,%3\n\
 		andi.	%1,%0,%6\n\
@@ -534,10 +533,7 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 	: "=&r" (old), "=&r" (tmp), "=m" (*pmdp)
 	: "r" (pmdp), "r" (clr), "m" (*pmdp), "i" (_PAGE_BUSY), "r" (set)
 	: "cc" );
-#else
-	old = pmd_val(*pmdp);
-	*pmdp = __pmd((old & ~clr) | set);
-#endif
+
 	trace_hugepage_update(addr, old, clr, set);
 	if (old & _PAGE_HASHPTE)
 		hpte_do_hugepage_flush(mm, addr, pmdp, old);
-- 
2.5.0
