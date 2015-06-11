Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1AD051A09FE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 15:18:09 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 11 Jun 2015 10:48:06 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 5464CE0056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 10:51:27 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5B5I3Th000470
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 10:48:03 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5B5I1st000776
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 10:48:02 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: rusty@rustcorp.com.au, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v2 1/7]powerpc/powernv: Data structure and macros definition
Date: Thu, 11 Jun 2015 10:47:48 +0530
Message-Id: <1433999874-2043-2-git-send-email-maddy@linux.vnet.ibm.com>
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

Create new header file "nest-pmu.h" to add the data structures
and macros needed for the nest pmu support.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/nest-pmu.h | 53 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 arch/powerpc/perf/nest-pmu.h

diff --git a/arch/powerpc/perf/nest-pmu.h b/arch/powerpc/perf/nest-pmu.h
new file mode 100644
index 0000000..ebe7689
--- /dev/null
+++ b/arch/powerpc/perf/nest-pmu.h
@@ -0,0 +1,53 @@
+/*
+ * Nest Performance Monitor counter support for POWER8 processors.
+ *
+ * Copyright (C) 2015 Madhavan Srinivasan, IBM Corporation.
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
+#define P8_MAX_CHIP		32
+#define MAX_PMU_NAME_LEN	256
+#define MAX_EVENTS_SUPPORTED    256
+#define P8_NEST_ENGINE_START	1
+#define P8_NEST_ENGINE_STOP	0
+#define P8_MAX_NEST_PMUS	32
+
+/*
+ * Structure to hold per chip specific memory address
+ * information for nest pmus. Nest Counter data are exported
+ * in per-chip reserved memory region by the PORE Engine.
+ */
+struct perchip_nest_info {
+	uint32_t chip_id;
+	uint64_t pbase;
+	uint64_t vbase;
+	uint32_t size;
+};
+
+/*
+ * Place holder for nest pmu events and values.
+ */
+struct ppc64_nest_ima_events {
+	const char *ev_name;
+	const char *ev_value;
+};
+
+/*
+ * Device tree parser code detects nest pmu support and
+ * registers new nest pmus. This structure will
+ * hold the pmu functions and attrs for each nest pmu and
+ * will be referenced at the time of pmu registration.
+ */
+struct nest_pmu {
+	struct pmu pmu;
+	const struct attribute_group *attr_groups[4];
+};
-- 
1.9.1
