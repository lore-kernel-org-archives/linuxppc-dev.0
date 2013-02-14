Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CDDCE2C033C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 19:36:48 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 14 Feb 2013 14:04:11 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A02681258057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 14:07:12 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1E8aQHC31719478
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 14:06:27 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1E8aSgR020301
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 19:36:28 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, phileas-fogg@mail.ru,
 geoff@infradead.org
Subject: [PATCH 3/4] powerpc: Don't update r10 early in the call
Date: Thu, 14 Feb 2013 14:06:22 +0530
Message-Id: <1360830983-1812-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1360830983-1812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <a>
 <1360830983-1812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

This enables us to use r10 as scratch in the code.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb_low.S |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 487f998..2a233cb 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -34,7 +34,6 @@ _GLOBAL(slb_allocate_realmode)
 	/* r3 = faulting address */
 
 	srdi	r9,r3,60		/* get region */
-	srdi	r10,r3,28		/* get esid */
 	cmpldi	cr7,r9,0xc		/* cmp PAGE_OFFSET for later use */
 
 	/* r3 = address, r10 = esid, cr7 = <> PAGE_OFFSET */
@@ -63,7 +62,7 @@ _GLOBAL(slb_miss_kernel_load_linear)
 	subi	r9,r9,(0xc + 4 + 1)
 	lis	r10, 8
 	add	r9,r9,r10
-	srdi	r10,r3,28 /* FIXME!! doing it twice */
+	srdi	r10,r3,SID_SHIFT	/* get esid */
 	/*
 	 * for 1T we shift 12 bits more.  slb_finish_load_1T will do
 	 * the necessary adjustment
@@ -75,6 +74,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	b	slb_finish_load_1T
 
 1:
+	srdi	r10,r3,SID_SHIFT	/* get esid */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	/* Check virtual memmap region. To be patches at kernel boot */
 	cmpldi	cr0,r9,0xf
@@ -116,9 +116,11 @@ BEGIN_FTR_SECTION
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	b	slb_finish_load_1T
 
-0:	/* user address: proto-VSID = context << 15 | ESID. First check
+0:	/*
+	 * user address: proto-VSID = context << 15 | ESID. First check
 	 * if the address is within the boundaries of the user region
 	 */
+	srdi	r10,r3,SID_SHIFT	/* get esid */
 	srdi.	r9,r10,USER_ESID_BITS
 	bne-	8f			/* invalid ea bits set */
 
-- 
1.7.10
