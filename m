Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406rqs2WNyzF22p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 15:57:13 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2N4s6Vw081920
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 00:57:10 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gvrjs48a6-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 00:57:10 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 22:57:09 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mauricfo@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/3] powerpc/mm/radix: Move the functions that does the actual
 tlbie closer
Date: Fri, 23 Mar 2018 10:26:26 +0530
In-Reply-To: <20180323045627.16800-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180323045627.16800-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180323045627.16800-2-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No functionality change. Just code movement to ease code changes later

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/tlb-radix.c | 64 ++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 8ce858ec59e1..570fdc7b0e74 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -119,6 +119,38 @@ static inline void __tlbie_pid(unsigned long pid, unsigned long ric)
 	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
+static inline void __tlbiel_va(unsigned long va, unsigned long pid,
+			       unsigned long ap, unsigned long ric)
+{
+	unsigned long rb,rs,prs,r;
+
+	rb = va & ~(PPC_BITMASK(52, 63));
+	rb |= ap << PPC_BITLSHIFT(58);
+	rs = pid << PPC_BITLSHIFT(31);
+	prs = 1; /* process scoped */
+	r = 1;   /* raidx format */
+
+	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	trace_tlbie(0, 1, rb, rs, ric, prs, r);
+}
+
+static inline void __tlbie_va(unsigned long va, unsigned long pid,
+			      unsigned long ap, unsigned long ric)
+{
+	unsigned long rb,rs,prs,r;
+
+	rb = va & ~(PPC_BITMASK(52, 63));
+	rb |= ap << PPC_BITLSHIFT(58);
+	rs = pid << PPC_BITLSHIFT(31);
+	prs = 1; /* process scoped */
+	r = 1;   /* raidx format */
+
+	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	trace_tlbie(0, 0, rb, rs, ric, prs, r);
+}
+
 /*
  * We use 128 set in radix mode and 256 set in hpt mode.
  */
@@ -155,22 +187,6 @@ static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
-static inline void __tlbiel_va(unsigned long va, unsigned long pid,
-			       unsigned long ap, unsigned long ric)
-{
-	unsigned long rb,rs,prs,r;
-
-	rb = va & ~(PPC_BITMASK(52, 63));
-	rb |= ap << PPC_BITLSHIFT(58);
-	rs = pid << PPC_BITLSHIFT(31);
-	prs = 1; /* process scoped */
-	r = 1;   /* raidx format */
-
-	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
-		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
-	trace_tlbie(0, 1, rb, rs, ric, prs, r);
-}
-
 static inline void __tlbiel_va_range(unsigned long start, unsigned long end,
 				    unsigned long pid, unsigned long page_size,
 				    unsigned long psize)
@@ -203,22 +219,6 @@ static inline void _tlbiel_va_range(unsigned long start, unsigned long end,
 	asm volatile("ptesync": : :"memory");
 }
 
-static inline void __tlbie_va(unsigned long va, unsigned long pid,
-			     unsigned long ap, unsigned long ric)
-{
-	unsigned long rb,rs,prs,r;
-
-	rb = va & ~(PPC_BITMASK(52, 63));
-	rb |= ap << PPC_BITLSHIFT(58);
-	rs = pid << PPC_BITLSHIFT(31);
-	prs = 1; /* process scoped */
-	r = 1;   /* raidx format */
-
-	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
-		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
-	trace_tlbie(0, 0, rb, rs, ric, prs, r);
-}
-
 static inline void __tlbie_va_range(unsigned long start, unsigned long end,
 				    unsigned long pid, unsigned long page_size,
 				    unsigned long psize)
-- 
2.14.3
