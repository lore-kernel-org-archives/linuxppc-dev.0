Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F74A1A0CEB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 16:41:30 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 00:41:28 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CF1D938C804A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:41:25 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E6fPZd16121914
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 06:41:25 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E6fNt3022157
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:41:24 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v9 07/11] perf,
 tools: Query terminal width and use in perf list
Date: Mon, 13 Apr 2015 23:41:00 -0700
Message-Id: <1428993665-2133-8-git-send-email-sukadev@linux.vnet.ibm.com>
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

From: Andi Kleen <ak@linux.intel.com>

Automatically adapt the now wider and word wrapped perf list
output to wider terminals. This requires querying the terminal
before the auto pager takes over, and exporting this
information from the pager subsystem.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

---
Changelog[v9] by Sukadev Bhattiprolu
	Rebase to 4.0.
---
 tools/perf/util/cache.h |    1 +
 tools/perf/util/pager.c |   15 +++++++++++++++
 tools/perf/util/pmu.c   |   12 ++----------
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/cache.h b/tools/perf/util/cache.h
index d04d770..f1990c9 100644
--- a/tools/perf/util/cache.h
+++ b/tools/perf/util/cache.h
@@ -32,6 +32,7 @@ extern void setup_pager(void);
 extern const char *pager_program;
 extern int pager_in_use(void);
 extern int pager_use_color;
+int pager_get_columns(void);
 
 char *alias_lookup(const char *alias);
 int split_cmdline(char *cmdline, const char ***argv);
diff --git a/tools/perf/util/pager.c b/tools/perf/util/pager.c
index 31ee02d..9761202 100644
--- a/tools/perf/util/pager.c
+++ b/tools/perf/util/pager.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include <sys/ioctl.h>
 
 /*
  * This is split up from the rest of git so that we can do
@@ -8,6 +9,7 @@
  */
 
 static int spawned_pager;
+static int pager_columns;
 
 static void pager_preexec(void)
 {
@@ -47,9 +49,12 @@ static void wait_for_pager_signal(int signo)
 void setup_pager(void)
 {
 	const char *pager = getenv("PERF_PAGER");
+	struct winsize sz;
 
 	if (!isatty(1))
 		return;
+	if (ioctl(1, TIOCGWINSZ, &sz) == 0)
+		pager_columns = sz.ws_col;
 	if (!pager) {
 		if (!pager_program)
 			perf_config(perf_default_config, NULL);
@@ -98,3 +103,13 @@ int pager_in_use(void)
 	env = getenv("PERF_PAGER_IN_USE");
 	return env ? perf_config_bool("PERF_PAGER_IN_USE", env) : 0;
 }
+
+int pager_get_columns(void)
+{
+	char *s;
+
+	s = getenv("COLUMNS");
+	if (s)
+		return atoi(s);
+	return (pager_columns ? pager_columns : 80) - 2;
+}
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 274aa18..2150455 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -11,6 +11,7 @@
 #include "pmu.h"
 #include "parse-events.h"
 #include "cpumap.h"
+#include "cache.h"
 #include "jevents.h"
 
 const char *json_file;
@@ -929,15 +930,6 @@ static void wordwrap(char *s, int start, int max, int corr)
 	}
 }
 
-static int get_columns(void)
-{
-	/*
-	 * Should ask the terminal with TIOCGWINSZ here, but we
-	 * need the original fd before the pager.
-	 */
-	return 79;
-}
-
 void print_pmu_events(const char *event_glob, bool name_only)
 {
 	struct perf_pmu *pmu;
@@ -947,7 +939,7 @@ void print_pmu_events(const char *event_glob, bool name_only)
 	int len, j;
 	struct pair *aliases;
 	int numdesc = 0;
-	int columns = get_columns();
+	int columns = pager_get_columns();
 
 	pmu = NULL;
 	len = 0;
-- 
1.7.9.5
