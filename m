Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 665821A0464
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 05:24:01 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 12:23:59 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 25AC71FF0046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 12:12:08 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9RIMWt72032018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 11:22:32 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9RINuFW026886
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 12:23:56 -0600
Received: from [9.41.105.89] ([9.41.105.89])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t9RINtXd026829
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 12:23:55 -0600
Subject: [PATCH v2 1/6] powerpc/pseries: Consolidate CPU hotplug code to
 hotplug-cpu.c
To: linuxppc-dev@lists.ozlabs.org
References: <562FC0C3.7000303@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <562FC13B.2060308@linux.vnet.ibm.com>
Date: Tue, 27 Oct 2015 13:23:55 -0500
MIME-Version: 1.0
In-Reply-To: <562FC0C3.7000303@linux.vnet.ibm.com>
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
