Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2E748140155
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:36 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:35 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D35832BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:32 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7dcax34930920
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:38 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80WIc023568
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:32 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 23/25] powerpc/powernv: pci_domain_nr() not reliable
Date: Thu, 24 Apr 2014 18:00:29 +1000
Message-Id: <1398326431-24305-24-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the PE contains single PCI function, "pe->pbus" would be NULL.
It's not reliable to be used by pci_domain_nr().  We just grab the
PCI domain number from the PCI host controller (struct pci_controller)
instance.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1934327..9807341 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -673,7 +673,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 				 TCE_PCI_SWINV_PAIR);
 	}
 	iommu_init_table(tbl, phb->hose->node);
-	iommu_register_group(tbl, pci_domain_nr(pe->pbus), pe->pe_number);
+	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
 
 	if (pe->pdev)
 		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
@@ -801,7 +801,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
 	}
 	iommu_init_table(tbl, phb->hose->node);
-	iommu_register_group(tbl, pci_domain_nr(pe->pbus), pe->pe_number);
+	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
 
 	if (pe->pdev)
 		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
-- 
1.8.3.2
