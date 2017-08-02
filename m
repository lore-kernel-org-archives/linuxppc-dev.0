Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMhr30sjyzDsQK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 15:41:06 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v725f2bG092563
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 01:41:05 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c387u1qny-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 01:41:03 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 23:41:02 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 06/17] powerpc/mm: Switch flush_hash_range to not use slot
Date: Wed,  2 Aug 2017 11:10:05 +0530
In-Reply-To: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170802054016.8927-7-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c      | 28 ++++++++--------------------
 arch/powerpc/platforms/pseries/lpar.c | 13 ++++---------
 2 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index ce25e125dd06..c3fdd684a287 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -702,10 +702,8 @@ static void native_hpte_clear(void)
 static void native_flush_hash_range(unsigned long number, int local)
 {
 	unsigned long vpn;
-	unsigned long hash, index, hidx, shift, slot;
+	unsigned long hash, index, shift;
 	struct hash_pte *hptep;
-	unsigned long hpte_v;
-	unsigned long want_v;
 	unsigned long flags;
 	real_pte_t pte;
 	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
@@ -725,23 +723,13 @@ static void native_flush_hash_range(unsigned long number, int local)
 
 		pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
 			hash = hpt_hash(vpn, shift, ssize);
-			hidx = __rpte_to_hidx(pte, index);
-			if (hidx & _PTEIDX_SECONDARY)
-				hash = ~hash;
-			slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-			slot += hidx & _PTEIDX_GROUP_IX;
-			hptep = htab_address + slot;
-			want_v = hpte_encode_avpn(vpn, psize, ssize);
-			native_lock_hpte(hptep);
-			hpte_v = be64_to_cpu(hptep->v);
-			if (cpu_has_feature(CPU_FTR_ARCH_300))
-				hpte_v = hpte_new_to_old_v(hpte_v,
-						be64_to_cpu(hptep->r));
-			if (!HPTE_V_COMPARE(hpte_v, want_v) ||
-			    !(hpte_v & HPTE_V_VALID))
-				native_unlock_hpte(hptep);
-			else
-				hptep->v = 0;
+			hptep = native_hpte_find(hash, vpn, psize, ssize);
+			if (!hptep)
+				continue;
+			/*
+			 * Invalidate the hpte. NOTE: this also unlocks it
+			 */
+			hptep->v = 0;
 		} pte_iterate_hashed_end();
 	}
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index e366252e0e93..ad7838171bb0 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -580,14 +580,14 @@ static int pSeries_lpar_hpte_removebolted(unsigned long ea,
 static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 {
 	unsigned long vpn;
-	unsigned long i, pix, rc;
+	unsigned long i, rc;
 	unsigned long flags = 0;
 	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 	unsigned long param[PLPAR_HCALL9_BUFSIZE];
-	unsigned long hash, index, shift, hidx, slot;
+	unsigned long index, shift, slot;
 	real_pte_t pte;
-	int psize, ssize;
+	int psize, ssize, pix;
 
 	if (lock_tlbie)
 		spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
@@ -599,12 +599,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 		vpn = batch->vpn[i];
 		pte = batch->pte[i];
 		pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
-			hash = hpt_hash(vpn, shift, ssize);
-			hidx = __rpte_to_hidx(pte, index);
-			if (hidx & _PTEIDX_SECONDARY)
-				hash = ~hash;
-			slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-			slot += hidx & _PTEIDX_GROUP_IX;
+			slot = pSeries_lpar_hpte_find(vpn, psize, ssize);
 			if (!firmware_has_feature(FW_FEATURE_BULK_REMOVE)) {
 				/*
 				 * lpar doesn't use the passed actual page size
-- 
2.13.3
