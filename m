Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 212D11007D6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 00:17:59 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 29 Jun 2012 15:04:52 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5TEHtlF57147528
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 00:17:55 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5TEHtg1032740
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 00:17:55 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 anton@samba.org
Subject: [PATCH -V1 4/9] arch/powerpc: Use vsid and segment offset to
 represent virtual address
Date: Fri, 29 Jun 2012 19:47:32 +0530
Message-Id: <1340979457-26018-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1340979457-26018-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1340979457-26018-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

This patch enables us to have 78 bit virtual address.

With 1TB segments we use 40 bits of virtual adress as segment offset and
the remaining 24 bits (of the current 64 bit virtual address) are used
to index the virtual segment. Out of the 24 bits we currently use 19 bits
for user context and that leave us with only 4 bits for effective segment
ID. In-order to support more than 16TB of memory we would require more than
4 ESID bits. This patch splits the virtual address to two unsigned long
components, vsid and segment offset thereby allowing us to support 78 bit
virtual address.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h |   62 ++++++++---
 arch/powerpc/mm/hash_low_64.S         |  191 ++++++++++++++++++---------------
 arch/powerpc/mm/hash_native_64.c      |   36 ++++---
 arch/powerpc/mm/hash_utils_64.c       |    6 +-
 arch/powerpc/platforms/ps3/htab.c     |   13 +--
 arch/powerpc/platforms/pseries/lpar.c |   29 ++---
 6 files changed, 192 insertions(+), 145 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 5ff936b..e48c66b 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -143,8 +143,10 @@ struct mmu_psize_def
 	unsigned long	sllp;	/* SLB L||LP (exact mask to use in slbmte) */
 };
 
+/* 78 bit power virtual address */
 struct virt_addr {
-	unsigned long addr;
+	unsigned long vsid;
+	unsigned long seg_off;
 };
 
 #endif /* __ASSEMBLY__ */
