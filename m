Return-Path: <nfont@austin.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2E7DB7BCD
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 01:46:23 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9LEgInh007873
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 10:42:18 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9LEkKoW164424
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 10:46:20 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9LEjul7032484
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 10:45:56 -0400
Message-ID: <4ADF1EB7.2090709@austin.ibm.com>
Date: Wed, 21 Oct 2009 09:46:15 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/5 v4] Kernel Handling of memory DLPAR
References: <4ADF1C49.2030201@austin.ibm.com>
In-Reply-To: <4ADF1C49.2030201@austin.ibm.com>
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

Signed-off-by: Nathan Fontenot <nfont at austin.ibm.com>
---

Index: powerpc/arch/powerpc/platforms/pseries/dlpar.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/dlpar.c	2009-10-19 11:59:10.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/dlpar.c	2009-10-19 11:59:43.000000000 -0500
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
@@ -404,11 +408,186 @@
 	return 0;
 }
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+
+static struct property *clone_property(struct property *old_prop)
+{
+	struct property *new_prop;
+
+	new_prop = kzalloc((sizeof *new_prop), GFP_KERNEL);
+	if (!new_prop)
+		return NULL;
+
+	new_prop->name = kstrdup(old_prop->name, GFP_KERNEL);
+	new_prop->value = kzalloc(old_prop->length + 1, GFP_KERNEL);
+	if (!new_prop->name || !new_prop->value) {
+		free_property(new_prop);
+		return NULL;
+	}
+
+	memcpy(new_prop->value, old_prop->value, old_prop->length);
+	new_prop->length = old_prop->length;
+
+	return new_prop;
+}
+
+int platform_probe_memory(u64 phys_addr)
+{
+	struct device_node *dn = NULL;
+	struct property *new_prop;
+	struct property *old_prop;
+	struct of_drconf_cell *drmem;
+	const u64 *lmb_size;
+	int num_entries, i;
+	int rc = -EINVAL;
+
+	if (!phys_addr)
+		goto memory_probe_exit;
+
+	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!dn)
+		goto memory_probe_exit;
+
+	lmb_size = of_get_property(dn, "ibm,lmb-size", NULL);
+	if (!lmb_size)
+		goto memory_probe_exit;
+
+	old_prop = of_find_property(dn, "ibm,dynamic-memory", NULL);
+	if (!old_prop)
+		goto memory_probe_exit;
+
+	num_entries = *(u32 *)old_prop->value;
+	drmem = (struct of_drconf_cell *)
+				((char *)old_prop->value + sizeof(u32));
+
+	for (i = 0; i < num_entries; i++) {
+		u64 lmb_end_addr = drmem[i].base_addr + *lmb_size;
+		if (phys_addr >= drmem[i].base_addr
+		    && phys_addr < lmb_end_addr)
+			break;
+	}
+
+	if (i >= num_entries)
+		goto memory_probe_exit;
+
+	if (drmem[i].flags & DRCONF_MEM_ASSIGNED) {
+		/* This lmb is already adssigned to the system, nothing to do */
+		rc = 0;
+		goto memory_probe_exit;
+	}
+
+	rc = acquire_drc(drmem[i].drc_index);
+	if (rc) {
+		rc = -EINVAL;
+		goto memory_probe_exit;
+	}
+
+	new_prop = clone_property(old_prop);
+	drmem = (struct of_drconf_cell *)
+				((char *)new_prop->value + sizeof(u32));
+
+	drmem[i].flags |= DRCONF_MEM_ASSIGNED;
+	rc = prom_update_property(dn, new_prop, old_prop);
+	if (rc) {
+		free_property(new_prop);
+		rc = -EINVAL;
+		goto memory_probe_exit;
+	}
+
+	rc = blocking_notifier_call_chain(&pSeries_reconfig_chain,
+					  PSERIES_DRCONF_MEM_ADD,
+					  &drmem[i].base_addr);
+	if (rc == NOTIFY_BAD) {
+		prom_update_property(dn, old_prop, new_prop);
+		release_drc(drmem[i].drc_index);
+		rc = -EINVAL;
+	} else
+		rc = 0;
+
+memory_probe_exit:
+	of_node_put(dn);
+	return rc;
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
+	int i;
+	int rc = -EINVAL;
+
+	rc = strict_strtoul(buf, 0, &drc_index);
+	if (rc)
+		return rc;
+
+	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!dn)
+		return rc;
+
+	old_prop = of_find_property(dn, "ibm,dynamic-memory", NULL);
+	if (!old_prop)
+		goto memory_release_exit;
+
+	num_entries = *(u32 *)old_prop->value;
+	drmem = (struct of_drconf_cell *)
+				((char *)old_prop->value + sizeof(u32));
+
+	for (i = 0; i < num_entries; i++) {
+		if (drmem[i].drc_index == drc_index)
+			break;
+	}
+
+	if (i >= num_entries)
+		goto memory_release_exit;
+
+	new_prop = clone_property(old_prop);
+	drmem = (struct of_drconf_cell *)
+				((char *)new_prop->value + sizeof(u32));
+
+	drmem[i].flags &= ~DRCONF_MEM_ASSIGNED;
+	rc = prom_update_property(dn, new_prop, old_prop);
+	if (rc) {
+		free_property(new_prop);
+		rc = -EINVAL;
+		goto memory_release_exit;
+	}
+
+	rc = blocking_notifier_call_chain(&pSeries_reconfig_chain,
+					  PSERIES_DRCONF_MEM_REMOVE,
+					  &drmem[i].base_addr);
+	if (rc != NOTIFY_BAD)
+		rc = release_drc(drc_index);
+
+	if (rc) {
+		prom_update_property(dn, old_prop, new_prop);
+		rc = -EINVAL;
+	}
+
+memory_release_exit:
+	of_node_put(dn);
+	return rc ? rc : count;
+}
+
+static struct class_attribute class_attr_mem_release =
+			__ATTR(release, S_IWUSR, NULL, memory_release_store);
+#endif
+
 static int pseries_dlpar_init(void)
 {
 	if (!machine_is(pseries))
 		return 0;
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+	if (sysfs_create_file(&memory_sysdev_class.kset.kobj,
+			      &class_attr_mem_release.attr))
+		printk(KERN_INFO "DLPAR: Could not create sysfs memory "
+		       "release file\n");
+#endif
+
 	return 0;
 }
 device_initcall(pseries_dlpar_init);
Index: powerpc/arch/powerpc/mm/mem.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/mem.c	2009-10-19 11:58:38.000000000 -0500
+++ powerpc/arch/powerpc/mm/mem.c	2009-10-19 11:59:43.000000000 -0500
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
