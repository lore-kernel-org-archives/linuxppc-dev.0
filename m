Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A9201A09EE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 07:17:22 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 26 Oct 2015 14:17:20 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6F16619D804E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 14:05:28 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9QKFvDT5898576
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 13:15:57 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9QKHGOQ016975
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 14:17:18 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v18 17/19] perf, tools: Make alias matching case-insensitive
Date: Mon, 26 Oct 2015 13:14:31 -0700
Message-Id: <1445890473-22877-18-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1445890473-22877-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1445890473-22877-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
generally use upper case event names. The JSON files use lower
case by default too. But if we search case insensitively then
users can cut-n-paste the upper case event names.

So the following works:

% perf stat -e BR_INST_EXEC.TAKEN_INDIRECT_NEAR_CALL true

 Performance counter stats for 'true':

               305      BR_INST_EXEC.TAKEN_INDIRECT_NEAR_CALL

       0.000492799 seconds time elapsed

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f05d4c4..16329d0 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1098,7 +1098,7 @@ comp_pmu(const void *p1, const void *p2)
 	struct perf_pmu_event_symbol *pmu1 = (struct perf_pmu_event_symbol *) p1;
 	struct perf_pmu_event_symbol *pmu2 = (struct perf_pmu_event_symbol *) p2;
 
-	return strcmp(pmu1->symbol, pmu2->symbol);
+	return strcasecmp(pmu1->symbol, pmu2->symbol);
 }
 
 static void perf_pmu__parse_cleanup(void)
-- 
2.5.3
