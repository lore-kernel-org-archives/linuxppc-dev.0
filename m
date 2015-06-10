Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 051971A0E46
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 17:26:24 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 01:26:23 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 560E5C90041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 03:17:27 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5A7QKSf53018802
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 07:26:20 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5A7QJTx014673
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 03:26:20 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v15 12/19] perf,
 tools: Add override support for event list CPUID
Date: Wed, 10 Jun 2015 00:25:16 -0700
Message-Id: <1433921123-25327-13-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1433921123-25327-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1433921123-25327-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
index ebbd4c7..2a7abac 100644
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
1.8.3.1
