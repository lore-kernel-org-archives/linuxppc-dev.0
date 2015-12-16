Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 563D81A0318
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 07:55:13 +1100 (AEDT)
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 16 Dec 2015 15:55:10 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBGKt8UX25624806
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 20:55:08 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBGKt8Yq032519
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 15:55:08 -0500
Received: from [9.41.105.164] ([9.41.105.164])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 tBGKt7Y9032444
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 15:55:07 -0500
Subject: [PATCH v3 5/6] powerpc/pseries: Add CPU dlpar add functionality
To: linuxppc-dev@lists.ozlabs.org
References: <5671CD8A.8000500@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <5671CFAB.5060502@linux.vnet.ibm.com>
Date: Wed, 16 Dec 2015 14:55:07 -0600
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

Add the ability to hotplug add cpus via rtas hotplug events by either
specifying the drc index of the CPU to add, or providing a count of the
number of CPUs to add.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
v3:
 - Add new routine valid_cpu_drc_index() to validate the drc index of a CPU
   before trying to add it.
 - Re-wrote dlpar_cpus_to_add, now called find_dlpar_cpus_to_add(), to improve
   readability and error handling.
 - Added additional messages in failure conditions.

 arch/powerpc/platforms/pseries/hotplug-cpu.c |  116 ++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 292a8e3..5ae9e8c 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -410,6 +410,27 @@ static bool dlpar_cpu_exists(struct device_node *parent, u32 drc_index)
 	return found;
 }
 
+static bool valid_cpu_drc_index(struct device_node *parent, u32 drc_index)
+{
+	bool found = false;
+	int rc, index;
+
+	index = 0;
+	while (!found) {
+		u32 drc;
+
+		rc = of_property_read_u32_index(parent, "ibm,drc-indexes",
+						index++, &drc);
+		if (rc)
+			break;
+
+		if (drc == drc_index)
+			found = true;
+	}
+
+	return found;
+}
+
 static ssize_t dlpar_cpu_add(u32 drc_index)
 {
 	struct device_node *dn, *parent;
@@ -429,6 +450,12 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
 		return -EINVAL;
 	}
 
+	if (!valid_cpu_drc_index(parent, drc_index)) {
+		of_node_put(parent);
+		pr_warn("Cannot find CPU (drc index %x) to add.\n", drc_index);
+		return -EINVAL;
+	}
+
 	rc = dlpar_acquire_drc(drc_index);
 	if (rc) {
 		pr_warn("Failed to acquire DRC, rc: %d, drc index: %x\n",
@@ -688,6 +715,87 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
 	return rc;
 }
 
+static int find_dlpar_cpus_to_add(u32 *cpu_drcs, u32 cpus_to_add)
+{
+	struct device_node *parent;
+	int cpus_found = 0;
+	int index, rc;
+
+	parent = of_find_node_by_path("/cpus");
+	if (!parent) {
+		pr_warn("Could not find CPU root node in device tree\n");
+		kfree(cpu_drcs);
+		return -1;
+	}
+
+	/* Search the ibm,drc-indexes array for possible CPU drcs to
+	 * add. Note that the format of the ibm,drc-indexes array is
+	 * the number of entries in the array followed by the array
+	 * of drc values so we start looking at index = 1.
+	 */
+	index = 1;
+	while (cpus_found < cpus_to_add) {
+		u32 drc;
+
+		rc = of_property_read_u32_index(parent, "ibm,drc-indexes",
+						index++, &drc);
+		if (rc)
+			break;
+
+		if (dlpar_cpu_exists(parent, drc))
+			continue;
+
+		cpu_drcs[cpus_found++] = drc;
+	}
+
+	of_node_put(parent);
+	return cpus_found;
+}
+
+static int dlpar_cpu_add_by_count(u32 cpus_to_add)
+{
+	u32 *cpu_drcs;
+	int cpus_added = 0;
+	int cpus_found;
+	int i, rc;
+
+	pr_debug("Attempting to hot-add %d CPUs\n", cpus_to_add);
+
+	cpu_drcs = kcalloc(cpus_to_add, sizeof(*cpu_drcs), GFP_KERNEL);
+	if (!cpu_drcs)
+		return -EINVAL;
+
+	cpus_found = find_dlpar_cpus_to_add(cpu_drcs, cpus_to_add);
+	if (cpus_found < cpus_to_add) {
+		pr_warn("Failed to find enough CPUs (%d of %d) to add\n",
+			cpus_found, cpus_to_add);
+		kfree(cpu_drcs);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < cpus_to_add; i++) {
+		rc = dlpar_cpu_add(cpu_drcs[i]);
+		if (rc)
+			break;
+
+		cpus_added++;
+	}
+
+	if (cpus_added < cpus_to_add) {
+		pr_warn("CPU hot-add failed, removing any added CPUs\n");
+
+		for (i = 0; i < cpus_added; i++)
+			dlpar_cpu_remove_by_index(cpu_drcs[i]);
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
 int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 {
 	u32 count, drc_index;
@@ -707,6 +815,14 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 		else
 			rc = -EINVAL;
 		break;
+	case PSERIES_HP_ELOG_ACTION_ADD:
+		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
+			rc = dlpar_cpu_add_by_count(count);
+		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
+			rc = dlpar_cpu_add(drc_index);
+		else
+			rc = -EINVAL;
+		break;
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
 		rc = -EINVAL;
