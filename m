Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69D7E1A0318
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 07:50:28 +1100 (AEDT)
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 16 Dec 2015 15:50:25 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBGKoNFG27656444
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 20:50:23 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBGKoM7d005673
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 15:50:23 -0500
Received: from [9.41.105.164] ([9.41.105.164])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 tBGKoLtL005582
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 15:50:22 -0500
Subject: [PATCH v3 1/6] powerpc/pseries: Consolidate CPU hotplug code to
 hotplug-cpu.c
To: linuxppc-dev@lists.ozlabs.org
References: <5671CD8A.8000500@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <5671CE8D.304@linux.vnet.ibm.com>
Date: Wed, 16 Dec 2015 14:50:21 -0600
MIME-Version: 1.0
In-Reply-To: <5671CD8A.8000500@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No functional changes, this patch is simply a move of the cpu hotplug
code from pseries/dlpar.c to pseries/hotplug-cpu.c. This is in an effort
to consolidate all of the cpu hotplug code in a common place.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c       |  226 --------------------------
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  218 +++++++++++++++++++++++++
 2 files changed, 219 insertions(+), 225 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index fe6320d..438fdbd 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -20,7 +20,6 @@
 #include <linux/of.h>
 
 #include "of_helpers.h"
-#include "offline_states.h"
 #include "pseries.h"
 
 #include <asm/prom.h>
@@ -338,220 +337,6 @@ int dlpar_release_drc(u32 drc_index)
 	return 0;
 }
 
