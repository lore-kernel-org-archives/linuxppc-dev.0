Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A7E6B140094
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 15:07:47 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Apr 2014 15:07:46 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DB4003578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 15:07:44 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3L4krsY1048916
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 14:46:54 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3L57hek012464
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 15:07:43 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc/mm: Fix tlbie to add AVAL fields for 64K pages
Date: Mon, 21 Apr 2014 10:37:36 +0530
Message-Id: <1398056856-17891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

The if condition check was based on a draft ISA doc. Remove the same.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 3ea26c25590b..cf1d325eae8b 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -82,17 +82,14 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 		va &= ~((1ul << mmu_psize_defs[apsize].shift) - 1);
 		va |= penc << 12;
 		va |= ssize << 8;
-		/* Add AVAL part */
-		if (psize != apsize) {
-			/*
-			 * MPSS, 64K base page size and 16MB parge page size
-			 * We don't need all the bits, but rest of the bits
-			 * must be ignored by the processor.
-			 * vpn cover upto 65 bits of va. (0...65) and we need
-			 * 58..64 bits of va.
-			 */
-			va |= (vpn & 0xfe);
-		}
+		/*
+		 * AVAL bits:
+		 * We don't need all the bits, but rest of the bits
+		 * must be ignored by the processor.
+		 * vpn cover upto 65 bits of va. (0...65) and we need
+		 * 58..64 bits of va.
+		 */
+		va |= (vpn & 0xfe); /* AVAL */
 		va |= 1; /* L */
 		asm volatile(ASM_FTR_IFCLR("tlbie %0,1", PPC_TLBIE(%1,%0), %2)
 			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
@@ -133,17 +130,14 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 		va &= ~((1ul << mmu_psize_defs[apsize].shift) - 1);
 		va |= penc << 12;
 		va |= ssize << 8;
-		/* Add AVAL part */
-		if (psize != apsize) {
-			/*
-			 * MPSS, 64K base page size and 16MB parge page size
-			 * We don't need all the bits, but rest of the bits
-			 * must be ignored by the processor.
-			 * vpn cover upto 65 bits of va. (0...65) and we need
-			 * 58..64 bits of va.
-			 */
-			va |= (vpn & 0xfe);
-		}
+		/*
+		 * AVAL bits:
+		 * We don't need all the bits, but rest of the bits
+		 * must be ignored by the processor.
+		 * vpn cover upto 65 bits of va. (0...65) and we need
+		 * 58..64 bits of va.
+		 */
+		va |= (vpn & 0xfe);
 		va |= 1; /* L */
 		asm volatile(".long 0x7c000224 | (%0 << 11) | (1 << 21)"
 			     : : "r"(va) : "memory");
-- 
1.9.1
