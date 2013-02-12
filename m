Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 077E82C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 05:32:06 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 12 Feb 2013 23:59:19 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id B524FE004E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 00:02:47 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1CIVsOk31653926
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 00:01:54 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1CIVu2B012214
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 05:31:57 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/2] powerpc: Make VSID_BITS* dependency explicit
Date: Wed, 13 Feb 2013 00:01:44 +0530
Message-Id: <1360693905-23503-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
