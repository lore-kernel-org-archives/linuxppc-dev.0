Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8A841A19C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 21:14:08 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Jul 2015 16:44:07 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5DFF13940072
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:44:02 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6GBDZUX39452836
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:43:36 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6GBDYsa000575
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:43:35 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v5 5/7] powerpc/powernv: add event attribute and group to nest
 pmu
Date: Thu, 16 Jul 2015 16:43:24 +0530
Message-Id: <1437045206-7491-6-git-send-email-maddy@linux.vnet.ibm.com>
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

Add code to create event/format attributes and attribute groups for
each nest pmu.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/nest-pmu.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
index c4c08e4dee55..f3418bdec1cd 100644
--- a/arch/powerpc/perf/nest-pmu.c
+++ b/arch/powerpc/perf/nest-pmu.c
@@ -13,6 +13,17 @@
 static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
 static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
 
+PMU_FORMAT_ATTR(event, "config:0-20");
+static struct attribute *p8_nest_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group p8_nest_format_group = {
+	.name = "format",
+	.attrs = p8_nest_format_attrs,
+};
+
 static int nest_event_info(struct property *pp, char *name,
 			struct nest_ima_events *p8_events, int string, u32 val)
 {
@@ -46,6 +57,56 @@ static int nest_event_info(struct property *pp, char *name,
 	return 0;
 }
 
+/*
+ * Populate event name and string in attribute
+ */
+static struct attribute *dev_str_attr(const char *name, const char *str)
+{
+	struct perf_pmu_events_attr *attr;
+
+	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+
+	sysfs_attr_init(&attr->attr.attr);
+
+	attr->event_str = str;
+	attr->attr.attr.name = name;
+	attr->attr.attr.mode = 0444;
+	attr->attr.show = perf_event_sysfs_show;
+
+	return &attr->attr.attr;
+}
+
+static int update_events_in_group(
+	struct nest_ima_events *p8_events, int idx, struct nest_pmu *pmu)
+{
+	struct attribute_group *attr_group;
+	struct attribute **attrs;
+	int i;
+
+	/*
+	 * Allocate memory for both event attribute group and for
+	 * event attributes array.
+	 */
+	attr_group = kzalloc(((sizeof(struct attribute *) * (idx + 1)) +
+				sizeof(*attr_group)), GFP_KERNEL);
+	if (!attr_group)
+		return -ENOMEM;
+
+	/*
+	 * Assign memory for event attribute array
+	 */
+	attrs = (struct attribute **)(attr_group + 1);
+	attr_group->name = "events";
+	attr_group->attrs = attrs;
+
+	for (i = 0; i < idx; i++, p8_events++)
+		attrs[i] = dev_str_attr((char *)p8_events->ev_name,
+					(char *)p8_events->ev_value);
+
+	pmu->attr_groups[0] = attr_group;
+	return 0;
+}
+
 static int nest_pmu_create(struct device_node *dev, int pmu_index)
 {
 	struct nest_ima_events **p8_events_arr, *p8_events;
@@ -93,6 +154,7 @@ static int nest_pmu_create(struct device_node *dev, int pmu_index)
 			/* Save the name to register it later */
 			sprintf(buf, "Nest_%s", (char *)pp->value);
 			pmu_ptr->pmu.name = (char *)buf;
+			pmu_ptr->attr_groups[1] = &p8_nest_format_group;
 			continue;
 		}
 
@@ -124,6 +186,9 @@ static int nest_pmu_create(struct device_node *dev, int pmu_index)
 		idx++;
 	}
 
+	update_events_in_group(
+		(struct nest_ima_events *)p8_events_arr, idx, pmu_ptr);
+
 	return 0;
 }
 
-- 
1.9.1
