Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0EB91A0DFE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 02:02:33 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 3 Jun 2015 02:02:32 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E08C2357804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 02:02:30 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52G17NV54263818
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 02:01:15 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52G0h4O019395
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 02:00:43 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v1 6/9]powerpc/powernv: dt parser function for nest pmu and
 its events
Date: Tue,  2 Jun 2015 21:29:35 +0530
Message-Id: <1433260778-26497-7-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch adds a device-tree parser function to detect each Nest PMU
and will traverse through the folder to find the supported events and
corresponding unit and scale files, if any.

Event file will contain the offset in HOMER region to get the counter data
for a given event. Kernel DT parser looks for scale/unit in the file name
and pass on the file as an event attr for perf tool to use in the
post processing. For scale and unit, DT will have file name starting with
"scale.<event name>.scale" and "unit.<event name>.unit".

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/nest-pmu.c | 141 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
index c979e57..514a0be 100644
--- a/arch/powerpc/perf/nest-pmu.c
+++ b/arch/powerpc/perf/nest-pmu.c
@@ -12,6 +12,7 @@
 #include "nest-pmu.h"
 
 static struct perchip_nest_info p8_perchip_nest_info[P8_MAX_CHIP];
+static struct nest_pmu *per_nestpmu_arr[P8_MAX_NEST_PMUS];
 static cpumask_t cpu_mask_nest_pmu;
 
 static ssize_t cpumask_nest_pmu_get_attr(struct device *dev,
@@ -243,6 +244,129 @@ static int update_pmu_ops(struct nest_pmu *pmu)
 	return 0;
 }
 
+static int nest_pmu_create(struct device_node *dev, int pmu_index)
+{
+	struct ppc64_nest_ima_events **p8_events_arr;
+	struct ppc64_nest_ima_events *p8_events;
+	struct property *pp;
+	char *buf;
+	const __be32 *lval;
+	u32 val;
+	int len, idx = 0;
+	struct nest_pmu *pmu_ptr;
+	const char *start, *end;
+
+	if (!dev)
+		return -EINVAL;
+
+	pmu_ptr = kzalloc(sizeof(struct nest_pmu), GFP_KERNEL);
+	if (!pmu_ptr)
+		return -ENOMEM;
+
+	/* Needed for hotplug/migration */
+	per_nestpmu_arr[pmu_index] = pmu_ptr;
+
+	p8_events_arr = kzalloc((sizeof(struct ppc64_nest_ima_events) * 64),
+								GFP_KERNEL);
+	if (!p8_events_arr)
+		return -ENOMEM;
+	p8_events = (struct ppc64_nest_ima_events *)p8_events_arr;
+
+	/*
+	 * Loop through each property
+	 */
+	for_each_property_of_node(dev, pp) {
+		start = pp->name;
+		end = start + strlen(start);
+		len = strlen(start);
+
+		if (!strcmp(pp->name, "name")) {
+			if (!pp->value ||
+			   (strnlen(pp->value, pp->length) >= pp->length))
+				return -EINVAL;
+
+			buf = kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
+			if (!buf)
+				return -ENOMEM;
+
+			sprintf(buf, "Nest_%s", (char *)pp->value);
+			pmu_ptr->pmu.name = (char *)buf;
+			pmu_ptr->attr_groups[1] = &p8_nest_format_group;
+			pmu_ptr->attr_groups[2] = &cpumask_nest_pmu_attr_group;
+		}
+
+		/* Skip these, we dont need it */
+		if (!strcmp(pp->name, "name") ||
+		    !strcmp(pp->name, "phandle") ||
+		    !strcmp(pp->name, "device_type") ||
+		    !strcmp(pp->name, "linux,phandle"))
+			continue;
+
+		buf = kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		if (strncmp(pp->name, "unit.", 5) == 0) {
+			start += 5;
+			len = strlen(start);
+			strncpy(buf, start, strlen(start));
+			p8_events->ev_name = buf;
+
+			if (!pp->value ||
+                            (strnlen(pp->value, pp->length) >= pp->length))
+				return -EINVAL;
+
+			buf = kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
+			if (!buf)
+				return -ENOMEM;
+
+			strncpy(buf, (const char *)pp->value, pp->length);
+			p8_events->ev_value = buf;
+			idx++;
+			p8_events++;
+
+		} else if (strncmp(pp->name, "scale.", 6) == 0) {
+			start += 6;
+			len = strlen(start);
+			strncpy(buf, start, strlen(start));
+			p8_events->ev_name = buf;
+
+			if (!pp->value ||
+			   (strnlen(pp->value, pp->length) >= pp->length))
+				return -EINVAL;
+
+			buf = kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
+			if (!buf)
+				return -ENOMEM;
+
+			strncpy(buf, (const char *)pp->value, pp->length);
+			p8_events->ev_value = buf;
+			idx++;
+			p8_events++;
+
+		} else {
+			strncpy(buf, start, len);
+			p8_events->ev_name = buf;
+			lval = of_get_property(dev, pp->name, NULL);
+			val = (uint32_t)be32_to_cpup(lval);
+
+			/*
+			* Use DT property value as the event
+			*/
+			buf = kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
+			if (!buf)
+                                return -ENOMEM;
+
+			sprintf(buf,"event=0x%x", val);
+			p8_events->ev_value = buf;
+			p8_events++;
+			idx++;
+		}
+	}
+
+	return 0;
+}
+
 static int nest_ima_detect_parse(void)
 {
 	const __be32 *gcid;
@@ -270,6 +394,21 @@ static int nest_ima_detect_parse(void)
 		rc = 0;
 	}
 
+	/*
+	 * At this point if nest-ima not found in DT, return.
+	 */
+	if (rc)
+		return rc;
+
+	/*
+	 * Look for Nest IMA units supported here.
+	 */
+	idx = 0; /* Reuse for nest pmu counts */
+	for_each_node_by_type(dev, "nest-ima-unit") {
+		nest_pmu_create(dev, idx);
+		idx++;
+	}
+
 	return rc;
 }
 
@@ -288,7 +427,7 @@ static int __init nest_pmu_init(void)
 	cpumask_chip();
 
 	/*
-	 * Detect the Nest PMU feature
+	 * Detect the Nest PMU feature and register the pmus
 	 */
 	if (nest_ima_detect_parse())
 		return 0;
-- 
1.9.1
