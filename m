Return-Path: <grimm@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B3A51A0E96
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jan 2015 06:48:26 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <grimm@linux.vnet.ibm.com>;
 Fri, 16 Jan 2015 14:48:24 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id ED9F638C8039
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 14:48:20 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0GJmKbj24576070
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 19:48:20 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0GJmK3n007037
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 14:48:20 -0500
From: Ryan Grimm <grimm@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, mikey@neuling.org
Subject: [PATCH 3/4] CXL: Enable CAPP recovery
Date: Fri, 16 Jan 2015 13:48:06 -0600
Message-Id: <1421437687-12835-3-git-send-email-grimm@linux.vnet.ibm.com>
In-Reply-To: <1421437687-12835-1-git-send-email-grimm@linux.vnet.ibm.com>
References: <1421437687-12835-1-git-send-email-grimm@linux.vnet.ibm.com>
Cc: Ryan Grimm <grimm@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Turning snoops on is the last step in CAPP recovery.  Sapphire is expected to
have reinitialized the PHB and done the previous recovery steps.

Add mode argument to opal call to do this.  Driver can turn snoops off although
it does not currently.

Signed-off-by: Ryan Grimm <grimm@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h           | 8 ++++++++
 arch/powerpc/include/asm/pnv-pci.h        | 2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c | 6 +++---
 drivers/misc/cxl/pci.c                    | 8 +++++++-
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index eb95b67..2baf8a5 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -595,6 +595,14 @@ enum {
 	OPAL_PHB3_NUM_PEST_REGS = 256
 };
 
+/* CAPI modes for PHB */
+enum {
+	OPAL_PHB_CAPI_MODE_PCIE         = 0,
+	OPAL_PHB_CAPI_MODE_CAPI         = 1,
+	OPAL_PHB_CAPI_MODE_SNOOP_OFF    = 2,
+	OPAL_PHB_CAPI_MODE_SNOOP_ON     = 3,
+};
+
 struct OpalIoPhbErrorCommon {
 	__be32 version;
 	__be32 ioType;
diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index f09a22f..3c00d64 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -13,7 +13,7 @@
 #include <linux/pci.h>
 #include <misc/cxl.h>
 
-int pnv_phb_to_cxl(struct pci_dev *dev);
+int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
 int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
 			   unsigned int virq);
 int pnv_cxl_alloc_hwirqs(struct pci_dev *dev, int num);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fac88ed..5d52d6f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1468,7 +1468,7 @@ struct device_node *pnv_pci_to_phb_node(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pnv_pci_to_phb_node);
 
-int pnv_phb_to_cxl(struct pci_dev *dev)
+int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -1481,13 +1481,13 @@ int pnv_phb_to_cxl(struct pci_dev *dev)
 
 	pe_info(pe, "Switching PHB to CXL\n");
 
-	rc = opal_pci_set_phb_cxl_mode(phb->opal_id, 1, pe->pe_number);
+	rc = opal_pci_set_phb_cxl_mode(phb->opal_id, mode, pe->pe_number);
 	if (rc)
 		dev_err(&dev->dev, "opal_pci_set_phb_cxl_mode failed: %i\n", rc);
 
 	return rc;
 }
-EXPORT_SYMBOL(pnv_phb_to_cxl);
+EXPORT_SYMBOL(pnv_phb_to_cxl_mode);
 
 /* Find PHB for cxl dev and allocate MSI hwirqs?
  * Returns the absolute hardware IRQ number
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 5e71ef9..b4aa4f1 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -927,9 +927,15 @@ static struct cxl *cxl_init_adapter(struct pci_dev *dev)
 	if ((rc = init_implementation_adapter_regs(adapter, dev)))
 		goto err3;
 
-	if ((rc = pnv_phb_to_cxl(dev)))
+	if ((rc = pnv_phb_to_cxl_mode(dev, OPAL_PHB_CAPI_MODE_CAPI)))
 		goto err3;
 
+	/* If recovery happened, the last step is to turn on snooping.
+	 * In the non-recovery case this has no effect */
+	if ((rc = pnv_phb_to_cxl_mode(dev, OPAL_PHB_CAPI_MODE_SNOOP_ON))) {
+		goto err3;
+	}
+
 	if ((rc = cxl_register_psl_err_irq(adapter)))
 		goto err3;
 
-- 
1.9.1
