Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 15BCF1A05D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 03:22:11 +1100 (AEDT)
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 23 Feb 2016 16:22:08 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2F0C217D805F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 16:22:27 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1NGM6qD8061360
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 16:22:06 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1NGM5hk008900
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 09:22:05 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 13/18] cxl: sysfs support for guests
Date: Tue, 23 Feb 2016 17:21:54 +0100
Message-Id: <1456244519-18934-14-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
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
---
 Documentation/ABI/testing/sysfs-class-cxl |  8 +++----
 drivers/misc/cxl/cxl.h                    |  1 +
 drivers/misc/cxl/guest.c                  | 12 +++++++++++
 drivers/misc/cxl/native.c                 |  6 ++++++
 drivers/misc/cxl/sysfs.c                  | 36 +++++++++++++++++++++++--------
 5 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index b07e86d..4d0da47 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
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
index 4372a87..e54bf4f 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -844,6 +844,7 @@ struct cxl_backend_ops {
 	int (*attach_process)(struct cxl_context *ctx, bool kernel,
 			u64 wed, u64 amr);
 	int (*detach_process)(struct cxl_context *ctx);
+	bool (*support_attributes)(const char *attr_name);
 	bool (*link_ok)(struct cxl *cxl);
 	void (*release_afu)(struct device *dev);
 	ssize_t (*afu_read_err_buffer)(struct cxl_afu *afu, char *buf,
diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index 03eb83d..d02ff03 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -596,6 +596,17 @@ static int guest_afu_check_and_enable(struct cxl_afu *afu)
 	return 0;
 }
 
+static bool guest_support_attributes(const char *attr_name)
+{
+	if ((strcmp(attr_name, "base_image") == 0) ||
+		(strcmp(attr_name, "load_image_on_perst") == 0) ||
+		(strcmp(attr_name, "perst_reloads_same_image") == 0) ||
+		(strcmp(attr_name, "image_loaded") == 0))
+		return false;
+
+	return true;
+}
+
 static int activate_afu_directed(struct cxl_afu *afu)
 {
 	int rc;
@@ -936,6 +947,7 @@ const struct cxl_backend_ops cxl_guest_ops = {
 	.ack_irq = guest_ack_irq,
 	.attach_process = guest_attach_process,
 	.detach_process = guest_detach_process,
+	.support_attributes = guest_support_attributes,
 	.link_ok = guest_link_ok,
 	.release_afu = guest_release_afu,
 	.afu_read_err_buffer = guest_afu_read_err_buffer,
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index c0bca59..acb9486 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -967,6 +967,11 @@ int cxl_check_error(struct cxl_afu *afu)
 	return (cxl_p1n_read(afu, CXL_PSL_SCNTL_An) == ~0ULL);
 }
 
+static bool native_support_attributes(const char *attr_name)
+{
+	return true;
+}
+
 static int native_afu_cr_read64(struct cxl_afu *afu, int cr, u64 off, u64 *out)
 {
 	if (unlikely(!cxl_ops->link_ok(afu->adapter)))
@@ -1026,6 +1031,7 @@ const struct cxl_backend_ops cxl_native_ops = {
 	.ack_irq = native_ack_irq,
 	.attach_process = native_attach_process,
 	.detach_process = native_detach_process,
+	.support_attributes = native_support_attributes,
 	.link_ok = cxl_adapter_link_ok,
 	.release_afu = cxl_pci_release_afu,
 	.afu_read_err_buffer = cxl_pci_afu_read_err_buffer,
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 1a1409c..41963d4 100644
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
@@ -406,24 +412,36 @@ static struct device_attribute afu_attrs[] = {
 
 int cxl_sysfs_adapter_add(struct cxl *adapter)
 {
+	struct device_attribute *dev_attr;
 	int i, rc;
 
 	for (i = 0; i < ARRAY_SIZE(adapter_attrs); i++) {
-		if ((rc = device_create_file(&adapter->dev, &adapter_attrs[i])))
-			goto err;
+		dev_attr = &adapter_attrs[i];
+		if (cxl_ops->support_attributes(dev_attr->attr.name)) {
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
+		if (cxl_ops->support_attributes(dev_attr->attr.name))
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
+		if (cxl_ops->support_attributes(dev_attr->attr.name))
+			device_remove_file(&adapter->dev, dev_attr);
+	}
 }
 
 struct afu_config_record {
@@ -534,7 +552,7 @@ static struct afu_config_record *cxl_sysfs_afu_new_cr(struct cxl_afu *afu, int c
 	/*
 	 * Export raw AFU PCIe like config record. For now this is read only by
 	 * root - we can expand that later to be readable by non-root and maybe
-	 * even writable provided we have a good use-case. Once we suport
+	 * even writable provided we have a good use-case. Once we support
 	 * exposing AFUs through a virtual PHB they will get that for free from
 	 * Linux' PCI infrastructure, but until then it's not clear that we
 	 * need it for anything since the main use case is just identifying
-- 
1.9.1
