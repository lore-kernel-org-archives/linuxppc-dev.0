Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYYxY5CLXzDqCX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 14:03:45 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L3xnlT119414
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:03:43 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23n2fyjksa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:03:43 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:03:43 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v20 07/20] perf,
 tools: Query terminal width and use in perf list
Date: Mon, 20 Jun 2016 21:02:37 -0700
In-Reply-To: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1466481770-25290-8-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andi Kleen <ak@linux.intel.com>

Automatically adapt the now wider and word wrapped perf list
output to wider terminals. This requires querying the terminal
before the auto pager takes over, and exporting this
information from the pager subsystem.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---

Changelog[v20]
	- Minor reorg since helpers like setup_pager() are now in
	  tools/lib/subcmd/pager.c
---
 tools/lib/subcmd/pager.c | 15 +++++++++++++++
 tools/lib/subcmd/pager.h |  1 +
 tools/perf/util/pmu.c    |  3 ++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/pager.c b/tools/lib/subcmd/pager.c
index d50f3b5..409b582 100644
--- a/tools/lib/subcmd/pager.c
+++ b/tools/lib/subcmd/pager.c
@@ -3,6 +3,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <signal.h>
+#include <sys/ioctl.h>
 #include "pager.h"
 #include "run-command.h"
 #include "sigchain.h"
@@ -14,6 +15,7 @@
  */
 
 static int spawned_pager;
+static int pager_columns;
 
 void pager_init(const char *pager_env)
 {
@@ -58,9 +60,12 @@ static void wait_for_pager_signal(int signo)
 void setup_pager(void)
 {
 	const char *pager = getenv(subcmd_config.pager_env);
+	struct winsize sz;
 
 	if (!isatty(1))
 		return;
+	if (ioctl(1, TIOCGWINSZ, &sz) == 0)
+		pager_columns = sz.ws_col;
 	if (!pager)
 		pager = getenv("PAGER");
 	if (!(pager || access("/usr/bin/pager", X_OK)))
@@ -98,3 +103,13 @@ int pager_in_use(void)
 {
 	return spawned_pager;
 }
+
+int pager_get_columns(void)
+{
+       char *s;
+
+       s = getenv("COLUMNS");
+       if (s)
+               return atoi(s);
+       return (pager_columns ? pager_columns : 80) - 2;
+}
diff --git a/tools/lib/subcmd/pager.h b/tools/lib/subcmd/pager.h
index 8b83714..623f554 100644
--- a/tools/lib/subcmd/pager.h
+++ b/tools/lib/subcmd/pager.h
@@ -5,5 +5,6 @@ extern void pager_init(const char *pager_env);
 
 extern void setup_pager(void);
 extern int pager_in_use(void);
+extern int pager_get_columns(void);
 
 #endif /* __SUBCMD_PAGER_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 496c02e..10a95e7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -14,6 +14,7 @@
 #include "cpumap.h"
 #include "header.h"
 #include "pmu-events/pmu-events.h"
+#include "cache.h"
 
 struct perf_pmu_format {
 	char *name;
@@ -1084,7 +1085,7 @@ void print_pmu_events(const char *event_glob, bool name_only)
 	int len, j;
 	struct pair *aliases;
 	int numdesc = 0;
-	int columns = 78;
+	int columns = pager_get_columns();
 
 	pmu = NULL;
 	len = 0;
-- 
2.5.3
