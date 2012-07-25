Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 345F02C00B4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 22:58:34 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 25 Jul 2012 22:58:23 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6PCoK2H6881644
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 22:50:21 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6PCwTRw015511
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 22:58:29 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V4 11/12] arch/powerpc: properly offset the context bits for
 1T segemnts
Date: Wed, 25 Jul 2012 18:28:04 +0530
Message-Id: <1343221085-30661-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1343221085-30661-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1343221085-30661-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We should do rldimi r10,r9,USER_ESID_BITS,0 only after populating
r10 with ESID bits.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb_low.S |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index db2cb3f..7bd8438 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -59,6 +59,7 @@ _GLOBAL(slb_miss_kernel_load_linear)
 BEGIN_FTR_SECTION
 	b	slb_finish_load
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
+	srdi	r10,r10,40-28		/* get 1T ESID */
 	b	slb_finish_load_1T
 
 1:
@@ -88,6 +89,7 @@ _GLOBAL(slb_miss_kernel_load_vmemmap)
 BEGIN_FTR_SECTION
 	b	slb_finish_load
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
+	srdi	r10,r10,40-28		/* get 1T ESID */
 	b	slb_finish_load_1T
 
 0:	/* user address: proto-VSID = context << 15 | ESID. First check
@@ -155,13 +157,16 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	ld	r9,PACACONTEXTID(r13)
 BEGIN_FTR_SECTION
 	cmpldi	r10,0x1000
+	bge	9f
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	rldimi	r10,r9,USER_ESID_BITS,0
+	b	slb_finish_load
 BEGIN_FTR_SECTION
-	bge	slb_finish_load_1T
+9:
+	srdi	r10,r10,40-28		/* get 1T ESID */
+	rldimi	r10,r9,USER_ESID_BITS,0
+	b	slb_finish_load_1T
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
-	b	slb_finish_load
-
 8:	/* invalid EA */
 	li	r10,0			/* BAD_VSID */
 	li	r11,SLB_VSID_USER	/* flags don't much matter */
@@ -292,7 +297,6 @@ _GLOBAL(slb_compare_rr_to_size)
  * r3 = EA, r10 = proto-VSID, r11 = flags, clobbers r9
  */
 slb_finish_load_1T:
-	srdi	r10,r10,40-28		/* get 1T ESID */
 	ASM_VSID_SCRAMBLE(r10,r9,1T)
 	/*
 	 * bits above VSID_BITS_1T need to be ignored from r10
-- 
1.7.10
