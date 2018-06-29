Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H9464z3fzF1dk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:36:54 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5T8YQuM035525
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 04:36:51 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jwg28uqc3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 04:36:51 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 29 Jun 2018 02:36:51 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 2/3] powerpc/mm/hash: Add hpte_get_old_v and use that instead
 of opencoding
Date: Fri, 29 Jun 2018 14:06:30 +0530
In-Reply-To: <20180629083631.28017-1-aneesh.kumar@linux.ibm.com>
References: <20180629083631.28017-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180629083631.28017-2-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No functional change

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 10 +++++++
 arch/powerpc/mm/hash_native_64.c              | 27 +++++--------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 50ed64fba4ae..eee0b5b8a23f 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -364,6 +364,16 @@ static inline unsigned long hpte_new_to_old_r(unsigned long r)
 	return r & ~HPTE_R_3_0_SSIZE_MASK;
 }
 
+static inline unsigned long hpte_get_old_v(struct hash_pte *hptep)
+{
+	unsigned long hpte_v;
+
+	hpte_v = be64_to_cpu(hptep->v);
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		hpte_v = hpte_new_to_old_v(hpte_v, be64_to_cpu(hptep->r));
+	return hpte_v;
+}
+
 /*
  * This function sets the AVPN and L fields of the HPTE  appropriately
  * using the base page size and actual page size.
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 1d049c78c82a..68e6eaf41bb9 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -423,9 +423,7 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	DBG_LOW("    update(vpn=%016lx, avpnv=%016lx, group=%lx, newpp=%lx)",
 		vpn, want_v & HPTE_V_AVPN, slot, newpp);
 
-	hpte_v = be64_to_cpu(hptep->v);
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
-		hpte_v = hpte_new_to_old_v(hpte_v, be64_to_cpu(hptep->r));
+	hpte_v = hpte_get_old_v(hptep);
 	/*
 	 * We need to invalidate the TLB always because hpte_remove doesn't do
 	 * a tlb invalidate. If a hash bucket gets full, we "evict" a more/less
@@ -439,9 +437,7 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	} else {
 		native_lock_hpte(hptep);
 		/* recheck with locks held */
-		hpte_v = be64_to_cpu(hptep->v);
-		if (cpu_has_feature(CPU_FTR_ARCH_300))
-			hpte_v = hpte_new_to_old_v(hpte_v, be64_to_cpu(hptep->r));
+		hpte_v = hpte_get_old_v(hptep);
 		if (unlikely(!HPTE_V_COMPARE(hpte_v, want_v) ||
 			     !(hpte_v & HPTE_V_VALID))) {
 			ret = -1;
@@ -481,11 +477,9 @@ static long native_hpte_find(unsigned long vpn, int psize, int ssize)
 	/* Bolted mappings are only ever in the primary group */
 	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 	for (i = 0; i < HPTES_PER_GROUP; i++) {
-		hptep = htab_address + slot;
-		hpte_v = be64_to_cpu(hptep->v);
-		if (cpu_has_feature(CPU_FTR_ARCH_300))
-			hpte_v = hpte_new_to_old_v(hpte_v, be64_to_cpu(hptep->r));
 
+		hptep = htab_address + slot;
+		hpte_v = hpte_get_old_v(hptep);
 		if (HPTE_V_COMPARE(hpte_v, want_v) && (hpte_v & HPTE_V_VALID))
 			/* HPTE matches */
 			return slot;
@@ -575,9 +569,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 
 	want_v = hpte_encode_avpn(vpn, bpsize, ssize);
 	native_lock_hpte(hptep);
-	hpte_v = be64_to_cpu(hptep->v);
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
-		hpte_v = hpte_new_to_old_v(hpte_v, be64_to_cpu(hptep->r));
+	hpte_v = hpte_get_old_v(hptep);
 
 	/*
 	 * We need to invalidate the TLB always because hpte_remove doesn't do
@@ -635,9 +627,7 @@ static void native_hugepage_invalidate(unsigned long vsid,
 		hptep = htab_address + slot;
 		want_v = hpte_encode_avpn(vpn, psize, ssize);
 		native_lock_hpte(hptep);
-		hpte_v = be64_to_cpu(hptep->v);
-		if (cpu_has_feature(CPU_FTR_ARCH_300))
-			hpte_v = hpte_new_to_old_v(hpte_v, be64_to_cpu(hptep->r));
+		hpte_v = hpte_get_old_v(hptep);
 
 		/* Even if we miss, we need to invalidate the TLB */
 		if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID))
@@ -813,10 +803,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 			hptep = htab_address + slot;
 			want_v = hpte_encode_avpn(vpn, psize, ssize);
 			native_lock_hpte(hptep);
-			hpte_v = be64_to_cpu(hptep->v);
-			if (cpu_has_feature(CPU_FTR_ARCH_300))
-				hpte_v = hpte_new_to_old_v(hpte_v,
-						be64_to_cpu(hptep->r));
+			hpte_v = hpte_get_old_v(hptep);
 			if (!HPTE_V_COMPARE(hpte_v, want_v) ||
 			    !(hpte_v & HPTE_V_VALID))
 				native_unlock_hpte(hptep);
-- 
2.17.1
