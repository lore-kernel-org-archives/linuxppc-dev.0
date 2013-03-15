Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 443682C09F7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 20:44:17 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 15 Mar 2013 15:07:51 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id B14F63940149
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 15:10:13 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2F9eAQR10551608
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 15:10:10 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2F9eBR2009615
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 20:40:13 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V3 09/25] powerpc: Fix hpte_decode to use the correct
 decoding for page sizes
Date: Fri, 15 Mar 2013 15:09:51 +0530
Message-Id: <1363340407-22619-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1363340407-22619-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1363340407-22619-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Acked-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c |   38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 910b50d..af9eb1c 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -415,41 +415,51 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			int *psize, int *apsize, int *ssize, unsigned long *vpn)
 {
 	unsigned long avpn, pteg, vpi;
-	unsigned long hpte_r = hpte->r;
 	unsigned long hpte_v = hpte->v;
 	unsigned long vsid, seg_off;
-	int i, size, a_size, shift, penc;
+	int size, a_size, shift, mask;
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
 
+			/* start from 1 ignoring MMU_PAGE_4K */
+			for (a_size = 1; a_size < MMU_PAGE_COUNT; a_size++) {
 				/* valid entries have a shift value */
 				if (!mmu_psize_defs[a_size].shift)
 					continue;
 
-				if (penc == mmu_psize_defs[size].penc[a_size])
+				/* invalid penc */
+				if (mmu_psize_defs[size].penc[a_size] == -1)
+					continue;
+				/*
+				 * encoding bits per actual page size
+				 *        PTE LP     actual page size
+				 *    rrrr rrrz		≥8KB
+				 *    rrrr rrzz		≥16KB
+				 *    rrrr rzzz		≥32KB
+				 *    rrrr zzzz		≥64KB
+				 * .......
+				 */
+				shift = mmu_psize_defs[a_size].shift - LP_SHIFT;
+				if (shift > LP_BITS)
+					shift = LP_BITS;
+				mask = (1 << shift) - 1;
+				if ((lp & mask) ==
+				    mmu_psize_defs[size].penc[a_size]) {
 					goto out;
+				}
 			}
 		}
 	}
-
 out:
 	/* This works for all page sizes, and for 256M and 1T segments */
 	*ssize = hpte_v >> HPTE_V_SSIZE_SHIFT;
-- 
1.7.10
