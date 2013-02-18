Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4515A2C0291
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:28:46 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 15:56:50 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id CD0CE394004F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 15:58:37 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1IASXas33095884
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 15:58:33 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1IASZq5001032
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:28:35 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 06/17] powerpc/mm: Decode the pte-lp-encoding bits
 correctly.
Date: Mon, 18 Feb 2013 15:58:04 +0530
Message-Id: <1361183295-6958-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1361183295-6958-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1361183295-6958-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We look at both the segment base page size and actual page size and store
the pte-lp-encodings in an array per base page size.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h    |    3 +-
 arch/powerpc/include/asm/mmu-hash64.h |   12 ++--
 arch/powerpc/mm/hash_low_64.S         |   18 ++++--
 arch/powerpc/mm/hash_native_64.c      |  105 ++++++++++++++++++++++++---------
 arch/powerpc/mm/hash_utils_64.c       |  103 +++++++++++++++++++-------------
 arch/powerpc/platforms/pseries/lpar.c |    4 +-
 6 files changed, 163 insertions(+), 82 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 19d9d96..6cee6e0 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -50,7 +50,8 @@ struct machdep_calls {
 				       unsigned long prpn,
 				       unsigned long rflags,
 				       unsigned long vflags,
-				       int psize, int ssize);
+				       int psize, int apsize,
+				       int ssize);
 	long		(*hpte_remove)(unsigned long hpte_group);
 	void            (*hpte_removebolted)(unsigned long ea,
 					     int psize, int ssize);
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index c3b3518..6290e26 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -154,7 +154,7 @@ extern unsigned long htab_hash_mask;
 struct mmu_psize_def
 {
 	unsigned int	shift;	/* number of bits */
-	unsigned int	penc;	/* HPTE encoding */
+	unsigned int	penc[MMU_PAGE_COUNT];	/* HPTE encoding */
 	unsigned int	tlbiel;	/* tlbiel supported for that page size */
 	unsigned long	avpnm;	/* bits to mask out in AVPN in the HPTE */
 	unsigned long	sllp;	/* SLB L||LP (exact mask to use in slbmte) */
@@ -254,16 +254,18 @@ static inline unsigned long hpte_encode_v(unsigned long vpn,
  * for the page size. We assume the pa is already "clean" that is properly
  * aligned for the requested page size
  */
-static inline unsigned long hpte_encode_r(unsigned long pa, int psize)
+static inline unsigned long hpte_encode_r(unsigned long pa, int base_psize,
+					  int actual_psize)
 {
 	unsigned long r;
 
 	/* A 4K page needs no special encoding */
-	if (psize == MMU_PAGE_4K)
+	if (actual_psize == MMU_PAGE_4K)
 		return pa & HPTE_R_RPN;
 	else {
-		unsigned int penc = mmu_psize_defs[psize].penc;
-		unsigned int shift = mmu_psize_defs[psize].shift;
+		unsigned int penc = mmu_psize_defs[base_psize].penc[actual_psize];
+		unsigned int shift = mmu_psize_defs[actual_psize].shift;
+		/* FIXME!! replace 12 by LP_SHIFT ? */
 		return (pa & ~((1ul << shift) - 1)) | (penc << 12);
 	}
 	return r;
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index abdd5e2..0e980ac 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -196,7 +196,8 @@ htab_insert_pte:
 	mr	r4,r29			/* Retrieve vpn */
 	li	r7,0			/* !bolted, !secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
-	ld	r9,STK_PARAM(R9)(r1)	/* segment size */
+	li	r9,MMU_PAGE_4K		/* actual page size */
+	ld	r10,STK_PARAM(R9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert1)
 	bl	.			/* Patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -219,7 +220,8 @@ _GLOBAL(htab_call_hpte_insert1)
 	mr	r4,r29			/* Retrieve vpn */
 	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
-	ld	r9,STK_PARAM(R9)(r1)	/* segment size */
+	li	r9,MMU_PAGE_4K		/* actual page size */
+	ld	r10,STK_PARAM(R9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert2)
 	bl	.			/* Patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -515,7 +517,8 @@ htab_special_pfn:
 	mr	r4,r29			/* Retrieve vpn */
 	li	r7,0			/* !bolted, !secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
-	ld	r9,STK_PARAM(R9)(r1)	/* segment size */
+	li	r9,MMU_PAGE_4K		/* actual page size */
+	ld	r10,STK_PARAM(R9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert1)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -542,7 +545,8 @@ _GLOBAL(htab_call_hpte_insert1)
 	mr	r4,r29			/* Retrieve vpn */
 	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
-	ld	r9,STK_PARAM(R9)(r1)	/* segment size */
+	li	r9,MMU_PAGE_4K		/* actual page size */
+	ld	r10,STK_PARAM(R9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert2)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -840,7 +844,8 @@ ht64_insert_pte:
 	mr	r4,r29			/* Retrieve vpn */
 	li	r7,0			/* !bolted, !secondary */
 	li	r8,MMU_PAGE_64K
-	ld	r9,STK_PARAM(R9)(r1)	/* segment size */
+	li	r9,MMU_PAGE_64K		/* actual page size */
+	ld	r10,STK_PARAM(R9)(r1)	/* segment size */
 _GLOBAL(ht64_call_hpte_insert1)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -863,7 +868,8 @@ _GLOBAL(ht64_call_hpte_insert1)
 	mr	r4,r29			/* Retrieve vpn */
 	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
 	li	r8,MMU_PAGE_64K
-	ld	r9,STK_PARAM(R9)(r1)	/* segment size */
+	li	r9,MMU_PAGE_64K		/* actual page size */
+	ld	r10,STK_PARAM(R9)(r1)	/* segment size */
 _GLOBAL(ht64_call_hpte_insert2)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index ffc1e00..16ba033 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -36,10 +36,14 @@
 #endif
 
 #define HPTE_LOCK_BIT 3
+#define LP_SHIFT	12
+#define LP_BITS		8
+#define LP_MASK(i)	((0xFF >> (i)) << LP_SHIFT)
+
 
 DEFINE_RAW_SPINLOCK(native_tlbie_lock);
 
-static inline void __tlbie(unsigned long vpn, int psize, int ssize)
+static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 {
 	unsigned long va;
 	unsigned int penc;
@@ -68,7 +72,7 @@ static inline void __tlbie(unsigned long vpn, int psize, int ssize)
 		break;
 	default:
 		/* We need 14 to 14 + i bits of va */
-		penc = mmu_psize_defs[psize].penc;
+		penc = mmu_psize_defs[psize].penc[apsize];
 		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
 		va |= penc << 12;
 		va |= ssize << 8;
@@ -80,7 +84,7 @@ static inline void __tlbie(unsigned long vpn, int psize, int ssize)
 	}
 }
 
-static inline void __tlbiel(unsigned long vpn, int psize, int ssize)
+static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 {
 	unsigned long va;
 	unsigned int penc;
@@ -102,7 +106,7 @@ static inline void __tlbiel(unsigned long vpn, int psize, int ssize)
 		break;
 	default:
 		/* We need 14 to 14 + i bits of va */
-		penc = mmu_psize_defs[psize].penc;
+		penc = mmu_psize_defs[psize].penc[apsize];
 		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
 		va |= penc << 12;
 		va |= ssize << 8;
@@ -114,7 +118,8 @@ static inline void __tlbiel(unsigned long vpn, int psize, int ssize)
 
 }
 
-static inline void tlbie(unsigned long vpn, int psize, int ssize, int local)
+static inline void tlbie(unsigned long vpn, int psize, int apsize,
+			 int ssize, int local)
 {
 	unsigned int use_local = local && mmu_has_feature(MMU_FTR_TLBIEL);
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
@@ -125,10 +130,10 @@ static inline void tlbie(unsigned long vpn, int psize, int ssize, int local)
 		raw_spin_lock(&native_tlbie_lock);
 	asm volatile("ptesync": : :"memory");
 	if (use_local) {
-		__tlbiel(vpn, psize, ssize);
+		__tlbiel(vpn, psize, apsize, ssize);
 		asm volatile("ptesync": : :"memory");
 	} else {
-		__tlbie(vpn, psize, ssize);
+		__tlbie(vpn, psize, apsize, ssize);
 		asm volatile("eieio; tlbsync; ptesync": : :"memory");
 	}
 	if (lock_tlbie && !use_local)
@@ -156,7 +161,7 @@ static inline void native_unlock_hpte(struct hash_pte *hptep)
 
 static long native_hpte_insert(unsigned long hpte_group, unsigned long vpn,
 			unsigned long pa, unsigned long rflags,
-			unsigned long vflags, int psize, int ssize)
+			unsigned long vflags, int psize, int apsize, int ssize)
 {
 	struct hash_pte *hptep = htab_address + hpte_group;
 	unsigned long hpte_v, hpte_r;
@@ -184,7 +189,7 @@ static long native_hpte_insert(unsigned long hpte_group, unsigned long vpn,
 		return -1;
 
 	hpte_v = hpte_encode_v(vpn, psize, ssize) | vflags | HPTE_V_VALID;
-	hpte_r = hpte_encode_r(pa, psize) | rflags;
+	hpte_r = hpte_encode_r(pa, psize, apsize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED)) {
 		DBG_LOW(" i=%x hpte_v=%016lx, hpte_r=%016lx\n",
@@ -244,6 +249,47 @@ static long native_hpte_remove(unsigned long hpte_group)
 	return i;
 }
 
+static inline int hpte_actual_psize(struct hash_pte *hptep, int psize)
+{
+	unsigned int mask;
+	int i, penc, shift;
+	unsigned int lp = (hptep->r >> LP_SHIFT) & LP_BITS;
+
+#if 0
+	/*
+	 * FIXME!! hpte_decode have more tricks. why not
+	 * How do we find how many bits need to be used for r and z ?
+	 */
+	for (i = 0; i < LP_BITS; i++) {
+		if ((hptep->r & LP_MASK(i+1)) == LP_MASK(i+1))
+			break;
+	}
+	penc = LP_MASK(i+1) >> LP_SHIFT;
+	for (i = 0; i < MMU_PAGE_COUNT; i++) {
+		if (penc == mmu_psize_defs[psize].penc[i])
+			return i;
+	}
+	return -1;
+#else
+	penc = 0;
+	/* is this better ? */
+	for (i = 0; i < MMU_PAGE_COUNT; i++) {
+		/* valid entries have a shift value */
+		if (!mmu_psize_defs[i].shift)
+			continue;
+
+		/* encoding bits per actual page size */
+		shift = mmu_psize_defs[i].shift - 11;
+		if (shift > 9)
+			shift = 9;
+		mask = (1 << shift) - 1;
+		if ((lp & mask) == mmu_psize_defs[psize].penc[i])
+			return i;
+	}
+	return -1;
+#endif
+}
+
 static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 				 unsigned long vpn, int psize, int ssize,
 				 int local)
@@ -251,6 +297,7 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	struct hash_pte *hptep = htab_address + slot;
 	unsigned long hpte_v, want_v;
 	int ret = 0;
+	int actual_psize;
 
 	want_v = hpte_encode_v(vpn, psize, ssize);
 
@@ -260,6 +307,7 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	native_lock_hpte(hptep);
 
 	hpte_v = hptep->v;
+	actual_psize = hpte_actual_psize(hptep, psize);
 
 	/* Even if we miss, we need to invalidate the TLB */
 	if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID)) {
@@ -274,7 +322,7 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	native_unlock_hpte(hptep);
 
 	/* Ensure it is out of the tlb too. */
-	tlbie(vpn, psize, ssize, local);
+	tlbie(vpn, psize, actual_psize, ssize, local);
 
 	return ret;
 }
@@ -315,6 +363,7 @@ static long native_hpte_find(unsigned long vpn, int psize, int ssize)
 static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 				       int psize, int ssize)
 {
+	int actual_psize;
 	unsigned long vpn;
 	unsigned long vsid;
 	long slot;
@@ -327,13 +376,14 @@ static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 	if (slot == -1)
 		panic("could not find page to bolt\n");
 	hptep = htab_address + slot;
+	actual_psize = hpte_actual_psize(hptep, psize);
 
 	/* Update the HPTE */
 	hptep->r = (hptep->r & ~(HPTE_R_PP | HPTE_R_N)) |
 		(newpp & (HPTE_R_PP | HPTE_R_N));
 
 	/* Ensure it is out of the tlb too. */
-	tlbie(vpn, psize, ssize, 0);
+	tlbie(vpn, psize, actual_psize, ssize, 0);
 }
 
 static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
