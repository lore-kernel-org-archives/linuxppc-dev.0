Return-Path: <grimm@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7972D1A0E06
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 09:27:45 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <grimm@linux.vnet.ibm.com>;
 Thu, 15 Jan 2015 15:27:43 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 725DF3E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:20:36 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0FMRea451576998
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:27:40 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0FMRdf9028536
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:27:40 -0700
From: Ryan Grimm <grimm@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, mikey@neuling.org
Subject: [PATCH 3/3] CXL: Add ability to reset the card
Date: Thu, 15 Jan 2015 16:27:17 -0600
Message-Id: <1421360837-40287-3-git-send-email-grimm@linux.vnet.ibm.com>
In-Reply-To: <1421360837-40287-1-git-send-email-grimm@linux.vnet.ibm.com>
References: <1421360837-40287-1-git-send-email-grimm@linux.vnet.ibm.com>
Cc: Ryan Grimm <grimm@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds reset to sysfs which will PERST the card.  If load_image_on_perst is set
to "user" or "factory", the PERST will cause that image to be loaded.

load_image_on_perst is set to "user" for production.

"none" could be used for debugging.  The PSL trace arrays are preserved which
then can be read through debugfs.

PERST also triggers CAPP recovery.  An HMI comes in, which is handled by EEH.
EEH unbinds the driver, calls into Sapphire to reinitialize the PHB, then
rebinds the driver.

Signed-off-by: Ryan Grimm <grimm@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/sysfs-class-cxl | 14 ++++++++--
 drivers/misc/cxl/cxl.h                    |  1 +
 drivers/misc/cxl/pci.c                    | 44 +++++++++++++++++++++++++++++--
 drivers/misc/cxl/sysfs.c                  | 13 +++++++++
 4 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index d23d1c7..043bfbf 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -133,6 +133,16 @@ Date:           December 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read/write
                 Value of "none" means PERST will not cause image to be loaded
-                to the card.  A power cycle is required to load the image.  
+                to the card.  A power cycle is required to load the image.
+                "none" is useful for debugging so the contents of the trace 
+                arrays are preserved.
                 Value of "user" and "factory" means PERST will cause either the
-                user or factory image to be loaded.
+                user or factory image to be loaded.  "user" is default and 
+                should be used in production.  
+
+What:           /sys/class/cxl/<card>/reset
+Date:           October 2014
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    write only
+                Writing 1 will issue a PERST to card which may cause the card
+                to reload the FPGA depending on load_image_on_perst.
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
index 0f546f6..5137ee5 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -21,6 +21,7 @@
 #include <asm/msi_bitmap.h>
 #include <asm/pci-bridge.h> /* for struct pci_controller */
 #include <asm/pnv-pci.h>
+#include <asm/io.h>
 
 #include "cxl.h"
 
@@ -742,6 +743,42 @@ static void cxl_remove_afu(struct cxl_afu *afu)
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
+	/* pcie_warm_reset requests a fundamental pci reset which includes a
+	 * PERST assert/deassert.  PERST triggers a loading of the image
+	 * if "user" or "factory" is selected in sysfs */
+	if ((rc = pci_set_pcie_reset_state(dev, pcie_warm_reset))) {
+		dev_err(&dev->dev, "cxl: pcie_warm_reset failed\n");
+		return rc;
+	}
+
+	/* the PERST done above fences the PHB.  So, reset depends on EEH
+	 * to unbind the driver, tell Sapphire to reinit the PHB, and rebind
+	 * the driver.  Do an mmio read explictly to ensure EEH notices the
+	 * fenced PHB.  Retry for a few seconds before giving up. */
+	i = 0;
+	while (((val = mmio_read32be(adapter->p1_mmio)) != 0xffffffff) &&
+		(i < 5)) {
+		msleep(500);
+		i++;
+	}
+
+	if (val != 0xffffffff)
+		dev_err(&dev->dev, "cxl: PERST failed to trigger EEH\n");
+
+	return rc;
+}
 
 static int cxl_map_adapter_regs(struct cxl *adapter, struct pci_dev *dev)
 {
@@ -806,8 +843,8 @@ static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
 	CXL_READ_VSEC_BASE_IMAGE(dev, vsec, &adapter->base_image);
 	CXL_READ_VSEC_IMAGE_STATE(dev, vsec, &image_state);
 	adapter->user_image_loaded = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
-	adapter->perst_loads_image = !!(image_state & CXL_VSEC_PERST_LOADS_IMAGE);
-	adapter->perst_select_user = !!(image_state & CXL_VSEC_PERST_SELECT_USER);
+	adapter->perst_loads_image = true;
+	adapter->perst_select_user = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
 
 	CXL_READ_VSEC_NAFUS(dev, vsec, &adapter->slices);
 	CXL_READ_VSEC_AFU_DESC_OFF(dev, vsec, &afu_desc_off);
@@ -915,6 +952,9 @@ static struct cxl *cxl_init_adapter(struct pci_dev *dev)
 	if ((rc = cxl_vsec_looks_ok(adapter, dev)))
 		goto err2;
 
+	if ((rc = cxl_update_image_control(adapter)))
+		goto err2;
+
 	if ((rc = cxl_map_adapter_regs(adapter, dev)))
 		goto err2;
 
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index ed4ad46..c4febcf 100644
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
 static ssize_t load_image_on_perst_show(struct device *device,
 				 struct device_attribute *attr,
 				 char *buf)
@@ -100,6 +112,7 @@ static struct device_attribute adapter_attrs[] = {
 	__ATTR_RO(base_image),
 	__ATTR_RO(image_loaded),
 	__ATTR_RW(load_image_on_perst),
+	__ATTR(reset, S_IWUSR, NULL, reset_adapter_store),
 };
 
 
-- 
1.9.1
