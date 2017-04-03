Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxZvB1fkJzDqK9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 00:56:53 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v33EsGdt082326
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Apr 2017 10:56:43 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29kqbnw4t8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 10:56:43 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 00:56:40 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v33EuTEg54722798
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 00:56:37 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v33Eu02S026185
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 00:56:01 +1000
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
Subject: [PATCH v6 03/11] powerpc/powernv: Detect supported IMC units and its
 events
Date: Mon,  3 Apr 2017 20:25:00 +0530
In-Reply-To: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1491231308-15282-4-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hemant Kumar <hemant@linux.vnet.ibm.com>

Parse device tree to detect IMC units. Traverse through each IMC unit
node to find supported events and corresponding unit/scale files (if any).

Here is the DTS file for reference:

	https://github.com/open-power/ima-catalog/blob/master/81E00612.4E0100.dts

The device tree for IMC counters starts at the node "imc-counters".
This node contains all the IMC PMU nodes and event nodes
for these IMC PMUs. The PMU nodes have an "events" property which has a
phandle value for the actual events node. The events are separated from
the PMU nodes to abstract out the common events. For example, PMU node
"mcs0", "mcs1" etc. will contain a pointer to "nest-mcs-events" since,
the events are common between these PMUs. These events have a different
prefix based on their relation to different PMUs, and hence, the PMU
nodes themselves contain an "events-prefix" property. The value for this
property concatenated to the event name, forms the actual event
name. Also, the PMU have a "reg" field as the base offset for the events
which belong to this PMU. This "reg" field is added to an event in the
"events" node, which gives us the location of the counter data. Kernel
code uses this offset as event configuration value.

Device tree parser code also looks for scale/unit property in the event
node and passes on the value as an event attr for perf interface to use
in the post processing by the perf tool. Some PMUs may have common scale
and unit properties which implies that all events supported by this PMU
inherit the scale and unit properties of the PMU itself. For those
events, we need to set the common unit and scale values.

For failure to initialize any unit or any event, disable that unit and
continue setting up the rest of them.

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-imc.c | 386 ++++++++++++++++++++++++++++++
 1 file changed, 386 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index c476d596c6a8..ba0203e669c0 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -33,6 +33,388 @@
 #include <asm/imc-pmu.h>
 
 struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
+struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
+
+static int imc_event_info(char *name, struct imc_events *events)
+{
+	char *buf;
+
+	/* memory for content */
+	buf = kzalloc(IMC_MAX_PMU_NAME_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	events->ev_name = name;
+	events->ev_value = buf;
+	return 0;
+}
+
+static int imc_event_info_str(struct property *pp, char *name,
+			       struct imc_events *events)
+{
+	int ret;
+
+	ret = imc_event_info(name, events);
+	if (ret)
+		return ret;
+
+	if (!pp->value || (strnlen(pp->value, pp->length) == pp->length) ||
+	   (pp->length > IMC_MAX_PMU_NAME_LEN))
+		return -EINVAL;
+	strncpy(events->ev_value, (const char *)pp->value, pp->length);
+
+	return 0;
+}
+
+static int imc_event_info_val(char *name, u32 val,
+			      struct imc_events *events)
+{
+	int ret;
+
+	ret = imc_event_info(name, events);
+	if (ret)
+		return ret;
+	sprintf(events->ev_value, "event=0x%x", val);
+
+	return 0;
+}
+
+static int set_event_property(struct property *pp, char *event_prop,
+			      struct imc_events *events, char *ev_name)
+{
+	char *buf;
+	int ret;
+
+	buf = kzalloc(IMC_MAX_PMU_NAME_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	sprintf(buf, "%s.%s", ev_name, event_prop);
+	ret = imc_event_info_str(pp, buf, events);
+	if (ret) {
+		kfree(events->ev_name);
+		kfree(events->ev_value);
+	}
+
+	return ret;
+}
+
+/*
+ * imc_events_node_parser: Parse the event node "dev" and assign the parsed
+ *                         information to event "events".
+ *
+ * Parses the "reg" property of this event. "reg" gives us the event offset.
+ * Also, parse the "scale" and "unit" properties, if any.
+ */
+static int imc_events_node_parser(struct device_node *dev,
+				  struct imc_events *events,
+				  struct property *event_scale,
+				  struct property *event_unit,
+				  struct property *name_prefix,
+				  u32 reg)
+{
+	struct property *name, *pp;
+	char *ev_name;
+	u32 val;
+	int idx = 0, ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	/*
+	 * Loop through each property of an event node
+	 */
+	name = of_find_property(dev, "event-name", NULL);
+	if (!name)
+		return -ENODEV;
+
+	if (!name->value ||
+	  (strnlen(name->value, name->length) == name->length) ||
+	  (name->length > IMC_MAX_PMU_NAME_LEN))
+		return -EINVAL;
+
+	ev_name = kzalloc(IMC_MAX_PMU_NAME_LEN, GFP_KERNEL);
+	if (!ev_name)
+		return -ENOMEM;
+
+	snprintf(ev_name, IMC_MAX_PMU_NAME_LEN, "%s%s",
+		 (char *)name_prefix->value,
+		 (char *)name->value);
+
+	/*
+	 * Parse each property of this event node "dev". Property "reg" has
+	 * the offset which is assigned to the event name. Other properties
+	 * like "scale" and "unit" are assigned to event.scale and event.unit
+	 * accordingly.
+	 */
+	for_each_property_of_node(dev, pp) {
+		/*
+		 * If there is an issue in parsing a single property of
+		 * this event, we just clean up the buffers, but we still
+		 * continue to parse.
+		 */
+		if (strncmp(pp->name, "reg", 3) == 0) {
+			of_property_read_u32(dev, pp->name, &val);
+			val += reg;
+			ret = imc_event_info_val(ev_name, val, &events[idx]);
+			if (ret) {
+				kfree(events[idx].ev_name);
+				kfree(events[idx].ev_value);
+				continue;
+			}
+			/*
+			 * If the common scale and unit properties available,
+			 * then, assign them to this event
+			 */
+			if (event_scale) {
+				idx++;
+				ret = set_event_property(event_scale, "scale",
+							 &events[idx],
+							 ev_name);
+				if (ret)
+					continue;
+				idx++;
+			}
+			if (event_unit) {
+				ret = set_event_property(event_unit, "unit",
+							 &events[idx],
+							 ev_name);
+				if (ret)
+					continue;
+			}
+			idx++;
+		} else if (strncmp(pp->name, "unit", 4) == 0) {
+			ret = set_event_property(pp, "unit", &events[idx],
+						 ev_name);
+			if (ret)
+				continue;
+			idx++;
+		} else if (strncmp(pp->name, "scale", 5) == 0) {
+			ret = set_event_property(pp, "scale", &events[idx],
+						 ev_name);
+			if (ret)
+				continue;
+			idx++;
+		}
+	}
+
+	return idx;
+}
+
+/*
+ * imc_get_domain : Returns the domain for pmu "pmu_dev".
+ */
+int imc_get_domain(struct device_node *pmu_dev)
+{
+	if (of_device_is_compatible(pmu_dev, IMC_DTB_NEST_COMPAT))
+		return IMC_DOMAIN_NEST;
+	else
+		return IMC_DOMAIN_UNKNOWN;
+}
+
+/*
+ * get_nr_children : Returns the number of children for a pmu device node.
+ */
+static int get_nr_children(struct device_node *pmu_node)
+{
+	struct device_node *child;
+	int i = 0;
+
+	for_each_child_of_node(pmu_node, child)
+		i++;
+	return i;
+}
+
+/*
+ * imc_free_events : Cleanup the "events" list having "nr_entries" entries.
+ */
+static void imc_free_events(struct imc_events *events, int nr_entries)
+{
+	int i;
+
+	/* Nothing to clean, return */
+	if (!events)
+		return;
+	for (i = 0; i < nr_entries; i++) {
+		kfree(events[i].ev_name);
+		kfree(events[i].ev_value);
+	}
+
+	kfree(events);
+}
+
+/*
+ * imc_pmu_create : Takes the parent device which is the pmu unit and a
+ *                  pmu_index as the inputs.
+ * Allocates memory for the pmu, sets up its domain (NEST or CORE), and
+ * allocates memory for the events supported by this pmu. Assigns a name for
+ * the pmu. Calls imc_events_node_parser() to setup the individual events.
+ * If everything goes fine, it calls, init_imc_pmu() to setup the pmu device
+ * and register it.
+ */
+static int imc_pmu_create(struct device_node *parent, int pmu_index)
+{
+	struct device_node *ev_node = NULL, *dir = NULL;
+	struct imc_events *events;
+	struct imc_pmu *pmu_ptr;
+	u32 prop, reg;
+	struct property *pp, *scale_pp, *unit_pp, *name_prefix;
+	char *buf;
+	int idx = 0, ret = 0, nr_children = 0;
+
+	if (!parent)
+		return -EINVAL;
+
+	/* memory for pmu */
+	pmu_ptr = kzalloc(sizeof(struct imc_pmu), GFP_KERNEL);
+	if (!pmu_ptr)
+		return -ENOMEM;
+
+	pmu_ptr->domain = imc_get_domain(parent);
+	if (pmu_ptr->domain == IMC_DOMAIN_UNKNOWN)
+		goto free_pmu;
+
+	/* Needed for hotplug/migration */
+	per_nest_pmu_arr[pmu_index] = pmu_ptr;
+
+	/*
+	 * "events" property inside a PMU node contains the phandle value
+	 * for the actual events node. The "events" node for the IMC PMU
+	 * is not in this node, rather inside "imc-counters" node, since,
+	 * we want to factor out the common events (thereby, reducing the
+	 * size of the device tree)
+	 */
+	of_property_read_u32(parent, "events", &prop);
+	if (!prop)
+		return -EINVAL;
+
+	/*
+	 * Fetch the actual node where the events for this PMU exist.
+	 */
+	dir = of_find_node_by_phandle(prop);
+	if (!dir)
+		return -EINVAL;
+
+	/*
+	 * Get the maximum no. of events in this node.
+	 * Multiply by 3 to account for .scale and .unit properties
+	 * This number suggests the amount of memory needed to setup the
+	 * events for this pmu.
+	 */
+	nr_children = get_nr_children(dir) * 3;
+
+	/* memory for pmu events */
+	events = kzalloc((sizeof(struct imc_events) * nr_children),
+			 GFP_KERNEL);
+	if (!events) {
+		ret = -ENOMEM;
+		goto free_pmu;
+	}
+
+	pp = of_find_property(parent, "name", NULL);
+	if (!pp) {
+		ret = -ENODEV;
+		goto free_events;
+	}
+
+	if (!pp->value ||
+	  (strnlen(pp->value, pp->length) == pp->length) ||
+	    (pp->length > IMC_MAX_PMU_NAME_LEN)) {
+		ret = -EINVAL;
+		goto free_events;
+	}
+
+	buf = kzalloc(IMC_MAX_PMU_NAME_LEN, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto free_events;
+	}
+
+	/* Save the name to register it later */
+	sprintf(buf, "nest_%s", (char *)pp->value);
+	pmu_ptr->pmu.name = (char *)buf;
+
+	/*
+	 * Check if there is a common "scale" and "unit" properties inside
+	 * the PMU node for all the events supported by this PMU.
+	 */
+	scale_pp = of_find_property(parent, "scale", NULL);
+	unit_pp = of_find_property(parent, "unit", NULL);
+
+	/*
+	 * Get the event-prefix property from the PMU node
+	 * which needs to be attached with the event names.
+	 */
+	name_prefix = of_find_property(parent, "events-prefix", NULL);
+	if (!name_prefix)
+		return -ENODEV;
+
+	/*
+	 * "reg" property gives out the base offset of the counters data
+	 * for this PMU.
+	 */
+	of_property_read_u32(parent, "reg", &reg);
+
+	if (!name_prefix->value ||
+	   (strnlen(name_prefix->value, name_prefix->length) == name_prefix->length) ||
+	   (name_prefix->length > IMC_MAX_PMU_NAME_LEN))
+		return -EINVAL;
+
+	/* Loop through event nodes */
+	for_each_child_of_node(dir, ev_node) {
+		ret = imc_events_node_parser(ev_node, &events[idx], scale_pp,
+					     unit_pp, name_prefix, reg);
+		if (ret < 0) {
+			/* Unable to parse this event */
+			if (ret == -ENOMEM)
+				goto free_events;
+			continue;
+		}
+
+		/*
+		 * imc_event_node_parser will return number of
+		 * event entries created for this. This could include
+		 * event scale and unit files also.
+		 */
+		idx += ret;
+	}
+
+	return 0;
+
+free_events:
+	imc_free_events(events, idx);
+free_pmu:
+	kfree(pmu_ptr);
+	return ret;
+}
+
+/*
+ * imc_pmu_setup : Setup the IMC PMUs (children of "parent").
+ */
+static void imc_pmu_setup(struct device_node *parent)
+{
+	struct device_node *child;
+	int pmu_count = 0, rc = 0;
+	const struct property *pp;
+
+	if (!parent)
+		return;
+
+	/* Setup all the IMC pmus */
+	for_each_child_of_node(parent, child) {
+		pp = of_get_property(child, "compatible", NULL);
+		if (pp) {
+			/*
+			 * If there is a node with a "compatible" field,
+			 * that's a PMU node
+			 */
+			rc = imc_pmu_create(child, pmu_count);
+			if (rc)
+				return;
+			pmu_count++;
+		}
+	}
+}
 
 static int opal_imc_counters_probe(struct platform_device *pdev)
 {
@@ -102,6 +484,10 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 		} while (i < (pcni->size / PAGE_SIZE));
 	}
 
+#ifdef CONFIG_PERF_EVENTS
+	imc_pmu_setup(imc_dev);
+#endif
+
 	return 0;
 err:
 	return -ENODEV;
-- 
2.7.4
