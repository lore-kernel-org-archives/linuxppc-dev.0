Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DE9B1A0324
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 01:47:01 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 17 Jun 2014 11:46:55 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9F0D738C8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:46:54 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5HFks07262408
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 15:46:54 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5HFkrG1020455
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:46:53 -0400
Received: from localhost.localdomain ([9.80.40.207])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s5HFkqFU020349
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:46:52 -0400
Message-ID: <53A062EC.3040000@linux.vnet.ibm.com>
Date: Tue, 17 Jun 2014 10:46:52 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 3/4] Handle cpu hotplug from rtas hotplug events
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

This patch updates the cpu hotplug handling code so that we can perform
cpu hotplug using the new rtas hotplug event interface while still
maintaining the ability to use the probe/release sysfs interface
for adding and removing cpus.

At a later point we could deprecate the use of the probe/release sysfs
files and remove those code bits.

---
 arch/powerpc/platforms/pseries/dlpar.c       |   4 +
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 164 +++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pseries.h     |   1 +
 3 files changed, 169 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 16c85b9..53f4fe6 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -275,6 +275,7 @@ int dlpar_attach_node(struct device_node *dn)
 	if (!dn->parent)
 		return -ENOMEM;
 
+	of_node_init(dn);
 	rc = of_attach_node(dn);
 	if (rc) {
 		printk(KERN_ERR "Failed to add device node %s\n",
@@ -374,6 +375,9 @@ static int handle_dlpar_errorlog(struct rtas_error_log *error_log)
 	case HP_ELOG_RESOURCE_MEM:
 		rc = dlpar_memory(hp_elog);
 		break;
+	case HP_ELOG_RESOURCE_CPU:
+		rc = dlpar_cpus(hp_elog);
+		break;
 	}
 
 	return rc;
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 6b42fd5..8be88d6 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -24,6 +24,7 @@
 #include <linux/sched.h>	/* for idle_task_exit */
 #include <linux/cpu.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
 #include <asm/firmware.h>
@@ -387,6 +388,169 @@ static int dlpar_remove_one_cpu(struct device_node *dn, u32 drc_index)
 	return 0;
 }
 
+struct cpu_drc_info {
+	u32	drc_index;
+	int	present;
+};
+
+static struct cpu_drc_info *get_cpu_drc_info(int *drc_count)
+{
+	struct device_node *dn, *child = NULL;
+	struct cpu_drc_info *drcs;
+	const u32 *indexes;
+	int i, count;
+
+	dn = of_find_node_by_path("/cpus");
+	if (!dn)
+		return NULL;
+
+	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
+	if (!indexes) {
+		of_node_put(dn);
+		return NULL;
+	}
+
+	count = *indexes++;
+	drcs = kzalloc(count * sizeof(*drcs), GFP_KERNEL);
+	if (!drcs) {
+		of_node_put(dn);
+		return NULL;
+	}
+
+	for (i = 0; i < count; i++)
+		drcs[i].drc_index = indexes[i];
+
+	for_each_child_of_node(dn, child) {
+		const u32 *drc_index;
+
+		drc_index = of_get_property(child, "ibm,my-drc-index", NULL);
+		if (!drc_index)
+			continue;
+
+		for (i = 0; i < count; i++) {
+			if (drcs[i].drc_index == *drc_index)
+				drcs[i].present = 1;
+				break;
+		}
+	}
+
+	of_node_put(dn);
+	*drc_count = count;
+	return drcs;
+}
+
+static struct device_node *cpu_drc_index_to_device(u32 drc_index)
+{
+	struct device_node *parent, *child;
+	const u32 *my_drc_index;
+
+	parent = of_find_node_by_path("/cpus");
+	if (!parent)
+		return NULL;
+
+	for_each_child_of_node(parent, child) {
+		my_drc_index = of_get_property(child, "ibm,my-drc-index", NULL);
+		if (!my_drc_index)
+			continue;
+
+		if (*my_drc_index == drc_index)
+			break;
+	}
+
+	of_node_put(parent);
+	return child;
+}
+
+static int dlpar_remove_cpus(struct pseries_hp_elog *hp_elog,
+			    struct cpu_drc_info *cpu_drcs, int num_drcs)
+{
+	struct device_node *dn;
+	int cpus_to_remove, cpus_removed = 0;
+	int rc, i;
+
+	if (hp_elog->id_type == HP_ELOG_ID_DRC_COUNT)
+		cpus_to_remove = hp_elog->_drc_u.drc_count;
+	else
+		cpus_to_remove = 1;
+
+	for (i = 0; i < num_drcs; i++) {
+		if (cpus_to_remove == cpus_removed)
+			break;
+
+		if (!cpu_drcs[i].present)
+			continue;
+
+		if (hp_elog->id_type == HP_ELOG_ID_DRC_INDEX
+		    && hp_elog->_drc_u.drc_index != cpu_drcs[i].drc_index)
+			continue;
+
+		dn = cpu_drc_index_to_device(cpu_drcs[i].drc_index);
+		if (!dn)
+			continue;
+
+		rc = dlpar_remove_one_cpu(dn, cpu_drcs[i].drc_index);
+		of_node_put(dn);
+		
+		if (!rc)
+			cpus_removed++;
+	}
+
+	return (cpus_to_remove == cpus_removed) ? 0: -1;
+}
+
+static int dlpar_add_cpus(struct pseries_hp_elog *hp_elog,
+			  struct cpu_drc_info *cpu_drcs, int num_drcs)
+{
+	int cpus_to_add, cpus_added = 0;
+	int rc, i;
+
+	if (hp_elog->id_type == HP_ELOG_ID_DRC_COUNT)
+		cpus_to_add = hp_elog->_drc_u.drc_count;
+	else
+		cpus_to_add = 1;
+
+	for (i = 0; i < num_drcs; i++) {
+		if (cpus_to_add == cpus_added)
+			break;
+
+		if (cpu_drcs[i].present)
+			continue;
+
+		if (hp_elog->id_type == HP_ELOG_ID_DRC_INDEX
+		    && hp_elog->_drc_u.drc_index != cpu_drcs[i].drc_index)
+			continue;
+		
+		rc = dlpar_add_one_cpu(cpu_drcs[i].drc_index);
+		if (!rc)
+			cpus_added++;
+	}
+
+	return (cpus_to_add == cpus_added) ? 0: -1;
+}
+
+int dlpar_cpus(struct pseries_hp_elog *hp_elog)
+{
+	struct cpu_drc_info *cpu_drcs;
+	int num_drcs;
+	int rc = 0;
+
+	cpu_drcs = get_cpu_drc_info(&num_drcs);
+	if (!cpu_drcs)
+		return -1;
+
+	switch (hp_elog->action) {
+	case HP_ELOG_ACTION_ADD:
+		rc = dlpar_add_cpus(hp_elog, cpu_drcs, num_drcs);
+		break;
+	case HP_ELOG_ACTION_REMOVE:
+		rc = dlpar_remove_cpus(hp_elog, cpu_drcs, num_drcs);
+		break;
+	}
+
+	kfree(cpu_drcs);
+	return rc;
+}
+
 #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 {
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 89c25769..1706215 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -63,6 +63,7 @@ extern int dlpar_detach_node(struct device_node *);
 extern int dlpar_acquire_drc(u32);
 extern int dlpar_release_drc(u32);
 extern int dlpar_memory(struct pseries_hp_elog *);
+extern int dlpar_cpus(struct pseries_hp_elog *);
 
 /* PCI root bridge prepare function override for pseries */
 struct pci_host_bridge;
-- 
2.0.0.rc3.2.g998f840
