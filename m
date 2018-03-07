Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxCKN4Nt8zDqjB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 23:15:52 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w27CE2Dq025854
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Mar 2018 07:15:50 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gjet72vfw-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2018 07:15:50 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 7 Mar 2018 07:15:48 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/hash: Move the slb_addr_limit check within
 PPC_MM_SLICES
Date: Wed,  7 Mar 2018 17:45:39 +0530
Message-Id: <20180307121539.20745-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Should not have any impact, because we always select PP_MM_SLICES these days.
Nevertheless it is good to indicate that slb_addr_limit is available only
with slice code.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb_low.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index c66cb06e73a1..337ef162851d 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -166,6 +166,8 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	 */
 	cmpdi	r9, 0
 	bne-	8f
+
+#ifdef CONFIG_PPC_MM_SLICES
         /*
          * user space make sure we are within the allowed limit
 	 */
@@ -183,7 +185,6 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	 * really do dynamic patching unfortunately as processes might flip
 	 * between 4k and 64k standard page size
 	 */
-#ifdef CONFIG_PPC_MM_SLICES
 	/* r10 have esid */
 	cmpldi	r10,16
 	/* below SLICE_LOW_TOP */
-- 
2.14.3
