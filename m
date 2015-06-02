Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 936BB1A0DA1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 02:02:14 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 3 Jun 2015 02:02:14 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 31D0C357804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 02:02:12 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52G0mR548693430
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 02:00:56 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52G0OBd018788
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 02:00:24 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v1 2/9]powerpc/powernv: nest pmu init function with cpumask
 attr
Date: Tue,  2 Jun 2015 21:29:31 +0530
Message-Id: <1433260778-26497-3-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch creates a file "nest-pmu-c" to contain nest pmu related functions.
Patch adds nest pmu init function and cpumask function since Nest pmu units
are per-chip. First online cpu for a given node is picked as
designated thread to read the counter data.

Subsequent patch adds the hotplug support.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/nest-pmu.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 arch/powerpc/perf/nest-pmu.c

diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
new file mode 100644
index 0000000..d4413bb
--- /dev/null
+++ b/arch/powerpc/perf/nest-pmu.c
@@ -0,0 +1,70 @@
+/*
+ * Nest Performance Monitor counter support for POWER8 processors.
+ *
+ * Copyright 2015 Madhavan Srinivasan, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "nest-pmu.h"
+
+static cpumask_t cpu_mask_nest_pmu;
+
+static ssize_t cpumask_nest_pmu_get_attr(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return cpumap_print_to_pagebuf(true, buf, &cpu_mask_nest_pmu);
+}
+
+static DEVICE_ATTR(cpumask, S_IRUGO, cpumask_nest_pmu_get_attr, NULL);
+
+static struct attribute *cpumask_nest_pmu_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static struct attribute_group cpumask_nest_pmu_attr_group = {
+	.attrs = cpumask_nest_pmu_attrs,
+};
+
+void cpumask_chip(void)
+{
+	const struct cpumask *l_cpumask;
+	int cpu, nid;
+
+	if (!cpumask_empty(&cpu_mask_nest_pmu)) {
+		printk(KERN_INFO "cpumask not empty\n");
+		return;
+	}
+
+	cpu_notifier_register_begin();
+	for_each_online_node(nid) {
+		l_cpumask = cpumask_of_node(nid);
+		cpu = cpumask_first(l_cpumask);
+		cpumask_set_cpu(cpu, &cpu_mask_nest_pmu);
+	}
+
+	cpu_notifier_register_done();
+}
+
+
+static int __init nest_pmu_init(void)
+{
+	int ret = 0;
+
+	/*
+	 * Lets do this only if we are hypervisor
+	 */
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	   strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8") ||
+	   !cpu_has_feature(CPU_FTR_HVMODE))
+		return ret;
+
+	cpumask_chip();
+
+	return 0;
+}
+device_initcall(nest_pmu_init);
-- 
1.9.1
