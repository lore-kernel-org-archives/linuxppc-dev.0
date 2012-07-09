Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CDF5D2C0316
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 23:14:06 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 9 Jul 2012 12:52:14 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q69DDsL065536004
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 23:13:54 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q69DDrCT029889
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 23:13:54 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V3 02/11] arch/powerpc: Simplify hpte_decode
Date: Mon,  9 Jul 2012 18:43:32 +0530
Message-Id: <1341839621-28332-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

This patch simplify hpte_decode for easy switching of virtual address to
virtual page number in the later patch

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c |   49 ++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 90039bc..660b8bb 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -351,9 +351,10 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long va,
 static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			int *psize, int *ssize, unsigned long *va)
 {
+	unsigned long avpn, pteg, vpi;
 	unsigned long hpte_r = hpte->r;
 	unsigned long hpte_v = hpte->v;
-	unsigned long avpn;
+	unsigned long vsid, seg_off;
 	int i, size, shift, penc;
 
 	if (!(hpte_v & HPTE_V_LARGE))
@@ -380,32 +381,38 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 	}
 
 	/* This works for all page sizes, and for 256M and 1T segments */
+	*ssize = hpte_v >> HPTE_V_SSIZE_SHIFT;
 	shift = mmu_psize_defs[size].shift;
-	avpn = (HPTE_V_AVPN_VAL(hpte_v) & ~mmu_psize_defs[size].avpnm) << 23;
-
-	if (shift < 23) {
-		unsigned long vpi, vsid, pteg;
 
-		pteg = slot / HPTES_PER_GROUP;
-		if (hpte_v & HPTE_V_SECONDARY)
-			pteg = ~pteg;
-		switch (hpte_v >> HPTE_V_SSIZE_SHIFT) {
-		case MMU_SEGSIZE_256M:
-			vpi = ((avpn >> 28) ^ pteg) & htab_hash_mask;
-			break;
-		case MMU_SEGSIZE_1T:
-			vsid = avpn >> 40;
+	avpn = (HPTE_V_AVPN_VAL(hpte_v) & ~mmu_psize_defs[size].avpnm);
+	pteg = slot / HPTES_PER_GROUP;
+	if (hpte_v & HPTE_V_SECONDARY)
+		pteg = ~pteg;
+
+	switch (*ssize) {
+	case MMU_SEGSIZE_256M:
+		/* We only have 28 - 23 bits of seg_off in avpn */
+		seg_off = (avpn & 0x1f) << 23;
+		vsid    =  avpn >> 5;
+		/* We can find more bits from the pteg value */
+		if (shift < 23) {
+			vpi = (vsid ^ pteg) & htab_hash_mask;
+			seg_off |= vpi << shift;
+		}
+		*va = vsid << SID_SHIFT | seg_off;
+	case MMU_SEGSIZE_1T:
+		/* We only have 40 - 23 bits of seg_off in avpn */
+		seg_off = (avpn & 0x1ffff) << 23;
+		vsid    = avpn >> 17;
+		if (shift < 23) {
 			vpi = (vsid ^ (vsid << 25) ^ pteg) & htab_hash_mask;
-			break;
-		default:
-			avpn = vpi = size = 0;
+			seg_off |= vpi << shift;
 		}
-		avpn |= (vpi << mmu_psize_defs[size].shift);
+		*va = vsid << SID_SHIFT_1T | seg_off;
+	default:
+		*va = size = 0;
 	}
-
-	*va = avpn;
 	*psize = size;
-	*ssize = hpte_v >> HPTE_V_SSIZE_SHIFT;
 }
 
 /*
-- 
1.7.10
