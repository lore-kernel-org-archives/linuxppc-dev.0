Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rCrg6XYTzDrJF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 10:22:27 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4N0KHVK046812
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 20:22:25 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j4vpva3hf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 20:22:25 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 22 May 2018 18:22:24 -0600
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [RFC v7 4/7] powerpc/dlpar: Provide CPU readd operation
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <b9c98429-f3d7-1e6d-603f-6ac01225e400@linux.vnet.ibm.com>
Date: Tue, 22 May 2018 19:22:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <eb787b76-871a-75f6-1f86-6413dd8dabea@linux.vnet.ibm.com>
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
Changes in RFC:
  -- Add CPU validity check to pseries_smp_notifier
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index f78ba5d..ac08d85 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -691,6 +691,26 @@ static int dlpar_cpu_remove_by_index(u32 drc_index, bool release_drc)
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
@@ -902,6 +922,9 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 		else
 			rc = -EINVAL;
 		break;
+	case PSERIES_HP_ELOG_ACTION_READD:
+		rc = dlpar_cpu_readd_by_index(drc_index);
+		break;
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
 		rc = -EINVAL;
@@ -958,6 +981,9 @@ static int pseries_smp_notifier(struct notifier_block *nb,
 	struct of_reconfig_data *rd = data;
 	int err = 0;
 
+	if (strcmp(rd->dn->type, "cpu"))
+		return notifier_from_errno(err);
+
 	switch (action) {
 	case OF_RECONFIG_ATTACH_NODE:
 		err = pseries_add_processor(rd->dn);
@@ -965,6 +991,12 @@ static int pseries_smp_notifier(struct notifier_block *nb,
 	case OF_RECONFIG_DETACH_NODE:
 		pseries_remove_processor(rd->dn);
 		break;
+	case OF_RECONFIG_UPDATE_PROPERTY:
+		if (!strcmp(rd->prop->name, "ibm,associativity"))
+			dlpar_queue_action(PSERIES_HP_ELOG_RESOURCE_CPU,
+					   PSERIES_HP_ELOG_ACTION_READD,
+					   be32_to_cpu(rd->dn->phandle));
+		break;
 	}
 	return notifier_from_errno(err);
 }
