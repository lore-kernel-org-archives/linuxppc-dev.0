Return-Path: <maddy@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F18E81A09D9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:28 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7DD2D140142
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 00:08:28 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 23:08:27 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 14C8C357804F
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 00:08:25 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2BD8GHo35848420
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 00:08:24 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2BD7oex011589
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 00:07:51 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 2/7] powerpc/powernv: uncore foundation code
Date: Wed, 11 Mar 2015 18:37:08 +0530
Message-Id: <1426079233-16720-3-git-send-email-maddy@linux.vnet.ibm.com>
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

Patch adds the foundation code enable nest pmu. It defines
various init routines and these are based on Intel's uncore
framework. But it does differ since "box" structure abstraction
is not implemented here.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/uncore_pmu.c | 104 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 arch/powerpc/perf/uncore_pmu.c

diff --git a/arch/powerpc/perf/uncore_pmu.c b/arch/powerpc/perf/uncore_pmu.c
new file mode 100644
index 0000000..cc544d3
--- /dev/null
+++ b/arch/powerpc/perf/uncore_pmu.c
@@ -0,0 +1,104 @@
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
+#include "uncore_pmu.h"
+
+struct ppc64_uncore_type *empty_uncore[] = { NULL, };
+struct ppc64_uncore_type **ppc64_uncore = empty_uncore;
+
+struct ppc64_uncore_pmu *uncore_event_to_pmu(struct perf_event *event)
+{
+	return container_of(event->pmu, struct ppc64_uncore_pmu, pmu);
+}
+
+int __init uncore_type_init(struct ppc64_uncore_type *type)
+{
+	struct ppc64_uncore_pmu *pmus;
+	int i;
+
+	pmus = kzalloc(sizeof(*pmus) * type->num_boxes, GFP_KERNEL);
+	if (!pmus)
+		return -ENOMEM;
+
+	type->pmus = pmus;
+
+	for (i = 0; i < type->num_boxes; i++) {
+		pmus[i].pmu_idx = i;
+		pmus[i].type = type;
+		pmus[i].pmu = *type->pmu;
+		sprintf((char *)pmus[i].name, "uncore_%s_%d",
+				type->name, (int)i);
+	}
+
+	return 0;
+}
+
+int __init uncore_types_init(struct ppc64_uncore_type **types)
+{
+	int i, ret;
+
+	for (i = 0; types[i]; i++) {
+		ret = uncore_type_init(types[i]);
+		if (ret)
+			goto fail;
+	}
+	return 0;
+fail:
+	while (--i >= 0)
+		kfree(types[i]);
+	return ret;
+}
+
+static int __init uncore_pmus_register(void)
+{
+	struct ppc64_uncore_pmu *pmus;
+	struct pmu *pmu;
+	struct ppc64_uncore_type *type;
+	int i, j, ret;
+
+	for (i = 0; ppc64_uncore[i]; i++) {
+		type = ppc64_uncore[i];
+		for (j = 0; j < type->num_boxes; j++) {
+			pmus = &type->pmus[j];
+			pmu = &pmus->pmu;
+			pmu->attr_groups = pmus->type->attr_groups;
+			ret = perf_pmu_register(pmu, pmus->name, -1);
+		}
+	}
+
+	return 0;
+}
+
+static int __init uncore_init(void)
+{
+	int ret = 0;
+
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8") ||
+	    !cpu_has_feature(CPU_FTR_HVMODE))
+		return ret;
+
+	ret = uncore_types_init(ppc64_uncore);
+	if (ret)
+		return ret;
+
+	uncore_pmus_register();
+
+	return ret;
+}
+
+device_initcall(uncore_init);
+
-- 
1.9.1
