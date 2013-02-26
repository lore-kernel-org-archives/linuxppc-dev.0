Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7CF0A2C02C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:06:02 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 26 Feb 2013 17:59:52 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6B02C2CE8023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:05:58 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1Q7rMSK61604000
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 18:53:22 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1Q85vxF008468
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:05:57 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V1 17/24] mm/THP: withdraw the pgtable after pmdp related
 operations
Date: Tue, 26 Feb 2013 13:35:07 +0530
Message-Id: <1361865914-13911-18-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

For architectures like ppc64 we look at deposited pgtable when
calling pmdp_get_and_clear. So do the pgtable_trans_huge_withdraw
after finishing pmdp related operations.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 mm/huge_memory.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e91b763..5c7cd7d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1380,9 +1380,10 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		struct page *page;
 		pgtable_t pgtable;
 		pmd_t orig_pmd;
-		pgtable = pgtable_trans_huge_withdraw(tlb->mm, pmd);
+
 		orig_pmd = pmdp_get_and_clear(tlb->mm, addr, pmd);
 		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
+		pgtable = pgtable_trans_huge_withdraw(tlb->mm, pmd);
 		if (is_huge_zero_pmd(orig_pmd)) {
 			tlb->mm->nr_ptes--;
 			spin_unlock(&tlb->mm->page_table_lock);
-- 
1.7.10
