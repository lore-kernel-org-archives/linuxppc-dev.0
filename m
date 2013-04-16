Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D9E392C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 12:53:38 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Tue, 16 Apr 2013 08:20:14 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D30BB125804E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 08:25:00 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3G2rRIn6881574
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 08:23:27 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3G2rU8j028793
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 12:53:31 +1000
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 1/3] powerpc: Move the setting of rflags out of loop in
 __hash_page_huge
Date: Tue, 16 Apr 2013 10:53:18 +0800
Message-Id: <1366080800-27885-1-git-send-email-zhong@linux.vnet.ibm.com>
Cc: paulus@samba.org, Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It seems that new_pte and rflags don't get changed in the repeating loop, so
move their assignment out of the loop.

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
