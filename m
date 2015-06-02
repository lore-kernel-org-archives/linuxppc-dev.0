Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443F41A0D04
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 03:13:02 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 2 Jun 2015 11:13:00 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 39AF519D8045
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 11:04:00 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52HCgvb32637098
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 10:12:42 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52HCv1C025991
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 11:12:58 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 07/14] perf,
 tools: Query terminal width and use in perf list
Date: Tue,  2 Jun 2015 10:12:07 -0700
Message-Id: <1433265135-20426-8-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

Conflicts:
	tools/perf/util/pager.c
---
 tools/perf/util/cache.h |    1 +
 tools/perf/util/pager.c |   15 +++++++++++++++
 tools/perf/util/pmu.c   |    3 ++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cache.h b/tools/perf/util/cache.h
index c861373..8e0d4b8 100644
--- a/tools/perf/util/cache.h
+++ b/tools/perf/util/cache.h
@@ -32,6 +32,7 @@ extern const char *perf_config_dirname(const char *, const char *);
 extern void setup_pager(void);
 extern int pager_in_use(void);
 extern int pager_use_color;
+int pager_get_columns(void);
 
 char *alias_lookup(const char *alias);
 int split_cmdline(char *cmdline, const char ***argv);
diff --git a/tools/perf/util/pager.c b/tools/perf/util/pager.c
index 53ef006..1770c88 100644
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
 	if (!pager)
 		pager = getenv("PAGER");
 	if (!(pager || access("/usr/bin/pager", X_OK)))
@@ -93,3 +98,13 @@ int pager_in_use(void)
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
index 77b6801..77e0500 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -13,6 +13,7 @@
 #include "pmu-events/pmu-events.h"
 #include "cpumap.h"
 #include "header.h"
+#include "cache.h"
 
 struct perf_pmu_format {
 	char *name;
@@ -1037,7 +1038,7 @@ void print_pmu_events(const char *event_glob, bool name_only)
 	int len, j;
 	struct pair *aliases;
 	int numdesc = 0;
-	int columns = 78;
+	int columns = pager_get_columns();
 
 	pmu = NULL;
 	len = 0;
-- 
1.7.9.5
