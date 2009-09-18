Return-Path: <nfont@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 649A9B7B7D
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Sep 2009 01:03:34 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8IEsbVc030348
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 10:54:37 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8IF3VVA247808
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 11:03:31 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8IF3VO5030781
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 11:03:31 -0400
Message-ID: <4AB3A13D.1060405@austin.ibm.com>
Date: Fri, 18 Sep 2009 10:03:25 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/5 v2] kernel handling of memory DLPAR
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

This adds the capability to DLPAR add and remove memory from the kernel.  The
patch extends the powerpc handling of memory_add_physaddr_to_nid(), which is
called from the sysfs memory 'probe' file to first ensure that the memory
has been added to the system.  This is done by creating a platform specific
callout from the routine.  The pseries implementation of this handles the
DLPAR work to add the memory to the system and update the device tree.

The patch also creates a pseries only 'release' sys file,
/sys/devices/system/memory/release.  This file handles the DLPAR release of
memory back to firmware and updating of the device-tree.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: powerpc/arch/powerpc/platforms/pseries/dlpar.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/dlpar.c	2009-09-17 11:32:22.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/dlpar.c	2009-09-17 11:33:00.000000000 -0500
@@ -16,6 +16,10 @@
 #include <linux/notifier.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
+#include <linux/memory_hotplug.h>
+#include <linux/sysdev.h>
+#include <linux/sysfs.h>
+
 
 #include <asm/prom.h>
 #include <asm/machdep.h>
@@ -406,11 +410,163 @@
 	return 0;
 }
 
+static struct property *clone_property(struct property *old_prop)
+{
+	struct property *new_prop;
+
+	new_prop = kzalloc((sizeof *new_prop), GFP_KERNEL);
+	if (!new_prop)
+		return NULL;
+
+	new_prop->name = kzalloc(strlen(old_prop->name) + 1, GFP_KERNEL);
+	new_prop->value = kzalloc(old_prop->length + 1, GFP_KERNEL);
+	if (!new_prop->name || !new_prop->value) {
+		free_property(new_prop);
+		return NULL;
+	}
+
+	strcpy(new_prop->name, old_prop->name);
+	memcpy(new_prop->value, old_prop->value, old_prop->length);
+	new_prop->length = old_prop->length;
+
+	return new_prop;
+}
+
+int platform_probe_memory(u64 phys_addr)
+{
+	struct device_node *dn;
+	struct property *new_prop, *old_prop;
+	struct property *lmb_sz_prop;
+	struct of_drconf_cell *drmem;
+	u64 lmb_size;
+	int num_entries, i, rc;
+
+	if (!phys_addr)
+		return -EINVAL;
+
+	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!dn)
+		return -EINVAL;
+
+	lmb_sz_prop = of_find_property(dn, "ibm,lmb-size", NULL);
+	lmb_size = *(u64 *)lmb_sz_prop->value;
+
+	old_prop = of_find_property(dn, "ibm,dynamic-memory", NULL);
+
+	num_entries = *(u32 *)old_prop->value;
+	drmem = (struct of_drconf_cell *)
+				((char *)old_prop->value + sizeof(u32));
+
+	for (i = 0; i < num_entries; i++) {
+		u64 lmb_end_addr = drmem[i].base_addr + lmb_size;
+		if (phys_addr >= drmem[i].base_addr
+		    && phys_addr < lmb_end_addr)
+			break;
+	}
+
+	if (i >= num_entries) {
+		of_node_put(dn);
+		return -EINVAL;
+	}
+
+	if (drmem[i].flags & DRCONF_MEM_ASSIGNED) {
+		of_node_put(dn);
+		return 0;
+	}
+
+	rc = acquire_drc(drmem[i].drc_index);
+	if (rc) {
+		of_node_put(dn);
+		return -1;
+	}
+
+	new_prop = clone_property(old_prop);
+	drmem = (struct of_drconf_cell *)
+				((char *)new_prop->value + sizeof(u32));
+
+	drmem[i].flags |= DRCONF_MEM_ASSIGNED;
+	prom_update_property(dn, new_prop, old_prop);
+
+	rc = blocking_notifier_call_chain(&pSeries_reconfig_chain,
+					  PSERIES_DRCONF_MEM_ADD,
+					  &drmem[i].base_addr);
+	if (rc == NOTIFY_BAD) {
+		prom_update_property(dn, old_prop, new_prop);
+		release_drc(drmem[i].drc_index);
+	}
+
+	of_node_put(dn);
+	return rc == NOTIFY_BAD ? -1 : 0;
+}
+
+static ssize_t memory_release_store(struct class *class, const char *buf,
+				    size_t count)
+{
+	unsigned long drc_index;
+	struct device_node *dn;
+	struct property *new_prop, *old_prop;
+	struct of_drconf_cell *drmem;
+	int num_entries;
+	int i, rc;
+
+	rc = strict_strtoul(buf, 0, &drc_index);
+	if (rc)
+		return -EINVAL;
+
+	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!dn)
+		return 0;
+
+	old_prop = of_find_property(dn, "ibm,dynamic-memory", NULL);
+	new_prop = clone_property(old_prop);
+
+	num_entries = *(u32 *)new_prop->value;
+	drmem = (struct of_drconf_cell *)
+				((char *)new_prop->value + sizeof(u32));
+
+	for (i = 0; i < num_entries; i++) {
+		if (drmem[i].drc_index == drc_index)
+			break;
+	}
+
+	if (i >= num_entries) {
+		free_property(new_prop);
+		of_node_put(dn);
+		return -EINVAL;
+	}
+
+	drmem[i].flags &= ~DRCONF_MEM_ASSIGNED;
+	prom_update_property(dn, new_prop, old_prop);
+
+	rc = blocking_notifier_call_chain(&pSeries_reconfig_chain,
+					  PSERIES_DRCONF_MEM_REMOVE,
+					  &drmem[i].base_addr);
+	if (rc != NOTIFY_BAD)
+		rc = release_drc(drc_index);
+
+	if (rc)
+		prom_update_property(dn, old_prop, new_prop);
+
+	of_node_put(dn);
+	return rc ? -1 : count;
+}
+
+static struct class_attribute class_attr_mem_release =
+			__ATTR(release, S_IWUSR, NULL, memory_release_store);
+
 static int pseries_dlpar_init(void)
 {
+	int rc;
+
 	if (!machine_is(pseries))
 		return 0;
 
+	rc = sysfs_create_file(&memory_sysdev_class.kset.kobj,
+			       &class_attr_mem_release.attr);
+	if (rc)
+		printk(KERN_INFO "DLPAR: Could not create sysfs memory "
+		       "release file\n");
+
 	return 0;
 }
 device_initcall(pseries_dlpar_init);
Index: powerpc/arch/powerpc/mm/mem.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/mem.c	2009-09-17 11:17:57.000000000 -0500
+++ powerpc/arch/powerpc/mm/mem.c	2009-09-17 11:33:00.000000000 -0500
@@ -111,8 +111,19 @@
 #ifdef CONFIG_MEMORY_HOTPLUG
 
 #ifdef CONFIG_NUMA
+int __attribute ((weak)) platform_probe_memory(u64 start)
+{
+	return 0;
+}
+
 int memory_add_physaddr_to_nid(u64 start)
 {
+	int rc;
+
+	rc = platform_probe_memory(start);
+	if (rc)
+		return rc;
+
 	return hot_add_scn_to_nid(start);
 }
 #endif
