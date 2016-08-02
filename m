Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3N6V3z1czDrF1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:10:58 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7248qs5106204
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 00:10:56 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24gpjfg3et-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 00:10:56 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 2 Aug 2016 14:10:53 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1113B3578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:10:52 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u724Apts28311670
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:10:51 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u724Apdg030138
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:10:51 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 3/9] powerpc/powernv: Specify proper data type for
 PCI_SLOT_ID_PREFIX
Date: Tue,  2 Aug 2016 14:10:31 +1000
In-Reply-To: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1470111037-18531-4-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes the warning reported from sparse:

  gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
                             arch/powerpc/platforms/powernv/eeh-powernv.o
        :
  arch/powerpc/platforms/powernv/eeh-powernv.c:875:23: \
  warning: constant 0x8000000000000000 is so big it is unsigned long

Fixes: ebe225312739 ("powerpc/powernv: Support PCI slot ID")
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pnv-pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index 0cbd813..62a36ed 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -15,7 +15,7 @@
 #include <misc/cxl-base.h>
 #include <asm/opal-api.h>
 
-#define PCI_SLOT_ID_PREFIX	0x8000000000000000
+#define PCI_SLOT_ID_PREFIX	(1UL << 63)
 #define PCI_SLOT_ID(phb_id, bdfn)	\
 	(PCI_SLOT_ID_PREFIX | ((uint64_t)(bdfn) << 16) | (phb_id))
 
-- 
2.1.0
