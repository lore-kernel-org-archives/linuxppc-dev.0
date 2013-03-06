Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 27D812C06AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 17:11:09 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 6 Mar 2013 16:06:59 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DAC4C2BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 17:10:59 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r265wEjY26345566
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 16:58:14 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r266AwU2014847
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 17:10:59 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 13/26] powerpc: Update tlbie/tlbiel as per ISA doc
Date: Wed,  6 Mar 2013 11:40:14 +0530
Message-Id: <1362550227-575-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

This make sure we handle multiple page size segment correctly.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c |   52 +++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 5e7f45c..f106fa4 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -39,7 +39,7 @@
 
 DEFINE_RAW_SPINLOCK(native_tlbie_lock);
 
-static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
+static inline void __tlbie(unsigned long vpn, int bpsize, int apsize, int ssize)
 {
 	unsigned long va;
 	unsigned int penc;
@@ -59,19 +59,33 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 	 */
 	va &= ~(0xffffULL << 48);
 
-	switch (psize) {
+	switch (bpsize) {
 	case MMU_PAGE_4K:
+		/* clear out bits after (52) [0....52.....63] */
+		va &= ~((1ul << (64 - 52)) - 1);
 		va |= ssize << 8;
+		va |= mmu_psize_defs[apsize].sllp << 6;
 		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%1,%0), %2)
 			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
 			     : "memory");
 		break;
 	default:
 		/* We need 14 to 14 + i bits of va */
-		penc = mmu_psize_defs[psize].penc[apsize];
-		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
+		penc = mmu_psize_defs[bpsize].penc[apsize];
+		/* clear out bits after (44) [0....44.....63] */
+		va &= ~((1ul << (64 - 44)) - 1);
 		va |= penc << 12;
 		va |= ssize << 8;
+		/* Add AVAL part */
+		if (bpsize != apsize) {
+			/*
+			 * MPSS, 64K base page size and 16MB parge page size
+			 * We don't need all the bits, but this seems to work.
+			 * vpn cover upto 65 bits of va. (0...65) and we need
+			 * 56..62 bits of va.
+			 */
+			va |= ((vpn >> 2) & 0xfe);
+		}
 		va |= 1; /* L */
 		asm volatile(ASM_FTR_IFCLR("tlbie %0,1", PPC_TLBIE(%1,%0), %2)
 			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
@@ -80,7 +94,7 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 	}
 }
 
-static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
+static inline void __tlbiel(unsigned long vpn, int bpsize, int apsize, int ssize)
 {
 	unsigned long va;
 	unsigned int penc;
@@ -94,18 +108,32 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 	 */
 	va &= ~(0xffffULL << 48);
 
-	switch (psize) {
+	switch (bpsize) {
 	case MMU_PAGE_4K:
+		/* clear out bits after(52) [0....52.....63] */
+		va &= ~((1ul << (64 - 52)) - 1);
 		va |= ssize << 8;
+		va |= mmu_psize_defs[apsize].sllp << 6;
 		asm volatile(".long 0x7c000224 | (%0 << 11) | (0 << 21)"
 			     : : "r"(va) : "memory");
 		break;
 	default:
 		/* We need 14 to 14 + i bits of va */
-		penc = mmu_psize_defs[psize].penc[apsize];
-		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
+		penc = mmu_psize_defs[bpsize].penc[apsize];
+		/* clear out bits after(44) [0....44.....63] */
+		va &= ~((1ul << (64 - 44)) - 1);
 		va |= penc << 12;
 		va |= ssize << 8;
+		/* Add AVAL part */
+		if (bpsize != apsize) {
+			/*
+			 * MPSS, 64K base page size and 16MB parge page size
+			 * We don't need all the bits, but this seems to work.
+			 * vpn cover upto 65 bits of va. (0...65) and we need
+			 * 56..62 bits of va.
+			 */
+			va |= ((vpn >> 2) & 0xfe);
+		}
 		va |= 1; /* L */
 		asm volatile(".long 0x7c000224 | (%0 << 11) | (1 << 21)"
 			     : : "r"(va) : "memory");
@@ -114,22 +142,22 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 
 }
 
-static inline void tlbie(unsigned long vpn, int psize, int apsize,
+static inline void tlbie(unsigned long vpn, int bpsize, int apsize,
 			 int ssize, int local)
 {
 	unsigned int use_local = local && mmu_has_feature(MMU_FTR_TLBIEL);
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 
 	if (use_local)
-		use_local = mmu_psize_defs[psize].tlbiel;
+		use_local = mmu_psize_defs[bpsize].tlbiel;
 	if (lock_tlbie && !use_local)
 		raw_spin_lock(&native_tlbie_lock);
 	asm volatile("ptesync": : :"memory");
 	if (use_local) {
-		__tlbiel(vpn, psize, apsize, ssize);
+		__tlbiel(vpn, bpsize, apsize, ssize);
 		asm volatile("ptesync": : :"memory");
 	} else {
-		__tlbie(vpn, psize, apsize, ssize);
+		__tlbie(vpn, bpsize, apsize, ssize);
 		asm volatile("eieio; tlbsync; ptesync": : :"memory");
 	}
 	if (lock_tlbie && !use_local)
-- 
1.7.10
