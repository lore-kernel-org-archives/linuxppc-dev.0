Return-Path: <cody@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E19892C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Feb 2014 09:02:31 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Fri, 14 Feb 2014 17:02:29 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A886F6E803A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 17:02:22 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1EM2RmJ524594
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 22:02:27 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1EM2P9C026699
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 17:02:27 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH v2 02/11] perf core: export swevent hrtimer helpers
Date: Fri, 14 Feb 2014 14:02:06 -0800
Message-Id: <1392415338-16288-3-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1392415338-16288-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1392415338-16288-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Michael Ellerman <michael@ellerman.id.au>,
 Cody P Schafer <cody@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export the swevent hrtimer helpers currently only used in events/core.c
to allow the addition of architecture specific sw-like pmus.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 include/linux/perf_event.h | 5 ++++-
 kernel/events/core.c       | 8 ++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2702e91..24378a9 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -559,7 +559,10 @@ extern void perf_pmu_migrate_context(struct pmu *pmu,
 				int src_cpu, int dst_cpu);
 extern u64 perf_event_read_value(struct perf_event *event,
 				 u64 *enabled, u64 *running);
-
+extern void perf_swevent_init_hrtimer(struct perf_event *event);
+extern void perf_swevent_start_hrtimer(struct perf_event *event);
+extern void perf_swevent_cancel_hrtimer(struct perf_event *event);
+extern int perf_swevent_event_idx(struct perf_event *event);
 
 struct perf_sample_data {
 	u64				type;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 56003c6..feb0347 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5816,7 +5816,7 @@ static int perf_swevent_init(struct perf_event *event)
 	return 0;
 }
 
-static int perf_swevent_event_idx(struct perf_event *event)
+int perf_swevent_event_idx(struct perf_event *event)
 {
 	return 0;
 }
@@ -6045,7 +6045,7 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 	return ret;
 }
 
-static void perf_swevent_start_hrtimer(struct perf_event *event)
+void perf_swevent_start_hrtimer(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	s64 period;
@@ -6067,7 +6067,7 @@ static void perf_swevent_start_hrtimer(struct perf_event *event)
 				HRTIMER_MODE_REL_PINNED, 0);
 }
 
-static void perf_swevent_cancel_hrtimer(struct perf_event *event)
+void perf_swevent_cancel_hrtimer(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
@@ -6079,7 +6079,7 @@ static void perf_swevent_cancel_hrtimer(struct perf_event *event)
 	}
 }
 
-static void perf_swevent_init_hrtimer(struct perf_event *event)
+void perf_swevent_init_hrtimer(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-- 
1.8.5.4
