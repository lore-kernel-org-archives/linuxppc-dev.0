Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mYJs20KGzDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 02:15:56 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w79G9Ux5054048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Aug 2018 12:15:54 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2krnmjhfrn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Aug 2018 12:15:54 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 9 Aug 2018 10:15:53 -0600
Subject: Re: [PATCH v3 2/2] powerpc/pseries: Wait for completion of hotplug
 events during PRRN handling
To: John Allen <jallen@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Cc: desnesn@linux.vnet.ibm.com
References: <20180808152926.28842-1-jallen@linux.ibm.com>
 <20180808152926.28842-3-jallen@linux.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Thu, 9 Aug 2018 11:15:48 -0500
MIME-Version: 1.0
In-Reply-To: <20180808152926.28842-3-jallen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <5a15ca87-74ae-171f-1506-b0bc5cee11bc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/08/2018 10:29 AM, John Allen wrote:
> While handling PRRN events, the time to handle the actual hotplug events
> dwarfs the time it takes to perform the device tree updates and queue the
> hotplug events. In the case that PRRN events are being queued continuously,
> hotplug events have been observed to be queued faster than the kernel can
> actually handle them. This patch avoids the problem by waiting for a
> hotplug request to complete before queueing more hotplug events.
> 
> Signed-off-by: John Allen <jallen@linux.ibm.com>

In the V2 thread it was mentioned that we could just call the DLPAR operation
directly instead of going through the workqueue. I have written a patch to do
this that also cleans up some of the request handling.

requests that come through the hotplug interrupt still use the workqueue. The
other requests, PRRN and sysfs, just call the dlpar handler directly. This
eliminates the need for a wait conditional and return code handling in the
workqueue handler and should solve the issue that John solves with his patch.

This still needs testing but wanted to get people's thoughts.

-Nathan

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
index 14a46b07ab2f..25b48994cd60 100644
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
 
