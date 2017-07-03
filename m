Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1MWP3LHlzDr44
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 19:38:09 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v639XiPI085685
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 05:38:06 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bem6g9bcb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Jul 2017 05:38:06 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 3 Jul 2017 19:38:03 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v639c1Jr6947110
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 19:38:01 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v639bqi0027577
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 19:37:53 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH v12 01/10] powerpc/powernv: Data structure and macros
 definitions for IMC
Date: Mon,  3 Jul 2017 15:07:47 +0530
In-Reply-To: <1499074673-30576-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1499074673-30576-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1499074673-30576-2-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Create a new header file to add the data structures and
macros needed for In-Memory Collection (IMC) counter support.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h | 99 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 arch/powerpc/include/asm/imc-pmu.h

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
new file mode 100644
index 000000000000..ffaea0b9c13e
--- /dev/null
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -0,0 +1,99 @@
+#ifndef PPC_POWERNV_IMC_PMU_DEF_H
+#define PPC_POWERNV_IMC_PMU_DEF_H
+
+/*
+ * IMC Nest Performance Monitor counter support.
+ *
+ * Copyright (C) 2017 Madhavan Srinivasan, IBM Corporation.
+ *           (C) 2017 Anju T Sudhakar, IBM Corporation.
+ *           (C) 2017 Hemant K Shaw, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or later version.
+ */
+
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <asm/opal.h>
+
+/*
+ * For static allocation of some of the structures.
+ */
+#define IMC_MAX_PMUS			32
+
+/*
+ * This macro is used for memory buffer allocation of
+ * event names and event string
+ */
+#define IMC_MAX_NAME_VAL_LEN		96
+
+/*
+ * Currently Microcode supports a max of 256KB of counter memory
+ * in the reserved memory region. Max pages to mmap (considering 4K PAGESIZE).
+ */
+#define IMC_MAX_PAGES			64
+
+/*
+ *Compatbility macros for IMC devices
+ */
+#define IMC_DTB_COMPAT			"ibm,opal-in-memory-counters"
+#define IMC_DTB_UNIT_COMPAT		"ibm,imc-counters"
+
+/*
+ * Structure to hold memory address information for imc units.
+ */
+struct imc_mem_info {
+	u32 id;
+	u64 *vbase[IMC_MAX_PAGES];
+};
+
+/*
+ * Place holder for nest pmu events and values.
+ */
+struct imc_events {
+	char *ev_name;
+	char *ev_value;
+};
+
+#define IMC_FORMAT_ATTR		0
+#define IMC_CPUMASK_ATTR	1
+#define IMC_EVENT_ATTR		2
+#define IMC_NULL_ATTR		3
+
+/*
+ * Device tree parser code detects IMC pmu support and
+ * registers new IMC pmus. This structure will hold the
+ * pmu functions, events, counter memory information
+ * and attrs for each imc pmu and will be referenced at
+ * the time of pmu registration.
+ */
+struct imc_pmu {
+	struct pmu pmu;
+	int domain;
+	/*
+	 * flag to notify whether the memory is mmaped
+	 * or allocated by kernel.
+	 */
+	int imc_counter_mmaped;
+	struct imc_mem_info *mem_info;
+	struct imc_events *events;
+	u32 counter_mem_size;
+	/*
+	 * Attribute groups for the PMU. Slot 0 used for
+	 * format attribute, slot 1 used for cpusmask attribute,
+	 * slot 2 used for event attribute. Slot 3 keep as
+	 * NULL.
+	 */
+	const struct attribute_group *attr_groups[4];
+};
+
+/*
+ * Domains for IMC PMUs
+ */
+#define IMC_DOMAIN_NEST		1
+
+#endif /* PPC_POWERNV_IMC_PMU_DEF_H */
-- 
2.11.0