@@ -343,6 +393,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	unsigned long hpte_v;
 	unsigned long want_v;
 	unsigned long flags;
+	int actual_psize;
 
 	local_irq_save(flags);
 
@@ -352,6 +403,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	native_lock_hpte(hptep);
 	hpte_v = hptep->v;
 
+	actual_psize = hpte_actual_psize(hptep, psize);
 	/* Even if we miss, we need to invalidate the TLB */
 	if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID))
 		native_unlock_hpte(hptep);
@@ -360,23 +412,19 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 		hptep->v = 0;
 
 	/* Invalidate the TLB */
-	tlbie(vpn, psize, ssize, local);
+	tlbie(vpn, psize, actual_psize, ssize, local);
 
 	local_irq_restore(flags);
 }
 
-#define LP_SHIFT	12
-#define LP_BITS		8
-#define LP_MASK(i)	((0xFF >> (i)) << LP_SHIFT)
-
 static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
-			int *psize, int *ssize, unsigned long *vpn)
+			int *psize, int *apsize, int *ssize, unsigned long *vpn)
 {
 	unsigned long avpn, pteg, vpi;
 	unsigned long hpte_r = hpte->r;
 	unsigned long hpte_v = hpte->v;
 	unsigned long vsid, seg_off;
-	int i, size, shift, penc;
+	int i, size, a_size = MMU_PAGE_4K, shift, penc;
 
 	if (!(hpte_v & HPTE_V_LARGE))
 		size = MMU_PAGE_4K;
@@ -395,12 +443,13 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			/* valid entries have a shift value */
 			if (!mmu_psize_defs[size].shift)
 				continue;
-
-			if (penc == mmu_psize_defs[size].penc)
-				break;
+			for (a_size = 0; a_size < MMU_PAGE_COUNT; a_size++)
+				if (penc == mmu_psize_defs[size].penc[a_size])
+					goto out;
 		}
 	}
 
