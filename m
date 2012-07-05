Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A4D6C2C0203
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 18:15:00 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 5 Jul 2012 07:54:46 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q658EZNl7602576
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jul 2012 18:14:35 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q658EYMX026233
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jul 2012 18:14:34 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 3/9] arch/powerpc: Convert virtual address to vpn
Date: Thu,  5 Jul 2012 13:44:12 +0530
Message-Id: <1341476058-5405-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1341476058-5405-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1341476058-5405-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This patch convert different functions to take virtual page number
instead of virtual address. Virtual page number is virtual address
shifted right by VPN_SHIFT (12) bits. This enable us to have an
address range of upto 76 bits.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h     |   70 +++++++++++++++++----
 arch/powerpc/include/asm/pte-hash64-64k.h |   18 +++---
 arch/powerpc/kvm/book3s_64_mmu_host.c     |    2 +-
 arch/powerpc/mm/hash_low_64.S             |   97 ++++++++++++++++++-----------
 arch/powerpc/mm/hash_native_64.c          |   40 +++++++++---
 arch/powerpc/mm/hash_utils_64.c           |    6 +-
 arch/powerpc/mm/hugetlbpage-hash64.c      |    2 +-
 arch/powerpc/mm/tlb_hash64.c              |    2 +-
 arch/powerpc/platforms/cell/beat_htab.c   |    2 +-
 arch/powerpc/platforms/pseries/lpar.c     |   20 +-----
 10 files changed, 168 insertions(+), 91 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 1c65a59..1c984a6 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -14,6 +14,7 @@
 
 #include <asm/asm-compat.h>
 #include <asm/page.h>
+#include <asm/bug.h>
 
 /*
  * Segment table
@@ -154,9 +155,25 @@ struct mmu_psize_def
 #define MMU_SEGSIZE_256M	0
 #define MMU_SEGSIZE_1T		1
 
+/*
+ * encode page number shift.
+ * Inorder to fit the 78 bit va in a 64 bit variable we shift the va by
+ * 12 bits. This enable us to address upto 76 bit va.
+ * For hpt hash from a va we can ignore the page size bits of va and for
+ * hpte encoding we ignore upto 23 bits of va. So ignoring lower 12 bits ensure
+ * we work in all cases including 4k page size.
+ */
+#define VPN_SHIFT	12
 
 #ifndef __ASSEMBLY__
 
+static inline int segment_shift(int ssize)
+{
+	if (ssize == MMU_SEGSIZE_256M)
+		return SID_SHIFT;
+	return SID_SHIFT_1T;
+}
+
 /*
  * The current system page and segment sizes
  */
@@ -180,6 +197,30 @@ extern unsigned long tce_alloc_start, tce_alloc_end;
 extern int mmu_ci_restrictions;
 
 /*
+ * This computes the AVPN and B fields of the first dword of a HPTE,
+ * for use when we want to match an existing PTE.  The bottom 7 bits
+ * of the returned value are zero.
+ */
+static inline unsigned long hpte_encode_avpn(unsigned long vpn, int psize,
+					     int ssize)
+{
+	unsigned long v;
+	/*
+	 * The AVA field omits the low-order 23 bits of the 78 bits VA.
+	 * These bits are not needed in the PTE, because the
+	 * low-order b of these bits are part of the byte offset
+	 * into the virtual page and, if b < 23, the high-order
+	 * 23-b of these bits are always used in selecting the
+	 * PTEGs to be searched
+	 */
+	BUG_ON(VPN_SHIFT > 23);
+	v = (vpn >> (23 - VPN_SHIFT)) & ~(mmu_psize_defs[psize].avpnm);
+	v <<= HPTE_V_AVPN_SHIFT;
+	v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
+	return v;
+}
+
+/*
  * This function sets the AVPN and L fields of the HPTE  appropriately
  * for the page size
  */
@@ -187,11 +228,9 @@ static inline unsigned long hpte_encode_v(unsigned long va, int psize,
 					  int ssize)
 {
 	unsigned long v;
-	v = (va >> 23) & ~(mmu_psize_defs[psize].avpnm);
-	v <<= HPTE_V_AVPN_SHIFT;
+	v = hpte_encode_avpn(va, psize, ssize);
 	if (psize != MMU_PAGE_4K)
 		v |= HPTE_V_LARGE;
-	v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
 	return v;
 }
 
