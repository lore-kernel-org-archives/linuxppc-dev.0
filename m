Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4Pc43GPwzDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 15:21:24 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 11 May 2016 15:21:23 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D02D635780A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 15:20:22 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4B5JoWY65536046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 15:20:12 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4B5JP9u000928
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 15:19:25 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/radix: Add missing tlb flush
Date: Wed, 11 May 2016 10:48:58 +0530
Message-Id: <1462943938-29341-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This should not have any impact on hash, because hash does tlb
invalidate with every pte update and we don't implement
flush_tlb_* functions for hash. With radix we should make an explicit
call to flush tlb outside pte update.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable-book3s64.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index eb4451144746..670318766545 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -33,10 +33,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 	changed = !pmd_same(*(pmdp), entry);
 	if (changed) {
 		__ptep_set_access_flags(pmdp_ptep(pmdp), pmd_pte(entry));
-		/*
-		 * Since we are not supporting SW TLB systems, we don't
-		 * have any thing similar to flush_tlb_page_nohash()
-		 */
+		flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	}
 	return changed;
 }
-- 
2.7.4
