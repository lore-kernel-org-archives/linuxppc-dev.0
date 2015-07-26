Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 801271A09A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 02:10:51 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 27 Jul 2015 21:40:48 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8D456394009B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 00:24:32 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6QIsWv957802986
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 00:24:32 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6QHVDvW011577
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 23:01:13 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v6 1/7]powerpc/powernv: Data structure and macros definition
Date: Mon, 27 Jul 2015 00:24:18 +0530
Message-Id: <1437936864-4402-2-git-send-email-maddy@linux.vnet.ibm.com>
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
 arch/powerpc/perf/nest-pmu.h | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 arch/powerpc/perf/nest-pmu.h

diff --git a/arch/powerpc/perf/nest-pmu.h b/arch/powerpc/perf/nest-pmu.h
new file mode 100644
index 000000000000..73aff2de3350
--- /dev/null
+++ b/arch/powerpc/perf/nest-pmu.h
@@ -0,0 +1,54 @@
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
+#define P8_NEST_MAX_CHIPS		32
+#define P8_NEST_MAX_PMUS		32
+#define P8_NEST_MAX_PMU_NAME_LEN	256
+#define P8_NEST_MAX_EVENTS_SUPPORTED	64
+#define P8_NEST_ENGINE_START		1
+#define P8_NEST_ENGINE_STOP		0
+#define P8_NEST_MODE_PRODUCTION		1
+
+/*
+ * Structure to hold per chip specific memory address
+ * information for nest pmus. Nest Counter data are exported
+ * in per-chip reserved memory region by the PORE Engine.
+ */
+struct perchip_nest_info {
+	u32 chip_id;
+	u64 pbase;
+	u64 vbase;
+	u32 size;
+};
+
+/*
+ * Place holder for nest pmu events and values.
+ */
+struct nest_ima_events {
+	char *ev_name;
+	char *ev_value;
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
