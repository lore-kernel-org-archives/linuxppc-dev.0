Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1C311A0A07
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:39 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 23:08:39 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EBE202BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:36 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2BD8SXr46203098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:36 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2BD82cv011872
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:03 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 6/7]powerpc/powernv: add support to parse dt for nest pmu
Date: Wed, 11 Mar 2015 18:37:12 +0530
Message-Id: <1426079233-16720-7-git-send-email-maddy@linux.vnet.ibm.com>
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

Nest counter unit informations are passed on as part of device-tree
to kernel. Here is the Device-tree layout.

DT root folder  /:
 /
 |
 -uncore@<chip-id>
   |
   -phb  <--dt node for pcie host bridge (uncore pmu type)
   -...
   -mcs  <--dt node for memory controller (uncore pmu type)
     |
     -mcs@0   <-- dt node for memory controller sub units
     -mcs@1
     -mcs@2
     -mcs@3
      |
      - mcs_read                <-- Sample event file
      - unit.mcs_read.unit      <-- Sample event unit file.
      - scale.mcs_read.scale    <-- Sample event scale file

Patch implements generic function to creates type structure and populate 
events and event related information from DT. For each type structure, 
new pmu is registered.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/uncore_pmu_p8.c | 240 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 238 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/uncore_pmu_p8.c b/arch/powerpc/perf/uncore_pmu_p8.c
index 411c077..6a347d6 100644
--- a/arch/powerpc/perf/uncore_pmu_p8.c
+++ b/arch/powerpc/perf/uncore_pmu_p8.c
@@ -153,8 +153,246 @@ struct pmu p8_uncore_pmu = {
 	.read		= p8_uncore_perf_event_update,
 };
 
