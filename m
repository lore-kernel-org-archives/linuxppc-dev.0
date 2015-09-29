Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED8D51A06EE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 10:53:15 +1000 (AEST)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 28 Sep 2015 18:53:14 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id BFAED3E40041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 18:53:10 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8T0qFki3670412
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 17:52:15 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8T0r9o9027650
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 18:53:10 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v17 09/19] perf,
 tools: Add override support for event list CPUID
Date: Mon, 28 Sep 2015 17:50:47 -0700
Message-Id: <1443487857-26281-10-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1443487857-26281-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1443487857-26281-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andi Kleen <ak@linux.intel.com>

Add a PERF_CPUID variable to override the CPUID of the current CPU (within
the current architecture). This is useful for testing, so that all event
lists can be tested on a single system.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---

v2: Fix double free in earlier version.
    Print actual CPUID being used with verbose option.
---
 tools/perf/util/pmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e4cb21e..ca01aea 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -477,10 +477,16 @@ static int pmu_add_cpu_aliases(struct list_head *head)
 	struct pmu_event *pe;
 	char *cpuid;
 
-	cpuid = get_cpuid_str();
+	cpuid = getenv("PERF_CPUID");
+	if (cpuid)
+		cpuid = strdup(cpuid);
+	if (!cpuid)
+		cpuid = get_cpuid_str();
 	if (!cpuid)
 		return 0;
 
+	pr_debug("Using CPUID %s\n", cpuid);
+
 	i = 0;
 	while (1) {
 		map = &pmu_events_map[i++];
-- 
2.5.3
