Return-Path: <BATV+c3601ec1c81c7bfd3073+4790+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp33s1sZRzDrLs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 13:37:45 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux Weekly News <lwn@lwn.net>,
 Andi Kleen <ak@linux.intel.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/22] perf pmu: Add override support for event list CPUID
Date: Mon,  3 Oct 2016 23:37:13 -0300
Message-Id: <1475548641-12182-15-git-send-email-acme@kernel.org>
In-Reply-To: <1475548641-12182-1-git-send-email-acme@kernel.org>
References: <1475548641-12182-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andi Kleen <ak@linux.intel.com>

Add a PERF_CPUID variable to override the CPUID of the current CPU
(within the current architecture). This is useful for testing, so that
all event lists can be tested on a single system.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1473978296-20712-10-git-send-email-sukadev@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9dc3506d23fc..79242cf9bb79 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -501,10 +501,16 @@ static void pmu_add_cpu_aliases(struct list_head *head)
 	struct pmu_event *pe;
 	char *cpuid;
 
-	cpuid = get_cpuid_str();
+	cpuid = getenv("PERF_CPUID");
+	if (cpuid)
+		cpuid = strdup(cpuid);
+	if (!cpuid)
+		cpuid = get_cpuid_str();
 	if (!cpuid)
 		return;
 
+	pr_debug("Using CPUID %s\n", cpuid);
+
 	i = 0;
 	while (1) {
 		map = &pmu_events_map[i++];
-- 
2.7.4
