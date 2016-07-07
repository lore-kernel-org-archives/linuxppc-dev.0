Return-Path: <jallen@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlglX6jJ8zDr0X
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 01:00:08 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u67ExHqi082179
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 11:00:06 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xmfgax-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 11:00:06 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Thu, 7 Jul 2016 09:00:05 -0600
Subject: [PATCH 1/3] powerpc/pseries: Add pseries hotplug workqueue
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <4cf3edf2-fc24-5989-ae5d-b451a2323cf2@linux.vnet.ibm.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
From: John Allen <jallen@linux.vnet.ibm.com>
Date: Thu, 7 Jul 2016 10:00:34 -0500
MIME-Version: 1.0
In-Reply-To: <4cf3edf2-fc24-5989-ae5d-b451a2323cf2@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <f03894c6-edf7-9fcc-c817-6e0ee6234dd6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In support of PAPR changes to add a new hotplug interrupt, introduce a
hotplug workqueue to avoid processing hotplug events in interrupt context.
We will also take advantage of the queue on PowerVM to ensure hotplug
events initiated from different sources (HMC and PRRN events) are handled
and serialized properly.

Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c |   52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 2b93ae8..66a77d7 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -27,6 +27,15 @@
 #include <asm/uaccess.h>
 #include <asm/rtas.h>

+struct workqueue_struct *pseries_hp_wq;
+
+struct pseries_hp_work {
+	struct work_struct work;
+	struct pseries_hp_errorlog *errlog;
+	struct completion *hp_completion;
+	int *rc;
+};
+
 struct cc_workarea {
 	__be32	drc_index;
 	__be32	zero;
@@ -368,10 +377,51 @@ static int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
 	return rc;
 }

+void pseries_hp_work_fn(struct work_struct *work)
+{
+	struct pseries_hp_work *hp_work =
+			container_of(work, struct pseries_hp_work, work);
+
+	if (hp_work->rc)
+		*(hp_work->rc) = handle_dlpar_errorlog(hp_work->errlog);
+	else
+		handle_dlpar_errorlog(hp_work->errlog);
+
+	if (hp_work->hp_completion)
+		complete(hp_work->hp_completion);
+
+	kfree(hp_work->errlog);
+	kfree((void *)work);
+}
+
+void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
+			 struct completion *hotplug_done, int *rc)
+{
+	struct pseries_hp_work *work;
+	struct pseries_hp_errorlog *hp_errlog_copy;
+
+	hp_errlog_copy = kmalloc(sizeof(struct pseries_hp_errorlog),
+				 GFP_KERNEL);
+	memcpy(hp_errlog_copy, hp_errlog, sizeof(struct pseries_hp_errorlog));
+
+	work = kmalloc(sizeof(struct pseries_hp_work), GFP_KERNEL);
+	if (work) {
+		INIT_WORK((struct work_struct *)work, pseries_hp_work_fn);
+		work->errlog = hp_errlog_copy;
+		work->hp_completion = hotplug_done;
+		work->rc = rc;
+		queue_work(pseries_hp_wq, (struct work_struct *)work);
+	} else {
+		*rc = -ENOMEM;
+		complete(hotplug_done);
+	}
+}
+
 static ssize_t dlpar_store(struct class *class, struct class_attribute *attr,
 			   const char *buf, size_t count)
 {
 	struct pseries_hp_errorlog *hp_elog;
+	struct completion hotplug_done;
 	const char *arg;
 	int rc;

@@ -450,6 +500,8 @@ static CLASS_ATTR(dlpar, S_IWUSR, NULL, dlpar_store);

 static int __init pseries_dlpar_init(void)
 {
+	pseries_hp_wq = alloc_workqueue("pseries hotplug workqueue",
+					WQ_UNBOUND, 1);
 	return sysfs_create_file(kernel_kobj, &class_attr_dlpar.attr);
 }
 machine_device_initcall(pseries, pseries_dlpar_init);
