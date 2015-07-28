Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B016F1A0E90
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 15:31:35 +1000 (AEST)
Received: from mail-pd0-x22b.google.com (mail-pd0-x22b.google.com
 [IPv6:2607:f8b0:400e:c02::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CFAB4140E11
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 15:31:34 +1000 (AEST)
Received: by pdbnt7 with SMTP id nt7so64330092pdb.0
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 22:31:33 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 08/10] cxl: Allow the kernel to trust that an image won't
 change on PERST.
Date: Tue, 28 Jul 2015 15:28:41 +1000
Message-Id: <1438061323-20710-9-git-send-email-dja@axtens.net>
In-Reply-To: <1438061323-20710-1-git-send-email-dja@axtens.net>
References: <1438061323-20710-1-git-send-email-dja@axtens.net>
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
 drivers/misc/cxl/api.c                    |  9 +++++++++
 drivers/misc/cxl/cxl.h                    |  3 +++
 drivers/misc/cxl/pci.c                    | 11 +++++++++++
 drivers/misc/cxl/sysfs.c                  | 30 ++++++++++++++++++++++++++++++
 include/misc/cxl.h                        | 12 ++++++++++++
 6 files changed, 75 insertions(+)

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
index 729e0851167d..c1012ced0323 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -327,3 +327,12 @@ int cxl_afu_reset(struct cxl_context *ctx)
 	return cxl_afu_check_and_enable(afu);
 }
 EXPORT_SYMBOL_GPL(cxl_afu_reset);
+
+#ifdef CONFIG_CXL_EEH
+void cxl_perst_reloads_same_image(struct cxl_afu *afu,
+				  bool perst_reloads_same_image)
+{
+	afu->adapter->perst_same_image = perst_reloads_same_image;
+}
+EXPORT_SYMBOL_GPL(cxl_perst_reloads_same_image);
+#endif
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 88a88c445e2a..6dd4158f76ac 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -493,6 +493,9 @@ struct cxl {
 	bool user_image_loaded;
 	bool perst_loads_image;
 	bool perst_select_user;
+#ifdef CONFIG_CXL_EEH
+	bool perst_same_image;
+#endif
 };
 
 int cxl_alloc_one_irq(struct cxl *adapter);
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 0acf9e62733e..b6a189b35323 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -875,6 +875,14 @@ int cxl_reset(struct cxl *adapter)
 	int i;
 	u32 val;
 
+#ifdef CONFIG_CXL_EEH
+	if (adapter->perst_same_image) {
+		dev_warn(&dev->dev,
+			 "cxl: refusing to reset/reflash when perst_reloads_same_image is set.\n");
+		return -EINVAL;
+	}
+#endif
+
 	dev_info(&dev->dev, "CXL reset\n");
 
 	/* pcie_warm_reset requests a fundamental pci reset which includes a
@@ -1148,6 +1156,9 @@ static struct cxl *cxl_init_adapter(struct pci_dev *dev)
 	 * configure/reconfigure
 	 */
 	adapter->perst_loads_image = true;
+#ifdef CONFIG_CXL_EEH
+	adapter->perst_same_image = false;
+#endif
 
 	if ((rc = cxl_configure_adapter(adapter, dev))) {
 		pci_disable_device(dev);
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 31f38bc71a3d..4bcb63258e3e 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -112,12 +112,42 @@ static ssize_t load_image_on_perst_store(struct device *device,
 	return count;
 }
 
+#ifdef CONFIG_CXL_EEH
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
+#endif /* CONFIG_CXL_EEH */
+
 static struct device_attribute adapter_attrs[] = {
 	__ATTR_RO(caia_version),
 	__ATTR_RO(psl_revision),
 	__ATTR_RO(base_image),
 	__ATTR_RO(image_loaded),
 	__ATTR_RW(load_image_on_perst),
+#ifdef CONFIG_CXL_EEH
+	__ATTR_RW(perst_reloads_same_image),
+#endif
 	__ATTR(reset, S_IWUSR, NULL, reset_adapter_store),
 };
 
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index 7a6c1d6cc173..7f2cdc6caab3 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -200,4 +200,16 @@ unsigned int cxl_fd_poll(struct file *file, struct poll_table_struct *poll);
 ssize_t cxl_fd_read(struct file *file, char __user *buf, size_t count,
 			   loff_t *off);
 
+#ifdef CONFIG_CXL_EEH
+/*
+ * For EEH, a driver may want to assert a PERST will reload the same image
+ * from flash into the FPGA.
+ *
+ * This is a property of the entire adapter, not a single AFU, so drivers
+ * should set this property with care!
+ */
+void cxl_perst_reloads_same_image(struct cxl_afu *afu,
+				  bool perst_reloads_same_image);
+#endif /* CONFIG_CXL_EEH */
+
 #endif /* _MISC_CXL_H */
-- 
2.1.4
