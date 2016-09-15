Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZMHS3m0WzDsTX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 12:07:16 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sZMHR6Hk8z9sD5
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 12:07:15 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8F23HsO020817
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Sep 2016 22:07:14 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25exce9mkg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Sep 2016 22:07:14 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 12:07:11 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D057B2CE8056
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 12:07:08 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8F278R163307888
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 12:07:08 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8F278Z6006004
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 12:07:08 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 3/4] powerpc/powernv: Unfreeze PE on allocation
Date: Thu, 15 Sep 2016 12:07:21 +1000
In-Reply-To: <1473905242-898-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1473905242-898-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1473905242-898-4-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This unfreezes PE when it's initialized because the PE might be put
into frozen state in the last hot remove path. It's not harmful to
do so if the PE is already in unfrozen state.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c38a6a1..5122257 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -126,9 +126,21 @@ static inline bool pnv_pci_is_m64(struct pnv_phb *phb, struct resource *r)
 
 static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
 {
+	s64 rc;
+
 	phb->ioda.pe_array[pe_no].phb = phb;
 	phb->ioda.pe_array[pe_no].pe_number = pe_no;
 
+	/* Clear the PE frozen state as it might be put into frozen state
+	 * in the last PCI remove path. It's not harmful to do so when the
+	 * PE is already in unfrozen state.
+	 */
+	rc = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no,
+				       OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+	if (rc != OPAL_SUCCESS)
+		pr_warn("%s: Error %lld unfreezing PHB#%d-PE#%d\n",
+			__func__, rc, phb->hose->global_number, pe_no);
+
 	return &phb->ioda.pe_array[pe_no];
 }
 
-- 
2.1.0
