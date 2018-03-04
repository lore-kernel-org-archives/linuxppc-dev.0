Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvM2j53vKzF09G
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Mar 2018 22:56:45 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w24BrqX0044149
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 4 Mar 2018 06:56:42 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gg9kf9rpp-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Mar 2018 06:56:41 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 4 Mar 2018 11:56:39 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 1/3] powerpc/perf: Infrastructure to support addition of
 blacklisted events
Date: Sun,  4 Mar 2018 17:26:26 +0530
Message-Id: <1520164588-19167-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce code to support addition of blacklisted events for a
processor version. A 'pointer' and 'int' variable to hold the
number of events are added to 'struct power_pmu', along with a
generic function to loop through the list to validate the given
event. Generic function 'is_event_blacklisted' is called in
power_pmu_event_init() to detect and reject early.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h |  2 ++
 arch/powerpc/perf/core-book3s.c              | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 723bf48e7494..67a8a9585d50 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -53,6 +53,8 @@ struct power_pmu {
 			       [PERF_COUNT_HW_CACHE_OP_MAX]
 			       [PERF_COUNT_HW_CACHE_RESULT_MAX];
 
+	int		n_blacklist_ev;
+	int 		*blacklist_ev;
 	/* BHRB entries in the PMU */
 	int		bhrb_nr;
 };
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index c4525323d691..73f997b84d19 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1819,6 +1819,18 @@ static int hw_perf_cache_event(u64 config, u64 *eventp)
 	return 0;
 }
 
+static bool is_event_blacklisted(u64 ev)
+{
+	int i;
+
+	for (i=0; i < ppmu->n_blacklist_ev; i++) {
+		if (ppmu->blacklist_ev[i] == ev)
+			return true;
+	}
+
+	return false;
+}
+
 static int power_pmu_event_init(struct perf_event *event)
 {
 	u64 ev;
@@ -1844,15 +1856,24 @@ static int power_pmu_event_init(struct perf_event *event)
 		ev = event->attr.config;
 		if (ev >= ppmu->n_generic || ppmu->generic_events[ev] == 0)
 			return -EOPNOTSUPP;
+
+		if (ppmu->blacklist_ev && is_event_blacklisted(ev))
+			return -EINVAL;
 		ev = ppmu->generic_events[ev];
 		break;
 	case PERF_TYPE_HW_CACHE:
 		err = hw_perf_cache_event(event->attr.config, &ev);
 		if (err)
 			return err;
+
+		if (ppmu->blacklist_ev && is_event_blacklisted(ev))
+			return -EINVAL;
 		break;
 	case PERF_TYPE_RAW:
 		ev = event->attr.config;
+
+		if (ppmu->blacklist_ev && is_event_blacklisted(ev))
+			return -EINVAL;
 		break;
 	default:
 		return -ENOENT;
-- 
2.7.4
