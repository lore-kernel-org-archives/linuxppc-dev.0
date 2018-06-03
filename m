Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zTYd27NBzF1LY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 06:04:37 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w53K3e1M068132
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Jun 2018 16:04:34 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jc88t4ujv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Jun 2018 16:04:34 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sun, 3 Jun 2018 14:04:33 -0600
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [RFC v9 2/4] hotplug/cpu: Add operation queuing function
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <95c97180-37b7-85da-a82f-17dbc73f5ed6@linux.vnet.ibm.com>
Date: Sun, 3 Jun 2018 15:04:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <703bd384-b38e-d05a-04ac-aae1d60ae6b8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Testing delayed due to internal SAN problems.]

migration/dlpar: This patch adds function dlpar_queue_action()
which will add information about a CPU/Memory 'readd' operation
according to resource type, action code, and DRC index.  Initial
usage is for the 'readd' CPU and Memory blocks identified as
having changed their associativity during a migration event.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in RFC:
  -- Correct drc_index for dlpar_queue_action worker invocation
  -- Correct text of notice
  -- Revise queuing model to save up all of the DLPAR actions for
     later execution.
---
 arch/powerpc/platforms/pseries/dlpar.c   |   51 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pseries.h |    2 +
 2 files changed, 53 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a0b20c0..a1300d2 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -407,6 +407,57 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
 	}
 }
 
+struct DlparWork {
+	struct list_head list;
+	int resource;
+	int action;
+	u32 drc_index;
+} DlparWorkQ;
+
+int dlpar_delayed_queue_action(int resource, int action, u32 drc_index)
+{
+	struct DlparWork *dwq;
+
+	dwq = kmalloc(sizeof(struct DlparWork), GFP_KERNEL);
+	if (!dwq)
+		return -ENOMEM;
+
+	dwq->resource = resource;
+	dwq->action = action;
+	dwq->drc_index = drc_index;
+
+	list_add_tail(&dwq->list, &DlparWorkQ.list);
+
+	return 0;
+}
+
+int dlpar_schedule_delayed_queue(void)
+{
+	struct DlparWork *iter;
+	struct list_head *pos, *q;
+
+	list_for_each_entry(iter, &DlparWorkQ.list, list) {
+	        struct pseries_hp_errorlog hp_elog;
+
+        	hp_elog.resource = iter->resource;
+        	hp_elog.action = iter->action;
+        	hp_elog.id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
+        	hp_elog._drc_u.drc_index = cpu_to_be32(iter->drc_index);
+
+		handle_dlpar_errorlog(&hp_elog);
+	}
+
+	list_for_each_safe(pos, q, &DlparWorkQ.list) {
+		struct DlparWork *tmp;
+
+		tmp = list_entry(pos, struct DlparWork, list);
+		list_del(pos);
+		kfree(tmp);
+	}
+
+	return 0;
+}
+
 static int dlpar_parse_resource(char **cmd, struct pseries_hp_errorlog *hp_elog)
 {
 	char *arg;
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 60db2ee..de73fda 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -61,6 +61,8 @@ extern struct device_node *dlpar_configure_connector(__be32,
 
 void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
 			 struct completion *hotplug_done, int *rc);
+int dlpar_delayed_queue_action(int resource, int action, u32 drc_index);
+int dlpar_schedule_delayed_queue(void);
 #ifdef CONFIG_MEMORY_HOTPLUG
 int dlpar_memory(struct pseries_hp_errorlog *hp_elog);
 #else
