Return-Path: <grimm@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09A071A0D28
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 13:56:50 +1100 (AEDT)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <grimm@linux.vnet.ibm.com>;
 Wed, 14 Jan 2015 19:56:48 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id A8CC23E40030
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 19:48:33 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0F2v0pM37880050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 19:57:00 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0F2uklG032068
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 19:56:46 -0700
From: Ryan Grimm <grimm@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, mikey@neuling.org
Subject: [PATCH 2/3] CXL: Snoop control
Date: Wed, 14 Jan 2015 20:56:40 -0600
Message-Id: <1421290601-3293-2-git-send-email-grimm@linux.vnet.ibm.com>
In-Reply-To: <1421290601-3293-1-git-send-email-grimm@linux.vnet.ibm.com>
References: <1421290601-3293-1-git-send-email-grimm@linux.vnet.ibm.com>
Cc: Ryan Grimm <grimm@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add mode to opal call.  SNOOP control turns CAPP unit snooping on/off.  This is
needed for the following reset patch, which turns snoops off in the CAPP
recovery path.

Signed-off-by: Ryan Grimm <grimm@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h           | 12 ++++++++++++
 arch/powerpc/include/asm/pnv-pci.h        |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |  4 ++--
 drivers/misc/cxl/pci.c                    |  6 +++++-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 5d073e5..965e232 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -676,6 +676,18 @@ enum {
 	OPAL_PHB3_NUM_PEST_REGS = 256
 };
 
+/* CAPI modes for PHB */
+enum {
+        OPAL_PHB_CAPI_MODE_PCIE         = 0,
+        OPAL_PHB_CAPI_MODE_CAPI         = 1,
+        OPAL_PHB_CAPI_MODE_SNOOP_OFF    = 2,
+        OPAL_PHB_CAPI_MODE_SNOOP_ON     = 3,
+};
+
+/* CAPI feature flags (in device-tree) */
+#define OPAL_PHB_CAPI_FLAG_SNOOP_CONTROL        0x00000001
+#define OPAL_PHB_CAPI_FLAG_REVERT_TO_PCIE       0x00000002
+
 struct OpalIoPhbErrorCommon {
 	__be32 version;
 	__be32 ioType;
diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index f09a22f..e18082c 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -13,7 +13,7 @@
 #include <linux/pci.h>
 #include <misc/cxl.h>
 
-int pnv_phb_to_cxl(struct pci_dev *dev);
+int pnv_phb_to_cxl(struct pci_dev *dev, uint64_t mode);
 int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
 			   unsigned int virq);
 int pnv_cxl_alloc_hwirqs(struct pci_dev *dev, int num);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 468a0f2..acacc1b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1363,7 +1363,7 @@ struct device_node *pnv_pci_to_phb_node(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pnv_pci_to_phb_node);
 
-int pnv_phb_to_cxl(struct pci_dev *dev)
+int pnv_phb_to_cxl(struct pci_dev *dev, uint64_t mode)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -1376,7 +1376,7 @@ int pnv_phb_to_cxl(struct pci_dev *dev)
 
 	pe_info(pe, "Switching PHB to CXL\n");
 
-	rc = opal_pci_set_phb_cxl_mode(phb->opal_id, 1, pe->pe_number);
+	rc = opal_pci_set_phb_cxl_mode(phb->opal_id, mode, pe->pe_number);
 	if (rc)
 		dev_err(&dev->dev, "opal_pci_set_phb_cxl_mode failed: %i\n", rc);
 
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 26cacc1..9aa95f9 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -924,7 +924,7 @@ static struct cxl *cxl_init_adapter(struct pci_dev *dev)
 	if ((rc = init_implementation_adapter_regs(adapter, dev)))
 		goto err3;
 
-	if ((rc = pnv_phb_to_cxl(dev)))
+	if ((rc = pnv_phb_to_cxl(dev, OPAL_PHB_CAPI_MODE_CAPI)))
 		goto err3;
 
 	if ((rc = cxl_register_psl_err_irq(adapter)))
@@ -1009,6 +1009,10 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 			dev_err(&dev->dev, "AFU %i failed to initialise: %i\n", slice, rc);
 	}
 
+	if ((rc = pnv_phb_to_cxl(dev, OPAL_PHB_CAPI_MODE_SNOOP_ON))) {
+		dev_err(&dev->dev, "enable capp snoops: %i\n", rc);
+	}
+
 	return 0;
 }
 
-- 
1.9.1
