Return-Path: <BATV+ef2f77d1cbf736fff7a8+4790+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp33r6rT2zDrLm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 13:37:44 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux Weekly News <lwn@lwn.net>,
 Andi Kleen <ak@linux.intel.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/22] perf tools: Query terminal width and use in perf list
Date: Mon,  3 Oct 2016 23:37:11 -0300
Message-Id: <1475548641-12182-13-git-send-email-acme@kernel.org>
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

Automatically adapt the now wider and word wrapped perf list output to
wider terminals. This requires querying the terminal before the auto
pager takes over, and exporting this information from the pager
subsystem.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1473978296-20712-8-git-send-email-sukadev@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/pager.c | 16 ++++++++++++++++
 tools/lib/subcmd/pager.h |  1 +
 tools/perf/util/pmu.c    |  3 ++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/pager.c b/tools/lib/subcmd/pager.c
index d50f3b58606b..6518bea926d6 100644
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
@@ -98,3 +103,14 @@ int pager_in_use(void)
 {
 	return spawned_pager;
 }
+
+int pager_get_columns(void)
+{
+	char *s;
+
+	s = getenv("COLUMNS");
+	if (s)
+		return atoi(s);
+
+	return (pager_columns ? pager_columns : 80) - 2;
+}
diff --git a/tools/lib/subcmd/pager.h b/tools/lib/subcmd/pager.h
index 8b83714ecf73..623f5542d05d 100644
--- a/tools/lib/subcmd/pager.h
+++ b/tools/lib/subcmd/pager.h
@@ -5,5 +5,6 @@ extern void pager_init(const char *pager_env);
 
 extern void setup_pager(void);
 extern int pager_in_use(void);
+extern int pager_get_columns(void);
 
 #endif /* __SUBCMD_PAGER_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9857fb14ea86..7b46e772f5f9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -14,6 +14,7 @@
 #include "cpumap.h"
 #include "header.h"
 #include "pmu-events/pmu-events.h"
+#include "cache.h"
 
 struct perf_pmu_format {
 	char *name;
@@ -1092,7 +1093,7 @@ void print_pmu_events(const char *event_glob, bool name_only)
 	int len, j;
 	struct pair *aliases;
 	int numdesc = 0;
-	int columns = 78;
+	int columns = pager_get_columns();
 
 	pmu = NULL;
 	len = 0;
-- 
2.7.4
