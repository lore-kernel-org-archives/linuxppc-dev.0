Return-Path: <cody@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 99E602C0227
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 10:54:11 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Thu, 16 Jan 2014 18:54:08 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 0B2F3C90026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 18:54:03 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0GNs5tZ5636484
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 23:54:05 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0GNs4ik007617
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 18:54:05 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/8] perf core: export swevent hrtimer helpers
Date: Thu, 16 Jan 2014 15:53:48 -0800
Message-Id: <1389916434-2288-3-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1389916434-2288-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1389916434-2288-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Cody P Schafer <cody@linux.vnet.ibm.com>
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
index 8646e33..c5bc71a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -558,7 +558,10 @@ extern void perf_pmu_migrate_context(struct pmu *pmu,
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
index f574401..d881d1e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5801,7 +5801,7 @@ static int perf_swevent_init(struct perf_event *event)
 	return 0;
 }
 
-static int perf_swevent_event_idx(struct perf_event *event)
+int perf_swevent_event_idx(struct perf_event *event)
 {
 	return 0;
 }
@@ -6030,7 +6030,7 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 	return ret;
 }
 
-static void perf_swevent_start_hrtimer(struct perf_event *event)
+void perf_swevent_start_hrtimer(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	s64 period;
@@ -6052,7 +6052,7 @@ static void perf_swevent_start_hrtimer(struct perf_event *event)
 				HRTIMER_MODE_REL_PINNED, 0);
 }
 
-static void perf_swevent_cancel_hrtimer(struct perf_event *event)
+void perf_swevent_cancel_hrtimer(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
@@ -6064,7 +6064,7 @@ static void perf_swevent_cancel_hrtimer(struct perf_event *event)
 	}
 }
 
-static void perf_swevent_init_hrtimer(struct perf_event *event)
+void perf_swevent_init_hrtimer(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-- 
1.8.5.2
