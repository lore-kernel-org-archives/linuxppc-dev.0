Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6rz25VPxzDq9D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 03:02:22 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3IGwjTl119795
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 13:02:11 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29w0p7nkj5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 13:02:10 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 18 Apr 2017 22:32:07 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3IH25OT14680186
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 22:32:05 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3IH21I9024657
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 22:32:04 +0530
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH v7 03/10] powerpc/powernv: Detect supported IMC units and its
 events
Date: Tue, 18 Apr 2017 22:31:43 +0530
In-Reply-To: <1492534910-7991-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1492534910-7991-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1492534910-7991-4-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
which belong to this PMU. This "reg" field is added to event's "reg" field 
in the "events" node, which gives us the location of the counter data. Kernel
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
 arch/powerpc/platforms/powernv/opal-imc.c | 413 ++++++++++++++++++++++++++++++
 1 file changed, 413 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 3a87000..0ddaf7d 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -33,15 +33,428 @@
 #include <asm/cputable.h>
 #include <asm/imc-pmu.h>
 
+u64 nest_max_offset;
 struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
+struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
+
+static int imc_event_prop_update(char *name, struct imc_events *events)
+{
+	char *buf;
+
+	if (!events || !name)
+		return -EINVAL;
+
+	/* memory for content */
+	buf = kzalloc(IMC_MAX_NAME_VAL_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	events->ev_name = name;
+	events->ev_value = buf;
+	return 0;
+}
+
+static int imc_event_prop_str(struct property *pp, char *name,
+			      struct imc_events *events)
+{
+	int ret;
+
+	ret = imc_event_prop_update(name, events);
+	if (ret)
+		return ret;
+
+	if (!pp->value || (strnlen(pp->value, pp->length) == pp->length) ||
+	   (pp->length > IMC_MAX_NAME_VAL_LEN))
+		return -EINVAL;
+	strncpy(events->ev_value, (const char *)pp->value, pp->length);
+
+	return 0;
+}
+
+static int imc_event_prop_val(char *name, u32 val,
+			      struct imc_events *events)
+{
+	int ret;
+
+	ret = imc_event_prop_update(name, events);
+	if (ret)
+		return ret;
+	snprintf(events->ev_value, IMC_MAX_NAME_VAL_LEN, "event=0x%x", val);
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
+	buf = kzalloc(IMC_MAX_NAME_VAL_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	sprintf(buf, "%s.%s", ev_name, event_prop);
+	ret = imc_event_prop_str(pp, buf, events);
+	if (ret) {
+		if (events->ev_name)
+			kfree(events->ev_name);
+		if (events->ev_value)
+			kfree(events->ev_value);
+	}
+	return ret;
+}
+
+/*
+ * Updates the maximum offset for an event in the pmu with domain
+ * "pmu_domain".
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
+/*
+ * imc_events_node_parser: Parse the event node "dev" and assign the parsed
+ *                         information to event "events".
+ *
+ * Parses the "reg", "scale" and "unit" properties of this event.
+ * "reg" gives us the event offset in the counter memory.
+ */
+static int imc_events_node_parser(struct device_node *dev,
+				  struct imc_events *events,
+				  struct property *event_scale,
+				  struct property *event_unit,
+				  struct property *name_prefix,
+				  u32 reg, int pmu_domain)
+{
+	struct property *name, *pp;
+	char *ev_name;
+	u32 val;
+	int idx = 0, ret;
+
+	if (!dev)
+		goto fail;
+
+	/* Find the event name */
+	name = of_find_property(dev, "event-name", NULL);
+	if (!name)
+		return -ENODEV;
+
+	if (!name->value ||
+	  (strnlen(name->value, name->length) == name->length) ||
+	  (name->length > IMC_MAX_NAME_VAL_LEN))
+		return -EINVAL;
+
+	ev_name = kzalloc(IMC_MAX_NAME_VAL_LEN, GFP_KERNEL);
+	if (!ev_name)
+		return -ENOMEM;
+
+	snprintf(ev_name, IMC_MAX_NAME_VAL_LEN, "%s%s",
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
+		 * continue to parse. XXX: This could be rewritten to skip the
+		 * entire event node incase of parsing issues, but that can be
+		 * done later.
+		 */
+		if (strncmp(pp->name, "reg", 3) == 0) {
+			of_property_read_u32(dev, pp->name, &val);
+			val += reg;
+			update_max_value(val, pmu_domain);
+			ret = imc_event_prop_val(ev_name, val, &events[idx]);
+			if (ret) {
+				if (events[idx].ev_name)
+					kfree(events[idx].ev_name);
+				if (events[idx].ev_value)
+					kfree(events[idx].ev_value);
+				goto fail;
+			}
+			idx++;
+			/*
+			 * If the common scale and unit properties available,
+			 * then, assign them to this event
+			 */
+			if (event_scale) {
+				ret = set_event_property(event_scale, "scale",
+							 &events[idx],
+							 ev_name);
+				if (ret)
+					goto fail;
+				idx++;
+			}
+			if (event_unit) {
+				ret = set_event_property(event_unit, "unit",
+							 &events[idx],
+							 ev_name);
+				if (ret)
+					goto fail;
+				idx++;
+			}
+		} else if (strncmp(pp->name, "unit", 4) == 0) {
+			/*
+			 * The event's unit and scale properties can override the
+			 * PMU's event and scale properties, if present.
+			 */
+			ret = set_event_property(pp, "unit", &events[idx],
+						 ev_name);
+			if (ret)
+				goto fail;
+			idx++;
+		} else if (strncmp(pp->name, "scale", 5) == 0) {
+			ret = set_event_property(pp, "scale", &events[idx],
+						 ev_name);
+			if (ret)
+				goto fail;
+			idx++;
+		}
+	}
+
+	return idx;
+fail:
+	return -EINVAL;
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
+
+	for (i = 0; i < nr_entries; i++) {
+		if (events[i].ev_name)
+			kfree(events[i].ev_name);
+		if (events[i].ev_value)
+			kfree(events[i].ev_value);
+	}
+
+	kfree(events);
+}
+
+/*
+ * imc_events_setup() : First finds the event node for the pmu and
+ *                      gets the number of supported events and then
+ * allocates memory for the same. Finally returns the address of events
+ * memory allocated.
+ */
+static struct imc_events *imc_events_setup(struct device_node *parent,
+					   int pmu_index,
+					   struct imc_pmu *pmu_ptr,
+					   u32 prop,
+					   int *idx)
+{
+	struct device_node *ev_node = NULL, *dir = NULL;
+	u32 reg;
+	struct imc_events *events;
+	struct property *scale_pp, *unit_pp, *name_prefix;
+	int ret = 0, nr_children = 0;
+
+	/*
+	 * Fetch the actual node where the events for this PMU exist.
+	 */
+	dir = of_find_node_by_phandle(prop);
+	if (!dir)
+		return NULL;
+	/*
+	 * Get the maximum no. of events in this node.
+	 * Multiply by 3 to account for .scale and .unit properties
+	 * This number suggests the amount of memory needed to setup the
+	 * events for this pmu.
+	 */
+	nr_children = get_nr_children(dir) * 3;
+
+	events = kzalloc((sizeof(struct imc_events) * nr_children),
+			 GFP_KERNEL);
+	if (!events)
+		return NULL;
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
+		goto free_events;
+
+	/*
+	 * "reg" property gives out the base offset of the counters data
+	 * for this PMU.
+	 */
+	of_property_read_u32(parent, "reg", &reg);
+
+	if (!name_prefix->value ||
+	   (strnlen(name_prefix->value, name_prefix->length) == name_prefix->length) ||
+	   (name_prefix->length > IMC_MAX_NAME_VAL_LEN))
+		goto free_events;
+
+	/* Loop through event nodes */
+	for_each_child_of_node(dir, ev_node) {
+		ret = imc_events_node_parser(ev_node, &events[*idx], scale_pp,
+				unit_pp, name_prefix, reg, pmu_ptr->domain);
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
+		*idx += ret;
+		}
+		return events;
+
+free_events:
+	imc_free_events(events, *idx);
+	return NULL;
+
+}
+
+/*
+ * imc_pmu_create : Takes the parent device which is the pmu unit and a
+ *                  pmu_index as the inputs.
+ * Allocates memory for the pmu, sets up its domain (NEST), and
+ * calls imc_events_setup() to allocate memory for the events supported
+ * by this pmu. Assigns a name for the pmu. Calls imc_events_node_parser()
+ * to setup the individual events.
+ * If everything goes fine, it calls, init_imc_pmu() to setup the pmu device
+ * and register it.
+ */
+static int imc_pmu_create(struct device_node *parent, int pmu_index, int domain)
+{
+	struct imc_events *events = NULL;
+	struct imc_pmu *pmu_ptr;
+	u32 prop = 0;
+	struct property *pp;
+	char *buf;
+	int idx = 0, ret = 0;
+
+	if (!parent)
+		return -EINVAL;
+
+	/* memory for pmu */
+	pmu_ptr = kzalloc(sizeof(struct imc_pmu), GFP_KERNEL);
+	if (!pmu_ptr)
+		return -ENOMEM;
+
+	pmu_ptr->domain = domain;
+	if (pmu_ptr->domain == IMC_DOMAIN_UNKNOWN)
+		goto free_pmu;
+
+	/* Needed for hotplug/migration */
+	per_nest_pmu_arr[pmu_index] = pmu_ptr;
+
+	pp = of_find_property(parent, "name", NULL);
+	if (!pp) {
+		ret = -ENODEV;
+		goto free_pmu;
+	}
+
+	if (!pp->value ||
+	   (strnlen(pp->value, pp->length) == pp->length) ||
+	   (pp->length > IMC_MAX_NAME_VAL_LEN)) {
+		ret = -EINVAL;
+		goto free_pmu;
+	}
+
+	buf = kzalloc(IMC_MAX_NAME_VAL_LEN, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto free_pmu;
+	}
+	/* Save the name to register it later */
+	sprintf(buf, "nest_%s", (char *)pp->value);
+	pmu_ptr->pmu.name = (char *)buf;
+
+	/*
+	 * "events" property inside a PMU node contains the phandle value
+	 * for the actual events node. The "events" node for the IMC PMU
+	 * is not in this node, rather inside "imc-counters" node, since,
+	 * we want to factor out the common events (thereby, reducing the
+	 * size of the device tree)
+	 */
+	of_property_read_u32(parent, "events", &prop);
+	if (prop)
+		events = imc_events_setup(parent, pmu_index, pmu_ptr,
+					  prop, &idx);
+	return 0;
+
+free_pmu:
+	kfree(pmu_ptr);
+	return ret;
+}
+
 
 /*
  * imc_pmu_setup : Setup the IMC PMUs (children of "parent").
+ *
+ * Top level "imc-counters" node contains both event-nodes and pmu
+ * unit nodes. We only consider the pmu unit node here.
  */
 static void __init imc_pmu_setup(struct device_node *parent)
 {
+	struct device_node *child;
+	int pmu_count = 0, rc = 0, domain;
+
 	if (!parent)
 		return;
+	/*
+	 * Loop through the imc-counters tree for each compatible
+	 * "ibm,imc-counters-nest", and update "struct imc_pmu".
+	 */
+	for_each_compatible_node(child, NULL, IMC_DTB_NEST_COMPAT) {
+		domain = IMC_DOMAIN_NEST;
+		rc = imc_pmu_create(child, pmu_count, domain);
+		if (rc)
+			return;
+		pmu_count++;
+	}
 }
 
 static int opal_imc_counters_probe(struct platform_device *pdev)
-- 
2.7.4
