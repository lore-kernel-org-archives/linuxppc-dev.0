Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41djwH5BT5zF12F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 23:19:27 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6TDIhxq032902
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 09:19:24 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kh5eyv82b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 09:19:24 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sun, 29 Jul 2018 07:19:23 -0600
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v08 2/5] hotplug/cpu: Add operation queuing function
Date: Sun, 29 Jul 2018 08:19:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <a36eec91-f514-87ea-ea6e-b13bf2f46109@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<9573dc30-01ad-2650-c247-28df08875cef@linux.vnet.ibm.com>hotplug/cpu: This patch adds function dlpar_queue_action() which
will queued up information about a CPU/Memory 'readd' operation
according to resource type, action code, and DRC index.  Examples
of such operations include 'readd' of CPU and Memory blocks
identified as having changed their associativity during an LPAR
migration event.

At a subsequent point, the list of operations can be run/played
in series from a worker function added to the pseries work queue.
In the case of 'migration_store', the code has identified a set
of post migration topology changes to be applied.  There may be
a small number of CPU and memory changes to apply on small systems.
On large SAP HANA systems though, there may changes to thousands
and thousands of CPUs and memory blocks.  Applying these changes
may take a significant amount of time -- much longer than the
timeouts used by an associated HMC.  In order to avoid such
timeout errors, the worker queue implementation allows the code
to exit 'migration_store' with a good status, and then apply the
changes to CPUs and memory blocks afterward.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in patch:
  -- Correct drc_index before adding to pseries_hp_errorlog struct
  -- Correct text of notice
  -- Revise queuing model to save up all of the DLPAR actions for
     later execution.
  -- Restore list init statement missing from patch
  -- Move call to apply queued operations into 'mobility.c'
  -- Compress some code
  -- Rename some of queueing function APIs
  -- Revise implementation to push execution of queued operations
     to a workqueue task.
  -- Cleanup reference to outdated queuing operation.
  -- Add more information to patch description.
  -- Remove sleep calls from new code.
---
 arch/powerpc/include/asm/rtas.h           |    2 +
 arch/powerpc/platforms/pseries/dlpar.c    |   57 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/mobility.c |    4 ++
 arch/powerpc/platforms/pseries/pseries.h  |    2 +
 4 files changed, 65 insertions(+)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 71e393c..4f601c7 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -310,12 +310,14 @@ struct pseries_hp_errorlog {
 		struct { __be32 count, index; } ic;
 		char	drc_name[1];
 	} _drc_u;
+	struct list_head list;
 };
 
 #define PSERIES_HP_ELOG_RESOURCE_CPU	1
 #define PSERIES_HP_ELOG_RESOURCE_MEM	2
 #define PSERIES_HP_ELOG_RESOURCE_SLOT	3
 #define PSERIES_HP_ELOG_RESOURCE_PHB	4
+#define PSERIES_HP_ELOG_RESOURCE_PMT	5
 
 #define PSERIES_HP_ELOG_ACTION_ADD	1
 #define PSERIES_HP_ELOG_ACTION_REMOVE	2
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a0b20c0..13ac1cc 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -25,6 +25,7 @@
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <linux/uaccess.h>
+#include <linux/delay.h>
 #include <asm/rtas.h>
 
 static struct workqueue_struct *pseries_hp_wq;
@@ -329,6 +330,8 @@ int dlpar_release_drc(u32 drc_index)
 	return 0;
 }
 
+static int dlpar_pmt(struct pseries_hp_errorlog *work);
+
 static int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
 {
 	int rc;
@@ -357,6 +360,9 @@ static int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
 	case PSERIES_HP_ELOG_RESOURCE_CPU:
 		rc = dlpar_cpu(hp_elog);
 		break;
+	case PSERIES_HP_ELOG_RESOURCE_PMT:
+		rc = dlpar_pmt(hp_elog);
+		break;
 	default:
 		pr_warn_ratelimited("Invalid resource (%d) specified\n",
 				    hp_elog->resource);
@@ -407,6 +413,57 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
 	}
 }
 
+LIST_HEAD(dlpar_delayed_list);
+
+int dlpar_queue_action(int resource, int action, u32 drc_index)
+{
+	struct pseries_hp_errorlog *hp_errlog;
+
+	hp_errlog = kmalloc(sizeof(struct pseries_hp_errorlog), GFP_KERNEL);
+	if (!hp_errlog)
+		return -ENOMEM;
+
+	hp_errlog->resource = resource;
+	hp_errlog->action = action;
+	hp_errlog->id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
+	hp_errlog->_drc_u.drc_index = cpu_to_be32(drc_index);
+
+	list_add_tail(&hp_errlog->list, &dlpar_delayed_list);
+
+	return 0;
+}
+
+static int dlpar_pmt(struct pseries_hp_errorlog *work)
+{
+	struct list_head *pos, *q;
+
+	list_for_each_safe(pos, q, &dlpar_delayed_list) {
+		struct pseries_hp_errorlog *tmp;
+
+		tmp = list_entry(pos, struct pseries_hp_errorlog, list);
+		handle_dlpar_errorlog(tmp);
+
+		list_del(pos);
+		kfree(tmp);
+	}
+
+	return 0;
+}
+
+int dlpar_queued_actions_run(void)
+{
+	if (!list_empty(&dlpar_delayed_list)) {
+		struct pseries_hp_errorlog hp_errlog;
+
+		hp_errlog.resource = PSERIES_HP_ELOG_RESOURCE_PMT;
+		hp_errlog.action = 0;
+		hp_errlog.id_type = 0;
+
+		queue_hotplug_event(&hp_errlog, 0, 0);
+	}
+	return 0;
+}
+
 static int dlpar_parse_resource(char **cmd, struct pseries_hp_errorlog *hp_elog)
 {
 	char *arg;
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index f6364d9..d0d1cae 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -378,6 +378,10 @@ static ssize_t migration_store(struct class *class,
 		return rc;
 
 	post_mobility_fixup();
+
+	/* Apply any necessary changes identified during fixup */
+	dlpar_queued_actions_run();
+
 	return count;
 }
 
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 60db2ee..72ca996 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -61,6 +61,8 @@ extern struct device_node *dlpar_configure_connector(__be32,
 
 void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
 			 struct completion *hotplug_done, int *rc);
+int dlpar_queue_action(int resource, int action, u32 drc_index);
+int dlpar_queued_actions_run(void);
 #ifdef CONFIG_MEMORY_HOTPLUG
 int dlpar_memory(struct pseries_hp_errorlog *hp_elog);
 #else