+/*
+ * Populate event name and string in attribute
+ */
+struct attribute *dev_str_attr(char *name, char *str)
+{
+	struct perf_pmu_events_attr *attr;
+
+	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+
+	attr->event_str = (const char *)str;
+	attr->attr.attr.name = name;
+	attr->attr.attr.mode = 0444;
+	attr->attr.show = perf_event_sysfs_show;
+
+	return &attr->attr.attr;
+}
+
+int update_uncore_unit_event_group(
+		struct ppc64_uncore_type *ptr)
+{
+	struct attribute_group *attr_group;
+	struct attribute **attrs;
+	struct ppc64_uncore_type_events *ev_arry = ptr->event_arry;
+	char *ev_val;
+	int i, j;
+
+	/*
+	 * Count the total # of events for this uncore pmu
+	 */
+	for (j = 0; ev_arry[0].ev_offset[j] != 0; j++)
+		;
+
+	attr_group = kzalloc(sizeof(struct attribute *) * (j) +
+		sizeof(*attr_group), GFP_KERNEL);
+	if (!attr_group)
+		return -ENOMEM;
+
+	attrs = (struct attribute **)(attr_group + 1);
+	attr_group->name = "events";
+	attr_group->attrs = attrs;
+
+	for (i = 0; i < j; i++) {
+		if (ev_arry[0].ev_offset[i] < 0) {
+			attrs[i] = dev_str_attr((char *)ev_arry[0].ev_name[i], (char *)ev_arry[0].ev_value[i]);
+		} else {
+			ev_val = kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
+			if (!ev_val)
+				return -ENOMEM;
+			sprintf((char *)ev_val, "event=0x%02x", (i+1));
+			attrs[i] = dev_str_attr((char *)ev_arry[0].ev_name[i], ev_val);
+		}
+	}
+
+	ptr->events_group = attr_group;
+	return 0;
+}
+
+/*
+ * Parse the child node and identify events associated
+ * with this pmu.
+ */
+static int populate_events(struct device_node *dev,
+			struct ppc64_uncore_type *ptr, int idx)
+{
+	struct ppc64_uncore_type_events *ev_arry = ptr->event_arry;
+	struct property *pp;
+	int ev_idx = 0, len = 0;
+	const char *start, *end, *out_str;
+	char *buf;
+	const __be32 *lval;
+	u32 val;
+
+	/*
+	 * Loop through each property
+	 */
+	for_each_property_of_node(dev, pp) {
+		start = pp->name;
+		end = start + strlen(start);
+		len = strlen(start);
+
+		/* Skip these, we dont need it */
+		if (!strcmp(pp->name, "name") ||
+		    !strcmp(pp->name, "phandle") ||
+		    !strcmp(pp->name, "ibm,dev-id") ||
+		    !strcmp(pp->name, "linux,phandle"))
+			continue;
+
+		buf = kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		/*
+		 * Event may have corresponding unit and scale
+		 * information. Incase of unit and scale, populate
+		 * the offset value to negative.
+		 */
+		if (strncmp(pp->name, "unit.", 5) == 0) {
+			of_property_read_string(dev, pp->name, &out_str);
+			start += 5;
+			len = strlen(start);
+			strncpy(buf, start, strlen(start));
+			of_property_read_string(dev, pp->value, &out_str);
+
+			ev_arry[idx].ev_offset[ev_idx] = -1;
+			ev_arry[idx].ev_name[ev_idx] = buf;
+			ev_arry[idx].ev_value[ev_idx] = out_str;
+			ev_idx++;
+			continue;
+		}
+
+		if (strncmp(pp->name, "scale.", 6) == 0) {
+			of_property_read_string(dev, pp->name, &out_str);
+			start += 6;
+			len = strlen(start);
+			strncpy(buf, start, strlen(start));
+			of_property_read_string(dev, pp->value, &out_str);
+
+			ev_arry[idx].ev_offset[ev_idx] = -1;
+			ev_arry[idx].ev_name[ev_idx] = buf;
+			ev_arry[idx].ev_value[ev_idx] = out_str;
+			ev_idx++;
+			continue;
+		}
+
+		/*
+		 * Event support by this pmu.
+		 */
+		lval = of_get_property(dev, pp->name, NULL);
+		val = (uint32_t)be32_to_cpup(lval);
+		strncpy(buf, start, len);
+		ev_arry[idx].ev_offset[ev_idx] = val;
+		ev_arry[idx].ev_name[ev_idx] = buf;
+		ev_arry[idx].ev_value[ev_idx] = "\0";
+		ev_idx++;
+	}
+	return 0;
+}
+
+static int uncore_unit_parse(struct device_node *parent,
+				struct ppc64_uncore_type *ptr)
+{
+	struct device_node *child;
+	const __be32 *unit_idx;
+	int idx;
+
+	for_each_available_child_of_node(parent, child) {
+		unit_idx = of_get_property(child, "ibm,dev-id", NULL);
+		idx = (uint32_t)be32_to_cpup(unit_idx);
+		if (populate_events(child, ptr, idx))
+			return -1;
+	}
+
+	if (update_uncore_unit_event_group(ptr))
+		return -1;
+
+	return 0;
+}
+
+static int uncore_create_types(struct device_node *parent)
+{
+	struct device_node *dev_type;
+	struct ppc64_uncore_type *uncore_type;
+	const __be32 *uncore_type_units;
+	int idx = 0, i;
+
+	for_each_child_of_node(parent, dev_type) {
+		uncore_type = (struct ppc64_uncore_type *)
+				kzalloc(sizeof(struct ppc64_uncore_type),
+					GFP_KERNEL);
+		if (!uncore_type)
+			goto fail;
+
+		/*
+		 * Populate the uncore pmu type name and
+		 * # of sub units.
+		 */
+		uncore_type->name = of_get_property(dev_type,
+					"name", NULL);
+		uncore_type_units = of_get_property(dev_type,
+					"sub_units", NULL);
+		uncore_type->num_boxes = be32_to_cpup(uncore_type_units);
+
+		if (uncore_unit_parse(dev_type, uncore_type))
+			goto fail;
+
+		uncore_type->format_group = &p8_uncore_format_group;
+		uncore_type->pmu = &p8_uncore_pmu;
+
+		p8_uncore[idx++] = uncore_type;
+	}
+
+	return 0;
+
+fail:
+	for (i = 0; i < idx; i++)
+		kfree(p8_uncore[i]);
+	return -1;
+}
+
 static int uncore_init(void)
 {
+	struct device_node *dev;
+	const __be32 *gcid;
+	const __be64 *chip_ima_reg;
+	const __be32 *chip_ima_size;
+	int idx = 0;
+
+	dev = of_find_node_with_property(NULL, "ibm,uncore");
+	if (!dev)
+		return -EINVAL;
+
+	for_each_node_with_property(dev, "ibm,uncore") {
+		gcid = of_get_property(dev, "ibm,chip-id", NULL);
+		chip_ima_reg = of_get_property(dev, "reg", NULL);
+		chip_ima_size = of_get_property(dev, "size", NULL);
+		if ((!gcid) || (!chip_ima_reg) || (!chip_ima_size)) {
+			pr_err("%s: device %s missing property \n",
+				__func__, dev->full_name);
+			return -EINVAL;
+		}
+
+		/*
+		 * Get the chip id, populate
+		 * address range/size and translate it.
+		 */
+		idx = (uint32_t)be32_to_cpup(gcid);
+		uncore_per_chip[idx].chip_id = (uint32_t)be32_to_cpup(gcid);
+		uncore_per_chip[idx].preg_base = be64_to_cpup(chip_ima_reg);
+		uncore_per_chip[idx].size = be32_to_cpup(chip_ima_size);
+		uncore_per_chip[idx].vreg_base = (u64)ioremap(
+			(phys_addr_t)uncore_per_chip[idx].preg_base,
+				uncore_per_chip[idx].size);
+
+		/*
+		 * looks for uncore pmu types supported here.
+		 */
+		if (uncore_create_types(dev))
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -163,5 +401,3 @@ int uncore_p8_init(void)
 	ppc64_uncore = p8_uncore;
 	return uncore_init();
 }
-
-
-- 
1.9.1
