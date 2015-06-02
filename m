Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44B931A0D6A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 02:02:36 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 3 Jun 2015 02:02:35 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E00FF2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 02:02:34 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52G1B5N35717322
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 02:01:19 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52G0lR3019470
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 02:00:47 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v1 7/9]powerpc/powernv: Event attr creation and PMU
 registration
Date: Tue,  2 Jun 2015 21:29:36 +0530
Message-Id: <1433260778-26497-8-git-send-email-maddy@linux.vnet.ibm.com>
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

Patch adds common event attribute function and Nest pmu registration call.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/nest-pmu.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
index 514a0be..dd84fd7 100644
--- a/arch/powerpc/perf/nest-pmu.c
+++ b/arch/powerpc/perf/nest-pmu.c
@@ -244,6 +244,49 @@ static int update_pmu_ops(struct nest_pmu *pmu)
 	return 0;
 }
 
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
+int update_events_in_group(
+	struct ppc64_nest_ima_events *p8_events, int idx,
+		struct nest_pmu *pmu)
+{
+	struct attribute_group *attr_group;
+	struct attribute **attrs;
+	int i;
+
+	attr_group = kzalloc(((sizeof(struct attribute *) * (idx + 1)) +
+				sizeof(*attr_group)), GFP_KERNEL);
+	if (!attr_group)
+		return -ENOMEM;
+
+	attrs = (struct attribute **)(attr_group + 1);
+	attr_group->name = "events";
+	attr_group->attrs = attrs;
+
+	for (i=0; i< idx; i++, p8_events++)
+		attrs[i] = dev_str_attr((char *)p8_events->ev_name,
+						(char *)p8_events->ev_value);
+
+	pmu->attr_groups[0] = attr_group;
+	return 0;
+}
+
+
 static int nest_pmu_create(struct device_node *dev, int pmu_index)
 {
 	struct ppc64_nest_ima_events **p8_events_arr;
@@ -364,6 +407,15 @@ static int nest_pmu_create(struct device_node *dev, int pmu_index)
 		}
 	}
 
+	update_events_in_group(
+		(struct ppc64_nest_ima_events *)p8_events_arr,
+							idx, pmu_ptr);
+	update_pmu_ops(pmu_ptr);
+
+	/* Register the pmu */
+	perf_pmu_register(&pmu_ptr->pmu, pmu_ptr->pmu.name, -1);
+	printk(KERN_INFO "Nest PMU %s Registered\n", pmu_ptr->pmu.name);
+
 	return 0;
 }
 
-- 
1.9.1
