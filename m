Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfmWg23fBzF0j6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 11:19:39 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1C0J8rm105754
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 19:19:37 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g2sak0ggn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 19:19:37 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Mon, 12 Feb 2018 00:19:35 -0000
Date: Mon, 12 Feb 2018 11:19:29 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] powerpc/pseries: Enable RAS hotplug events late
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <b3202827b5f22e9a7e8f145f83140698911641f7.1518394650.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently if the kernel receives a memory hot-unplug event early
enough, it may get stuck in an infinite loop in
dissolve_free_huge_pages(). This appears as a stall just after:

pseries-hotplug-mem: Attempting to hot-remove XX LMB(s) at YYYYYYYY

It appears to be caused by "minimum_order" being uninitialized, due to
init_ras_IRQ() executing before hugetlb_init().

To correct this, extract the part of init_ras_IRQ() that enables
hotplug event processing and place it in the machine_late_initcall
phase, which is guaranteed to be after hugetlb_init() is called.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 arch/powerpc/platforms/pseries/ras.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 81d8614e7379..ba284949af06 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -66,6 +66,26 @@ static int __init init_ras_IRQ(void)
 		of_node_put(np);
 	}
 
+	/* EPOW Events */
+	np = of_find_node_by_path("/event-sources/epow-events");
+	if (np != NULL) {
+		request_event_sources_irqs(np, ras_epow_interrupt, "RAS_EPOW");
+		of_node_put(np);
+	}
+
+	return 0;
+}
+machine_subsys_initcall(pseries, init_ras_IRQ);
+
+/*
+ * Enable the hotplug interrupt late because processing them may touch other
+ * devices or systems (e.g. hugepages) that have not been initialized at the
+ * subsys stage.
+ */
+int __init init_ras_hotplug_IRQ(void)
+{
+	struct device_node *np;
+
 	/* Hotplug Events */
 	np = of_find_node_by_path("/event-sources/hot-plug-events");
 	if (np != NULL) {
@@ -75,16 +95,9 @@ static int __init init_ras_IRQ(void)
 		of_node_put(np);
 	}
 
-	/* EPOW Events */
-	np = of_find_node_by_path("/event-sources/epow-events");
-	if (np != NULL) {
-		request_event_sources_irqs(np, ras_epow_interrupt, "RAS_EPOW");
-		of_node_put(np);
-	}
-
 	return 0;
 }
-machine_subsys_initcall(pseries, init_ras_IRQ);
+machine_late_initcall(pseries, init_ras_hotplug_IRQ);
 
 #define EPOW_SHUTDOWN_NORMAL				1
 #define EPOW_SHUTDOWN_ON_UPS				2
-- 
2.16.1.74.g9b0b1f47b
