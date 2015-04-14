Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F37C1A0CCD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 16:41:28 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 00:41:26 -0600
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 1660238C8051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:41:23 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E6fN8p31588410
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 06:41:23 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E6fLrx021971
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:41:21 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v9 05/11] perf,
 tools: Automatically look for event file name for cpu
Date: Mon, 13 Apr 2015 23:40:58 -0700
Message-Id: <1428993665-2133-6-git-send-email-sukadev@linux.vnet.ibm.com>
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

When no JSON event file is specified automatically look
for a suitable file in ~/.cache/pmu-events.

The event file format is per architecture, but can be
extended for other architectures.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v9] by Sukadev Bhattiprolu
	Rebase to 4.0 and fix.
v2: Supports XDG_CACHE_HOME and defaults to ~/.cache/pmu-events
v3: Minor updates and handle EVENTMAP.
v4: Unify with header.c. Now uses CPUID directly.
---
 tools/perf/arch/x86/util/header.c |   19 +++++++++++++++---
 tools/perf/util/jevents.c         |   40 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/jevents.h         |    1 +
 tools/perf/util/pmu.c             |    2 +-
 4 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index 146d12a..76e0ece 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -5,6 +5,7 @@
 #include <string.h>
 
 #include "../../util/header.h"
+#include "../../util/jevents.h"
 
 static inline void
 cpuid(unsigned int op, unsigned int *a, unsigned int *b, unsigned int *c,
@@ -19,8 +20,8 @@ cpuid(unsigned int op, unsigned int *a, unsigned int *b, unsigned int *c,
 			: "a" (op));
 }
 
-int
-get_cpuid(char *buffer, size_t sz)
+static int
+__get_cpuid(char *buffer, size_t sz, const char *fmt)
 {
 	unsigned int a, b, c, d, lvl;
 	int family = -1, model = -1, step = -1;
@@ -48,7 +49,7 @@ get_cpuid(char *buffer, size_t sz)
 		if (family >= 0x6)
 			model += ((a >> 16) & 0xf) << 4;
 	}
-	nb = scnprintf(buffer, sz, "%s,%u,%u,%u$", vendor, family, model, step);
+	nb = scnprintf(buffer, sz, fmt, vendor, family, model, step);
 
 	/* look for end marker to ensure the entire data fit */
 	if (strchr(buffer, '$')) {
@@ -57,3 +58,15 @@ get_cpuid(char *buffer, size_t sz)
 	}
 	return -1;
 }
+
+int get_cpuid(char *buffer, size_t sz)
+{
+	return __get_cpuid(buffer, sz, "%s,%u,%u,%u$");
+}
+
+char *get_cpu_str(void)
+{
+	char *buf = malloc(128);
+	__get_cpuid(buf, 128, "%s-%d-%X-core");
+	return buf;
+}
diff --git a/tools/perf/util/jevents.c b/tools/perf/util/jevents.c
index 023757c..ef4c047 100644
--- a/tools/perf/util/jevents.c
+++ b/tools/perf/util/jevents.c
@@ -39,6 +39,44 @@
 #include "json.h"
 #include "jevents.h"
 
+__attribute__((weak)) char *get_cpu_str(void)
+{
+	return NULL;
+}
+
+static const char *json_default_name(void)
+{
+	char *cache;
+	char *idstr = get_cpu_str();
+	char *res = NULL;
+	char *home = NULL;
+	char *emap;
+
+	emap = getenv("EVENTMAP");
+	if (emap) {
+		if (access(emap, R_OK) == 0)
+			return emap;
+		if (asprintf(&idstr, "%s-core", emap) < 0)
+			return NULL;
+	}
+
+	cache = getenv("XDG_CACHE_HOME");
+	if (!cache) {
+		home = getenv("HOME");
+		if (!home || asprintf(&cache, "%s/.cache", home) < 0)
+			goto out;
+	}
+	if (cache && idstr)
+		res = mkpath("%s/pmu-events/%s.json",
+			     cache,
+			     idstr);
+	if (home)
+		free(cache);
+out:
+	free(idstr);
+	return res;
+}
+
 static void addfield(char *map, char **dst, const char *sep,
 		     const char *a, jsmntok_t *bt)
 {
@@ -171,6 +209,8 @@ int json_events(const char *fn,
 	int i, j, len;
 	char *map;
 
+	if (!fn)
+		fn = json_default_name();
 	tokens = parse_json(fn, &map, &size, &len);
 	if (!tokens)
 		return -EIO;
diff --git a/tools/perf/util/jevents.h b/tools/perf/util/jevents.h
index fbc4549..86a94dd 100644
--- a/tools/perf/util/jevents.h
+++ b/tools/perf/util/jevents.h
@@ -4,5 +4,6 @@
 int json_events(const char *fn,
 		int (*func)(void *data, char *name, char *event, char *desc),
 		void *data);
+char *get_cpu_str(void);
 
 #endif
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d7e5e1b..274aa18 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -482,7 +482,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	if (pmu_aliases(name, &aliases))
 		return NULL;
 
-	if (!strcmp(name, "cpu") && json_file)
+	if (!strcmp(name, "cpu"))
 		json_events(json_file, add_alias, &aliases);
 
 	if (pmu_type(name, &type))
-- 
1.7.9.5
