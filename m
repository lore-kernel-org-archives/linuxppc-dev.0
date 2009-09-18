Return-Path: <nfont@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4EB93B7B93
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Sep 2009 01:04:27 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8IEvCAC030577
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 10:57:12 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8IF4Ojp253412
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 11:04:24 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8IF4Odl002602
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 11:04:24 -0400
Message-ID: <4AB3A172.4090601@austin.ibm.com>
Date: Fri, 18 Sep 2009 10:04:18 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5 v2] kernel handling of CPU DLPAR
References: <4AB39FB3.1020608@austin.ibm.com>
In-Reply-To: <4AB39FB3.1020608@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds the capability to DLPAR add and remove CPUs from the kernel. The
creates two new files /sys/devices/system/cpu/probe and
/sys/devices/system/cpu/release to handle the DLPAR addition and removal of
CPUs respectively.

CPU DLPAR add is accomplished by writing the drc-index of the CPU to the
probe file, and removal is done by writing the device-tree path of the cpu
to the release file.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: powerpc/arch/powerpc/platforms/pseries/dlpar.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/dlpar.c	2009-09-17 11:33:00.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/dlpar.c	2009-09-17 11:33:06.000000000 -0500
@@ -1,11 +1,11 @@
 /*
- * dlpar.c - support for dynamic reconfiguration (including PCI
- * Hotplug and Dynamic Logical Partitioning on RPA platforms).
+ * dlpar.c - support for dynamic reconfiguration (including PCI,
+ * Memory, and CPU Hotplug and Dynamic Logical Partitioning on
+ * PAPR platforms).
  *
  * Copyright (C) 2009 Nathan Fontenot
  * Copyright (C) 2009 IBM Corporation
  *
- *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License version
  * 2 as published by the Free Software Foundation.
@@ -19,6 +19,7 @@
 #include <linux/memory_hotplug.h>
 #include <linux/sysdev.h>
 #include <linux/sysfs.h>
+#include <linux/cpu.h>
 
 
 #include <asm/prom.h>
@@ -551,8 +552,85 @@
 	return rc ? -1 : count;
 }
 
+static ssize_t cpu_probe_store(struct class *class, const char *buf,
+			       size_t count)
+{
+	struct device_node *dn;
+	unsigned long drc_index;
+	char *cpu_name;
+	int rc;
+
+	rc = strict_strtoul(buf, 0, &drc_index);
+	if (rc)
+		return -EINVAL;
+
+	rc = acquire_drc(drc_index);
+	if (rc)
+		return rc;
+
+	dn = configure_connector(drc_index);
+	if (!dn) {
+		release_drc(drc_index);
+		return rc;
+	}
+
+	/* fixup dn name */
+	cpu_name = kzalloc(strlen(dn->full_name) + strlen("/cpus/") + 1,
+			   GFP_KERNEL);
+	if (!cpu_name) {
+		free_cc_nodes(dn);
+		release_drc(drc_index);
+		return -ENOMEM;
+	}
+
+	sprintf(cpu_name, "/cpus/%s", dn->full_name);
+	kfree(dn->full_name);
+	dn->full_name = cpu_name;
+
+	rc = add_device_tree_nodes(dn);
+	if (rc)
+		release_drc(drc_index);
+
+	return rc ? rc : count;
+}
+
+static ssize_t cpu_release_store(struct class *class, const char *buf,
+				 size_t count)
+{
+	struct device_node *dn;
+	u32 *drc_index;
+	int rc;
+
+	dn = of_find_node_by_path(buf);
+	if (!dn)
+		return -EINVAL;
+
+	drc_index = (u32 *)of_get_property(dn, "ibm,my-drc-index", NULL);
+	if (!drc_index) {
+		of_node_put(dn);
+		return -EINVAL;
+	}
+
+	rc = release_drc(*drc_index);
+	if (rc) {
+		of_node_put(dn);
+		return rc;
+	}
+
+	rc = remove_device_tree_nodes(dn);
+	if (rc)
+		acquire_drc(*drc_index);
+
+	of_node_put(dn);
+	return rc ? rc : count;
+}
+
 static struct class_attribute class_attr_mem_release =
 			__ATTR(release, S_IWUSR, NULL, memory_release_store);
+static struct class_attribute class_attr_cpu_probe =
+			__ATTR(probe, S_IWUSR, NULL, cpu_probe_store);
+static struct class_attribute class_attr_cpu_release =
+			__ATTR(release, S_IWUSR, NULL, cpu_release_store);
 
 static int pseries_dlpar_init(void)
 {
@@ -567,6 +645,18 @@
 		printk(KERN_INFO "DLPAR: Could not create sysfs memory "
 		       "release file\n");
 
+	rc = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
+			       &class_attr_cpu_probe.attr);
+	if (rc)
+		printk(KERN_INFO "DLPAR: Could not create sysfs cpu "
+		       "probe file\n");
+
+	rc = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
+			       &class_attr_cpu_release.attr);
+	if (rc)
+		printk(KERN_INFO "DLPAR: Could not create sysfs cpu "
+		       "release file\n");
+
 	return 0;
 }
 device_initcall(pseries_dlpar_init);
