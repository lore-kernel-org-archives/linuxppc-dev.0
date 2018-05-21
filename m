Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qRFX25yyzF0SN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 03:52:48 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4LHnAOu013339
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 13:52:45 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j42b31c7f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 13:52:45 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 21 May 2018 13:52:44 -0400
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [RFC v5 4/6] powerpc/dlpar: Provide CPU readd operation
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <6add12e8-acf9-228e-fa04-80e38dbb8f7c@linux.vnet.ibm.com>
Date: Mon, 21 May 2018 12:52:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <1c45d04d-7b41-0aac-a8b9-8fcf0730f06c@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index ec78cc6..ac08d85 100644
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
@@ -968,6 +991,12 @@ static int pseries_smp_notifier(struct notifier_block *nb,
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
