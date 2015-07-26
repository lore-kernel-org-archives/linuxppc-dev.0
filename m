Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 940A51A0C1A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 01:31:15 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 27 Jul 2015 21:01:12 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B9F55125809E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 00:27:37 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6QIsZZK50594026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 00:24:35 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6QHVGDL011631
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 23:01:16 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v6 3/7]powerpc/powernv: Nest PMU detection and device tree
 parser
Date: Mon, 27 Jul 2015 00:24:20 +0530
Message-Id: <1437936864-4402-4-git-send-email-maddy@linux.vnet.ibm.com>
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

Create a file "nest-pmu.c" to contain nest pmu related functions. Code
to detect nest pmu support and parser to collect per-chip reserved memory
region information from device tree (DT).

Detection mechanism is to look for specific property "ibm,ima-chip" in DT.
For Nest pmu, device tree will have two set of information.
1) Per-chip reserved memory region for nest pmu counter collection area.
2) Supported Nest PMUs and events

Device tree layout for the Nest PMU as follows.

  /                     -- DT root folder
  |
  -nest-ima             -- Nest PMU folder
   |

   -ima-chip@<chip-id>  -- Per-chip folder for reserved region information
    |
    -ibm,chip-id        -- Chip id
    -ibm,ima-chip
    -reg                -- HOMER PORE Nest Counter collection Address (RA)
    -size               -- size to map in kernel space

   -Alink_BW            -- Nest PMU folder
    |
    -Alink0             -- Nest PMU Alink Event file
    -scale.Alink0.scale -- Event scale file
    -unit.Alink0.unit   -- Event unit file
    -device_type        -- "nest-ima-unit" marker
  ....

Subsequent patch will parse the next part of the DT to find various
Nest PMUs and their events.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/Makefile   |  2 +-
 arch/powerpc/perf/nest-pmu.c | 72 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/perf/nest-pmu.c

diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index f9c083a5652a..6da656b50e3c 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_PERF_EVENTS)	+= callchain.o
 obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o bhrb.o
 obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
 				   power5+-pmu.o power6-pmu.o power7-pmu.o \
-				   power8-pmu.o
+				   power8-pmu.o nest-pmu.o
 obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
 
 obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
new file mode 100644
index 000000000000..48738f9f6426
--- /dev/null
+++ b/arch/powerpc/perf/nest-pmu.c
@@ -0,0 +1,72 @@
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
+#include "nest-pmu.h"
+
+static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
+
+static int nest_ima_dt_parser(void)
+{
+	struct device_node *dev;
+	struct perchip_nest_info *p8ni;
+	u32 idx;
+
+	/*
+	 * "nest-ima" folder contains two things,
+	 * a) per-chip reserved memory region for Nest PMU Counter data
+	 * b) Support Nest PMU units and their event files
+	 */
+	for_each_node_with_property(dev, "ibm,ima-chip") {
+		if (of_property_read_u32(dev, "ibm,chip-id", &idx)) {
+			pr_err("Nest_PMU: device %s missing property\n",
+							dev->full_name);
+			return -ENODEV;
+		}
+		p8ni = &p8_nest_perchip_info[idx];
+
+		if (of_property_read_u64(dev, "reg", &p8ni->pbase)) {
+			pr_err("Nest_PMU: device %s missing property\n",
+							dev->full_name);
+			return -ENODEV;
+		}
+		p8ni->vbase = (u64)phys_to_virt(p8ni->pbase);
+	}
+
+	return 0;
+}
+
+static int __init nest_pmu_init(void)
+{
+	int ret = -ENODEV;
+
+	/*
+	 * Lets do this only if we are hypervisor
+	 */
+	if (!cpu_has_feature(CPU_FTR_HVMODE))
+		return ret;
+
+	/*
+	 * Nest PMU information is grouped under "nest-ima" node
+	 * of the top-level device-tree directory. Detect Nest PMU
+	 * by the "ibm,ima-chip" property.
+	 */
+	if (!of_find_node_with_property(NULL, "ibm,ima-chip"))
+		return ret;
+
+	/*
+	 * Parse device-tree for Nest PMU information
+	 */
+	ret = nest_ima_dt_parser();
+	if (ret)
+		return ret;
+
+	return 0;
+}
+device_initcall(nest_pmu_init);
-- 
1.9.1
