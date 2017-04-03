Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxZvJ5Jz4zDqK3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 00:57:00 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v33EsRtX008498
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Apr 2017 10:56:47 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29kqbjw5q7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 10:56:47 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 00:56:44 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v33EuXCI53215432
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 00:56:41 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v33Eu5bn026228
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 00:56:06 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v6 04/11] powerpc/perf: Add event attribute and group to IMC
 pmus
Date: Mon,  3 Apr 2017 20:25:01 +0530
In-Reply-To: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1491231308-15282-5-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hemant Kumar <hemant@linux.vnet.ibm.com>

Device tree IMC driver code parses the IMC units and their events. It
passes the information to IMC pmu code which is placed in powerpc/perf
as "imc-pmu.c".

This patch creates only event attributes and attribute groups for the
IMC pmus.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/Makefile                |  6 +-
 arch/powerpc/perf/imc-pmu.c               | 97 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-imc.c | 12 +++-
 3 files changed, 112 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/perf/imc-pmu.c

diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index 4d606b99a5cb..d0d1f04203c7 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -2,10 +2,14 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 obj-$(CONFIG_PERF_EVENTS)	+= callchain.o perf_regs.o
 
+imc-$(CONFIG_PPC_POWERNV)       += imc-pmu.o
+
 obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o bhrb.o
 obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
 				   power5+-pmu.o power6-pmu.o power7-pmu.o \
-				   isa207-common.o power8-pmu.o power9-pmu.o
+				   isa207-common.o power8-pmu.o power9-pmu.o \
+				   $(imc-y)
+
 obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
 
 obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
new file mode 100644
index 000000000000..ec464c76b749
--- /dev/null
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -0,0 +1,97 @@
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
+#include <asm/imc-pmu.h>
+#include <asm/cputhreads.h>
+#include <asm/smp.h>
+#include <linux/string.h>
+
+struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
+struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
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
+static int update_events_in_group(struct imc_events *events,
+				  int idx, struct imc_pmu *pmu)
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
+ * init_imc_pmu : Setup the IMC pmu device in "pmu_ptr" and its events
+ *                "events".
+ * Setup the cpu mask information for these pmus and setup the state machine
+ * hotplug notifiers as well.
+ */
+int init_imc_pmu(struct imc_events *events, int idx,
+		 struct imc_pmu *pmu_ptr)
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
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index ba0203e669c0..73c46703c2af 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -32,8 +32,11 @@
 #include <asm/cputable.h>
 #include <asm/imc-pmu.h>
 
-struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
-struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
+extern struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
+extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
+
+extern int init_imc_pmu(struct imc_events *events,
+			int idx, struct imc_pmu *pmu_ptr);
 
 static int imc_event_info(char *name, struct imc_events *events)
 {
@@ -379,6 +382,11 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index)
 		idx += ret;
 	}
 
+	ret = init_imc_pmu(events, idx, pmu_ptr);
+	if (ret) {
+		pr_err("IMC PMU %s Register failed\n", pmu_ptr->pmu.name);
+		goto free_events;
+	}
 	return 0;
 
 free_events:
-- 
2.7.4
