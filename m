Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 761671A19DC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 21:14:09 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Jul 2015 16:44:06 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 745DCE0044
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:47:58 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6GBDZDL18022548
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:43:36 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6GBDXMS000516
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:43:34 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v5 4/7] powerpc/powernv: detect supported nest pmus and its
 events
Date: Thu, 16 Jul 2015 16:43:23 +0530
Message-Id: <1437045206-7491-5-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
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

The nest unit event file from DT, will contain the offset in the
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
 arch/powerpc/perf/nest-pmu.c | 126 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
index e7d45ed4922d..c4c08e4dee55 100644
--- a/arch/powerpc/perf/nest-pmu.c
+++ b/arch/powerpc/perf/nest-pmu.c
@@ -11,6 +11,121 @@
 #include "nest-pmu.h"
 
 static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
+static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
+
+static int nest_event_info(struct property *pp, char *name,
+			struct nest_ima_events *p8_events, int string, u32 val)
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
+	if (string) {
+		/* string content*/
+		if (!pp->value ||
+		   (strnlen(pp->value, pp->length) == pp->length) ||
+		   (pp->length > P8_NEST_MAX_PMU_NAME_LEN))
+			return -EINVAL;
+
+		strncpy(buf, (const char *)pp->value, pp->length);
+	} else
+		sprintf(buf, "event=0x%x", val);
+
+	p8_events->ev_value = buf;
+	return 0;
+}
+
+static int nest_pmu_create(struct device_node *dev, int pmu_index)
+{
+	struct nest_ima_events **p8_events_arr, *p8_events;
+	struct nest_pmu *pmu_ptr;
+	struct property *pp;
+	char *buf, *start;
+	const __be32 *lval;
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
+	p8_events_arr = kzalloc((sizeof(struct nest_ima_events) * 64),
+								GFP_KERNEL);
+	if (!p8_events_arr)
+		return -ENOMEM;
+	p8_events = (struct nest_ima_events *)p8_events_arr;
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
+		/* Skip these, we dont need it */
+		if (!strcmp(pp->name, "phandle") ||
+		    !strcmp(pp->name, "device_type") ||
+		    !strcmp(pp->name, "linux,phandle"))
+			continue;
+
+		if (strncmp(pp->name, "unit.", 5) == 0) {
+			/* Skip first few chars in the name */
+			start += 5;
+			ret = nest_event_info(pp, start, p8_events++, 1, 0);
+		} else if (strncmp(pp->name, "scale.", 6) == 0) {
+			/* Skip first few chars in the name */
+			start += 6;
+			ret = nest_event_info(pp, start, p8_events++, 1, 0);
+		} else {
+			lval = of_get_property(dev, pp->name, NULL);
+			val = (uint32_t)be32_to_cpup(lval);
+
+			ret = nest_event_info(pp, start, p8_events++, 0, val);
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
@@ -19,7 +134,7 @@ static int nest_ima_dt_parser(void)
 	const __be64 *chip_ima_size;
 	struct device_node *dev;
 	struct perchip_nest_info *p8ni;
-	int idx;
+	int idx, ret;
 
 	/*
 	 * "nest-ima" folder contains two things,
@@ -50,6 +165,15 @@ static int nest_ima_dt_parser(void)
 		p8ni->vbase = (uint64_t) phys_to_virt(p8ni->pbase);
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
