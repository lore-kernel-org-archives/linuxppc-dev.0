Return-Path: <grimm@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C77E1A0D64
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 04:53:09 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <grimm@linux.vnet.ibm.com>;
 Mon, 19 Jan 2015 10:53:07 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 198BE19D8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 10:44:16 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0JHrE6V27787474
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 10:53:14 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0JHr3TS018484
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 10:53:04 -0700
From: Ryan Grimm <grimm@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, mikey@neuling.org
Subject: [PATCH 1/4] CXL: Use image state defaults for reloading FPGA
Date: Mon, 19 Jan 2015 11:52:48 -0600
Message-Id: <1421689971-34476-1-git-send-email-grimm@linux.vnet.ibm.com>
Cc: Ryan Grimm <grimm@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Select defaults such that a PERST causes flash image reload.  Select which
image based on what the card is set up to load.

CXL_VSEC_PERST_LOADS_IMAGE selects whether PERST assertion causes flash image
load.

CXL_VSEC_PERST_SELECT_USER selects which image is loaded on the next PERST.

cxl_update_image_control writes these bits into the VSEC.

Signed-off-by: Ryan Grimm <grimm@linux.vnet.ibm.com>
---

Please consider this patch for stable.  Without these defaults, the card could
get in a bad state and require a power cycle to the box.

 drivers/misc/cxl/cxl.h |  1 +
 drivers/misc/cxl/pci.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 0df0438..518c4c6 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -488,6 +488,7 @@ void cxl_release_one_irq(struct cxl *adapter, int hwirq);
 int cxl_alloc_irq_ranges(struct cxl_irq_ranges *irqs, struct cxl *adapter, unsigned int num);
 void cxl_release_irq_ranges(struct cxl_irq_ranges *irqs, struct cxl *adapter);
 int cxl_setup_irq(struct cxl *adapter, unsigned int hwirq, unsigned int virq);
+int cxl_update_image_control(struct cxl *adapter);
 
 /* common == phyp + powernv */
 struct cxl_process_element_common {
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index f801c28..5e71ef9 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -362,6 +362,41 @@ int cxl_setup_irq(struct cxl *adapter, unsigned int hwirq,
 	return pnv_cxl_ioda_msi_setup(dev, hwirq, virq);
 }
 
+int cxl_update_image_control(struct cxl *adapter)
+{
+	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
+	int rc;
+	int vsec;
+	u8 image_state;
+
+	if (!(vsec = find_cxl_vsec(dev))) {
+		dev_err(&dev->dev, "ABORTING: CXL VSEC not found!\n");
+		return -ENODEV;
+	}
+
+	if ((rc = CXL_READ_VSEC_IMAGE_STATE(dev, vsec, &image_state))) {
+		dev_err(&dev->dev, "failed to read image state: %i\n", rc);
+		return rc;
+	}
+
+	if (adapter->perst_loads_image)
+		image_state |= CXL_VSEC_PERST_LOADS_IMAGE;
+	else
+		image_state &= ~CXL_VSEC_PERST_LOADS_IMAGE;
+
+	if (adapter->perst_select_user)
+		image_state |= CXL_VSEC_PERST_SELECT_USER;
+	else
+		image_state &= ~CXL_VSEC_PERST_SELECT_USER;
+
+	if ((rc = CXL_WRITE_VSEC_IMAGE_STATE(dev, vsec, image_state))) {
+		dev_err(&dev->dev, "failed to update image control: %i\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
 int cxl_alloc_one_irq(struct cxl *adapter)
 {
 	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
@@ -771,8 +806,8 @@ static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
 	CXL_READ_VSEC_BASE_IMAGE(dev, vsec, &adapter->base_image);
 	CXL_READ_VSEC_IMAGE_STATE(dev, vsec, &image_state);
 	adapter->user_image_loaded = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
-	adapter->perst_loads_image = !!(image_state & CXL_VSEC_PERST_LOADS_IMAGE);
-	adapter->perst_select_user = !!(image_state & CXL_VSEC_PERST_SELECT_USER);
+	adapter->perst_loads_image = true;
+	adapter->perst_select_user = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
 
 	CXL_READ_VSEC_NAFUS(dev, vsec, &adapter->slices);
 	CXL_READ_VSEC_AFU_DESC_OFF(dev, vsec, &afu_desc_off);
@@ -880,6 +915,9 @@ static struct cxl *cxl_init_adapter(struct pci_dev *dev)
 	if ((rc = cxl_vsec_looks_ok(adapter, dev)))
 		goto err2;
 
+	if ((rc = cxl_update_image_control(adapter)))
+		goto err2;
+
 	if ((rc = cxl_map_adapter_regs(adapter, dev)))
 		goto err2;
 
-- 
1.9.1
