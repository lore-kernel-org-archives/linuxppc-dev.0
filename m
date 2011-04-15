Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <df0bb549cf8acc08daf01beb7bc603a4ef6921ee.1302856271.git.michael@ellerman.id.au>
In-Reply-To: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
Subject: [PATCH 03/15] powerpc: Add SCOM infrastructure
Date: Fri, 15 Apr 2011 18:31:58 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: Jimi Xenidis <jimix@watson.ibm.com>, jack@codezen.org, imunsie@au.ibm.com,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

SCOM is a side-band configuration bus implemented on some processors.
This code provides a way for code to map and operate on devices via
SCOM, while the details of how that is implemented is left up to a
SCOM "controller" in the platform code.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/scom.h |  156 +++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/Kconfig     |    7 ++
 arch/powerpc/sysdev/Makefile    |    2 +
 arch/powerpc/sysdev/scom.c      |  192 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 357 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/scom.h b/arch/powerpc/include/asm/scom.h
new file mode 100644
index 0000000..0cabfd7
--- /dev/null
+++ b/arch/powerpc/include/asm/scom.h
@@ -0,0 +1,156 @@
+/*
+ * Copyright 2010 Benjamin Herrenschmidt, IBM Corp
+ *                <benh@kernel.crashing.org>
+ *     and        David Gibson, IBM Corporation.
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef _ASM_POWERPC_SCOM_H
+#define _ASM_POWERPC_SCOM_H
+
+#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_PPC_SCOM
+
+/*
+ * The SCOM bus is a sideband bus used for accessing various internal
+ * registers of the processor or the chipset. The implementation details
+ * differ between processors and platforms, and the access method as
+ * well.
+ *
+ * This API allows to "map" ranges of SCOM register numbers associated
+ * with a given SCOM controller. The later must be represented by a
+ * device node, though some implementations might support NULL if there
+ * is no possible ambiguity
+ *
+ * Then, scom_read/scom_write can be used to accesses registers inside
+ * that range. The argument passed is a register number relative to
+ * the beginning of the range mapped.
+ */
+
+typedef void *scom_map_t;
+
+/* Value for an invalid SCOM map */
+#define SCOM_MAP_INVALID	(NULL)
+
+/* The scom_controller data structure is what the platform passes
+ * to the core code in scom_init, it provides the actual implementation
+ * of all the SCOM functions
+ */
+struct scom_controller {
+	scom_map_t (*map)(struct device_node *ctrl_dev, u64 reg, u64 count);
+	void (*unmap)(scom_map_t map);
+
+	u64 (*read)(scom_map_t map, u32 reg);
+	void (*write)(scom_map_t map, u32 reg, u64 value);
+};
+
+extern const struct scom_controller *scom_controller;
+
+/**
+ * scom_init - Initialize the SCOM backend, called by the platform
+ * @controller: The platform SCOM controller
+ */
+static inline void scom_init(const struct scom_controller *controller)
+{
+	scom_controller = controller;
+}
+
+/**
+ * scom_map_ok - Test is a SCOM mapping is successful
+ * @map: The result of scom_map to test
+ */
+static inline int scom_map_ok(scom_map_t map)
+{
+	return map != SCOM_MAP_INVALID;
+}
+
+/**
+ * scom_map - Map a block of SCOM registers
+ * @ctrl_dev: Device node of the SCOM controller
+ *            some implementations allow NULL here
+ * @reg: first SCOM register to map
+ * @count: Number of SCOM registers to map
+ */
+
+static inline scom_map_t scom_map(struct device_node *ctrl_dev,
+				  u64 reg, u64 count)
+{
+	return scom_controller->map(ctrl_dev, reg, count);
+}
+
+/**
+ * scom_find_parent - Find the SCOM controller for a device
+ * @dev: OF node of the device
+ *
+ * This is not meant for general usage, but in combination with
+ * scom_map() allows to map registers not represented by the
+ * device own scom-reg property. Useful for applying HW workarounds
+ * on things not properly represented in the device-tree for example.
+ */
+struct device_node *scom_find_parent(struct device_node *dev);
+
+
+/**
+ * scom_map_device - Map a device's block of SCOM registers
+ * @dev: OF node of the device
+ * @index: Register bank index (index in "scom-reg" property)
+ *
+ * This function will use the device-tree binding for SCOM which
+ * is to follow "scom-parent" properties until it finds a node with
+ * a "scom-controller" property to find the controller. It will then
+ * use the "scom-reg" property which is made of reg/count pairs,
+ * each of them having a size defined by the controller's #scom-cells
+ * property
+ */
+extern scom_map_t scom_map_device(struct device_node *dev, int index);
+
+
+/**
+ * scom_unmap - Unmap a block of SCOM registers
+ * @map: Result of scom_map is to be unmapped
+ */
+static inline void scom_unmap(scom_map_t map)
+{
+	if (scom_map_ok(map))
+		scom_controller->unmap(map);
+}
+
+/**
+ * scom_read - Read a SCOM register
+ * @map: Result of scom_map
+ * @reg: Register index within that map
+ */
+static inline u64 scom_read(scom_map_t map, u32 reg)
+{
+	return scom_controller->read(map, reg);
+}
+
+/**
+ * scom_write - Write to a SCOM register
+ * @map: Result of scom_map
+ * @reg: Register index within that map
+ * @value: Value to write
+ */
+static inline void scom_write(scom_map_t map, u32 reg, u64 value)
+{
+	scom_controller->write(map, reg, value);
+}
+
+#endif /* CONFIG_PPC_SCOM */
+#endif /* __ASSEMBLY__ */
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_SCOM_H */
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index cfc1877..d775fd1 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -15,3 +15,10 @@ config PPC_MSI_BITMAP
 
 source "arch/powerpc/sysdev/xics/Kconfig"
 
