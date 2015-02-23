Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95C1C1A0A3E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 15:21:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org
Subject: [PATCH 1/3] cxl: Use image state defaults for reloading FPGA
Date: Mon, 23 Feb 2015 15:21:19 +1100
Message-Id: <1424665281-25431-1-git-send-email-mpe@ellerman.id.au>
Cc: grimm@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, imunsie@au.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ryan Grimm <grimm@linux.vnet.ibm.com>

Commit 4beb5421babee1204757b877622830c6aa31be6d upstream.

Select defaults such that a PERST causes flash image reload.  Select which
image based on what the card is set up to load.

CXL_VSEC_PERST_LOADS_IMAGE selects whether PERST assertion causes flash image
load.

CXL_VSEC_PERST_SELECT_USER selects which image is loaded on the next PERST.

cxl_update_image_control writes these bits into the VSEC.

Signed-off-by: Ryan Grimm <grimm@linux.vnet.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/misc/cxl/cxl.h |  1 +
 drivers/misc/cxl/pci.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 28078f8894a5..f3856c3eb63b 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -481,6 +481,7 @@ void cxl_release_one_irq(struct cxl *adapter, int hwirq);
 int cxl_alloc_irq_ranges(struct cxl_irq_ranges *irqs, struct cxl *adapter, unsigned int num);
 void cxl_release_irq_ranges(struct cxl_irq_ranges *irqs, struct cxl *adapter);
 int cxl_setup_irq(struct cxl *adapter, unsigned int hwirq, unsigned int virq);
+int cxl_update_image_control(struct cxl *adapter);
 
 /* common == phyp + powernv */
 struct cxl_process_element_common {
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 0f2cc9f8b4db..184550baa8b9 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -361,6 +361,41 @@ int cxl_setup_irq(struct cxl *adapter, unsigned int hwirq,
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
@@ -770,8 +805,8 @@ static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
 	CXL_READ_VSEC_BASE_IMAGE(dev, vsec, &adapter->base_image);
 	CXL_READ_VSEC_IMAGE_STATE(dev, vsec, &image_state);
 	adapter->user_image_loaded = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
-	adapter->perst_loads_image = !!(image_state & CXL_VSEC_PERST_LOADS_IMAGE);
-	adapter->perst_select_user = !!(image_state & CXL_VSEC_PERST_SELECT_USER);
+	adapter->perst_loads_image = true;
+	adapter->perst_select_user = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
 
 	CXL_READ_VSEC_NAFUS(dev, vsec, &adapter->slices);
 	CXL_READ_VSEC_AFU_DESC_OFF(dev, vsec, &afu_desc_off);
@@ -879,6 +914,9 @@ static struct cxl *cxl_init_adapter(struct pci_dev *dev)
 	if ((rc = cxl_vsec_looks_ok(adapter, dev)))
 		goto err2;
 
+	if ((rc = cxl_update_image_control(adapter)))
+		goto err2;
+
 	if ((rc = cxl_map_adapter_regs(adapter, dev)))
 		goto err2;
 
-- 
2.1.0
