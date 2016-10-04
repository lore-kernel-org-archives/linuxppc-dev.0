Return-Path: <BATV+c3601ec1c81c7bfd3073+4790+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp33x1BnyzDrLK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 13:37:49 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux Weekly News <lwn@lwn.net>,
 Andi Kleen <ak@linux.intel.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/22] perf tools: Make alias matching case-insensitive
Date: Mon,  3 Oct 2016 23:37:19 -0300
Message-Id: <1475548641-12182-21-git-send-email-acme@kernel.org>
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

Make alias matching the events parser case-insensitive. This is useful
with the JSON events. perf uses lower case events, but the CPU manuals
generally use upper case event names. The JSON files use lower case by
default too. But if we search case insensitively then users can
cut-n-paste the upper case event names.

So the following works:

% perf stat -e BR_INST_EXEC.TAKEN_INDIRECT_NEAR_CALL true

 Performance counter stats for 'true':

               305      BR_INST_EXEC.TAKEN_INDIRECT_NEAR_CALL

       0.000492799 seconds time elapsed

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1473978296-20712-17-git-send-email-sukadev@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d445b1144c87..4e778eae1510 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1459,7 +1459,7 @@ comp_pmu(const void *p1, const void *p2)
 	struct perf_pmu_event_symbol *pmu1 = (struct perf_pmu_event_symbol *) p1;
 	struct perf_pmu_event_symbol *pmu2 = (struct perf_pmu_event_symbol *) p2;
 
-	return strcmp(pmu1->symbol, pmu2->symbol);
+	return strcasecmp(pmu1->symbol, pmu2->symbol);
 }
 
 static void perf_pmu__parse_cleanup(void)
-- 
2.7.4
