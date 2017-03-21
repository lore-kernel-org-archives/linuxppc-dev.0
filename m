Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnqQW3FXQzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 10:53:39 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id o126so24172130pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 16:53:39 -0700 (PDT)
Received: from matt.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id a77sm41605992pfl.91.2017.03.21.16.53.35
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Mar 2017 16:53:36 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [v6] powerpc/powernv: add hdat attribute to sysfs
Date: Wed, 22 Mar 2017 10:53:23 +1100
Message-Id: <20170321235323.6314-1-matthew.brown.dev@gmail.com>
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

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
Changelog

v6
	- attribute names are stored locally, removing potential null pointer errors
	- added of_node_put for the corresponding of_find_node
	- folded exports node creation into opal_export_attr()
	- fixed kzalloc flags to GFP_KERNEL
	- fixed struct array indexing
	- fixed error message
---
 arch/powerpc/platforms/powernv/opal.c | 84 +++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2822935..953537e 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -604,6 +604,87 @@ static void opal_export_symmap(void)
 		pr_warn("Error %d creating OPAL symbols file\n", rc);
 }
 
+static ssize_t export_attr_read(struct file *fp, struct kobject *kobj,
+			     struct bin_attribute *bin_attr, char *buf,
+			     loff_t off, size_t count)
+{
+	return memory_read_from_buffer(buf, count, &off, bin_attr->private,
+				       bin_attr->size);
+}
+
+static struct bin_attribute *exported_attrs;
+static char **attr_name;
+/*
+ * opal_export_attrs: creates a sysfs node for each property listed in
+ * the device-tree under /ibm,opal/firmware/exports/
+ * All new sysfs nodes are created under /opal/exports/.
+ * This allows for reserved memory regions (e.g. HDAT) to be read.
+ * The new sysfs nodes are only readable by root.
+ */
+static void opal_export_attrs(void)
+{
+	/* /sys/firmware/opal/exports */
+	struct kobject *opal_export_kobj;
+
+	struct bin_attribute *attr_tmp;
+	const __be64 *syms;
+	unsigned int size;
+	struct device_node *fw;
+	struct property *prop;
+	int rc;
+	int attr_count = 0;
+	int n = 0;
+	
+	/* Create new 'exports' directory */
+	opal_export_kobj = kobject_create_and_add("exports", opal_kobj);
+	if (!opal_export_kobj) {
+		pr_warn("kobject_create_and_add opal_exports failed\n");
+		return;
+	}
+
+	fw = of_find_node_by_path("/ibm,opal/firmware/exports");
+	if (!fw)
+		return;
+
+	for (prop = fw->properties; prop != NULL; prop = prop->next)
+		attr_count++;
+
+	if (attr_count > 2) {
+		exported_attrs = kzalloc(sizeof(exported_attrs)*(attr_count-2),
+				GFP_KERNEL);
+		attr_name = kzalloc(sizeof(char *)*(attr_count-2), GFP_KERNEL);
+	}
+
+	for_each_property_of_node(fw, prop) {
+		
+		attr_name[n] = kstrdup(prop->name, GFP_KERNEL);
+		syms = of_get_property(fw, attr_name[n], &size);
+
+		if (!strcmp(attr_name[n], "name") ||
+				!strcmp(attr_name[n], "phandle"))
+			continue;
+
+		if (!syms || size != 2 * sizeof(__be64))
+			continue;
+
+		attr_tmp = &exported_attrs[n];
+		attr_tmp->attr.name = attr_name[n];
+		attr_tmp->attr.mode = 0400;
+		attr_tmp->read = export_attr_read;
+		attr_tmp->private = __va(be64_to_cpu(syms[0]));
+		attr_tmp->size = be64_to_cpu(syms[1]);
+
+		rc = sysfs_create_bin_file(opal_export_kobj, attr_tmp);
+		if (rc)
+			pr_warn("Error %d creating OPAL sysfs exports/%s file\n",
+					rc, attr_name[n]);
+		n++;
+	}
+
+	of_node_put(fw);
+
+}
+
 static void __init opal_dump_region_init(void)
 {
 	void *addr;
@@ -742,6 +823,9 @@ static int __init opal_init(void)
 		opal_msglog_sysfs_init();
 	}
 
+	/* Export all properties */
+	opal_export_attrs();
+
 	/* Initialize platform devices: IPMI backend, PRD & flash interface */
 	opal_pdev_init("ibm,opal-ipmi");
 	opal_pdev_init("ibm,opal-flash");
-- 
2.9.3
