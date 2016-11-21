Return-Path: <hemant@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMdW540bjzDvWk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:25 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAL68aNS028592
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 01:10:23 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26us3bcv32-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 01:10:22 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 21 Nov 2016 16:10:18 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 057FA2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:17 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAL6AG2P46268666
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:16 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAL6AFrB030325
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 17:10:16 +1100
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 stewart@linux.vnet.ibm.com, dja@axtens.net, mikey@neuling.org,
 maddy@linux.vnet.ibm.com, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v2 1/6] powerpc/powernv: Data structure and macros definitions
Date: Mon, 21 Nov 2016 11:40:00 +0530
In-Reply-To: <1479708605-10238-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1479708605-10238-1-git-send-email-hemant@linux.vnet.ibm.com>
Message-Id: <1479708605-10238-2-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create new header file "ima-pmu.h" to add the data structures
and macros needed for IMA pmu support.


Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ima-pmu.h | 73 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 arch/powerpc/include/asm/ima-pmu.h

diff --git a/arch/powerpc/include/asm/ima-pmu.h b/arch/powerpc/include/asm/ima-pmu.h
new file mode 100644
index 0000000..0ed8886
--- /dev/null
+++ b/arch/powerpc/include/asm/ima-pmu.h
@@ -0,0 +1,73 @@
+#ifndef PPC_POWERNV_IMA_PMU_DEF_H
+#define PPC_POWERNV_IMA_PMU_DEF_H
+
+/*
+ * Nest Performance Monitor counter support.
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
+#define IMA_MAX_CHIPS			32
+#define IMA_MAX_PMUS			32
+#define IMA_MAX_PMU_NAME_LEN		256
+
+#define NEST_IMA_ENGINE_START		1
+#define NEST_IMA_ENGINE_STOP		0
+#define NEST_MAX_PAGES			16
+
+#define NEST_IMA_PRODUCTION_MODE	1
+
+#define IMA_DTB_COMPAT		"ibm,opal-in-memory-counters"
+#define IMA_DTB_NEST_COMPAT	"ibm,ima-counters-chip"
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
+struct ima_events {
+	char *ev_name;
+	char *ev_value;
+};
+
+/*
+ * Device tree parser code detects IMA pmu support and
+ * registers new IMA pmus. This structure will
+ * hold the pmu functions and attrs for each ima pmu and
+ * will be referenced at the time of pmu registration.
+ */
+struct ima_pmu {
+	struct pmu pmu;
+	int domain;
+	const struct attribute_group *attr_groups[4];
+};
+
+/*
+ * Domains for IMA PMUs
+ */
+#define IMA_DOMAIN_NEST		1
+
+#define UNKNOWN_DOMAIN		-1
+
+#endif /* PPC_POWERNV_IMA_PMU_DEF_H */
-- 
2.7.4
