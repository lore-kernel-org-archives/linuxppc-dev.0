Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZ1Qp2bD5zDw40
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 14:42:42 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB83cmYn045470
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 22:42:39 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 276reew74v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Dec 2016 22:42:39 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 7 Dec 2016 20:42:38 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Fixup wrong LPCR_VRMASD value
Date: Thu,  8 Dec 2016 09:12:13 +0530
Message-Id: <20161208034213.21700-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit a4b349540a26af ("powerpc/mm: Cleanup LPCR defines") we updated
LPCR_VRMASD wrongly as below.

-#define   LPCR_VRMASD  (0x1ful << (63-16))
+#define   LPCR_VRMASD_SH       47
+#define   LPCR_VRMASD          (ASM_CONST(1) << LPCR_VRMASD_SH)

We initialize the VRMA bits in LPCR to 0x00 in kvm. Hence using a different
mask value as above while updating lpcr should not have any impact.

This patch updates it to the correct value
Fixes: a4b349540a26af ("powerpc/mm: Cleanup LPCR defines") we updated

Reported-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 9e1499f98def..1c17e208db78 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -337,7 +337,7 @@
 #define   LPCR_DPFD_SH		52
 #define   LPCR_DPFD		(ASM_CONST(7) << LPCR_DPFD_SH)
 #define   LPCR_VRMASD_SH	47
-#define   LPCR_VRMASD		(ASM_CONST(1) << LPCR_VRMASD_SH)
+#define   LPCR_VRMASD		(ASM_CONST(1f) << LPCR_VRMASD_SH)
 #define   LPCR_VRMA_L		ASM_CONST(0x0008000000000000)
 #define   LPCR_VRMA_LP0		ASM_CONST(0x0001000000000000)
 #define   LPCR_VRMA_LP1		ASM_CONST(0x0000800000000000)
-- 
2.10.2
