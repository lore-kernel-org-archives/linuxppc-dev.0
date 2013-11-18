Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7CE082C009C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 20:28:32 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Nov 2013 19:28:31 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AF46F2BB0053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 20:28:28 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAI9Ai4J8716588
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 20:10:44 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAI9SRvj019769
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 20:28:28 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, linux-mm@kvack.org
Subject: [PATCH -V2 4/5] powerpc: mm: Only check for _PAGE_PRESENT in
 set_pte/pmd functions
Date: Mon, 18 Nov 2013 14:58:12 +0530
Message-Id: <1384766893-10189-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1384766893-10189-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1384766893-10189-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We want to make sure we don't use these function when updating a pte
or pmd entry that have a valid hpte entry, because these functions
don't invalidate them. So limit the check to _PAGE_PRESENT bit.
Numafault core changes use these functions for updating _PAGE_NUMA bits.
That should be ok because when _PAGE_NUMA is set we can be sure that
hpte entries are not present.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable.c    | 2 +-
 arch/powerpc/mm/pgtable_64.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 841e0d00863c..ad90429bbd8b 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -174,7 +174,7 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 		pte_t pte)
 {
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(pte_present(*ptep));
+	WARN_ON(pte_val(*ptep) & _PAGE_PRESENT);
 #endif
 	/* Note: mm->context.id might not yet have been assigned as
 	 * this context might not have been activated yet when this
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 9d95786aa80f..02e8681fb865 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -687,7 +687,7 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 		pmd_t *pmdp, pmd_t pmd)
 {
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pmd_none(*pmdp));
+	WARN_ON(pmd_val(*pmdp) & _PAGE_PRESENT);
 	assert_spin_locked(&mm->page_table_lock);
 	WARN_ON(!pmd_trans_huge(pmd));
 #endif
-- 
1.8.3.2
