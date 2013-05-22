Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B32E2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 02:58:28 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 22 May 2013 22:22:30 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 3F30E125804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 22:30:21 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4MGwHCt52756598
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 22:28:17 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4MGwMmZ020833
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 02:58:22 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, dwg@au1.ibm.com
Subject: [PATCH -V9 18/20] powerpc: disable assert_pte_locked for
 collapse_huge_page
Date: Wed, 22 May 2013 22:27:50 +0530
Message-Id: <1369241872-15700-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1369241872-15700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1369241872-15700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
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

With THP we set pmd to none, before we do pte_clear. Hence we can't
walk page table to get the pte lock ptr and verify whether it is locked.
THP do take pte lock before calling pte_clear. So we don't change the locking
rules here. It is that we can't use page table walking to check whether
pte locks are held with THP.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 214130a..edda589 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -235,6 +235,14 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	pud = pud_offset(pgd, addr);
 	BUG_ON(pud_none(*pud));
 	pmd = pmd_offset(pud, addr);
+	/*
+	 * khugepaged to collapse normal pages to hugepage, first set
+	 * pmd to none to force page fault/gup to take mmap_sem. After
+	 * pmd is set to none, we do a pte_clear which does this assertion
+	 * so if we find pmd none, return.
+	 */
+	if (pmd_none(*pmd))
+		return;
 	BUG_ON(!pmd_present(*pmd));
 	assert_spin_locked(pte_lockptr(mm, pmd));
 }
-- 
1.8.1.2
