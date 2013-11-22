Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 13A912C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 19:28:57 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 22 Nov 2013 01:28:54 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 29D3A1FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 01:28:33 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAM6QqTJ9109786
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 07:26:52 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAM8Sp0q016889
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 01:28:51 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/powernv: Move PHB-diag dump functions around
Date: Fri, 22 Nov 2013 16:28:45 +0800
Message-Id: <1385108926-10817-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Prior to the completion of PCI enumeration, we actively detects
EEH errors on PCI config cycles and dump PHB diag-data if necessary.
The EEH backend also dumps PHB diag-data in case of frozen PE or
fenced PHB. However, we are using different functions to dump the
PHB diag-data for those 2 cases.

The patch merges the functions for dumping PHB diag-data to one so
that we can avoid duplicate code. Also, we never dump PHB3 diag-data
during PCI config cycles with frozen PE. The patch fixes it as well.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |  150 +---------------------
 arch/powerpc/platforms/powernv/pci.c      |  196 ++++++++++++++++++++---------
 arch/powerpc/platforms/powernv/pci.h      |    3 +
 3 files changed, 144 insertions(+), 205 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 02245ce..be33a16 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -681,164 +681,20 @@ static void ioda_eeh_hub_diag(struct pci_controller *hose)
 	}
 }
 
