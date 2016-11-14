Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHZvp00pZzDvdG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 02:59:17 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAEFwSA1003410
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 10:59:15 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26pqqeu2nn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 10:59:15 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 14 Nov 2016 08:59:14 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Batch tlb flush when invalidating pte entries
Date: Mon, 14 Nov 2016 21:28:57 +0530
Message-Id: <20161114155857.25046-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This will improve the task exit case, by batching tlb invalidates.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index aec6e8ee6e27..e8b4f39e9fab 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -147,10 +147,16 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
 		 * new value of pte
 		 */
 		new_pte = (old_pte | set) & ~clr;
-		psize = radix_get_mmu_psize(pg_sz);
-		radix__flush_tlb_page_psize(mm, addr, psize);
-
-		__radix_pte_update(ptep, 0, new_pte);
+		/*
+		 * If we are trying to clear the pte, we can skip
+		 * the below sequence and batch the tlb flush. The
+		 * tlb flush batching is done by mmu gather code
+		 */
+		if (new_pte) {
+			psize = radix_get_mmu_psize(pg_sz);
+			radix__flush_tlb_page_psize(mm, addr, psize);
+			__radix_pte_update(ptep, 0, new_pte);
+		}
 	} else
 		old_pte = __radix_pte_update(ptep, clr, set);
 	asm volatile("ptesync" : : : "memory");
-- 
2.10.2
