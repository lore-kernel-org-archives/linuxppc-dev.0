Return-Path: <hemant@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMdWM5Y1fzDvhH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:39 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAL68X0Y067110
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 01:10:37 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26utr01byx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 01:10:37 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 21 Nov 2016 16:10:34 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1D8EB2CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:32 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAL6AW1O55705848
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:32 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAL6AVWS030847
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:31 +1100
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 stewart@linux.vnet.ibm.com, dja@axtens.net, mikey@neuling.org,
 maddy@linux.vnet.ibm.com, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v2 5/6] powerpc/perf: Generic ima pmu event functions
Date: Mon, 21 Nov 2016 11:40:04 +0530
In-Reply-To: <1479708605-10238-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1479708605-10238-1-git-send-email-hemant@linux.vnet.ibm.com>
Message-Id: <1479708605-10238-6-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since, the IMA counters' data are periodically fed to a memory location,
the functions to read/update, start/stop, add/del can be generic and can
be used by all IMA PMU units.

This patch adds a set of generic ima pmu related event functions to be
used  by each ima pmu unit. Add code to setup format attribute and to
register ima pmus. Add a event_init function for nest_ima events.

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
 arch/powerpc/include/asm/ima-pmu.h        |   2 +
 arch/powerpc/perf/ima-pmu.c               | 122 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-ima.c |  37 +++++++--
 3 files changed, 154 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/ima-pmu.h b/arch/powerpc/include/asm/ima-pmu.h
