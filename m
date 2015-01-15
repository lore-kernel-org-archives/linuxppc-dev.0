Return-Path: <grimm@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A24F21A0D74
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 09:27:39 +1100 (AEDT)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <grimm@linux.vnet.ibm.com>;
 Thu, 15 Jan 2015 15:27:37 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id DD6D11FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:18:46 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0FMRY2l50200716
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:27:34 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0FMRYH6028053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:27:34 -0700
From: Ryan Grimm <grimm@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, mikey@neuling.org
Subject: [PATCH 1/3] CXL: Add image control to sysfs
Date: Thu, 15 Jan 2015 16:27:15 -0600
Message-Id: <1421360837-40287-1-git-send-email-grimm@linux.vnet.ibm.com>
Cc: Ryan Grimm <grimm@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

reset_image_select identifies whether a PERST will cause the image to be
flashed to the card.  And if so, which image.

Valid entries are: "none", "user" and "factory".

A value of "none" means PERST will not cause the image to be flashed.  A power
cycle to the pcie slot is required to load the image.

"user" loads the user provided image and "factory" loads the factory image upon
PERST.

sysfs updates the cxl struct in the driver then calls cxl_update_image_control
to write the vals in the VSEC.

Signed-off-by: Ryan Grimm <grimm@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/sysfs-class-cxl |  9 +++++++
 drivers/misc/cxl/cxl.h                    |  1 +
 drivers/misc/cxl/pci.c                    | 35 +++++++++++++++++++++++++++
 drivers/misc/cxl/sysfs.c                  | 39 +++++++++++++++++++++++++++++++
 4 files changed, 84 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index 554405e..d23d1c7 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -127,3 +127,12 @@ Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
                 Will return "user" or "factory" depending on the image loaded
                 onto the card.
+
+What:           /sys/class/cxl/<card>/load_image_on_perst
+Date:           December 2014
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    read/write
+                Value of "none" means PERST will not cause image to be loaded
+                to the card.  A power cycle is required to load the image.  
+                Value of "user" and "factory" means PERST will cause either the
+                user or factory image to be loaded.
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
index f801c28..26cacc1 100644
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
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 461bdbd..ed4ad46 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -56,11 +56,50 @@ static ssize_t image_loaded_show(struct device *device,
 	return scnprintf(buf, PAGE_SIZE, "factory\n");
 }
 
+static ssize_t load_image_on_perst_show(struct device *device,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct cxl *adapter = to_cxl_adapter(device);
+
+	if (!adapter->perst_loads_image)
+		return scnprintf(buf, PAGE_SIZE, "none\n");
+
+	if (adapter->perst_select_user)
+		return scnprintf(buf, PAGE_SIZE, "user\n");
+	return scnprintf(buf, PAGE_SIZE, "factory\n");
+}
+
+static ssize_t load_image_on_perst_store(struct device *device,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct cxl *adapter = to_cxl_adapter(device);
+	int rc;
+
+	if (!strncmp(buf, "none", 4))
+		adapter->perst_loads_image = false;
+	else if (!strncmp(buf, "user", 4)) {
+		adapter->perst_select_user = true;
+		adapter->perst_loads_image = true;
+	} else if (!strncmp(buf, "factory", 7)) {
+		adapter->perst_select_user = false;
+		adapter->perst_loads_image = true;
+	} else
+		return -EINVAL;
+
+	if ((rc = cxl_update_image_control(adapter)))
+		return rc;
+
+	return count;
+}
+
 static struct device_attribute adapter_attrs[] = {
 	__ATTR_RO(caia_version),
 	__ATTR_RO(psl_revision),
 	__ATTR_RO(base_image),
 	__ATTR_RO(image_loaded),
+	__ATTR_RW(load_image_on_perst),
 };
 
 
-- 
1.9.1
