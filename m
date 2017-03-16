Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkKzl4D4LzDqbg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:36:51 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2G7SaAP076418
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:36:41 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297kqk6y62-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:36:40 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 17:36:36 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2G7aR8b51183692
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:36:35 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2G7a1sJ009785
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:36:02 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v5 04/13] powerpc/perf: Add event attribute and group to IMC
 pmus
Date: Thu, 16 Mar 2017 13:04:58 +0530
In-Reply-To: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1489649707-8021-5-git-send-email-maddy@linux.vnet.ibm.com>
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

Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Stephane Eranian <eranian@google.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/Makefile                |  6 +-
 arch/powerpc/perf/imc-pmu.c               | 96 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-imc.c | 12 +++-
 3 files changed, 111 insertions(+), 3 deletions(-)
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
index 000000000000..7b6ce500ddc5
--- /dev/null
+++ b/arch/powerpc/perf/imc-pmu.c
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
+#include <asm/imc-pmu.h>
+#include <asm/cputhreads.h>
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
index 0c076aca87e6..a15e8e64dda0 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -31,8 +31,11 @@
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
@@ -378,6 +381,11 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index)
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
