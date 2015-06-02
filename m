Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E1A61A0CFB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 02:01:12 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 3 Jun 2015 02:01:10 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 730B3357804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 02:01:08 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52G10Xx22872080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 02:01:08 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52G0ZBt019160
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 02:00:36 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v1 4/9]powerpc/powernv: Add generic nest pmu ops
Date: Tue,  2 Jun 2015 21:29:33 +0530
Message-Id: <1433260778-26497-5-git-send-email-maddy@linux.vnet.ibm.com>
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

Patch adds generic nest pmu functions and format attribute.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/nest-pmu.c | 107 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
index 3e7010e..345707c 100644
--- a/arch/powerpc/perf/nest-pmu.c
+++ b/arch/powerpc/perf/nest-pmu.c
@@ -134,6 +134,113 @@ void cpumask_chip(void)
 	cpu_notifier_register_done();
 }
 
+PMU_FORMAT_ATTR(event, "config:0-20");
+struct attribute *p8_nest_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+struct attribute_group p8_nest_format_group = {
+	.name = "format",
+	.attrs = p8_nest_format_attrs,
+};
+
+int p8_nest_event_init(struct perf_event *event)
+{
+	int chip_id;
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
+	chip_id = topology_physical_package_id(event->cpu);
+	event->hw.event_base = event->attr.config +
+				p8_perchip_nest_info[chip_id].vbase;
+
+	return 0;
+}
+
+void p8_nest_read_counter(struct perf_event *event)
+{
+	u64 *addr;
+	u64 data = 0;
+
+	addr = (u64 *)event->hw.event_base;
+	data = __be64_to_cpu((uint64_t)*addr);
+	local64_set(&event->hw.prev_count, data);
+}
+
+void p8_nest_perf_event_update(struct perf_event *event)
+{
+	u64 counter_prev, counter_new, final_count;
+	uint64_t *addr;
+
+	addr = (u64 *)event->hw.event_base;
+	counter_prev = local64_read(&event->hw.prev_count);
+	counter_new = __be64_to_cpu((uint64_t)*addr);
+	final_count = counter_new - counter_prev;
+
+	local64_set(&event->hw.prev_count, counter_new);
+	local64_add(final_count, &event->count);
+}
+
+void p8_nest_event_start(struct perf_event *event, int flags)
+{
+	event->hw.state = 0;
+	p8_nest_read_counter(event);
+}
+
+void p8_nest_event_stop(struct perf_event *event, int flags)
+{
+	p8_nest_perf_event_update(event);
+}
+
+int p8_nest_event_add(struct perf_event *event, int flags)
+{
+	p8_nest_event_start(event, flags);
+	return 0;
+}
+
+void p8_nest_event_del(struct perf_event *event, int flags)
+{
+	p8_nest_event_stop(event, flags);
+}
+
+/*
+ * Populate pmu ops in the structure
+ */
+static int update_pmu_ops(struct nest_pmu *pmu)
+{
+	if (!pmu)
+		return -EINVAL;
+
+	pmu->pmu.task_ctx_nr = perf_invalid_context;
+	pmu->pmu.event_init = p8_nest_event_init;
+	pmu->pmu.add = p8_nest_event_add;
+	pmu->pmu.del = p8_nest_event_del;
+	pmu->pmu.start = p8_nest_event_start;
+	pmu->pmu.stop = p8_nest_event_stop;
+	pmu->pmu.read = p8_nest_perf_event_update;
+	pmu->pmu.attr_groups = pmu->attr_groups;
+
+	return 0;
+}
 
 static int __init nest_pmu_init(void)
 {
-- 
1.9.1