-static void ioda_eeh_p7ioc_phb_diag(struct pci_controller *hose,
-				    struct OpalIoPhbErrorCommon *common)
-{
-	struct OpalIoP7IOCPhbErrorData *data;
-	int i;
-
-	data = (struct OpalIoP7IOCPhbErrorData *)common;
-
-	pr_info("P7IOC PHB#%x Diag-data (Version: %d)\n\n",
-		hose->global_number, common->version);
-
-	pr_info("  brdgCtl:              %08x\n", data->brdgCtl);
-
-	pr_info("  portStatusReg:        %08x\n", data->portStatusReg);
-	pr_info("  rootCmplxStatus:      %08x\n", data->rootCmplxStatus);
-	pr_info("  busAgentStatus:       %08x\n", data->busAgentStatus);
-
-	pr_info("  deviceStatus:         %08x\n", data->deviceStatus);
-	pr_info("  slotStatus:           %08x\n", data->slotStatus);
-	pr_info("  linkStatus:           %08x\n", data->linkStatus);
-	pr_info("  devCmdStatus:         %08x\n", data->devCmdStatus);
-	pr_info("  devSecStatus:         %08x\n", data->devSecStatus);
-
-	pr_info("  rootErrorStatus:      %08x\n", data->rootErrorStatus);
-	pr_info("  uncorrErrorStatus:    %08x\n", data->uncorrErrorStatus);
-	pr_info("  corrErrorStatus:      %08x\n", data->corrErrorStatus);
-	pr_info("  tlpHdr1:              %08x\n", data->tlpHdr1);
-	pr_info("  tlpHdr2:              %08x\n", data->tlpHdr2);
-	pr_info("  tlpHdr3:              %08x\n", data->tlpHdr3);
-	pr_info("  tlpHdr4:              %08x\n", data->tlpHdr4);
-	pr_info("  sourceId:             %08x\n", data->sourceId);
-
-	pr_info("  errorClass:           %016llx\n", data->errorClass);
-	pr_info("  correlator:           %016llx\n", data->correlator);
-	pr_info("  p7iocPlssr:           %016llx\n", data->p7iocPlssr);
-	pr_info("  p7iocCsr:             %016llx\n", data->p7iocCsr);
-	pr_info("  lemFir:               %016llx\n", data->lemFir);
-	pr_info("  lemErrorMask:         %016llx\n", data->lemErrorMask);
-	pr_info("  lemWOF:               %016llx\n", data->lemWOF);
-	pr_info("  phbErrorStatus:       %016llx\n", data->phbErrorStatus);
-	pr_info("  phbFirstErrorStatus:  %016llx\n", data->phbFirstErrorStatus);
-	pr_info("  phbErrorLog0:         %016llx\n", data->phbErrorLog0);
-	pr_info("  phbErrorLog1:         %016llx\n", data->phbErrorLog1);
-	pr_info("  mmioErrorStatus:      %016llx\n", data->mmioErrorStatus);
-	pr_info("  mmioFirstErrorStatus: %016llx\n", data->mmioFirstErrorStatus);
-	pr_info("  mmioErrorLog0:        %016llx\n", data->mmioErrorLog0);
-	pr_info("  mmioErrorLog1:        %016llx\n", data->mmioErrorLog1);
-	pr_info("  dma0ErrorStatus:      %016llx\n", data->dma0ErrorStatus);
-	pr_info("  dma0FirstErrorStatus: %016llx\n", data->dma0FirstErrorStatus);
-	pr_info("  dma0ErrorLog0:        %016llx\n", data->dma0ErrorLog0);
-	pr_info("  dma0ErrorLog1:        %016llx\n", data->dma0ErrorLog1);
-	pr_info("  dma1ErrorStatus:      %016llx\n", data->dma1ErrorStatus);
-	pr_info("  dma1FirstErrorStatus: %016llx\n", data->dma1FirstErrorStatus);
-	pr_info("  dma1ErrorLog0:        %016llx\n", data->dma1ErrorLog0);
-	pr_info("  dma1ErrorLog1:        %016llx\n", data->dma1ErrorLog1);
-
-	for (i = 0; i < OPAL_P7IOC_NUM_PEST_REGS; i++) {
-		if ((data->pestA[i] >> 63) == 0 &&
-		    (data->pestB[i] >> 63) == 0)
-			continue;
-
-		pr_info("  PE[%3d] PESTA:        %016llx\n", i, data->pestA[i]);
-		pr_info("          PESTB:        %016llx\n", data->pestB[i]);
-	}
-}
-
-static void ioda_eeh_phb3_phb_diag(struct pci_controller *hose,
-				    struct OpalIoPhbErrorCommon *common)
-{
-	struct OpalIoPhb3ErrorData *data;
-	int i;
-
-	data = (struct OpalIoPhb3ErrorData*)common;
-	pr_info("PHB3 PHB#%x Diag-data (Version: %d)\n\n",
-		hose->global_number, common->version);
-
-	pr_info("  brdgCtl:              %08x\n", data->brdgCtl);
-
-	pr_info("  portStatusReg:        %08x\n", data->portStatusReg);
-	pr_info("  rootCmplxStatus:      %08x\n", data->rootCmplxStatus);
-	pr_info("  busAgentStatus:       %08x\n", data->busAgentStatus);
-
-	pr_info("  deviceStatus:         %08x\n", data->deviceStatus);
-	pr_info("  slotStatus:           %08x\n", data->slotStatus);
-	pr_info("  linkStatus:           %08x\n", data->linkStatus);
-	pr_info("  devCmdStatus:         %08x\n", data->devCmdStatus);
-	pr_info("  devSecStatus:         %08x\n", data->devSecStatus);
-
-	pr_info("  rootErrorStatus:      %08x\n", data->rootErrorStatus);
-	pr_info("  uncorrErrorStatus:    %08x\n", data->uncorrErrorStatus);
-	pr_info("  corrErrorStatus:      %08x\n", data->corrErrorStatus);
-	pr_info("  tlpHdr1:              %08x\n", data->tlpHdr1);
-	pr_info("  tlpHdr2:              %08x\n", data->tlpHdr2);
-	pr_info("  tlpHdr3:              %08x\n", data->tlpHdr3);
-	pr_info("  tlpHdr4:              %08x\n", data->tlpHdr4);
-	pr_info("  sourceId:             %08x\n", data->sourceId);
-	pr_info("  errorClass:           %016llx\n", data->errorClass);
-	pr_info("  correlator:           %016llx\n", data->correlator);
-	pr_info("  nFir:                 %016llx\n", data->nFir);
-	pr_info("  nFirMask:             %016llx\n", data->nFirMask);
-	pr_info("  nFirWOF:              %016llx\n", data->nFirWOF);
-	pr_info("  PhbPlssr:             %016llx\n", data->phbPlssr);
-	pr_info("  PhbCsr:               %016llx\n", data->phbCsr);
-	pr_info("  lemFir:               %016llx\n", data->lemFir);
-	pr_info("  lemErrorMask:         %016llx\n", data->lemErrorMask);
-	pr_info("  lemWOF:               %016llx\n", data->lemWOF);
-	pr_info("  phbErrorStatus:       %016llx\n", data->phbErrorStatus);
-	pr_info("  phbFirstErrorStatus:  %016llx\n", data->phbFirstErrorStatus);
-	pr_info("  phbErrorLog0:         %016llx\n", data->phbErrorLog0);
-	pr_info("  phbErrorLog1:         %016llx\n", data->phbErrorLog1);
-	pr_info("  mmioErrorStatus:      %016llx\n", data->mmioErrorStatus);
-	pr_info("  mmioFirstErrorStatus: %016llx\n", data->mmioFirstErrorStatus);
-	pr_info("  mmioErrorLog0:        %016llx\n", data->mmioErrorLog0);
-	pr_info("  mmioErrorLog1:        %016llx\n", data->mmioErrorLog1);
-	pr_info("  dma0ErrorStatus:      %016llx\n", data->dma0ErrorStatus);
-	pr_info("  dma0FirstErrorStatus: %016llx\n", data->dma0FirstErrorStatus);
-	pr_info("  dma0ErrorLog0:        %016llx\n", data->dma0ErrorLog0);
-	pr_info("  dma0ErrorLog1:        %016llx\n", data->dma0ErrorLog1);
-	pr_info("  dma1ErrorStatus:      %016llx\n", data->dma1ErrorStatus);
-	pr_info("  dma1FirstErrorStatus: %016llx\n", data->dma1FirstErrorStatus);
-	pr_info("  dma1ErrorLog0:        %016llx\n", data->dma1ErrorLog0);
-	pr_info("  dma1ErrorLog1:        %016llx\n", data->dma1ErrorLog1);
-
-	for (i = 0; i < OPAL_PHB3_NUM_PEST_REGS; i++) {
-		if ((data->pestA[i] >> 63) == 0 &&
-		    (data->pestB[i] >> 63) == 0)
-			continue;
-
-		pr_info("  PE[%3d] PESTA:        %016llx\n", i, data->pestA[i]);
-		pr_info("          PESTB:        %016llx\n", data->pestB[i]);
-	}
-}
-
 static void ioda_eeh_phb_diag(struct pci_controller *hose)
 {
 	struct pnv_phb *phb = hose->private_data;
-	struct OpalIoPhbErrorCommon *common;
 	long rc;
 
-	common = (struct OpalIoPhbErrorCommon *)phb->diag.blob;
-	rc = opal_pci_get_phb_diag_data2(phb->opal_id, common, PAGE_SIZE);
+	rc = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
+					 PNV_PCI_DIAG_BUF_SIZE);
 	if (rc != OPAL_SUCCESS) {
 		pr_warning("%s: Failed to get diag-data for PHB#%x (%ld)\n",
 			    __func__, hose->global_number, rc);
 		return;
 	}
 
