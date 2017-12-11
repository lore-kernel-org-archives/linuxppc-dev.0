Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywC2546W2zDr3K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Dec 2017 16:58:53 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBB5uQq0121403
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Dec 2017 00:58:50 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eskrfsvxh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Dec 2017 00:58:50 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 11 Dec 2017 05:58:48 -0000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH 3/3] powerpc/perf: Passs struct imc_events as a parameter to
 imc_parse_event()
Date: Mon, 11 Dec 2017 11:28:37 +0530
In-Reply-To: <1512971917-23851-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1512971917-23851-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1512971917-23851-4-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the allocation of struct imc_events from imc_parse_event(). Instead pass
imc_events as a parameter to imc_parse_event(), which is a pointer to a slot in
the array allocated in update_events_in_group().

Reported by: Dan Carpenter ("powerpc/perf: Fix a sizeof() typo so we allocate less memory")
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h |  2 +-
 arch/powerpc/perf/imc-pmu.c        | 66 +++++++++++++++++++++++---------------
 2 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index fad0e6f..080731d 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -71,7 +71,7 @@ struct imc_events {
 struct imc_pmu {
 	struct pmu pmu;
 	struct imc_mem_info *mem_info;
-	struct imc_events **events;
+	struct imc_events *events;
 	/*
 	 * Attribute groups for the PMU. Slot 0 used for
 	 * format attribute, slot 1 used for cpusmask attribute,
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 71f425f..5cb1f31 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -116,17 +116,13 @@ static struct attribute *device_str_attr_create(const char *name, const char *st
 	return &attr->attr.attr;
 }
 
-struct imc_events *imc_parse_event(struct device_node *np, const char *scale,
-				  const char *unit, const char *prefix, u32 base)
+static int imc_parse_event(struct device_node *np, const char *scale,
+				  const char *unit, const char *prefix,
+				  u32 base, struct imc_events *event)
 {
-	struct imc_events *event;
 	const char *s;
 	u32 reg;
 
-	event = kzalloc(sizeof(struct imc_events), GFP_KERNEL);
-	if (!event)
-		return NULL;
-
 	if (of_property_read_u32(np, "reg", &reg))
 		goto error;
 	/* Add the base_reg value to the "reg" */
@@ -157,14 +153,32 @@ struct imc_events *imc_parse_event(struct device_node *np, const char *scale,
 			goto error;
 	}
 
-	return event;
+	return 0;
 error:
 	kfree(event->unit);
 	kfree(event->scale);
 	kfree(event->name);
-	kfree(event);
+	return -EINVAL;
+}
+
+/*
+ * imc_free_events: Function to cleanup the events list, having
+ * 		    "nr_entries".
+ */
+static void imc_free_events(struct imc_events *events, int nr_entries)
+{
+	int i;
+
+	/* Nothing to clean, return */
+	if (!events)
+		return;
+	for (i = 0; i < nr_entries; i++) {
+		kfree(events[i].unit);
+		kfree(events[i].scale);
+		kfree(events[i].name);
+	}
 
-	return NULL;
+	kfree(events);
 }
 
 /*
@@ -176,9 +190,8 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 	struct attribute_group *attr_group;
 	struct attribute **attrs, *dev_str;
 	struct device_node *np, *pmu_events;
-	struct imc_events *ev;
 	u32 handle, base_reg;
-	int i=0, j=0, ct;
+	int i = 0, j = 0, ct, ret;
 	const char *prefix, *g_scale, *g_unit;
 	const char *ev_val_str, *ev_scale_str, *ev_unit_str;
 
@@ -216,15 +229,17 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 	ct = 0;
 	/* Parse the events and update the struct */
 	for_each_child_of_node(pmu_events, np) {
-		ev = imc_parse_event(np, g_scale, g_unit, prefix, base_reg);
-		if (ev)
-			pmu->events[ct++] = ev;
+		ret = imc_parse_event(np, g_scale, g_unit, prefix, base_reg, &pmu->events[ct]);
+		if (!ret)
+			ct++;
 	}
 
 	/* Allocate memory for attribute group */
 	attr_group = kzalloc(sizeof(*attr_group), GFP_KERNEL);
-	if (!attr_group)
+	if (!attr_group) {
+		imc_free_events(pmu->events, ct);
 		return -ENOMEM;
+	}
 
 	/*
 	 * Allocate memory for attributes.
@@ -237,31 +252,31 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 	attrs = kcalloc(((ct * 3) + 1), sizeof(struct attribute *), GFP_KERNEL);
 	if (!attrs) {
 		kfree(attr_group);
-		kfree(pmu->events);
+		imc_free_events(pmu->events, ct);
 		return -ENOMEM;
 	}
 
 	attr_group->name = "events";
 	attr_group->attrs = attrs;
 	do {
-		ev_val_str = kasprintf(GFP_KERNEL, "event=0x%x", pmu->events[i]->value);
-		dev_str = device_str_attr_create(pmu->events[i]->name, ev_val_str);
+		ev_val_str = kasprintf(GFP_KERNEL, "event=0x%x", pmu->events[i].value);
+		dev_str = device_str_attr_create(pmu->events[i].name, ev_val_str);
 		if (!dev_str)
 			continue;
 
 		attrs[j++] = dev_str;
-		if (pmu->events[i]->scale) {
-			ev_scale_str = kasprintf(GFP_KERNEL, "%s.scale",pmu->events[i]->name);
-			dev_str = device_str_attr_create(ev_scale_str, pmu->events[i]->scale);
+		if (pmu->events[i].scale) {
+			ev_scale_str = kasprintf(GFP_KERNEL, "%s.scale", pmu->events[i].name);
+			dev_str = device_str_attr_create(ev_scale_str, pmu->events[i].scale);
 			if (!dev_str)
 				continue;
 
 			attrs[j++] = dev_str;
 		}
 
-		if (pmu->events[i]->unit) {
-			ev_unit_str = kasprintf(GFP_KERNEL, "%s.unit",pmu->events[i]->name);
-			dev_str = device_str_attr_create(ev_unit_str, pmu->events[i]->unit);
+		if (pmu->events[i].unit) {
+			ev_unit_str = kasprintf(GFP_KERNEL, "%s.unit", pmu->events[i].name);
+			dev_str = device_str_attr_create(ev_unit_str, pmu->events[i].unit);
 			if (!dev_str)
 				continue;
 
@@ -272,7 +287,6 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 	/* Save the event attribute */
 	pmu->attr_groups[IMC_EVENT_ATTR] = attr_group;
 
-	kfree(pmu->events);
 	return 0;
 }
 
-- 
2.7.4
