Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJjTF2W8WzDqGy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 13:58:57 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v192we8Z034352
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 21:58:54 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28gekbasgd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2017 21:58:54 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 21:58:54 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 3/3] powerpc/mm/radix: Skip ptesync in pte update helpers
Date: Thu,  9 Feb 2017 08:28:21 +0530
In-Reply-To: <1486609101-5231-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1486609101-5231-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1486609101-5231-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We do them at the start of tlb flush, and we are sure a pte update will be
followed by a tlbflush. Hence we can skip the ptesync in pte update helpers.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index fcf822d6c204..77e590c77299 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -144,13 +144,11 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
 		 * new value of pte
 		 */
 		new_pte = (old_pte | set) & ~clr;
-		asm volatile("ptesync" : : : "memory");
 		radix__flush_tlb_pte_p9_dd1(old_pte, mm, addr);
 		if (new_pte)
 			__radix_pte_update(ptep, 0, new_pte);
 	} else
 		old_pte = __radix_pte_update(ptep, clr, set);
-	asm volatile("ptesync" : : : "memory");
 	if (!huge)
 		assert_pte_locked(mm, addr);
 
@@ -195,7 +193,6 @@ static inline void radix__ptep_set_access_flags(struct mm_struct *mm,
 		unsigned long old_pte, new_pte;
 
 		old_pte = __radix_pte_update(ptep, ~0, 0);
-		asm volatile("ptesync" : : : "memory");
 		/*
 		 * new value of pte
 		 */
-- 
2.7.4
