Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C43B1A06DD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 01:46:09 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 17 Jun 2014 09:46:07 -0600
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 57CC138C804D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:46:05 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5HFk5Us000326
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 15:46:05 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5HFk5ws014530
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:46:05 -0400
Received: from localhost.localdomain ([9.80.40.207])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s5HFk3a7014388
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:46:04 -0400
Message-ID: <53A062BB.6080509@linux.vnet.ibm.com>
Date: Tue, 17 Jun 2014 10:46:03 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 2/4] Migrate cpu hotplug code to pseries/hotplug-cpu.c
References: <53A061EC.10403@linux.vnet.ibm.com>
In-Reply-To: <53A061EC.10403@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch moves the cpu hotplug handling code from pseries/dlpar.c
to pseries/hotplug-cpu.c. Additionally it factors out the work to
add/remove a single cpu into its own routine.

---
 arch/powerpc/platforms/pseries/dlpar.c       | 182 -------------------------
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 194 +++++++++++++++++++++++++++
 2 files changed, 194 insertions(+), 182 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index dfca23b..16c85b9 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -359,182 +359,6 @@ int dlpar_release_drc(u32 drc_index)
 	return 0;
 }
 
-#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
-
-static int dlpar_online_cpu(struct device_node *dn)
-{
-	int rc = 0;
-	unsigned int cpu;
-	int len, nthreads, i;
-	const u32 *intserv;
-
-	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
-	if (!intserv)
-		return -EINVAL;
-
-	nthreads = len / sizeof(u32);
-
-	cpu_maps_update_begin();
-	for (i = 0; i < nthreads; i++) {
-		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
-				continue;
-			BUG_ON(get_cpu_current_state(cpu)
-					!= CPU_STATE_OFFLINE);
-			cpu_maps_update_done();
-			rc = cpu_up(cpu);
-			if (rc)
-				goto out;
-			cpu_maps_update_begin();
-
-			break;
-		}
-		if (cpu == num_possible_cpus())
-			printk(KERN_WARNING "Could not find cpu to online "
-			       "with physical id 0x%x\n", intserv[i]);
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
-	unsigned long drc_index;
-	int rc;
-
-	rc = strict_strtoul(buf, 0, &drc_index);
-	if (rc)
-		return -EINVAL;
-
-	parent = of_find_node_by_path("/cpus");
-	if (!parent)
-		return -ENODEV;
-
-	dn = dlpar_configure_connector(drc_index, parent);
-	if (!dn)
-		return -EINVAL;
-
-	of_node_put(parent);
-
-	rc = dlpar_acquire_drc(drc_index);
-	if (rc) {
-		dlpar_free_cc_nodes(dn);
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
-	const u32 *intserv;
-
-	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
-	if (!intserv)
-		return -EINVAL;
-
-	nthreads = len / sizeof(u32);
-
-	cpu_maps_update_begin();
-	for (i = 0; i < nthreads; i++) {
-		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
-				continue;
-
-			if (get_cpu_current_state(cpu) == CPU_STATE_OFFLINE)
-				break;
-
-			if (get_cpu_current_state(cpu) == CPU_STATE_ONLINE) {
-				set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
-				cpu_maps_update_done();
-				rc = cpu_down(cpu);
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
-			BUG_ON(plpar_hcall_norets(H_PROD, intserv[i])
-								!= H_SUCCESS);
-			__cpu_die(cpu);
-			break;
-		}
-		if (cpu == num_possible_cpus())
-			printk(KERN_WARNING "Could not find cpu to offline "
-			       "with physical id 0x%x\n", intserv[i]);
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
-	const u32 *drc_index;
-	int rc;
-
-	dn = of_find_node_by_path(buf);
-	if (!dn)
-		return -EINVAL;
-
-	drc_index = of_get_property(dn, "ibm,my-drc-index", NULL);
-	if (!drc_index) {
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
-	rc = dlpar_release_drc(*drc_index);
-	if (rc) {
-		of_node_put(dn);
-		return rc;
-	}
-
-	rc = dlpar_detach_node(dn);
-	if (rc) {
-		dlpar_acquire_drc(*drc_index);
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
 static int handle_dlpar_errorlog(struct rtas_error_log *error_log)
 {
 	struct pseries_errorlog *pseries_log;
@@ -589,12 +413,6 @@ static int __init pseries_dlpar_init(void)
 	if (proc_ent)
 		proc_set_size(proc_ent, 0);
 
-#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
-	ppc_md.cpu_probe = dlpar_cpu_probe;
-	ppc_md.cpu_release = dlpar_cpu_release;
-#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
-
-
 	return 0;
 }
 machine_device_initcall(pseries, pseries_dlpar_init);
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 20d6297..6b42fd5 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -33,6 +33,7 @@
 #include <asm/plpar_wrappers.h>
 
 #include "offline_states.h"
+#include "pseries.h"
 
 /* This version can't take the spinlock, because it never returns */
 static int rtas_stop_self_token = RTAS_UNKNOWN_SERVICE;
@@ -235,6 +236,194 @@ static void pseries_cpu_die(unsigned int cpu)
 	paca[cpu].cpu_start = 0;
 }
 
+static int dlpar_online_cpu(struct device_node *dn)
+{
+	int rc = 0;
+	unsigned int cpu;
+	int len, nthreads, i;
+	const u32 *intserv;
+
+	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
+	if (!intserv)
+		return -EINVAL;
+
+	nthreads = len / sizeof(u32);
+
+	cpu_maps_update_begin();
+	for (i = 0; i < nthreads; i++) {
+		for_each_present_cpu(cpu) {
+			if (get_hard_smp_processor_id(cpu) != intserv[i])
+				continue;
+			BUG_ON(get_cpu_current_state(cpu)
+					!= CPU_STATE_OFFLINE);
+			cpu_maps_update_done();
+			rc = cpu_up(cpu);
+			if (rc)
+				goto out;
+			cpu_maps_update_begin();
+
+			break;
+		}
+		if (cpu == num_possible_cpus())
+			printk(KERN_WARNING "Could not find cpu to online "
+			       "with physical id 0x%x\n", intserv[i]);
+	}
+	cpu_maps_update_done();
+
+out:
+	return rc;
+
+}
+
+static ssize_t dlpar_add_one_cpu(u32 drc_index)
+{
+	struct device_node *dn, *parent;
+	int rc;
+
+	parent = of_find_node_by_path("/cpus");
+	if (!parent)
+		return -ENODEV;
+
+	dn = dlpar_configure_connector(drc_index, parent);
+	if (!dn)
+		return -EINVAL;
+
+	of_node_put(parent);
+
+	rc = dlpar_acquire_drc(drc_index);
+	if (rc) {
+		dlpar_free_cc_nodes(dn);
+		return -EINVAL;
+	}
+
+	rc = dlpar_attach_node(dn);
+	if (rc) {
+		dlpar_release_drc(drc_index);
+		dlpar_free_cc_nodes(dn);
+		return rc;
+	}
+
+	rc = dlpar_online_cpu(dn);
+	return rc;
+}
+
+static int dlpar_offline_cpu(struct device_node *dn)
+{
+	int rc = 0;
+	unsigned int cpu;
+	int len, nthreads, i;
+	const u32 *intserv;
+
+	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
+	if (!intserv)
+		return -EINVAL;
+
+	nthreads = len / sizeof(u32);
+
+	cpu_maps_update_begin();
+	for (i = 0; i < nthreads; i++) {
+		for_each_present_cpu(cpu) {
+			if (get_hard_smp_processor_id(cpu) != intserv[i])
+				continue;
+
+			if (get_cpu_current_state(cpu) == CPU_STATE_OFFLINE)
+				break;
+
+			if (get_cpu_current_state(cpu) == CPU_STATE_ONLINE) {
+				set_preferred_offline_state(cpu,
+							    CPU_STATE_OFFLINE);
+				cpu_maps_update_done();
+				rc = cpu_down(cpu);
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
+			BUG_ON(plpar_hcall_norets(H_PROD, intserv[i])
+								!= H_SUCCESS);
+			__cpu_die(cpu);
+			break;
+		}
+		if (cpu == num_possible_cpus())
+			printk(KERN_WARNING "Could not find cpu to offline "
+			       "with physical id 0x%x\n", intserv[i]);
+	}
+	cpu_maps_update_done();
+
+out:
+	return rc;
+
+}
+
+static int dlpar_remove_one_cpu(struct device_node *dn, u32 drc_index)
+{
+	int rc;
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
+	return 0;
+}
+
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
+static ssize_t dlpar_cpu_release(const char *buf, size_t count)
+{
+	struct device_node *dn;
+	const u32 *drc_index;
+	int rc;
+
+	dn = of_find_node_by_path(buf);
+	if (!dn)
+		return -EINVAL;
+
+	drc_index = of_get_property(dn, "ibm,my-drc-index", NULL);
+	if (!drc_index) {
+		of_node_put(dn);
+		return -EINVAL;
+	}
+
+	rc = dlpar_remove_one_cpu(dn, *drc_index);
+	of_node_put(dn);
+
+	return rc ? rc : count;
+}
+
+static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
+{
+	unsigned long drc_index;
+	int rc;
+
+	rc = strict_strtoul(buf, 0, &drc_index);
+	if (rc)
+		return -EINVAL;
+
+	rc = dlpar_add_one_cpu(drc_index);
+	return rc ? rc : count;
+}
+#endif
+
 /*
  * Update cpu_present_mask and paca(s) for a new cpu node.  The wrinkle
  * here is that a cpu device node may represent up to two logical cpus
@@ -403,6 +592,11 @@ static int __init pseries_cpu_hotplug_init(void)
 		return 0;
 	}
 
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
+	ppc_md.cpu_probe = dlpar_cpu_probe;
+	ppc_md.cpu_release = dlpar_cpu_release;
+#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
+
 	ppc_md.cpu_die = pseries_mach_cpu_die;
 	smp_ops->cpu_disable = pseries_cpu_disable;
 	smp_ops->cpu_die = pseries_cpu_die;
-- 
2.0.0.rc3.2.g998f840
