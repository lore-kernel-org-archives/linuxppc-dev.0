Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMhqh3wXDzDrVk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 15:40:48 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v725TkrL065421
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 01:40:46 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c32gxg1th-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 01:40:46 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 23:40:45 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 01/17] powerpc/mm: Update native_hpte_find to return hash
 pte
Date: Wed,  2 Aug 2017 11:10:00 +0530
In-Reply-To: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170802054016.8927-2-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The helper now also does a secondary hash search so that we can use this in other
functions.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c | 70 +++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 3848af167df9..4b3f6d66e7f0 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -351,32 +351,44 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	return ret;
 }
 
-static long native_hpte_find(unsigned long vpn, int psize, int ssize)
+/* returns a locked hash pte */
+struct hash_pte *native_hpte_find(unsigned long hash, unsigned long vpn,
+				  unsigned long bpsize, unsigned long ssize)
 {
+	int i;
+	unsigned long hpte_v;
 	struct hash_pte *hptep;
-	unsigned long hash;
-	unsigned long i;
-	long slot;
-	unsigned long want_v, hpte_v;
-
-	hash = hpt_hash(vpn, mmu_psize_defs[psize].shift, ssize);
-	want_v = hpte_encode_avpn(vpn, psize, ssize);
+	unsigned long want_v, slot;
+	bool secondary_search = false;
 
-	/* Bolted mappings are only ever in the primary group */
+	want_v = hpte_encode_avpn(vpn, bpsize, ssize);
 	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-	for (i = 0; i < HPTES_PER_GROUP; i++) {
-		hptep = htab_address + slot;
+
+	/*
+	 * search for hpte in the primary group
+	 */
+search_again:
+	hptep = htab_address + slot;
+	for (i = 0; i < HPTES_PER_GROUP; i++, hptep++) {
+		/*
+		 * FIXME!! Should we check locklessly check first ?
+		 */
+		native_lock_hpte(hptep);
 		hpte_v = be64_to_cpu(hptep->v);
 		if (cpu_has_feature(CPU_FTR_ARCH_300))
 			hpte_v = hpte_new_to_old_v(hpte_v, be64_to_cpu(hptep->r));
-
-		if (HPTE_V_COMPARE(hpte_v, want_v) && (hpte_v & HPTE_V_VALID))
-			/* HPTE matches */
-			return slot;
-		++slot;
+		if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID))
+			native_unlock_hpte(hptep);
+		else
+			return hptep;
 	}
-
-	return -1;
+	if (!secondary_search) {
+		/* Search for hpte in the secondary group */
+		slot = (~hash & htab_hash_mask) * HPTES_PER_GROUP;
+		secondary_search = true;
+		goto search_again;
+	}
+	return NULL;
 }
 
 /*
@@ -389,23 +401,22 @@ static long native_hpte_find(unsigned long vpn, int psize, int ssize)
 static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 				       int psize, int ssize)
 {
-	unsigned long vpn;
-	unsigned long vsid;
-	long slot;
+	unsigned long hash;
+	unsigned long vpn, vsid;
 	struct hash_pte *hptep;
 
 	vsid = get_kernel_vsid(ea, ssize);
 	vpn = hpt_vpn(ea, vsid, ssize);
-
-	slot = native_hpte_find(vpn, psize, ssize);
-	if (slot == -1)
+	hash = hpt_hash(vpn, mmu_psize_defs[psize].shift, ssize);
+	hptep = native_hpte_find(hash, vpn, psize, ssize);
+	if (!hptep)
 		panic("could not find page to bolt\n");
-	hptep = htab_address + slot;
 
 	/* Update the HPTE */
 	hptep->r = cpu_to_be64((be64_to_cpu(hptep->r) &
 				~(HPTE_R_PPP | HPTE_R_N)) |
 			       (newpp & (HPTE_R_PPP | HPTE_R_N)));
+	native_unlock_hpte(hptep);
 	/*
 	 * Ensure it is out of the tlb too. Bolted entries base and
 	 * actual page size will be same.
@@ -422,18 +433,17 @@ static int native_hpte_removebolted(unsigned long ea, int psize, int ssize)
 {
 	unsigned long vpn;
 	unsigned long vsid;
-	long slot;
+	unsigned long hash;
 	struct hash_pte *hptep;
 
 	vsid = get_kernel_vsid(ea, ssize);
 	vpn = hpt_vpn(ea, vsid, ssize);
+	hash = hpt_hash(vpn, mmu_psize_defs[psize].shift, ssize);
 
-	slot = native_hpte_find(vpn, psize, ssize);
-	if (slot == -1)
+	hptep = native_hpte_find(hash, vpn, psize, ssize);
+	if (!hptep)
 		return -ENOENT;
 
-	hptep = htab_address + slot;
-
 	VM_WARN_ON(!(be64_to_cpu(hptep->v) & HPTE_V_BOLTED));
 
 	/* Invalidate the hpte */
-- 
2.13.3
