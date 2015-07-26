Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 843FF1A0065
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 01:30:25 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 27 Jul 2015 21:00:21 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D23FCE0099
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 00:28:42 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6QIsapC55509040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 00:24:37 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6QHVHeB011653
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 23:01:18 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v6 4/7]powerpc/powernv: detect supported nest pmus and its
 events
Date: Mon, 27 Jul 2015 00:24:21 +0530
Message-Id: <1437936864-4402-5-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1437936864-4402-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1437936864-4402-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Parse device tree to detect supported nest pmu units. Traverse
through each nest pmu unit folder to find supported events and
corresponding unit/scale files (if any).

The nest unit event file from Device Tree will contain the offset in the
reserved memory region to get the counter data for a given event.
Kernel code uses this offset as event configuration value.

Device tree parser code also looks for scale/unit in the file name and
passes on the file as an event attr for perf tool to use in the post
processing.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/nest-pmu.c | 137 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
index 48738f9f6426..292fc2b91ed0 100644
--- a/arch/powerpc/perf/nest-pmu.c
+++ b/arch/powerpc/perf/nest-pmu.c
@@ -11,12 +11,140 @@
 #include "nest-pmu.h"
 
 static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
+static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
+
+static int nest_event_info(char *name, struct nest_ima_events *p8_events)
+{
+	char *buf;
+
+	/* memory for event name */
+	buf = kzalloc(P8_NEST_MAX_PMU_NAME_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	strncpy(buf, name, strlen(name));
+	p8_events->ev_name = buf;
+
+	/* memory for content */
+	buf = kzalloc(P8_NEST_MAX_PMU_NAME_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	p8_events->ev_value = buf;
+	return 0;
+}
+
+static int nest_event_info_str(struct property *pp, char *name,
+					struct nest_ima_events *p8_events)
+{
+	if (nest_event_info(name, p8_events))
+		return -ENOMEM;
+
+	if (!pp->value || (strnlen(pp->value, pp->length) == pp->length) ||
+	    (pp->length > P8_NEST_MAX_PMU_NAME_LEN))
+		return -EINVAL;
+
+	strncpy(p8_events->ev_value, (const char *)pp->value, pp->length);
+
+	return 0;
+}
+
+static int nest_event_info_val(char *name, u32 val,
+					struct nest_ima_events *p8_events)
+{
+	if (nest_event_info(name, p8_events))
+		return -ENOMEM;
+
+	sprintf(p8_events->ev_value, "event=0x%x", val);
+
+	return 0;
+}
+
+static int nest_pmu_create(struct device_node *dev, int pmu_index)
+{
+	struct nest_ima_events *p8_events;
+	struct nest_pmu *pmu_ptr;
+	struct property *pp;
+	char *buf, *start;
+	u32 val;
+	int idx = 0, ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	/* memory for nest pmus */
+	pmu_ptr = kzalloc(sizeof(struct nest_pmu), GFP_KERNEL);
+	if (!pmu_ptr)
+		return -ENOMEM;
+
+	/* Needed for hotplug/migration */
+	per_nest_pmu_arr[pmu_index] = pmu_ptr;
+
+	/* memory for nest pmu events */
+	p8_events = kzalloc((sizeof(struct nest_ima_events) *
+				P8_NEST_MAX_EVENTS_SUPPORTED), GFP_KERNEL);
+	if (!p8_events)
+		return -ENOMEM;
+
+	/*
+	 * Loop through each property
+	 */
+	for_each_property_of_node(dev, pp) {
+		start = pp->name;
+
+		if (!strcmp(pp->name, "name")) {
+			if (!pp->value ||
+			   (strnlen(pp->value, pp->length) == pp->length) ||
+			   (pp->length > P8_NEST_MAX_PMU_NAME_LEN))
+				return -EINVAL;
+
+			buf = kzalloc(P8_NEST_MAX_PMU_NAME_LEN, GFP_KERNEL);
+			if (!buf)
+				return -ENOMEM;
+
+			/* Save the name to register it later */
+			sprintf(buf, "Nest_%s", (char *)pp->value);
+			pmu_ptr->pmu.name = (char *)buf;
+			continue;
+		}
+
+		/* Skip these, we don't need it */
+		if (!strcmp(pp->name, "phandle") ||
+		    !strcmp(pp->name, "device_type") ||
+		    !strcmp(pp->name, "linux,phandle"))
+			continue;
+
+		/*
+		 * Strip the prefix from "unit" and "scale" property name
+		 * since it is only a marker search
+		 */
+		if (strncmp(pp->name, "unit.", 5) == 0) {
+			start += 5;
+			ret = nest_event_info_str(pp, start, &p8_events[idx]);
+		} else if (strncmp(pp->name, "scale.", 6) == 0) {
+			start += 6;
+			ret = nest_event_info_str(pp, start, &p8_events[idx]);
+		} else {
+			of_property_read_u32(dev, pp->name, &val);
+			ret = nest_event_info_val(start, val, &p8_events[idx]);
+		}
+
+		if (ret)
+			return ret;
+
+		/* book keeping */
+		idx++;
+	}
+
+	return 0;
+}
 
 static int nest_ima_dt_parser(void)
 {
 	struct device_node *dev;
 	struct perchip_nest_info *p8ni;
 	u32 idx;
+	int ret;
 
 	/*
 	 * "nest-ima" folder contains two things,
@@ -39,6 +167,15 @@ static int nest_ima_dt_parser(void)
 		p8ni->vbase = (u64)phys_to_virt(p8ni->pbase);
 	}
 
+	/* Look for supported Nest PMU units */
+	idx = 0;
+	for_each_node_by_type(dev, "nest-ima-unit") {
+		ret = nest_pmu_create(dev, idx);
+		if (ret)
+			return ret;
+		idx++;
+	}
+
 	return 0;
 }
 
-- 
1.9.1
