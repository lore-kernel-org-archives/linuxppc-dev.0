Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3495B1A0D59
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 09:56:03 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 11 Jan 2016 15:56:01 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id EC7BD19D8045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 15:43:58 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0BMtvIs14090408
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 15:55:57 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0BMtum5026918
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 15:55:57 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] powerpc/perf: Remove PME_ prefix for power7 events
Date: Mon, 11 Jan 2016 14:55:25 -0800
Message-Id: <1452552926-17494-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We used the PME_ prefix earlier to avoid some macro/variable name
collisions.  We have since changed the way we define/use the event
macros so we no longer need the prefix.

By dropping the prefix, we keep the the event macros consistent with
their official names.

Reported-by: Michael Ellerman <ellerman@au1.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h |  2 +-
 arch/powerpc/perf/power7-pmu.c               | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 8146221..0691087 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -141,7 +141,7 @@ extern ssize_t power_events_sysfs_show(struct device *dev,
 #define	EVENT_PTR(_id, _suffix)		&EVENT_VAR(_id, _suffix).attr.attr
 
 #define	EVENT_ATTR(_name, _id, _suffix)					\
-	PMU_EVENT_ATTR(_name, EVENT_VAR(_id, _suffix), PME_##_id,	\
+	PMU_EVENT_ATTR(_name, EVENT_VAR(_id, _suffix), _id,		\
 			power_events_sysfs_show)
 
 #define	GENERIC_EVENT_ATTR(_name, _id)	EVENT_ATTR(_name, _id, _g)
diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index 5b62f238..a383c23 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -54,7 +54,7 @@
  * Power7 event codes.
  */
 #define EVENT(_name, _code) \
-	PME_##_name = _code,
+	_name = _code,
 
 enum {
 #include "power7-events-list.h"
@@ -318,14 +318,14 @@ static void power7_disable_pmc(unsigned int pmc, unsigned long mmcr[])
 }
 
 static int power7_generic_events[] = {
-	[PERF_COUNT_HW_CPU_CYCLES] =			PME_PM_CYC,
-	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =	PME_PM_GCT_NOSLOT_CYC,
-	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =	PME_PM_CMPLU_STALL,
-	[PERF_COUNT_HW_INSTRUCTIONS] =			PME_PM_INST_CMPL,
-	[PERF_COUNT_HW_CACHE_REFERENCES] =		PME_PM_LD_REF_L1,
-	[PERF_COUNT_HW_CACHE_MISSES] =			PME_PM_LD_MISS_L1,
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PME_PM_BRU_FIN,
-	[PERF_COUNT_HW_BRANCH_MISSES] =			PME_PM_BR_MPRED,
+	[PERF_COUNT_HW_CPU_CYCLES] =			PM_CYC,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =	PM_GCT_NOSLOT_CYC,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =	PM_CMPLU_STALL,
+	[PERF_COUNT_HW_INSTRUCTIONS] =			PM_INST_CMPL,
+	[PERF_COUNT_HW_CACHE_REFERENCES] =		PM_LD_REF_L1,
+	[PERF_COUNT_HW_CACHE_MISSES] =			PM_LD_MISS_L1,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PM_BRU_FIN,
+	[PERF_COUNT_HW_BRANCH_MISSES] =			PM_BR_MPRED,
 };
 
 #define C(x)	PERF_COUNT_HW_CACHE_##x
-- 
2.5.3