-	switch (common->ioType) {
-	case OPAL_PHB_ERROR_DATA_TYPE_P7IOC:
-		ioda_eeh_p7ioc_phb_diag(hose, common);
-		break;
-	case OPAL_PHB_ERROR_DATA_TYPE_PHB3:
-		ioda_eeh_phb3_phb_diag(hose, common);
-		break;
-	default:
-		pr_warning("%s: Unrecognized I/O chip %d\n",
-			   __func__, common->ioType);
-	}
+	pnv_pci_dump_phb_diag_data(hose, phb->diag.blob);
 }
 
 static int ioda_eeh_get_phb_pe(struct pci_controller *hose,
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 4eb33a9..f519cef 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -124,77 +124,157 @@ static void pnv_teardown_msi_irqs(struct pci_dev *pdev)
 }
 #endif /* CONFIG_PCI_MSI */
 
-static void pnv_pci_dump_p7ioc_diag_data(struct pnv_phb *phb)
+static void pnv_pci_dump_p7ioc_diag_data(struct pci_controller *hose,
+					 struct OpalIoPhbErrorCommon *common)
 {
-	struct OpalIoP7IOCPhbErrorData *data = &phb->diag.p7ioc;
+	struct OpalIoP7IOCPhbErrorData *data;
 	int i;
 
-	pr_info("PHB %d diagnostic data:\n", phb->hose->global_number);
-
-	pr_info("  brdgCtl              = 0x%08x\n", data->brdgCtl);
-
-	pr_info("  portStatusReg        = 0x%08x\n", data->portStatusReg);
-	pr_info("  rootCmplxStatus      = 0x%08x\n", data->rootCmplxStatus);
-	pr_info("  busAgentStatus       = 0x%08x\n", data->busAgentStatus);
-
-	pr_info("  deviceStatus         = 0x%08x\n", data->deviceStatus);
-	pr_info("  slotStatus           = 0x%08x\n", data->slotStatus);
-	pr_info("  linkStatus           = 0x%08x\n", data->linkStatus);
-	pr_info("  devCmdStatus         = 0x%08x\n", data->devCmdStatus);
-	pr_info("  devSecStatus         = 0x%08x\n", data->devSecStatus);
-
-	pr_info("  rootErrorStatus      = 0x%08x\n", data->rootErrorStatus);
-	pr_info("  uncorrErrorStatus    = 0x%08x\n", data->uncorrErrorStatus);
-	pr_info("  corrErrorStatus      = 0x%08x\n", data->corrErrorStatus);
-	pr_info("  tlpHdr1              = 0x%08x\n", data->tlpHdr1);
-	pr_info("  tlpHdr2              = 0x%08x\n", data->tlpHdr2);
-	pr_info("  tlpHdr3              = 0x%08x\n", data->tlpHdr3);
-	pr_info("  tlpHdr4              = 0x%08x\n", data->tlpHdr4);
-	pr_info("  sourceId             = 0x%08x\n", data->sourceId);
-
-	pr_info("  errorClass           = 0x%016llx\n", data->errorClass);
-	pr_info("  correlator           = 0x%016llx\n", data->correlator);
-
-	pr_info("  p7iocPlssr           = 0x%016llx\n", data->p7iocPlssr);
-	pr_info("  p7iocCsr             = 0x%016llx\n", data->p7iocCsr);
-	pr_info("  lemFir               = 0x%016llx\n", data->lemFir);
-	pr_info("  lemErrorMask         = 0x%016llx\n", data->lemErrorMask);
-	pr_info("  lemWOF               = 0x%016llx\n", data->lemWOF);
-	pr_info("  phbErrorStatus       = 0x%016llx\n", data->phbErrorStatus);
-	pr_info("  phbFirstErrorStatus  = 0x%016llx\n", data->phbFirstErrorStatus);
-	pr_info("  phbErrorLog0         = 0x%016llx\n", data->phbErrorLog0);
-	pr_info("  phbErrorLog1         = 0x%016llx\n", data->phbErrorLog1);
-	pr_info("  mmioErrorStatus      = 0x%016llx\n", data->mmioErrorStatus);
-	pr_info("  mmioFirstErrorStatus = 0x%016llx\n", data->mmioFirstErrorStatus);
-	pr_info("  mmioErrorLog0        = 0x%016llx\n", data->mmioErrorLog0);
-	pr_info("  mmioErrorLog1        = 0x%016llx\n", data->mmioErrorLog1);
-	pr_info("  dma0ErrorStatus      = 0x%016llx\n", data->dma0ErrorStatus);
-	pr_info("  dma0FirstErrorStatus = 0x%016llx\n", data->dma0FirstErrorStatus);
-	pr_info("  dma0ErrorLog0        = 0x%016llx\n", data->dma0ErrorLog0);
-	pr_info("  dma0ErrorLog1        = 0x%016llx\n", data->dma0ErrorLog1);
-	pr_info("  dma1ErrorStatus      = 0x%016llx\n", data->dma1ErrorStatus);
-	pr_info("  dma1FirstErrorStatus = 0x%016llx\n", data->dma1FirstErrorStatus);
-	pr_info("  dma1ErrorLog0        = 0x%016llx\n", data->dma1ErrorLog0);
-	pr_info("  dma1ErrorLog1        = 0x%016llx\n", data->dma1ErrorLog1);
+	data = (struct OpalIoP7IOCPhbErrorData *)common;
+	pr_info("P7IOC PHB#%d Diag-data (Version: %d)\n\n",
+		hose->global_number, common->version);
+
+	pr_info("  brdgCtl:              %08x\n", data->brdgCtl);
+
+	pr_info("  portStatusReg:        %08x\n", data->portStatusReg);
+	pr_info("  rootCmplxStatus:      %08x\n", data->rootCmplxStatus);
+	pr_info("  busAgentStatus:       %08x\n", data->busAgentStatus);
+
+	pr_info("  deviceStatus:         %08x\n", data->deviceStatus);
+	pr_info("  slotStatus:           %08x\n", data->slotStatus);
+	pr_info("  linkStatus:           %08x\n", data->linkStatus);
+	pr_info("  devCmdStatus:         %08x\n", data->devCmdStatus);
+	pr_info("  devSecStatus:         %08x\n", data->devSecStatus);
+
+	pr_info("  rootErrorStatus:      %08x\n", data->rootErrorStatus);
+	pr_info("  uncorrErrorStatus:    %08x\n", data->uncorrErrorStatus);
+	pr_info("  corrErrorStatus:      %08x\n", data->corrErrorStatus);
+	pr_info("  tlpHdr1:              %08x\n", data->tlpHdr1);
+	pr_info("  tlpHdr2:              %08x\n", data->tlpHdr2);
+	pr_info("  tlpHdr3:              %08x\n", data->tlpHdr3);
+	pr_info("  tlpHdr4:              %08x\n", data->tlpHdr4);
+	pr_info("  sourceId:             %08x\n", data->sourceId);
+	pr_info("  errorClass:           %016llx\n", data->errorClass);
+	pr_info("  correlator:           %016llx\n", data->correlator);
+	pr_info("  p7iocPlssr:           %016llx\n", data->p7iocPlssr);
+	pr_info("  p7iocCsr:             %016llx\n", data->p7iocCsr);
+	pr_info("  lemFir:               %016llx\n", data->lemFir);
+	pr_info("  lemErrorMask:         %016llx\n", data->lemErrorMask);
+	pr_info("  lemWOF:               %016llx\n", data->lemWOF);
+	pr_info("  phbErrorStatus:       %016llx\n", data->phbErrorStatus);
+	pr_info("  phbFirstErrorStatus:  %016llx\n", data->phbFirstErrorStatus);
+	pr_info("  phbErrorLog0:         %016llx\n", data->phbErrorLog0);
+	pr_info("  phbErrorLog1:         %016llx\n", data->phbErrorLog1);
+	pr_info("  mmioErrorStatus:      %016llx\n", data->mmioErrorStatus);
+	pr_info("  mmioFirstErrorStatus: %016llx\n", data->mmioFirstErrorStatus);
+	pr_info("  mmioErrorLog0:        %016llx\n", data->mmioErrorLog0);
+	pr_info("  mmioErrorLog1:        %016llx\n", data->mmioErrorLog1);
+	pr_info("  dma0ErrorStatus:      %016llx\n", data->dma0ErrorStatus);
+	pr_info("  dma0FirstErrorStatus: %016llx\n", data->dma0FirstErrorStatus);
+	pr_info("  dma0ErrorLog0:        %016llx\n", data->dma0ErrorLog0);
+	pr_info("  dma0ErrorLog1:        %016llx\n", data->dma0ErrorLog1);
+	pr_info("  dma1ErrorStatus:      %016llx\n", data->dma1ErrorStatus);
+	pr_info("  dma1FirstErrorStatus: %016llx\n", data->dma1FirstErrorStatus);
+	pr_info("  dma1ErrorLog0:        %016llx\n", data->dma1ErrorLog0);
+	pr_info("  dma1ErrorLog1:        %016llx\n", data->dma1ErrorLog1);
 
 	for (i = 0; i < OPAL_P7IOC_NUM_PEST_REGS; i++) {
 		if ((data->pestA[i] >> 63) == 0 &&
 		    (data->pestB[i] >> 63) == 0)
 			continue;
-		pr_info("  PE[%3d] PESTA        = 0x%016llx\n", i, data->pestA[i]);
-		pr_info("          PESTB        = 0x%016llx\n", data->pestB[i]);
+
+		pr_info("  PE[%3d] PESTA:        %016llx\n", i, data->pestA[i]);
+		pr_info("          PESTB:        %016llx\n", data->pestB[i]);
 	}
 }
 
