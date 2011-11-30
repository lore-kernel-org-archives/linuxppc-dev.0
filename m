Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E69EF1008D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 15:22:58 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAU4MsrO016533
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 22:22:54 -0600
Message-ID: <1322626973.21641.26.camel@pasglop>
Subject: [PATCH 2/3] powerpc/powernv: Display diag data on p7ioc EEH errors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 30 Nov 2011 15:22:53 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/pci-ioda.c   |   25 ++++---
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |    1 +
 arch/powerpc/platforms/powernv/pci.c        |  117 ++++++++++++++++++++++++--
 arch/powerpc/platforms/powernv/pci.h        |   16 ++++
 4 files changed, 140 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 425c2b2..f31162c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -9,7 +9,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#define DEBUG
+#undef DEBUG
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -467,14 +467,13 @@ static void __devinit pnv_ioda_update_resources(struct pci_bus *bus)
 	struct pci_bus *cbus;
 	struct pci_dev *cdev;
 	unsigned int i;
-	u16 cmd;
 
-	/* Clear all device enables  */
-	list_for_each_entry(cdev, &bus->devices, bus_list) {
-		pci_read_config_word(cdev, PCI_COMMAND, &cmd);
-		cmd &= ~(PCI_COMMAND_IO|PCI_COMMAND_MEMORY|PCI_COMMAND_MASTER);
-		pci_write_config_word(cdev, PCI_COMMAND, cmd);
-	}
+	/* We used to clear all device enables here. However it looks like
+	 * clearing MEM enable causes Obsidian (IPR SCS) to go bonkers,
+	 * and shoot fatal errors to the PHB which in turns fences itself
+	 * and we can't recover from that ... yet. So for now, let's leave
+	 * the enables as-is and hope for the best.
+	 */
 
 	/* Check if bus resources fit in our IO or M32 range */
 	for (i = 0; bus->self && (i < 2); i++) {
@@ -618,7 +617,7 @@ static int __devinit pnv_ioda_configure_pe(struct pnv_phb *phb,
 		struct pci_dn *pdn = pnv_ioda_get_pdn(parent);
 		if (pdn && pdn->pe_number != IODA_INVALID_PE) {
 			rc = opal_pci_set_peltv(phb->opal_id, pdn->pe_number,
-						pe->pe_number, 1);
+						pe->pe_number, OPAL_ADD_PE_TO_DOMAIN);
 			/* XXX What to do in case of error ? */
 		}
 		parent = parent->bus->self;
@@ -638,7 +637,7 @@ static int __devinit pnv_ioda_configure_pe(struct pnv_phb *phb,
 			pe->mve_number = -1;
 		} else {
 			rc = opal_pci_set_mve_enable(phb->opal_id,
-						     pe->mve_number, 1);
+						     pe->mve_number, OPAL_ENABLE_MVE);
 			if (rc) {
 				pe_err(pe, "OPAL error %ld enabling MVE %d\n",
 				       rc, pe->mve_number);
@@ -1187,6 +1186,12 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
 	phb->opal_id = phb_id;
 	phb->type = PNV_PHB_IODA1;
 
+	/* Detect specific models for error handling */
+	if (of_device_is_compatible(np, "ibm,p7ioc-pciex"))
+		phb->model = PNV_PHB_MODEL_P7IOC;
+	else
+		phb->model = PNV_PHB_MODEL_UNKNOWN;
+
 	/* We parse "ranges" now since we need to deduce the register base
 	 * from the IO base
 	 */
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 4c80f7c..2649677 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -137,6 +137,7 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np,
 	phb->hose->private_data = phb;
 	phb->opal_id = phb_id;
 	phb->type = PNV_PHB_P5IOC2;
+	phb->model = PNV_PHB_MODEL_P5IOC2;
 
 	phb->regs = of_iomap(np, 0);
 
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index c0ed379..68e7e2c 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -144,6 +144,112 @@ static void pnv_teardown_msi_irqs(struct pci_dev *pdev)
 }
 #endif /* CONFIG_PCI_MSI */
 
+static void pnv_pci_dump_p7ioc_diag_data(struct pnv_phb *phb)
+{
+	struct OpalIoP7IOCPhbErrorData *data = &phb->diag.p7ioc;
+	int i;
+
+	pr_info("PHB %d diagnostic data:\n", phb->hose->global_number);
+
+	pr_info("  brdgCtl              = 0x%08x\n", data->brdgCtl);
+
+	pr_info("  portStatusReg        = 0x%08x\n", data->portStatusReg);
+	pr_info("  rootCmplxStatus      = 0x%08x\n", data->rootCmplxStatus);
+	pr_info("  busAgentStatus       = 0x%08x\n", data->busAgentStatus);
+
+	pr_info("  deviceStatus         = 0x%08x\n", data->deviceStatus);
+	pr_info("  slotStatus           = 0x%08x\n", data->slotStatus);
+	pr_info("  linkStatus           = 0x%08x\n", data->linkStatus);
+	pr_info("  devCmdStatus         = 0x%08x\n", data->devCmdStatus);
+	pr_info("  devSecStatus         = 0x%08x\n", data->devSecStatus);
+
+	pr_info("  rootErrorStatus      = 0x%08x\n", data->rootErrorStatus);
+	pr_info("  uncorrErrorStatus    = 0x%08x\n", data->uncorrErrorStatus);
+	pr_info("  corrErrorStatus      = 0x%08x\n", data->corrErrorStatus);
+	pr_info("  tlpHdr1              = 0x%08x\n", data->tlpHdr1);
+	pr_info("  tlpHdr2              = 0x%08x\n", data->tlpHdr2);
+	pr_info("  tlpHdr3              = 0x%08x\n", data->tlpHdr3);
+	pr_info("  tlpHdr4              = 0x%08x\n", data->tlpHdr4);
+	pr_info("  sourceId             = 0x%08x\n", data->sourceId);
+
+	pr_info("  errorClass           = 0x%016llx\n", data->errorClass);
+	pr_info("  correlator           = 0x%016llx\n", data->correlator);
+
+	pr_info("  p7iocPlssr           = 0x%016llx\n", data->p7iocPlssr);
+	pr_info("  p7iocCsr             = 0x%016llx\n", data->p7iocCsr);
+	pr_info("  lemFir               = 0x%016llx\n", data->lemFir);
+	pr_info("  lemErrorMask         = 0x%016llx\n", data->lemErrorMask);
+	pr_info("  lemWOF               = 0x%016llx\n", data->lemWOF);
+	pr_info("  phbErrorStatus       = 0x%016llx\n", data->phbErrorStatus);
+	pr_info("  phbFirstErrorStatus  = 0x%016llx\n", data->phbFirstErrorStatus);
+	pr_info("  phbErrorLog0         = 0x%016llx\n", data->phbErrorLog0);
+	pr_info("  phbErrorLog1         = 0x%016llx\n", data->phbErrorLog1);
+	pr_info("  mmioErrorStatus      = 0x%016llx\n", data->mmioErrorStatus);
+	pr_info("  mmioFirstErrorStatus = 0x%016llx\n", data->mmioFirstErrorStatus);
+	pr_info("  mmioErrorLog0        = 0x%016llx\n", data->mmioErrorLog0);
+	pr_info("  mmioErrorLog1        = 0x%016llx\n", data->mmioErrorLog1);
+	pr_info("  dma0ErrorStatus      = 0x%016llx\n", data->dma0ErrorStatus);
+	pr_info("  dma0FirstErrorStatus = 0x%016llx\n", data->dma0FirstErrorStatus);
+	pr_info("  dma0ErrorLog0        = 0x%016llx\n", data->dma0ErrorLog0);
+	pr_info("  dma0ErrorLog1        = 0x%016llx\n", data->dma0ErrorLog1);
+	pr_info("  dma1ErrorStatus      = 0x%016llx\n", data->dma1ErrorStatus);
+	pr_info("  dma1FirstErrorStatus = 0x%016llx\n", data->dma1FirstErrorStatus);
+	pr_info("  dma1ErrorLog0        = 0x%016llx\n", data->dma1ErrorLog0);
+	pr_info("  dma1ErrorLog1        = 0x%016llx\n", data->dma1ErrorLog1);
+
+	for (i = 0; i < OPAL_P7IOC_NUM_PEST_REGS; i++) {
+		if ((data->pestA[i] >> 63) == 0 && 
+		    (data->pestB[i] >> 63) == 0)
+			continue;
+		pr_info("  PE[%3d] PESTA        = 0x%016llx\n", i, data->pestA[i]);
+		pr_info("          PESTB        = 0x%016llx\n", data->pestB[i]);
+	}
+}
+
+static void pnv_pci_dump_phb_diag_data(struct pnv_phb *phb)
+{
+	switch(phb->model) {
+	case PNV_PHB_MODEL_P7IOC:
+		pnv_pci_dump_p7ioc_diag_data(phb);
+		break;
+	default:
+		pr_warning("PCI %d: Can't decode this PHB diag data\n",
+			   phb->hose->global_number);
+	}
+}
+
+static void pnv_pci_handle_eeh_config(struct pnv_phb *phb, u32 pe_no)
+{
+	unsigned long flags, rc;
+	int has_diag;
+
+	spin_lock_irqsave(&phb->lock, flags);
+
+	rc = opal_pci_get_phb_diag_data(phb->opal_id, phb->diag.blob, PNV_PCI_DIAG_BUF_SIZE);
+	has_diag = (rc == OPAL_SUCCESS);
+
+	rc = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no,
+				       OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+	if (rc) {
+		pr_warning("PCI %d: Failed to clear EEH freeze state"
+			   " for PE#%d, err %ld\n",
+			   phb->hose->global_number, pe_no, rc);
+
+		/* For now, let's only display the diag buffer when we fail to clear
+		 * the EEH status. We'll do more sensible things later when we have
+		 * proper EEH support. We need to make sure we don't pollute ourselves
+		 * with the normal errors generated when probing empty slots
+		 */
+		if (has_diag)
+			pnv_pci_dump_phb_diag_data(phb);
+		else
+			pr_warning("PCI %d: No diag data available\n",
+				   phb->hose->global_number);
+	}
+
+	spin_unlock_irqrestore(&phb->lock, flags);
+}
+
 static void pnv_pci_config_check_eeh(struct pnv_phb *phb, struct pci_bus *bus,
 				     u32 bdfn)
 {
@@ -165,15 +271,8 @@ static void pnv_pci_config_check_eeh(struct pnv_phb *phb, struct pci_bus *bus,
 	}
 	cfg_dbg(" -> EEH check, bdfn=%04x PE%d fstate=%x\n",
 		bdfn, pe_no, fstate);
-	if (fstate != 0) {
-		rc = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no,
-					      OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
-		if (rc) {
-			pr_warning("PCI %d: Failed to clear EEH freeze state"
-				   " for PE#%d, err %lld\n",
-				   phb->hose->global_number, pe_no, rc);
-		}
-	}
+	if (fstate != 0)
+		pnv_pci_handle_eeh_config(phb, pe_no);
 }
 
 static int pnv_pci_read_config(struct pci_bus *bus,
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 28ae4ca..8bc4796 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -9,6 +9,15 @@ enum pnv_phb_type {
 	PNV_PHB_IODA2,
 };
 
+/* Precise PHB model for error management */
+enum pnv_phb_model {
+	PNV_PHB_MODEL_UNKNOWN,
+	PNV_PHB_MODEL_P5IOC2,
+	PNV_PHB_MODEL_P7IOC,
+};
+
+#define PNV_PCI_DIAG_BUF_SIZE	4096
+
 /* Data associated with a PE, including IOMMU tracking etc.. */
 struct pnv_ioda_pe {
 	/* A PE can be associated with a single device or an
@@ -56,6 +65,7 @@ struct pnv_ioda_pe {
 struct pnv_phb {
 	struct pci_controller	*hose;
 	enum pnv_phb_type	type;
+	enum pnv_phb_model	model;
 	u64			opal_id;
 	void __iomem		*regs;
 	spinlock_t		lock;
@@ -118,6 +128,12 @@ struct pnv_phb {
 			struct list_head	pe_list;
 		} ioda;
 	};
+
+	/* PHB status structure */
+	union {
+		unsigned char			blob[PNV_PCI_DIAG_BUF_SIZE];
+		struct OpalIoP7IOCPhbErrorData	p7ioc;
+	} diag;
 };
 
 extern struct pci_ops pnv_pci_ops;
-- 
1.7.7.2
