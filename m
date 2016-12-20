Return-Path: <hemant@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjSpp5TzlzDwPD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 17:40:50 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBK6cUG7024994
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 01:40:48 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27ewnjevny-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 01:40:48 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Tue, 20 Dec 2016 16:40:46 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0FA103578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 17:40:43 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBK6ehWe53608668
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 17:40:43 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBK6efGm006998
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 17:40:42 +1100
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>
Subject: [PATCH v3 5/6] powerpc/perf: Generic imc pmu event functions
Date: Tue, 20 Dec 2016 12:09:45 +0530
In-Reply-To: <1482215986-11783-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1482215986-11783-1-git-send-email-hemant@linux.vnet.ibm.com>
Message-Id: <1482215986-11783-6-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since, the IMC counters' data are periodically fed to a memory location,
the functions to read/update, start/stop, add/del can be generic and can
be used by all IMC PMU units.

This patch adds a set of generic imc pmu related event functions to be
used  by each imc pmu unit. Add code to setup format attribute and to
register imc pmus. Add a event_init function for nest_imc events.

Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h        |   1 +
 arch/powerpc/perf/imc-pmu.c               | 122 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-imc.c |  29 ++++++-
 3 files changed, 148 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 911d837..ceb6b1f 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -70,4 +70,5 @@ struct imc_pmu {
 
 #define UNKNOWN_DOMAIN		-1
 
+int imc_get_domain(struct device_node *pmu_dev);
 #endif /* PPC_POWERNV_IMC_PMU_DEF_H */
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 7b6ce50..f12ece8 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -17,6 +17,117 @@
 struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
 struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 
+/* Needed for sanity check */
+extern u64 nest_max_offset;
+
+PMU_FORMAT_ATTR(event, "config:0-20");
+static struct attribute *imc_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group imc_format_group = {
+	.name = "format",
+	.attrs = imc_format_attrs,
+};
+
+static int nest_imc_event_init(struct perf_event *event)
+{
+	int chip_id;
+	u32 config = event->attr.config;
+	struct perchip_nest_info *pcni;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* Sampling not supported */
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
+	/* Sanity check for config (event offset) */
+	if (config > nest_max_offset)
+		return -EINVAL;
+
+	chip_id = topology_physical_package_id(event->cpu);
+	pcni = &nest_perchip_info[chip_id];
+	event->hw.event_base = pcni->vbase[config/PAGE_SIZE] +
+							(config & ~PAGE_MASK);
+
+	return 0;
+}
+
+static void imc_read_counter(struct perf_event *event)
+{
+	u64 *addr, data;
+
+	addr = (u64 *)event->hw.event_base;
+	data = __be64_to_cpu(*addr);
+	local64_set(&event->hw.prev_count, data);
+}
+
+static void imc_perf_event_update(struct perf_event *event)
+{
+	u64 counter_prev, counter_new, final_count, *addr;
+
+	addr = (u64 *)event->hw.event_base;
+	counter_prev = local64_read(&event->hw.prev_count);
+	counter_new = __be64_to_cpu(*addr);
+	final_count = counter_new - counter_prev;
+
+	local64_set(&event->hw.prev_count, counter_new);
+	local64_add(final_count, &event->count);
+}
+
+static void imc_event_start(struct perf_event *event, int flags)
+{
+	imc_read_counter(event);
+}
+
+static void imc_event_stop(struct perf_event *event, int flags)
+{
+	if (flags & PERF_EF_UPDATE)
+		imc_perf_event_update(event);
+}
+
+static int imc_event_add(struct perf_event *event, int flags)
+{
+	if (flags & PERF_EF_START)
+		imc_event_start(event, flags);
+
+	return 0;
+}
+
+/* update_pmu_ops : Populate the appropriate operations for "pmu" */
+static int update_pmu_ops(struct imc_pmu *pmu)
+{
+	if (!pmu)
+		return -EINVAL;
+
+	pmu->pmu.task_ctx_nr = perf_invalid_context;
+	pmu->pmu.event_init = nest_imc_event_init;
+	pmu->pmu.add = imc_event_add;
+	pmu->pmu.del = imc_event_stop;
+	pmu->pmu.start = imc_event_start;
+	pmu->pmu.stop = imc_event_stop;
+	pmu->pmu.read = imc_perf_event_update;
+	pmu->attr_groups[1] = &imc_format_group;
+	pmu->pmu.attr_groups = pmu->attr_groups;
+
+	return 0;
+}
+
 /* dev_str_attr : Populate event "name" and string "str" in attribute */
 static struct attribute *dev_str_attr(const char *name, const char *str)
 {
@@ -83,6 +194,17 @@ int init_imc_pmu(struct imc_events *events, int idx,
 	if (ret)
 		goto err_free;
 
+	ret = update_pmu_ops(pmu_ptr);
+	if (ret)
+		goto err_free;
+
+	ret = perf_pmu_register(&pmu_ptr->pmu, pmu_ptr->pmu.name, -1);
+	if (ret)
+		goto err_free;
+
+	pr_info("%s performance monitor hardware support registered\n",
+		pmu_ptr->pmu.name);
+
 	return 0;
 
 err_free:
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 7870401..a2ca8e4 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -36,6 +36,7 @@ extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 
 extern int init_imc_pmu(struct imc_events *events,
 			int idx, struct imc_pmu *pmu_ptr);
+u64 nest_max_offset;
 
 static int imc_event_info(char *name, struct imc_events *events)
 {
@@ -68,8 +69,25 @@ static int imc_event_info_str(struct property *pp, char *name,
 	return 0;
 }
 
+/*
+ * Updates the maximum offset for an event in the pmu with domain
+ * "pmu_domain". Right now, only nest domain is supported.
+ */
+static void update_max_value(u32 value, int pmu_domain)
+{
+	switch (pmu_domain) {
+	case IMC_DOMAIN_NEST:
+		if (nest_max_offset < value)
+			nest_max_offset = value;
+		break;
+	default:
+		/* Unknown domain, return */
+		return;
+	}
+}
+
 static int imc_event_info_val(char *name, u32 val,
-			      struct imc_events *events)
+			      struct imc_events *events, int pmu_domain)
 {
 	int ret;
 
@@ -77,6 +95,7 @@ static int imc_event_info_val(char *name, u32 val,
 	if (ret)
 		return ret;
 	sprintf(events->ev_value, "event=0x%x", val);
+	update_max_value(val, pmu_domain);
 
 	return 0;
 }
@@ -111,7 +130,8 @@ static int set_event_property(struct property *pp, char *event_prop,
 static int imc_events_node_parser(struct device_node *dev,
 				  struct imc_events *events,
 				  struct property *event_scale,
-				  struct property *event_unit)
+				  struct property *event_unit,
+				  int pmu_domain)
 {
 	struct property *name, *pp;
 	char *ev_name;
@@ -153,7 +173,8 @@ static int imc_events_node_parser(struct device_node *dev,
 		 */
 		if (strncmp(pp->name, "reg", 3) == 0) {
 			of_property_read_u32(dev, pp->name, &val);
-			ret = imc_event_info_val(ev_name, val, &events[idx]);
+			ret = imc_event_info_val(ev_name, val, &events[idx],
+				pmu_domain);
 			if (ret) {
 				kfree(events[idx].ev_name);
 				kfree(events[idx].ev_value);
@@ -322,7 +343,7 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index)
 	/* Loop through event nodes */
 	for_each_child_of_node(parent, ev_node) {
 		ret = imc_events_node_parser(ev_node, &events[idx], scale_pp,
-					     unit_pp);
+					     unit_pp, pmu_ptr->domain);
 		if (ret < 0) {
 			/* Unable to parse this event */
 			if (ret == -ENOMEM)
-- 
2.7.4
