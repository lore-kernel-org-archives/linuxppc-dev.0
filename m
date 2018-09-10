Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428BWn25RLzF3Dh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 01:18:29 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8AFF1g4125451
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 11:18:25 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mdt3eug8t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 11:18:25 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 10 Sep 2018 11:18:24 -0400
Subject: [PATCH v5 2/2] powerpc/pseries:Remove unneeded uses of dlpar work
 queue
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: johnallen3991@gmail.com, desnesn@linux.vnet.ibm.com,
 haren@linux.vnet.ibm.com, pmac@au1.ibm.com
Date: Mon, 10 Sep 2018 09:57:07 -0500
In-Reply-To: <153659128238.7764.14440832607437622051.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <153659128238.7764.14440832607437622051.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153659142683.7764.14082769051437367416.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are three instances in which dlpar hotplug events are invoked;
handling a hotplug interrupt (in a kvm guest), handling a dlpar
request through sysfs, and updating LMB affinity when handling a
PRRN event. Only in the case of handling a hotplug interrupt do we
have to put the work on a workqueue, the other cases can handle the
dlpar request directly.

This patch exports the handle_dlpar_errorlog() function so that
dlpar hotplug events can be handled directly and updates the two
instances mentioned above to use the direct invocation.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c    |   37 +++++++----------------------
 arch/powerpc/platforms/pseries/mobility.c |   18 +++++---------
 arch/powerpc/platforms/pseries/pseries.h  |    5 ++--
 arch/powerpc/platforms/pseries/ras.c      |    2 +-
 4 files changed, 19 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a0b20c03f078..052c4f2ba0a0 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -32,8 +32,6 @@ static struct workqueue_struct *pseries_hp_wq;
 struct pseries_hp_work {
 	struct work_struct work;
 	struct pseries_hp_errorlog *errlog;
-	struct completion *hp_completion;
-	int *rc;
 };
 
 struct cc_workarea {
@@ -329,7 +327,7 @@ int dlpar_release_drc(u32 drc_index)
 	return 0;
 }
 
-static int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
+int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
 {
 	int rc;
 
@@ -371,20 +369,13 @@ static void pseries_hp_work_fn(struct work_struct *work)
 	struct pseries_hp_work *hp_work =
 			container_of(work, struct pseries_hp_work, work);
 
-	if (hp_work->rc)
-		*(hp_work->rc) = handle_dlpar_errorlog(hp_work->errlog);
-	else
-		handle_dlpar_errorlog(hp_work->errlog);
-
-	if (hp_work->hp_completion)
-		complete(hp_work->hp_completion);
+	handle_dlpar_errorlog(hp_work->errlog);
 
 	kfree(hp_work->errlog);
 	kfree((void *)work);
 }
 
-void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
-			 struct completion *hotplug_done, int *rc)
+void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog)
 {
 	struct pseries_hp_work *work;
 	struct pseries_hp_errorlog *hp_errlog_copy;
@@ -397,13 +388,9 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
 	if (work) {
 		INIT_WORK((struct work_struct *)work, pseries_hp_work_fn);
 		work->errlog = hp_errlog_copy;
-		work->hp_completion = hotplug_done;
-		work->rc = rc;
 		queue_work(pseries_hp_wq, (struct work_struct *)work);
 	} else {
-		*rc = -ENOMEM;
 		kfree(hp_errlog_copy);
-		complete(hotplug_done);
 	}
 }
 
@@ -521,18 +508,15 @@ static int dlpar_parse_id_type(char **cmd, struct pseries_hp_errorlog *hp_elog)
 static ssize_t dlpar_store(struct class *class, struct class_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct pseries_hp_errorlog *hp_elog;
-	struct completion hotplug_done;
+	struct pseries_hp_errorlog hp_elog;
 	char *argbuf;
 	char *args;
 	int rc;
 
 	args = argbuf = kstrdup(buf, GFP_KERNEL);
-	hp_elog = kzalloc(sizeof(*hp_elog), GFP_KERNEL);
-	if (!hp_elog || !argbuf) {
+	if (!argbuf) {
 		pr_info("Could not allocate resources for DLPAR operation\n");
 		kfree(argbuf);
-		kfree(hp_elog);
 		return -ENOMEM;
 	}
 
@@ -540,25 +524,22 @@ static ssize_t dlpar_store(struct class *class, struct class_attribute *attr,
 	 * Parse out the request from the user, this will be in the form:
 	 * <resource> <action> <id_type> <id>
 	 */
-	rc = dlpar_parse_resource(&args, hp_elog);
+	rc = dlpar_parse_resource(&args, &hp_elog);
 	if (rc)
 		goto dlpar_store_out;
 
-	rc = dlpar_parse_action(&args, hp_elog);
+	rc = dlpar_parse_action(&args, &hp_elog);
 	if (rc)
 		goto dlpar_store_out;
 
-	rc = dlpar_parse_id_type(&args, hp_elog);
+	rc = dlpar_parse_id_type(&args, &hp_elog);
 	if (rc)
 		goto dlpar_store_out;
 
-	init_completion(&hotplug_done);
-	queue_hotplug_event(hp_elog, &hotplug_done, &rc);
-	wait_for_completion(&hotplug_done);
+	rc = handle_dlpar_errorlog(&hp_elog);
 
 dlpar_store_out:
 	kfree(argbuf);
-	kfree(hp_elog);
 
 	if (rc)
 		pr_err("Could not handle DLPAR request \"%s\"\n", buf);
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index f0e30dc94988..6f27d00505cf 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -242,7 +242,7 @@ static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
 
 static void prrn_update_node(__be32 phandle)
 {
-	struct pseries_hp_errorlog *hp_elog;
+	struct pseries_hp_errorlog hp_elog;
 	struct device_node *dn;
 
 	/*
@@ -255,18 +255,12 @@ static void prrn_update_node(__be32 phandle)
 		return;
 	}
 
-	hp_elog = kzalloc(sizeof(*hp_elog), GFP_KERNEL);
-	if(!hp_elog)
-		return;
-
-	hp_elog->resource = PSERIES_HP_ELOG_RESOURCE_MEM;
-	hp_elog->action = PSERIES_HP_ELOG_ACTION_READD;
-	hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
-	hp_elog->_drc_u.drc_index = phandle;
-
-	queue_hotplug_event(hp_elog, NULL, NULL);
+	hp_elog.resource = PSERIES_HP_ELOG_RESOURCE_MEM;
+	hp_elog.action = PSERIES_HP_ELOG_ACTION_READD;
+	hp_elog.id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
+	hp_elog._drc_u.drc_index = phandle;
 
-	kfree(hp_elog);
+	handle_dlpar_errorlog(&hp_elog);
 }
 
 int pseries_devicetree_update(s32 scope)
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 60db2ee511fb..9310a20aef44 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -59,8 +59,9 @@ extern int dlpar_detach_node(struct device_node *);
 extern int dlpar_acquire_drc(u32 drc_index);
 extern int dlpar_release_drc(u32 drc_index);
 
-void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
-			 struct completion *hotplug_done, int *rc);
+void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog);
+int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_errlog);
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 int dlpar_memory(struct pseries_hp_errorlog *hp_elog);
 #else
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 851ce326874a..85a607d52014 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -238,7 +238,7 @@ static irqreturn_t ras_hotplug_interrupt(int irq, void *dev_id)
 	 */
 	if (hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_MEM ||
 	    hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_CPU)
-		queue_hotplug_event(hp_elog, NULL, NULL);
+		queue_hotplug_event(hp_elog);
 	else
 		log_error(ras_log_buf, ERR_TYPE_RTAS_LOG, 0);
 
