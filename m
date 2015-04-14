Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 549791A0CEB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 16:41:29 +1000 (AEST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 02:41:26 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id AC094C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:32:33 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E6fOQa29491322
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 06:41:24 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E6fMsS022064
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:41:23 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v9 06/11] powerpc/perf: Implement get_cpu_str()
Date: Mon, 13 Apr 2015 23:40:59 -0700
Message-Id: <1428993665-2133-7-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With a file ~/.cache/pmu-events/004d0100-core.json describing Power8
PMU events we would need to run:

	perf stat \
		--events-file ~/.cache/pmu-events/004d0100-core.json \
		-e pm_cyc sleep 1

With this get_cpu_str(), on Powerpc, we can skip the --events-file option
and run:

	perf stat -e pm_cyc sleep 1

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v9] by Sukadev Bhattiprolu
	Rebase to 4.0.

Changelog[v3]:
        [Tobias Klauser]: Fix some changelog damage to patch.

Changelog[v2]:
	[Michael Ellerman]: Use PVR instead of AUXV variables
---
 tools/perf/arch/powerpc/util/header.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 6c1b8a7..306bf35 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -6,6 +6,7 @@
 
 #include "../../util/header.h"
 #include "../../util/util.h"
+#include "../../util/jevents.h"
 
 #define mfspr(rn)       ({unsigned long rval; \
 			 asm volatile("mfspr %0," __stringify(rn) \
@@ -32,3 +33,14 @@ get_cpuid(char *buffer, size_t sz)
 	}
 	return -1;
 }
+
+char *
+get_cpu_str(void)
+{
+	char *bufp;
+
+	if (asprintf(&bufp, "%.8lx-core", mfspr(SPRN_PVR)) < 0)
+		bufp = NULL;
+
+	return bufp;
+}
-- 
1.7.9.5
