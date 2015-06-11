Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 277C11A0C4D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 15:18:26 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 11 Jun 2015 10:48:25 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 024A71258053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 10:50:53 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5B5IB007471324
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 10:48:11 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5B5IAYX001559
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 10:48:11 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: rusty@rustcorp.com.au, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v2 5/7]powerpc/powernv: add event attribute and group to nest
 pmu
Date: Thu, 11 Jun 2015 10:47:52 +0530
Message-Id: <1433999874-2043-6-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1433999874-2043-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1433999874-2043-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add code to create event attribute and attribute group for
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
 arch/powerpc/perf/nest-pmu.c | 55 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
index 43d5fde..8fad2d9 100644
--- a/arch/powerpc/perf/nest-pmu.c
+++ b/arch/powerpc/perf/nest-pmu.c
@@ -13,6 +13,55 @@
 static struct perchip_nest_info p8_perchip_nest_info[P8_MAX_CHIP];
 static struct nest_pmu *per_nest_pmu_arr[P8_MAX_NEST_PMUS];
 
+/*
+ * Populate event name and string in attribute
+ */
+struct attribute *dev_str_attr(const char *name, const char *str)
+{
+	struct perf_pmu_events_attr *attr;
+
+	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+
+	attr->event_str = str;
+	attr->attr.attr.name = name;
+	attr->attr.attr.mode = 0444;
+	attr->attr.show = perf_event_sysfs_show;
+
+	return &attr->attr.attr;
+}
+
+int update_events_in_group(
+	struct ppc64_nest_ima_events *p8_events, int idx,
+		struct nest_pmu *pmu)
+{
+	struct attribute_group *attr_group;
+	struct attribute **attrs;
+	int i;
+
+	/* Allocate memory add supported event as event attribute */
+	attr_group = kzalloc(((sizeof(struct attribute *) * (idx + 1)) +
+				sizeof(*attr_group)), GFP_KERNEL);
+	if (!attr_group)
+		return -ENOMEM;
+
+	attrs = (struct attribute **)(attr_group + 1);
+	attr_group->name = "events";
+
+	/*
+	 * struct attribute group contains,  "name" and an
+	 * array of attributes, along other elemsnts.
+	 * link attrs with attribute group's attr array.
+	 */
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
 	struct ppc64_nest_ima_events **p8_events_arr, *p8_events;
@@ -68,7 +117,7 @@ static int nest_pmu_create(struct device_node *dev, int pmu_index)
 
 		buf = kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
 		if (!buf)
-		return -ENOMEM;
+			return -ENOMEM;
 
 		if (strncmp(pp->name, "unit.", 5) == 0) {
 			start += 5;
@@ -126,6 +175,10 @@ static int nest_pmu_create(struct device_node *dev, int pmu_index)
 		}
 	}
 
+	update_events_in_group(
+		(struct ppc64_nest_ima_events *)p8_events_arr,
+							idx, pmu_ptr);
+
 	return 0;
 }
 
-- 
1.9.1
