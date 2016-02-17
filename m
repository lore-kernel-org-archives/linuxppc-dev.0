Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FBA41A0356
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:58 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 13:45:58 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DEAF93578056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:53 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1H3jjX060948566
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:53 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1H3jHXq013055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:20 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 05/45] powerpc/powernv: Drop phb->bdfn_to_pe()
Date: Wed, 17 Feb 2016 14:43:48 +1100
Message-Id: <1455680668-23298-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This drops struct pnv_phb::bdfn_to_pe() as nobody uses it.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 9 ---------
 arch/powerpc/platforms/powernv/pci.h      | 1 -
 2 files changed, 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 524c9c7..10ecd97 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3195,12 +3195,6 @@ static bool pnv_pci_enable_device_hook(struct pci_dev *dev)
 	return true;
 }
 
-static u32 pnv_ioda_bdfn_to_pe(struct pnv_phb *phb, struct pci_bus *bus,
-			       u32 devfn)
-{
-	return phb->ioda.pe_rmap[(bus->number << 8) | devfn];
-}
-
 static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
 {
 	struct pnv_phb *phb = hose->private_data;
@@ -3377,9 +3371,6 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	phb->freeze_pe = pnv_ioda_freeze_pe;
 	phb->unfreeze_pe = pnv_ioda_unfreeze_pe;
 
-	/* Setup RID -> PE mapping function */
-	phb->bdfn_to_pe = pnv_ioda_bdfn_to_pe;
-
 	/* Setup TCEs */
 	phb->dma_dev_setup = pnv_pci_ioda_dma_dev_setup;
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 3f814f3..78f035e 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -110,7 +110,6 @@ struct pnv_phb {
 			 unsigned int is_64, struct msi_msg *msg);
 	void (*dma_dev_setup)(struct pnv_phb *phb, struct pci_dev *pdev);
 	void (*fixup_phb)(struct pci_controller *hose);
-	u32 (*bdfn_to_pe)(struct pnv_phb *phb, struct pci_bus *bus, u32 devfn);
 	int (*init_m64)(struct pnv_phb *phb);
 	void (*reserve_m64_pe)(struct pci_bus *bus,
 			       unsigned long *pe_bitmap, bool all);
-- 
2.1.0
