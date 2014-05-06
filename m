Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2BCF9140213
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 04:01:49 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 6 May 2014 23:31:46 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 5DA37E0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 23:32:11 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s46I1rIR5702108
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 23:31:53 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s46I1ip6014837
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 23:31:45 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH V2] KVM: PPC: BOOK3S: HV: Add mixed page-size support for guest
Date: Tue,  6 May 2014 23:31:36 +0530
Message-Id: <1399399296-17711-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On recent IBM Power CPUs, while the hashed page table is looked up using
the page size from the segmentation hardware (i.e. the SLB), it is
possible to have the HPT entry indicate a larger page size.  Thus for
example it is possible to put a 16MB page in a 64kB segment, but since
the hash lookup is done using a 64kB page size, it may be necessary to
put multiple entries in the HPT for a single 16MB page.  This
capability is called mixed page-size segment (MPSS).  With MPSS,
there are two relevant page sizes: the base page size, which is the
size used in searching the HPT, and the actual page size, which is the
size indicated in the HPT entry. [ Note that the actual page size is
always >= base page size ].

We use "ibm,segment-page-sizes" device tree node to advertise
the MPSS support to PAPR guest. The penc encoding indicates whether
we support a specific combination of base page size and actual
page size in the same segment. We also use the penc value in the
LP encoding of HPTE entry.

This patch exposes MPSS support to KVM guest by advertising the
feature via "ibm,segment-page-sizes". It also adds the necessary changes
to decode the base page size and the actual page size correctly from the
HPTE entry.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V1:
* Update commit message
* Rename variables as per review feedback

 arch/powerpc/include/asm/kvm_book3s_64.h | 146 ++++++++++++++++++++++++++-----
 arch/powerpc/kvm/book3s_hv.c             |   7 ++
 2 files changed, 130 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 51388befeddb..fddb72b48ce9 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -77,34 +77,122 @@ static inline long try_lock_hpte(unsigned long *hpte, unsigned long bits)
 	return old == 0;
 }
 