@@ -161,6 +163,13 @@ struct virt_addr {
 
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
@@ -184,6 +193,32 @@ extern unsigned long tce_alloc_start, tce_alloc_end;
 extern int mmu_ci_restrictions;
 
 /*
+ * This computes the AVPN and B fields of the first dword of a HPTE,
+ * for use when we want to match an existing PTE.  The bottom 7 bits
+ * of the returned value are zero.
+ */
+static inline unsigned long hpte_encode_avpn(struct virt_addr va, int psize,
+					     int ssize)
+{
+	unsigned long v;
+
+	/*
+	 * The AVA field omits the low-order 23 bits of the 78 bits VA.
+	 * These bits are not needed in the PTE, because the
+	 * low-order b of these bits are part of the byte offset
+	 * into the virtual page and, if b < 23, the high-order
+	 * 23-b of these bits are always used in selecting the
+	 * PTEGs to be searched
+	 */
+	v = va.seg_off >> 23;
+	v |= va.vsid << (segment_shift(ssize) - 23);
+	v &= ~(mmu_psize_defs[psize].avpnm);
+	v <<= HPTE_V_AVPN_SHIFT;
+	v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
+	return v;
+}
+
+/*
  * This function sets the AVPN and L fields of the HPTE  appropriately
  * for the page size
  */
@@ -191,11 +226,9 @@ static inline unsigned long hpte_encode_v(struct virt_addr va, int psize,
 					  int ssize)
 {
 	unsigned long v;
-	v = (va.addr >> 23) & ~(mmu_psize_defs[psize].avpnm);
-	v <<= HPTE_V_AVPN_SHIFT;
+	v = hpte_encode_avpn(va, psize, ssize);
 	if (psize != MMU_PAGE_4K)
 		v |= HPTE_V_LARGE;
-	v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
 	return v;
 }
 
@@ -222,30 +255,31 @@ static inline unsigned long hpte_encode_r(unsigned long pa, int psize)
 /*
  * Build a VA given VSID, EA and segment size
  */
-static inline struct virt_addr hpt_va(unsigned long ea, unsigned long vsid,
-				   int ssize)
+static inline struct virt_addr hpt_va(unsigned long ea, unsigned long vsid, int ssize)
 {
 	struct virt_addr va;
+
+	va.vsid    = vsid;
 	if (ssize == MMU_SEGSIZE_256M)
-		va.addr = (vsid << 28) | (ea & 0xfffffffUL);
-	va.addr = (vsid << 40) | (ea & 0xffffffffffUL);
+		va.seg_off = ea & 0xfffffffUL;
+	else
+		va.seg_off = ea & 0xffffffffffUL;
 	return va;
 }
 
 /*
  * This hashes a virtual address
  */
-
-static inline unsigned long hpt_hash(struct virt_addr va, unsigned int shift,
-				     int ssize)
+/* Verify */
+static inline unsigned long hpt_hash(struct virt_addr va, unsigned int shift, int ssize)
 {
 	unsigned long hash, vsid;
 
 	if (ssize == MMU_SEGSIZE_256M) {
-		hash = (va.addr >> 28) ^ ((va.addr & 0x0fffffffUL) >> shift);
+		hash = (va.vsid & 0x0000007fffffffff) ^ (va.seg_off >> shift);
 	} else {
-		vsid = va.addr >> 40;
-		hash = vsid ^ (vsid << 25) ^ ((va.addr & 0xffffffffffUL) >> shift);
+		vsid = va.vsid;
+		hash = vsid ^ (vsid << 25) ^ (va.seg_off >> shift);
 	}
 	return hash & 0x7fffffffffUL;
 }
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index a242b5d..cf66a0a 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -71,10 +71,12 @@ _GLOBAL(__hash_page_4K)
 	/* Save non-volatile registers.
 	 * r31 will hold "old PTE"
 	 * r30 is "new PTE"
-	 * r29 is "va"
+	 * r29 is vsid
 	 * r28 is a hash value
 	 * r27 is hashtab mask (maybe dynamic patched instead ?)
+	 * r26 is seg_off
 	 */
+	std	r26,STK_REG(r26)(r1)
 	std	r27,STK_REG(r27)(r1)
 	std	r28,STK_REG(r28)(r1)
 	std	r29,STK_REG(r29)(r1)
@@ -119,10 +121,9 @@ BEGIN_FTR_SECTION
 	cmpdi	r9,0			/* check segment size */
 	bne	3f
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
-	/* Calc va and put it in r29 */
-	rldicr	r29,r5,28,63-28
-	rldicl	r3,r3,0,36
-	or	r29,r3,r29
+	/* r29 is virtual address and r26 is seg_off */
+	mr	r29,r5			/* vsid */
+	rldicl	r26,r3,0,36		/* ea & 0x000000000fffffffUL */
 
 	/* Calculate hash value for primary slot and store it in r28 */
 	rldicl	r5,r5,0,25		/* vsid & 0x0000007fffffffff */
@@ -130,14 +131,17 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	xor	r28,r5,r0
 	b	4f
 
-3:	/* Calc VA and hash in r29 and r28 for 1T segment */
-	sldi	r29,r5,40		/* vsid << 40 */
-	clrldi	r3,r3,24		/* ea & 0xffffffffff */
+3:	/* r29 is virtual address and r26 is seg_off */
+	mr	r29,r5			/* vsid */
+	rldicl	r26,r3,0,24		/* ea & 0xffffffffff */
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
@@ -183,20 +187,21 @@ htab_insert_pte:
 	andc	r30,r30,r0
 	ori	r30,r30,_PAGE_HASHPTE
 
-	/* physical address r5 */
-	rldicl	r5,r31,64-PTE_RPN_SHIFT,PTE_RPN_SHIFT
-	sldi	r5,r5,PAGE_SHIFT
+	/* physical address r6 */
+	rldicl	r6,r31,64-PTE_RPN_SHIFT,PTE_RPN_SHIFT
+	sldi	r6,r6,PAGE_SHIFT
 
 	/* Calculate primary group hash */
 	and	r0,r28,r27
 	rldicr	r3,r0,3,63-3		/* r3 = (hash & mask) << 3 */
 
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
-	mr	r4,r29			/* Retrieve va */
-	li	r7,0			/* !bolted, !secondary */
-	li	r8,MMU_PAGE_4K		/* page size */
-	ld	r9,STK_PARM(r9)(r1)	/* segment size */
+	ld	r7,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
+	mr	r4,r29			/* Retrieve vsid */
+	mr	r5,r26			/* seg_off */
+	li	r8,0			/* !bolted, !secondary */
+	li	r9,MMU_PAGE_4K		/* page size */
+	ld	r10,STK_PARM(r9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert1)
 	bl	.			/* Patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -206,20 +211,21 @@ _GLOBAL(htab_call_hpte_insert1)
 
 	/* Now try secondary slot */
 	
-	/* physical address r5 */
-	rldicl	r5,r31,64-PTE_RPN_SHIFT,PTE_RPN_SHIFT
-	sldi	r5,r5,PAGE_SHIFT
+	/* physical address r6 */
+	rldicl	r6,r31,64-PTE_RPN_SHIFT,PTE_RPN_SHIFT
+	sldi	r6,r6,PAGE_SHIFT
 
 	/* Calculate secondary group hash */
 	andc	r0,r27,r28
 	rldicr	r3,r0,3,63-3	/* r0 = (~hash & mask) << 3 */
 	
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
-	mr	r4,r29			/* Retrieve va */
-	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
-	li	r8,MMU_PAGE_4K		/* page size */
-	ld	r9,STK_PARM(r9)(r1)	/* segment size */
+	ld	r7,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
+	mr	r4,r29			/* Retrieve vsid */
+	mr	r5,r26			/* seg_off */
+	li	r8,HPTE_V_SECONDARY	/* !bolted, secondary */
+	li	r9,MMU_PAGE_4K		/* page size */
+	ld	r10,STK_PARM(r9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert2)
 	bl	.			/* Patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -286,13 +292,13 @@ htab_modify_pte:
 	add	r3,r0,r3	/* add slot idx */
 
 	/* Call ppc_md.hpte_updatepp */
-	mr	r5,r29			/* va */
-	li	r6,MMU_PAGE_4K		/* page size */
-	ld	r7,STK_PARM(r9)(r1)	/* segment size */
-	ld	r8,STK_PARM(r8)(r1)	/* get "local" param */
+	mr	r5,r29			/* vsid */
+	mr	r6,r26			/* seg off */
+	li	r7,MMU_PAGE_4K		/* page size */
+	ld	r8,STK_PARM(r9)(r1)	/* segment size */
+	ld	r9,STK_PARM(r8)(r1)	/* get "local" param */
 _GLOBAL(htab_call_hpte_updatepp)
 	bl	.			/* Patched by htab_finish_init() */
-
 	/* if we failed because typically the HPTE wasn't really here
 	 * we try an insertion. 
 	 */
@@ -347,12 +353,14 @@ _GLOBAL(__hash_page_4K)
 	/* Save non-volatile registers.
 	 * r31 will hold "old PTE"
 	 * r30 is "new PTE"
-	 * r29 is "va"
+	 * r29 is vsid
 	 * r28 is a hash value
 	 * r27 is hashtab mask (maybe dynamic patched instead ?)
 	 * r26 is the hidx mask
 	 * r25 is the index in combo page
+	 * r24 is seg_off
 	 */
+	std	r24,STK_REG(r24)(r1)
 	std	r25,STK_REG(r25)(r1)
 	std	r26,STK_REG(r26)(r1)
 	std	r27,STK_REG(r27)(r1)
@@ -402,10 +410,9 @@ BEGIN_FTR_SECTION
 	cmpdi	r9,0			/* check segment size */
 	bne	3f
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
-	/* Calc va and put it in r29 */
-	rldicr	r29,r5,28,63-28		/* r29 = (vsid << 28) */
-	rldicl	r3,r3,0,36		/* r3 = (ea & 0x0fffffff) */
-	or	r29,r3,r29		/* r29 = va */
+	/* r29 is virtual address and r24 is seg_off */
+	mr	r29,r5			/* vsid */
+	rldicl	r24,r3,0,36		/* ea & 0x000000000fffffffUL */
 
 	/* Calculate hash value for primary slot and store it in r28 */
 	rldicl	r5,r5,0,25		/* vsid & 0x0000007fffffffff */
@@ -413,14 +420,17 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	xor	r28,r5,r0
 	b	4f
 
-3:	/* Calc VA and hash in r29 and r28 for 1T segment */
-	sldi	r29,r5,40		/* vsid << 40 */
-	clrldi	r3,r3,24		/* ea & 0xffffffffff */
+3:	/* r29 is virtual address and r24 is seg_off */
+	mr	r29,r5			/* vsid */
+	rldicl	r24,r3,0,24		/* ea & 0xffffffffff */
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
@@ -481,25 +491,26 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FTR_COHERENT_ICACHE, CPU_FTR_NOEXECUTE)
 	bne	htab_modify_pte
 
 htab_insert_pte:
