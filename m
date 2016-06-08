Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrmG20lkzDwQW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:43:58 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58EcwxU034192
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 10:43:56 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9m3tukw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 10:43:56 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 08:43:55 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 06/16] powerpc/mm/hash: Add helper for finding SLBE LLP
 encoding
Date: Wed,  8 Jun 2016 20:13:13 +0530
In-Reply-To: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465397003-26812-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 74839f24f412..b042e5f9a428 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -151,6 +151,15 @@ static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
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
index 4c6d4c736ba4..fd483948981a 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -72,8 +72,7 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 		/* clear out bits after (52) [0....52.....63] */
 		va &= ~((1ul << (64 - 52)) - 1);
 		va |= ssize << 8;
-		sllp = ((mmu_psize_defs[apsize].sllp & SLB_VSID_L) >> 6) |
-			((mmu_psize_defs[apsize].sllp & SLB_VSID_LP) >> 4);
+		sllp = get_sllp_encoding(apsize);
 		va |= sllp << 5;
 		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%1,%0), %2)
 			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
@@ -122,8 +121,7 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
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