@@ -216,14 +255,16 @@ static inline unsigned long hpte_encode_r(unsigned long pa, int psize)
 }
 
 /*
- * Build a VA given VSID, EA and segment size
+ * Build a VPN_SHIFT bit shifted va given VSID, EA and segment size.
  */
-static inline unsigned long hpt_va(unsigned long ea, unsigned long vsid,
+static inline unsigned long hpt_vpn(unsigned long ea, unsigned long vsid,
 				   int ssize)
 {
-	if (ssize == MMU_SEGSIZE_256M)
-		return (vsid << 28) | (ea & 0xfffffffUL);
-	return (vsid << 40) | (ea & 0xffffffffffUL);
+	unsigned long mask;
+	int s_shift = segment_shift(ssize);
+
+	mask = (1ul << (s_shift - VPN_SHIFT)) - 1;
+	return (vsid << (s_shift - VPN_SHIFT)) | ((ea >> VPN_SHIFT) & mask);
 }
 
 /*
@@ -233,13 +274,20 @@ static inline unsigned long hpt_va(unsigned long ea, unsigned long vsid,
 static inline unsigned long hpt_hash(unsigned long va, unsigned int shift,
 				     int ssize)
 {
+	int mask;
 	unsigned long hash, vsid;
 
+	BUG_ON(shift < VPN_SHIFT);
+
 	if (ssize == MMU_SEGSIZE_256M) {
-		hash = (va >> 28) ^ ((va & 0x0fffffffUL) >> shift);
+		mask = (1ul << (SID_SHIFT - VPN_SHIFT)) - 1;
+		hash = ((va >> (SID_SHIFT - VPN_SHIFT)) & 0x0000007fffffffff) ^
+			(((va & mask) >> (shift - VPN_SHIFT)) & 0xffff);
 	} else {
-		vsid = va >> 40;
-		hash = vsid ^ (vsid << 25) ^ ((va & 0xffffffffffUL) >> shift);
+		mask = (1ul << (SID_SHIFT_1T - VPN_SHIFT)) - 1;
+		vsid = va >> (SID_SHIFT_1T - VPN_SHIFT);
+		hash = (vsid & 0xffffff) ^ ((vsid << 25) & 0x7fffffffff) ^
+			(((va & mask) >> (shift - VPN_SHIFT)) & 0xfffffff);
 	}
 	return hash & 0x7fffffffffUL;
 }
diff --git a/arch/powerpc/include/asm/pte-hash64-64k.h b/arch/powerpc/include/asm/pte-hash64-64k.h
index 59247e8..eedf427 100644
--- a/arch/powerpc/include/asm/pte-hash64-64k.h
+++ b/arch/powerpc/include/asm/pte-hash64-64k.h
@@ -58,14 +58,16 @@
 /* Trick: we set __end to va + 64k, which happens works for
  * a 16M page as well as we want only one iteration
  */
-#define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)	    \
-        do {                                                                \
-                unsigned long __end = va + PAGE_SIZE;                       \
-                unsigned __split = (psize == MMU_PAGE_4K ||                 \
-				    psize == MMU_PAGE_64K_AP);              \
-                shift = mmu_psize_defs[psize].shift;                        \
-		for (index = 0; va < __end; index++, va += (1L << shift)) { \
-		        if (!__split || __rpte_sub_valid(rpte, index)) do { \
+#define pte_iterate_hashed_subpages(rpte, psize, vpn, index, shift)	\
+	do {								\
+		unsigned long __end = vpn + (1UL << (PAGE_SHIFT - VPN_SHIFT));	\
+		unsigned __split = (psize == MMU_PAGE_4K ||		\
+				    psize == MMU_PAGE_64K_AP);		\
+		shift = mmu_psize_defs[psize].shift;			\
+		for (index = 0; vpn < __end; index++,			\
+			     vpn += (1L << (shift - VPN_SHIFT))) {	\
+			if (!__split || __rpte_sub_valid(rpte, index))	\
+				do {
 
 #define pte_iterate_hashed_end() } while(0); } } while(0)
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index 10fc8ec..9d184f1 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -117,7 +117,7 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
 	}
 
 	vsid = map->host_vsid;
-	va = hpt_va(orig_pte->eaddr, vsid, MMU_SEGSIZE_256M);
+	va = hpt_vpn(orig_pte->eaddr, vsid, MMU_SEGSIZE_256M);
 
 	if (!orig_pte->may_write)
 		rflags |= HPTE_R_PP;
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index a242b5d..534cc26 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -71,7 +71,7 @@ _GLOBAL(__hash_page_4K)
 	/* Save non-volatile registers.
 	 * r31 will hold "old PTE"
 	 * r30 is "new PTE"
-	 * r29 is "va"
+	 * r29 is vpn
 	 * r28 is a hash value
 	 * r27 is hashtab mask (maybe dynamic patched instead ?)
 	 */
@@ -119,10 +119,10 @@ BEGIN_FTR_SECTION
 	cmpdi	r9,0			/* check segment size */
 	bne	3f
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
-	/* Calc va and put it in r29 */
-	rldicr	r29,r5,28,63-28
-	rldicl	r3,r3,0,36
-	or	r29,r3,r29
+	/* Calc vpn and put it in r29 */
+	sldi	r29,r5,SID_SHIFT - VPN_SHIFT
+	rldicl  r28,r3,64 - VPN_SHIFT,64 - (SID_SHIFT - VPN_SHIFT)
+	or	r29,r28,r29
 
 	/* Calculate hash value for primary slot and store it in r28 */
 	rldicl	r5,r5,0,25		/* vsid & 0x0000007fffffffff */
@@ -130,14 +130,19 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	xor	r28,r5,r0
 	b	4f
 
-3:	/* Calc VA and hash in r29 and r28 for 1T segment */
-	sldi	r29,r5,40		/* vsid << 40 */
-	clrldi	r3,r3,24		/* ea & 0xffffffffff */
+3:	/* Calc vpn and put it in r29 */
+	sldi	r29,r5,SID_SHIFT_1T - VPN_SHIFT
+	rldicl  r28,r3,64 - VPN_SHIFT,64 - (SID_SHIFT_1T - VPN_SHIFT)
+	or	r29,r28,r29
+
+	/*
+	 * calculate hash value for primary slot and
+	 * store it in r28 for 1T segment
+	 */
 	rldic	r28,r5,25,25		/* (vsid << 25) & 0x7fffffffff */
 	clrldi	r5,r5,40		/* vsid & 0xffffff */
 	rldicl	r0,r3,64-12,36		/* (ea >> 12) & 0xfffffff */
 	xor	r28,r28,r5
-	or	r29,r3,r29		/* VA */
 	xor	r28,r28,r0		/* hash */
 
 	/* Convert linux PTE bits into HW equivalents */
@@ -193,7 +198,7 @@ htab_insert_pte:
 
 	/* Call ppc_md.hpte_insert */
 	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
-	mr	r4,r29			/* Retrieve va */
+	mr	r4,r29			/* Retrieve vpn */
 	li	r7,0			/* !bolted, !secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
 	ld	r9,STK_PARM(r9)(r1)	/* segment size */
@@ -216,7 +221,7 @@ _GLOBAL(htab_call_hpte_insert1)
 	
 	/* Call ppc_md.hpte_insert */
 	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
-	mr	r4,r29			/* Retrieve va */
+	mr	r4,r29			/* Retrieve vpn */
 	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
 	ld	r9,STK_PARM(r9)(r1)	/* segment size */
@@ -286,7 +291,7 @@ htab_modify_pte:
 	add	r3,r0,r3	/* add slot idx */
 
 	/* Call ppc_md.hpte_updatepp */
-	mr	r5,r29			/* va */
+	mr	r5,r29			/* vpn */
 	li	r6,MMU_PAGE_4K		/* page size */
 	ld	r7,STK_PARM(r9)(r1)	/* segment size */
 	ld	r8,STK_PARM(r8)(r1)	/* get "local" param */
@@ -347,7 +352,7 @@ _GLOBAL(__hash_page_4K)
 	/* Save non-volatile registers.
 	 * r31 will hold "old PTE"
 	 * r30 is "new PTE"
-	 * r29 is "va"
+	 * r29 is vpn
 	 * r28 is a hash value
 	 * r27 is hashtab mask (maybe dynamic patched instead ?)
 	 * r26 is the hidx mask
@@ -402,10 +407,14 @@ BEGIN_FTR_SECTION
 	cmpdi	r9,0			/* check segment size */
 	bne	3f
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
-	/* Calc va and put it in r29 */
-	rldicr	r29,r5,28,63-28		/* r29 = (vsid << 28) */
-	rldicl	r3,r3,0,36		/* r3 = (ea & 0x0fffffff) */
-	or	r29,r3,r29		/* r29 = va */
+	/* Calc vpn and put it in r29 */
+	sldi	r29,r5,SID_SHIFT - VPN_SHIFT
+	/*
+	 * clrldi r3,r3,64 - SID_SHIFT -->  ea & 0xfffffff
+	 * srdi	 r28,r3,VPN_SHIFT
+	 */
+	rldicl  r28,r3,64 - VPN_SHIFT,64 - (SID_SHIFT - VPN_SHIFT)
+	or	r29,r28,r29
 
 	/* Calculate hash value for primary slot and store it in r28 */
 	rldicl	r5,r5,0,25		/* vsid & 0x0000007fffffffff */
@@ -413,14 +422,23 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	xor	r28,r5,r0
 	b	4f
 
-3:	/* Calc VA and hash in r29 and r28 for 1T segment */
-	sldi	r29,r5,40		/* vsid << 40 */
-	clrldi	r3,r3,24		/* ea & 0xffffffffff */
+3:	/* Calc vpn and put it in r29 */
+	sldi	r29,r5,SID_SHIFT_1T - VPN_SHIFT
+	/*
+	 * clrldi r3,r3,64 - SID_SHIFT_1T -->  ea & 0xffffffffff
+	 * srdi	r28,r3,VPN_SHIFT
+	 */
+	rldicl  r28,r3,64 - VPN_SHIFT,64 - (SID_SHIFT_1T - VPN_SHIFT)
+	or	r29,r28,r29
+
+	/*
+	 * Calculate hash value for primary slot and
+	 * store it in r28  for 1T segment
+	 */
 	rldic	r28,r5,25,25		/* (vsid << 25) & 0x7fffffffff */
 	clrldi	r5,r5,40		/* vsid & 0xffffff */
 	rldicl	r0,r3,64-12,36		/* (ea >> 12) & 0xfffffff */
 	xor	r28,r28,r5
-	or	r29,r3,r29		/* VA */
 	xor	r28,r28,r0		/* hash */
 
 	/* Convert linux PTE bits into HW equivalents */
@@ -496,7 +514,7 @@ htab_special_pfn:
 
 	/* Call ppc_md.hpte_insert */
 	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
-	mr	r4,r29			/* Retrieve va */
+	mr	r4,r29			/* Retrieve vpn */
 	li	r7,0			/* !bolted, !secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
 	ld	r9,STK_PARM(r9)(r1)	/* segment size */
@@ -523,7 +541,7 @@ _GLOBAL(htab_call_hpte_insert1)
 
 	/* Call ppc_md.hpte_insert */
 	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
-	mr	r4,r29			/* Retrieve va */
+	mr	r4,r29			/* Retrieve vpn */
 	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
 	ld	r9,STK_PARM(r9)(r1)	/* segment size */
@@ -555,7 +573,7 @@ _GLOBAL(htab_call_hpte_remove)
 	 * useless now that the segment has been switched to 4k pages.
 	 */
 htab_inval_old_hpte:
-	mr	r3,r29			/* virtual addr */
+	mr	r3,r29			/* vpn */
 	mr	r4,r31			/* PTE.pte */
 	li	r5,0			/* PTE.hidx */
 	li	r6,MMU_PAGE_64K		/* psize */
@@ -628,7 +646,7 @@ htab_modify_pte:
 	add	r3,r0,r3	/* add slot idx */
 
 	/* Call ppc_md.hpte_updatepp */
-	mr	r5,r29			/* va */
+	mr	r5,r29			/* vpn */
 	li	r6,MMU_PAGE_4K		/* page size */
 	ld	r7,STK_PARM(r9)(r1)	/* segment size */
 	ld	r8,STK_PARM(r8)(r1)	/* get "local" param */
@@ -684,7 +702,7 @@ _GLOBAL(__hash_page_64K)
 	/* Save non-volatile registers.
 	 * r31 will hold "old PTE"
 	 * r30 is "new PTE"
-	 * r29 is "va"
+	 * r29 is vpn
 	 * r28 is a hash value
 	 * r27 is hashtab mask (maybe dynamic patched instead ?)
 	 */
@@ -737,10 +755,10 @@ BEGIN_FTR_SECTION
 	cmpdi	r9,0			/* check segment size */
 	bne	3f
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
-	/* Calc va and put it in r29 */
-	rldicr	r29,r5,28,63-28
-	rldicl	r3,r3,0,36
-	or	r29,r3,r29
+	/* Calc vpn and put it in r29 */
+	sldi	r29,r5,SID_SHIFT - VPN_SHIFT
+	rldicl  r28,r3,64 - VPN_SHIFT,64 - (SID_SHIFT - VPN_SHIFT)
+	or	r29,r28,r29
 
 	/* Calculate hash value for primary slot and store it in r28 */
 	rldicl	r5,r5,0,25		/* vsid & 0x0000007fffffffff */
@@ -748,14 +766,19 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	xor	r28,r5,r0
 	b	4f
 
-3:	/* Calc VA and hash in r29 and r28 for 1T segment */
-	sldi	r29,r5,40		/* vsid << 40 */
-	clrldi	r3,r3,24		/* ea & 0xffffffffff */
+3:	/* Calc vpn and put it in r29 */
+	sldi	r29,r5,SID_SHIFT_1T - VPN_SHIFT
+	rldicl  r28,r3,64 - VPN_SHIFT,64 - (SID_SHIFT_1T - VPN_SHIFT)
+	or	r29,r28,r29
+
+	/*
+	 * calculate hash value for primary slot and
+	 * store it in r28 for 1T segment
+	 */
 	rldic	r28,r5,25,25		/* (vsid << 25) & 0x7fffffffff */
 	clrldi	r5,r5,40		/* vsid & 0xffffff */
 	rldicl	r0,r3,64-16,40		/* (ea >> 16) & 0xffffff */
 	xor	r28,r28,r5
-	or	r29,r3,r29		/* VA */
 	xor	r28,r28,r0		/* hash */
 
 	/* Convert linux PTE bits into HW equivalents */
@@ -814,7 +837,7 @@ ht64_insert_pte:
 
 	/* Call ppc_md.hpte_insert */
 	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
-	mr	r4,r29			/* Retrieve va */
+	mr	r4,r29			/* Retrieve vpn */
 	li	r7,0			/* !bolted, !secondary */
 	li	r8,MMU_PAGE_64K
 	ld	r9,STK_PARM(r9)(r1)	/* segment size */
@@ -837,7 +860,7 @@ _GLOBAL(ht64_call_hpte_insert1)
 
 	/* Call ppc_md.hpte_insert */
 	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
-	mr	r4,r29			/* Retrieve va */
+	mr	r4,r29			/* Retrieve vpn */
 	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
 	li	r8,MMU_PAGE_64K
 	ld	r9,STK_PARM(r9)(r1)	/* segment size */
@@ -907,7 +930,7 @@ ht64_modify_pte:
 	add	r3,r0,r3	/* add slot idx */
 
 	/* Call ppc_md.hpte_updatepp */
-	mr	r5,r29			/* va */
+	mr	r5,r29			/* vpn */
 	li	r6,MMU_PAGE_64K
 	ld	r7,STK_PARM(r9)(r1)	/* segment size */
 	ld	r8,STK_PARM(r8)(r1)	/* get "local" param */
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 660b8bb..aa6f4f0 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -39,22 +39,35 @@
 
 DEFINE_RAW_SPINLOCK(native_tlbie_lock);
 
-static inline void __tlbie(unsigned long va, int psize, int ssize)
+static inline void __tlbie(unsigned long vpn, int psize, int ssize)
 {
+	unsigned long va;
 	unsigned int penc;
 
+	/*
+	 * We need 14 to 65 bits of va for a tlibe of 4K page
+	 * With vpn we ignore the lower VPN_SHIFT bits already.
+	 * And top two bits are already ignored because we can
+	 * only accomadate 76 bits in a 64 bit vpn with a VPN_SHIFT
+	 * of 12.
+	 */
+	BUG_ON((77 - 65) > VPN_SHIFT);
+	va = vpn << VPN_SHIFT;
+
+#if 1 /* FIXME!! What is this about ? */
 	/* clear top 16 bits, non SLS segment */
 	va &= ~(0xffffULL << 48);
+#endif
 
 	switch (psize) {
 	case MMU_PAGE_4K:
-		va &= ~0xffful;
 		va |= ssize << 8;
 		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%1,%0), %2)
 			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
 			     : "memory");
 		break;
 	default:
+		/* We need 14 to 14 + i bits of va */
 		penc = mmu_psize_defs[psize].penc;
 		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
 		va |= penc << 12;
@@ -67,21 +80,27 @@ static inline void __tlbie(unsigned long va, int psize, int ssize)
 	}
 }
 
-static inline void __tlbiel(unsigned long va, int psize, int ssize)
+static inline void __tlbiel(unsigned long vpn, int psize, int ssize)
 {
+	unsigned long va;
 	unsigned int penc;
 
+	BUG_ON((77 - 65) > VPN_SHIFT);
+	va = vpn << VPN_SHIFT;
+
+#if 1 /*FIXME!! What is this about ? */
 	/* clear top 16 bits, non SLS segment */
 	va &= ~(0xffffULL << 48);
+#endif
 
 	switch (psize) {
 	case MMU_PAGE_4K:
-		va &= ~0xffful;
 		va |= ssize << 8;
 		asm volatile(".long 0x7c000224 | (%0 << 11) | (0 << 21)"
 			     : : "r"(va) : "memory");
 		break;
 	default:
+		/* We need 14 to 14 + i bits of va */
 		penc = mmu_psize_defs[psize].penc;
 		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
 		va |= penc << 12;
@@ -234,7 +253,7 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 
 	want_v = hpte_encode_v(va, psize, ssize);
 
-	DBG_LOW("    update(va=%016lx, avpnv=%016lx, hash=%016lx, newpp=%x)",
+	DBG_LOW("    update(va=%016lx, avpnv=%016lx, group=%lx, newpp=%lx)",
 		va, want_v & HPTE_V_AVPN, slot, newpp);
 
 	native_lock_hpte(hptep);
@@ -300,7 +319,7 @@ static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 	struct hash_pte *hptep;
 
 	vsid = get_kernel_vsid(ea, ssize);
-	va = hpt_va(ea, vsid, ssize);
+	va = hpt_vpn(ea, vsid, ssize);
 
 	slot = native_hpte_find(va, psize, ssize);
 	if (slot == -1)
@@ -325,7 +344,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long va,
 
 	local_irq_save(flags);
 
-	DBG_LOW("    invalidate(va=%016lx, hash: %x)\n", va, slot);
+	DBG_LOW("    invalidate(va=%016lx, hash: %lx)\n", va, slot);
 
 	want_v = hpte_encode_v(va, psize, ssize);
 	native_lock_hpte(hptep);
@@ -399,7 +418,7 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			vpi = (vsid ^ pteg) & htab_hash_mask;
 			seg_off |= vpi << shift;
 		}
-		*va = vsid << SID_SHIFT | seg_off;
+		*va = vsid << (SID_SHIFT - VPN_SHIFT) | seg_off >> VPN_SHIFT;
 	case MMU_SEGSIZE_1T:
 		/* We only have 40 - 23 bits of seg_off in avpn */
 		seg_off = (avpn & 0x1ffff) << 23;
@@ -408,7 +427,7 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			vpi = (vsid ^ (vsid << 25) ^ pteg) & htab_hash_mask;
 			seg_off |= vpi << shift;
 		}
-		*va = vsid << SID_SHIFT_1T | seg_off;
+		*va = vsid << (SID_SHIFT_1T - VPN_SHIFT) | seg_off >> VPN_SHIFT;
 	default:
 		*va = size = 0;
 	}
@@ -425,9 +444,10 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
  */
 static void native_hpte_clear(void)
 {
+	unsigned long va = 0;
 	unsigned long slot, slots, flags;
 	struct hash_pte *hptep = htab_address;
-	unsigned long hpte_v, va;
+	unsigned long hpte_v;
 	unsigned long pteg_count;
 	int psize, ssize;
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 377e5cb..975c7d1 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -192,7 +192,7 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 	     vaddr += step, paddr += step) {
 		unsigned long hash, hpteg;
 		unsigned long vsid = get_kernel_vsid(vaddr, ssize);
-		unsigned long va = hpt_va(vaddr, vsid, ssize);
+		unsigned long va  = hpt_vpn(vaddr, vsid, ssize);
 		unsigned long tprot = prot;
 
 		/* Make kernel text executable */
@@ -1208,7 +1208,7 @@ static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
 {
 	unsigned long hash, hpteg;
 	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
-	unsigned long va = hpt_va(vaddr, vsid, mmu_kernel_ssize);
+	unsigned long va = hpt_vpn(vaddr, vsid, mmu_kernel_ssize);
 	unsigned long mode = htab_convert_pte_flags(PAGE_KERNEL);
 	int ret;
 
@@ -1229,7 +1229,7 @@ static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long lmi)
 {
 	unsigned long hash, hidx, slot;
 	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
-	unsigned long va = hpt_va(vaddr, vsid, mmu_kernel_ssize);
+	unsigned long va = hpt_vpn(vaddr, vsid, mmu_kernel_ssize);
 
 	hash = hpt_hash(va, PAGE_SHIFT, mmu_kernel_ssize);
 	spin_lock(&linear_map_hash_lock);
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index cc5c273..1331403 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -25,7 +25,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	BUG_ON(shift != mmu_psize_defs[mmu_psize].shift);
 
 	/* Search the Linux page table for a match with va */
-	va = hpt_va(ea, vsid, ssize);
+	va = hpt_vpn(ea, vsid, ssize);
 
 	/* At this point, we have a pte (old_pte) which can be used to build
 	 * or update an HPTE. There are 2 cases:
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index 31f1820..321c585 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -86,7 +86,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 		vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
 		ssize = mmu_kernel_ssize;
 	}
-	vaddr = hpt_va(addr, vsid, ssize);
+	vaddr = hpt_vpn(addr, vsid, ssize);
 	rpte = __real_pte(__pte(pte), ptep);
 
 	/*
diff --git a/arch/powerpc/platforms/cell/beat_htab.c b/arch/powerpc/platforms/cell/beat_htab.c
index b83077e..c8c7bf6 100644
--- a/arch/powerpc/platforms/cell/beat_htab.c
+++ b/arch/powerpc/platforms/cell/beat_htab.c
@@ -259,7 +259,7 @@ static void beat_lpar_hpte_updateboltedpp(unsigned long newpp,
 	u64 dummy0, dummy1;
 
 	vsid = get_kernel_vsid(ea, MMU_SEGSIZE_256M);
-	va = hpt_va(ea, vsid, MMU_SEGSIZE_256M);
+	va = hpt_vpn(ea, vsid, MMU_SEGSIZE_256M);
 
 	raw_spin_lock(&beat_htab_lock);
 	slot = beat_lpar_hpte_find(va, psize);
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 5f3ef87..2127529 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -227,22 +227,6 @@ static void pSeries_lpar_hptab_clear(void)
 }
 
 /*
- * This computes the AVPN and B fields of the first dword of a HPTE,
- * for use when we want to match an existing PTE.  The bottom 7 bits
- * of the returned value are zero.
- */
-static inline unsigned long hpte_encode_avpn(unsigned long va, int psize,
-					     int ssize)
-{
-	unsigned long v;
-
-	v = (va >> 23) & ~(mmu_psize_defs[psize].avpnm);
-	v <<= HPTE_V_AVPN_SHIFT;
-	v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
-	return v;
-}
-
-/*
  * NOTE: for updatepp ops we are fortunate that the linux "newpp" bits and
  * the low 3 bits of flags happen to line up.  So no transform is needed.
  * We can probably optimize here and assume the high bits of newpp are
@@ -326,7 +310,7 @@ static void pSeries_lpar_hpte_updateboltedpp(unsigned long newpp,
 	unsigned long lpar_rc, slot, vsid, va, flags;
 
 	vsid = get_kernel_vsid(ea, ssize);
-	va = hpt_va(ea, vsid, ssize);
+	va = hpt_vpn(ea, vsid, ssize);
 
 	slot = pSeries_lpar_hpte_find(va, psize, ssize);
 	BUG_ON(slot == -1);
@@ -361,7 +345,7 @@ static void pSeries_lpar_hpte_removebolted(unsigned long ea,
 	unsigned long slot, vsid, va;
 
 	vsid = get_kernel_vsid(ea, ssize);
-	va = hpt_va(ea, vsid, ssize);
+	va = hpt_vpn(ea, vsid, ssize);
 
 	slot = pSeries_lpar_hpte_find(va, psize, ssize);
 	BUG_ON(slot == -1);
-- 
1.7.10