-	/* real page number in r5, PTE RPN value + index */
+	/* real page number in r6, PTE RPN value + index */
 	andis.	r0,r31,_PAGE_4K_PFN@h
 	srdi	r5,r31,PTE_RPN_SHIFT
 	bne-	htab_special_pfn
 	sldi	r5,r5,PAGE_SHIFT-HW_PAGE_SHIFT
 	add	r5,r5,r25
 htab_special_pfn:
-	sldi	r5,r5,HW_PAGE_SHIFT
+	sldi	r6,r5,HW_PAGE_SHIFT
 
 	/* Calculate primary group hash */
 	and	r0,r28,r27
 	rldicr	r3,r0,3,63-3		/* r0 = (hash & mask) << 3 */
 
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
-	mr	r4,r29			/* Retrieve va */
-	li	r7,0			/* !bolted, !secondary */
-	li	r8,MMU_PAGE_4K		/* page size */
-	ld	r9,STK_PARM(r9)(r1)	/* segment size */
+	ld	r7,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
+	mr	r4,r29			/* Retrieve vsid */
+	mr      r5,r24			/* seg off */
+	li	r8,0			/* !bolted, !secondary */
+	li	r9,MMU_PAGE_4K		/* page size */
+	ld	r10,STK_PARM(r9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert1)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -515,18 +526,19 @@ _GLOBAL(htab_call_hpte_insert1)
 	bne-	3f
 	sldi	r5,r5,PAGE_SHIFT-HW_PAGE_SHIFT
 	add	r5,r5,r25
