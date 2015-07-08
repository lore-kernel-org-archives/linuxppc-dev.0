Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A69F1A2AA8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 23:03:32 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 8 Jul 2015 23:03:31 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CBADB2BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 23:03:28 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t68D3L6d2359794
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jul 2015 23:03:30 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t68D2u3a011585
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jul 2015 23:02:56 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v4 4/7] powerpc/powernv: detect supported nest pmus and its
 events
Date: Wed,  8 Jul 2015 18:31:43 +0530
Message-Id: <1436360506-18805-5-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1436360506-18805-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1436360506-18805-1-git-send-email-maddy@linux.vnet.ibm.com>
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
 arch/powerpc/perf/nest-pmu.c | 124 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
index e7d45ed..6116ff3 100644
--- a/arch/powerpc/perf/nest-pmu.c
+++ b/arch/powerpc/perf/nest-pmu.c
@@ -11,6 +11,119 @@
 #include "nest-pmu.h"
 
 static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
+static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
+
+static int nest_event_info(struct property *pp, char *start,
+			struct nest_ima_events *p8_events, int flg, u32 val)
+{
+	char *buf;
+
+	/* memory for event name */
+	buf = kzalloc(P8_NEST_MAX_PMU_NAME_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	strncpy(buf, start, strlen(start));
+	p8_events->ev_name = buf;
+
+	/* memory for content */
+	buf = kzalloc(P8_NEST_MAX_PMU_NAME_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (flg) {
+		/* string content*/
+		if (!pp->value ||
+		   (strnlen(pp->value, pp->length) == pp->length))
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
+			   (strnlen(pp->value, pp->length) == pp->length))
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
@@ -19,7 +132,7 @@ static int nest_ima_dt_parser(void)
 	const __be64 *chip_ima_size;
 	struct device_node *dev;
 	struct perchip_nest_info *p8ni;
-	int idx;
+	int idx, ret;
 
 	/*
 	 * "nest-ima" folder contains two things,
@@ -50,6 +163,15 @@ static int nest_ima_dt_parser(void)
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
