Return-Path: <grimm@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9574C1A0D1B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 13:56:51 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <grimm@linux.vnet.ibm.com>;
 Wed, 14 Jan 2015 19:56:49 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id EF5B519D803E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 19:47:59 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0F2uxVT29098006
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 19:56:59 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0F2ul6Y032102
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 19:56:47 -0700
From: Ryan Grimm <grimm@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, mikey@neuling.org
Subject: [PATCH 3/3] CXL: Add reset to sysfs
Date: Wed, 14 Jan 2015 20:56:41 -0600
Message-Id: <1421290601-3293-3-git-send-email-grimm@linux.vnet.ibm.com>
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

This allows an image to be downloaded to the flash without rebooting the
machine.  The driver perform a PERST, which results in FPGA image downloaded to
flash and the CAPP unit enters recovery.  CAPP recovery triggers an HMI, which
is handled by EEH in Linux.  EEH removes the driver, calls into Sapphire to
reinitialize the PHB, and then loads the driver.

reset_image_select must be set to "user" and reset_load_image set to 1.  The
driver writes "user" to the vsec if a user image was loaded.  It writes 1 to
reset_load_image on initialization by default.  Other values could be used by
hand for debugging purposes.

Signed-off-by: Ryan Grimm <grimm@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/sysfs-class-cxl |  6 +++++
 drivers/misc/cxl/cxl.h                    |  1 +
 drivers/misc/cxl/pci.c                    | 38 +++++++++++++++++++++++++++++--
 drivers/misc/cxl/sysfs.c                  | 13 +++++++++++
 4 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index 134cfaf..389cf24 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -142,3 +142,9 @@ Description:    read/write
                 Value of 0 means PERST will not cause image load.  A power
                 cycle is required to load the image.  Value of 1 means PERST
                 will cause image load.
+
+What:           /sys/class/cxl/<card>/reset
+Date:           October 2014
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    write only
+                Writing 1 here will issue a PERST to card.
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 518c4c6..6a6a487 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -489,6 +489,7 @@ int cxl_alloc_irq_ranges(struct cxl_irq_ranges *irqs, struct cxl *adapter, unsig
 void cxl_release_irq_ranges(struct cxl_irq_ranges *irqs, struct cxl *adapter);
 int cxl_setup_irq(struct cxl *adapter, unsigned int hwirq, unsigned int virq);
 int cxl_update_image_control(struct cxl *adapter);
+int cxl_reset(struct cxl *adapter);
 
 /* common == phyp + powernv */
 struct cxl_process_element_common {
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 9aa95f9..a93daa0 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -21,6 +21,7 @@
 #include <asm/msi_bitmap.h>
 #include <asm/pci-bridge.h> /* for struct pci_controller */
 #include <asm/pnv-pci.h>
+#include <asm/io.h>
 
 #include "cxl.h"
 
@@ -742,6 +743,36 @@ static void cxl_remove_afu(struct cxl_afu *afu)
 	device_unregister(&afu->dev);
 }
 
+int cxl_reset(struct cxl *adapter)
+{
+	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
+	int rc;
+	int i;
+	u32 val;
+
+	dev_info(&dev->dev, "CXL reset\n");
+
+	for (i = 0; i < adapter->slices; i++)
+		cxl_remove_afu(adapter->afu[i]);
+
+	if ((rc = pci_set_pcie_reset_state(dev, pcie_warm_reset))) {
+		dev_err(&dev->dev, "cxl: pcie_warm_reset failed\n");
+		return rc;
+	}
+
+	/* Do mmio read to trigger EEH.  Retry for a few seconds. */
+	i = 0;
+        while ((val = mmio_read32be(adapter->p1_mmio) != 0xffffffff) &&
+		(i < 5)) {
+                msleep(500);
+		i++;
+        }
+
+        if (val != 0xffffffff)
+                dev_err(&dev->dev, "cxl: PERST failed to trigger EEH\n");
+
+	return rc;
+}
 
 static int cxl_map_adapter_regs(struct cxl *adapter, struct pci_dev *dev)
 {
@@ -806,8 +837,8 @@ static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
 	CXL_READ_VSEC_BASE_IMAGE(dev, vsec, &adapter->base_image);
 	CXL_READ_VSEC_IMAGE_STATE(dev, vsec, &image_state);
 	adapter->user_image_loaded = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
-	adapter->perst_loads_image = !!(image_state & CXL_VSEC_PERST_LOADS_IMAGE);
-	adapter->perst_select_user = !!(image_state & CXL_VSEC_PERST_SELECT_USER);
+	adapter->perst_loads_image = true;
+	adapter->perst_select_user = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
 
 	CXL_READ_VSEC_NAFUS(dev, vsec, &adapter->slices);
 	CXL_READ_VSEC_AFU_DESC_OFF(dev, vsec, &afu_desc_off);
@@ -915,6 +946,9 @@ static struct cxl *cxl_init_adapter(struct pci_dev *dev)
 	if ((rc = cxl_vsec_looks_ok(adapter, dev)))
 		goto err2;
 
+	if ((rc = cxl_update_image_control(adapter)))
+		goto err2;
+
 	if ((rc = cxl_map_adapter_regs(adapter, dev)))
 		goto err2;
 
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 06f554b..7ebd7e3 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -56,6 +56,18 @@ static ssize_t image_loaded_show(struct device *device,
 	return scnprintf(buf, PAGE_SIZE, "factory\n");
 }
 
+static ssize_t reset_adapter_store(struct device *device,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct cxl *adapter = to_cxl_adapter(device);
+	int rc;
+
+	if ((rc = cxl_reset(adapter)))
+		return rc;
+	return count;
+}
+
 static ssize_t reset_loads_image_show(struct device *device,
 				 struct device_attribute *attr,
 				 char *buf)
@@ -121,6 +133,7 @@ static struct device_attribute adapter_attrs[] = {
 	__ATTR_RO(image_loaded),
 	__ATTR_RW(reset_loads_image),
 	__ATTR_RW(reset_image_select),
+	__ATTR(reset, S_IWUSR, NULL, reset_adapter_store),
 };
 
 
-- 
1.9.1
