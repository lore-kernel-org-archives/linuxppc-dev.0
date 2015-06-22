Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 074841A03ED
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 13:46:50 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 22 Jun 2015 13:46:49 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2D0362CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 13:46:46 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5M3kbtm4587888
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 13:46:46 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5M3kDO8019268
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 13:46:13 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Include VF PE in PELTV of PF PE
Date: Mon, 22 Jun 2015 13:45:47 +1000
Message-Id: <1434944747-6028-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PELTV of PF PE should include VF PE, which is missed by current
code, so that the VF PE is frozen automatically when freezing PF PE.
The patch fixes the PELTV of PF PE to include VF PE.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 726c7ee..b1248ca 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -622,7 +622,7 @@ static int pnv_ioda_set_peltv(struct pnv_phb *phb,
 		pdev = pe->pdev->bus->self;
 #ifdef CONFIG_PCI_IOV
 	else if (pe->flags & PNV_IODA_PE_VF)
-		pdev = pe->parent_dev->bus->self;
+		pdev = pe->parent_dev;
 #endif /* CONFIG_PCI_IOV */
 	while (pdev) {
 		struct pci_dn *pdn = pci_get_pdn(pdev);
-- 
2.1.0