-#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
-
-static int dlpar_online_cpu(struct device_node *dn)
-{
-	int rc = 0;
-	unsigned int cpu;
-	int len, nthreads, i;
-	const __be32 *intserv;
-	u32 thread;
-
-	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
-	if (!intserv)
-		return -EINVAL;
-
-	nthreads = len / sizeof(u32);
-
-	cpu_maps_update_begin();
-	for (i = 0; i < nthreads; i++) {
-		thread = be32_to_cpu(intserv[i]);
-		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != thread)
-				continue;
-			BUG_ON(get_cpu_current_state(cpu)
-					!= CPU_STATE_OFFLINE);
-			cpu_maps_update_done();
-			rc = device_online(get_cpu_device(cpu));
-			if (rc)
-				goto out;
-			cpu_maps_update_begin();
-
-			break;
-		}
-		if (cpu == num_possible_cpus())
-			printk(KERN_WARNING "Could not find cpu to online "
-			       "with physical id 0x%x\n", thread);
-	}
-	cpu_maps_update_done();
-
-out:
-	return rc;
-
-}
-
-static bool dlpar_cpu_exists(struct device_node *parent, u32 drc_index)
-{
-	struct device_node *child = NULL;
-	u32 my_drc_index;
-	bool found;
-	int rc;
-
-	/* Assume cpu doesn't exist */
-	found = false;
-
-	for_each_child_of_node(parent, child) {
-		rc = of_property_read_u32(child, "ibm,my-drc-index",
-					  &my_drc_index);
-		if (rc)
-			continue;
-
-		if (my_drc_index == drc_index) {
-			of_node_put(child);
-			found = true;
-			break;
-		}
-	}
-
-	return found;
-}
-
-static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
-{
-	struct device_node *dn, *parent;
-	u32 drc_index;
-	int rc;
-
-	rc = kstrtou32(buf, 0, &drc_index);
-	if (rc)
-		return -EINVAL;
-
-	parent = of_find_node_by_path("/cpus");
-	if (!parent)
-		return -ENODEV;
-
-	if (dlpar_cpu_exists(parent, drc_index)) {
-		of_node_put(parent);
-		printk(KERN_WARNING "CPU with drc index %x already exists\n",
-		       drc_index);
-		return -EINVAL;
-	}
-
-	rc = dlpar_acquire_drc(drc_index);
-	if (rc) {
-		of_node_put(parent);
-		return -EINVAL;
-	}
-
-	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
-	of_node_put(parent);
-	if (!dn) {
-		dlpar_release_drc(drc_index);
-		return -EINVAL;
-	}
-
-	rc = dlpar_attach_node(dn);
-	if (rc) {
-		dlpar_release_drc(drc_index);
-		dlpar_free_cc_nodes(dn);
-		return rc;
-	}
-
-	rc = dlpar_online_cpu(dn);
-	if (rc)
-		return rc;
-
-	return count;
-}
-
-static int dlpar_offline_cpu(struct device_node *dn)
-{
-	int rc = 0;
-	unsigned int cpu;
-	int len, nthreads, i;
-	const __be32 *intserv;
-	u32 thread;
-
-	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
-	if (!intserv)
-		return -EINVAL;
-
-	nthreads = len / sizeof(u32);
-
-	cpu_maps_update_begin();
-	for (i = 0; i < nthreads; i++) {
-		thread = be32_to_cpu(intserv[i]);
-		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != thread)
-				continue;
-
-			if (get_cpu_current_state(cpu) == CPU_STATE_OFFLINE)
-				break;
-
-			if (get_cpu_current_state(cpu) == CPU_STATE_ONLINE) {
-				set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
-				cpu_maps_update_done();
-				rc = device_offline(get_cpu_device(cpu));
-				if (rc)
-					goto out;
-				cpu_maps_update_begin();
-				break;
-
-			}
-
-			/*
-			 * The cpu is in CPU_STATE_INACTIVE.
-			 * Upgrade it's state to CPU_STATE_OFFLINE.
-			 */
-			set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
-			BUG_ON(plpar_hcall_norets(H_PROD, thread)
-								!= H_SUCCESS);
-			__cpu_die(cpu);
-			break;
-		}
-		if (cpu == num_possible_cpus())
-			printk(KERN_WARNING "Could not find cpu to offline "
-			       "with physical id 0x%x\n", thread);
-	}
-	cpu_maps_update_done();
-
-out:
-	return rc;
-
-}
-
-static ssize_t dlpar_cpu_release(const char *buf, size_t count)
-{
-	struct device_node *dn;
-	u32 drc_index;
-	int rc;
-
-	dn = of_find_node_by_path(buf);
-	if (!dn)
-		return -EINVAL;
-
-	rc = of_property_read_u32(dn, "ibm,my-drc-index", &drc_index);
-	if (rc) {
-		of_node_put(dn);
-		return -EINVAL;
-	}
-
-	rc = dlpar_offline_cpu(dn);
-	if (rc) {
-		of_node_put(dn);
-		return -EINVAL;
-	}
-
-	rc = dlpar_release_drc(drc_index);
-	if (rc) {
-		of_node_put(dn);
-		return rc;
-	}
-
-	rc = dlpar_detach_node(dn);
-	if (rc) {
-		dlpar_acquire_drc(drc_index);
-		return rc;
-	}
-
-	of_node_put(dn);
-
-	return count;
-}
-
-#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
-
 static int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
 {
 	int rc;
@@ -659,16 +444,7 @@ static CLASS_ATTR(dlpar, S_IWUSR, NULL, dlpar_store);
 
 static int __init pseries_dlpar_init(void)
 {
-	int rc;
-
-#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
-	ppc_md.cpu_probe = dlpar_cpu_probe;
-	ppc_md.cpu_release = dlpar_cpu_release;
-#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
-
-	rc = sysfs_create_file(kernel_kobj, &class_attr_dlpar.attr);
-
-	return rc;
+	return sysfs_create_file(kernel_kobj, &class_attr_dlpar.attr);
 }
 machine_device_initcall(pseries, pseries_dlpar_init);
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 6247544..10c2942 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -32,6 +32,7 @@
 #include <asm/xics.h>
 #include <asm/plpar_wrappers.h>
 
+#include "pseries.h"
 #include "offline_states.h"
 
 /* This version can't take the spinlock, because it never returns */
@@ -339,6 +340,218 @@ static void pseries_remove_processor(struct device_node *np)
 	cpu_maps_update_done();
 }
 
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
+
+static int dlpar_online_cpu(struct device_node *dn)
+{
+	int rc = 0;
+	unsigned int cpu;
+	int len, nthreads, i;
+	const __be32 *intserv;
+	u32 thread;
+
+	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
+	if (!intserv)
+		return -EINVAL;
+
+	nthreads = len / sizeof(u32);
+
+	cpu_maps_update_begin();
+	for (i = 0; i < nthreads; i++) {
+		thread = be32_to_cpu(intserv[i]);
+		for_each_present_cpu(cpu) {
+			if (get_hard_smp_processor_id(cpu) != thread)
+				continue;
+			BUG_ON(get_cpu_current_state(cpu)
+					!= CPU_STATE_OFFLINE);
+			cpu_maps_update_done();
+			rc = device_online(get_cpu_device(cpu));
+			if (rc)
+				goto out;
+			cpu_maps_update_begin();
+
+			break;
+		}
+		if (cpu == num_possible_cpus())
+			printk(KERN_WARNING "Could not find cpu to online "
+			       "with physical id 0x%x\n", thread);
+	}
+	cpu_maps_update_done();
+
+out:
+	return rc;
+
+}
+
+static bool dlpar_cpu_exists(struct device_node *parent, u32 drc_index)
+{
+	struct device_node *child = NULL;
+	u32 my_drc_index;
+	bool found;
+	int rc;
+
+	/* Assume cpu doesn't exist */
+	found = false;
+
+	for_each_child_of_node(parent, child) {
+		rc = of_property_read_u32(child, "ibm,my-drc-index",
+					  &my_drc_index);
+		if (rc)
+			continue;
+
+		if (my_drc_index == drc_index) {
+			of_node_put(child);
+			found = true;
+			break;
+		}
+	}
+
+	return found;
+}
+
+static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
+{
+	struct device_node *dn, *parent;
+	u32 drc_index;
+	int rc;
+
+	rc = kstrtou32(buf, 0, &drc_index);
+	if (rc)
+		return -EINVAL;
+
+	parent = of_find_node_by_path("/cpus");
+	if (!parent)
+		return -ENODEV;
+
+	if (dlpar_cpu_exists(parent, drc_index)) {
+		of_node_put(parent);
+		printk(KERN_WARNING "CPU with drc index %x already exists\n",
+		       drc_index);
+		return -EINVAL;
+	}
+
+	rc = dlpar_acquire_drc(drc_index);
+	if (rc) {
+		of_node_put(parent);
+		return -EINVAL;
+	}
+
+	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
+	of_node_put(parent);
+	if (!dn)
+		return -EINVAL;
+
+	rc = dlpar_attach_node(dn);
+	if (rc) {
+		dlpar_release_drc(drc_index);
+		dlpar_free_cc_nodes(dn);
+		return rc;
+	}
+
+	rc = dlpar_online_cpu(dn);
+	if (rc)
+		return rc;
+
+	return count;
+}
+
+static int dlpar_offline_cpu(struct device_node *dn)
+{
+	int rc = 0;
+	unsigned int cpu;
+	int len, nthreads, i;
+	const __be32 *intserv;
+	u32 thread;
+
+	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
+	if (!intserv)
+		return -EINVAL;
+
+	nthreads = len / sizeof(u32);
+
+	cpu_maps_update_begin();
+	for (i = 0; i < nthreads; i++) {
+		thread = be32_to_cpu(intserv[i]);
+		for_each_present_cpu(cpu) {
+			if (get_hard_smp_processor_id(cpu) != thread)
+				continue;
+
+			if (get_cpu_current_state(cpu) == CPU_STATE_OFFLINE)
+				break;
+
+			if (get_cpu_current_state(cpu) == CPU_STATE_ONLINE) {
+				set_preferred_offline_state(cpu,
+							    CPU_STATE_OFFLINE);
+				cpu_maps_update_done();
+				rc = device_offline(get_cpu_device(cpu));
+				if (rc)
+					goto out;
+				cpu_maps_update_begin();
+				break;
+
+			}
+
+			/*
+			 * The cpu is in CPU_STATE_INACTIVE.
+			 * Upgrade it's state to CPU_STATE_OFFLINE.
+			 */
+			set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
+			BUG_ON(plpar_hcall_norets(H_PROD, thread)
+								!= H_SUCCESS);
+			__cpu_die(cpu);
+			break;
+		}
+		if (cpu == num_possible_cpus())
+			printk(KERN_WARNING "Could not find cpu to offline with physical id 0x%x\n", thread);
+	}
+	cpu_maps_update_done();
+
+out:
+	return rc;
+
+}
+
+static ssize_t dlpar_cpu_release(const char *buf, size_t count)
+{
+	struct device_node *dn;
+	u32 drc_index;
+	int rc;
+
+	dn = of_find_node_by_path(buf);
+	if (!dn)
+		return -EINVAL;
+
+	rc = of_property_read_u32(dn, "ibm,my-drc-index", &drc_index);
+	if (rc) {
+		of_node_put(dn);
+		return -EINVAL;
+	}
+
+	rc = dlpar_offline_cpu(dn);
+	if (rc) {
+		of_node_put(dn);
+		return -EINVAL;
+	}
+
+	rc = dlpar_release_drc(drc_index);
+	if (rc) {
+		of_node_put(dn);
+		return rc;
+	}
+
+	rc = dlpar_detach_node(dn);
+	if (rc) {
+		dlpar_acquire_drc(drc_index);
+		return rc;
+	}
+
+	of_node_put(dn);
+
+	return count;
+}
+
+#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
+
 static int pseries_smp_notifier(struct notifier_block *nb,
 				unsigned long action, void *data)
 {
@@ -385,6 +598,11 @@ static int __init pseries_cpu_hotplug_init(void)
 	int cpu;
 	int qcss_tok;
 
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
+	ppc_md.cpu_probe = dlpar_cpu_probe;
+	ppc_md.cpu_release = dlpar_cpu_release;
+#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
+
 	for_each_node_by_name(np, "interrupt-controller") {
 		typep = of_get_property(np, "compatible", NULL);
 		if (strstr(typep, "open-pic")) {