+config PPC_SCOM
+	bool
+
+config SCOM_DEBUGFS
+	bool "Expose SCOM controllers via debugfs"
+	depends on PPC_SCOM
+	default n
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 9516e75..6076e00 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -58,6 +58,8 @@ ifeq ($(CONFIG_SUSPEND),y)
 obj-$(CONFIG_6xx)		+= 6xx-suspend.o
 endif
 
+obj-$(CONFIG_PPC_SCOM)		+= scom.o
+
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 obj-$(CONFIG_PPC_XICS)		+= xics/
diff --git a/arch/powerpc/sysdev/scom.c b/arch/powerpc/sysdev/scom.c
new file mode 100644
index 0000000..b2593ce
--- /dev/null
+++ b/arch/powerpc/sysdev/scom.c
@@ -0,0 +1,192 @@
+/*
+ * Copyright 2010 Benjamin Herrenschmidt, IBM Corp
+ *                <benh@kernel.crashing.org>
+ *     and        David Gibson, IBM Corporation.
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/debugfs.h>
+#include <linux/slab.h>
+#include <asm/prom.h>
+#include <asm/scom.h>
+
+const struct scom_controller *scom_controller;
+EXPORT_SYMBOL_GPL(scom_controller);
+
+struct device_node *scom_find_parent(struct device_node *node)
+{
+	struct device_node *par, *tmp;
+	const u32 *p;
+
+	for (par = of_node_get(node); par;) {
+		if (of_get_property(par, "scom-controller", NULL))
+			break;
+		p = of_get_property(par, "scom-parent", NULL);
+		tmp = par;
+		if (p == NULL)
+			par = of_get_parent(par);
+		else
+			par = of_find_node_by_phandle(*p);
+		of_node_put(tmp);
+	}
+	return par;
+}
+EXPORT_SYMBOL_GPL(scom_find_parent);
+
+scom_map_t scom_map_device(struct device_node *dev, int index)
+{
+	struct device_node *parent;
+	unsigned int cells, size;
+	const u32 *prop;
+	u64 reg, cnt;
+	scom_map_t ret;
+
+	parent = scom_find_parent(dev);
+
+	if (parent == NULL)
+		return 0;
+
+	prop = of_get_property(parent, "#scom-cells", NULL);
+	cells = prop ? *prop : 1;
+
+	prop = of_get_property(dev, "scom-reg", &size);
+	if (!prop)
+		return 0;
+	size >>= 2;
+
+	if (index >= (size / (2*cells)))
+		return 0;
+
+	reg = of_read_number(&prop[index * cells * 2], cells);
+	cnt = of_read_number(&prop[index * cells * 2 + cells], cells);
+
+	ret = scom_map(parent, reg, cnt);
+	of_node_put(parent);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(scom_map_device);
+
+#ifdef CONFIG_SCOM_DEBUGFS
+struct scom_debug_entry {
+	struct device_node *dn;
+	unsigned long addr;
+	scom_map_t map;
+	spinlock_t lock;
+	char name[8];
+	struct debugfs_blob_wrapper blob;
+};
+
+static int scom_addr_set(void *data, u64 val)
+{
+	struct scom_debug_entry *ent = data;
+
+	ent->addr = 0;
+	scom_unmap(ent->map);
+
+	ent->map = scom_map(ent->dn, val, 1);
+	if (scom_map_ok(ent->map))
+		ent->addr = val;
+	else
+		return -EFAULT;
+
+	return 0;
+}
+
+static int scom_addr_get(void *data, u64 *val)
+{
+	struct scom_debug_entry *ent = data;
+	*val = ent->addr;
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(scom_addr_fops, scom_addr_get, scom_addr_set,
+			"0x%llx\n");
+
+static int scom_val_set(void *data, u64 val)
+{
+	struct scom_debug_entry *ent = data;
+
+	if (!scom_map_ok(ent->map))
+		return -EFAULT;
+
+	scom_write(ent->map, 0, val);
+
+	return 0;
+}
+
+static int scom_val_get(void *data, u64 *val)
+{
+	struct scom_debug_entry *ent = data;
+
+	if (!scom_map_ok(ent->map))
+		return -EFAULT;
+
+	*val = scom_read(ent->map, 0);
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(scom_val_fops, scom_val_get, scom_val_set,
+			"0x%llx\n");
+
+static int scom_debug_init_one(struct dentry *root, struct device_node *dn,
+			       int i)
+{
+	struct scom_debug_entry *ent;
+	struct dentry *dir;
+
+	ent = kzalloc(sizeof(*ent), GFP_KERNEL);
+	if (!ent)
+		return -ENOMEM;
+
+	ent->dn = of_node_get(dn);
+	ent->map = SCOM_MAP_INVALID;
+	spin_lock_init(&ent->lock);
+	snprintf(ent->name, 8, "scom%d", i);
+	ent->blob.data = dn->full_name;
+	ent->blob.size = strlen(dn->full_name);
+
+	dir = debugfs_create_dir(ent->name, root);
+	if (!dir) {
+		of_node_put(dn);
+		kfree(ent);
+		return -1;
+	}
+
+	debugfs_create_file("addr", 0600, dir, ent, &scom_addr_fops);
+	debugfs_create_file("value", 0600, dir, ent, &scom_val_fops);
+	debugfs_create_blob("path", 0400, dir, &ent->blob);
+
+	return 0;
+}
+
+static int scom_debug_init(void)
+{
+	struct device_node *dn;
+	struct dentry *root;
+	int i, rc;
+
+	root = debugfs_create_dir("scom", powerpc_debugfs_root);
+	if (!root)
+		return -1;
+
+	i = rc = 0;
+	for_each_node_with_property(dn, "scom-controller")
+		rc |= scom_debug_init_one(root, dn, i++);
+
+	return rc;
+}
+device_initcall(scom_debug_init);
+#endif /* CONFIG_SCOM_DEBUGFS */
-- 
1.7.1
