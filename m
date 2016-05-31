Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJk6L3tZhzDqZC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 16:26:50 +1000 (AEST)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 31 May 2016 00:26:48 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 3/3] powerpc/mm/radix: Add missing tlb flush
Date: Tue, 31 May 2016 11:56:31 +0530
Message-Id: <1464675991-13023-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1464675991-13023-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1464675991-13023-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
