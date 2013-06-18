Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 41BC72C0392
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 18:34:30 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 18 Jun 2013 04:34:27 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C665EC90041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:24 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5I8YPq4286766
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:25 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5I8YOsP017861
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:25 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 22/31] powerpc/eeh: I/O chip next error
Date: Tue, 18 Jun 2013 16:33:46 +0800
Message-Id: <1371544435-4943-23-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch implements the backend for EEH core to retrieve next
EEH error to handle. For the informational errors, we won't bother
the EEH core. Otherwise, the EEH should take appropriate actions
depending on the return value:

	0 - No further errors detected
	1 - Frozen PE
	2 - Fenced PHB
	3 - Dead PHB
	4 - Dead IOC

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |  334 ++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.h      |    1 +
 2 files changed, 333 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 8d9c2d2..a3eebd1 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -34,6 +34,15 @@
 #include "powernv.h"
 #include "pci.h"
 
+/* Debugging option */
+#ifdef IODA_EEH_DBG_ON
+#define IODA_EEH_DBG(args...)	pr_info(args)
+#else
+#define IODA_EEH_DBG(args...)
+#endif
+
+static char *hub_diag = NULL;
+
 /**
  * ioda_eeh_post_init - Chip dependent post initialization
  * @hose: PCI controller
@@ -47,8 +56,19 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 	struct pnv_phb *phb = hose->private_data;
 
 	/* FIXME: Enable it for PHB3 later */
-	if (phb->type == PNV_PHB_IODA1)
+	if (phb->type == PNV_PHB_IODA1) {
+		if (!hub_diag) {
+			hub_diag = (char *)__get_free_page(GFP_KERNEL |
+							   __GFP_ZERO);
+			if (!hub_diag) {
+				pr_err("%s: Out of memory !\n",
+				       __func__);
+				return -ENOMEM;
+			}
+		}
+
 		phb->eeh_enabled = 1;
+	}
 
 	return 0;
 }
@@ -498,6 +518,316 @@ static int ioda_eeh_configure_bridge(struct eeh_pe *pe)
 	return 0;
 }
 
