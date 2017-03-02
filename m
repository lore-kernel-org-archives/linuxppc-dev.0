Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYh971X3GzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 16:44:58 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id e66so20727pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 21:44:58 -0800 (PST)
Received: from matt.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id w29sm13902029pfi.131.2017.03.01.21.44.54
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Mar 2017 21:44:55 -0800 (PST)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [Patch v5] powerpc/powernv: add hdat attribute to sysfs
Date: Thu,  2 Mar 2017 16:44:42 +1100
Message-Id: <20170302054442.6533-1-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The HDAT data area is consumed by skiboot and turned into a device-tree.
In some cases we would like to look directly at the HDAT, so this patch
adds a sysfs node to allow it to be viewed.  This is not possible through
/dev/mem as it is reserved memory which is stopped by the /dev/mem filter.
This patch also adds sysfs nodes for all properties in the device-tree 
under /ibm,opal/firmware/exports.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
Changes between v4 and v5:
	- all properties under /ibm,opal/firmware/exports in the device-tree
	  are now added as new sysfs nodes
	- the new sysfs nodes are now placed under /opal/exports
	- added a generic read function for all exported attributes
---
 arch/powerpc/platforms/powernv/opal.c | 84 +++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2822935..fbb8264 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -36,6 +36,9 @@
 /* /sys/firmware/opal */
 struct kobject *opal_kobj;
 
+/* /sys/firmware/opal/exports */
+struct kobject *opal_export_kobj;
+
 struct opal {
 	u64 base;
 	u64 entry;
@@ -604,6 +607,82 @@ static void opal_export_symmap(void)
 		pr_warn("Error %d creating OPAL symbols file\n", rc);
 }
 
+
+static int opal_exports_sysfs_init(void)
+{
+	opal_export_kobj = kobject_create_and_add("exports", opal_kobj);
+	if (!opal_export_kobj) {
+		pr_warn("kobject_create_and_add opal_exports failed\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static ssize_t export_attr_read(struct file *fp, struct kobject *kobj,
+			     struct bin_attribute *bin_attr, char *buf,
+			     loff_t off, size_t count)
+{
+	return memory_read_from_buffer(buf, count, &off, bin_attr->private,
+				       bin_attr->size);
+}
+
+static struct bin_attribute *exported_attrs;
+/*
+ * opal_export_attrs: creates a sysfs node for each property listed in
+ * the device-tree under /ibm,opal/firmware/exports/
+ * All new sysfs nodes are created under /opal/exports/.
+ * This allows for reserved memory regions (e.g. HDAT) to be read.
+ * The new sysfs nodes are only readable by root.
+ */
+static void opal_export_attrs(void)
+{
+	const __be64 *syms;
+	unsigned int size;
+	struct device_node *fw;
+	struct property *prop;
+	int rc;
+	int attr_count = 0;
+	int n = 0;
+
+	fw = of_find_node_by_path("/ibm,opal/firmware/exports");
+	if (!fw)
+		return;
+
+	for (prop = fw->properties; prop != NULL; prop = prop->next)
+		attr_count++;
+
+	if (attr_count > 2)
+		exported_attrs = kmalloc(sizeof(exported_attrs)*(attr_count-2),
+				__GFP_IO | __GFP_FS);
+
+
+	for_each_property_of_node(fw, prop) {
+
+		syms = of_get_property(fw, prop->name, &size);
+
+		if (!strcmp(prop->name, "name") ||
+				!strcmp(prop->name, "phandle"))
+			continue;
+
+		if (!syms || size != 2 * sizeof(__be64))
+			continue;
+
+		(exported_attrs+n)->attr.name = prop->name;
+		(exported_attrs+n)->attr.mode = 0400;
+		(exported_attrs+n)->read = export_attr_read;
+		(exported_attrs+n)->private = __va(be64_to_cpu(syms[0]));
+		(exported_attrs+n)->size = be64_to_cpu(syms[1]);
+
+		rc = sysfs_create_bin_file(opal_export_kobj, exported_attrs+n);
+		if (rc)
+			pr_warn("Error %d creating OPAL %s file\n", rc,
+				prop->name);
+		n++;
+	}
+
+}
+
 static void __init opal_dump_region_init(void)
 {
 	void *addr;
@@ -742,6 +821,11 @@ static int __init opal_init(void)
 		opal_msglog_sysfs_init();
 	}
 
+	rc = opal_exports_sysfs_init();
+	if (rc == 0) {
+		/* Export all properties */
+		opal_export_attrs();
+	}
 	/* Initialize platform devices: IPMI backend, PRD & flash interface */
 	opal_pdev_init("ibm,opal-ipmi");
 	opal_pdev_init("ibm,opal-flash");
-- 
2.9.3
