Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFj622NM2zF0T0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 04:32:58 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
 w08HWRfB001330
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Jan 2018 12:32:56 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fccfkswt3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jan 2018 12:32:55 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 8 Jan 2018 10:32:54 -0700
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: [PATCH V3 1/3] hotplug/mobility: Apply assoc updates for Post
 Migration Topo
In-Reply-To: <0658ebca-aa3c-9251-9d74-b645633a750a@linux.vnet.ibm.com>
Date: Mon, 8 Jan 2018 11:32:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <991e6ef3-f1b9-acf6-4f71-ccf00aaeea24@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hotplug/mobility: Recognize more changes to the associativity of
memory blocks described by the 'ibm,dynamic-memory' and 'cpu'
properties when processing the topology of LPARS in Post Migration
events.  Previous efforts only recognized whether a memory block's
assignment had changed in the property.  Changes here include:

* Checking the aa_index values of the old/new properties and 'readd'
  any block for which the setting has changed.
* Checking for changes in cpu associativity and making 'readd' calls
  when differences are observed.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V3:
  -- Simplify code to update CPU nodes during mobility checks.
     Remove functions to generate extra HP_ELOG messages in favor
     of direct function calls to dlpar_cpu_readd_by_index.
  -- Move check for "cpu" node type from pseries_update_cpu to
     pseries_smp_notifier in 'hotplug-cpu.c'
  -- Remove functions 'pseries_memory_readd_by_index' and
     'pseries_cpu_readd_by_index' as no longer needed outside of
     'mobility.c'.
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |   69 +++++++++++++++++++++++
 arch/powerpc/platforms/pseries/hotplug-memory.c |    7 ++
 2 files changed, 76 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index a7d14aa7..64e29d76 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -636,6 +636,27 @@ static int dlpar_cpu_remove_by_index(u32 drc_index)
 	return rc;
 }
 
+static int dlpar_cpu_readd_by_index(u32 drc_index)
+{
+	int rc = 0;
+
+	pr_info("Attempting to update CPU, drc index %x\n", drc_index);
+
+	if (dlpar_cpu_remove_by_index(drc_index))
+		rc = -EINVAL;
+	else if (dlpar_cpu_add(drc_index))
+		rc = -EINVAL;
+
+	if (rc)
+		pr_info("Failed to update cpu at drc_index %lx\n",
+				(unsigned long int)drc_index);
+	else
+		pr_info("CPU at drc_index %lx was updated\n",
+				(unsigned long int)drc_index);
+
+	return rc;
+}
+
 static int find_dlpar_cpus_to_remove(u32 *cpu_drcs, int cpus_to_remove)
 {
 	struct device_node *dn;
@@ -826,6 +847,9 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 		else
 			rc = -EINVAL;
 		break;
+	case PSERIES_HP_ELOG_ACTION_READD:
+		rc = dlpar_cpu_readd_by_index(drc_index);
+		break;
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
 		rc = -EINVAL;
@@ -876,12 +900,53 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
 
 #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
 
+static int pseries_update_cpu(struct of_reconfig_data *pr)
+{
+	u32 old_entries, new_entries;
+	__be32 *p, *old_assoc, *new_assoc;
+	int rc = 0;
+
+	/* So far, we only handle the 'ibm,associativity' property,
+	 * here.
+	 * The first int of the property is the number of domains
+	 * described.  This is followed by an array of level values.
+	 */
+	p = (__be32 *) pr->old_prop->value;
+	if (!p)
+		return -EINVAL;
+	old_entries = be32_to_cpu(*p++);
+	old_assoc = p;
+
+	p = (__be32 *)pr->prop->value;
+	if (!p)
+		return -EINVAL;
+	new_entries = be32_to_cpu(*p++);
+	new_assoc = p;
+
+	if (old_entries == new_entries) {
+		int sz = old_entries * sizeof(int);
+
+		if (!memcmp(old_assoc, new_assoc, sz))
+			rc = dlpar_cpu_readd_by_index(
+					be32_to_cpu(pr->dn->phandle));
+
+	} else {
+		rc = dlpar_cpu_readd_by_index(
+					be32_to_cpu(pr->dn->phandle));
+	}
+
+	return rc;
+}
+
 static int pseries_smp_notifier(struct notifier_block *nb,
 				unsigned long action, void *data)
 {
 	struct of_reconfig_data *rd = data;
 	int err = 0;
 
+	if (strcmp(pr->dn->type, "cpu"))
+		return notifier_from_errno(err);
+
 	switch (action) {
 	case OF_RECONFIG_ATTACH_NODE:
 		err = pseries_add_processor(rd->dn);
@@ -889,6 +954,10 @@ static int pseries_smp_notifier(struct notifier_block *nb,
 	case OF_RECONFIG_DETACH_NODE:
 		pseries_remove_processor(rd->dn);
 		break;
+	case OF_RECONFIG_UPDATE_PROPERTY:
+		if (!strcmp(rd->prop->name, "ibm,associativity"))
+			err = pseries_update_cpu(rd);
+		break;
 	}
 	return notifier_from_errno(err);
 }
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 1d48ab4..0e2ae20 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -1160,6 +1160,13 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
 					  memblock_size);
 			rc = (rc < 0) ? -EINVAL : 0;
 			break;
+		} else if ((be32_to_cpu(old_drmem[i].aa_index) !=
+					be32_to_cpu(new_drmem[i].aa_index)) &&
+				(be32_to_cpu(new_drmem[i].flags) &
+					DRCONF_MEM_ASSIGNED)) {
+			rc = dlpar_memory_readd_by_index(
+				be32_to_cpu(new_drmem[i].drc_index),
+				pr->prop);
 		}
 	}
 	return rc;
