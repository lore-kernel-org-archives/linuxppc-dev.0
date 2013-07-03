Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB2A42C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 18:20:17 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 3 Jul 2013 18:10:35 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E70362BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 18:20:10 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6385B1L57933946
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jul 2013 18:05:12 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r638K9SS004295
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jul 2013 18:20:09 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/2] powerpc/mm: Use the correct SLB(LLP) encoding in tlbie
 instruction
Date: Wed,  3 Jul 2013 13:50:02 +0530
Message-Id: <1372839603-8308-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

The sllp value is stored in mmu_psize_defs in such a way that we can easily OR
the value to get the operand for slbmte instruction. ie, the L and LP bits are
not contiguous. Decode the bits and use them correctly in tlbie.
regression is introduced by 1f6aaaccb1b3af8613fe45781c1aefee2ae8c6b3
"powerpc: Update tlbie/tlbiel as per ISA doc"

Reported-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 3f0c30a..0de15fc 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -43,6 +43,7 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 {
 	unsigned long va;
 	unsigned int penc;
+	unsigned long sllp;
 
 	/*
 	 * We need 14 to 65 bits of va for a tlibe of 4K page
@@ -64,7 +65,9 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 		/* clear out bits after (52) [0....52.....63] */
 		va &= ~((1ul << (64 - 52)) - 1);
 		va |= ssize << 8;
-		va |= mmu_psize_defs[apsize].sllp << 6;
+		sllp = ((mmu_psize_defs[apsize].sllp & 0x100) >> 6) |
+			((mmu_psize_defs[apsize].sllp & 0x30) >> 4);
+		va |= sllp << 5;
 		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%1,%0), %2)
 			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
 			     : "memory");
@@ -98,6 +101,7 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 {
 	unsigned long va;
 	unsigned int penc;
+	unsigned long sllp;
 
 	/* VPN_SHIFT can be atmost 12 */
 	va = vpn << VPN_SHIFT;
@@ -113,7 +117,9 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 		/* clear out bits after(52) [0....52.....63] */
 		va &= ~((1ul << (64 - 52)) - 1);
 		va |= ssize << 8;
-		va |= mmu_psize_defs[apsize].sllp << 6;
+		sllp = ((mmu_psize_defs[apsize].sllp & 0x100) >> 6) |
+			((mmu_psize_defs[apsize].sllp & 0x30) >> 4);
+		va |= sllp << 5;
 		asm volatile(".long 0x7c000224 | (%0 << 11) | (0 << 21)"
 			     : : "r"(va) : "memory");
 		break;
-- 
1.8.1.2
