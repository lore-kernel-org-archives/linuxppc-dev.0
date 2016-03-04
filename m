Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA36F1A0B7A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 22:27:06 +1100 (AEDT)
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 11:27:03 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0F71617D8068
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 11:27:26 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u24BR0gG7209416
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 11:27:00 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24BQx8L007502
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 04:27:00 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 13/20] cxl: sysfs support for guests
Date: Fri,  4 Mar 2016 12:26:37 +0100
Message-Id: <1457090804-9719-14-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christophe Lombard <clombard@linux.vnet.ibm.com>

Filter out a few adapter parameters which don't make sense in a guest.
Document the changes.

Co-authored-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/sysfs-class-cxl | 10 ++--
 drivers/misc/cxl/cxl.h                    |  7 +++
 drivers/misc/cxl/guest.c                  | 25 +++++++++
 drivers/misc/cxl/native.c                 |  7 +++
 drivers/misc/cxl/sysfs.c                  | 89 ++++++++++++++++++++++++-------
 5 files changed, 113 insertions(+), 25 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index b07e86d..7fd737e 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -159,7 +159,7 @@ Description:    read only
                 Decimal value of the Per Process MMIO space length.
 Users:		https://github.com/ibm-capi/libcxl
 
-What:           /sys/class/cxl/<afu>m/pp_mmio_off
+What:           /sys/class/cxl/<afu>m/pp_mmio_off (not in a guest)
 Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
@@ -183,7 +183,7 @@ Description:    read only
                 Identifies the revision level of the PSL.
 Users:		https://github.com/ibm-capi/libcxl
 
-What:           /sys/class/cxl/<card>/base_image
+What:           /sys/class/cxl/<card>/base_image (not in a guest)
 Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
@@ -193,7 +193,7 @@ Description:    read only
                 during the initial program load.
 Users:		https://github.com/ibm-capi/libcxl
 
-What:           /sys/class/cxl/<card>/image_loaded
+What:           /sys/class/cxl/<card>/image_loaded (not in a guest)
 Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
@@ -201,7 +201,7 @@ Description:    read only
                 onto the card.
 Users:		https://github.com/ibm-capi/libcxl
 
-What:           /sys/class/cxl/<card>/load_image_on_perst
+What:           /sys/class/cxl/<card>/load_image_on_perst (not in a guest)
 Date:           December 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read/write
@@ -224,7 +224,7 @@ Description:    write only
                 to reload the FPGA depending on load_image_on_perst.
 Users:		https://github.com/ibm-capi/libcxl
 
-What:		/sys/class/cxl/<card>/perst_reloads_same_image
+What:		/sys/class/cxl/<card>/perst_reloads_same_image (not in a guest)
 Date:		July 2015
 Contact:	linuxppc-dev@lists.ozlabs.org
 Description:	read/write
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 4372a87..a7e75f1 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -336,6 +336,12 @@ enum prefault_modes {
 	CXL_PREFAULT_ALL,
 };
 
