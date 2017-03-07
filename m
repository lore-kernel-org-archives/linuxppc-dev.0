Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vctfV08FpzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 21:48:01 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v27AhvTF103651
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 05:47:57 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2917d52cyd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Mar 2017 05:47:57 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 7 Mar 2017 16:17:53 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 744A1E0063
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 16:19:40 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v27AloAU14221416
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 16:17:50 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v27Almcx020269
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 16:17:50 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5/6] perf: probes: move ftrace README parsing logic into
 trace-event-parse.c
Date: Tue,  7 Mar 2017 16:17:40 +0530
In-Reply-To: <cover.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
References: <20170306220638.e7db155d44e14325c5c0174b@kernel.org>
 <cover.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <b5e4defdba760ea9a48681e3c3075b3517037008.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

probe-file.c needs libelf, but scanning ftrace README does not require
that. As such, move the ftrace README scanning logic out of probe-file.c
and into trace-event-parse.c.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/util/probe-file.c        | 87 +++---------------------------------
 tools/perf/util/probe-file.h        |  2 -
 tools/perf/util/trace-event-parse.c | 89 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/trace-event.h       |  4 ++
 4 files changed, 99 insertions(+), 83 deletions(-)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 1542cd0d6799..ff872fa30cdb 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -26,6 +26,7 @@
 #include <api/fs/tracing_path.h>
 #include "probe-event.h"
 #include "probe-file.h"
+#include "trace-event.h"
 #include "session.h"
 
 #define MAX_CMDLEN 256
@@ -70,33 +71,17 @@ static void print_both_open_warning(int kerr, int uerr)
 	}
 }
 
-int open_trace_file(const char *trace_file, bool readwrite)
-{
-	char buf[PATH_MAX];
-	int ret;
-
-	ret = e_snprintf(buf, PATH_MAX, "%s/%s",
-			 tracing_path, trace_file);
-	if (ret >= 0) {
-		pr_debug("Opening %s write=%d\n", buf, readwrite);
-		if (readwrite && !probe_event_dry_run)
-			ret = open(buf, O_RDWR | O_APPEND, 0);
-		else
-			ret = open(buf, O_RDONLY, 0);
-
-		if (ret < 0)
-			ret = -errno;
-	}
-	return ret;
-}
-
 static int open_kprobe_events(bool readwrite)
 {
+	if (probe_event_dry_run)
+		readwrite = false;
 	return open_trace_file("kprobe_events", readwrite);
 }
 
 static int open_uprobe_events(bool readwrite)
 {
+	if (probe_event_dry_run)
+		readwrite = false;
 	return open_trace_file("uprobe_events", readwrite);
 }
 
@@ -877,72 +862,12 @@ int probe_cache__show_all_caches(struct strfilter *filter)
 	return 0;
 }
 
-enum ftrace_readme {
-	FTRACE_README_PROBE_TYPE_X = 0,
-	FTRACE_README_KRETPROBE_OFFSET,
-	FTRACE_README_END,
-};
-
-static struct {
-	const char *pattern;
-	bool avail;
-} ftrace_readme_table[] = {
-#define DEFINE_TYPE(idx, pat)			\
-	[idx] = {.pattern = pat, .avail = false}
-	DEFINE_TYPE(FTRACE_README_PROBE_TYPE_X, "*type: * x8/16/32/64,*"),
-	DEFINE_TYPE(FTRACE_README_KRETPROBE_OFFSET, "*place (kretprobe): *"),
-};
-
-static bool scan_ftrace_readme(enum ftrace_readme type)
-{
-	int fd;
-	FILE *fp;
-	char *buf = NULL;
-	size_t len = 0;
-	bool ret = false;
-	static bool scanned = false;
-
-	if (scanned)
-		goto result;
-
-	fd = open_trace_file("README", false);
-	if (fd < 0)
-		return ret;
-
-	fp = fdopen(fd, "r");
-	if (!fp) {
-		close(fd);
-		return ret;
-	}
-
-	while (getline(&buf, &len, fp) > 0)
-		for (enum ftrace_readme i = 0; i < FTRACE_README_END; i++)
-			if (!ftrace_readme_table[i].avail)
-				ftrace_readme_table[i].avail =
-					strglobmatch(buf, ftrace_readme_table[i].pattern);
-	scanned = true;
-
-	fclose(fp);
-	free(buf);
-
-result:
-	if (type >= FTRACE_README_END)
-		return false;
-
-	return ftrace_readme_table[type].avail;
-}
-
 bool probe_type_is_available(enum probe_type type)
 {
 	if (type >= PROBE_TYPE_END)
 		return false;
 	else if (type == PROBE_TYPE_X)
-		return scan_ftrace_readme(FTRACE_README_PROBE_TYPE_X);
+		return probe_type_x_is_supported();
 
 	return true;
 }
