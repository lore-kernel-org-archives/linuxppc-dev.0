Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 455021A0FCB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 19:57:25 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 15:27:20 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5FCE0125804B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 15:29:57 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5P9vA5V2883880
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 15:27:11 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5P9v9fM004335
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 15:27:10 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v3 6/7]powerpc/powernv: generic nest pmu event functions
Date: Thu, 25 Jun 2015 15:26:18 +0530
Message-Id: <1435226179-28618-7-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1435226179-28618-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1435226179-28618-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add set of generic nest pmu related event functions to be used by
each nest pmu. Add code to register nest pmus.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/nest-pmu.c | 104 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
index 20ed9f8..c2ada13 100644
--- a/arch/powerpc/perf/nest-pmu.c
+++ b/arch/powerpc/perf/nest-pmu.c
@@ -24,6 +24,100 @@ struct attribute_group p8_nest_format_group = {
 	.attrs = p8_nest_format_attrs,
 };
 
+static int p8_nest_event_init(struct perf_event *event)
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
+	    event->attr.exclude_guest)
+		return -EINVAL;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	chip_id = topology_physical_package_id(event->cpu);
+	event->hw.event_base = event->attr.config +
+					p8_nest_perchip_info[chip_id].vbase;
+
+	return 0;
+}
+
+static void p8_nest_read_counter(struct perf_event *event)
+{
+	uint64_t *addr;
+	u64 data = 0;
+
+	addr = (u64 *)event->hw.event_base;
+	data = __be64_to_cpu(*addr);
+	local64_set(&event->hw.prev_count, data);
+}
+
+static void p8_nest_perf_event_update(struct perf_event *event)
+{
+	u64 counter_prev, counter_new, final_count;
+	uint64_t *addr;
+
+	addr = (uint64_t *)event->hw.event_base;
+	counter_prev = local64_read(&event->hw.prev_count);
+	counter_new = __be64_to_cpu(*addr);
+	final_count = counter_new - counter_prev;
+
+	local64_set(&event->hw.prev_count, counter_new);
+	local64_add(final_count, &event->count);
+}
+
+static void p8_nest_event_start(struct perf_event *event, int flags)
+{
+	event->hw.state = 0;
+	p8_nest_read_counter(event);
+}
+
+static void p8_nest_event_stop(struct perf_event *event, int flags)
+{
+	if (flags & PERF_EF_UPDATE)
+		p8_nest_perf_event_update(event);
+}
+
+static int p8_nest_event_add(struct perf_event *event, int flags)
+{
+	if (flags & PERF_EF_START)
+		p8_nest_event_start(event, flags);
+
+	return 0;
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
+	pmu->pmu.del = p8_nest_event_stop;
+	pmu->pmu.start = p8_nest_event_start;
+	pmu->pmu.stop = p8_nest_event_stop;
+	pmu->pmu.read = p8_nest_perf_event_update;
+	pmu->pmu.attr_groups = pmu->attr_groups;
+
+	return 0;
+}
+
 static int nest_event_info(struct property *pp, char *start,
 			struct nest_ima_events *p8_events, int flg, u32 val)
 {
@@ -179,6 +273,16 @@ static int nest_pmu_create(struct device_node *dev, int pmu_index)
 	update_events_in_group(
 		(struct nest_ima_events *)p8_events_arr, idx, pmu_ptr);
 
+	update_pmu_ops(pmu_ptr);
+	/* Register the pmu */
+	ret = perf_pmu_register(&pmu_ptr->pmu, pmu_ptr->pmu.name, -1);
+	if (ret) {
+		pr_err("Nest PMU %s Register failed\n", pmu_ptr->pmu.name);
+		return ret;
+	}
+
+	pr_info("%s performance monitor hardware support registered\n",
+			pmu_ptr->pmu.name);
 	return 0;
 }
 
-- 
1.9.1