+out:
 	/* This works for all page sizes, and for 256M and 1T segments */
 	*ssize = hpte_v >> HPTE_V_SSIZE_SHIFT;
 	shift = mmu_psize_defs[size].shift;
@@ -433,7 +482,8 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 	default:
 		*vpn = size = 0;
 	}
-	*psize = size;
+	*psize  = size;
+	*apsize = a_size;
 }
 
 /*
@@ -451,7 +501,7 @@ static void native_hpte_clear(void)
 	struct hash_pte *hptep = htab_address;
 	unsigned long hpte_v;
 	unsigned long pteg_count;
-	int psize, ssize;
+	int psize, apsize, ssize;
 
 	pteg_count = htab_hash_mask + 1;
 
@@ -477,9 +527,9 @@ static void native_hpte_clear(void)
 		 * already hold the native_tlbie_lock.
 		 */
 		if (hpte_v & HPTE_V_VALID) {
-			hpte_decode(hptep, slot, &psize, &ssize, &vpn);
+			hpte_decode(hptep, slot, &psize, &apsize, &ssize, &vpn);
 			hptep->v = 0;
-			__tlbie(vpn, psize, ssize);
+			__tlbie(vpn, psize, apsize, ssize);
 		}
 	}
 
@@ -491,6 +541,7 @@ static void native_hpte_clear(void)
 /*
  * Batched hash table flush, we batch the tlbie's to avoid taking/releasing
  * the lock all the time
+ * FIXME!! large page support needed ?
  */
 static void native_flush_hash_range(unsigned long number, int local)
 {
@@ -540,7 +591,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 
 			pte_iterate_hashed_subpages(pte, psize,
 						    vpn, index, shift) {
-				__tlbiel(vpn, psize, ssize);
+				__tlbiel(vpn, psize, psize, ssize);
 			} pte_iterate_hashed_end();
 		}
 		asm volatile("ptesync":::"memory");
