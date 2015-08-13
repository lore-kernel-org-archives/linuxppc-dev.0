Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E411D1A1A78
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 14:14:47 +1000 (AEST)
Received: from mail-pd0-x233.google.com (mail-pd0-x233.google.com
 [IPv6:2607:f8b0:400e:c02::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6AFE514028F
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2015 14:14:47 +1000 (AEST)
Received: by pdco4 with SMTP id o4so14685655pdc.3
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 21:14:45 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, cyrilbur@gmail.com,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, mikey@neuling.org, imunsie@au.ibm.com,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH v4 09/11] cxl: Allow the kernel to trust that an image won't
 change on PERST.
Date: Thu, 13 Aug 2015 14:11:27 +1000
Message-Id: <1439439089-25151-10-git-send-email-dja@axtens.net>
In-Reply-To: <1439439089-25151-1-git-send-email-dja@axtens.net>
References: <1439439089-25151-1-git-send-email-dja@axtens.net>
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

cxl_reset is used to reflash the card. In that case, we cannot safely
assert that the image will not change. Therefore, disallow cxl_reset
if the flag is set.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 Documentation/ABI/testing/sysfs-class-cxl | 10 ++++++++++
 drivers/misc/cxl/api.c                    |  7 +++++++
 drivers/misc/cxl/cxl.h                    |  1 +
 drivers/misc/cxl/pci.c                    |  7 +++++++
 drivers/misc/cxl/sysfs.c                  | 26 ++++++++++++++++++++++++++
 include/misc/cxl.h                        | 10 ++++++++++
 6 files changed, 61 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index acfe9df83139..b07e86d4597f 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -223,3 +223,13 @@ Description:    write only
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
index 729e0851167d..6a768a9ad22f 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -327,3 +327,10 @@ int cxl_afu_reset(struct cxl_context *ctx)
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
index d540542f9931..cda02412b01e 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -493,6 +493,7 @@ struct cxl {
 	bool user_image_loaded;
 	bool perst_loads_image;
 	bool perst_select_user;
+	bool perst_same_image;
 };
 
 int cxl_alloc_one_irq(struct cxl *adapter);
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index e7976deed1f8..965524a6ae7c 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -887,6 +887,12 @@ int cxl_reset(struct cxl *adapter)
 	int i;
 	u32 val;
 
+	if (adapter->perst_same_image) {
+		dev_warn(&dev->dev,
+			 "cxl: refusing to reset/reflash when perst_reloads_same_image is set.\n");
+		return -EINVAL;
+	}
+
 	dev_info(&dev->dev, "CXL reset\n");
 
 	/* pcie_warm_reset requests a fundamental pci reset which includes a
@@ -1171,6 +1177,7 @@ static struct cxl *cxl_init_adapter(struct pci_dev *dev)
 	 * configure/reconfigure
 	 */
 	adapter->perst_loads_image = true;
+	adapter->perst_same_image = false;
 
 	rc = cxl_configure_adapter(adapter, dev);
 	if (rc) {
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 31f38bc71a3d..6619cf1f6e1f 100644
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
