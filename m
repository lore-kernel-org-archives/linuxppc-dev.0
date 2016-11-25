Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQLTZ3v11zDvyY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 03:03:30 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAPFwhr9014026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:03:28 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26xg61wt3a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:03:28 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 25 Nov 2016 09:03:27 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v6 7/7] powerpc/mm: Batch tlb flush when invalidating pte
 entries
Date: Fri, 25 Nov 2016 21:32:57 +0530
In-Reply-To: <20161125160257.9158-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161125160257.9158-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20161125160257.9158-8-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/book3s/64/radix.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index c0d43766ec63..98a0aee8b148 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -140,13 +140,20 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
 		unsigned long new_pte;
 
 		old_pte = __radix_pte_update(ptep, ~0, 0);
-		asm volatile("ptesync" : : : "memory");
 		/*
 		 * new value of pte
 		 */
 		new_pte = (old_pte | set) & ~clr;
-		radix__flush_tlb_pte(old_pte, mm, addr);
-		__radix_pte_update(ptep, 0, new_pte);
+		/*
+		 * If we are trying to clear the pte, we can skip
+		 * the below sequence and batch the tlb flush. The
+		 * tlb flush batching is done by mmu gather code
+		 */
+		if (new_pte) {
+			asm volatile("ptesync" : : : "memory");
+			radix__flush_tlb_pte(old_pte, mm, addr);
+			__radix_pte_update(ptep, 0, new_pte);
+		}
 	} else
 		old_pte = __radix_pte_update(ptep, clr, set);
 	asm volatile("ptesync" : : : "memory");
-- 
2.10.2