+static inline int __hpte_actual_psize(unsigned int lp, int psize)
+{
+	int i, shift;
+	unsigned int mask;
+
+	/* start from 1 ignoring MMU_PAGE_4K */
+	for (i = 1; i < MMU_PAGE_COUNT; i++) {
+
+		/* invalid penc */
+		if (mmu_psize_defs[psize].penc[i] == -1)
+			continue;
+		/*
+		 * encoding bits per actual page size
+		 *        PTE LP     actual page size
+		 *    rrrr rrrz		>=8KB
+		 *    rrrr rrzz		>=16KB
+		 *    rrrr rzzz		>=32KB
+		 *    rrrr zzzz		>=64KB
+		 * .......
+		 */
+		shift = mmu_psize_defs[i].shift - LP_SHIFT;
+		if (shift > LP_BITS)
+			shift = LP_BITS;
+		mask = (1 << shift) - 1;
+		if ((lp & mask) == mmu_psize_defs[psize].penc[i])
+			return i;
+	}
+	return -1;
+}
+
 static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 					     unsigned long pte_index)
 {
-	unsigned long rb, va_low;
+	int b_psize, a_psize;
+	unsigned int penc;
+	unsigned long rb = 0, va_low, sllp;
+	unsigned int lp = (r >> LP_SHIFT) & ((1 << LP_BITS) - 1);
+
+	if (!(v & HPTE_V_LARGE)) {
+		/* both base and actual psize is 4k */
+		b_psize = MMU_PAGE_4K;
+		a_psize = MMU_PAGE_4K;
+	} else {
+		for (b_psize = 0; b_psize < MMU_PAGE_COUNT; b_psize++) {
+
+			/* valid entries have a shift value */
+			if (!mmu_psize_defs[b_psize].shift)
+				continue;
 
+			a_psize = __hpte_actual_psize(lp, b_psize);
+			if (a_psize != -1)
+				break;
+		}
+	}
+	/*
+	 * Ignore the top 14 bits of va
+	 * v have top two bits covering segment size, hence move
+	 * by 16 bits, Also clear the lower HPTE_V_AVPN_SHIFT (7) bits.
+	 * AVA field in v also have the lower 23 bits ignored.
+	 * For base page size 4K we need 14 .. 65 bits (so need to
+	 * collect extra 11 bits)
+	 * For others we need 14..14+i
+	 */
+	/* This covers 14..54 bits of va*/
 	rb = (v & ~0x7fUL) << 16;		/* AVA field */
+	/*
+	 * AVA in v had cleared lower 23 bits. We need to derive
+	 * that from pteg index
+	 */
 	va_low = pte_index >> 3;
 	if (v & HPTE_V_SECONDARY)
 		va_low = ~va_low;
-	/* xor vsid from AVA */
+	/*
+	 * get the vpn bits from va_low using reverse of hashing.
+	 * In v we have va with 23 bits dropped and then left shifted
+	 * HPTE_V_AVPN_SHIFT (7) bits. Now to find vsid we need
+	 * right shift it with (SID_SHIFT - (23 - 7))
+	 */
 	if (!(v & HPTE_V_1TB_SEG))
-		va_low ^= v >> 12;
+		va_low ^= v >> (SID_SHIFT - 16);
 	else
-		va_low ^= v >> 24;
+		va_low ^= v >> (SID_SHIFT_1T - 16);
 	va_low &= 0x7ff;
-	if (v & HPTE_V_LARGE) {
-		rb |= 1;			/* L field */
-		if (cpu_has_feature(CPU_FTR_ARCH_206) &&
-		    (r & 0xff000)) {
-			/* non-16MB large page, must be 64k */
-			/* (masks depend on page size) */
-			rb |= 0x1000;		/* page encoding in LP field */
-			rb |= (va_low & 0x7f) << 16; /* 7b of VA in AVA/LP field */
-			rb |= ((va_low << 4) & 0xf0);	/* AVAL field (P7 doesn't seem to care) */
-		}
-	} else {
-		/* 4kB page */
-		rb |= (va_low & 0x7ff) << 12;	/* remaining 11b of VA */
+
+	switch (b_psize) {
+	case MMU_PAGE_4K:
+		sllp = ((mmu_psize_defs[a_psize].sllp & SLB_VSID_L) >> 6) |
+			((mmu_psize_defs[a_psize].sllp & SLB_VSID_LP) >> 4);
+		rb |= sllp << 5;	/*  AP field */
+		rb |= (va_low & 0x7ff) << 12;	/* remaining 11 bits of AVA */
+		break;
+	default:
+	{
+		int aval_shift;
+		/*
+		 * remaining 7bits of AVA/LP fields
+		 * Also contain the rr bits of LP
+		 */
+		rb |= (va_low & 0x7f) << 16;
+		/*
+		 * Now clear not needed LP bits based on actual psize
+		 */
+		rb &= ~((1ul << mmu_psize_defs[a_psize].shift) - 1);
+		/*
+		 * AVAL field 58..77 - base_page_shift bits of va
+		 * we have space for 58..64 bits, Missing bits should
+		 * be zero filled. +1 is to take care of L bit shift
+		 */
+		aval_shift = 64 - (77 - mmu_psize_defs[b_psize].shift) + 1;
+		rb |= ((va_low << aval_shift) & 0xfe);
+
+		rb |= 1;		/* L field */
+		penc = mmu_psize_defs[b_psize].penc[a_psize];
+		rb |= penc << 12;	/* LP field */
+		break;
+	}
 	}
 	rb |= (v >> 54) & 0x300;		/* B field */
 	return rb;
@@ -112,14 +200,26 @@ static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 
 static inline unsigned long hpte_page_size(unsigned long h, unsigned long l)
 {
+	int size, a_psize;
+	/* Look at the 8 bit LP value */
+	unsigned int lp = (l >> LP_SHIFT) & ((1 << LP_BITS) - 1);
+
 	/* only handle 4k, 64k and 16M pages for now */
 	if (!(h & HPTE_V_LARGE))
-		return 1ul << 12;		/* 4k page */
-	if ((l & 0xf000) == 0x1000 && cpu_has_feature(CPU_FTR_ARCH_206))
-		return 1ul << 16;		/* 64k page */
-	if ((l & 0xff000) == 0)
-		return 1ul << 24;		/* 16M page */
-	return 0;				/* error */
+		return 1ul << 12;
+	else {
+		for (size = 0; size < MMU_PAGE_COUNT; size++) {
+			/* valid entries have a shift value */
+			if (!mmu_psize_defs[size].shift)
+				continue;
+
+			a_psize = __hpte_actual_psize(lp, size);
+			if (a_psize != -1)
+				return 1ul << mmu_psize_defs[a_psize].shift;
+		}
+
+	}
+	return 0;
 }
 
 static inline unsigned long hpte_rpn(unsigned long ptel, unsigned long psize)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 8227dba5af0f..f5d4b9d77dc9 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1949,6 +1949,13 @@ static void kvmppc_add_seg_page_size(struct kvm_ppc_one_seg_page_size **sps,
 	 * support pte_enc here
 	 */
 	(*sps)->enc[0].pte_enc = def->penc[linux_psize];
+	/*
+	 * Add 16MB MPSS support if host supports it
+	 */
+	if (linux_psize != MMU_PAGE_16M && def->penc[MMU_PAGE_16M] != -1) {
+		(*sps)->enc[1].page_shift = 24;
+		(*sps)->enc[1].pte_enc = def->penc[MMU_PAGE_16M];
+	}
 	(*sps)++;
 }
 
-- 
1.9.1
