Return-Path: <runzhen@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 176342C0414
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 18:16:19 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <runzhen@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 13:39:57 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id B8F893940043
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 13:46:13 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5S8GWXq26804326
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 13:46:32 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5S8G52r009222
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 18:16:13 +1000
From: Runzhen Wang <runzhen@linux.vnet.ibm.com>
To: michael@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] perf tools: fix a typo of a Power7 event name
Date: Fri, 28 Jun 2013 16:14:56 +0800
Message-Id: <1372407297-6996-2-git-send-email-runzhen@linux.vnet.ibm.com>
In-Reply-To: <1372407297-6996-1-git-send-email-runzhen@linux.vnet.ibm.com>
References: <1372407297-6996-1-git-send-email-runzhen@linux.vnet.ibm.com>
Cc: icycoder@gmail.com, runzhew@clemson.edu, xiaoguangrong@linux.vnet.ibm.com,
 acme@redhat.com, paulus@samba.org, Runzhen Wang <runzhen@linux.vnet.ibm.com>,
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

It fixed the typo by changing the name of the event in kernel
and documentation accordingly.

This patch changes the ABI, there are some reasons I think it's ok:

- It is relatively new interface, specific to the Power7 platform.

- No tools that we know of actually use this interface at this point
 (none are listed near the interface).

- Users of this interface (eg oprofile users migrating to perf)
  would be more used to the "PM_BR_MPRED" rather than "PM_BRU_MPRED".

- These are in the ABI/testing at this point rather than ABI/stable,
  so hoping we have some wiggle room.

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
