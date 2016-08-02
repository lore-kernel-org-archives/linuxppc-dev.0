Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3N6b5BxtzDr0T
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:11:03 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7248pU9130428
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 00:11:01 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24gn49j6x5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 00:11:01 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 2 Aug 2016 14:10:57 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 51D122CE805B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:10:56 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u724Au2u20119560
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:10:56 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u724AtAq020020
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:10:56 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 4/9] powerpc/powernv: Use CPU-endian PEST in
 pnv_pci_dump_p7ioc_diag_data()
Date: Tue,  2 Aug 2016 14:10:32 +1000
In-Reply-To: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1470111037-18531-5-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes the warnings reported from sparse:

  gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
                             arch/powerpc/platforms/powernv/pci.o
        :
  arch/powerpc/platforms/powernv/pci.c:312:33: \
  warning: restricted __be64 degrades to integer
  arch/powerpc/platforms/powernv/pci.c:313:33: \
  warning: restricted __be64 degrades to integer

Fixes: cee72d5bb489 ("powerpc/powernv: Display diag data on p7ioc EEH errors")
Cc: stable@vger.kernel.org # v3.3+
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 6701dd5..b32bafb 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -309,8 +309,8 @@ static void pnv_pci_dump_p7ioc_diag_data(struct pci_controller *hose,
 			be64_to_cpu(data->dma1ErrorLog1));
 
 	for (i = 0; i < OPAL_P7IOC_NUM_PEST_REGS; i++) {
-		if ((data->pestA[i] >> 63) == 0 &&
-		    (data->pestB[i] >> 63) == 0)
+		if ((be64_to_cpu(data->pestA[i]) >> 63) == 0 &&
+		    (be64_to_cpu(data->pestB[i]) >> 63) == 0)
 			continue;
 
 		pr_info("PE[%3d] A/B: %016llx %016llx\n",
-- 
2.1.0
