Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMy0r6gqrzDvk8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 05:33:48 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uALISxo3044602
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 13:33:45 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26v54dc2x0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 13:33:45 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Nov 2016 11:33:46 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v3 6/6] powerpc/mm: Batch tlb flush when invalidating pte
 entries
Date: Tue, 22 Nov 2016 00:03:22 +0530
In-Reply-To: <20161121183322.14585-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161121183322.14585-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20161121183322.14585-6-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/book3s/64/radix.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index aec6e8ee6e27..83c77323a769 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -142,15 +142,21 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
 		unsigned long new_pte;
 
 		old_pte = __radix_pte_update(ptep, ~0, 0);
-		asm volatile("ptesync" : : : "memory");
 		/*
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
+			asm volatile("ptesync" : : : "memory");
+			psize = radix_get_mmu_psize(pg_sz);
+			radix__flush_tlb_page_psize(mm, addr, psize);
+			__radix_pte_update(ptep, 0, new_pte);
+		}
 	} else
 		old_pte = __radix_pte_update(ptep, clr, set);
 	asm volatile("ptesync" : : : "memory");
-- 
2.10.2
