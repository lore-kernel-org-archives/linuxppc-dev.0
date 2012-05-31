Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B57F0B7077
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2012 05:51:59 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 31 May 2012 19:41:40 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4VJiqxl26607636
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2012 05:44:52 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4VJptVD018316
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2012 05:51:56 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 anton@samba.org
Subject: [Early RFC 3/6] arch/powerpc: Simplify hpte_decode
Date: Fri,  1 Jun 2012 01:20:38 +0530
Message-Id: <1338493841-9926-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1338493841-9926-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1338493841-9926-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This patch simplify hpte_decode for easy switching of virtual address to
vsid and segment offset combination in the later patch

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c |   51 ++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index cab3892..76c2574 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -357,9 +357,10 @@ static void native_hpte_invalidate(unsigned long slot, struct virt_addr va,
 static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			int *psize, int *ssize, struct virt_addr *va)
 {
+	unsigned long avpn, pteg, vpi;
 	unsigned long hpte_r = hpte->r;
 	unsigned long hpte_v = hpte->v;
-	unsigned long avpn;
+	unsigned long vsid, seg_off;
 	int i, size, shift, penc;
 
 	if (!(hpte_v & HPTE_V_LARGE))
@@ -386,32 +387,40 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
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
+		va->addr = vsid << 28 | seg_off;
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
+		va->addr = vsid << 40 | seg_off;
+	default:
+		seg_off = 0;
+		vsid    = 0;
+		va->addr = 0;
 	}
-
-	va->addr = avpn;
 	*psize = size;
-	*ssize = hpte_v >> HPTE_V_SSIZE_SHIFT;
 }
 
 /*
-- 
1.7.10
