Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E77D12C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 05:37:51 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 29 Apr 2013 01:04:10 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 88B20E0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 01:09:56 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3SJbfc461210826
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 01:07:41 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3SJbknd003331
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 05:37:47 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, dwg@au1.ibm.com,
 linux-mm@kvack.org
Subject: [PATCH -V7 18/18] powerpc: Update tlbie/tlbiel as per ISA doc
Date: Mon, 29 Apr 2013 01:07:39 +0530
Message-Id: <1367177859-7893-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1367177859-7893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1367177859-7893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Encode the actual page correctly in tlbie/tlbiel. This make sure we handle
multiple page size segment correctly.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index bb920ee..6a2aead 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -61,7 +61,10 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 
 	switch (psize) {
 	case MMU_PAGE_4K:
+		/* clear out bits after (52) [0....52.....63] */
+		va &= ~((1ul << (64 - 52)) - 1);
 		va |= ssize << 8;
+		va |= mmu_psize_defs[apsize].sllp << 6;
 		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%1,%0), %2)
 			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
 			     : "memory");
@@ -69,9 +72,20 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 	default:
 		/* We need 14 to 14 + i bits of va */
 		penc = mmu_psize_defs[psize].penc[apsize];
-		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
+		va &= ~((1ul << mmu_psize_defs[apsize].shift) - 1);
 		va |= penc << 12;
 		va |= ssize << 8;
+		/* Add AVAL part */
+		if (psize != apsize) {
+			/*
+			 * MPSS, 64K base page size and 16MB parge page size
+			 * We don't need all the bits, but rest of the bits
+			 * must be ignored by the processor.
+			 * vpn cover upto 65 bits of va. (0...65) and we need
+			 * 58..64 bits of va.
+			 */
+			va |= (vpn & 0xfe);
+		}
 		va |= 1; /* L */
 		asm volatile(ASM_FTR_IFCLR("tlbie %0,1", PPC_TLBIE(%1,%0), %2)
 			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
@@ -96,16 +110,30 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 
 	switch (psize) {
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
 		penc = mmu_psize_defs[psize].penc[apsize];
-		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
+		va &= ~((1ul << mmu_psize_defs[apsize].shift) - 1);
 		va |= penc << 12;
 		va |= ssize << 8;
+		/* Add AVAL part */
+		if (psize != apsize) {
+			/*
+			 * MPSS, 64K base page size and 16MB parge page size
+			 * We don't need all the bits, but rest of the bits
+			 * must be ignored by the processor.
+			 * vpn cover upto 65 bits of va. (0...65) and we need
+			 * 58..64 bits of va.
+			 */
+			va |= (vpn & 0xfe);
+		}
 		va |= 1; /* L */
 		asm volatile(".long 0x7c000224 | (%0 << 11) | (1 << 21)"
 			     : : "r"(va) : "memory");
-- 
1.8.1.2