@@ -557,7 +608,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 
 			pte_iterate_hashed_subpages(pte, psize,
 						    vpn, index, shift) {
-				__tlbie(vpn, psize, ssize);
+				__tlbie(vpn, psize, psize, ssize);
 			} pte_iterate_hashed_end();
 		}
 		asm volatile("eieio; tlbsync; ptesync":::"memory");
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index bfeab83..48edb46 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -125,7 +125,7 @@ static struct mmu_psize_def mmu_psize_defaults_old[] = {
 	[MMU_PAGE_4K] = {
 		.shift	= 12,
 		.sllp	= 0,
-		.penc	= 0,
+		.penc[MMU_PAGE_4K] = 0,
 		.avpnm	= 0,
 		.tlbiel = 0,
 	},
@@ -139,14 +139,14 @@ static struct mmu_psize_def mmu_psize_defaults_gp[] = {
 	[MMU_PAGE_4K] = {
 		.shift	= 12,
 		.sllp	= 0,
-		.penc	= 0,
+		.penc[MMU_PAGE_4K] = 0,
 		.avpnm	= 0,
 		.tlbiel = 1,
 	},
 	[MMU_PAGE_16M] = {
 		.shift	= 24,
 		.sllp	= SLB_VSID_L,
-		.penc	= 0,
+		.penc[MMU_PAGE_16M] = 0,
 		.avpnm	= 0x1UL,
 		.tlbiel = 0,
 	},
@@ -208,7 +208,7 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 
 		BUG_ON(!ppc_md.hpte_insert);
 		ret = ppc_md.hpte_insert(hpteg, vpn, paddr, tprot,
-					 HPTE_V_BOLTED, psize, ssize);
+					 HPTE_V_BOLTED, psize, psize, ssize);
 
 		if (ret < 0)
 			break;
@@ -275,6 +275,30 @@ static void __init htab_init_seg_sizes(void)
 	of_scan_flat_dt(htab_dt_scan_seg_sizes, NULL);
 }
 
