Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B209E1A0FEE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 05:27:48 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 12:27:46 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A17A41FF0041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 12:15:56 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9RIOOaS9306430
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 11:24:24 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9RIRiQQ015560
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 12:27:44 -0600
Received: from [9.41.105.89] ([9.41.105.89])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t9RIRh1v015539
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 12:27:44 -0600
Subject: [PATCH v2 5/6] powerpc/pseries: Add CPU dlpar add functionality
To: linuxppc-dev@lists.ozlabs.org
References: <562FC0C3.7000303@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <562FC21F.3050907@linux.vnet.ibm.com>
Date: Tue, 27 Oct 2015 13:27:43 -0500
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

Add the ability to hotplug add cpus via rtas hotplug events by either
specifying the drc index of the CPU to add, or providing a count of the
number of CPUs to add.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   94 ++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 635f0ba..8ec52c0 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -679,6 +679,92 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
 	return rc;
 }
 
+static u32 *dlpar_cpus_to_add(u32 cpus_to_add)
+{
+	struct device_node *parent;
+	u32 *cpu_drcs;
+	int cpus_found = 0;
+	int i, index, rc;
+
+	cpu_drcs = kcalloc(cpus_to_add, sizeof(*cpu_drcs), GFP_KERNEL);
+	if (!cpu_drcs)
+		return NULL;
+
+	parent = of_find_node_by_path("/cpus");
+	if (!parent) {
+		kfree(cpu_drcs);
+		return NULL;
+	}
+
+	/* Search the ibm,drc-indexes array for possible CPU drcs to
+	 * add. Note that the format of the ibm,drc-indexes array is
+	 * the number of entries in the array followed by the array
+	 * of drc values so we start looking at index = 1.
+	 */
+	i = 0;
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
+		cpu_drcs[i++] = drc;
+		cpus_found++;
+	}
+
+	of_node_put(parent);
+
+	if (cpus_found < cpus_to_add) {
+		pr_warn("Failed to find enough CPUs (%d of %d) to add\n",
+			cpus_found, cpus_to_add);
+		kfree(cpu_drcs);
+		cpu_drcs = NULL;
+	}
+
+	return cpu_drcs;
+}
+
+static int dlpar_cpu_add_by_count(u32 cpus_to_add)
+{
+	u32 *cpu_drcs;
+	int cpus_added = 0;
+	int i, rc;
+
+	pr_debug("Attempting to hot-add %d CPUs\n", cpus_to_add);
+
+	cpu_drcs = dlpar_cpus_to_add(cpus_to_add);
+	if (!cpu_drcs)
+		return -EINVAL;
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
@@ -698,6 +784,14 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
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
