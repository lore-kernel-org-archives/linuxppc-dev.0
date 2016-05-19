Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9Ndc54NCzDqKd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 17:55:00 +1000 (AEST)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 19 May 2016 13:24:57 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 17F731258060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:27:06 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4J7spEl4456830
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:24:51 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4J7sncJ031715
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:24:50 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 6/6] powerpc/mm/hash: Add helper for finding SLBE LLP encoding
Date: Thu, 19 May 2016 13:24:32 +0530
Message-Id: <1463644472-10158-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1463644472-10158-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1463644472-10158-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace opencoding of the same at multiple places with the helper.
No functional change with this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 9 +++++++++
 arch/powerpc/include/asm/kvm_book3s_64.h      | 3 +--
 arch/powerpc/mm/hash_native_64.c              | 6 ++----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 290157e8d5b2..a5fa6be7d5ae 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -150,6 +150,15 @@ static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
 	BUG();
 }
 
+static inline unsigned long get_sllp_encoding(int psize)
+{
+	unsigned long sllp;
+
+	sllp = ((mmu_psize_defs[psize].sllp & SLB_VSID_L) >> 6) |
+		((mmu_psize_defs[psize].sllp & SLB_VSID_LP) >> 4);
+	return sllp;
+}
+
 #endif /* __ASSEMBLY__ */
 
 /*
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 1f4497fb5b83..88d17b4ea9c8 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -181,8 +181,7 @@ static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 
 	switch (b_psize) {
 	case MMU_PAGE_4K:
-		sllp = ((mmu_psize_defs[a_psize].sllp & SLB_VSID_L) >> 6) |
-			((mmu_psize_defs[a_psize].sllp & SLB_VSID_LP) >> 4);
+		sllp = get_sllp_encoding(a_psize);
 		rb |= sllp << 5;	/*  AP field */
 		rb |= (va_low & 0x7ff) << 12;	/* remaining 11 bits of AVA */
 		break;
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index c9715fc99d68..db108e478c80 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -71,8 +71,7 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 		/* clear out bits after (52) [0....52.....63] */
 		va &= ~((1ul << (64 - 52)) - 1);
 		va |= ssize << 8;
-		sllp = ((mmu_psize_defs[apsize].sllp & SLB_VSID_L) >> 6) |
-			((mmu_psize_defs[apsize].sllp & SLB_VSID_LP) >> 4);
+		sllp = get_sllp_encoding(apsize);
 		va |= sllp << 5;
 		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%1,%0), %2)
 			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
@@ -120,8 +119,7 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 		/* clear out bits after(52) [0....52.....63] */
 		va &= ~((1ul << (64 - 52)) - 1);
 		va |= ssize << 8;
-		sllp = ((mmu_psize_defs[apsize].sllp & SLB_VSID_L) >> 6) |
-			((mmu_psize_defs[apsize].sllp & SLB_VSID_LP) >> 4);
+		sllp = get_sllp_encoding(apsize);
 		va |= sllp << 5;
 		asm volatile(".long 0x7c000224 | (%0 << 11) | (0 << 21)"
 			     : : "r"(va) : "memory");
-- 
2.7.4
