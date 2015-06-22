Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A9FEA1A0F69
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 06:56:33 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 22 Jun 2015 16:56:31 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 7AC986E8041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 16:48:15 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5MKuS5w40042544
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 20:56:28 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5MKuSEt026183
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 16:56:28 -0400
Received: from [9.41.105.93] (dhcp-9-41-105-93.austin.ibm.com [9.41.105.93])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t5MKuSQ1026151
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 16:56:28 -0400
Message-ID: <5588767C.6050705@linux.vnet.ibm.com>
Date: Mon, 22 Jun 2015 15:56:28 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/6] pseries: Consolidate CPU hotplug code to hotplug-cpu.c
References: <558875FF.2040000@linux.vnet.ibm.com>
In-Reply-To: <558875FF.2040000@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/pseries/dlpar.c       |  189 --------------------------
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  183 +++++++++++++++++++++++++
 2 files changed, 184 insertions(+), 188 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 47d9cebe..4463e9a 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -18,7 +18,6 @@
 #include <linux/cpu.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include "offline_states.h"
 #include "pseries.h"
 
 #include <asm/prom.h>
@@ -359,183 +358,6 @@ int dlpar_release_drc(u32 drc_index)
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
-	rc = dlpar_acquire_drc(drc_index);
-	if (rc)
-		return -EINVAL;
-
-	parent = of_find_node_by_path("/cpus");
-	if (!parent)
-		return -ENODEV;
-
-	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
-	of_node_put(parent);
-	if (!dn)
-		return -EINVAL;
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
@@ -643,16 +465,7 @@ static CLASS_ATTR(dlpar, S_IWUSR, NULL, dlpar_store);
 
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
index 6247544..c55cdbc 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -32,6 +32,7 @@
 #include <asm/xics.h>
 #include <asm/plpar_wrappers.h>
 
+#include "pseries.h"
 #include "offline_states.h"
 
 /* This version can't take the spinlock, because it never returns */
@@ -339,6 +340,183 @@ static void pseries_remove_processor(struct device_node *np)
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
+	rc = dlpar_acquire_drc(drc_index);
+	if (rc)
+		return -EINVAL;
+
+	parent = of_find_node_by_path("/cpus");
+	if (!parent)
+		return -ENODEV;
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
@@ -385,6 +563,11 @@ static int __init pseries_cpu_hotplug_init(void)
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
