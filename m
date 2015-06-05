Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6CBAA1A0919
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:28:13 +1000 (AEST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 5 Jun 2015 00:28:11 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 746F03E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 00:28:07 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t556Pqmk28049660
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 23:25:52 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t556S6Wc007811
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 00:28:07 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 03/19] Use __weak definition from <linux/compiler.h>
Date: Thu,  4 Jun 2015 23:27:11 -0700
Message-Id: <1433485647-9314-4-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri Olsa pointed out, that the <linux/compiler.h> defines the
attribute '__weak'. We might as well use that.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/util/pmu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0fcc624..c6b16b1 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1,4 +1,5 @@
 #include <linux/list.h>
+#include <linux/compiler.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <stdio.h>
@@ -436,7 +437,7 @@ static struct cpu_map *pmu_cpumask(const char *name)
 	return cpus;
 }
 
-struct perf_event_attr *__attribute__((weak))
+struct perf_event_attr * __weak
 perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
 	return NULL;
-- 
1.7.9.5
