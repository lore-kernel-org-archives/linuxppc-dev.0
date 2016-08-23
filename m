Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJS8Z2cKXzDrK7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 20:58:05 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7NAs9QA130287
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 06:58:02 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24y8tn9evh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 06:58:01 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 23 Aug 2016 04:58:01 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3] powerpc/mm: Add radix flush all with IS=3
Date: Tue, 23 Aug 2016 16:27:48 +0530
In-Reply-To: <1471596759-3396-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1471596759-3396-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1471949868-542-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  1 +
 arch/powerpc/mm/tlb-radix.c                        | 24 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index 65037762b120..a9e19cb2f7c5 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -41,4 +41,5 @@ extern void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmad
 extern void radix__flush_tlb_lpid_va(unsigned long lpid, unsigned long gpa,
 				     unsigned long page_size);
 extern void radix__flush_tlb_lpid(unsigned long lpid);
+extern void radix__flush_tlb_all(void);
 #endif
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 48df05ef5231..0e49ec541ab5 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -400,3 +400,27 @@ void radix__flush_pmd_tlb_range(struct vm_area_struct *vma,
 	radix__flush_tlb_range_psize(vma->vm_mm, start, end, MMU_PAGE_2M);
 }
 EXPORT_SYMBOL(radix__flush_pmd_tlb_range);
+
+void radix__flush_tlb_all(void)
+{
+	unsigned long rb,prs,r,rs;
+	unsigned long ric = RIC_FLUSH_ALL;
+
+	rb = 0x3 << PPC_BITLSHIFT(53); /* IS = 3 */
+	prs = 0; /* partition scoped */
+	r = 1;   /* raidx format */
+	rs = 1 & ((1UL << 32) - 1); /* any LPID value to flush guest mappings */
+
+	asm volatile("ptesync": : :"memory");
+	/*
+	 * now flush guest entries by passing PRS = 1 and LPID != 0
+	 */
+	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(r), "i"(1), "i"(ric), "r"(rs) : "memory");
+	/*
+	 * now flush host entires by passing PRS = 0 and LPID == 0
+	 */
+	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(0) : "memory");
+	asm volatile("eieio; tlbsync; ptesync": : :"memory");
+}
-- 
2.7.4
