Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmMG4860zDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:17:14 +1000 (AEST)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 02:17:12 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C7758C90043
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 02:17:04 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396H9QQ34930854
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:17:09 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396H9AB018788
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:17:09 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 62/68] powerpc/mm: Drop PTE_ATOMIC_UPDATES from
 pmd_hugepage_update
Date: Sat,  9 Apr 2016 11:43:58 +0530
Message-Id: <1460182444-2468-63-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

THP is only supported by hash64 now and for that we should always
have PTE_ATOMIC_UPDATES always set. Drop the unnecessary #ifdef
in the code.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable_64.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 0e980204c4d5..092c07115612 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -475,7 +475,6 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 	assert_spin_locked(&mm->page_table_lock);
 #endif
 
-#ifdef PTE_ATOMIC_UPDATES
 	clr = cpu_to_be64(clr);
 	set = cpu_to_be64(set);
 	__asm__ __volatile__(
@@ -491,10 +490,7 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 	: "cc" );
 
 	old = be64_to_cpu(old);
-#else
-	old = pmd_val(*pmdp);
-	*pmdp = __pmd((old & ~clr) | set);
-#endif
+
 	trace_hugepage_update(addr, old, clr, set);
 	if (old & H_PAGE_HASHPTE)
 		hpte_do_hugepage_flush(mm, addr, pmdp, old);
-- 
2.5.0
