Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYYxt3sFrzDqCq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 14:04:02 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L3xmaY051800
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:04:00 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n0mepfus-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:04:00 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:03:58 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v20 17/20] perf, tools: Make alias matching case-insensitive
Date: Mon, 20 Jun 2016 21:02:47 -0700
In-Reply-To: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1466481770-25290-18-git-send-email-sukadev@linux.vnet.ibm.com>
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
index 77bb7ac..c599077 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1436,7 +1436,7 @@ comp_pmu(const void *p1, const void *p2)
 	struct perf_pmu_event_symbol *pmu1 = (struct perf_pmu_event_symbol *) p1;
 	struct perf_pmu_event_symbol *pmu2 = (struct perf_pmu_event_symbol *) p2;
 
-	return strcmp(pmu1->symbol, pmu2->symbol);
+	return strcasecmp(pmu1->symbol, pmu2->symbol);
 }
 
 static void perf_pmu__parse_cleanup(void)
-- 
2.5.3
