Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJjT91fgrzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 13:58:53 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v192wgPC030256
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 21:58:50 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28g8kg05du-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2017 21:58:50 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 19:58:49 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 1/3] powerpc/mm/radix: Update pte update sequence for pte
 clear case
Date: Thu,  9 Feb 2017 08:28:19 +0530
Message-Id: <1486609101-5231-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the kernel we do follow the below sequence in different code paths.
pte = ptep_get_clear(ptep)
....
set_pte_at(ptep, pte)

We do that for mremap, autonuma protection update and softdirty clearing. This
implies our optimization to skip a tlb flush when clearing a pte update is
not valid, because for DD1 system that followup set_pte_at will be done witout
doing the required tlbflush. Fix that by always doing the dd1 style pte update
irrespective of new_pte value. In a later patch we will optimize the application
exit case.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index b4d1302387a3..70a3cdcdbe47 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -144,16 +144,10 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
 		 * new value of pte
 		 */
 		new_pte = (old_pte | set) & ~clr;
-		/*
-		 * If we are trying to clear the pte, we can skip
-		 * the below sequence and batch the tlb flush. The
-		 * tlb flush batching is done by mmu gather code
-		 */
-		if (new_pte) {
-			asm volatile("ptesync" : : : "memory");
-			radix__flush_tlb_pte_p9_dd1(old_pte, mm, addr);
+		asm volatile("ptesync" : : : "memory");
+		radix__flush_tlb_pte_p9_dd1(old_pte, mm, addr);
+		if (new_pte)
 			__radix_pte_update(ptep, 0, new_pte);
-		}
 	} else
 		old_pte = __radix_pte_update(ptep, clr, set);
 	asm volatile("ptesync" : : : "memory");
-- 
2.7.4
