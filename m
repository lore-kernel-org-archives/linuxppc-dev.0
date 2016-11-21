Return-Path: <hemant@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMdWH1WvwzDvg1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:35 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAL68XuE021850
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 01:10:33 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26usccv66x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 01:10:33 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 21 Nov 2016 16:10:30 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EA43E357805B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:27 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAL6ARw850594012
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:27 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAL6ARXK030715
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:27 +1100
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 stewart@linux.vnet.ibm.com, dja@axtens.net, mikey@neuling.org,
 maddy@linux.vnet.ibm.com, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v2 4/6] powerpc/perf: Add event attribute and group to IMA pmus
Date: Mon, 21 Nov 2016 11:40:03 +0530
In-Reply-To: <1479708605-10238-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1479708605-10238-1-git-send-email-hemant@linux.vnet.ibm.com>
Message-Id: <1479708605-10238-5-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Device tree IMA driver code parses the IMA units and their events. It
passes the information to IMA pmu code which is placed in powerpc/perf
as "ima-pmu.c".

This patch creates only event attributes and attribute groups for the
IMA pmus.

Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
Changelog:
v1 -> v2:
 - Changes to Makefile to only enable this feature for
   CONFIG_PPC_POWERNV=y

 arch/powerpc/perf/Makefile                |  6 +-
 arch/powerpc/perf/ima-pmu.c               | 96 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-ima.c | 12 +++-
 3 files changed, 111 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/perf/ima-pmu.c

diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index f102d53..099c61a 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -2,10 +2,14 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 obj-$(CONFIG_PERF_EVENTS)	+= callchain.o perf_regs.o
 
+ima-$(CONFIG_PPC_POWERNV)       += ima-pmu.o
+
 obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o bhrb.o
 obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
 				   power5+-pmu.o power6-pmu.o power7-pmu.o \
-				   isa207-common.o power8-pmu.o power9-pmu.o
+				   isa207-common.o power8-pmu.o power9-pmu.o \
+				   $(ima-y)
+
 obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
 
 obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
diff --git a/arch/powerpc/perf/ima-pmu.c b/arch/powerpc/perf/ima-pmu.c
new file mode 100644
index 0000000..50d2226
--- /dev/null
+++ b/arch/powerpc/perf/ima-pmu.c
@@ -0,0 +1,96 @@
+/*
+ * Nest Performance Monitor counter support.
+ *
+ * Copyright (C) 2016 Madhavan Srinivasan, IBM Corporation.
+ *	     (C) 2016 Hemant K Shaw, IBM Corporation.
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+#include <asm/opal.h>
+#include <asm/ima-pmu.h>
+#include <asm/cputhreads.h>
+#include <linux/string.h>
+
+struct perchip_nest_info nest_perchip_info[IMA_MAX_CHIPS];
+struct ima_pmu *per_nest_pmu_arr[IMA_MAX_PMUS];
+
+/* dev_str_attr : Populate event "name" and string "str" in attribute */
+static struct attribute *dev_str_attr(const char *name, const char *str)
+{
+	struct perf_pmu_events_attr *attr;
+
+	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+
+	sysfs_attr_init(&attr->attr.attr);
+
+	attr->event_str = str;
+	attr->attr.attr.name = name;
+	attr->attr.attr.mode = 0444;
+	attr->attr.show = perf_event_sysfs_show;
+
+	return &attr->attr.attr;
+}
+
+/*
+ * update_events_in_group: Update the "events" information in an attr_group
+ *                         and assign the attr_group to the pmu "pmu".
+ */
+static int update_events_in_group(struct ima_events *events,
+				  int idx, struct ima_pmu *pmu)
+{
+	struct attribute_group *attr_group;
+	struct attribute **attrs;
+	int i;
+
+	/* Allocate memory for attribute group */
+	attr_group = kzalloc(sizeof(*attr_group), GFP_KERNEL);
+	if (!attr_group)
+		return -ENOMEM;
+
+	/* Allocate memory for attributes */
+	attrs = kzalloc((sizeof(struct attribute *) * (idx + 1)), GFP_KERNEL);
+	if (!attrs) {
+		kfree(attr_group);
+		return -ENOMEM;
+	}
+
+	attr_group->name = "events";
+	attr_group->attrs = attrs;
+	for (i = 0; i < idx; i++, events++) {
+		attrs[i] = dev_str_attr((char *)events->ev_name,
+					(char *)events->ev_value);
+	}
+
+	pmu->attr_groups[0] = attr_group;
+	return 0;
+}
+
+/*
+ * init_ima_pmu : Setup the IMA pmu device in "pmu_ptr" and its events
+ *                "events".
+ * Setup the cpu mask information for these pmus and setup the state machine
+ * hotplug notifiers as well.
+ */
+int init_ima_pmu(struct ima_events *events, int idx,
+		 struct ima_pmu *pmu_ptr)
+{
+	int ret = -ENODEV;
+
+	ret = update_events_in_group(events, idx, pmu_ptr);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	/* Only free the attr_groups which are dynamically allocated  */
+	if (pmu_ptr->attr_groups[0]) {
+		kfree(pmu_ptr->attr_groups[0]->attrs);
+		kfree(pmu_ptr->attr_groups[0]);
+	}
+
+	return ret;
+}
diff --git a/arch/powerpc/platforms/powernv/opal-ima.c b/arch/powerpc/platforms/powernv/opal-ima.c
index e8d5771..d2e6910 100644
--- a/arch/powerpc/platforms/powernv/opal-ima.c
+++ b/arch/powerpc/platforms/powernv/opal-ima.c
@@ -31,8 +31,11 @@
 #include <asm/cputable.h>
 #include <asm/ima-pmu.h>
 
-struct perchip_nest_info nest_perchip_info[IMA_MAX_CHIPS];
-struct ima_pmu *per_nest_pmu_arr[IMA_MAX_PMUS];
+extern struct perchip_nest_info nest_perchip_info[IMA_MAX_CHIPS];
+extern struct ima_pmu *per_nest_pmu_arr[IMA_MAX_PMUS];
+
+extern int init_ima_pmu(struct ima_events *events,
+			int idx, struct ima_pmu *pmu_ptr);
 
 static int ima_event_info(char *name, struct ima_events *events)
 {
@@ -335,6 +338,11 @@ static int ima_pmu_create(struct device_node *parent, int pmu_index)
 		idx += ret;
 	}
 
+	ret = init_ima_pmu(events, idx, pmu_ptr);
+	if (ret) {
+		pr_err("IMA PMU %s Register failed\n", pmu_ptr->pmu.name);
+		goto free_events;
+	}
 	return 0;
 
 free_events:
-- 
2.7.4
