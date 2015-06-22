Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D8671A0F71
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 07:00:59 +1000 (AEST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 22 Jun 2015 15:00:57 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B25CB1FF002E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 14:52:03 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5ML0Doh33751092
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 14:00:13 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5ML0r6x022491
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 15:00:53 -0600
Received: from [9.41.105.93] (dhcp-9-41-105-93.austin.ibm.com [9.41.105.93])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t5ML0pPk022201
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 15:00:51 -0600
Message-ID: <55887781.2040709@linux.vnet.ibm.com>
Date: Mon, 22 Jun 2015 16:00:49 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/6] pseries: Add CPU dlpar remove functionality
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

Add the ability to dlpar remove CPUs via hotplug rtas events, either by
specifying the drc-index of the CPU to remove or providing a count of cpus 
to remove.

To accomplish we create a list of possible dr cpus and their drc indexes
so we can easily traverse the list looking for candidates to remove and
easily clean up in any cases of failure.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  202 ++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pseries.h     |    5 +
 2 files changed, 207 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 7890b2f..49b7196 100644
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
@@ -506,6 +507,207 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
 	return rc;
 }
 
+static struct device_node *cpu_drc_index_to_dn(struct device_node *parent,
+					       u32 drc_index)
+{
+	struct device_node *dn;
+	u32 my_index;
+	int rc;
+
+	for_each_child_of_node(parent, dn) {
+		if (of_node_cmp(dn->type, "cpu") != 0)
+			continue;
+
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
+static int dlpar_cpu_remove_by_index(struct device_node *parent,
+				     u32 drc_index)
+{
+	struct device_node *dn;
+	int rc;
+
+	dn = cpu_drc_index_to_dn(parent, drc_index);
+	if (!dn)
+		return -ENODEV;
+
+	rc = dlpar_cpu_remove(dn, drc_index);
+	of_node_put(dn);
+	return rc;
+}
+
+static int dlpar_cpus_possible(struct device_node *parent)
+{
+	int dr_cpus_possible;
+
+	/* The first u32 in the ibm,drc-indexes property is the numnber
+	 * of drc entries in the property, which is the possible number
+	 * number of dr capable cpus.
+	 */
+	of_property_read_u32(parent, "ibm,drc-indexes", &dr_cpus_possible);
+	return dr_cpus_possible;
+}
+
+struct dr_cpu {
+	u32     drc_index;
+	bool    present;
+	bool    modified;
+};
+
+static struct dr_cpu *get_dlpar_cpus(struct device_node *parent)
+{
+	struct device_node *dn;
+	struct property *prop;
+	struct dr_cpu *dr_cpus;
+	const __be32 *p;
+	u32 drc_index;
+	int dr_cpus_possible, index;
+	bool first;
+
+	dr_cpus_possible = dlpar_cpus_possible(parent);
+	dr_cpus = kcalloc(dr_cpus_possible, sizeof(*dr_cpus), GFP_KERNEL);
+	if (!dr_cpus)
+		return NULL;
+
+	first = true;
+	index = 0;
+	of_property_for_each_u32(parent, "ibm,drc-indexes", prop, p,
+				 drc_index) {
+		if (first) {
+			/* The first entry is the number of drc indexes in
+			 * the property, skip it.
+			 */
+			first = false;
+			continue;
+		}
+
+		dr_cpus[index].drc_index = drc_index;
+
+		dn = cpu_drc_index_to_dn(parent, drc_index);
+		if (dn) {
+			dr_cpus[index].present = true;
+			of_node_put(dn);
+		}
+
+		index++;
+	}
+
+	return dr_cpus;
+}
+
+static int dlpar_cpu_remove_by_count(struct device_node *parent,
+				     u32 cpus_to_remove)
+{
+	struct dr_cpu *dr_cpus;
+	int dr_cpus_removed = 0;
+	int dr_cpus_present = 0;
+	int dr_cpus_possible;
+	int i, rc;
+
+	pr_info("Attempting to hot-remove %d CPUs\n", cpus_to_remove);
+
+	dr_cpus = get_dlpar_cpus(parent);
+	if (!dr_cpus) {
+		pr_info("Could not gather dr CPU info\n");
+		return -EINVAL;
+	}
+
+	dr_cpus_possible = dlpar_cpus_possible(parent);
+
+	for (i = 0; i < dr_cpus_possible; i++) {
+		if (dr_cpus[i].present)
+			dr_cpus_present++;
+	}
+
+	/* Validate the available CPUs to remove.
+	 * NOTE: we can't remove the last CPU.
+	 */
+	if (cpus_to_remove >= dr_cpus_present) {
+		pr_err("Insufficient CPUs (%d) to satisfy remove request\n",
+		       dr_cpus_present);
+		kfree(dr_cpus);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < dr_cpus_possible; i++) {
+		if (dr_cpus_removed == cpus_to_remove)
+			break;
+
+		if (!dr_cpus[i].present)
+			continue;
+
+		rc = dlpar_cpu_remove_by_index(parent, dr_cpus[i].drc_index);
+		if (!rc) {
+			dr_cpus_removed++;
+			dr_cpus[i].modified = true;
+		}
+	}
+
+	if (dr_cpus_removed != cpus_to_remove) {
+		pr_info("CPU hot-remove failed, adding any removed CPUs\n");
+
+		for (i = 0; i < dr_cpus_possible; i++) {
+			if (!dr_cpus[i].modified)
+				continue;
+
+			rc = dlpar_cpu_add(parent, dr_cpus[i].drc_index);
+			if (rc)
+				pr_info("Failed to re-add CPU (%x)\n",
+					dr_cpus[i].drc_index);
+		}
+
+		rc = -EINVAL;
+	} else {
+		rc = 0;
+	}
+
+	kfree(dr_cpus);
+	return rc;
+}
+
+int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
+{
+	struct device_node *parent;
+	u32 count, drc_index;
+	int rc;
+
+	count = hp_elog->_drc_u.drc_count;
+	drc_index = hp_elog->_drc_u.drc_index;
+
+	parent = of_find_node_by_path("/cpus");
+	if (!parent)
+		return -ENODEV;
+
+	lock_device_hotplug();
+
+	switch (hp_elog->action) {
+	case PSERIES_HP_ELOG_ACTION_REMOVE:
+		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
+			rc = dlpar_cpu_remove_by_count(parent, count);
+		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
+			rc = dlpar_cpu_remove_by_index(parent, drc_index);
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
+	of_node_put(parent);
+	return rc;
+}
+
 #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 
 static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 8411c27..58892f1 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -66,11 +66,16 @@ extern int dlpar_release_drc(u32 drc_index);
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 int dlpar_memory(struct pseries_hp_errorlog *hp_elog);
+int dlpar_cpu(struct pseries_hp_errorlog *hp_elog);
 #else
 static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 {
 	return -EOPNOTSUPP;
 }
+static inline int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /* PCI root bridge prepare function override for pseries */