+static void ioda_eeh_hub_diag_common(struct OpalIoP7IOCErrorData *data)
+{
+	/* GEM */
+	pr_info("  GEM XFIR:        %016llx\n", data->gemXfir);
+	pr_info("  GEM RFIR:        %016llx\n", data->gemRfir);
+	pr_info("  GEM RIRQFIR:     %016llx\n", data->gemRirqfir);
+	pr_info("  GEM Mask:        %016llx\n", data->gemMask);
+	pr_info("  GEM RWOF:        %016llx\n", data->gemRwof);
+
+	/* LEM */
+	pr_info("  LEM FIR:         %016llx\n", data->lemFir);
+	pr_info("  LEM Error Mask:  %016llx\n", data->lemErrMask);
+	pr_info("  LEM Action 0:    %016llx\n", data->lemAction0);
+	pr_info("  LEM Action 1:    %016llx\n", data->lemAction1);
+	pr_info("  LEM WOF:         %016llx\n", data->lemWof);
+}
+
+static void ioda_eeh_hub_diag(struct pci_controller *hose)
+{
+	struct pnv_phb *phb = hose->private_data;
+	struct OpalIoP7IOCErrorData *data;
+	long rc;
+
+	data = (struct OpalIoP7IOCErrorData *)ioda_eeh_hub_diag;
+	rc = opal_pci_get_hub_diag_data(phb->hub_id, data, PAGE_SIZE);
+	if (rc != OPAL_SUCCESS) {
+		pr_warning("%s: Failed to get HUB#%llx diag-data (%ld)\n",
+			   __func__, phb->hub_id, rc);
+		return;
+	}
+
+	switch (data->type) {
+	case OPAL_P7IOC_DIAG_TYPE_RGC:
+		pr_info("P7IOC diag-data for RGC\n\n");
+		ioda_eeh_hub_diag_common(data);
+		pr_info("  RGC Status:      %016llx\n", data->rgc.rgcStatus);
+		pr_info("  RGC LDCP:        %016llx\n", data->rgc.rgcLdcp);
+		break;
+	case OPAL_P7IOC_DIAG_TYPE_BI:
+		pr_info("P7IOC diag-data for BI %s\n\n",
+			data->bi.biDownbound ? "Downbound" : "Upbound");
+		ioda_eeh_hub_diag_common(data);
+		pr_info("  BI LDCP 0:       %016llx\n", data->bi.biLdcp0);
+		pr_info("  BI LDCP 1:       %016llx\n", data->bi.biLdcp1);
+		pr_info("  BI LDCP 2:       %016llx\n", data->bi.biLdcp2);
+		pr_info("  BI Fence Status: %016llx\n", data->bi.biFenceStatus);
+		break;
+	case OPAL_P7IOC_DIAG_TYPE_CI:
+		pr_info("P7IOC diag-data for CI Port %d\\nn",
+			data->ci.ciPort);
+		ioda_eeh_hub_diag_common(data);
+		pr_info("  CI Port Status:  %016llx\n", data->ci.ciPortStatus);
+		pr_info("  CI Port LDCP:    %016llx\n", data->ci.ciPortLdcp);
+		break;
+	case OPAL_P7IOC_DIAG_TYPE_MISC:
+		pr_info("P7IOC diag-data for MISC\n\n");
+		ioda_eeh_hub_diag_common(data);
+		break;
+	case OPAL_P7IOC_DIAG_TYPE_I2C:
+		pr_info("P7IOC diag-data for I2C\n\n");
+		ioda_eeh_hub_diag_common(data);
+		break;
+	default:
+		pr_warning("%s: Invalid type of HUB#%llx diag-data (%d)\n",
+			   __func__, phb->hub_id, data->type);
+	}
+}
+
+static void ioda_eeh_p7ioc_phb_diag(struct pci_controller *hose,
+				    struct OpalIoPhbErrorCommon *common)
+{
+	struct OpalIoP7IOCPhbErrorData *data;
+	int i;
+
+	data = (struct OpalIoP7IOCPhbErrorData *)common;
+
+	pr_info("P7IOC PHB#%x Diag-data (Version: %d)\n\n",
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
+
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
+
+	for (i = 0; i < OPAL_P7IOC_NUM_PEST_REGS; i++) {
+		if ((data->pestA[i] >> 63) == 0 &&
+		    (data->pestB[i] >> 63) == 0)
+			continue;
+
+		pr_info("  PE[%3d] PESTA:        %016llx\n", i, data->pestA[i]);
+		pr_info("          PESTB:        %016llx\n", data->pestB[i]);
+	}
+}
+
+static void ioda_eeh_phb_diag(struct pci_controller *hose)
+{
+	struct pnv_phb *phb = hose->private_data;
+	struct OpalIoPhbErrorCommon *common;
+	long rc;
+
+	common = (struct OpalIoPhbErrorCommon *)phb->diag.blob;
+	rc = opal_pci_get_phb_diag_data2(phb->opal_id, common, PAGE_SIZE);
+	if (rc != OPAL_SUCCESS) {
+		pr_warning("%s: Failed to get diag-data for PHB#%x (%ld)\n",
+			    __func__, hose->global_number, rc);
+		return;
+	}
+
+	switch (common->ioType) {
+	case OPAL_PHB_ERROR_DATA_TYPE_P7IOC:
+		ioda_eeh_p7ioc_phb_diag(hose, common);
+		break;
+	default:
+		pr_warning("%s: Unrecognized I/O chip %d\n",
+			   __func__, common->ioType);
+	}
+}
+
+static int ioda_eeh_get_phb_pe(struct pci_controller *hose,
+			       struct eeh_pe **pe)
+{
+	struct eeh_pe *phb_pe;
+
+	phb_pe = eeh_phb_pe_get(hose);
+	if (!phb_pe) {
+		pr_warning("%s Can't find PE for PHB#%d\n",
+			   __func__, hose->global_number);
+		return -EEXIST;
+	}
+
+	*pe = phb_pe;
+	return 0;
+}
+
+static int ioda_eeh_get_pe(struct pci_controller *hose,
+			   u16 pe_no, struct eeh_pe **pe)
+{
+	struct eeh_pe *phb_pe, *dev_pe;
+	struct eeh_dev dev;
+
+	/* Find the PHB PE */
+	if (ioda_eeh_get_phb_pe(hose, &phb_pe))
+		return -EEXIST;
+
+	/* Find the PE according to PE# */
+	memset(&dev, 0, sizeof(struct eeh_dev));
+	dev.phb = hose;
+	dev.pe_config_addr = pe_no;
+	dev_pe = eeh_pe_get(&dev);
+	if (!dev_pe) {
+		pr_warning("%s: Can't find PE for PHB#%x - PE#%x\n",
+			   __func__, hose->global_number, pe_no);
+		return -EEXIST;
+	}
+
+	*pe = dev_pe;
+	return 0;
+}
+
+/**
+ * ioda_eeh_next_error - Retrieve next error for EEH core to handle
+ * @pe: The affected PE
+ *
+ * The function is expected to be called by EEH core while it gets
+ * special EEH event (without binding PE). The function calls to
+ * OPAL APIs for next error to handle. The informational error is
+ * handled internally by platform. However, the dead IOC, dead PHB,
+ * fenced PHB and frozen PE should be handled by EEH core eventually.
+ */
+static int ioda_eeh_next_error(struct eeh_pe **pe)
+{
+	struct pci_controller *hose, *tmp;
+	struct pnv_phb *phb;
+	u64 frozen_pe_no;
+	u16 err_type, severity;
+	long rc;
+	int ret = 1;
+
+	/* While running here, it's safe to purge the event queue */
+	eeh_remove_event(NULL);
+
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+		/*
+		 * If the subordinate PCI buses of the PHB has been
+		 * removed, we needn't take care of it any more.
+		 */
+		phb = hose->private_data;
+		if (phb->removed)
+			continue;
+
+		rc = opal_pci_next_error(phb->opal_id,
+				&frozen_pe_no, &err_type, &severity);
+
+		/* If OPAL API returns error, we needn't proceed */
+		if (rc != OPAL_SUCCESS) {
+			IODA_EEH_DBG("%s: Invalid return value on "
+				     "PHB#%x (0x%lx) from opal_pci_next_error",
+				     __func__, hose->global_number, rc);
+			continue;
+		}
+
+		/* If the PHB doesn't have error, stop processing */
+		if (err_type == OPAL_EEH_NO_ERROR ||
+		    severity == OPAL_EEH_SEV_NO_ERROR) {
+			IODA_EEH_DBG("%s: No error found on PHB#%x\n",
+				     __func__, hose->global_number);
+			continue;
+		}
+
+		/*
+		 * Processing the error. We're expecting the error with
+		 * highest priority reported upon multiple errors on the
+		 * specific PHB.
+		 */
+		IODA_EEH_DBG("%s: Error (%d, %d, %d) on PHB#%x\n",
+			err_type, severity, pe_no, hose->global_number);
+		switch (err_type) {
+		case OPAL_EEH_IOC_ERROR:
+			if (severity == OPAL_EEH_SEV_IOC_DEAD) {
+				list_for_each_entry_safe(hose, tmp,
+						&hose_list, list_node) {
+					phb = hose->private_data;
+					phb->removed = 1;
+				}
+
+				WARN(1, "EEH: dead IOC detected\n");
+				ret = 4;
+				goto out;
+			} else if (severity == OPAL_EEH_SEV_INF)
+				ioda_eeh_hub_diag(hose);
+
+			break;
+		case OPAL_EEH_PHB_ERROR:
+			if (severity == OPAL_EEH_SEV_PHB_DEAD) {
+				if (ioda_eeh_get_phb_pe(hose, pe))
+					break;
+
+				WARN(1, "EEH: dead PHB#%x detected\n",
+				     hose->global_number);
+				phb->removed = 1;
+				ret = 3;
+				goto out;
+			} else if (severity == OPAL_EEH_SEV_PHB_FENCED) {
+				if (ioda_eeh_get_phb_pe(hose, pe))
+					break;
+
+				WARN(1, "EEH: fenced PHB#%x detected\n",
+				     hose->global_number);
+				ret = 2;
+				goto out;
+			} else if (severity == OPAL_EEH_SEV_INF)
+				ioda_eeh_phb_diag(hose);
+
+			break;
+		case OPAL_EEH_PE_ERROR:
+			if (ioda_eeh_get_pe(hose, frozen_pe_no, pe))
+				break;
+
+			WARN(1, "EEH: Frozen PE#%x on PHB#%x detected\n",
+			     (*pe)->addr, (*pe)->phb->global_number);
+			ret = 1;
+			goto out;
+		}
+	}
+
+	ret = 0;
+out:
+	return ret;
+}
+
 struct pnv_eeh_ops ioda_eeh_ops = {
 	.post_init		= ioda_eeh_post_init,
 	.set_option		= ioda_eeh_set_option,
@@ -505,5 +835,5 @@ struct pnv_eeh_ops ioda_eeh_ops = {
 	.reset			= ioda_eeh_reset,
 	.get_log		= ioda_eeh_get_log,
 	.configure_bridge	= ioda_eeh_configure_bridge,
-	.next_error		= NULL
+	.next_error		= ioda_eeh_next_error
 };
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 336c9dc..3656a240 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -93,6 +93,7 @@ struct pnv_phb {
 #ifdef CONFIG_EEH
 	struct pnv_eeh_ops	*eeh_ops;
 	int			eeh_enabled;
+	int			removed;
 #endif
 
 #ifdef CONFIG_PCI_MSI
-- 
1.7.5.4
