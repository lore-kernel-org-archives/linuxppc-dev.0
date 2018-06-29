Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H94951p4zF1g1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:36:57 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5T8Y3AU008466
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 04:36:55 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jwg7c3gcg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 04:36:55 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 29 Jun 2018 02:36:54 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 3/3] powerpc/mm/nv/hash: Reduce contention on hpte lock
Date: Fri, 29 Jun 2018 14:06:31 +0530
In-Reply-To: <20180629083631.28017-1-aneesh.kumar@linux.ibm.com>
References: <20180629083631.28017-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180629083631.28017-3-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We do this in some part. This patch make sure we always try to search for
hpte without holding lock and redo the compare with lock held once match found.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c | 49 +++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 68e6eaf41bb9..ffbd5ed4e8de 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -568,9 +568,19 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	DBG_LOW("    invalidate(vpn=%016lx, hash: %lx)\n", vpn, slot);
 
 	want_v = hpte_encode_avpn(vpn, bpsize, ssize);
-	native_lock_hpte(hptep);
 	hpte_v = hpte_get_old_v(hptep);
 
+	if (HPTE_V_COMPARE(hpte_v, want_v) && (hpte_v & HPTE_V_VALID)) {
+		native_lock_hpte(hptep);
+		/* recheck with locks held */
+		hpte_v = hpte_get_old_v(hptep);
+
+		if (HPTE_V_COMPARE(hpte_v, want_v) && (hpte_v & HPTE_V_VALID))
+			/* Invalidate the hpte. NOTE: this also unlocks it */
+			hptep->v = 0;
+		else
+			native_unlock_hpte(hptep);
+	}
 	/*
 	 * We need to invalidate the TLB always because hpte_remove doesn't do
 	 * a tlb invalidate. If a hash bucket gets full, we "evict" a more/less
@@ -578,13 +588,6 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	 * (hpte_remove) because we assume the old translation is still
 	 * technically "valid".
 	 */
-	if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID))
-		native_unlock_hpte(hptep);
-	else
-		/* Invalidate the hpte. NOTE: this also unlocks it */
-		hptep->v = 0;
-
-	/* Invalidate the TLB */
 	tlbie(vpn, bpsize, apsize, ssize, local);
 
 	local_irq_restore(flags);
@@ -626,15 +629,23 @@ static void native_hugepage_invalidate(unsigned long vsid,
 
 		hptep = htab_address + slot;
 		want_v = hpte_encode_avpn(vpn, psize, ssize);
-		native_lock_hpte(hptep);
 		hpte_v = hpte_get_old_v(hptep);
 
 		/* Even if we miss, we need to invalidate the TLB */
-		if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID))
-			native_unlock_hpte(hptep);
-		else
-			/* Invalidate the hpte. NOTE: this also unlocks it */
-			hptep->v = 0;
+		if (HPTE_V_COMPARE(hpte_v, want_v) && (hpte_v & HPTE_V_VALID)) {
+			/* recheck with locks held */
+			native_lock_hpte(hptep);
+			hpte_v = hpte_get_old_v(hptep);
+
+			if (HPTE_V_COMPARE(hpte_v, want_v) && (hpte_v & HPTE_V_VALID)) {
+				/*
+				 * Invalidate the hpte. NOTE: this also unlocks it
+				 */
+
+				hptep->v = 0;
+			} else
+				native_unlock_hpte(hptep);
+		}
 		/*
 		 * We need to do tlb invalidate for all the address, tlbie
 		 * instruction compares entry_VA in tlb with the VA specified
@@ -802,13 +813,19 @@ static void native_flush_hash_range(unsigned long number, int local)
 			slot += hidx & _PTEIDX_GROUP_IX;
 			hptep = htab_address + slot;
 			want_v = hpte_encode_avpn(vpn, psize, ssize);
+			hpte_v = hpte_get_old_v(hptep);
+
+			if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID))
+				continue;
+			/* lock and try again */
 			native_lock_hpte(hptep);
 			hpte_v = hpte_get_old_v(hptep);
-			if (!HPTE_V_COMPARE(hpte_v, want_v) ||
-			    !(hpte_v & HPTE_V_VALID))
+
+			if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID))
 				native_unlock_hpte(hptep);
 			else
 				hptep->v = 0;
+
 		} pte_iterate_hashed_end();
 	}
 
-- 
2.17.1