+enum cxl_attrs {
+	CXL_ADAPTER_ATTRS,
+	CXL_AFU_MASTER_ATTRS,
+	CXL_AFU_ATTRS,
+};
+
 struct cxl_sste {
 	__be64 esid_data;
 	__be64 vsid_data;
@@ -844,6 +850,7 @@ struct cxl_backend_ops {
 	int (*attach_process)(struct cxl_context *ctx, bool kernel,
 			u64 wed, u64 amr);
 	int (*detach_process)(struct cxl_context *ctx);
+	bool (*support_attributes)(const char *attr_name, enum cxl_attrs type);
 	bool (*link_ok)(struct cxl *cxl);
 	void (*release_afu)(struct device *dev);
 	ssize_t (*afu_read_err_buffer)(struct cxl_afu *afu, char *buf,
diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index 03eb83d..920e074 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -596,6 +596,30 @@ static int guest_afu_check_and_enable(struct cxl_afu *afu)
 	return 0;
 }
 
+static bool guest_support_attributes(const char *attr_name,
+				     enum cxl_attrs type)
+{
+	switch (type) {
+	case CXL_ADAPTER_ATTRS:
+		if ((strcmp(attr_name, "base_image") == 0) ||
+			(strcmp(attr_name, "load_image_on_perst") == 0) ||
+			(strcmp(attr_name, "perst_reloads_same_image") == 0) ||
+			(strcmp(attr_name, "image_loaded") == 0))
+			return false;
+		break;
+	case CXL_AFU_MASTER_ATTRS:
+		if ((strcmp(attr_name, "pp_mmio_off") == 0))
+			return false;
+		break;
+	case CXL_AFU_ATTRS:
+		break;
+	default:
+		break;
+	}
+
+	return true;
+}
+
 static int activate_afu_directed(struct cxl_afu *afu)
 {
 	int rc;
@@ -936,6 +960,7 @@ const struct cxl_backend_ops cxl_guest_ops = {
 	.ack_irq = guest_ack_irq,
 	.attach_process = guest_attach_process,
 	.detach_process = guest_detach_process,
+	.support_attributes = guest_support_attributes,
 	.link_ok = guest_link_ok,
 	.release_afu = guest_release_afu,
 	.afu_read_err_buffer = guest_afu_read_err_buffer,
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index c0bca59..0e289c2 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -967,6 +967,12 @@ int cxl_check_error(struct cxl_afu *afu)
 	return (cxl_p1n_read(afu, CXL_PSL_SCNTL_An) == ~0ULL);
 }
 
+static bool native_support_attributes(const char *attr_name,
+				      enum cxl_attrs type)
+{
+	return true;
+}
+
 static int native_afu_cr_read64(struct cxl_afu *afu, int cr, u64 off, u64 *out)
 {
 	if (unlikely(!cxl_ops->link_ok(afu->adapter)))
@@ -1026,6 +1032,7 @@ const struct cxl_backend_ops cxl_native_ops = {
 	.ack_irq = native_ack_irq,
 	.attach_process = native_attach_process,
 	.detach_process = native_detach_process,
+	.support_attributes = native_support_attributes,
 	.link_ok = cxl_adapter_link_ok,
 	.release_afu = cxl_pci_release_afu,
 	.afu_read_err_buffer = cxl_pci_afu_read_err_buffer,
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 1a1409c..907c99b 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -253,8 +253,14 @@ static ssize_t irqs_max_store(struct device *device,
 	if (irqs_max < afu->pp_irqs)
 		return -EINVAL;
 
-	if (irqs_max > afu->adapter->user_irqs)
-		return -EINVAL;
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		if (irqs_max > afu->adapter->user_irqs)
+			return -EINVAL;
+	} else {
+		/* pHyp sets a per-AFU limit */
+		if (irqs_max > afu->guest->max_ints)
+			return -EINVAL;
+	}
 
 	afu->irqs_max = irqs_max;
 	return count;
@@ -406,24 +412,39 @@ static struct device_attribute afu_attrs[] = {
 
 int cxl_sysfs_adapter_add(struct cxl *adapter)
 {
+	struct device_attribute *dev_attr;
 	int i, rc;
 
 	for (i = 0; i < ARRAY_SIZE(adapter_attrs); i++) {
-		if ((rc = device_create_file(&adapter->dev, &adapter_attrs[i])))
-			goto err;
+		dev_attr = &adapter_attrs[i];
+		if (cxl_ops->support_attributes(dev_attr->attr.name,
+						CXL_ADAPTER_ATTRS)) {
+			if ((rc = device_create_file(&adapter->dev, dev_attr)))
+				goto err;
+		}
 	}
 	return 0;
 err:
-	for (i--; i >= 0; i--)
-		device_remove_file(&adapter->dev, &adapter_attrs[i]);
+	for (i--; i >= 0; i--) {
+		dev_attr = &adapter_attrs[i];
+		if (cxl_ops->support_attributes(dev_attr->attr.name,
+						CXL_ADAPTER_ATTRS))
+			device_remove_file(&adapter->dev, dev_attr);
+	}
 	return rc;
 }
+
 void cxl_sysfs_adapter_remove(struct cxl *adapter)
 {
+	struct device_attribute *dev_attr;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(adapter_attrs); i++)
-		device_remove_file(&adapter->dev, &adapter_attrs[i]);
+	for (i = 0; i < ARRAY_SIZE(adapter_attrs); i++) {
+		dev_attr = &adapter_attrs[i];
+		if (cxl_ops->support_attributes(dev_attr->attr.name,
+						CXL_ADAPTER_ATTRS))
+			device_remove_file(&adapter->dev, dev_attr);
+	}
 }
 
 struct afu_config_record {
@@ -534,7 +555,7 @@ static struct afu_config_record *cxl_sysfs_afu_new_cr(struct cxl_afu *afu, int c
 	/*
 	 * Export raw AFU PCIe like config record. For now this is read only by
 	 * root - we can expand that later to be readable by non-root and maybe
-	 * even writable provided we have a good use-case. Once we suport
+	 * even writable provided we have a good use-case. Once we support
 	 * exposing AFUs through a virtual PHB they will get that for free from
 	 * Linux' PCI infrastructure, but until then it's not clear that we
 	 * need it for anything since the main use case is just identifying
@@ -572,6 +593,7 @@ err:
 
 void cxl_sysfs_afu_remove(struct cxl_afu *afu)
 {
+	struct device_attribute *dev_attr;
 	struct afu_config_record *cr, *tmp;
 	int i;
 
@@ -579,8 +601,12 @@ void cxl_sysfs_afu_remove(struct cxl_afu *afu)
 	if (afu->eb_len)
 		device_remove_bin_file(&afu->dev, &afu->attr_eb);
 
-	for (i = 0; i < ARRAY_SIZE(afu_attrs); i++)
-		device_remove_file(&afu->dev, &afu_attrs[i]);
+	for (i = 0; i < ARRAY_SIZE(afu_attrs); i++) {
+		dev_attr = &afu_attrs[i];
+		if (cxl_ops->support_attributes(dev_attr->attr.name,
+						CXL_AFU_ATTRS))
+			device_remove_file(&afu->dev, &afu_attrs[i]);
+	}
 
 	list_for_each_entry_safe(cr, tmp, &afu->crs, list) {
 		sysfs_remove_bin_file(&cr->kobj, &cr->config_attr);
@@ -590,14 +616,19 @@ void cxl_sysfs_afu_remove(struct cxl_afu *afu)
 
 int cxl_sysfs_afu_add(struct cxl_afu *afu)
 {
+	struct device_attribute *dev_attr;
 	struct afu_config_record *cr;
 	int i, rc;
 
 	INIT_LIST_HEAD(&afu->crs);
 
 	for (i = 0; i < ARRAY_SIZE(afu_attrs); i++) {
-		if ((rc = device_create_file(&afu->dev, &afu_attrs[i])))
-			goto err;
+		dev_attr = &afu_attrs[i];
+		if (cxl_ops->support_attributes(dev_attr->attr.name,
+						CXL_AFU_ATTRS)) {
+			if ((rc = device_create_file(&afu->dev, &afu_attrs[i])))
+				goto err;
+		}
 	}
 
 	/* conditionally create the add the binary file for error info buffer */
@@ -636,32 +667,50 @@ err:
 	/* reset the eb_len as we havent created the bin attr */
 	afu->eb_len = 0;
 
-	for (i--; i >= 0; i--)
+	for (i--; i >= 0; i--) {
+		dev_attr = &afu_attrs[i];
+		if (cxl_ops->support_attributes(dev_attr->attr.name,
+						CXL_AFU_ATTRS))
 		device_remove_file(&afu->dev, &afu_attrs[i]);
+	}
 	return rc;
 }
 
 int cxl_sysfs_afu_m_add(struct cxl_afu *afu)
 {
+	struct device_attribute *dev_attr;
 	int i, rc;
 
 	for (i = 0; i < ARRAY_SIZE(afu_master_attrs); i++) {
-		if ((rc = device_create_file(afu->chardev_m, &afu_master_attrs[i])))
-			goto err;
+		dev_attr = &afu_master_attrs[i];
+		if (cxl_ops->support_attributes(dev_attr->attr.name,
+						CXL_AFU_MASTER_ATTRS)) {
+			if ((rc = device_create_file(afu->chardev_m, &afu_master_attrs[i])))
+				goto err;
+		}
 	}
 
 	return 0;
 
 err:
-	for (i--; i >= 0; i--)
-		device_remove_file(afu->chardev_m, &afu_master_attrs[i]);
+	for (i--; i >= 0; i--) {
+		dev_attr = &afu_master_attrs[i];
+		if (cxl_ops->support_attributes(dev_attr->attr.name,
+						CXL_AFU_MASTER_ATTRS))
+			device_remove_file(afu->chardev_m, &afu_master_attrs[i]);
+	}
 	return rc;
 }
 
 void cxl_sysfs_afu_m_remove(struct cxl_afu *afu)
 {
+	struct device_attribute *dev_attr;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(afu_master_attrs); i++)
-		device_remove_file(afu->chardev_m, &afu_master_attrs[i]);
+	for (i = 0; i < ARRAY_SIZE(afu_master_attrs); i++) {
+		dev_attr = &afu_master_attrs[i];
+		if (cxl_ops->support_attributes(dev_attr->attr.name,
+						CXL_AFU_MASTER_ATTRS))
+			device_remove_file(afu->chardev_m, &afu_master_attrs[i]);
+	}
 }
-- 
1.9.1
