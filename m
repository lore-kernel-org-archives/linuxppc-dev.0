Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41djwP24HnzF12T
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 23:19:33 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6TDIf5S027191
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 09:19:31 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kh5jd45q1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 09:19:30 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sun, 29 Jul 2018 07:19:30 -0600
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v08 3/5] hotplug/cpu: Provide CPU readd operation
Date: Sun, 29 Jul 2018 08:19:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <a5b0ee17-6317-959d-256e-b46a5f673355@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<9573dc30-01ad-2650-c247-28df08875cef@linux.vnet.ibm.com>powerpc/dlpar: Provide hotplug CPU 'readd by index' operation to
support LPAR Post Migration state updates.  When such changes are
invoked by the PowerPC 'mobility' code, they will be queued up so
that modifications to CPU properties will take place after the new
property value is written to the device-tree.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in patch:
  -- Add CPU validity check to pseries_smp_notifier
  -- Improve check on 'ibm,associativity' property
  -- Add check for cpu type to new update property entry
  -- Cleanup reference to outdated queuing function.
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 7ede3b0..1906ee57 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -305,6 +305,36 @@ static int pseries_add_processor(struct device_node *np)
 	return err;
 }
 
+static int pseries_update_processor(struct of_reconfig_data *pr)
+{
+	int old_entries, new_entries, rc = 0;
+	__be32 *old_assoc, *new_assoc;
+
+	/* We only handle changes due to 'ibm,associativity' property
+	 */
+	old_assoc = pr->old_prop->value;
+	old_entries = be32_to_cpu(*old_assoc++);
+
+	new_assoc = pr->prop->value;
+	new_entries = be32_to_cpu(*new_assoc++);
+
+	if (old_entries == new_entries) {
+		int sz = old_entries * sizeof(int);
+
+		if (memcmp(old_assoc, new_assoc, sz))
+			rc = dlpar_queue_action(
+					PSERIES_HP_ELOG_RESOURCE_CPU,
+					PSERIES_HP_ELOG_ACTION_READD,
+					pr->dn->phandle);
+	} else {
+		rc = dlpar_queue_action(PSERIES_HP_ELOG_RESOURCE_CPU,
+					PSERIES_HP_ELOG_ACTION_READD,
+					pr->dn->phandle);
+	}
+
+	return rc;
+}
+
 /*
  * Update the present map for a cpu node which is going away, and set
  * the hard id in the paca(s) to -1 to be consistent with boot time
@@ -648,6 +678,26 @@ static int dlpar_cpu_remove_by_index(u32 drc_index, bool release_drc)
 	return rc;
 }
 
+static int dlpar_cpu_readd_by_index(u32 drc_index)
+{
+	int rc = 0;
+
+	pr_info("Attempting to re-add CPU, drc index %x\n", drc_index);
+
+	rc = dlpar_cpu_remove_by_index(drc_index, false);
+	if (!rc)
+		rc = dlpar_cpu_add(drc_index, false);
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
@@ -838,6 +888,9 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 		else
 			rc = -EINVAL;
 		break;
+	case PSERIES_HP_ELOG_ACTION_READD:
+		rc = dlpar_cpu_readd_by_index(drc_index);
+		break;
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
 		rc = -EINVAL;
@@ -901,6 +954,11 @@ static int pseries_smp_notifier(struct notifier_block *nb,
 	case OF_RECONFIG_DETACH_NODE:
 		pseries_remove_processor(rd->dn);
 		break;
+	case OF_RECONFIG_UPDATE_PROPERTY:
+		if (!strcmp(rd->dn->type, "cpu") &&
+		    !strcmp(rd->prop->name, "ibm,associativity"))
+			pseries_update_processor(rd);
+		break;
 	}
 	return notifier_from_errno(err);
 }
