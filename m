Return-Path: <B44306@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4EF032C02F3
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 06:22:20 +1000 (EST)
Received: from mail158-db8 (localhost [127.0.0.1])	by
 mail158-db8-R.bigfish.com (Postfix) with ESMTP id 0515124005C	for
 <linuxppc-dev@ozlabs.org>; Wed,  5 Jun 2013 20:22:17 +0000 (UTC)
Received: from DB8EHSMHS006.bigfish.com (unknown [10.174.8.253])	by
 mail158-db8.bigfish.com (Postfix) with ESMTP id 3B3B04004D	for
 <linuxppc-dev@ozlabs.org>; Wed,  5 Jun 2013 20:22:15 +0000 (UTC)
From: Lijun Pan <Lijun.Pan@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/4] powerpc/perf: Add e6500 PMU driver
Date: Wed, 5 Jun 2013 15:22:10 -0500
Message-ID: <1370463730-23733-4-git-send-email-Lijun.Pan@freescale.com>
In-Reply-To: <1370463730-23733-1-git-send-email-Lijun.Pan@freescale.com>
References: <1370463730-23733-1-git-send-email-Lijun.Pan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Lijun.Pan@freescale.com, 'Priyanka Jain <Priyanka.Jain@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: 'Priyanka Jain <Priyanka.Jain@freescale.com>

e6500 core performance monitors has the following features:
- 6 performance monitor counters
- 512 events supported
- no threshold events

e6500 PMU has more specific events (Data L1 cache misses, Instruction L1
cache misses, etc ) than e500 PMU (which only had Data L1 cache reloads,
etc). Where available, the more specific events have been used which will
produce slightly different results than e500 PMU equivalents.

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
---
 arch/powerpc/include/asm/reg_fsl_emb.h |    4 +-
 arch/powerpc/perf/Makefile             |    2 +-
 arch/powerpc/perf/e6500-pmu.c          |  121 ++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/perf/e6500-pmu.c

diff --git a/arch/powerpc/include/asm/reg_fsl_emb.h b/arch/powerpc/include/asm/reg_fsl_emb.h
index c51d52e..0e3ddf5 100644
--- a/arch/powerpc/include/asm/reg_fsl_emb.h
+++ b/arch/powerpc/include/asm/reg_fsl_emb.h
@@ -34,8 +34,10 @@
 #define PMLCA_FCM1	0x10000000	/* Freeze when PMM==1 */
 #define PMLCA_FCM0	0x08000000	/* Freeze when PMM==0 */
 #define PMLCA_CE	0x04000000	/* Condition Enable */
+#define PMLCA_FGCS1	0x00000002	/* Freeze in guest state */
+#define PMLCA_FGCS0	0x00000001	/* Freeze in hypervisor state */
 
-#define PMLCA_EVENT_MASK 0x00ff0000	/* Event field */
+#define PMLCA_EVENT_MASK 0x01ff0000	/* Event field */
 #define PMLCA_EVENT_SHIFT	16
 
 #define PMRN_PMLCB0	0x110	/* PM Local Control B0 */
diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index af3fac2..06dd8d5 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -8,7 +8,7 @@ obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
 obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
 
 obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
-obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o
+obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o e6500-pmu.o
 
 obj-$(CONFIG_PPC64)		+= $(obj64-y)
 obj-$(CONFIG_PPC32)		+= $(obj32-y)
diff --git a/arch/powerpc/perf/e6500-pmu.c b/arch/powerpc/perf/e6500-pmu.c
new file mode 100644
index 0000000..3d877aa
--- /dev/null
+++ b/arch/powerpc/perf/e6500-pmu.c
@@ -0,0 +1,121 @@
+/*
+ * Performance counter support for e6500 family processors.
+ *
+ * Author: Priyanka Jain, Priyanka.Jain@freescale.com
+ * Based on e500-pmu.c
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/string.h>
+#include <linux/perf_event.h>
+#include <asm/reg.h>
+#include <asm/cputable.h>
+
+/*
+ * Map of generic hardware event types to hardware events
+ * Zero if unsupported
+ */
+static int e6500_generic_events[] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = 1,
+	[PERF_COUNT_HW_INSTRUCTIONS] = 2,
+	[PERF_COUNT_HW_CACHE_MISSES] = 221,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 12,
+	[PERF_COUNT_HW_BRANCH_MISSES] = 15,
+};
+
+#define C(x)	PERF_COUNT_HW_CACHE_##x
+
+/*
+ * Table of generalized cache-related events.
+ * 0 means not supported, -1 means nonsensical, other values
+ * are event codes.
+ */
+static int e6500_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
+	[C(L1D)] = {
+				/*RESULT_ACCESS		RESULT_MISS */
+		[C(OP_READ)] = {	27,		222	},
+		[C(OP_WRITE)] = {	28,		223	},
+		[C(OP_PREFETCH)] = {	29,		0	},
+	},
+	[C(L1I)] = {
+				/*RESULT_ACCESS		RESULT_MISS */
+		[C(OP_READ)] = {	2,		254	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	37,		0	},
+	},
+	/*
+	 * Assuming LL means L2, it's not a good match for this model.
+	 * It does not have separate read/write events (but it does have
+	 * separate instruction/data events).
+	 */
+	[C(LL)] = {
+				/*RESULT_ACCESS		RESULT_MISS */
+		[C(OP_READ)] = {	0,		0	},
+		[C(OP_WRITE)] = {	0,		0	},
+		[C(OP_PREFETCH)] = {	0,		0	},
+	},
+	/*
+	 * There are data/instruction MMU misses, but that's a miss on
+	 * the chip's internal level-one TLB which is probably not
+	 * what the user wants.  Instead, unified level-two TLB misses
+	 * are reported here.
+	 */
+	[C(DTLB)] = {
+				/*RESULT_ACCESS		RESULT_MISS */
+		[C(OP_READ)] = {	26,		66	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+	[C(BPU)] = {
+				/*RESULT_ACCESS		RESULT_MISS */
+		[C(OP_READ)] = {	12,		15	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+	[C(NODE)] = {
+				/* RESULT_ACCESS	RESULT_MISS */
+		[C(OP_READ)] = {	-1,		-1	},
+		[C(OP_WRITE)] = {	-1,		-1	},
+		[C(OP_PREFETCH)] = {	-1,		-1	},
+	},
+};
+
+static int num_events = 512;
+
+/* Upper half of event id is PMLCb, for threshold events */
+static u64 e6500_xlate_event(u64 event_id)
+{
+	u32 event_low = (u32)event_id;
+	if (event_low >= num_events ||
+		(event_id & (FSL_EMB_EVENT_THRESHMUL | FSL_EMB_EVENT_THRESH)))
+		return 0;
+
+	return FSL_EMB_EVENT_VALID;
+}
+
+static struct fsl_emb_pmu e6500_pmu = {
+	.name			= "e6500 family",
+	.n_counter		= 6,
+	.n_restricted		= 0,
+	.xlate_event		= e6500_xlate_event,
+	.n_generic		= ARRAY_SIZE(e6500_generic_events),
+	.generic_events		= e6500_generic_events,
+	.cache_events		= &e6500_cache_events,
+};
+
+static int init_e6500_pmu(void)
+{
+	if (!cur_cpu_spec->oprofile_cpu_type ||
+		strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/e6500"))
+		return -ENODEV;
+
+	return register_fsl_emb_pmu(&e6500_pmu);
+}
+
+early_initcall(init_e6500_pmu);
-- 
1.7.9.7
