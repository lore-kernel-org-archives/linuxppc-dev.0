Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 557E22C0125
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 12:18:06 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 12 Apr 2013 12:13:16 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5C912357804E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 12:18:02 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3C2HNN964684156
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 12:17:23 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3C2HRVY019203
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 12:17:28 +1000
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 1/4] powerpc: Move the setting of rflags out of loop in
 __hash_page_huge
Date: Fri, 12 Apr 2013 10:16:57 +0800
Message-Id: <1365733021-28912-2-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1365733021-28912-1-git-send-email-zhong@linux.vnet.ibm.com>
References: <1365733021-28912-1-git-send-email-zhong@linux.vnet.ibm.com>
Cc: paulus@samba.org, Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It seems that rflags don't get changed in  the repeating loop, so move
it out of the loop.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugetlbpage-hash64.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index cecad34..edb4129 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -87,10 +87,6 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 
 		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
 
-repeat:
-		hpte_group = ((hash & htab_hash_mask) *
-			      HPTES_PER_GROUP) & ~0x7UL;
-
 		/* clear HPTE slot informations in new PTE */
 #ifdef CONFIG_PPC_64K_PAGES
 		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HPTE_SUB0;
@@ -101,6 +97,10 @@ repeat:
 		rflags |= (new_pte & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
 				      _PAGE_COHERENT | _PAGE_GUARDED));
 
+repeat:
+		hpte_group = ((hash & htab_hash_mask) *
+			      HPTES_PER_GROUP) & ~0x7UL;
+
 		/* Insert into the hash table, primary slot */
 		slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, 0,
 					  mmu_psize, ssize);
-- 
1.7.9.5
