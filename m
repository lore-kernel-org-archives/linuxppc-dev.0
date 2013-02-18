Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E14B82C029C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:28:46 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 15:56:51 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7217D3940059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 15:58:38 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1IASaOA26214540
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 15:58:36 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1IASZgt001101
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:28:37 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 09/17] powerpc/mm: Use encode avpn where we need only avpn
 values
Date: Mon, 18 Feb 2013 15:58:07 +0530
Message-Id: <1361183295-6958-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h |    8 ++++----
 arch/powerpc/mm/hash_native_64.c      |   10 +++++-----
 arch/powerpc/platforms/pseries/lpar.c |    2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 6ec65b6..aeeee5e 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -237,14 +237,14 @@ static inline unsigned long hpte_encode_avpn(unsigned long vpn, int psize,
 
 /*
  * This function sets the AVPN and L fields of the HPTE  appropriately
- * for the page size
+ * using the base page size and actual page size.
  */
-static inline unsigned long hpte_encode_v(unsigned long vpn,
-					  int psize, int ssize)
+static inline unsigned long hpte_encode_v(unsigned long vpn, int psize,
+					  int apsize, int ssize)
 {
 	unsigned long v;
 	v = hpte_encode_avpn(vpn, psize, ssize);
-	if (psize != MMU_PAGE_4K)
+	if (apsize != MMU_PAGE_4K)
 		v |= HPTE_V_LARGE;
 	return v;
 }
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index da46cd3..4cf361f 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -216,7 +216,7 @@ static long native_hpte_insert(unsigned long hpte_group, unsigned long vpn,
 	if (i == HPTES_PER_GROUP)
 		return -1;
 
-	hpte_v = hpte_encode_v(vpn, psize, ssize) | vflags | HPTE_V_VALID;
+	hpte_v = hpte_encode_v(vpn, psize, apsize, ssize) | vflags | HPTE_V_VALID;
 	hpte_r = hpte_encode_r(pa, psize, apsize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED)) {
@@ -327,7 +327,7 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	int ret = 0;
 	int actual_psize;
 
-	want_v = hpte_encode_v(vpn, psize, ssize);
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
 
 	DBG_LOW("    update(vpn=%016lx, avpnv=%016lx, group=%lx, newpp=%lx)",
 		vpn, want_v & HPTE_V_AVPN, slot, newpp);
@@ -364,7 +364,7 @@ static long native_hpte_find(unsigned long vpn, int psize, int ssize)
 	unsigned long want_v, hpte_v;
 
 	hash = hpt_hash(vpn, mmu_psize_defs[psize].shift, ssize);
-	want_v = hpte_encode_v(vpn, psize, ssize);
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
 
 	/* Bolted mappings are only ever in the primary group */
 	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
@@ -427,7 +427,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 
 	DBG_LOW("    invalidate(vpn=%016lx, hash: %lx)\n", vpn, slot);
 
-	want_v = hpte_encode_v(vpn, psize, ssize);
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
 	native_lock_hpte(hptep);
 	hpte_v = hptep->v;
 
@@ -599,7 +599,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 			slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 			slot += hidx & _PTEIDX_GROUP_IX;
 			hptep = htab_address + slot;
-			want_v = hpte_encode_v(vpn, psize, ssize);
+			want_v = hpte_encode_avpn(vpn, psize, ssize);
 			native_lock_hpte(hptep);
 			hpte_v = hptep->v;
 			if (!HPTE_V_COMPARE(hpte_v, want_v) ||
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 9f99847..ca9c2bb 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -121,7 +121,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 			 "pa=%016lx, rflags=%lx, vflags=%lx, psize=%d)\n",
 			 hpte_group, vpn,  pa, rflags, vflags, psize);
 
-	hpte_v = hpte_encode_v(vpn, psize, ssize) | vflags | HPTE_V_VALID;
+	hpte_v = hpte_encode_v(vpn, psize, apsize, ssize) | vflags | HPTE_V_VALID;
 	hpte_r = hpte_encode_r(pa, psize, apsize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED))
-- 
1.7.10
