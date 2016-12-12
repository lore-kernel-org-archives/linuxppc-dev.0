Return-Path: <jallen@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tcwQR691JzDw1V
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 08:07:27 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBCL0fTC040989
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 16:07:25 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27a1g7858g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 16:07:25 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Mon, 12 Dec 2016 16:07:24 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9995A38C8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 16:07:22 -0500 (EST)
Subject: [PATCH 2/2] powerpc/pseries: Update affinity for memory and cpus
 specified in a PRRN event
To: linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>
References: <7125fe8e-60f9-2152-d159-0f4c07183547@linux.vnet.ibm.com>
From: John Allen <jallen@linux.vnet.ibm.com>
Date: Mon, 12 Dec 2016 15:07:21 -0600
MIME-Version: 1.0
In-Reply-To: <7125fe8e-60f9-2152-d159-0f4c07183547@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <ef52e969-62f8-7b2c-2928-07cb1081111b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Extend the existing PRRN infrastructure to perform the actual affinity
updating for cpus and memory in addition to the device tree updating. For
cpus, dynamic affinity updating already appears to exist in the kernel in
the form of arch_update_cpu_topology. For memory, we must place a READD
operation on the hotplug queue for any phandle included in the PRRN event
that is determined to be an LMB.

Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
---
diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index a26a020..8836130 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -21,6 +21,7 @@
 #include <linux/cpu.h>
 #include <linux/workqueue.h>
 #include <linux/slab.h>
+#include <linux/topology.h>

 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -282,6 +283,7 @@ static void prrn_work_fn(struct work_struct *work)
 	 * the RTAS event.
 	 */
 	pseries_devicetree_update(-prrn_update_scope);
+	arch_update_cpu_topology();
 }

 static DECLARE_WORK(prrn_work, prrn_work_fn);
@@ -434,7 +436,10 @@ static void do_event_scan(void)
 		}

 		if (error == 0) {
-			pSeries_log_error(logdata, ERR_TYPE_RTAS_LOG, 0);
+			if (rtas_error_type((struct rtas_error_log *)logdata) !=
+			    RTAS_TYPE_PRRN)
+				pSeries_log_error(logdata, ERR_TYPE_RTAS_LOG,
+						  0);
 			handle_rtas_event((struct rtas_error_log *)logdata);
 		}

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index a560a98..e2ed2d6 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -39,6 +39,7 @@ struct update_props_workarea {
 #define ADD_DT_NODE	0x03000000

 #define MIGRATION_SCOPE	(1)
+#define PRRN_SCOPE -2

 static int mobility_rtas_call(int token, char *buf, s32 scope)
 {
@@ -236,6 +237,49 @@ static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
 	return rc;
 }

+void pseries_prrn_update_node(__be32 phandle)
+{
+	struct pseries_hp_errorlog *hp_elog;
+	struct completion hotplug_done;
+	struct device_node *dn;
+	char *type;
+	int rc = 0;
+
+	hp_elog = kzalloc(sizeof(*hp_elog), GFP_KERNEL);
+	if (!hp_elog)
+		return;
+
+	dn = of_find_node_by_phandle(be32_to_cpu(phandle));
+
+	/*
+	 * If the phandle was not found, assume phandle is the drc index of
+	 * an LMB.
+	 */
+	if (!dn) {
+		type = "memory";
+		hp_elog->resource = PSERIES_HP_ELOG_RESOURCE_MEM;
+		hp_elog->action = PSERIES_HP_ELOG_ACTION_READD;
+		hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
+		hp_elog->_drc_u.drc_index = cpu_to_be32(phandle);
+
+		pr_info("Attempting to update %s at drc index %x\n", type,
+			hp_elog->_drc_u.drc_index);
+
+		init_completion(&hotplug_done);
+		queue_hotplug_event(hp_elog, &hotplug_done, &rc);
+		wait_for_completion(&hotplug_done);
+
+		if (rc)
+			pr_info("Failed to update %s at drc index %x\n", type,
+				hp_elog->_drc_u.drc_index);
+		else
+			pr_info("Updated %s at drc index %x\n", type,
+				hp_elog->_drc_u.drc_index);
+	}
+
+	kfree(hp_elog);
+}
+
 int pseries_devicetree_update(s32 scope)
 {
 	char *rtas_buf;
@@ -274,6 +318,10 @@ int pseries_devicetree_update(s32 scope)
 					break;
 				case UPDATE_DT_NODE:
 					update_dt_node(phandle, scope);
+
+					if (scope == PRRN_SCOPE)
+						pseries_prrn_update_node(phandle);
+
 					break;
 				case ADD_DT_NODE:
 					drc_index = *data++;
