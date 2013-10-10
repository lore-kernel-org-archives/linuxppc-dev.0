Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2C2CA2C046B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 19:18:42 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r9A8Ib05024029
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 03:18:38 -0500
Message-ID: <1381393115.4330.39.camel@pasglop>
Subject: [PATCH 2/3] powerpc/scom: Replace debugfs interface with cleaner
 sysfs one
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 10 Oct 2013 19:18:35 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The debugfs interface was essentially unused, and racy for anything
other than manual use by a developer. This provides a more useful
sysfs based one which can be used by programs without racing with
each other essentially by providing a file to read/write with an
offset being the scom address << 8.

It requires 8 bytes aligned and multiple of 8 bytes sized accesses

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/configs/chroma_defconfig |   2 +-
 arch/powerpc/sysdev/Kconfig           |   6 +-
 arch/powerpc/sysdev/scom.c            | 210 +++++++++++++++++++++-------------
 3 files changed, 135 insertions(+), 83 deletions(-)

diff --git a/arch/powerpc/configs/chroma_defconfig b/arch/powerpc/configs/chroma_defconfig
index 4f35fc4..2891464 100644
--- a/arch/powerpc/configs/chroma_defconfig
+++ b/arch/powerpc/configs/chroma_defconfig
@@ -42,7 +42,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_SCOM_DEBUGFS=y
+CONFIG_SCOM_SYSFS=y
 CONFIG_PPC_A2_DD2=y
 CONFIG_KVM_GUEST=y
 CONFIG_NO_HZ=y
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index 13ec968..30c26bb 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -26,9 +26,9 @@ source "arch/powerpc/sysdev/xics/Kconfig"
 config PPC_SCOM
 	bool
 
-config SCOM_DEBUGFS
-	bool "Expose SCOM controllers via debugfs"
-	depends on PPC_SCOM && DEBUG_FS
+config SCOM_SYSFS
+	bool "Expose SCOM controllers via sysfs"
+	depends on PPC_SCOM
 	default n
 
 config GE_FPGA
diff --git a/arch/powerpc/sysdev/scom.c b/arch/powerpc/sysdev/scom.c
index 3963d99..72eda2d 100644
--- a/arch/powerpc/sysdev/scom.c
+++ b/arch/powerpc/sysdev/scom.c
@@ -19,9 +19,10 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/debugfs.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
 #include <asm/debug.h>
 #include <asm/prom.h>
 #include <asm/scom.h>
@@ -95,116 +96,167 @@ scom_map_t scom_map_device(struct device_node *dev, int index)
 }
 EXPORT_SYMBOL_GPL(scom_map_device);
 
