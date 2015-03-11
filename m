Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEBEA1A09A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:22 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 23:08:21 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BAA132BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:20 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2BD8C3d39780534
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:20 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2BD7kVN011540
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:07:47 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 1/7] powerpc/powernv: Data structure and macros definition
Date: Wed, 11 Mar 2015 18:37:07 +0530
Message-Id: <1426079233-16720-2-git-send-email-maddy@linux.vnet.ibm.com>
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

Patch adds the data structures and macros 
needed for nest pmu support. "type" structure will 
hold each nest unit and sub-unit information.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/uncore_pmu.h | 89 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 arch/powerpc/perf/uncore_pmu.h

diff --git a/arch/powerpc/perf/uncore_pmu.h b/arch/powerpc/perf/uncore_pmu.h
new file mode 100644
index 0000000..ba4b3f4
--- /dev/null
+++ b/arch/powerpc/perf/uncore_pmu.h
@@ -0,0 +1,89 @@
+/*
+ * Uncore Performance Monitor counter support.
+ *
+ * Derived from Intel's uncore framework
+ *   written by: Liang,Kan
+ *               Zheng, Yan
+ *               Andi Keen
+ *
+ *   Copyright Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; under version
+ * 2 of the License.
+ */
+
+#include <linux/perf_event.h>
+#include <linux/cpumask.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <asm/prom.h>
+#include <asm/opal.h>
+#include <asm/cputhreads.h>
+
+/*
+ * Macros for pmu groups
+ */
+#define pmu_group attr_groups[0]
+#define format_group attr_groups[1]
+#define events_group attr_groups[2]
+
+/*
+ * uncore specific macros
+ */
+#define P8_MAX_CHIP		256
+#define MAX_PMU_NAME_LEN 	128
+#define MAX_UNITS_SUPPORTED	16
+#define MAX_SUB_UNITS		8
+#define MAX_TYPE_EVENTS		16
+#define MAX_EVENTS_SUPPORTED	256
+
+/*
+ * Structure to hold event information for a
+ * uncore pmu type. Device-Tree contain events
+ * and memory offsets to access the counter for
+ * a gievn event. Some events will also carry
+ * unit and scale.
+ */
+struct ppc64_uncore_type_events {
+	int ev_offset[MAX_EVENTS_SUPPORTED];
+	const char *ev_name[MAX_EVENTS_SUPPORTED];
+	const char *ev_value[MAX_EVENTS_SUPPORTED];
+};
+
+/*
+ * Structure to hold per chip specific memory address
+ * information for uncore pmus, since uncore pmus are
+ * per-chip.
+ */
+struct ppc64_uncore_unit {
+	uint32_t chip_id;
+	uint64_t preg_base;
+	uint64_t vreg_base;
+	uint32_t size;
+};
+
+/*
+ * Structure for each uncore unit.
+ */
+struct ppc64_uncore_type {
+	const char *name;
+	int num_boxes;
+	struct pmu *pmu;
+	struct ppc64_uncore_pmu *pmus;
+	struct attribute **event_attrs;
+	const struct attribute_group *attr_groups[4];
+	struct ppc64_uncore_type_events event_arry[MAX_SUB_UNITS];
+};
+
+
+struct ppc64_uncore_pmu {
+	struct pmu pmu;
+	char name[MAX_PMU_NAME_LEN];
+	int pmu_idx;
+	struct ppc64_uncore_type *type;
+};
+
+struct ppc64_uncore_pmu *uncore_event_to_pmu(struct perf_event *event);
+extern int uncore_p8_init(void);
-- 
1.9.1
