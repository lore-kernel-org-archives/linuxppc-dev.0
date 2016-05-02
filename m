Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qz1d06RW4zDqD8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 21:03:32 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 2 May 2016 20:53:21 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C12B32CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 20:53:19 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u42ArBGg7602454
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 May 2016 20:53:19 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u42Aql8G005910
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 May 2016 20:52:47 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/mm/subpage: Fix subpage protection with 4K hpte
 config
Date: Mon,  2 May 2016 16:21:51 +0530
Message-Id: <1462186311-1323-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1462186311-1323-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1462186311-1323-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With Linux page size of 64K and hardware only supporting 4K hpte, if
we use subpage protection, we always fail for the subpage 0 as shown
below (using the selftest subpage_prot test).

520175565: (4520111850): Failed at 0x0x3fffad4b0000 (p=13,sp=0,w=0), want=fault, got=pass !
4520890210: (4520826495): Failed at 0x0x3fffad5b0000 (p=29,sp=0,w=0), want=fault, got=pass !
4521574251: (4521510536): Failed at 0x0x3fffad6b0000 (p=45,sp=0,w=0), want=fault, got=pass !
4522258324: (4522194609): Failed at 0x0x3fffad7b0000 (p=61,sp=0,w=0), want=fault, got=pass !

This is because hash preload wrongly insert the hpte entry for subpage 0
without looking at the subapge protection information. Don't do hash
page table entry preload if we have subpage protection configured for
that range.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 262082e51db1..b5a454415215 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1329,15 +1329,26 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	unsigned long vsid;
 	pgd_t *pgdir;
 	pte_t *ptep;
+	int psize;
 	unsigned long flags;
 	int rc, ssize, update_flags = 0;
 
 	BUG_ON(REGION_ID(ea) != USER_REGION_ID);
 
 #ifdef CONFIG_PPC_MM_SLICES
-	/* We only prefault standard pages for now */
-	if (unlikely(get_slice_psize(mm, ea) != mm->context.user_psize))
+	psize = get_slice_psize(mm, ea);
+	/*
+	 * We only prefault standard pages
+	 */
+	if (psize != mm->context.user_psize)
 		return;
+#ifdef CONFIG_PPC_64K_PAGES
+	/*
+	 * Don't prefault is subpage protection is enabled for that ea
+	 */
+	if ((psize == MMU_PAGE_4K) && subpage_protection(mm, ea))
+		return;
+#endif
 #endif
 
 	DBG_LOW("hash_preload(mm=%p, mm->pgdir=%p, ea=%016lx, access=%lx,"
-- 
2.7.4
