Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C99CD1A023C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 16:27:14 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 11 May 2015 16:27:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 66B3F2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 16:27:10 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4B6R2G542074156
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 16:27:10 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4B6Qbs9008368
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 16:26:38 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com,
 akpm@linux-foundation.org
Subject: [PATCH V3] powerpc/thp: Serialize pmd clear against a linux page
 table walk.
Date: Mon, 11 May 2015 11:56:01 +0530
Message-Id: <1431325561-21396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Without this patch, a find_linux_pte_or_hugepte running in parallel to
__split_huge_zero_page_pmd or do_huge_pmd_wp_page_fallback or zap_huge_pmd
can run into the above issue. With __split_huge_zero_page_pmd and
do_huge_pmd_wp_page_fallback we clear the hugepage pte before inserting
the pmd entry with a regular pgtable address. Such a clear need to
wait for the parallel find_linux_pte_or_hugepte to finish.

With zap_huge_pmd, we can run into issues, with a hugepage pte
getting zapped due to a MADV_DONTNEED while other cpu fault it
in as small pages.

Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V2:
* Drop the cleanup patch
  Will this as a separate patch and not bug fix.
* Update commit message

 arch/powerpc/mm/pgtable_64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index b651179ac4da..1325be89e670 100644
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
