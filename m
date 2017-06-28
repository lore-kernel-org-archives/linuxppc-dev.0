Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyX9M3SYWzDr4Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 04:57:43 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5SIsC8s059488
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 14:57:41 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bcfpey2qq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 14:57:41 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 04:57:38 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5SIvatP065884
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 04:57:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5SIvRb1029624
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 04:57:27 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH v11 03/10] powerpc/powernv: Detect supported IMC units and its
 events
Date: Thu, 29 Jun 2017 00:27:08 +0530
In-Reply-To: <1498676232-23841-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1498676232-23841-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1498676232-23841-4-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Parse device tree to detect IMC units. Traverse through each IMC unit
node to find supported events and corresponding unit/scale files (if any).

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
 arch/powerpc/include/asm/imc-pmu.h        |   5 +
 arch/powerpc/platforms/powernv/opal-imc.c | 439 +++++++++++++++++++++++++++++-
 2 files changed, 443 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index ffaea0b..2a0239e 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -91,6 +91,11 @@ struct imc_pmu {
 	const struct attribute_group *attr_groups[4];
 };
 
+/* In-Memory Collection Counters Type */
+enum {
+	IMC_COUNTER_PER_CHIP            = 0x10,
+};
+
 /*
  * Domains for IMC PMUs
  */
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 5b1045c..839c257 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -34,9 +34,437 @@
 #include <asm/cputable.h>
 #include <asm/imc-pmu.h>
 
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
+	/* Check for "event-name" property, which is the perfix for event names */
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
+		 * continue to parse. TODO: This could be rewritten to skip the
+		 * entire event node incase of parsing issues, but that can be
+		 * done later.
+		 */
+		if (strncmp(pp->name, "reg", 3) == 0) {
+			of_property_read_u32(dev, pp->name, &val);
+			val += reg;
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
+ * get_nr_children : Returns the number of events(along with scale and unit)
+ * 		     for a pmu device node.
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
+ *                      gets the number of supported events, then
+ * allocates memory for the same and parse the events.
+ */
+static int imc_events_setup(struct device_node *parent,
+					   int pmu_index,
+					   struct imc_pmu *pmu_ptr,
+					   u32 prop,
+					   int *idx)
+{
+	struct device_node *ev_node = NULL, *dir = NULL;
+	u32 reg;
+	struct property *scale_pp, *unit_pp, *name_prefix;
+	int ret = 0, nr_children = 0;
+
+	/*
+	 * Fetch the actual node where the events for this PMU exist.
+	 */
+	dir = of_find_node_by_phandle(prop);
+	if (!dir)
+		return -ENODEV;
+	/*
+	 * Get the maximum no. of events in this node.
+	 * Multiply by 3 to account for .scale and .unit properties
+	 * This number suggests the amount of memory needed to setup the
+	 * events for this pmu.
+	 */
+	nr_children = get_nr_children(dir) * 3;
+
+	pmu_ptr->events = kzalloc((sizeof(struct imc_events) * nr_children),
+			 GFP_KERNEL);
+	if (!pmu_ptr->events)
+		return -ENOMEM;
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
+		ret = imc_events_node_parser(ev_node, &pmu_ptr->events[*idx], scale_pp,
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
+	}
+	return 0;
+
+free_events:
+	imc_free_events(pmu_ptr->events, *idx);
+	return -ENODEV;
+
+}
+
+/* imc_get_mem_addr_nest: Function to get nest counter memory region for each chip */
+static int imc_get_mem_addr_nest(struct device_node *node,
+				 struct imc_pmu *pmu_ptr,
+				 u32 offset)
+{
+	int nr_chips = 0, i, j;
+	u64 *base_addr_arr, baddr;
+	u32 *chipid_arr, size = pmu_ptr->counter_mem_size, pages;
+
+	nr_chips = of_property_count_u32_elems(node, "chip-id");
+	if (!nr_chips)
+		return -ENODEV;
+
+	base_addr_arr = kzalloc((sizeof(u64) * nr_chips), GFP_KERNEL);
+	chipid_arr = kzalloc((sizeof(u32) * nr_chips), GFP_KERNEL);
+	if (!base_addr_arr || !chipid_arr)
+		return -ENOMEM;
+
+	of_property_read_u32_array(node, "chip-id", chipid_arr, nr_chips);
+	of_property_read_u64_array(node, "base-addr", base_addr_arr, nr_chips);
+
+	pmu_ptr->mem_info = kzalloc((sizeof(struct imc_mem_info) * nr_chips), GFP_KERNEL);
+	if (!pmu_ptr->mem_info) {
+		if (base_addr_arr)
+			kfree(base_addr_arr);
+		if (chipid_arr)
+			kfree(chipid_arr);
+
+		return -ENOMEM;
+		}
+
+	for (i = 0; i < nr_chips; i++) {
+		pmu_ptr->mem_info[i].id = chipid_arr[i];
+		baddr = base_addr_arr[i] + offset;
+		for (j = 0; j < (size/PAGE_SIZE); j++) {
+			pages = PAGE_SIZE * j;
+			pmu_ptr->mem_info[i].vbase[j] = phys_to_virt(baddr + pages);
+		}
+	}
+	return 0;
+}
+
+/*
+ * imc_pmu_create : Takes the parent device which is the pmu unit, pmu_index
+ *		    and domain as the inputs.
+ * Allocates memory for the pmu, sets up its domain (NEST), and
+ * calls imc_events_setup() to allocate memory for the events supported
+ * by this pmu. Assigns a name for the pmu.
+ *
+ * If everything goes fine, it calls, init_imc_pmu() to setup the pmu device
+ * and register it.
+ */
+static int imc_pmu_create(struct device_node *parent, int pmu_index, int domain)
+{
+	u32 prop = 0;
+	struct property *pp;
+	char *buf;
+	int idx = 0, ret = 0;
+	struct imc_pmu *pmu_ptr;
+	u32 offset;
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
+	if (of_property_read_u32(parent, "size", &pmu_ptr->counter_mem_size))
+		pmu_ptr->counter_mem_size = 0;
+
+	if (!of_property_read_u32(parent, "offset", &offset)) {
+		if (imc_get_mem_addr_nest(parent, pmu_ptr, offset))
+			goto free_pmu;
+		pmu_ptr->imc_counter_mmaped = 1;
+	}
+
+	/*
+	 * "events" property inside a PMU node contains the phandle value
+	 * for the actual events node. The "events" node for the IMC PMU
+	 * is not in this node, rather inside "imc-counters" node, since,
+	 * we want to factor out the common events (thereby, reducing the
+	 * size of the device tree)
+	 */
+	if (!of_property_read_u32(parent, "events", &prop)) {
+		if (prop)
+			imc_events_setup(parent, pmu_index, pmu_ptr, prop, &idx);
+	}
+	return 0;
+
+free_pmu:
+	if (pmu_ptr)
+		kfree(pmu_ptr);
+	return ret;
+}
+
 static int opal_imc_counters_probe(struct platform_device *pdev)
 {
 	struct device_node *imc_dev = NULL;
+	int pmu_count = 0, domain;
+	u32 type;
 
 	if (!pdev || !pdev->dev.of_node)
 		return -ENODEV;
@@ -50,7 +478,16 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 	imc_dev = pdev->dev.of_node;
 	if (!imc_dev)
 		return -ENODEV;
-
+	for_each_compatible_node(imc_dev, NULL, IMC_DTB_UNIT_COMPAT) {
+		if (of_property_read_u32(imc_dev, "type", &type))
+			continue;
+		if (type == IMC_COUNTER_PER_CHIP)
+			domain = IMC_DOMAIN_NEST;
+		else
+			continue;
+		if (!imc_pmu_create(imc_dev, pmu_count, domain))
+			pmu_count++;
+	}
 	return 0;
 }
 
-- 
2.7.4
