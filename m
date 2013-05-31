Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9B5902C030C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 21:03:53 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 31 May 2013 16:26:44 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 19CFDE0053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 16:36:23 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4VB3ZoW4522332
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 16:33:36 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4VB3cLd007990
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 21:03:39 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/mm: Always invalidate tlb on hpte invalidate and
 update
Date: Fri, 31 May 2013 16:33:24 +0530
Message-Id: <1369998204-31490-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

If a hash bucket gets full, we "evict" a more/less random entry from it.
When we do that we don't invalidate the TLB (hpte_remove) because we assume
the old translation is still technically "valid". This implies that when
we are invalidating or updating pte, even if HPTE entry is not valid
we should do a tlb invalidate.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 6a2aead..4c122c3 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -336,11 +336,18 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 
 	hpte_v = hptep->v;
 	actual_psize = hpte_actual_psize(hptep, psize);
+	/*
+	 * We need to invalidate the TLB always because hpte_remove doesn't do
+	 * a tlb invalidate. If a hash bucket gets full, we "evict" a more/less
+	 * random entry from it. When we do that we don't invalidate the TLB
+	 * (hpte_remove) because we assume the old translation is still
+	 * technically "valid".
+	 */
 	if (actual_psize < 0) {
-		native_unlock_hpte(hptep);
-		return -1;
+		actual_psize = psize;
+		ret = -1;
+		goto err_out;
 	}
-	/* Even if we miss, we need to invalidate the TLB */
 	if (!HPTE_V_COMPARE(hpte_v, want_v)) {
 		DBG_LOW(" -> miss\n");
 		ret = -1;
@@ -350,6 +357,7 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 		hptep->r = (hptep->r & ~(HPTE_R_PP | HPTE_R_N)) |
 			(newpp & (HPTE_R_PP | HPTE_R_N | HPTE_R_C));
 	}
+err_out:
 	native_unlock_hpte(hptep);
 
 	/* Ensure it is out of the tlb too. */
@@ -409,7 +417,7 @@ static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 	hptep = htab_address + slot;
 	actual_psize = hpte_actual_psize(hptep, psize);
 	if (actual_psize < 0)
-		return;
+		actual_psize = psize;
 
 	/* Update the HPTE */
 	hptep->r = (hptep->r & ~(HPTE_R_PP | HPTE_R_N)) |
@@ -437,21 +445,27 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	hpte_v = hptep->v;
 
 	actual_psize = hpte_actual_psize(hptep, psize);
+	/*
+	 * We need to invalidate the TLB always because hpte_remove doesn't do
+	 * a tlb invalidate. If a hash bucket gets full, we "evict" a more/less
+	 * random entry from it. When we do that we don't invalidate the TLB
+	 * (hpte_remove) because we assume the old translation is still
+	 * technically "valid".
+	 */
 	if (actual_psize < 0) {
+		actual_psize = psize;
 		native_unlock_hpte(hptep);
-		local_irq_restore(flags);
-		return;
+		goto err_out;
 	}
-	/* Even if we miss, we need to invalidate the TLB */
 	if (!HPTE_V_COMPARE(hpte_v, want_v))
 		native_unlock_hpte(hptep);
 	else
 		/* Invalidate the hpte. NOTE: this also unlocks it */
 		hptep->v = 0;
 
+err_out:
 	/* Invalidate the TLB */
 	tlbie(vpn, psize, actual_psize, ssize, local);
-
 	local_irq_restore(flags);
 }
 
-- 
1.8.1.2
