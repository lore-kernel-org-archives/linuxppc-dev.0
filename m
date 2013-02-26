Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D238D2C03F6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:06:06 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 26 Feb 2013 18:01:23 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9180E2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:05:52 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1Q85okB7143856
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:05:50 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1Q85phj008279
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:05:51 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V1 14/24] powerpc: Fix hpte_decode to use the correct
 decoding for page sizes
Date: Tue, 26 Feb 2013 13:35:04 +0530
Message-Id: <1361865914-13911-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
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
rrrr rrrz 	≥8KB
rrrr rrzz	≥16KB
rrrr rzzz 	≥32KB
rrrr zzzz 	≥64KB
rrrz zzzz 	≥128KB
rrzz zzzz 	≥256KB
rzzz zzzz	≥512KB
zzzz zzzz 	≥1MB

ISA doc also says
"The values of the “z” bits used to specify each size, along with all possible
values of “r” bits in the LP field, must result in LP values distinct from
other LP values for other sizes."

based on the above update hpte_decode to use the correct decoding for LP bits.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index e800b26..2c6940f 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -428,19 +428,15 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			int *psize, int *apsize, int *ssize, unsigned long *vpn)
 {
 	unsigned long avpn, pteg, vpi;
-	unsigned long hpte_r = hpte->r;
 	unsigned long hpte_v = hpte->v;
 	unsigned long vsid, seg_off;
-	int i, size, a_size = MMU_PAGE_4K, shift, penc;
+	int size, a_size = MMU_PAGE_4K, shift, mask;
+	/* Look at the 8 bit LP value */
+	unsigned int lp = (hpte->r >> LP_SHIFT) & ((1 << LP_BITS) - 1);
 
 	if (!(hpte_v & HPTE_V_LARGE))
 		size = MMU_PAGE_4K;
 	else {
-		for (i = 0; i < LP_BITS; i++) {
-			if ((hpte_r & LP_MASK(i+1)) == LP_MASK(i+1))
-				break;
-		}
-		penc = LP_MASK(i+1) >> LP_SHIFT;
 		for (size = 0; size < MMU_PAGE_COUNT; size++) {
 
 			/* 4K pages are not represented by LP */
@@ -450,12 +446,23 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			/* valid entries have a shift value */
 			if (!mmu_psize_defs[size].shift)
 				continue;
-			for (a_size = 0; a_size < MMU_PAGE_COUNT; a_size++)
-				if (penc == mmu_psize_defs[size].penc[a_size])
+
+			for (a_size = 0; a_size < MMU_PAGE_COUNT; a_size++) {
+				/* valid entries have a shift value */
+				if (!mmu_psize_defs[a_size].shift)
+					continue;
+
+				shift = mmu_psize_defs[a_size].shift - 11;
+				if (shift > 9)
+					shift = 9;
+				mask = (1 << shift) - 1;
+				if ((lp & mask) ==
+				    mmu_psize_defs[size].penc[a_size]) {
 					goto out;
+				}
+			}
 		}
 	}
-
 out:
 	/* This works for all page sizes, and for 256M and 1T segments */
 	*ssize = hpte_v >> HPTE_V_SSIZE_SHIFT;
-- 
1.7.10
