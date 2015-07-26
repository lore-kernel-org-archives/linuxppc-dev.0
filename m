Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70F2D1A0065
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 01:15:40 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 27 Jul 2015 20:45:35 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2147AE009C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 00:28:44 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6QIscUx48300048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 00:24:38 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6QHVJYR011680
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 23:01:19 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v6 5/7]powerpc/powernv: add event attribute and group to nest
 pmu
Date: Mon, 27 Jul 2015 00:24:22 +0530
Message-Id: <1437936864-4402-6-git-send-email-maddy@linux.vnet.ibm.com>
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
 arch/powerpc/perf/nest-pmu.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
index 292fc2b91ed0..4a74ffb97741 100644
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
 static int nest_event_info(char *name, struct nest_ima_events *p8_events)
 {
 	char *buf;
@@ -60,6 +71,53 @@ static int nest_event_info_val(char *name, u32 val,
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
+	/* Allocate memory for attribute group */
+	attr_group = kzalloc(sizeof(*attr_group), GFP_KERNEL);
+	if (!attr_group)
+		return -ENOMEM;
+
+	/* Allocate memory for attributes */
+	attrs = kzalloc((sizeof(struct attribute *) * (idx + 1)), GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
+
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
 	struct nest_ima_events *p8_events;
@@ -105,6 +163,7 @@ static int nest_pmu_create(struct device_node *dev, int pmu_index)
 			/* Save the name to register it later */
 			sprintf(buf, "Nest_%s", (char *)pp->value);
 			pmu_ptr->pmu.name = (char *)buf;
+			pmu_ptr->attr_groups[1] = &p8_nest_format_group;
 			continue;
 		}
 
@@ -136,6 +195,8 @@ static int nest_pmu_create(struct device_node *dev, int pmu_index)
 		idx++;
 	}
 
+	update_events_in_group(p8_events, idx, pmu_ptr);
+
 	return 0;
 }
 
-- 
1.9.1
