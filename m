Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQLTY4b5LzDvxh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 03:03:29 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAPFwwha064681
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:03:26 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26xh7s7nvf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:03:26 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 25 Nov 2016 09:03:25 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v6 6/7] powerpc/mm: update radix__pte_update to not do full mm
 tlb flush
Date: Fri, 25 Nov 2016 21:32:56 +0530
In-Reply-To: <20161125160257.9158-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161125160257.9158-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20161125160257.9158-7-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we are updating pte, we just need to flush the tlb mapping for
that pte. Right now we do a full mm flush because we don't track page
size. Now that we have page size details in pte use that to do the
optimized flush

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 08eaceb430ee..c0d43766ec63 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -145,13 +145,7 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
 		 * new value of pte
 		 */
 		new_pte = (old_pte | set) & ~clr;
-
-		/*
-		 * For now let's do heavy pid flush
-		 * radix__flush_tlb_page_psize(mm, addr, mmu_virtual_psize);
-		 */
-		radix__flush_tlb_mm(mm);
-
+		radix__flush_tlb_pte(old_pte, mm, addr);
 		__radix_pte_update(ptep, 0, new_pte);
 	} else
 		old_pte = __radix_pte_update(ptep, clr, set);
-- 
2.10.2