-3:	sldi	r5,r5,HW_PAGE_SHIFT
+3:	sldi	r6,r5,HW_PAGE_SHIFT
 
 	/* Calculate secondary group hash */
 	andc	r0,r27,r28
 	rldicr	r3,r0,3,63-3		/* r0 = (~hash & mask) << 3 */
 
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
-	mr	r4,r29			/* Retrieve va */
-	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
-	li	r8,MMU_PAGE_4K		/* page size */
-	ld	r9,STK_PARM(r9)(r1)	/* segment size */
+	ld	r7,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
+	mr	r4,r29			/* Retrieve vsid */
+	mr      r5,r24			/* seg off */
+	li	r8,HPTE_V_SECONDARY	/* !bolted, secondary */
+	li	r9,MMU_PAGE_4K		/* page size */
+	ld	r10,STK_PARM(r9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert2)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -628,13 +640,13 @@ htab_modify_pte:
 	add	r3,r0,r3	/* add slot idx */
 
 	/* Call ppc_md.hpte_updatepp */
-	mr	r5,r29			/* va */
-	li	r6,MMU_PAGE_4K		/* page size */
-	ld	r7,STK_PARM(r9)(r1)	/* segment size */
-	ld	r8,STK_PARM(r8)(r1)	/* get "local" param */
+	mr	r5,r29			/* vsid */
+	mr      r6,r24			/* seg off */
+	li	r7,MMU_PAGE_4K		/* page size */
+	ld	r8,STK_PARM(r9)(r1)	/* segment size */
+	ld	r9,STK_PARM(r8)(r1)	/* get "local" param */
 _GLOBAL(htab_call_hpte_updatepp)
 	bl	.			/* patched by htab_finish_init() */
