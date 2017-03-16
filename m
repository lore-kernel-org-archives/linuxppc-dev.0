Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkKzD3M4DzDqZb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:36:24 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2G7SaEE070690
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:36:22 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297cf6ej4m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:36:22 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 17:36:19 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2G7a8dJ11468816
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:36:16 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2G7ZgCn009178
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:35:43 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v5 01/13] powerpc/powernv: Data structure and macros
 definitions
Date: Thu, 16 Mar 2017 13:04:55 +0530
In-Reply-To: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1489649707-8021-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hemant Kumar <hemant@linux.vnet.ibm.com>

Create new header file "imc-pmu.h" to add the data structures
and macros needed for IMC pmu support.

Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Stephane Eranian <eranian@google.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h | 73 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 arch/powerpc/include/asm/imc-pmu.h

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
new file mode 100644
index 000000000000..323232248cc4
--- /dev/null
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -0,0 +1,73 @@
+#ifndef PPC_POWERNV_IMC_PMU_DEF_H
+#define PPC_POWERNV_IMC_PMU_DEF_H
+
+/*
+ * IMC Nest Performance Monitor counter support.
+ *
+ * Copyright (C) 2016 Madhavan Srinivasan, IBM Corporation.
+ *           (C) 2016 Hemant K Shaw, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <asm/opal.h>
+
+#define IMC_MAX_CHIPS			32
+#define IMC_MAX_PMUS			32
+#define IMC_MAX_PMU_NAME_LEN		256
+
+#define NEST_IMC_ENGINE_START		1
+#define NEST_IMC_ENGINE_STOP		0
+#define NEST_MAX_PAGES			16
+
+#define NEST_IMC_PRODUCTION_MODE	1
+
+#define IMC_DTB_COMPAT		"ibm,opal-in-memory-counters"
+#define IMC_DTB_NEST_COMPAT	"ibm,imc-counters-nest"
+
+/*
+ * Structure to hold per chip specific memory address
+ * information for nest pmus. Nest Counter data are exported
+ * in per-chip reserved memory region by the PORE Engine.
+ */
+struct perchip_nest_info {
+	u32 chip_id;
+	u64 pbase;
+	u64 vbase[NEST_MAX_PAGES];
+	u64 size;
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
+/*
+ * Device tree parser code detects IMC pmu support and
+ * registers new IMC pmus. This structure will
+ * hold the pmu functions and attrs for each imc pmu and
+ * will be referenced at the time of pmu registration.
+ */
+struct imc_pmu {
+	struct pmu pmu;
+	int domain;
+	const struct attribute_group *attr_groups[4];
+};
+
+/*
+ * Domains for IMC PMUs
+ */
+#define IMC_DOMAIN_NEST		1
+
+#define UNKNOWN_DOMAIN		-1
+
+#endif /* PPC_POWERNV_IMC_PMU_DEF_H */
-- 
2.7.4
