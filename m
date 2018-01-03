Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zBkDQ19GNzDqls
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jan 2018 08:13:09 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 w03L8gra008982
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jan 2018 16:13:07 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2f92mmudhu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jan 2018 16:13:07 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Wed, 3 Jan 2018 16:13:05 -0500
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, david@gibson.dropbear.id.au, benh@au1.ibm.com
Subject: [PATCH v3 1/1] powerpc/pseries: Make RAS IRQ explicitly dependent on
 DLPAR WQ
Date: Wed,  3 Jan 2018 19:12:52 -0200
In-Reply-To: <20180103211252.24615-1-joserz@linux.vnet.ibm.com>
References: <20180103211252.24615-1-joserz@linux.vnet.ibm.com>
Message-Id: <20180103211252.24615-2-joserz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hotplug engine uses its own workqueue to handle IRQ requests, the
problem is that such workqueue is initialized after init_ras_IRQ, which
will cause a kernel panic if any hotplug interruption is issued in that
period of time.

This patch makes RAS IRQ registration explicitly dependent on DLPAR
workqueue and adds a check to make sure that the workqueue is not
initialized more than once.

Reported-by: Min Deng <mdeng@redhat.com>
Reported-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Tested-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/dlpar.c   | 21 ++++++++++++++++++---
 arch/powerpc/platforms/pseries/pseries.h |  2 ++
 arch/powerpc/platforms/pseries/ras.c     |  3 ++-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 6e35780c5962..a0b20c03f078 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -574,11 +574,26 @@ static ssize_t dlpar_show(struct class *class, struct class_attribute *attr,
 
 static CLASS_ATTR_RW(dlpar);
 
-static int __init pseries_dlpar_init(void)
+int __init dlpar_workqueue_init(void)
 {
+	if (pseries_hp_wq)
+		return 0;
+
 	pseries_hp_wq = alloc_workqueue("pseries hotplug workqueue",
-					WQ_UNBOUND, 1);
+			WQ_UNBOUND, 1);
+
+	return pseries_hp_wq ? 0 : -ENOMEM;
+}
+
+static int __init dlpar_sysfs_init(void)
+{
+	int rc;
+
+	rc = dlpar_workqueue_init();
+	if (rc)
+		return rc;
+
 	return sysfs_create_file(kernel_kobj, &class_attr_dlpar.attr);
 }
-machine_device_initcall(pseries, pseries_dlpar_init);
+machine_device_initcall(pseries, dlpar_sysfs_init);
 
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 4470a3194311..1ae1d9f4dbe9 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -98,4 +98,6 @@ static inline unsigned long cmo_get_page_size(void)
 	return CMO_PageSize;
 }
 
+int dlpar_workqueue_init(void);
+
 #endif /* _PSERIES_PSERIES_H */
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 4923ffe230cf..81d8614e7379 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -69,7 +69,8 @@ static int __init init_ras_IRQ(void)
 	/* Hotplug Events */
 	np = of_find_node_by_path("/event-sources/hot-plug-events");
 	if (np != NULL) {
-		request_event_sources_irqs(np, ras_hotplug_interrupt,
+		if (dlpar_workqueue_init() == 0)
+			request_event_sources_irqs(np, ras_hotplug_interrupt,
 					   "RAS_HOTPLUG");
 		of_node_put(np);
 	}
-- 
2.14.1
