Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mTnh5lGbzDqkP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 23:37:12 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w79DTw8Z050980
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Aug 2018 09:37:10 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2krnmeaxdt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Aug 2018 09:37:10 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 9 Aug 2018 07:37:09 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] powerpc/mm/tlbflush: update the mmu_gather page size while
 iterating address range
Date: Thu,  9 Aug 2018 19:06:59 +0530
Message-Id: <20180809133659.16230-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch makes sure we update the mmu_gather page size even if we are
requesting for a fullmm flush. This avoids triggering VM_WARN_ON in code
paths like __tlb_remove_page_size that explicitly check for removing range page
size to be same as mmu gather page size.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/tlb.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 97ecef697e1b..f0e571b2dc7c 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -49,13 +49,11 @@ static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
 static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
-	if (tlb->fullmm)
-		return;
-
 	if (!tlb->page_size)
 		tlb->page_size = page_size;
 	else if (tlb->page_size != page_size) {
-		tlb_flush_mmu(tlb);
+		if (!tlb->fullmm)
+			tlb_flush_mmu(tlb);
 		/*
 		 * update the page size after flush for the new
 		 * mmu_gather.
-- 
2.17.1
