Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDyLF1dP8zDvsy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 20:24:37 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAA9O6a3105185
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 04:24:34 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26mk9ug4u9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 04:24:34 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 10 Nov 2016 02:24:32 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Move hpte encode routine to platform specific
 files
Date: Thu, 10 Nov 2016 14:54:23 +0530
Message-Id: <20161110092423.20137-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

They differ between powernv and pseries. While we are at it copy
a version for ps3 too. For now this is same as what we have for pSeries.

Fixes: 50de596de8be6 ("powerpc/mm/hash: Add support for Power9 Hash")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 61 ---------------------
 arch/powerpc/mm/hash_native_64.c              | 74 ++++++++++++++++++++++---
 arch/powerpc/platforms/ps3/htab.c             | 61 +++++++++++++++++++--
 arch/powerpc/platforms/pseries/lpar.c         | 77 ++++++++++++++++++++++++---
 4 files changed, 194 insertions(+), 79 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index e407af2b7333..62454a400cc0 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -296,67 +296,6 @@ extern unsigned long tce_alloc_start, tce_alloc_end;
  * If this is the case, mmu_ci_restrictions will be set to 1.
  */
 extern int mmu_ci_restrictions;
-
-/*
- * This computes the AVPN and B fields of the first dword of a HPTE,
- * for use when we want to match an existing PTE.  The bottom 7 bits
- * of the returned value are zero.
- */
-static inline unsigned long hpte_encode_avpn(unsigned long vpn, int psize,
-					     int ssize)
-{
-	unsigned long v;
-	/*
-	 * The AVA field omits the low-order 23 bits of the 78 bits VA.
-	 * These bits are not needed in the PTE, because the
-	 * low-order b of these bits are part of the byte offset
-	 * into the virtual page and, if b < 23, the high-order
-	 * 23-b of these bits are always used in selecting the
-	 * PTEGs to be searched
-	 */
-	v = (vpn >> (23 - VPN_SHIFT)) & ~(mmu_psize_defs[psize].avpnm);
-	v <<= HPTE_V_AVPN_SHIFT;
-	if (!cpu_has_feature(CPU_FTR_ARCH_300))
-		v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
-	return v;
-}
-
-/*
- * This function sets the AVPN and L fields of the HPTE  appropriately
- * using the base page size and actual page size.
- */
-static inline unsigned long hpte_encode_v(unsigned long vpn, int base_psize,
-					  int actual_psize, int ssize)
-{
-	unsigned long v;
-	v = hpte_encode_avpn(vpn, base_psize, ssize);
-	if (actual_psize != MMU_PAGE_4K)
-		v |= HPTE_V_LARGE;
-	return v;
-}
-
-/*
- * This function sets the ARPN, and LP fields of the HPTE appropriately
- * for the page size. We assume the pa is already "clean" that is properly
- * aligned for the requested page size
- */
-static inline unsigned long hpte_encode_r(unsigned long pa, int base_psize,
-					  int actual_psize, int ssize)
-{
-
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
-		pa |= ((unsigned long) ssize) << HPTE_R_3_0_SSIZE_SHIFT;
-
-	/* A 4K page needs no special encoding */
-	if (actual_psize == MMU_PAGE_4K)
-		return pa & HPTE_R_RPN;
-	else {
-		unsigned int penc = mmu_psize_defs[base_psize].penc[actual_psize];
-		unsigned int shift = mmu_psize_defs[actual_psize].shift;
-		return (pa & ~((1ul << shift) - 1)) | (penc << LP_SHIFT);
-	}
-}
-
 /*
  * Build a VPN_SHIFT bit shifted va given VSID, EA and segment size.
  */
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 83ddc0e171b0..4c4fb4cc2b8a 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -191,6 +191,66 @@ static inline void native_unlock_hpte(struct hash_pte *hptep)
 	clear_bit_unlock(HPTE_LOCK_BIT, word);
 }
 
