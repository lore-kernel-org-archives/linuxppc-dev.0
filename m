Return-Path: <nfont@austin.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9FFB0B7BEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 07:15:42 +1000 (EST)
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2FB45DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Sep 2009 07:15:41 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8BL9iGq008791
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 15:09:44 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8BLFdXJ249636
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 15:15:39 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8BLFdeL013032
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 15:15:39 -0600
Message-ID: <4AAABDF5.4090604@austin.ibm.com>
Date: Fri, 11 Sep 2009 16:15:33 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] kernel handling of CPU DLPAR
References: <4AAABC55.4070207@austin.ibm.com>
In-Reply-To: <4AAABC55.4070207@austin.ibm.com>
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

Index: powerpc/arch/powerpc/platforms/pseries/dlpar.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/dlpar.c	2009-09-11 13:05:23.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/dlpar.c	2009-09-11 14:10:28.000000000 -0500
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
@@ -558,8 +559,79 @@
 	return rc ? -1 : count;
 }
 
+static ssize_t cpu_probe_store(struct class *class, const char *buf,
+			       size_t count)
+{
+	struct device_node *dn;
+	u32 drc_index;
+	char *cpu_name;
+	int rc;
+
+	drc_index = simple_strtoull(buf, NULL, 0);
+	if (!drc_index)
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
+	return rc? rc : count;
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
@@ -576,6 +648,18 @@
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
 __initcall(pseries_dlpar_init);
