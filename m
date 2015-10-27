Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75AAC1A0F4B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 05:26:53 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 14:26:51 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B54C3C9003C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 14:14:59 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9RIQmFn51445972
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 18:26:48 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9RIQmlb025287
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 14:26:48 -0400
Received: from [9.41.105.89] ([9.41.105.89])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t9RIQmHL025244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 14:26:48 -0400
Subject: [PATCH v2 4/6] powerpc/pseries: Add CPU dlpar remove functionality
To: linuxppc-dev@lists.ozlabs.org
References: <562FC0C3.7000303@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <562FC1E8.9040902@linux.vnet.ibm.com>
Date: Tue, 27 Oct 2015 13:26:48 -0500
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

Add the ability to dlpar remove CPUs via hotplug rtas events, either by
specifying the drc-index of the CPU to remove or providing a count of cpus
to remove.

To remove multiple cpus in a single request we create a list of possible
DR (Dynamic Reconfiguration) cpus and their drc indexes that can be
removed.  We can then traverse the list remove each cpu and easily clean
up in any cases of failure.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---

Updates for v2:
- use for_each_node_by_type() instead of for_each_child_of_node
- updated how the list of cpus to remove is generated
- change to remove all cpus requested or none at all
- put function declarations under CONFIG_HOTPLUG_CPU

 arch/powerpc/platforms/pseries/hotplug-cpu.c |  138 ++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pseries.h     |    9 ++
 2 files changed, 147 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index f080e81..635f0ba 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -26,6 +26,7 @@
 #include <linux/sched.h>	/* for idle_task_exit */
 #include <linux/cpu.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
 #include <asm/firmware.h>
@@ -570,6 +571,143 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
 	return 0;
 }
 
+static struct device_node *cpu_drc_index_to_dn(u32 drc_index)
+{
+	struct device_node *dn;
+	u32 my_index;
+	int rc;
+
+	for_each_node_by_type(dn, "cpu") {
+		rc = of_property_read_u32(dn, "ibm,my-drc-index", &my_index);
+		if (rc)
+			continue;
+
+		if (my_index == drc_index)
+			break;
+	}
+
+	return dn;
+}
+
+static int dlpar_cpu_remove_by_index(u32 drc_index)
+{
+	struct device_node *dn;
+	int rc;
+
+	dn = cpu_drc_index_to_dn(drc_index);
+	if (!dn)
+		return -ENODEV;
+
+	rc = dlpar_cpu_remove(dn, drc_index);
+	of_node_put(dn);
+	return rc;
+}
+
+static u32 *dlpar_cpus_to_remove(int cpus_to_remove)
+{
+	struct device_node *dn;
+	u32 *cpu_drcs;
+	int cpus_found = 0;
+	int i, rc;
+
+	cpu_drcs = kcalloc(cpus_to_remove, sizeof(*cpu_drcs), GFP_KERNEL);
+	if (!cpu_drcs)
+		return NULL;
+
+	i = 0;
+	for_each_node_by_type(dn, "cpu") {
+		cpus_found++;
+
+		if (cpus_found > cpus_to_remove) {
+			of_node_put(dn);
+			break;
+		}
+
+		rc = of_property_read_u32(dn, "ibm,my-drc-index",
+					  &cpu_drcs[i++]);
+		if (rc) {
+			of_node_put(dn);
+			break;
+		}
+	}
+
+	/* We want to find cpus_to_remove + 1 CPUs to ensure we do not
+	 * remove the last CPU.
+	 */
+	if (cpus_found <= cpus_to_remove) {
+		pr_warn("Failed to find enough CPUs (%d of %d) to remove\n",
+			cpus_found, cpus_to_remove);
+		kfree(cpu_drcs);
+		cpu_drcs = NULL;
+	}
+
+	return cpu_drcs;
+}
+
+static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
+{
+	u32 *cpu_drcs;
+	int cpus_removed = 0;
+	int i, rc;
+
+	pr_debug("Attempting to hot-remove %d CPUs\n", cpus_to_remove);
+
+	cpu_drcs = dlpar_cpus_to_remove(cpus_to_remove);
+	if (!cpu_drcs)
+		return -EINVAL;
+
+	for (i = 0; i < cpus_to_remove; i++) {
+		rc = dlpar_cpu_remove_by_index(cpu_drcs[i]);
+		if (rc)
+			break;
+
+		cpus_removed++;
+	}
+
+	if (cpus_removed != cpus_to_remove) {
+		pr_warn("CPU hot-remove failed, adding back removed CPUs\n");
+
+		for (i = 0; i < cpus_removed; i++)
+			dlpar_cpu_add(cpu_drcs[i]);
+
+		rc = -EINVAL;
+	} else {
+		rc = 0;
+	}
+
+	kfree(cpu_drcs);
+	return rc;
+}
+
+int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
+{
+	u32 count, drc_index;
+	int rc;
+
+	count = hp_elog->_drc_u.drc_count;
+	drc_index = hp_elog->_drc_u.drc_index;
+
+	lock_device_hotplug();
+
+	switch (hp_elog->action) {
+	case PSERIES_HP_ELOG_ACTION_REMOVE:
+		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
+			rc = dlpar_cpu_remove_by_count(count);
+		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
+			rc = dlpar_cpu_remove_by_index(drc_index);
+		else
+			rc = -EINVAL;
+		break;
+	default:
+		pr_err("Invalid action (%d) specified\n", hp_elog->action);
+		rc = -EINVAL;
+		break;
+	}
+
+	unlock_device_hotplug();
+	return rc;
+}
+
 #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 
 static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 8411c27..7aa83f0 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -73,6 +73,15 @@ static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 }
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+int dlpar_cpu(struct pseries_hp_errorlog *hp_elog);
+#else
+static inline int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 /* PCI root bridge prepare function override for pseries */
 struct pci_host_bridge;
 int pseries_root_bridge_prepare(struct pci_host_bridge *bridge);
