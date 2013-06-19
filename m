Return-Path: <runzhen@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A14DD2C0456
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 19:15:44 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <runzhen@linux.vnet.ibm.com>;
 Thu, 20 Jun 2013 06:12:09 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 132473578050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 19:15:39 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5J90vlX14680126
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 19:00:57 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5J9Fcds013315
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 19:15:38 +1000
From: Runzhen Wang <runzhen@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf tools: fix a typo of a Power7 event name
Date: Wed, 19 Jun 2013 17:15:25 +0800
Message-Id: <1371633326-7696-1-git-send-email-runzhen@linux.vnet.ibm.com>
Cc: acme@redhat.com, icycoder@gmail.com, xiaoguangrong@linux.vnet.ibm.com,
 paulus@samba.org, Runzhen Wang <runzhen@linux.vnet.ibm.com>,
 sukadev@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the Power7 PMU guide:
https://www.power.org/documentation/commonly-used-metrics-for-performance-analysis/
PM_BRU_MPRED is referred to as PM_BR_MPRED.

This patch fix the typo by changing the name of the event in kernel and
documentation accordingly.

Signed-off-by: Runzhen Wang <runzhen@linux.vnet.ibm.com>
---
 .../testing/sysfs-bus-event_source-devices-events  |    2 +-
 arch/powerpc/perf/power7-pmu.c                     |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index 8b25ffb..3c1cc24 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -29,7 +29,7 @@ Description:	Generic performance monitoring events
 
 What: 		/sys/devices/cpu/events/PM_1PLUS_PPC_CMPL
 		/sys/devices/cpu/events/PM_BRU_FIN
-		/sys/devices/cpu/events/PM_BRU_MPRED
+		/sys/devices/cpu/events/PM_BR_MPRED
 		/sys/devices/cpu/events/PM_CMPLU_STALL
 		/sys/devices/cpu/events/PM_CMPLU_STALL_BRU
 		/sys/devices/cpu/events/PM_CMPLU_STALL_DCACHE_MISS
diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index 13c3f0e..d1821b8 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -60,7 +60,7 @@
 #define	PME_PM_LD_REF_L1		0xc880
 #define	PME_PM_LD_MISS_L1		0x400f0
 #define	PME_PM_BRU_FIN			0x10068
-#define	PME_PM_BRU_MPRED		0x400f6
+#define	PME_PM_BR_MPRED			0x400f6
 
 #define PME_PM_CMPLU_STALL_FXU			0x20014
 #define PME_PM_CMPLU_STALL_DIV			0x40014
@@ -349,7 +349,7 @@ static int power7_generic_events[] = {
 	[PERF_COUNT_HW_CACHE_REFERENCES] =		PME_PM_LD_REF_L1,
 	[PERF_COUNT_HW_CACHE_MISSES] =			PME_PM_LD_MISS_L1,
 	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PME_PM_BRU_FIN,
-	[PERF_COUNT_HW_BRANCH_MISSES] =			PME_PM_BRU_MPRED,
+	[PERF_COUNT_HW_BRANCH_MISSES] =			PME_PM_BR_MPRED,
 };
 
 #define C(x)	PERF_COUNT_HW_CACHE_##x
@@ -405,7 +405,7 @@ GENERIC_EVENT_ATTR(instructions,		INST_CMPL);
 GENERIC_EVENT_ATTR(cache-references,		LD_REF_L1);
 GENERIC_EVENT_ATTR(cache-misses,		LD_MISS_L1);
 GENERIC_EVENT_ATTR(branch-instructions,		BRU_FIN);
-GENERIC_EVENT_ATTR(branch-misses,		BRU_MPRED);
+GENERIC_EVENT_ATTR(branch-misses,		BR_MPRED);
 
 POWER_EVENT_ATTR(CYC,				CYC);
 POWER_EVENT_ATTR(GCT_NOSLOT_CYC,		GCT_NOSLOT_CYC);
@@ -414,7 +414,7 @@ POWER_EVENT_ATTR(INST_CMPL,			INST_CMPL);
 POWER_EVENT_ATTR(LD_REF_L1,			LD_REF_L1);
 POWER_EVENT_ATTR(LD_MISS_L1,			LD_MISS_L1);
 POWER_EVENT_ATTR(BRU_FIN,			BRU_FIN)
-POWER_EVENT_ATTR(BRU_MPRED,			BRU_MPRED);
+POWER_EVENT_ATTR(BR_MPRED,			BR_MPRED);
 
 POWER_EVENT_ATTR(CMPLU_STALL_FXU,		CMPLU_STALL_FXU);
 POWER_EVENT_ATTR(CMPLU_STALL_DIV,		CMPLU_STALL_DIV);
@@ -449,7 +449,7 @@ static struct attribute *power7_events_attr[] = {
 	GENERIC_EVENT_PTR(LD_REF_L1),
 	GENERIC_EVENT_PTR(LD_MISS_L1),
 	GENERIC_EVENT_PTR(BRU_FIN),
-	GENERIC_EVENT_PTR(BRU_MPRED),
+	GENERIC_EVENT_PTR(BR_MPRED),
 
 	POWER_EVENT_PTR(CYC),
 	POWER_EVENT_PTR(GCT_NOSLOT_CYC),
@@ -458,7 +458,7 @@ static struct attribute *power7_events_attr[] = {
 	POWER_EVENT_PTR(LD_REF_L1),
 	POWER_EVENT_PTR(LD_MISS_L1),
 	POWER_EVENT_PTR(BRU_FIN),
-	POWER_EVENT_PTR(BRU_MPRED),
+	POWER_EVENT_PTR(BR_MPRED),
 
 	POWER_EVENT_PTR(CMPLU_STALL_FXU),
 	POWER_EVENT_PTR(CMPLU_STALL_DIV),
-- 
1.7.9.5
