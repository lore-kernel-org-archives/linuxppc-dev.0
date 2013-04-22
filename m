Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A4DAA2C028B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:02:36 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 20:00:20 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 981CA2CE804C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:02:33 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3MA2RK134472144
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:02:27 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3MA2Wrr011789
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:02:33 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, David Gibson <dwg@au1.ibm.com>
Subject: [PATCH -V6 12/27] powerpc: Fix hpte_decode to use the correct
 decoding for page sizes
Date: Mon, 22 Apr 2013 15:30:46 +0530
Message-Id: <1366624861-24948-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

As per ISA doc, we encode base and actual page size in the LP bits of
PTE. The number of bit used to encode the page sizes depend on actual
page size.  ISA doc lists this as

   PTE LP     actual page size
rrrr rrrz 	>=8KB
rrrr rrzz	>=16KB
rrrr rzzz 	>=32KB
rrrr zzzz 	>=64KB
rrrz zzzz 	>=128KB
rrzz zzzz 	>=256KB
rzzz zzzz	>=512KB
zzzz zzzz 	>=1MB

ISA doc also says
"The values of the “z” bits used to specify each size, along with all possible
values of “r” bits in the LP field, must result in LP values distinct from
other LP values for other sizes."

based on the above update hpte_decode to use the correct decoding for LP bits.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c |   53 ++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 14e3fe8..bb920ee 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -245,19 +245,10 @@ static long native_hpte_remove(unsigned long hpte_group)
 	return i;
 }
 
-static inline int hpte_actual_psize(struct hash_pte *hptep, int psize)
+static inline int __hpte_actual_psize(unsigned int lp, int psize)
 {
 	int i, shift;
 	unsigned int mask;
-	/* Look at the 8 bit LP value */
-	unsigned int lp = (hptep->r >> LP_SHIFT) & ((1 << LP_BITS) - 1);
-
-	if (!(hptep->v & HPTE_V_VALID))
-		return -1;
-
-	/* First check if it is large page */
-	if (!(hptep->v & HPTE_V_LARGE))
-		return MMU_PAGE_4K;
 
 	/* start from 1 ignoring MMU_PAGE_4K */
 	for (i = 1; i < MMU_PAGE_COUNT; i++) {
@@ -284,6 +275,21 @@ static inline int hpte_actual_psize(struct hash_pte *hptep, int psize)
 	return -1;
 }
 
+static inline int hpte_actual_psize(struct hash_pte *hptep, int psize)
+{
+	/* Look at the 8 bit LP value */
+	unsigned int lp = (hptep->r >> LP_SHIFT) & ((1 << LP_BITS) - 1);
+
+	if (!(hptep->v & HPTE_V_VALID))
+		return -1;
+
+	/* First check if it is large page */
+	if (!(hptep->v & HPTE_V_LARGE))
+		return MMU_PAGE_4K;
+
+	return __hpte_actual_psize(lp, psize);
+}
+
 static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 				 unsigned long vpn, int psize, int ssize,
 				 int local)
@@ -425,42 +431,27 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			int *psize, int *apsize, int *ssize, unsigned long *vpn)
 {
 	unsigned long avpn, pteg, vpi;
-	unsigned long hpte_r = hpte->r;
 	unsigned long hpte_v = hpte->v;
 	unsigned long vsid, seg_off;
-	int i, size, a_size, shift, penc;
+	int size, a_size, shift;
+	/* Look at the 8 bit LP value */
+	unsigned int lp = (hpte->r >> LP_SHIFT) & ((1 << LP_BITS) - 1);
 
 	if (!(hpte_v & HPTE_V_LARGE)) {
 		size   = MMU_PAGE_4K;
 		a_size = MMU_PAGE_4K;
 	} else {
-		for (i = 0; i < LP_BITS; i++) {
-			if ((hpte_r & LP_MASK(i+1)) == LP_MASK(i+1))
-				break;
-		}
-		penc = LP_MASK(i+1) >> LP_SHIFT;
 		for (size = 0; size < MMU_PAGE_COUNT; size++) {
 
 			/* valid entries have a shift value */
 			if (!mmu_psize_defs[size].shift)
 				continue;
-			for (a_size = 0; a_size < MMU_PAGE_COUNT; a_size++) {
-
-				/* 4K pages are not represented by LP */
-				if (a_size == MMU_PAGE_4K)
-					continue;
 
-				/* valid entries have a shift value */
-				if (!mmu_psize_defs[a_size].shift)
-					continue;
-
-				if (penc == mmu_psize_defs[size].penc[a_size])
-					goto out;
-			}
+			a_size = __hpte_actual_psize(lp, size);
+			if (a_size != -1)
+				break;
 		}
 	}
-
-out:
 	/* This works for all page sizes, and for 256M and 1T segments */
 	*ssize = hpte_v >> HPTE_V_SSIZE_SHIFT;
 	shift = mmu_psize_defs[size].shift;
-- 
1.7.10