-#ifdef CONFIG_SCOM_DEBUGFS
-struct scom_debug_entry {
-	struct device_node *dn;
-	unsigned long addr;
-	scom_map_t map;
-	spinlock_t lock;
-	char name[8];
-	struct debugfs_blob_wrapper blob;
+#ifdef CONFIG_SCOM_SYSFS
+
+struct scom_chip_dir {
+	struct kobject kobj;
+	struct device_node *devnode;
 };
 
-static int scom_addr_set(void *data, u64 val)
+static struct scom_chip_dir *kobj_to_scom_chip_dir(struct kobject *k)
 {
-	struct scom_debug_entry *ent = data;
-
-	ent->addr = 0;
-	scom_unmap(ent->map);
-
-	ent->map = scom_map(ent->dn, val, 1);
-	if (scom_map_ok(ent->map))
-		ent->addr = val;
-	else
-		return -EFAULT;
-
-	return 0;
+	return container_of(k, struct scom_chip_dir, kobj);
 }
 
-static int scom_addr_get(void *data, u64 *val)
+static ssize_t scom_devspec_show(struct kobject *k, struct kobj_attribute *attr,
+				 char *buf)
 {
-	struct scom_debug_entry *ent = data;
-	*val = ent->addr;
-	return 0;
-}
-DEFINE_SIMPLE_ATTRIBUTE(scom_addr_fops, scom_addr_get, scom_addr_set,
-			"0x%llx\n");
+	struct scom_chip_dir *dir = kobj_to_scom_chip_dir(k);
 
-static int scom_val_set(void *data, u64 val)
-{
-	struct scom_debug_entry *ent = data;
+	return sprintf(buf, "%s", dir->devnode->full_name);
+}
 
-	if (!scom_map_ok(ent->map))
-		return -EFAULT;
+static struct kobj_attribute scom_devspec_attr =
+	__ATTR(devspec, S_IRUGO, scom_devspec_show, NULL);
 
-	scom_write(ent->map, 0, val);
+static struct attribute *scom_dir_default_attrs[] = {
+	&scom_devspec_attr.attr,
+	NULL,
+};
 
-	return 0;
+static void scom_dir_release(struct kobject *kobj)
+{
+	struct scom_chip_dir *dir = kobj_to_scom_chip_dir(kobj);
+	kfree(dir);
 }
 
-static int scom_val_get(void *data, u64 *val)
-{
-	struct scom_debug_entry *ent = data;
+static struct kobj_type scom_dir_type = {
+	.release = scom_dir_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_attrs = scom_dir_default_attrs,
+};
 
-	if (!scom_map_ok(ent->map))
-		return -EFAULT;
+static ssize_t scom_sysfs_read(struct file *filp, struct kobject *kobj,
+			       struct bin_attribute *bin_attr,
+			       char *buf, loff_t off, size_t count)
+{
+	struct scom_chip_dir *dir = kobj_to_scom_chip_dir(kobj);
+	u64 reg, reg_cnt, *buf64;
+	scom_map_t map;
+	int rc;
+
+	if (off & 7 || count & 7)
+		return -EINVAL;
+	reg = off >> 3;
+	reg_cnt = count >> 3;
+
+	map = scom_map(dir->devnode, reg, reg_cnt);
+	if (!scom_map_ok(map))
+		return -EINVAL;
+
+	buf64 = (u64 *)buf;
+	for (reg = 0; reg < reg_cnt; reg++) {
+		rc = scom_read(map, reg, buf64++);
+		if (rc) {
+			count = rc;
+			break;
+		}
+	}
+	scom_unmap(map);
+	return count;
+}
 
-	return scom_read(ent->map, 0, val);
+static ssize_t scom_sysfs_write(struct file* filp, struct kobject *kobj,
+				struct bin_attribute *bin_attr,
+				char *buf, loff_t off, size_t count)
+{
+	struct scom_chip_dir *dir = kobj_to_scom_chip_dir(kobj);
+	u64 reg, reg_cnt, *buf64;
+	scom_map_t map;
+	int rc;
+
+	if (off & 7 || count & 7)
+		return -EINVAL;
+	reg = off >> 3;
+	reg_cnt = count >> 3;
+
+	map = scom_map(dir->devnode, reg, reg_cnt);
+	if (!scom_map_ok(map))
+		return -EINVAL;
+
+	buf64 = (u64 *)buf;
+	for (reg = 0; reg < reg_cnt; reg++) {
+		rc = scom_write(map, reg,  *(buf64++));
+		if (rc) {
+			count = rc;
+			break;
+		}
+	}
+	scom_unmap(map);
+	return count;
 }
-DEFINE_SIMPLE_ATTRIBUTE(scom_val_fops, scom_val_get, scom_val_set,
-			"0x%llx\n");
 
-static int scom_debug_init_one(struct dentry *root, struct device_node *dn,
-			       int i)
+static struct bin_attribute scom_access_attr = {
+	.attr =	{
+		.name = "access",
+		.mode = S_IRUSR | S_IWUSR,
+	},
+	.size = 0,
+	.read = scom_sysfs_read,
+	.write = scom_sysfs_write,
+};
+
+static int scom_sysfs_init_chip(struct kobject *root, struct device_node *dn,
+				int index)
 {
-	struct scom_debug_entry *ent;
-	struct dentry *dir;
+	struct scom_chip_dir *dir;
+	int rc;
 
-	ent = kzalloc(sizeof(*ent), GFP_KERNEL);
-	if (!ent)
+	dir = kzalloc(sizeof(*dir), GFP_KERNEL);
+	if (!dir)
 		return -ENOMEM;
-
-	ent->dn = of_node_get(dn);
-	ent->map = SCOM_MAP_INVALID;
-	spin_lock_init(&ent->lock);
-	snprintf(ent->name, 8, "scom%d", i);
-	ent->blob.data = (void*) dn->full_name;
-	ent->blob.size = strlen(dn->full_name);
-
-	dir = debugfs_create_dir(ent->name, root);
-	if (!dir) {
-		of_node_put(dn);
-		kfree(ent);
-		return -1;
+	dir->devnode = of_node_get(dn);
+
+	rc = kobject_init_and_add(&dir->kobj, &scom_dir_type,
+				  root, "%08x", index);
+	if (rc) {
+		pr_err("scom: Failed to create kobj for %s, err %d\n",
+		       dn->full_name, rc);
+		return rc;
 	}
 
-	debugfs_create_file("addr", 0600, dir, ent, &scom_addr_fops);
-	debugfs_create_file("value", 0600, dir, ent, &scom_val_fops);
-	debugfs_create_blob("devspec", 0400, dir, &ent->blob);
+	rc = sysfs_create_bin_file(&dir->kobj, &scom_access_attr);
+	if (rc) {
+		pr_err("scom: Failed to create access file for %s, err %d\n",
+		       dn->full_name, rc);
+		return rc;
+	}
 
 	return 0;
 }
 
-static int scom_debug_init(void)
+static int scom_sysfs_init(void)
 {
 	struct device_node *dn;
-	struct dentry *root;
-	int i, rc;
+	struct kobject *root = NULL;
+	int i;
 
-	root = debugfs_create_dir("scom", powerpc_debugfs_root);
-	if (!root)
-		return -1;
-
-	i = rc = 0;
+	i = 0;
 	for_each_node_with_property(dn, "scom-controller") {
 		int id = of_get_ibm_chip_id(dn);
 		if (id == -1)
 			id = i;
-		rc |= scom_debug_init_one(root, dn, id);
+		if (!root)
+			root = kobject_create_and_add("scom", firmware_kobj);
+		if (!root) {
+			pr_err("scom: Failed to create sysfs root\n");
+			return -ENOMEM;
+		}
+		scom_sysfs_init_chip(root, dn, id);
 		i++;
 	}
-
-	return rc;
+	return 0;
 }
-device_initcall(scom_debug_init);
-#endif /* CONFIG_SCOM_DEBUGFS */
+subsys_initcall(scom_sysfs_init);
+
+#endif /* CONFIG_SCOM_SYSFS */