index 0ed8886..f0d95bb 100644
--- a/arch/powerpc/include/asm/ima-pmu.h
+++ b/arch/powerpc/include/asm/ima-pmu.h
@@ -70,4 +70,6 @@ struct ima_pmu {
 
 #define UNKNOWN_DOMAIN		-1
 
+int ima_get_domain(struct device_node *pmu_dev);
+
 #endif /* PPC_POWERNV_IMA_PMU_DEF_H */
diff --git a/arch/powerpc/perf/ima-pmu.c b/arch/powerpc/perf/ima-pmu.c
index 50d2226..9948636 100644
--- a/arch/powerpc/perf/ima-pmu.c
+++ b/arch/powerpc/perf/ima-pmu.c
@@ -17,6 +17,117 @@
 struct perchip_nest_info nest_perchip_info[IMA_MAX_CHIPS];
 struct ima_pmu *per_nest_pmu_arr[IMA_MAX_PMUS];
 
+/* Needed for sanity check */
+extern u64 nest_max_offset;
+
+PMU_FORMAT_ATTR(event, "config:0-20");
+static struct attribute *ima_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group ima_format_group = {
+	.name = "format",
+	.attrs = ima_format_attrs,
+};
+
+static int nest_ima_event_init(struct perf_event *event)
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
+static void ima_read_counter(struct perf_event *event)
+{
+	u64 *addr, data;
+
+	addr = (u64 *)event->hw.event_base;
+	data = __be64_to_cpu(*addr);
+	local64_set(&event->hw.prev_count, data);
+}
+
+static void ima_perf_event_update(struct perf_event *event)
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
+static void ima_event_start(struct perf_event *event, int flags)
+{
+	ima_read_counter(event);
+}
+
+static void ima_event_stop(struct perf_event *event, int flags)
+{
+	if (flags & PERF_EF_UPDATE)
+		ima_perf_event_update(event);
+}
+
+static int ima_event_add(struct perf_event *event, int flags)
+{
+	if (flags & PERF_EF_START)
+		ima_event_start(event, flags);
+
+	return 0;
+}
+
+/* update_pmu_ops : Populate the appropriate operations for "pmu" */
+static int update_pmu_ops(struct ima_pmu *pmu)
+{
+	if (!pmu)
+		return -EINVAL;
+
+	pmu->pmu.task_ctx_nr = perf_invalid_context;
+	pmu->pmu.event_init = nest_ima_event_init;
+	pmu->pmu.add = ima_event_add;
+	pmu->pmu.del = ima_event_stop;
+	pmu->pmu.start = ima_event_start;
+	pmu->pmu.stop = ima_event_stop;
+	pmu->pmu.read = ima_perf_event_update;
+	pmu->attr_groups[1] = &ima_format_group;
+	pmu->pmu.attr_groups = pmu->attr_groups;
+
+	return 0;
+}
+
 /* dev_str_attr : Populate event "name" and string "str" in attribute */
 static struct attribute *dev_str_attr(const char *name, const char *str)
 {
@@ -83,6 +194,17 @@ int init_ima_pmu(struct ima_events *events, int idx,
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
diff --git a/arch/powerpc/platforms/powernv/opal-ima.c b/arch/powerpc/platforms/powernv/opal-ima.c
index d2e6910..efafa92 100644
--- a/arch/powerpc/platforms/powernv/opal-ima.c
+++ b/arch/powerpc/platforms/powernv/opal-ima.c
@@ -34,6 +34,8 @@
 extern struct perchip_nest_info nest_perchip_info[IMA_MAX_CHIPS];
 extern struct ima_pmu *per_nest_pmu_arr[IMA_MAX_PMUS];
 
+u64 nest_max_offset;
+
 extern int init_ima_pmu(struct ima_events *events,
 			int idx, struct ima_pmu *pmu_ptr);
 
@@ -68,8 +70,25 @@ static int ima_event_info_str(struct property *pp, char *name,
 	return 0;
 }
 
+/*
+ * Updates the maximum offset for an event in the pmu with domain
+ * "pmu_domain". Right now, only nest domain is supported.
+ */
+static void update_max_value(u32 value, int pmu_domain)
+{
+	switch (pmu_domain) {
+	case IMA_DOMAIN_NEST:
+		if (nest_max_offset < value)
+			nest_max_offset = value;
+		break;
+	default:
+		/* Unknown domain, return */
+		return;
+	}
+}
+
 static int ima_event_info_val(char *name, u32 val,
-			       struct ima_events *events)
+			      struct ima_events *events, int pmu_domain)
 {
 	int ret;
 
@@ -77,6 +96,7 @@ static int ima_event_info_val(char *name, u32 val,
 	if (ret)
 		return ret;
 	sprintf(events->ev_value, "event=0x%x", val);
+	update_max_value(val, pmu_domain);
 
 	return 0;
 }
@@ -111,7 +131,8 @@ static int set_event_property(struct property *pp, char *event_prop,
 static int ima_events_node_parser(struct device_node *dev,
 				  struct ima_events *events,
 				  struct property *event_scale,
-				  struct property *event_unit)
+				  struct property *event_unit,
+				  int pmu_domain)
 {
 	struct property *name, *pp;
 	char *ev_name;
@@ -153,7 +174,8 @@ static int ima_events_node_parser(struct device_node *dev,
 		 */
 		if (strncmp(pp->name, "reg", 3) == 0) {
 			of_property_read_u32(dev, pp->name, &val);
-			ret = ima_event_info_val(ev_name, val, &events[idx]);
+			ret = ima_event_info_val(ev_name, val, &events[idx],
+				pmu_domain);
 			if (ret) {
 				kfree(events[idx].ev_name);
 				kfree(events[idx].ev_value);
@@ -243,9 +265,10 @@ static void ima_free_events(struct ima_events *events, int nr_entries)
 /*
  * ima_pmu_create : Takes the parent device which is the pmu unit and a
  *                  pmu_index as the inputs.
- * Allocates memory for the pmu, sets up its domain (NEST or CORE), and
- * allocates memory for the events supported by this pmu. Assigns a name for
- * the pmu. Calls ima_events_node_parser() to setup the individual events.
+ * Allocates memory for the pmu, sets up its domain (right now, only NEST),
+ * and allocates memory for the events supported by this pmu. Assigns a name
+ * for the pmu. Calls ima_events_node_parser() to setup the individual
+ * events.
  * If everything goes fine, it calls, init_ima_pmu() to setup the pmu device
  * and register it.
  */
@@ -322,7 +345,7 @@ static int ima_pmu_create(struct device_node *parent, int pmu_index)
 	/* Loop through event nodes */
 	for_each_child_of_node(parent, ev_node) {
 		ret = ima_events_node_parser(ev_node, &events[idx], scale_pp,
-					     unit_pp);
+					     unit_pp, pmu_ptr->domain);
 		if (ret < 0) {
 			/* Unable to parse this event */
 			if (ret == -ENOMEM)
-- 
2.7.4
