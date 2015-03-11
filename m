Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C67DE1A0ABE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:36 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 23:08:36 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1152A3578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:34 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2BD8PuD44564640
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:34 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2BD80Hh011825
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:00 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 5/7]powerpc/powernv: Add POWER8 specific nest pmu support
Date: Wed, 11 Mar 2015 18:37:11 +0530
Message-Id: <1426079233-16720-6-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1426079233-16720-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1426079233-16720-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: ak@linux.intel.com, srivatsa@mit.edu, linux-kernel@vger.kernel.org,
 eranian@google.com, linuxppc-dev@ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch enables POWER8 specific nest pmu support. It defines
pmu functions in a generic way that it can be shared across 
different nest units. Event id is used, to identify the 
offset in memory to read from. And the offset information
is saved in the per-chip data strucutres which are populated
at the time of device-tree parsing.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/uncore_pmu.c    |   4 +
 arch/powerpc/perf/uncore_pmu_p8.c | 167 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+)
 create mode 100644 arch/powerpc/perf/uncore_pmu_p8.c

diff --git a/arch/powerpc/perf/uncore_pmu.c b/arch/powerpc/perf/uncore_pmu.c
index 67ab6c0..504c6ac 100644
--- a/arch/powerpc/perf/uncore_pmu.c
+++ b/arch/powerpc/perf/uncore_pmu.c
@@ -242,6 +242,10 @@ static int __init uncore_init(void)
 	    !cpu_has_feature(CPU_FTR_HVMODE))
 		return ret;
 
+	ret = uncore_p8_init();
+	if (ret)
+		return ret;
+
 	ret = uncore_types_init(ppc64_uncore);
 	if (ret)
 		return ret;
diff --git a/arch/powerpc/perf/uncore_pmu_p8.c b/arch/powerpc/perf/uncore_pmu_p8.c
new file mode 100644
index 0000000..411c077
--- /dev/null
+++ b/arch/powerpc/perf/uncore_pmu_p8.c
@@ -0,0 +1,167 @@
+/*
+ * Uncore Performance Monitor counter support for POWER8 processors.
+ *
+ * Copyright 2015, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version
+ * 2 of the License
+ */
+
+#include "uncore_pmu.h"
+
+#define P8_UNCORE_EVENT_MASK    0xFF
+#define P8_UNCORE_ENGINE_START	0x1
+#define P8_UNCORE_ENGINE_STOP	0
+
+extern struct ppc64_uncore_type **ppc64_uncore;
+static struct ppc64_uncore_unit uncore_per_chip[P8_MAX_CHIP];
+
+struct attribute *p8_uncore_event_attrs[MAX_TYPE_EVENTS];
+struct ppc64_uncore_type *p8_uncore[MAX_UNITS_SUPPORTED];
+
+/*
+ * percpu variable for refcount for uncore events.
+ */
+DEFINE_PER_CPU(uint32_t, uncore_refcnt);
+
+PMU_FORMAT_ATTR(event, "config:0-7");
+
+static struct attribute *p8_uncore_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group p8_uncore_format_group = {
+	.name = "format",
+	.attrs = p8_uncore_format_attrs,
+};
+
+int p8_uncore_event_init(struct perf_event *event)
+{
+	struct ppc64_uncore_pmu *pmu;
+	struct ppc64_uncore_type *type;
+	int chip_id, cfg;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* Sampling not supported yet */
+	if (event->hw.sample_period)
+		return -EINVAL;
+
+	/* unsupported modes and filters */
+	if (event->attr.exclude_user   ||
+	    event->attr.exclude_kernel ||
+	    event->attr.exclude_hv     ||
+	    event->attr.exclude_idle   ||
+	    event->attr.exclude_host   ||
+	    event->attr.exclude_guest  ||
+	    event->attr.sample_period) /* no sampling */
+		return -EINVAL;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	pmu = uncore_event_to_pmu(event);
+	if (!pmu)
+		return -EINVAL;
+
+	if (event->attr.config & ~P8_UNCORE_EVENT_MASK)
+		return -EINVAL;
+
+	/* Event to look for in the offset strucutre */
+	cfg = event->attr.config & P8_UNCORE_EVENT_MASK;
+
+	type = pmu->type;
+	chip_id = topology_physical_package_id(event->cpu);
+
+	/* Mem access address calculation for this event */
+	event->hw.event_base = uncore_per_chip[chip_id].vreg_base;
+	event->hw.event_base += type->event_arry[pmu->pmu_idx].ev_offset[(cfg - 1)];
+
+	return 0;
+}
+
+void p8_uncore_read_counter(struct perf_event *event)
+{
+	uint64_t *ptr;
+
+	ptr = (uint64_t *)event->hw.event_base;
+	local64_set(&event->hw.prev_count, __be64_to_cpu((uint64_t)*ptr));
+}
+
+void p8_uncore_perf_event_update(struct perf_event *event)
+{
+	u64 counter_prev, counter_new, final_count;
+	uint64_t *ptr;
+
+	ptr = (uint64_t *)event->hw.event_base;
+	counter_prev = cpu_to_be64(local64_read(&event->hw.prev_count));
+	counter_new = __be64_to_cpu((uint64_t)*ptr);
+	final_count = counter_new - counter_prev;
+
+	local64_set(&event->hw.prev_count, counter_new);
+	local64_add(final_count, &event->count);
+}
+
+void p8_uncore_event_start(struct perf_event *event, int flags)
+{
+	uint32_t *refcnt = &get_cpu_var(uncore_refcnt);
+
+	event->hw.state = 0;
+	*refcnt += 1;
+
+	if (*refcnt == 1)
+		opal_uncore_control(P8_UNCORE_ENGINE_START);
+
+	p8_uncore_read_counter(event);
+	put_cpu_var(uncore_refcnt);
+}
+
+void p8_uncore_event_stop(struct perf_event *event, int flags)
+{
+	uint32_t *refcnt = &get_cpu_var(uncore_refcnt);
+
+	*refcnt -= 1;
+	if (*refcnt == 0)
+		opal_uncore_control(P8_UNCORE_ENGINE_STOP);
+
+	p8_uncore_perf_event_update(event);
+	put_cpu_var(uncore_refcnt);
+}
+
+int p8_uncore_event_add(struct perf_event *event, int flags)
+{
+	p8_uncore_event_start(event, flags);
+	return 0;
+}
+
+void p8_uncore_event_del(struct perf_event *event, int flags)
+{
+	p8_uncore_event_stop(event, flags);
+}
+
+struct pmu p8_uncore_pmu = {
+	.task_ctx_nr	= perf_invalid_context,
+	.event_init	= p8_uncore_event_init,
+	.add		= p8_uncore_event_add,
+	.del		= p8_uncore_event_del,
+	.start		= p8_uncore_event_start,
+	.stop		= p8_uncore_event_stop,
+	.read		= p8_uncore_perf_event_update,
+};
+
+static int uncore_init(void)
+{
+	return 0;
+}
+
+int uncore_p8_init(void)
+{
+	ppc64_uncore = p8_uncore;
+	return uncore_init();
+}
+
+
-- 
1.9.1