+/*
+ * This computes the AVPN and B fields of the first dword of a HPTE,
+ * for use when we want to match an existing PTE.  The bottom 7 bits
+ * of the returned value are zero.
+ */
+static inline unsigned long native_hpte_encode_avpn(unsigned long vpn, int psize,
+						    int ssize)
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
+	v = (vpn >> (23 - VPN_SHIFT)) & ~(mmu_psize_defs[psize].avpnm);
+	v <<= HPTE_V_AVPN_SHIFT;
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
+	return v;
+}
+
+/*
+ * This function sets the AVPN and L fields of the HPTE  appropriately
+ * using the base page size and actual page size.
+ */
+static inline unsigned long native_hpte_encode_v(unsigned long vpn, int base_psize,
+						 int actual_psize, int ssize)
+{
+	unsigned long v;
+	v = native_hpte_encode_avpn(vpn, base_psize, ssize);
+	if (actual_psize != MMU_PAGE_4K)
+		v |= HPTE_V_LARGE;
+	return v;
+}
+
+/*
+ * This function sets the ARPN, and LP fields of the HPTE appropriately
+ * for the page size. We assume the pa is already "clean" that is properly
+ * aligned for the requested page size
+ */
+static inline unsigned long native_hpte_encode_r(unsigned long pa, int base_psize,
+						 int actual_psize, int ssize)
+{
+
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		pa |= ((unsigned long) ssize) << HPTE_R_3_0_SSIZE_SHIFT;
+
+	/* A 4K page needs no special encoding */
+	if (actual_psize == MMU_PAGE_4K)
+		return pa & HPTE_R_RPN;
+	else {
+		unsigned int penc = mmu_psize_defs[base_psize].penc[actual_psize];
+		unsigned int shift = mmu_psize_defs[actual_psize].shift;
+		return (pa & ~((1ul << shift) - 1)) | (penc << LP_SHIFT);
+	}
+}
+
 static long native_hpte_insert(unsigned long hpte_group, unsigned long vpn,
 			unsigned long pa, unsigned long rflags,
 			unsigned long vflags, int psize, int apsize, int ssize)
