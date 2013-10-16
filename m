Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CC9402C0366
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 13:07:16 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 15 Oct 2013 20:07:14 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B7CA71FF001A
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:07:01 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9G27Bjq182132
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:07:11 -0600
Received: from d03av04.boulder.ibm.com (localhost [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9G2793B022751
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:07:10 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH 05/10][v6] powerpc/perf: Remove PME_ prefix for power7 events
Date: Tue, 15 Oct 2013 19:06:37 -0700
Message-Id: <1381889202-16826-6-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1381889202-16826-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1381889202-16826-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/perf_event_server.h |    2 +-
 arch/powerpc/perf/power7-pmu.c               |   18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 3fd2f1b..d7b3419 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -138,7 +138,7 @@ extern ssize_t power_events_sysfs_show(struct device *dev,
 #define	EVENT_PTR(_id, _suffix)		&EVENT_VAR(_id, _suffix).attr.attr
 
 #define	EVENT_ATTR(_name, _id, _suffix)					\
-	PMU_EVENT_ATTR(_name, EVENT_VAR(_id, _suffix), PME_##_id,	\
+	PMU_EVENT_ATTR(_name, EVENT_VAR(_id, _suffix), _id,		\
 			power_events_sysfs_show)
 
 #define	GENERIC_EVENT_ATTR(_name, _id)	EVENT_ATTR(_name, _id, _g)
diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index 56c67bc..ae24dfc 100644
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
1.7.9.5