-
-bool kretprobe_offset_is_supported(void)
-{
-	return scan_ftrace_readme(FTRACE_README_KRETPROBE_OFFSET);
-}
diff --git a/tools/perf/util/probe-file.h b/tools/perf/util/probe-file.h
index dbf95a00864a..eba44c3e9dca 100644
--- a/tools/perf/util/probe-file.h
+++ b/tools/perf/util/probe-file.h
@@ -35,7 +35,6 @@ enum probe_type {
 
 /* probe-file.c depends on libelf */
 #ifdef HAVE_LIBELF_SUPPORT
-int open_trace_file(const char *trace_file, bool readwrite);
 int probe_file__open(int flag);
 int probe_file__open_both(int *kfd, int *ufd, int flag);
 struct strlist *probe_file__get_namelist(int fd);
@@ -65,7 +64,6 @@ struct probe_cache_entry *probe_cache__find_by_name(struct probe_cache *pcache,
 					const char *group, const char *event);
 int probe_cache__show_all_caches(struct strfilter *filter);
 bool probe_type_is_available(enum probe_type type);
-bool kretprobe_offset_is_supported(void);
 #else	/* ! HAVE_LIBELF_SUPPORT */
 static inline struct probe_cache *probe_cache__new(const char *tgt __maybe_unused)
 {
diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index de0078e21408..77697c446cbd 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -23,10 +23,12 @@
 #include <string.h>
 #include <ctype.h>
 #include <errno.h>
+#include <api/fs/tracing_path.h>
 
 #include "../perf.h"
 #include "util.h"
 #include "trace-event.h"
+#include "debug.h"
 
 static int get_common_field(struct scripting_context *context,
 			    int *offset, int *size, const char *type)
@@ -254,3 +256,90 @@ unsigned long long eval_flag(const char *flag)
 
 	return 0;
 }
+
+int open_trace_file(const char *trace_file, bool readwrite)
+{
+	char buf[PATH_MAX];
+	int ret;
+
+	ret = snprintf(buf, PATH_MAX, "%s/%s",
+			 tracing_path, trace_file);
+	if (ret >= PATH_MAX)
+		ret = -E2BIG;
+	if (ret >= 0) {
+		pr_debug("Opening %s write=%d\n", buf, readwrite);
+		if (readwrite)
+			ret = open(buf, O_RDWR | O_APPEND, 0);
+		else
+			ret = open(buf, O_RDONLY, 0);
+
+		if (ret < 0)
+			ret = -errno;
+	}
+	return ret;
+}
+
+enum ftrace_readme {
+	FTRACE_README_PROBE_TYPE_X = 0,
+	FTRACE_README_KRETPROBE_OFFSET,
+	FTRACE_README_END,
+};
+
+static struct {
+	const char *pattern;
+	bool avail;
+} ftrace_readme_table[] = {
+#define DEFINE_TYPE(idx, pat)			\
+	[idx] = {.pattern = pat, .avail = false}
+	DEFINE_TYPE(FTRACE_README_PROBE_TYPE_X, "*type: * x8/16/32/64,*"),
+	DEFINE_TYPE(FTRACE_README_KRETPROBE_OFFSET, "*place (kretprobe): *"),
+};
+
+static bool scan_ftrace_readme(enum ftrace_readme type)
+{
+	int fd;
+	FILE *fp;
+	char *buf = NULL;
+	size_t len = 0;
+	bool ret = false;
+	static bool scanned = false;
+
+	if (scanned)
+		goto result;
+
+	fd = open_trace_file("README", false);
+	if (fd < 0)
+		return ret;
+
+	fp = fdopen(fd, "r");
+	if (!fp) {
+		close(fd);
+		return ret;
+	}
+
+	while (getline(&buf, &len, fp) > 0)
+		for (enum ftrace_readme i = 0; i < FTRACE_README_END; i++)
+			if (!ftrace_readme_table[i].avail)
+				ftrace_readme_table[i].avail =
+					strglobmatch(buf, ftrace_readme_table[i].pattern);
+	scanned = true;
+
+	fclose(fp);
+	free(buf);
+
+result:
+	if (type >= FTRACE_README_END)
+		return false;
+
+	return ftrace_readme_table[type].avail;
+}
+
+bool kretprobe_offset_is_supported(void)
+{
+	return scan_ftrace_readme(FTRACE_README_KRETPROBE_OFFSET);
+}
+
+bool probe_type_x_is_supported(void)
+{
+	return scan_ftrace_readme(FTRACE_README_PROBE_TYPE_X);
+}
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 1fbc044f9eb0..ecda2d822daf 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -37,6 +37,10 @@ int parse_ftrace_file(struct pevent *pevent, char *buf, unsigned long size);
 int parse_event_file(struct pevent *pevent,
 		     char *buf, unsigned long size, char *sys);
 
+int open_trace_file(const char *trace_file, bool readwrite);
+bool kretprobe_offset_is_supported(void);
+bool probe_type_x_is_supported(void);
+
 unsigned long long
 raw_field_value(struct event_format *event, const char *name, void *data);
 
-- 
2.11.1
