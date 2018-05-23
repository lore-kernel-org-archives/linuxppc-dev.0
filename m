Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rCrY2M2RzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 10:22:21 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4N0KQWO017271
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 20:22:18 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j4t0w0urh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 20:22:18 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 22 May 2018 18:22:17 -0600
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [RFC v7 3/7] migration/dlpar: Add operation queuing function
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <b9c98429-f3d7-1e6d-603f-6ac01225e400@linux.vnet.ibm.com>
Date: Tue, 22 May 2018 19:22:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <6e06c3f0-9df4-c7ef-9dcf-62d93cdab838@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

migration/dlpar: This patch adds function dlpar_queue_action()
which will queue a worker function to invoke an operation
according to resource type, action code, and DRC index.  Initial
usage is for the 'readd' CPU and Memory blocks identified as
having changed their associativity during a migration event.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in RFC:
  -- Correct drc_index for dlpar_queue_action worker invocation
  -- Correct text of notice
---
 arch/powerpc/platforms/pseries/dlpar.c   |   14 ++++++++++++++
 arch/powerpc/platforms/pseries/pseries.h |    1 +
 2 files changed, 15 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a0b20c0..1376f50 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -407,6 +407,20 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
 	}
 }
 
+int dlpar_queue_action(int resource, int action, u32 drc_index)
+{
+	struct pseries_hp_errorlog hp_elog;
+
+	hp_elog.resource = resource;
+	hp_elog.action = action;
+	hp_elog.id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
+	hp_elog._drc_u.drc_index = cpu_to_be32(drc_index);
+
+	queue_hotplug_event(&hp_elog, NULL, NULL);
+
+	return 0;
+}
+
 static int dlpar_parse_resource(char **cmd, struct pseries_hp_errorlog *hp_elog)
 {
 	char *arg;
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 60db2ee..cb2beb1 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -61,6 +61,7 @@ extern struct device_node *dlpar_configure_connector(__be32,
 
 void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
 			 struct completion *hotplug_done, int *rc);
+extern int dlpar_queue_action(int resource, int action, u32 drc_index);
 #ifdef CONFIG_MEMORY_HOTPLUG
 int dlpar_memory(struct pseries_hp_errorlog *hp_elog);
 #else