-
 	/* if we failed because typically the HPTE wasn't really here
 	 * we try an insertion.
 	 */
@@ -684,10 +696,12 @@ _GLOBAL(__hash_page_64K)
 	/* Save non-volatile registers.
 	 * r31 will hold "old PTE"
 	 * r30 is "new PTE"
-	 * r29 is "va"
+	 * r29 is vsid
 	 * r28 is a hash value
 	 * r27 is hashtab mask (maybe dynamic patched instead ?)
+	 * r26 is seg off
 	 */
+	std	r26,STK_REG(r26)(r1)
 	std	r27,STK_REG(r27)(r1)
 	std	r28,STK_REG(r28)(r1)
 	std	r29,STK_REG(r29)(r1)
@@ -737,10 +751,9 @@ BEGIN_FTR_SECTION
 	cmpdi	r9,0			/* check segment size */
 	bne	3f
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
-	/* Calc va and put it in r29 */
-	rldicr	r29,r5,28,63-28
-	rldicl	r3,r3,0,36
-	or	r29,r3,r29
+	/* r29 is virtual address and r26 is seg_off */
+	mr	r29,r5			/* vsid */
+	rldicl	r26,r3,0,36		/* ea & 0x000000000fffffffUL */
 
 	/* Calculate hash value for primary slot and store it in r28 */
 	rldicl	r5,r5,0,25		/* vsid & 0x0000007fffffffff */
@@ -748,14 +761,17 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	xor	r28,r5,r0
 	b	4f
 
-3:	/* Calc VA and hash in r29 and r28 for 1T segment */
-	sldi	r29,r5,40		/* vsid << 40 */
-	clrldi	r3,r3,24		/* ea & 0xffffffffff */
+3:	/* r29 is virtual address and r26 is seg_off */
+	mr	r29,r5			/* vsid */
+	rldicl	r26,r3,0,24		/* ea & 0xffffffffff */
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
@@ -804,20 +820,21 @@ ht64_insert_pte:
 #else
 	ori	r30,r30,_PAGE_HASHPTE
 #endif
-	/* Phyical address in r5 */
-	rldicl	r5,r31,64-PTE_RPN_SHIFT,PTE_RPN_SHIFT
-	sldi	r5,r5,PAGE_SHIFT
+	/* Phyical address in r6 */
+	rldicl	r6,r31,64-PTE_RPN_SHIFT,PTE_RPN_SHIFT
+	sldi	r6,r6,PAGE_SHIFT
 
 	/* Calculate primary group hash */
 	and	r0,r28,r27
 	rldicr	r3,r0,3,63-3	/* r0 = (hash & mask) << 3 */
 
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
-	mr	r4,r29			/* Retrieve va */
-	li	r7,0			/* !bolted, !secondary */
-	li	r8,MMU_PAGE_64K
-	ld	r9,STK_PARM(r9)(r1)	/* segment size */
+	ld	r7,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
+	mr	r4,r29			/* Retrieve vsid */
+	mr	r5,r26			/* seg_off */
+	li	r8,0			/* !bolted, !secondary */
+	li	r9,MMU_PAGE_64K
+	ld	r10,STK_PARM(r9)(r1)	/* segment size */
 _GLOBAL(ht64_call_hpte_insert1)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -827,20 +844,21 @@ _GLOBAL(ht64_call_hpte_insert1)
 
 	/* Now try secondary slot */
 
-	/* Phyical address in r5 */
-	rldicl	r5,r31,64-PTE_RPN_SHIFT,PTE_RPN_SHIFT
-	sldi	r5,r5,PAGE_SHIFT
+	/* Phyical address in r6 */
+	rldicl	r6,r31,64-PTE_RPN_SHIFT,PTE_RPN_SHIFT
+	sldi	r6,r6,PAGE_SHIFT
 
 	/* Calculate secondary group hash */
 	andc	r0,r27,r28
 	rldicr	r3,r0,3,63-3	/* r0 = (~hash & mask) << 3 */
 
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
-	mr	r4,r29			/* Retrieve va */
-	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
-	li	r8,MMU_PAGE_64K
-	ld	r9,STK_PARM(r9)(r1)	/* segment size */
+	ld	r7,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
+	mr	r4,r29			/* Retrieve vsid */
+	mr	r5,r26			/* seg_off */
+	li	r8,HPTE_V_SECONDARY	/* !bolted, secondary */
+	li	r9,MMU_PAGE_64K
+	ld	r10,STK_PARM(r9)(r1)	/* segment size */
 _GLOBAL(ht64_call_hpte_insert2)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -907,10 +925,11 @@ ht64_modify_pte:
 	add	r3,r0,r3	/* add slot idx */
 
 	/* Call ppc_md.hpte_updatepp */
