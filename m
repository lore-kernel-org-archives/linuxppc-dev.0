Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HW003g6nzF1s5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 08:04:32 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5TM4TLa051983
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:04:30 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jwujkb5ef-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:04:30 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 29 Jun 2018 18:04:23 -0400
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH v05 3/9] hotplug/cpu: Provide CPU readd operation
In-Reply-To: <e73c6076-34d9-d3fb-d1f0-ccef14dae093@linux.vnet.ibm.com>
Date: Fri, 29 Jun 2018 17:04:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <505a510c-ab3b-7f4f-02f9-baea6cf07895@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/dlpar: Provide hotplug CPU 'readd by index' operation to
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
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 3632db2..8f28160 100644
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
@@ -649,6 +679,26 @@ static int dlpar_cpu_remove_by_index(u32 drc_index, bool release_drc)
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
@@ -839,6 +889,9 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 		else
 			rc = -EINVAL;
 		break;
+	case PSERIES_HP_ELOG_ACTION_READD:
+		rc = dlpar_cpu_readd_by_index(drc_index);
+		break;
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
 		rc = -EINVAL;
@@ -902,6 +955,11 @@ static int pseries_smp_notifier(struct notifier_block *nb,
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