@@ -220,8 +280,8 @@ static long native_hpte_insert(unsigned long hpte_group, unsigned long vpn,
 	if (i == HPTES_PER_GROUP)
 		return -1;
 
-	hpte_v = hpte_encode_v(vpn, psize, apsize, ssize) | vflags | HPTE_V_VALID;
-	hpte_r = hpte_encode_r(pa, psize, apsize, ssize) | rflags;
+	hpte_v = native_hpte_encode_v(vpn, psize, apsize, ssize) | vflags | HPTE_V_VALID;
+	hpte_r = native_hpte_encode_r(pa, psize, apsize, ssize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED)) {
 		DBG_LOW(" i=%x hpte_v=%016lx, hpte_r=%016lx\n",
@@ -289,7 +349,7 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	unsigned long hpte_v, want_v;
 	int ret = 0, local = 0;
 
-	want_v = hpte_encode_avpn(vpn, bpsize, ssize);
+	want_v = native_hpte_encode_avpn(vpn, bpsize, ssize);
 
 	DBG_LOW("    update(vpn=%016lx, avpnv=%016lx, group=%lx, newpp=%lx)",
 		vpn, want_v & HPTE_V_AVPN, slot, newpp);
@@ -343,7 +403,7 @@ static long native_hpte_find(unsigned long vpn, int psize, int ssize)
 	unsigned long want_v, hpte_v;
 
 	hash = hpt_hash(vpn, mmu_psize_defs[psize].shift, ssize);
-	want_v = hpte_encode_avpn(vpn, psize, ssize);
+	want_v = native_hpte_encode_avpn(vpn, psize, ssize);
 
 	/* Bolted mappings are only ever in the primary group */
 	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
@@ -406,7 +466,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 
 	DBG_LOW("    invalidate(vpn=%016lx, hash: %lx)\n", vpn, slot);
 
-	want_v = hpte_encode_avpn(vpn, bpsize, ssize);
+	want_v = native_hpte_encode_avpn(vpn, bpsize, ssize);
 	native_lock_hpte(hptep);
 	hpte_v = be64_to_cpu(hptep->v);
 
@@ -464,7 +524,7 @@ static void native_hugepage_invalidate(unsigned long vsid,
 		slot += hidx & _PTEIDX_GROUP_IX;
 
 		hptep = htab_address + slot;
-		want_v = hpte_encode_avpn(vpn, psize, ssize);
+		want_v = native_hpte_encode_avpn(vpn, psize, ssize);
 		native_lock_hpte(hptep);
 		hpte_v = be64_to_cpu(hptep->v);
 
@@ -636,7 +696,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 			slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 			slot += hidx & _PTEIDX_GROUP_IX;
 			hptep = htab_address + slot;
-			want_v = hpte_encode_avpn(vpn, psize, ssize);
+			want_v = native_hpte_encode_avpn(vpn, psize, ssize);
 			native_lock_hpte(hptep);
 			hpte_v = be64_to_cpu(hptep->v);
 			if (!HPTE_V_COMPARE(hpte_v, want_v) ||
diff --git a/arch/powerpc/platforms/ps3/htab.c b/arch/powerpc/platforms/ps3/htab.c
index cb3c50328de8..7cf617827922 100644
--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -43,6 +43,61 @@ enum ps3_lpar_vas_id {
 
 
 static DEFINE_SPINLOCK(ps3_htab_lock);
+/*
+ * This computes the AVPN and B fields of the first dword of a HPTE,
+ * for use when we want to match an existing PTE.  The bottom 7 bits
+ * of the returned value are zero.
+ */
+static inline unsigned long ps3_hpte_encode_avpn(unsigned long vpn, int psize,
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
+	v = (vpn >> (23 - VPN_SHIFT)) & ~(mmu_psize_defs[psize].avpnm);
+	v <<= HPTE_V_AVPN_SHIFT;
+	v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
+	return v;
+}
+/*
+ * This function sets the AVPN and L fields of the HPTE  appropriately
+ * using the base page size and actual page size.
+ */
+static inline unsigned long ps3_hpte_encode_v(unsigned long vpn, int base_psize,
+					  int actual_psize, int ssize)
+{
+	unsigned long v;
+	v = ps3_hpte_encode_avpn(vpn, base_psize, ssize);
+	if (actual_psize != MMU_PAGE_4K)
+		v |= HPTE_V_LARGE;
+	return v;
+}
+
+/*
+ * This function sets the ARPN, and LP fields of the HPTE appropriately
+ * for the page size. We assume the pa is already "clean" that is properly
+ * aligned for the requested page size
+ */
+static inline unsigned long ps3_hpte_encode_r(unsigned long pa, int base_psize,
+					  int actual_psize, int ssize)
+{
+
+	/* A 4K page needs no special encoding */
+	if (actual_psize == MMU_PAGE_4K)
+		return pa & HPTE_R_RPN;
+	else {
+		unsigned int penc = mmu_psize_defs[base_psize].penc[actual_psize];
+		unsigned int shift = mmu_psize_defs[actual_psize].shift;
+		return (pa & ~((1ul << shift) - 1)) | (penc << LP_SHIFT);
+	}
+}
+
 
 static long ps3_hpte_insert(unsigned long hpte_group, unsigned long vpn,
 	unsigned long pa, unsigned long rflags, unsigned long vflags,
@@ -62,8 +117,8 @@ static long ps3_hpte_insert(unsigned long hpte_group, unsigned long vpn,
 	 */
 	vflags &= ~HPTE_V_SECONDARY;
 
-	hpte_v = hpte_encode_v(vpn, psize, apsize, ssize) | vflags | HPTE_V_VALID;
-	hpte_r = hpte_encode_r(ps3_mm_phys_to_lpar(pa), psize, apsize, ssize) | rflags;
+	hpte_v = ps3_hpte_encode_v(vpn, psize, apsize, ssize) | vflags | HPTE_V_VALID;
+	hpte_r = ps3_hpte_encode_r(ps3_mm_phys_to_lpar(pa), psize, apsize, ssize) | rflags;
 
 	spin_lock_irqsave(&ps3_htab_lock, flags);
 
@@ -118,7 +173,7 @@ static long ps3_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	unsigned long flags;
 	long ret;
 
-	want_v = hpte_encode_avpn(vpn, psize, ssize);
+	want_v = ps3_hpte_encode_avpn(vpn, psize, ssize);
 
 	spin_lock_irqsave(&ps3_htab_lock, flags);
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index aa35245d8d6d..b5b7db4cc5eb 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -128,6 +128,67 @@ void vpa_init(int cpu)
 }
 
 #ifdef CONFIG_PPC_STD_MMU_64
+/*
+ * This computes the AVPN and B fields of the first dword of a HPTE,
+ * for use when we want to match an existing PTE.  The bottom 7 bits
+ * of the returned value are zero.
+ */
+static inline unsigned long pSeries_lpar_hpte_encode_avpn(unsigned long vpn,
+							  int psize,
+							  int ssize)
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
+	v = (vpn >> (23 - VPN_SHIFT)) & ~(mmu_psize_defs[psize].avpnm);
+	v <<= HPTE_V_AVPN_SHIFT;
+	v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
+	return v;
+}
+
+/*
+ * This function sets the AVPN and L fields of the HPTE  appropriately
+ * using the base page size and actual page size.
+ */
+static inline unsigned long pSeries_lpar_hpte_encode_v(unsigned long vpn,
+						       int base_psize,
+						       int actual_psize,
+						       int ssize)
+{
+	unsigned long v;
+	v = pSeries_lpar_hpte_encode_avpn(vpn, base_psize, ssize);
+	if (actual_psize != MMU_PAGE_4K)
+		v |= HPTE_V_LARGE;
+	return v;
+}
+
+/*
+ * This function sets the ARPN, and LP fields of the HPTE appropriately
+ * for the page size. We assume the pa is already "clean" that is properly
+ * aligned for the requested page size
+ */
+static inline unsigned long pSeries_lpar_hpte_encode_r(unsigned long pa,
+						       int base_psize,
+						       int actual_psize,
+						       int ssize)
+{
+
+	/* A 4K page needs no special encoding */
+	if (actual_psize == MMU_PAGE_4K)
+		return pa & HPTE_R_RPN;
+	else {
+		unsigned int penc = mmu_psize_defs[base_psize].penc[actual_psize];
+		unsigned int shift = mmu_psize_defs[actual_psize].shift;
+		return (pa & ~((1ul << shift) - 1)) | (penc << LP_SHIFT);
+	}
+}
+
 
 static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 				     unsigned long vpn, unsigned long pa,
@@ -144,8 +205,8 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 			 "pa=%016lx, rflags=%lx, vflags=%lx, psize=%d)\n",
 			 hpte_group, vpn,  pa, rflags, vflags, psize);
 
-	hpte_v = hpte_encode_v(vpn, psize, apsize, ssize) | vflags | HPTE_V_VALID;
-	hpte_r = hpte_encode_r(pa, psize, apsize, ssize) | rflags;
+	hpte_v = pSeries_lpar_hpte_encode_v(vpn, psize, apsize, ssize) | vflags | HPTE_V_VALID;
+	hpte_r = pSeries_lpar_hpte_encode_r(pa, psize, apsize, ssize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED))
 		pr_devel(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
@@ -282,7 +343,7 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 	unsigned long flags = (newpp & 7) | H_AVPN;
 	unsigned long want_v;
 
-	want_v = hpte_encode_avpn(vpn, psize, ssize);
+	want_v = pSeries_lpar_hpte_encode_avpn(vpn, psize, ssize);
 
 	pr_devel("    update: avpnv=%016lx, hash=%016lx, f=%lx, psize: %d ...",
 		 want_v, slot, flags, psize);
@@ -334,7 +395,7 @@ static long pSeries_lpar_hpte_find(unsigned long vpn, int psize, int ssize)
 	unsigned long hpte_group;
 
 	hash = hpt_hash(vpn, mmu_psize_defs[psize].shift, ssize);
-	want_v = hpte_encode_avpn(vpn, psize, ssize);
+	want_v = pSeries_lpar_hpte_encode_avpn(vpn, psize, ssize);
 
 	/* Bolted entries are always in the primary group */
 	hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
@@ -374,7 +435,7 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	pr_devel("    inval : slot=%lx, vpn=%016lx, psize: %d, local: %d\n",
 		 slot, vpn, psize, local);
 
-	want_v = hpte_encode_avpn(vpn, psize, ssize);
+	want_v = pSeries_lpar_hpte_encode_avpn(vpn, psize, ssize);
 	lpar_rc = plpar_pte_remove(H_AVPN, slot, want_v, &dummy1, &dummy2);
 	if (lpar_rc == H_NOT_FOUND)
 		return;
@@ -408,7 +469,7 @@ static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
 						     ssize, 0);
 		} else {
 			param[pix] = HBR_REQUEST | HBR_AVPN | slot[i];
-			param[pix+1] = hpte_encode_avpn(vpn[i], psize, ssize);
+			param[pix+1] = pSeries_lpar_hpte_encode_avpn(vpn[i], psize, ssize);
 			pix += 2;
 			if (pix == 8) {
 				rc = plpar_hcall9(H_BULK_REMOVE, param,
@@ -551,8 +612,8 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 							     0, ssize, local);
 			} else {
 				param[pix] = HBR_REQUEST | HBR_AVPN | slot;
-				param[pix+1] = hpte_encode_avpn(vpn, psize,
-								ssize);
+				param[pix+1] = pSeries_lpar_hpte_encode_avpn(vpn, psize,
+									     ssize);
 				pix += 2;
 				if (pix == 8) {
 					rc = plpar_hcall9(H_BULK_REMOVE, param,
-- 
2.10.2
