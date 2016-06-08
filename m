Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrNG65bBzDqXZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:26:38 +1000 (AEST)
Received: from pps.filterd (m0082756.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58ENh3p016687
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 10:26:35 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9mf2dn9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 10:26:35 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 08:26:33 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 01/10] Fix .long's in mm/tlb-radix.c to more meaningful
Date: Wed,  8 Jun 2016 19:55:49 +0530
In-Reply-To: <1465395958-21349-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465395958-21349-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465395958-21349-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh <bsingharora@gmail.com>

The .longs with the shifts are harder to read, use more
meaningful names for the opcodes. PPC_TLBIE_5 is introduced
for the 5 opcode variation of the instruction due to an existing
op-code for the 2 opcode variant

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-opcode.h | 14 ++++++++++++++
 arch/powerpc/mm/tlb-radix.c           | 13 +++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 1d035c1cc889..c0e9ea44fee3 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -184,6 +184,7 @@
 #define PPC_INST_STSWX			0x7c00052a
 #define PPC_INST_STXVD2X		0x7c000798
 #define PPC_INST_TLBIE			0x7c000264
+#define PPC_INST_TLBIEL			0x7c000224
 #define PPC_INST_TLBILX			0x7c000024
 #define PPC_INST_WAIT			0x7c00007c
 #define PPC_INST_TLBIVAX		0x7c000624
@@ -257,6 +258,9 @@
 #define ___PPC_RB(b)	(((b) & 0x1f) << 11)
 #define ___PPC_RS(s)	(((s) & 0x1f) << 21)
 #define ___PPC_RT(t)	___PPC_RS(t)
+#define ___PPC_R(r)	(((r) & 0x1) << 16)
+#define ___PPC_PRS(prs)	(((prs) & 0x1) << 17)
+#define ___PPC_RIC(ric)	(((ric) & 0x3) << 18)
 #define __PPC_RA(a)	___PPC_RA(__REG_##a)
 #define __PPC_RA0(a)	___PPC_RA(__REGA0_##a)
 #define __PPC_RB(b)	___PPC_RB(__REG_##b)
@@ -321,6 +325,16 @@
 					__PPC_WC(w))
 #define PPC_TLBIE(lp,a) 	stringify_in_c(.long PPC_INST_TLBIE | \
 					       ___PPC_RB(a) | ___PPC_RS(lp))
+#define	PPC_TLBIE_5(rb,rs,ric,prs,r) \
+				stringify_in_c(.long PPC_INST_TLBIE | \
+					___PPC_RB(rb) | ___PPC_RS(rs) | \
+					___PPC_RIC(ric) | ___PPC_PRS(prs) | \
+					___PPC_R(r))
+#define	PPC_TLBIEL(rb,rs,ric,prs,r) \
+				stringify_in_c(.long PPC_INST_TLBIEL | \
+					___PPC_RB(rb) | ___PPC_RS(rs) | \
+					___PPC_RIC(ric) | ___PPC_PRS(prs) | \
+					___PPC_R(r))
 #define PPC_TLBSRX_DOT(a,b)	stringify_in_c(.long PPC_INST_TLBSRX_DOT | \
 					__PPC_RA0(a) | __PPC_RB(b))
 #define PPC_TLBIVAX(a,b)	stringify_in_c(.long PPC_INST_TLBIVAX | \
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 0fdaf93a3e09..e6b7487ad28f 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/memblock.h>
+#include <asm/ppc-opcode.h>
 
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
@@ -30,8 +31,7 @@ static inline void __tlbiel_pid(unsigned long pid, int set)
 	ric = 2;  /* invalidate all the caches */
 
 	asm volatile("ptesync": : :"memory");
-	asm volatile(".long 0x7c000224 | (%0 << 11) | (%1 << 16) |"
-		     "(%2 << 17) | (%3 << 18) | (%4 << 21)"
+	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
 	asm volatile("ptesync": : :"memory");
 }
@@ -60,8 +60,7 @@ static inline void _tlbie_pid(unsigned long pid)
 	ric = 2;  /* invalidate all the caches */
 
 	asm volatile("ptesync": : :"memory");
-	asm volatile(".long 0x7c000264 | (%0 << 11) | (%1 << 16) |"
-		     "(%2 << 17) | (%3 << 18) | (%4 << 21)"
+	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
@@ -79,8 +78,7 @@ static inline void _tlbiel_va(unsigned long va, unsigned long pid,
 	ric = 0;  /* no cluster flush yet */
 
 	asm volatile("ptesync": : :"memory");
-	asm volatile(".long 0x7c000224 | (%0 << 11) | (%1 << 16) |"
-		     "(%2 << 17) | (%3 << 18) | (%4 << 21)"
+	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
 	asm volatile("ptesync": : :"memory");
 }
@@ -98,8 +96,7 @@ static inline void _tlbie_va(unsigned long va, unsigned long pid,
 	ric = 0;  /* no cluster flush yet */
 
 	asm volatile("ptesync": : :"memory");
-	asm volatile(".long 0x7c000264 | (%0 << 11) | (%1 << 16) |"
-		     "(%2 << 17) | (%3 << 18) | (%4 << 21)"
+	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
-- 
2.7.4
