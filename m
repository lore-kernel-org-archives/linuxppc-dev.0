Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 217552C0507
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 17:10:54 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 6 Mar 2013 16:01:07 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 493C33578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 17:10:51 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r266AmIk42664170
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 17:10:48 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r266AoqM014607
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 17:10:50 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 09/26] powerpc: Use encode avpn where we need only avpn
 values
Date: Wed,  6 Mar 2013 11:40:10 +0530
Message-Id: <1362550227-575-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1362550227-575-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1362550227-575-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

In all these cases we are doing something similar to

HPTE_V_COMPARE(hpte_v, want_v) which ignores the HPTE_V_LARGE bit

With MPSS support we would need actual page size to set HPTE_V_LARGE
bit and that won't be available in most of these cases. Since we are ignoring
HPTE_V_LARGE bit, use the  avpn value instead. There should not be any change
in behaviour after this patch.

Acked-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c        |    8 ++++----
 arch/powerpc/platforms/cell/beat_htab.c |   10 +++++-----
 arch/powerpc/platforms/ps3/htab.c       |    2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index ffc1e00..9d8983a 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -252,7 +252,7 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	unsigned long hpte_v, want_v;
 	int ret = 0;
 
-	want_v = hpte_encode_v(vpn, psize, ssize);
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
 
 	DBG_LOW("    update(vpn=%016lx, avpnv=%016lx, group=%lx, newpp=%lx)",
 		vpn, want_v & HPTE_V_AVPN, slot, newpp);
@@ -288,7 +288,7 @@ static long native_hpte_find(unsigned long vpn, int psize, int ssize)
 	unsigned long want_v, hpte_v;
 
 	hash = hpt_hash(vpn, mmu_psize_defs[psize].shift, ssize);
-	want_v = hpte_encode_v(vpn, psize, ssize);
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
 
 	/* Bolted mappings are only ever in the primary group */
 	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
@@ -348,7 +348,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 
 	DBG_LOW("    invalidate(vpn=%016lx, hash: %lx)\n", vpn, slot);
 
-	want_v = hpte_encode_v(vpn, psize, ssize);
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
 	native_lock_hpte(hptep);
 	hpte_v = hptep->v;
 
@@ -520,7 +520,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 			slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 			slot += hidx & _PTEIDX_GROUP_IX;
 			hptep = htab_address + slot;
-			want_v = hpte_encode_v(vpn, psize, ssize);
+			want_v = hpte_encode_avpn(vpn, psize, ssize);
 			native_lock_hpte(hptep);
 			hpte_v = hptep->v;
 			if (!HPTE_V_COMPARE(hpte_v, want_v) ||
diff --git a/arch/powerpc/platforms/cell/beat_htab.c b/arch/powerpc/platforms/cell/beat_htab.c
index 0f6f839..472f9a7 100644
--- a/arch/powerpc/platforms/cell/beat_htab.c
+++ b/arch/powerpc/platforms/cell/beat_htab.c
@@ -191,7 +191,7 @@ static long beat_lpar_hpte_updatepp(unsigned long slot,
 	u64 dummy0, dummy1;
 	unsigned long want_v;
 
-	want_v = hpte_encode_v(vpn, psize, MMU_SEGSIZE_256M);
+	want_v = hpte_encode_avpn(vpn, psize, MMU_SEGSIZE_256M);
 
 	DBG_LOW("    update: "
 		"avpnv=%016lx, slot=%016lx, psize: %d, newpp %016lx ... ",
@@ -228,7 +228,7 @@ static long beat_lpar_hpte_find(unsigned long vpn, int psize)
 	unsigned long want_v, hpte_v;
 
 	hash = hpt_hash(vpn, mmu_psize_defs[psize].shift, MMU_SEGSIZE_256M);
-	want_v = hpte_encode_v(vpn, psize, MMU_SEGSIZE_256M);
+	want_v = hpte_encode_avpn(vpn, psize, MMU_SEGSIZE_256M);
 
 	for (j = 0; j < 2; j++) {
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
@@ -283,7 +283,7 @@ static void beat_lpar_hpte_invalidate(unsigned long slot, unsigned long vpn,
 
 	DBG_LOW("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
 		slot, va, psize, local);
-	want_v = hpte_encode_v(vpn, psize, MMU_SEGSIZE_256M);
+	want_v = hpte_encode_avpn(vpn, psize, MMU_SEGSIZE_256M);
 
 	raw_spin_lock_irqsave(&beat_htab_lock, flags);
 	dummy1 = beat_lpar_hpte_getword0(slot);
@@ -372,7 +372,7 @@ static long beat_lpar_hpte_updatepp_v3(unsigned long slot,
 	unsigned long want_v;
 	unsigned long pss;
 
-	want_v = hpte_encode_v(vpn, psize, MMU_SEGSIZE_256M);
+	want_v = hpte_encode_avpn(vpn, psize, MMU_SEGSIZE_256M);
 	pss = (psize == MMU_PAGE_4K) ? -1UL : mmu_psize_defs[psize].penc;
 
 	DBG_LOW("    update: "
@@ -402,7 +402,7 @@ static void beat_lpar_hpte_invalidate_v3(unsigned long slot, unsigned long vpn,
 
 	DBG_LOW("    inval : slot=%lx, vpn=%016lx, psize: %d, local: %d\n",
 		slot, vpn, psize, local);
-	want_v = hpte_encode_v(vpn, psize, MMU_SEGSIZE_256M);
+	want_v = hpte_encode_avpn(vpn, psize, MMU_SEGSIZE_256M);
 	pss = (psize == MMU_PAGE_4K) ? -1UL : mmu_psize_defs[psize].penc;
 
 	lpar_rc = beat_invalidate_htab_entry3(0, slot, want_v, pss);
diff --git a/arch/powerpc/platforms/ps3/htab.c b/arch/powerpc/platforms/ps3/htab.c
index d00d7b0..07a4bba 100644
--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -115,7 +115,7 @@ static long ps3_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	unsigned long flags;
 	long ret;
 
-	want_v = hpte_encode_v(vpn, psize, ssize);
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
 
 	spin_lock_irqsave(&ps3_htab_lock, flags);
 
-- 
1.7.10
