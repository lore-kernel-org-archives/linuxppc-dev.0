Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B2A692C008E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2013 02:39:54 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 16 Feb 2013 01:32:49 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4B8D72CE804A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2013 02:39:46 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1FFRWnx1179938
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2013 02:27:32 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1FFdjkP022079
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2013 02:39:45 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, phileas-fogg@mail.ru,
 geoff@infradead.org
Subject: [PATCH -V2 1/2] powerpc: Make VSID_BITS* dependency explicit
Date: Fri, 15 Feb 2013 21:09:37 +0530
Message-Id: <1360942778-21795-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

VSID_BITS and VSID_BITS_1T depends on the context bits  and user esid
bits. Make the dependency explicit

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 2fdb47a..5f8c2bd 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -381,21 +381,22 @@ extern void slb_set_size(u16 size);
  * hash collisions.
  */
 
+#define CONTEXT_BITS		19
+#define USER_ESID_BITS		18
+#define USER_ESID_BITS_1T	6
+
 /*
  * This should be computed such that protovosid * vsid_mulitplier
  * doesn't overflow 64 bits. It should also be co-prime to vsid_modulus
  */
 #define VSID_MULTIPLIER_256M	ASM_CONST(12538073)	/* 24-bit prime */
-#define VSID_BITS_256M		38
+#define VSID_BITS_256M		(CONTEXT_BITS + USER_ESID_BITS + 1)
 #define VSID_MODULUS_256M	((1UL<<VSID_BITS_256M)-1)
 
 #define VSID_MULTIPLIER_1T	ASM_CONST(12538073)	/* 24-bit prime */
-#define VSID_BITS_1T		26
+#define VSID_BITS_1T		(CONTEXT_BITS + USER_ESID_BITS_1T + 1)
 #define VSID_MODULUS_1T		((1UL<<VSID_BITS_1T)-1)
 
-#define CONTEXT_BITS		19
-#define USER_ESID_BITS		18
-#define USER_ESID_BITS_1T	6
 
 #define USER_VSID_RANGE	(1UL << (USER_ESID_BITS + SID_SHIFT))
 
-- 
1.7.10
