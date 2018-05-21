Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qRFS6k1MzF0jM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 03:52:44 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4LHnAdI001908
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 13:52:42 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j41agc4gd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 13:52:41 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 21 May 2018 13:52:41 -0400
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [RFC v5 3/6] migration/dlpar: Add device readd queuing function
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <6add12e8-acf9-228e-fa04-80e38dbb8f7c@linux.vnet.ibm.com>
Date: Mon, 21 May 2018 12:52:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <a44f908b-03f9-9042-afaa-2a8bb593db4b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

migration/dlpar: This patch adds function dlpar_readd_action()
which will queue a worker function to 'readd' a device in the
system.  Such devices must be identified by a 'resource' type
and a drc_index to be readded.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c   |   14 ++++++++++++++
 arch/powerpc/platforms/pseries/pseries.h |    1 +
 2 files changed, 15 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a0b20c0..a14684e 100644
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
+	hp_elog._drc_u.drc_index = drc_index;
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
