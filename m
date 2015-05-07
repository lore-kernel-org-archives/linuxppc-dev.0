Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0CD191A0276
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 17:23:40 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 7 May 2015 12:53:39 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 02FF0394005A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 12:53:38 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t477NXTP44826742
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 12:53:34 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t476nOYO003645
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 12:19:25 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com
Subject: [PATCH V2 2/2] powerpc/thp: Serialize pmd clear against a linux page
 table walk.
Date: Thu,  7 May 2015 12:53:28 +0530
Message-Id: <1430983408-24924-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1430983408-24924-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1430983408-24924-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Serialize against find_linux_pte_or_hugepte which does lock-less
lookup in page tables with local interrupts disabled. For huge pages
it casts pmd_t to pte_t. Since format of pte_t is different from
pmd_t we want to prevent transit from pmd pointing to page table
to pmd pointing to huge page (and back) while interrupts are disabled.
We clear pmd to possibly replace it with page table pointer in
different code paths. So make sure we wait for the parallel
find_linux_pte_or_hugepage to finish.

Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from v1:
* Move kick_all_cpus_sync to pmdp_get_and_clear so that it handle zap_huge_pmd
  case also.

 arch/powerpc/mm/pgtable_64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 9171c1a37290..049d961802aa 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -845,6 +845,17 @@ pmd_t pmdp_get_and_clear(struct mm_struct *mm,
 	 * hash fault look at them.
 	 */
 	memset(pgtable, 0, PTE_FRAG_SIZE);
+	/*
+	 * Serialize against find_linux_pte_or_hugepte which does lock-less
+	 * lookup in page tables with local interrupts disabled. For huge pages
+	 * it casts pmd_t to pte_t. Since format of pte_t is different from
+	 * pmd_t we want to prevent transit from pmd pointing to page table
+	 * to pmd pointing to huge page (and back) while interrupts are disabled.
+	 * We clear pmd to possibly replace it with page table pointer in
+	 * different code paths. So make sure we wait for the parallel
+	 * find_linux_pte_or_hugepage to finish.
+	 */
+	kick_all_cpus_sync();
 	return old_pmd;
 }
 
-- 
2.1.4
