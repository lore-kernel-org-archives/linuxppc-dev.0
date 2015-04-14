Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A84A81A0C77
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 16:41:31 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 00:41:29 -0600
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 852B638C8039
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:41:27 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E6fRln37880060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 06:41:27 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E6fPPt022279
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:41:26 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v9 09/11] perf, tools,
 test: Add test case for alias and JSON parsing
Date: Mon, 13 Apr 2015 23:41:02 -0700
Message-Id: <1428993665-2133-10-git-send-email-sukadev@linux.vnet.ibm.com>
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

Add a simple test case to perf test that parses all the available
events, including json events.

This needs adding an all event iterator to pmu.c

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v9] by Sukadev Bhattiprolu
	Rebase to 4.0 and fix conflicts in:
		tools/perf/tests/builtin-test.c
		tools/perf/tests/tests.h
Changelog:
v2: Rename identifiers
v3: Only iterate cpu pmu to avoid bogus errors.
Move pmu iterator to extra patch
v4: Include aliases.c again
v5: Include util/debug.h
---
 tools/perf/Makefile.perf        |    1 +
 tools/perf/tests/aliases.c      |   59 +++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/builtin-test.c |    4 +++
 tools/perf/tests/tests.h        |    1 +
 4 files changed, 65 insertions(+)
 create mode 100644 tools/perf/tests/aliases.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d9c1a4c..d9c03c4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -456,6 +456,7 @@ endif
 LIB_OBJS += $(OUTPUT)tests/code-reading.o
 LIB_OBJS += $(OUTPUT)tests/sample-parsing.o
 LIB_OBJS += $(OUTPUT)tests/parse-no-sample-id-all.o
+LIB_OBJS += $(OUTPUT)tests/aliases.o
 ifndef NO_DWARF_UNWIND
 ifeq ($(ARCH),$(filter $(ARCH),x86 arm))
 LIB_OBJS += $(OUTPUT)tests/dwarf-unwind.o
diff --git a/tools/perf/tests/aliases.c b/tools/perf/tests/aliases.c
new file mode 100644
index 0000000..4209e51
--- /dev/null
+++ b/tools/perf/tests/aliases.c
@@ -0,0 +1,59 @@
+/* Check if we can set up all aliases and can read JSON files */
+#include <stdlib.h>
+#include "tests.h"
+#include "pmu.h"
+#include "evlist.h"
+#include "parse-events.h"
+#include "util/debug.h"
+
+static struct perf_evlist *evlist;
+
+static int num_events;
+static int failed;
+
+static int test__event(const char *pmu, const char *name)
+{
+	int ret;
+
+	/* Not supported for now */
+	if (strcmp(pmu, "cpu"))
+		return 0;
+
+	ret = parse_events(evlist, name);
+
+	if (ret) {
+		/*
+		 * We only print on failure because common perf setups
+		 * have events that cannot be parsed.
+		 */
+		fprintf(stderr, "invalid or unsupported event: '%s'\n", name);
+		ret = 0;
+		failed++;
+	} else
+		num_events++;
+	return ret;
+}
+
+int test__aliases(void)
+{
+	int err;
+
+	/* Download JSON files */
+	/* XXX assumes perf is installed */
+	/* For now user must manually download */
+	if (0 && system("perf download > /dev/null") < 0) {
+		/* Don't error out for this for now */
+		fprintf(stderr, "perf download failed\n");
+	}
+
+	evlist = perf_evlist__new();
+	if (evlist == NULL)
+		return -ENOMEM;
+
+	err = pmu_iterate_events(test__event);
+	fprintf(stderr, " Parsed %d events :", num_events);
+	if (failed > 0)
+		pr_debug(" %d events failed", failed);
+	perf_evlist__delete(evlist);
+	return err;
+}
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 4b7d9ab..2324b1c 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -167,6 +167,10 @@ static struct test {
 		.func = test__fdarray__add,
 	},
 	{
+		.desc = "Test parsing JSON aliases",
+		.func = test__aliases,
+	},
+	{
 		.func = NULL,
 	},
 };
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 00e776a..ddce231 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -51,6 +51,7 @@ int test__hists_cumulate(void);
 int test__switch_tracking(void);
 int test__fdarray__filter(void);
 int test__fdarray__add(void);
+int test__aliases(void);
 
 #if defined(__x86_64__) || defined(__i386__) || defined(__arm__)
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
-- 
1.7.9.5
