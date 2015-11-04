Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E8F011A4AD0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 01:06:17 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 19:36:15 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id D9FEC3940019
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 19:36:11 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4Dkkca38535230
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 19:36:11 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DD4V6012775
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:07 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 06/50] powerpc/powernv: Drop phb->bdfn_to_pe()
Date: Thu,  5 Nov 2015 00:12:06 +1100
Message-Id: <1446642770-4681-7-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
index 74288ab..968da91 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2978,12 +2978,6 @@ static bool pnv_pci_enable_device_hook(struct pci_dev *dev)
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
@@ -3144,9 +3138,6 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	phb->freeze_pe = pnv_ioda_freeze_pe;
 	phb->unfreeze_pe = pnv_ioda_unfreeze_pe;
 
-	/* Setup RID -> PE mapping function */
-	phb->bdfn_to_pe = pnv_ioda_bdfn_to_pe;
-
 	/* Setup TCEs */
 	phb->dma_dev_setup = pnv_pci_ioda_dma_dev_setup;
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index c8ff50e..49e3baf 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -106,7 +106,6 @@ struct pnv_phb {
 			 unsigned int is_64, struct msi_msg *msg);
 	void (*dma_dev_setup)(struct pnv_phb *phb, struct pci_dev *pdev);
 	void (*fixup_phb)(struct pci_controller *hose);
-	u32 (*bdfn_to_pe)(struct pnv_phb *phb, struct pci_bus *bus, u32 devfn);
 	int (*init_m64)(struct pnv_phb *phb);
 	void (*reserve_m64_pe)(struct pci_bus *bus,
 			       unsigned long *pe_bitmap, bool all);
-- 
2.1.0
