Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skPxS6yKKzDrWL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 14:34:36 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8S4WvVB079799
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 00:34:35 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25r4h0xe6q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 00:34:35 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 14:34:32 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 58C1E2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 14:34:30 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8S4YUDA5243270
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 14:34:30 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8S4YTf6010140
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 14:34:30 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v3 4/6] powerpc/powernv: Unfreeze PE on allocation
Date: Wed, 28 Sep 2016 14:34:56 +1000
In-Reply-To: <1475037298-19188-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1475037298-19188-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1475037298-19188-5-git-send-email-gwshan@linux.vnet.ibm.com>
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
index 38a5c65..841395e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -133,9 +133,21 @@ static inline bool pnv_pci_is_m64_flags(unsigned long resource_flags)
 
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
