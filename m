Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tRxL05WvXzDvf4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 17:17:28 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAS6DdrJ023707
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 01:17:26 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2702g40mxy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 01:17:26 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Nov 2016 23:17:24 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v7 4/7] powerpc/mm: Add radix__tlb_flush_pte
Date: Mon, 28 Nov 2016 11:47:01 +0530
In-Reply-To: <20161128061704.4914-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161128061704.4914-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20161128061704.4914-5-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have page size details encoded in pte using software pte bits,
use that to find the page size needed for tlb flush.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/tlbflush-radix.h |  2 ++
 arch/powerpc/mm/tlb-radix.c                         | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index a9e19cb2f7c5..e9bbd10ee7e9 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -42,4 +42,6 @@ extern void radix__flush_tlb_lpid_va(unsigned long lpid, unsigned long gpa,
 				     unsigned long page_size);
 extern void radix__flush_tlb_lpid(unsigned long lpid);
 extern void radix__flush_tlb_all(void);
+extern void radix__flush_tlb_pte(unsigned long old_pte, struct mm_struct *mm,
+				 unsigned long address);
 #endif
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 3493cf4e0452..7648952e4f08 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -428,3 +428,21 @@ void radix__flush_tlb_all(void)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(0) : "memory");
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
+
+void radix__flush_tlb_pte(unsigned long old_pte, struct mm_struct *mm,
+			  unsigned long address)
+{
+	/*
+	 * We track page size in pte only for DD1, So we can
+	 * call this only on DD1.
+	 */
+	if (!cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+		VM_WARN_ON(1);
+		return;
+	}
+
+	if (old_pte & _PAGE_LARGE)
+		radix__flush_tlb_page_psize(mm, address, MMU_PAGE_2M);
+	else
+		radix__flush_tlb_page_psize(mm, address, mmu_virtual_psize);
+}
-- 
2.10.2
