Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMhr51gfxzDrhD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 15:41:09 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v725f1AH191903
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 01:41:06 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c385n9wmh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 01:41:05 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 23:41:05 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 07/17] powerpc/mm: Add hash updatepp callback
Date: Wed,  2 Aug 2017 11:10:06 +0530
In-Reply-To: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170802054016.8927-8-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add hash based updatepp callback and use that during hash pte fault.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  6 +++++
 arch/powerpc/mm/hash64_4k.c                   |  7 +----
 arch/powerpc/mm/hash64_64k.c                  | 17 +++---------
 arch/powerpc/mm/hash_native_64.c              | 37 +++++++++++++++++++++++++++
 arch/powerpc/mm/hugetlbpage-hash64.c          |  9 ++-----
 arch/powerpc/platforms/ps3/htab.c             | 29 +++++++++++++++++++++
 arch/powerpc/platforms/pseries/lpar.c         | 31 ++++++++++++++++++++++
 7 files changed, 109 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 7e1fcae472f0..a784d4ac4fb1 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -144,6 +144,12 @@ struct mmu_hash_ops {
 					 unsigned long vpn,
 					 int bpsize, int apsize,
 					 int ssize, unsigned long flags);
+	long		(*hash_updatepp)(unsigned long hash,
+					 unsigned long newpp,
+					 unsigned long vpn,
+					 int bpsize, int apsize,
+					 int ssize, unsigned long flags);
+
 	void            (*hpte_updateboltedpp)(unsigned long newpp,
 					       unsigned long ea,
 					       int psize, int ssize);
diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index 6fa450c12d6d..d262d814ca55 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -65,12 +65,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * There MIGHT be an HPTE for this pte
 		 */
 		hash = hpt_hash(vpn, shift, ssize);
-		if (old_pte & H_PAGE_F_SECOND)
-			hash = ~hash;
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
-
-		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_4K,
+		if (mmu_hash_ops.hash_updatepp(hash, rflags, vpn, MMU_PAGE_4K,
 					       MMU_PAGE_4K, ssize, flags) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
 	}
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 1a68cb19b0e3..2b72f2c5ed10 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -127,17 +127,11 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		int ret;
 
 		hash = hpt_hash(vpn, shift, ssize);
