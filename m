Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79B5C1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 12:31:48 +1000 (AEST)
Received: from mail-pd0-x22f.google.com (mail-pd0-x22f.google.com
 [IPv6:2607:f8b0:400e:c02::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F1A12140774
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2015 12:31:47 +1000 (AEST)
Received: by pdjr16 with SMTP id r16so72922770pdj.3
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 19:31:46 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH 1/8] cxl: Allow the kernel to trust that an image won't change
 on PERST.
Date: Tue, 14 Jul 2015 12:29:27 +1000
Message-Id: <1436840974-3412-2-git-send-email-dja@axtens.net>
In-Reply-To: <1436840974-3412-1-git-send-email-dja@axtens.net>
References: <1436840974-3412-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Provide a kernel API and a sysfs entry which allow a user to specify
that when a card is PERSTed, it's image will stay the same, allowing
it to participate in EEH.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 Documentation/ABI/testing/sysfs-class-cxl | 10 ++++++++++
 drivers/misc/cxl/api.c                    |  7 +++++++
 drivers/misc/cxl/cxl.h                    |  1 +
 drivers/misc/cxl/pci.c                    |  1 +
 drivers/misc/cxl/sysfs.c                  | 26 ++++++++++++++++++++++++++
 include/misc/cxl.h                        | 10 ++++++++++
 6 files changed, 55 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index 7cd9f2ede369..c82f0c0a8e99 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -212,3 +212,13 @@ Description:    write only
                 Writing 1 will issue a PERST to card which may cause the card
                 to reload the FPGA depending on load_image_on_perst.
 Users:		https://github.com/ibm-capi/libcxl
+
+What:		/sys/class/cxl/<card>/perst_reloads_same_image
+Date:		July 2015
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	read/write
+		Trust that when an image is reloaded via PERST, it will not
+		have changed.
+		0 = don't trust, the image may be different (default)
+		1 = trust that the image will not change.
+Users:		https://github.com/ibm-capi/libcxl
diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 0c77240ae2fc..a0b8d5bd50f8 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -329,3 +329,10 @@ int cxl_afu_reset(struct cxl_context *ctx)
 	return cxl_afu_check_and_enable(afu);
 }
 EXPORT_SYMBOL_GPL(cxl_afu_reset);
+
+void cxl_perst_reloads_same_image(struct cxl_afu *afu,
+				  bool perst_reloads_same_image)
+{
+	afu->adapter->perst_same_image = perst_reloads_same_image;
+}
+EXPORT_SYMBOL_GPL(cxl_perst_reloads_same_image);
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index b37d13887766..de611a246c10 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -491,6 +491,7 @@ struct cxl {
 	bool user_image_loaded;
 	bool perst_loads_image;
 	bool perst_select_user;
+	bool perst_same_image;
 };
 
 int cxl_alloc_one_irq(struct cxl *adapter);
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index e6e28ff83e74..5fad83653c9e 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -891,6 +891,7 @@ static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
 	adapter->user_image_loaded = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
 	adapter->perst_loads_image = true;
 	adapter->perst_select_user = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
+	adapter->perst_same_image = false;
 
 	CXL_READ_VSEC_NAFUS(dev, vsec, &adapter->slices);
 	CXL_READ_VSEC_AFU_DESC_OFF(dev, vsec, &afu_desc_off);
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 2d6e104c6a6a..b308d1f37edd 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -112,12 +112,38 @@ static ssize_t load_image_on_perst_store(struct device *device,
 	return count;
 }
 
+static ssize_t perst_reloads_same_image_show(struct device *device,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct cxl *adapter = to_cxl_adapter(device);
+
+	return scnprintf(buf, PAGE_SIZE, "%i\n", adapter->perst_same_image);
+}
+
+static ssize_t perst_reloads_same_image_store(struct device *device,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct cxl *adapter = to_cxl_adapter(device);
+	int rc;
+	int val;
+
+	rc = sscanf(buf, "%i", &val);
+	if ((rc != 1) || !(val == 1 || val == 0))
+		return -EINVAL;
+
+	adapter->perst_same_image = (val == 1 ? true : false);
+	return count;
+}
+
 static struct device_attribute adapter_attrs[] = {
 	__ATTR_RO(caia_version),
 	__ATTR_RO(psl_revision),
 	__ATTR_RO(base_image),
 	__ATTR_RO(image_loaded),
 	__ATTR_RW(load_image_on_perst),
+	__ATTR_RW(perst_reloads_same_image),
 	__ATTR(reset, S_IWUSR, NULL, reset_adapter_store),
 };
 
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index 7a6c1d6cc173..f2ffe5bd720d 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -200,4 +200,14 @@ unsigned int cxl_fd_poll(struct file *file, struct poll_table_struct *poll);
 ssize_t cxl_fd_read(struct file *file, char __user *buf, size_t count,
 			   loff_t *off);
 
+/*
+ * For EEH, a driver may want to assert a PERST will reload the same image
+ * from flash into the FPGA.
+ *
+ * This is a property of the entire adapter, not a single AFU, so drivers
+ * should set this property with care!
+ */
+void cxl_perst_reloads_same_image(struct cxl_afu *afu,
+				  bool perst_reloads_same_image);
+
 #endif /* _MISC_CXL_H */
-- 
2.1.4