-	mr	r5,r29			/* va */
-	li	r6,MMU_PAGE_64K
-	ld	r7,STK_PARM(r9)(r1)	/* segment size */
-	ld	r8,STK_PARM(r8)(r1)	/* get "local" param */
+	mr	r5,r29			/* vsid */
+	mr	r6,r26			/* seg off */
+	li	r7,MMU_PAGE_64K
+	ld	r8,STK_PARM(r9)(r1)	/* segment size */
+	ld	r9,STK_PARM(r8)(r1)	/* get "local" param */
 _GLOBAL(ht64_call_hpte_updatepp)
 	bl	.			/* patched by htab_finish_init() */
 
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 76c2574..d65b63c 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -42,10 +42,12 @@ DEFINE_RAW_SPINLOCK(native_tlbie_lock);
 /* Verify docs says 14 .. 14+i bits */
 static inline void __tlbie(struct virt_addr va, int psize, int ssize)
 {
-	unsigned long vaddr = va.addr;
+	unsigned long vaddr;
 	unsigned int penc;
 
-	vaddr &= ~(0xffffULL << 48);
+	/* We need only lower 48 bit of va, non SLS segment */
+	vaddr = va.vsid << segment_shift(ssize);
+	vaddr |= va.seg_off;
 
 	/* clear top 16 bits, non SLS segment */
 	vaddr &= ~(0xffffULL << 48);
@@ -74,9 +76,13 @@ static inline void __tlbie(struct virt_addr va, int psize, int ssize)
 /* Verify docs says 14 .. 14+i bits */
 static inline void __tlbiel(struct virt_addr va, int psize, int ssize)
 {
-	unsigned long vaddr = va.addr;
+	unsigned long vaddr;
 	unsigned int penc;
 
+	/* We need only lower 48 bit of va, non SLS segment */
+	vaddr = va.vsid << segment_shift(ssize);
+	vaddr |= va.seg_off;
+
 	vaddr &= ~(0xffffULL << 48);
 
 	switch (psize) {
@@ -148,9 +154,9 @@ static long native_hpte_insert(unsigned long hpte_group, struct virt_addr va,
 	int i;
 
 	if (!(vflags & HPTE_V_BOLTED)) {
-		DBG_LOW("    insert(group=%lx, va=%016lx, pa=%016lx,"
-			" rflags=%lx, vflags=%lx, psize=%d)\n",
-			hpte_group, va, pa, rflags, vflags, psize);
+		DBG_LOW("    insert(group=%lx, vsid=%016lx, seg_off=%016lx, pa=%016lx,"
+			" rflags=%lx, vflags=%lx, psize=%d)\n", hpte_group,
+			va.vsid, va.seg_off, pa, rflags, vflags, psize);
 	}
 
 	for (i = 0; i < HPTES_PER_GROUP; i++) {
@@ -239,8 +245,9 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 
 	want_v = hpte_encode_v(va, psize, ssize);
 
-	DBG_LOW("    update(va=%016lx, avpnv=%016lx, hash=%016lx, newpp=%x)",
-		va, want_v & HPTE_V_AVPN, slot, newpp);
+	DBG_LOW("    update(vsid=%016lx, seg_off=%016lx, avpnv=%016lx, "
+		"hash=%016lx, newpp=%lx)", va.vsid, va.seg_off,
+		want_v & HPTE_V_AVPN, slot, newpp);
 
 	native_lock_hpte(hptep);
 
@@ -331,7 +338,7 @@ static void native_hpte_invalidate(unsigned long slot, struct virt_addr va,
 
 	local_irq_save(flags);
 
-	DBG_LOW("    invalidate(va=%016lx, hash: %x)\n", va, slot);
+	DBG_LOW("    invalidate(va=%016lx, seg=%016lx, hash: %lx)\n", va.vsid, va.seg_off, slot);
 
 	want_v = hpte_encode_v(va, psize, ssize);
 	native_lock_hpte(hptep);
@@ -405,7 +412,6 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			vpi = (vsid ^ pteg) & htab_hash_mask;
 			seg_off |= vpi << shift;
 		}
-		va->addr = vsid << 28 | seg_off;
 	case MMU_SEGSIZE_1T:
 		/* We only have 40 - 23 bits of seg_off in avpn */
 		seg_off = (avpn & 0x1ffff) << 23;
@@ -414,12 +420,12 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			vpi = (vsid ^ (vsid << 25) ^ pteg) & htab_hash_mask;
 			seg_off |= vpi << shift;
 		}
-		va->addr = vsid << 40 | seg_off;
 	default:
 		seg_off = 0;
 		vsid    = 0;
-		va->addr = 0;
 	}
+	va->vsid = vsid;
+	va->seg_off = seg_off;
 	*psize = size;
 }
 
@@ -499,7 +505,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 		va = batch->vaddr[i];
 		pte = batch->pte[i];
 
-		pte_iterate_hashed_subpages(pte, psize, va.addr, index, shift) {
+		pte_iterate_hashed_subpages(pte, psize, va.seg_off, index, shift) {
 			hash = hpt_hash(va, shift, ssize);
 			hidx = __rpte_to_hidx(pte, index);
 			if (hidx & _PTEIDX_SECONDARY)
@@ -525,7 +531,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 			va = batch->vaddr[i];
 			pte = batch->pte[i];
 
-			pte_iterate_hashed_subpages(pte, psize, va.addr, index,
+			pte_iterate_hashed_subpages(pte, psize, va.seg_off, index,
 						    shift) {
 				__tlbiel(va, psize, ssize);
 			} pte_iterate_hashed_end();
@@ -542,7 +548,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 			va = batch->vaddr[i];
 			pte = batch->pte[i];
 
-			pte_iterate_hashed_subpages(pte, psize, va.addr, index,
+			pte_iterate_hashed_subpages(pte, psize, va.seg_off, index,
 						    shift) {
 				__tlbie(va, psize, ssize);
 			} pte_iterate_hashed_end();
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 2429d53..8b5d3c2 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1158,8 +1158,10 @@ void flush_hash_page(struct virt_addr va, real_pte_t pte, int psize, int ssize,
 {
 	unsigned long hash, index, shift, hidx, slot;
 
-	DBG_LOW("flush_hash_page(va=%016lx)\n", va.addr);
-	pte_iterate_hashed_subpages(pte, psize, va.addr, index, shift) {
+	DBG_LOW("flush_hash_page(vsid=%016lx seg_off=%016lx)\n",
+		va.vsid, va.seg_off);
+	/* since we won't cross segments, use seg_off for iteration */
+	pte_iterate_hashed_subpages(pte, psize, va.seg_off, index, shift) {
 		hash = hpt_hash(va, shift, ssize);
 		hidx = __rpte_to_hidx(pte, index);
 		if (hidx & _PTEIDX_SECONDARY)
diff --git a/arch/powerpc/platforms/ps3/htab.c b/arch/powerpc/platforms/ps3/htab.c
index 6e27576..4aa969d 100644
--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -75,8 +75,9 @@ static long ps3_hpte_insert(unsigned long hpte_group, struct virt_addr va,
 
 	if (result) {
 		/* all entries bolted !*/
-		pr_info("%s:result=%d va=%lx pa=%lx ix=%lx v=%llx r=%llx\n",
-			__func__, result, va, pa, hpte_group, hpte_v, hpte_r);
+		pr_info("%s:result=%d vsid=%lx seg_off=%lx pa=%lx ix=%lx "
+			"v=%llx r=%llx\n", __func__, result, va.vsid,
+			va.seg_off, pa, hpte_group, hpte_v, hpte_r);
 		BUG();
 	}
 
@@ -125,8 +126,8 @@ static long ps3_hpte_updatepp(unsigned long slot, unsigned long newpp,
 				       &hpte_rs);
 
 	if (result) {
-		pr_info("%s: res=%d read va=%lx slot=%lx psize=%d\n",
-			__func__, result, va, slot, psize);
+		pr_info("%s: res=%d read vsid=%lx seg_off=%lx slot=%lx psize=%d\n",
+			__func__, result, va.vsid, va.seg_off, slot, psize);
 		BUG();
 	}
 
@@ -170,8 +171,8 @@ static void ps3_hpte_invalidate(unsigned long slot, struct virt_addr va,
 	result = lv1_write_htab_entry(PS3_LPAR_VAS_ID_CURRENT, slot, 0, 0);
 
 	if (result) {
-		pr_info("%s: res=%d va=%lx slot=%lx psize=%d\n",
-			__func__, result, va, slot, psize);
+		pr_info("%s: res=%d vsid=%lx seg_off=%lx slot=%lx psize=%d\n",
+			__func__, result, va.vsid, va.seg_off, slot, psize);
 		BUG();
 	}
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index b4e9641..4c0848f 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -118,9 +118,10 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	unsigned long hpte_v, hpte_r;
 
 	if (!(vflags & HPTE_V_BOLTED))
-		pr_devel("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
-			 "rflags=%lx, vflags=%lx, psize=%d)\n",
-			 hpte_group, va.addr, pa, rflags, vflags, psize);
+		pr_devel("hpte_insert(group=%lx, vsid=%016lx, segoff=%016lx, "
+			 "pa=%016lx, rflags=%lx, vflags=%lx, psize=%d)\n",
+			 hpte_group, va.vsid, va.seg_off,
+			 pa, rflags, vflags, psize);
 
 	hpte_v = hpte_encode_v(va, psize, ssize) | vflags | HPTE_V_VALID;
 	hpte_r = hpte_encode_r(pa, psize) | rflags;
@@ -227,22 +228,6 @@ static void pSeries_lpar_hptab_clear(void)
 }
 
 /*
- * This computes the AVPN and B fields of the first dword of a HPTE,
- * for use when we want to match an existing PTE.  The bottom 7 bits
- * of the returned value are zero.
- */
-static inline unsigned long hpte_encode_avpn(struct virt_addr va, int psize,
-					     int ssize)
-{
-	unsigned long v;
-
-	v = (va.addr >> 23) & ~(mmu_psize_defs[psize].avpnm);
-	v <<= HPTE_V_AVPN_SHIFT;
-	v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
-	return v;
-}
-
-/*
  * NOTE: for updatepp ops we are fortunate that the linux "newpp" bits and
  * the low 3 bits of flags happen to line up.  So no transform is needed.
  * We can probably optimize here and assume the high bits of newpp are
@@ -345,8 +330,8 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, struct virt_addr va
 	unsigned long lpar_rc;
 	unsigned long dummy1, dummy2;
 
-	pr_devel("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
-		 slot, va.addr, psize, local);
+	pr_devel("    inval : slot=%lx, vsid=%016lx, seg_off=%016lx, psize: %d, local: %d\n",
+		 slot, va.vsid, va.seg_off, psize, local);
 
 	want_v = hpte_encode_avpn(va, psize, ssize);
 	lpar_rc = plpar_pte_remove(H_AVPN, slot, want_v, &dummy1, &dummy2);
@@ -403,7 +388,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	for (i = 0; i < number; i++) {
 		va = batch->vaddr[i];
 		pte = batch->pte[i];
-		pte_iterate_hashed_subpages(pte, psize, va.addr, index, shift) {
+		pte_iterate_hashed_subpages(pte, psize, va.seg_off, index, shift) {
 			hash = hpt_hash(va, shift, ssize);
 			hidx = __rpte_to_hidx(pte, index);
 			if (hidx & _PTEIDX_SECONDARY)
-- 
1.7.10
