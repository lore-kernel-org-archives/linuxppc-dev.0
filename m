Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYX0Q3dzQzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 12:36:06 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rYX0Q0FDqz9sxS
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 12:36:05 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L2YJU0038934
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Jun 2016 22:36:04 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n1kvat0p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Jun 2016 22:36:04 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 21 Jun 2016 12:36:01 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 92F0E2CE8054
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 12:35:59 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5L2Zxwm7274792
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 12:35:59 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5L2Zw9c016440
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 12:35:59 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Print correct PHB type names
Date: Tue, 21 Jun 2016 12:35:56 +1000
Message-Id: <1466476556-12627-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We're initializing "IODA1" and "IODA2" PHBs though they are IODA2
and NPU PHBs as below kernel log indicates.

   Initializing IODA1 OPAL PHB /pciex@3fffe40700000
   Initializing IODA2 OPAL PHB /pciex@3fff000400000

This fixes the PHB names. After it's applied, we get:

   Initializing IODA2 PHB (/pciex@3fffe40700000)
   Initializing NPU PHB (/pciex@3fff000400000)

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index e0a8a92..7f952a6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -55,6 +55,7 @@
 #define POWERNV_IOMMU_DEFAULT_LEVELS	1
 #define POWERNV_IOMMU_MAX_LEVELS	5
 
+static const char * const pnv_phb_names[] = { "IODA1", "IODA2", "NPU" };
 static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl);
 
 void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
@@ -3626,7 +3627,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	void *aux;
 	long rc;
 
-	pr_info("Initializing IODA%d OPAL PHB %s\n", ioda_type, np->full_name);
+	pr_info("Initializing %s PHB (%s)\n",
+		pnv_phb_names[ioda_type], of_node_full_name(np));
 
 	prop64 = of_get_property(np, "ibm,opal-phbid", NULL);
 	if (!prop64) {
-- 
2.1.0
