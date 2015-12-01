Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 670B81A07F0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 13:57:46 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 30 Nov 2015 21:57:44 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 36D5F38C8041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 21:57:42 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB12vfKp21299408
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 02:57:41 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB12vfES007253
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 21:57:41 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v19 17/19] perf, tools: Make alias matching case-insensitive
Date: Mon, 30 Nov 2015 18:57:12 -0800
Message-Id: <1448938635-29176-18-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1448938635-29176-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1448938635-29176-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
index 1db6adf..0e9b188 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1242,7 +1242,7 @@ comp_pmu(const void *p1, const void *p2)
 	struct perf_pmu_event_symbol *pmu1 = (struct perf_pmu_event_symbol *) p1;
 	struct perf_pmu_event_symbol *pmu2 = (struct perf_pmu_event_symbol *) p2;
 
-	return strcmp(pmu1->symbol, pmu2->symbol);
+	return strcasecmp(pmu1->symbol, pmu2->symbol);
 }
 
 static void perf_pmu__parse_cleanup(void)
-- 
1.8.3.1