-		hidx = __rpte_to_hidx(rpte, subpg_index);
-		if (hidx & _PTEIDX_SECONDARY)
-			hash = ~hash;
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += hidx & _PTEIDX_GROUP_IX;
-
-		ret = mmu_hash_ops.hpte_updatepp(slot, rflags, vpn,
+		ret = mmu_hash_ops.hash_updatepp(hash, rflags, vpn,
 						 MMU_PAGE_4K, MMU_PAGE_4K,
 						 ssize, flags);
 		/*
-		 *if we failed because typically the HPTE wasn't really here
+		 * if we failed because typically the HPTE wasn't really here
 		 * we try an insertion.
 		 */
 		if (ret == -1)
@@ -268,12 +262,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		 * There MIGHT be an HPTE for this pte
 		 */
 		hash = hpt_hash(vpn, shift, ssize);
-		if (old_pte & H_PAGE_F_SECOND)
-			hash = ~hash;
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
-
-		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_64K,
+		if (mmu_hash_ops.hash_updatepp(hash, rflags, vpn, MMU_PAGE_64K,
 					       MMU_PAGE_64K, ssize,
 					       flags) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index c3fdd684a287..2eaded4680ae 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -391,6 +391,42 @@ struct hash_pte *native_hpte_find(unsigned long hash, unsigned long vpn,
 	return NULL;
 }
 
+static long native_hash_updatepp(unsigned long hash, unsigned long newpp,
+				 unsigned long vpn, int bpsize,
+				 int apsize, int ssize, unsigned long flags)
+{
+	int ret = 0;
+	struct hash_pte *hptep;
+	int local = 0;
+
+
+	DBG_LOW("    update(vpn=%016lx, newpp=%lx)", vpn, newpp);
+
+	hptep = native_hpte_find(hash, vpn, bpsize, ssize);
+	if (hptep) {
+		DBG_LOW(" -> hit\n");
+		/* Update the HPTE */
+		hptep->r = cpu_to_be64((be64_to_cpu(hptep->r) &
+					~(HPTE_R_PPP | HPTE_R_N)) |
+				       (newpp & (HPTE_R_PPP | HPTE_R_N |
+						 HPTE_R_C)));
+		native_unlock_hpte(hptep);
+	} else {
+		DBG_LOW(" -> miss\n");
+		ret = -1;
+	}
+	/*
+	 * Ensure it is out of the tlb too if it is not a nohpte fault
+	 */
+	if (!(flags & HPTE_NOHPTE_UPDATE)) {
+		if (flags & HPTE_LOCAL_UPDATE)
+			local = 1;
+		tlbie(vpn, bpsize, apsize, ssize, local);
+	}
+	return ret;
+}
+
+
 /*
  * Update the page protection bits. Intended to be used to create
  * guard pages for kernel data structures on pages which are bolted
@@ -787,6 +823,7 @@ void __init hpte_init_native(void)
 	mmu_hash_ops.hpte_invalidate	= native_hpte_invalidate;
 	mmu_hash_ops.hash_invalidate	= native_hash_invalidate;
 	mmu_hash_ops.hpte_updatepp	= native_hpte_updatepp;
+	mmu_hash_ops.hash_updatepp	= native_hash_updatepp;
 	mmu_hash_ops.hpte_updateboltedpp = native_hpte_updateboltedpp;
 	mmu_hash_ops.hpte_removebolted = native_hpte_removebolted;
 	mmu_hash_ops.hpte_insert	= native_hpte_insert;
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index a84bb44497f9..4eb8c9d2f452 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -71,15 +71,10 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	/* Check if pte already has an hpte (case 2) */
 	if (unlikely(old_pte & H_PAGE_HASHPTE)) {
 		/* There MIGHT be an HPTE for this pte */
-		unsigned long hash, slot;
+		unsigned long hash;
 
 		hash = hpt_hash(vpn, shift, ssize);
-		if (old_pte & H_PAGE_F_SECOND)
-			hash = ~hash;
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
-
-		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, mmu_psize,
+		if (mmu_hash_ops.hash_updatepp(hash, rflags, vpn, mmu_psize,
 					       mmu_psize, ssize, flags) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
 	}
diff --git a/arch/powerpc/platforms/ps3/htab.c b/arch/powerpc/platforms/ps3/htab.c
index 813c2f77f75d..4e82f7cbd124 100644
--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -251,11 +251,40 @@ static void ps3_hash_invalidate(unsigned long hash, unsigned long vpn,
 	return;
 }
 
+static long ps3_hash_updatepp(unsigned long hash,
+			      unsigned long newpp, unsigned long vpn,
+			      int psize, int apsize, int ssize,
+			      unsigned long inv_flags)
+{
+	long slot;
+	unsigned long flags;
+	unsigned long want_v;
+
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
+	spin_lock_irqsave(&ps3_htab_lock, flags);
+
+	slot = ps3_hpte_find(hash, want_v);
+	if (slot < 0)
+		goto err_out;
+	/*
+	 * entry found, just invalidate it
+	 */
+	lv1_write_htab_entry(PS3_LPAR_VAS_ID_CURRENT, slot, 0, 0);
+	/*
+	 * We just invalidate instead of updating pp. Hence
+	 * return -1;
+	 */
+err_out:
+	spin_unlock_irqrestore(&ps3_htab_lock, flags);
+	return -1;
+}
+
 void __init ps3_hpte_init(unsigned long htab_size)
 {
 	mmu_hash_ops.hpte_invalidate = ps3_hpte_invalidate;
 	mmu_hash_ops.hash_invalidate = ps3_hash_invalidate;
 	mmu_hash_ops.hpte_updatepp = ps3_hpte_updatepp;
+	mmu_hash_ops.hash_updatepp = ps3_hash_updatepp;
 	mmu_hash_ops.hpte_updateboltedpp = ps3_hpte_updateboltedpp;
 	mmu_hash_ops.hpte_insert = ps3_hpte_insert;
 	mmu_hash_ops.hpte_remove = ps3_hpte_remove;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index ad7838171bb0..f4970bae5909 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -376,6 +376,36 @@ static long pSeries_lpar_hpte_find(unsigned long vpn, int psize, int ssize)
 	return slot;
 }
 
+static long pSeries_lpar_hash_updatepp(unsigned long hash,
+				       unsigned long newpp,
+				       unsigned long vpn,
+				       int psize, int apsize,
+				       int ssize, unsigned long inv_flags)
+{
+	long slot;
+	unsigned long lpar_rc;
+	unsigned long flags = (newpp & 7) | H_AVPN;
+	unsigned long want_v;
+
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
+
+	pr_devel("    update: avpnv=%016lx, hash=%016lx, f=%lx, psize: %d ...",
+		 want_v, hash, flags, psize);
+
+	slot = __pSeries_lpar_hpte_find(hash, want_v);
+	if (slot < 0)
+		return -1;
+
+	lpar_rc = plpar_pte_protect(flags, slot, want_v);
+	if (lpar_rc == H_NOT_FOUND) {
+		pr_devel("not found !\n");
+		return -1;
+	}
+	pr_devel("ok\n");
+	BUG_ON(lpar_rc != H_SUCCESS);
+
+	return 0;
+}
 
 static void pSeries_lpar_hpte_updateboltedpp(unsigned long newpp,
 					     unsigned long ea,
@@ -780,6 +810,7 @@ void __init hpte_init_pseries(void)
 	mmu_hash_ops.hpte_invalidate	 = pSeries_lpar_hpte_invalidate;
 	mmu_hash_ops.hash_invalidate	 = pSeries_lpar_hash_invalidate;
 	mmu_hash_ops.hpte_updatepp	 = pSeries_lpar_hpte_updatepp;
+	mmu_hash_ops.hash_updatepp	 = pSeries_lpar_hash_updatepp;
 	mmu_hash_ops.hpte_updateboltedpp = pSeries_lpar_hpte_updateboltedpp;
 	mmu_hash_ops.hpte_insert	 = pSeries_lpar_hpte_insert;
 	mmu_hash_ops.hpte_remove	 = pSeries_lpar_hpte_remove;
-- 
2.13.3