+static int __init get_idx_from_shift(unsigned int shift)
+{
+	int idx = -1;
+
+	switch (shift) {
+	case 0xc:
+		idx = MMU_PAGE_4K;
+		break;
+	case 0x10:
+		idx = MMU_PAGE_64K;
+		break;
+	case 0x14:
+		idx = MMU_PAGE_1M;
+		break;
+	case 0x18:
+		idx = MMU_PAGE_16M;
+		break;
+	case 0x22:
+		idx = MMU_PAGE_16G;
+		break;
+	}
+	return idx;
+}
+
 static int __init htab_dt_scan_page_sizes(unsigned long node,
 					  const char *uname, int depth,
 					  void *data)
@@ -294,60 +318,57 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 		size /= 4;
 		cur_cpu_spec->mmu_features &= ~(MMU_FTR_16M_PAGE);
 		while(size > 0) {
-			unsigned int shift = prop[0];
+			unsigned int base_shift = prop[0];
 			unsigned int slbenc = prop[1];
 			unsigned int lpnum = prop[2];
-			unsigned int lpenc = 0;
 			struct mmu_psize_def *def;
-			int idx = -1;
+			int idx, base_idx;
 
 			size -= 3; prop += 3;
-			while(size > 0 && lpnum) {
-				if (prop[0] == shift)
-					lpenc = prop[1];
+			base_idx = get_idx_from_shift(base_shift);
+			if (base_idx < 0) {
+				/*
+				 * skip the pte encoding also
+				 */
 				prop += 2; size -= 2;
-				lpnum--;
+				continue;
 			}
-			switch(shift) {
-			case 0xc:
-				idx = MMU_PAGE_4K;
-				break;
-			case 0x10:
-				idx = MMU_PAGE_64K;
-				break;
-			case 0x14:
-				idx = MMU_PAGE_1M;
-				break;
-			case 0x18:
-				idx = MMU_PAGE_16M;
+			def = &mmu_psize_defs[base_idx];
+			if (base_idx == MMU_PAGE_16M)
 				cur_cpu_spec->mmu_features |= MMU_FTR_16M_PAGE;
-				break;
-			case 0x22:
-				idx = MMU_PAGE_16G;
-				break;
-			}
-			if (idx < 0)
-				continue;
-			def = &mmu_psize_defs[idx];
-			def->shift = shift;
-			if (shift <= 23)
+
+			def->shift = base_shift;
+			if (base_shift <= 23)
 				def->avpnm = 0;
 			else
-				def->avpnm = (1 << (shift - 23)) - 1;
+				def->avpnm = (1 << (base_shift - 23)) - 1;
 			def->sllp = slbenc;
-			def->penc = lpenc;
-			/* We don't know for sure what's up with tlbiel, so
+			/*
+			 * We don't know for sure what's up with tlbiel, so
 			 * for now we only set it for 4K and 64K pages
 			 */
-			if (idx == MMU_PAGE_4K || idx == MMU_PAGE_64K)
+			if (base_idx == MMU_PAGE_4K || base_idx == MMU_PAGE_64K)
 				def->tlbiel = 1;
 			else
 				def->tlbiel = 0;
 
-			DBG(" %d: shift=%02x, sllp=%04lx, avpnm=%08lx, "
-			    "tlbiel=%d, penc=%d\n",
-			    idx, shift, def->sllp, def->avpnm, def->tlbiel,
-			    def->penc);
+			while (size > 0 && lpnum) {
+				unsigned int shift = prop[0];
+				unsigned int penc  = prop[1];
+
+				prop += 2; size -= 2;
+				lpnum--;
+
+				idx = get_idx_from_shift(shift);
+				if (idx < 0)
+					continue;
+
+				def->penc[idx] = penc;
+				DBG(" %d: shift=%02x, sllp=%04lx, "
+				    "avpnm=%08lx, tlbiel=%d, penc=%d\n",
+				    idx, shift, def->sllp, def->avpnm,
+				    def->tlbiel, def->penc[idx]);
+			}
 		}
 		return 1;
 	}
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 0da39fe..9f99847 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -109,7 +109,7 @@ void vpa_init(int cpu)
 static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 				     unsigned long vpn, unsigned long pa,
 				     unsigned long rflags, unsigned long vflags,
-				     int psize, int ssize)
+				     int psize, int apsize, int ssize)
 {
 	unsigned long lpar_rc;
 	unsigned long flags;
@@ -122,7 +122,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 			 hpte_group, vpn,  pa, rflags, vflags, psize);
 
 	hpte_v = hpte_encode_v(vpn, psize, ssize) | vflags | HPTE_V_VALID;
-	hpte_r = hpte_encode_r(pa, psize) | rflags;
+	hpte_r = hpte_encode_r(pa, psize, apsize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED))
 		pr_devel(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
-- 
1.7.10
