Return-Path: <grimm@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DFA731A0DA1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 04:53:13 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <grimm@linux.vnet.ibm.com>;
 Mon, 19 Jan 2015 10:53:11 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 76B1A19D8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 10:44:20 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0JHpqbm32440488
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 10:51:52 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0JHr7EX018828
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 10:53:08 -0700
From: Ryan Grimm <grimm@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, mikey@neuling.org
Subject: [PATCH 4/4] CXL: Add ability to reset the card
Date: Mon, 19 Jan 2015 11:52:51 -0600
Message-Id: <1421689971-34476-4-git-send-email-grimm@linux.vnet.ibm.com>
In-Reply-To: <1421689971-34476-1-git-send-email-grimm@linux.vnet.ibm.com>
References: <1421689971-34476-1-git-send-email-grimm@linux.vnet.ibm.com>
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
 Documentation/ABI/testing/sysfs-class-cxl |  7 ++++++
 drivers/misc/cxl/cxl.h                    |  1 +
 drivers/misc/cxl/pci.c                    | 37 +++++++++++++++++++++++++++++++
 drivers/misc/cxl/sysfs.c                  | 18 +++++++++++++++
 4 files changed, 63 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index 6fcc631..db31176 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -141,3 +141,10 @@ Description:    read/write
                 user or factory image to be loaded.
                 Default is to reload on PERST whichever image the card has
                 loaded.
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
index b4aa4f1..5137ee5 100644
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
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index ed4ad46..adf1f6d 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -56,6 +56,23 @@ static ssize_t image_loaded_show(struct device *device,
 	return scnprintf(buf, PAGE_SIZE, "factory\n");
 }
 
+static ssize_t reset_adapter_store(struct device *device,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct cxl *adapter = to_cxl_adapter(device);
+	int rc;
+	int val;
+
+	rc = sscanf(buf, "%i", &val);
+	if ((rc != 1) || (val != 1))
+		return -EINVAL;
+
+	if ((rc = cxl_reset(adapter)))
+		return rc;
+	return count;
+}
+
 static ssize_t load_image_on_perst_show(struct device *device,
 				 struct device_attribute *attr,
 				 char *buf)
@@ -100,6 +117,7 @@ static struct device_attribute adapter_attrs[] = {
 	__ATTR_RO(base_image),
 	__ATTR_RO(image_loaded),
 	__ATTR_RW(load_image_on_perst),
+	__ATTR(reset, S_IWUSR, NULL, reset_adapter_store),
 };
 
 
-- 
1.9.1
