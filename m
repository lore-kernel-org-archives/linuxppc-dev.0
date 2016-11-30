Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTLM72z7lzDvpB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 00:08:19 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAUD4Vmx108729
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 08:08:16 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 271xk93dkk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 08:08:16 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 30 Nov 2016 23:08:13 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9305B2CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 00:08:10 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAUD8A5w34537648
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 00:08:10 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAUD8A1I017239
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 00:08:10 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Add constraints for power9 l2/l3 bus events
Date: Wed, 30 Nov 2016 18:38:06 +0530
Message-Id: <1480511286-25154-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In Power9, L2/L3 bus events are always available as a
"bank" of 4 events. To obtain the counts for any of the
l2/l3 bus events in a given bank, the user will have to
program PMC4 with corresponding l2/l3 bus event for that
bank. Patch adds a constraint check to enforce it.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h |  1 +
 arch/powerpc/perf/core-book3s.c              |  4 ++++
 arch/powerpc/perf/power9-pmu.c               | 20 ++++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index e157489ee7a1..3e6616c3e911 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -38,6 +38,7 @@ struct power_pmu {
 				unsigned long *valp);
 	int		(*get_alternatives)(u64 event_id, unsigned int flags,
 				u64 alt[]);
+	int		(*get_llevent_constraint)(u64 events[], int n_ev);
 	u64             (*bhrb_filter_map)(u64 branch_sample_type);
 	void            (*config_bhrb)(u64 pmu_bhrb_filter);
 	void		(*disable_pmc)(unsigned int pmc, unsigned long mmcr[]);
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 72c27b8d2cf3..2cdf2647cdb0 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1267,6 +1267,10 @@ static void power_pmu_enable(struct pmu *pmu)
 		goto out;
 	}
 
+	if ( (ppmu->get_llevent_constraint) &&
+	     ppmu->get_llevent_constraint(cpuhw->events, cpuhw->n_events))
+		goto out;
+
 	if (!(ppmu->flags & PPMU_ARCH_207S)) {
 		/*
 		 * Add in MMCR0 freeze bits corresponding to the attr.exclude_*
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 8e9a81967ff8..d67d532116b3 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -181,6 +181,25 @@ static void power9_config_bhrb(u64 pmu_bhrb_filter)
 	mtspr(SPRN_MMCRA, (mfspr(SPRN_MMCRA) | pmu_bhrb_filter));
 }
 
+static int power9_llevent_get_constraint(u64 event[], int n_ev)
+{
+	int i;
+	unsigned int pmc, unit, mask = 0;
+
+	for (i = 0; i < n_ev; ++i) {
+		pmc	= (event[i] >> EVENT_PMC_SHIFT) & EVENT_PMC_MASK;
+		unit	= (event[i] >> EVENT_UNIT_SHIFT) & EVENT_UNIT_MASK;
+		if (unit >= 6 && unit <= 9)
+			mask |= 1 << (pmc - 1);
+
+	}
+
+	if ((mask) && ((mask & 0xf) < 0x8))
+		return -1;
+
+	return 0;
+}
+
 #define C(x)	PERF_COUNT_HW_CACHE_##x
 
 /*
@@ -307,6 +326,7 @@ static struct power_pmu power9_pmu = {
 	.cache_events		= &power9_cache_events,
 	.attr_groups		= power9_pmu_attr_groups,
 	.bhrb_nr		= 32,
+	.get_llevent_constraint	= power9_llevent_get_constraint,
 };
 
 static int __init init_power9_pmu(void)
-- 
2.7.4