-static void pnv_pci_dump_phb_diag_data(struct pnv_phb *phb)
+static void pnv_pci_dump_phb3_diag_data(struct pci_controller *hose,
+					struct OpalIoPhbErrorCommon *common)
 {
-	switch(phb->model) {
-	case PNV_PHB_MODEL_P7IOC:
-		pnv_pci_dump_p7ioc_diag_data(phb);
+	struct OpalIoPhb3ErrorData *data;
+	int i;
+
+	data = (struct OpalIoPhb3ErrorData*)common;
+	pr_info("PHB3 PHB#%d Diag-data (Version: %d)\n\n",
+		hose->global_number, common->version);
+
+	pr_info("  brdgCtl:              %08x\n", data->brdgCtl);
+
+	pr_info("  portStatusReg:        %08x\n", data->portStatusReg);
+	pr_info("  rootCmplxStatus:      %08x\n", data->rootCmplxStatus);
+	pr_info("  busAgentStatus:       %08x\n", data->busAgentStatus);
+
+	pr_info("  deviceStatus:         %08x\n", data->deviceStatus);
+	pr_info("  slotStatus:           %08x\n", data->slotStatus);
+	pr_info("  linkStatus:           %08x\n", data->linkStatus);
+	pr_info("  devCmdStatus:         %08x\n", data->devCmdStatus);
+	pr_info("  devSecStatus:         %08x\n", data->devSecStatus);
+
+	pr_info("  rootErrorStatus:      %08x\n", data->rootErrorStatus);
+	pr_info("  uncorrErrorStatus:    %08x\n", data->uncorrErrorStatus);
+	pr_info("  corrErrorStatus:      %08x\n", data->corrErrorStatus);
+	pr_info("  tlpHdr1:              %08x\n", data->tlpHdr1);
+	pr_info("  tlpHdr2:              %08x\n", data->tlpHdr2);
+	pr_info("  tlpHdr3:              %08x\n", data->tlpHdr3);
+	pr_info("  tlpHdr4:              %08x\n", data->tlpHdr4);
+	pr_info("  sourceId:             %08x\n", data->sourceId);
+	pr_info("  errorClass:           %016llx\n", data->errorClass);
+	pr_info("  correlator:           %016llx\n", data->correlator);
+
+	pr_info("  nFir:                 %016llx\n", data->nFir);
+	pr_info("  nFirMask:             %016llx\n", data->nFirMask);
+	pr_info("  nFirWOF:              %016llx\n", data->nFirWOF);
+	pr_info("  PhbPlssr:             %016llx\n", data->phbPlssr);
+	pr_info("  PhbCsr:               %016llx\n", data->phbCsr);
+	pr_info("  lemFir:               %016llx\n", data->lemFir);
+	pr_info("  lemErrorMask:         %016llx\n", data->lemErrorMask);
+	pr_info("  lemWOF:               %016llx\n", data->lemWOF);
+	pr_info("  phbErrorStatus:       %016llx\n", data->phbErrorStatus);
+	pr_info("  phbFirstErrorStatus:  %016llx\n", data->phbFirstErrorStatus);
+	pr_info("  phbErrorLog0:         %016llx\n", data->phbErrorLog0);
+	pr_info("  phbErrorLog1:         %016llx\n", data->phbErrorLog1);
+	pr_info("  mmioErrorStatus:      %016llx\n", data->mmioErrorStatus);
+	pr_info("  mmioFirstErrorStatus: %016llx\n", data->mmioFirstErrorStatus);
+	pr_info("  mmioErrorLog0:        %016llx\n", data->mmioErrorLog0);
+	pr_info("  mmioErrorLog1:        %016llx\n", data->mmioErrorLog1);
+	pr_info("  dma0ErrorStatus:      %016llx\n", data->dma0ErrorStatus);
+	pr_info("  dma0FirstErrorStatus: %016llx\n", data->dma0FirstErrorStatus);
+	pr_info("  dma0ErrorLog0:        %016llx\n", data->dma0ErrorLog0);
+	pr_info("  dma0ErrorLog1:        %016llx\n", data->dma0ErrorLog1);
+	pr_info("  dma1ErrorStatus:      %016llx\n", data->dma1ErrorStatus);
+	pr_info("  dma1FirstErrorStatus: %016llx\n", data->dma1FirstErrorStatus);
+	pr_info("  dma1ErrorLog0:        %016llx\n", data->dma1ErrorLog0);
+	pr_info("  dma1ErrorLog1:        %016llx\n", data->dma1ErrorLog1);
+
+	for (i = 0; i < OPAL_PHB3_NUM_PEST_REGS; i++) {
+		if ((data->pestA[i] >> 63) == 0 &&
+		    (data->pestB[i] >> 63) == 0)
+			continue;
+
+		pr_info("  PE[%3d] PESTA:        %016llx\n", i, data->pestA[i]);
+		pr_info("          PESTB:        %016llx\n", data->pestB[i]);
+	}
+}
+
+void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
+				unsigned char *log_buff)
+{
+	struct OpalIoPhbErrorCommon *common;
+
+	if (!hose || !log_buff)
+		return;
+
+	common = (struct OpalIoPhbErrorCommon *)log_buff;
+	switch (common->ioType) {
+	case OPAL_PHB_ERROR_DATA_TYPE_P7IOC:
+		pnv_pci_dump_p7ioc_diag_data(hose, common);
+		break;
+	case OPAL_PHB_ERROR_DATA_TYPE_PHB3:
+		pnv_pci_dump_phb3_diag_data(hose, common);
 		break;
 	default:
-		pr_warning("PCI %d: Can't decode this PHB diag data\n",
-			   phb->hose->global_number);
+		pr_warn("%s: Unrecognized ioType %d\n",
+			__func__, common->ioType);
 	}
 }
 
@@ -222,7 +302,7 @@ static void pnv_pci_handle_eeh_config(struct pnv_phb *phb, u32 pe_no)
 		 * with the normal errors generated when probing empty slots
 		 */
 		if (has_diag)
-			pnv_pci_dump_phb_diag_data(phb);
+			pnv_pci_dump_phb_diag_data(phb->hose, phb->diag.blob);
 		else
 			pr_warning("PCI %d: No diag data available\n",
 				   phb->hose->global_number);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 911c24e..9a11ff0 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -176,6 +176,7 @@ struct pnv_phb {
 	union {
 		unsigned char			blob[PNV_PCI_DIAG_BUF_SIZE];
 		struct OpalIoP7IOCPhbErrorData	p7ioc;
+		struct OpalIoPhb3ErrorData	phb3;
 	} diag;
 };
 
@@ -184,6 +185,8 @@ extern struct pci_ops pnv_pci_ops;
 extern struct pnv_eeh_ops ioda_eeh_ops;
 #endif
 
+void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
+				unsigned char *log_buff);
 int pnv_pci_cfg_read(struct device_node *dn,
 		     int where, int size, u32 *val);
 int pnv_pci_cfg_write(struct device_node *dn,
-- 
1.7.9.5
