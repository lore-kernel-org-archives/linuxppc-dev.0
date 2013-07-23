Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/perf: Export PERF_EVENT_CONFIG_EBB_SHIFT to userspace
Date: Tue, 23 Jul 2013 18:07:45 +1000
Message-Id: <1374566865-26207-1-git-send-email-michael@ellerman.id.au>
Cc: azanella@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use bit 63 of the event code for userspace to request that the event
be counted using EBB (Event Based Branches). Export this value, making
it part of the API - though only on processors that support EBB.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/perf_event_server.h |  6 +-----
 arch/powerpc/include/uapi/asm/Kbuild         |  1 +
 arch/powerpc/include/uapi/asm/perf_event.h   | 18 ++++++++++++++++++
 arch/powerpc/perf/core-book3s.c              |  2 +-
 arch/powerpc/perf/power8-pmu.c               |  6 +++---
 5 files changed, 24 insertions(+), 9 deletions(-)
 create mode 100644 arch/powerpc/include/uapi/asm/perf_event.h

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 2dd7bfc..8b24926 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <asm/hw_irq.h>
 #include <linux/device.h>
+#include <uapi/asm/perf_event.h>
 
 #define MAX_HWEVENTS		8
 #define MAX_EVENT_ALTERNATIVES	8
@@ -69,11 +70,6 @@ struct power_pmu {
 #define PPMU_LIMITED_PMC_REQD	2	/* have to put this on a limited PMC */
 #define PPMU_ONLY_COUNT_RUN	4	/* only counting in run state */
 
-/*
- * We use the event config bit 63 as a flag to request EBB.
- */
-#define EVENT_CONFIG_EBB_SHIFT	63
-
 extern int register_power_pmu(struct power_pmu *);
 
 struct pt_regs;
diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index 5182c86..48be855 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -20,6 +20,7 @@ header-y += mman.h
 header-y += msgbuf.h
 header-y += nvram.h
 header-y += param.h
+header-y += perf_event.h
 header-y += poll.h
 header-y += posix_types.h
 header-y += ps3fb.h
diff --git a/arch/powerpc/include/uapi/asm/perf_event.h b/arch/powerpc/include/uapi/asm/perf_event.h
new file mode 100644
index 0000000..80a4d40
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/perf_event.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright 2013 Michael Ellerman, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the
+ * License.
+ */
+
+#ifndef _UAPI_ASM_POWERPC_PERF_EVENT_H
+#define _UAPI_ASM_POWERPC_PERF_EVENT_H
+
+/*
+ * We use bit 63 of perf_event_attr.config as a flag to request EBB.
+ */
+#define PERF_EVENT_CONFIG_EBB_SHIFT	63
+
+#endif /* _UAPI_ASM_POWERPC_PERF_EVENT_H */
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index a3985ae..2981f73 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -484,7 +484,7 @@ static bool is_ebb_event(struct perf_event *event)
 	 * use bit 63 of the event code for something else if they wish.
 	 */
 	return (ppmu->flags & PPMU_EBB) &&
-	       ((event->attr.config >> EVENT_CONFIG_EBB_SHIFT) & 1);
+	       ((event->attr.config >> PERF_EVENT_CONFIG_EBB_SHIFT) & 1);
 }
 
 static int ebb_event_check(struct perf_event *event)
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 96a64d6..5b49e78 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -118,7 +118,7 @@
 	 (EVENT_UNIT_MASK      << EVENT_UNIT_SHIFT)		|	\
 	 (EVENT_COMBINE_MASK   << EVENT_COMBINE_SHIFT)		|	\
 	 (EVENT_MARKED_MASK    << EVENT_MARKED_SHIFT)		|	\
-	 (EVENT_EBB_MASK       << EVENT_CONFIG_EBB_SHIFT)	|	\
+	 (EVENT_EBB_MASK       << PERF_EVENT_CONFIG_EBB_SHIFT)	|	\
 	  EVENT_PSEL_MASK)
 
 /* MMCRA IFM bits - POWER8 */
@@ -233,10 +233,10 @@ static int power8_get_constraint(u64 event, unsigned long *maskp, unsigned long
 	pmc   = (event >> EVENT_PMC_SHIFT)        & EVENT_PMC_MASK;
 	unit  = (event >> EVENT_UNIT_SHIFT)       & EVENT_UNIT_MASK;
 	cache = (event >> EVENT_CACHE_SEL_SHIFT)  & EVENT_CACHE_SEL_MASK;
-	ebb   = (event >> EVENT_CONFIG_EBB_SHIFT) & EVENT_EBB_MASK;
+	ebb   = (event >> PERF_EVENT_CONFIG_EBB_SHIFT) & EVENT_EBB_MASK;
 
 	/* Clear the EBB bit in the event, so event checks work below */
-	event &= ~(EVENT_EBB_MASK << EVENT_CONFIG_EBB_SHIFT);
+	event &= ~(EVENT_EBB_MASK << PERF_EVENT_CONFIG_EBB_SHIFT);
 
 	if (pmc) {
 		if (pmc > 6)
-- 
1.8.1.2
