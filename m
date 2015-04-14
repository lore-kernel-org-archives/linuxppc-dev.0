Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6840D1A0CA7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 16:41:26 +1000 (AEST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 02:41:24 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 089156E804C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:33:12 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E6fMSf22872212
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 06:41:22 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E6fJZr021914
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:41:21 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v9 04/11] perf, tools: Add support for reading JSON event files
Date: Mon, 13 Apr 2015 23:40:57 -0700
Message-Id: <1428993665-2133-5-git-send-email-sukadev@linux.vnet.ibm.com>
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

Add a parser for Intel style JSON event files. This allows
to use an Intel event list directly with perf. The Intel
event lists can be quite large and are too big to store
in unswappable kernel memory.

The parser code knows how to convert the JSON fields
to perf fields. The conversion code is straight forward.
It knows (very little) Intel specific information, and can be easily
extended to handle fields for other CPUs.

The parser code is partially shared with an independent parsing
library, which is 2-clause BSD licenced. To avoid any conflicts I marked
those files as BSD licenced too. As part of perf they become GPLv2.

The events are handled using the existing alias machinery.

We output the BriefDescription in perf list.

Right now the json file can be specified as an argument
to perf stat/record/list. Followon patches will automate this.

JSON files look like this:

[
  {
    "EventCode": "0x00",
    "UMask": "0x01",
    "EventName": "INST_RETIRED.ANY",
    "BriefDescription": "Instructions retired from execution.",
    "PublicDescription": "Instructions retired from execution.",
    "Counter": "Fixed counter 1",
    "CounterHTOff": "Fixed counter 1",
    "SampleAfterValue": "2000003",
    "MSRIndex": "0",
    "MSRValue": "0",
    "TakenAlone": "0",
    "CounterMask": "0",
    "Invert": "0",
    "AnyThread": "0",
    "EdgeDetect": "0",
    "PEBS": "0",
    "PRECISE_STORE": "0",
    "Errata": "null",
    "Offcore": "0"
  }
]

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v9] by Sukadev Bhattiprolu
	Rebase to 4.0 and fix conflicts in:
		tools/perf/Documentation/perf-record.txt
		tools/perf/builtin-list.c
		tools/perf/builtin-record.c
		tools/perf/util/pmu.h
v2: Address review feedback. Rename option to --event-files
v3: Add JSON example
v4: Update manpages.
v5: Don't remove dot in fixname. Fix compile error. Add include
protection. Comment realloc.
v6: Include debug/util.h
---
 tools/perf/Documentation/perf-list.txt   |   12 +-
 tools/perf/Documentation/perf-record.txt |    9 +-
 tools/perf/Documentation/perf-stat.txt   |    8 +-
 tools/perf/Makefile.perf                 |    2 +
 tools/perf/builtin-list.c                |    2 +
 tools/perf/builtin-record.c              |    3 +
 tools/perf/builtin-stat.c                |    2 +
 tools/perf/util/jevents.c                |  247 ++++++++++++++++++++++++++++++
 tools/perf/util/jevents.h                |    8 +
 tools/perf/util/json.c                   |    1 +
 tools/perf/util/pmu.c                    |   14 ++
 tools/perf/util/pmu.h                    |    1 +
 12 files changed, 305 insertions(+), 4 deletions(-)
 create mode 100644 tools/perf/util/jevents.c
 create mode 100644 tools/perf/util/jevents.h

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 3e2aec9..205ac40 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -15,8 +15,16 @@ DESCRIPTION
 This command displays the symbolic event types which can be selected in the
 various perf commands with the -e option.
 
-[[EVENT_MODIFIERS]]
-EVENT MODIFIERS
+OPTIONS
+-------
+--events-file=::
+Specify JSON event list file to use for parsing events. Files can be
+automatically downloaded with perf download.
+The JSON event file can be also specified with the EVENTMAP environment
+variable.
+
+
+[[EVENT_MODIFIERS]] EVENT MODIFIERS
 ---------------
 
 Events can optionally have a modifier by appending a colon and one or
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 31e9774..13f34b0 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -235,6 +235,13 @@ Capture machine state (registers) at interrupt, i.e., on counter overflows for
 each sample. List of captured registers depends on the architecture. This option
 is off by default.
 
+--events-file=::
+Specify JSON event list file to use for parsing events. Must be specified
+before the -e option. Files can be automatically downloaded with perf download.
+The JSON event file can be also specified with the EVENTMAP environment
+variable.
+
+
 SEE ALSO
 --------
-linkperf:perf-stat[1], linkperf:perf-list[1]
+linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-download[1]
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 04e150d..3853245 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -154,6 +154,12 @@ filter out the startup phase of the program, which is often very different.
 
 Print statistics of transactional execution if supported.
 
+--events-file=::
+Specify JSON event list file to use for parsing events. Must be specified before
+the -e option. Files can be automatically downloaded with perf download.
+The JSON event file can be also specified with the EVENTMAP environment
+variable.
+
 EXAMPLES
 --------
 
@@ -174,4 +180,4 @@ $ perf stat -- make -j
 
 SEE ALSO
 --------
-linkperf:perf-top[1], linkperf:perf-list[1]
+linkperf:perf-top[1], linkperf:perf-list[1], linkperf:perf-download[1]
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a558eb3..d9c1a4c 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -333,6 +333,7 @@ LIB_H += util/kvm-stat.h
 LIB_H += util/thread-stack.h
 LIB_H += util/jsmn.h
 LIB_H += util/json.h
+LIB_H += util/jevents.h
 
 LIB_OBJS += $(OUTPUT)util/abspath.o
 LIB_OBJS += $(OUTPUT)util/alias.o
@@ -414,6 +415,7 @@ LIB_OBJS += $(OUTPUT)util/cloexec.o
 LIB_OBJS += $(OUTPUT)util/thread-stack.o
 LIB_OBJS += $(OUTPUT)util/jsmn.o
 LIB_OBJS += $(OUTPUT)util/json.o
+LIB_OBJS += $(OUTPUT)util/jevents.o
 
 LIB_OBJS += $(OUTPUT)ui/setup.o
 LIB_OBJS += $(OUTPUT)ui/helpline.o
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 198f3c3..fd07cc1 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -22,6 +22,8 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 	bool raw_dump = false;
 	struct option list_options[] = {
 		OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
+		OPT_STRING(0, "events-file", &json_file, "json file",
+			   "Read event json file"),
 		OPT_END()
 	};
 	const char * const list_usage[] = {
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 404ab34..365c9d4 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -27,6 +27,7 @@
 #include "util/cpumap.h"
 #include "util/thread_map.h"
 #include "util/data.h"
+#include "util/pmu.h"
 
 #include <unistd.h>
 #include <sched.h>
@@ -839,6 +840,8 @@ struct option __record_options[] = {
 		    "use per-thread mmaps"),
 	OPT_BOOLEAN('I', "intr-regs", &record.opts.sample_intr_regs,
 		    "Sample machine registers on interrupt"),
+	OPT_STRING(0, "events-file", &json_file, "json file",
+		   "Read event json file"),
 	OPT_END()
 };
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e598e4e..f4ff31b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1757,6 +1757,8 @@ int cmd_stat(int argc, const char **argv, const char *prefix __maybe_unused)
 		     "aggregate counts per physical processor core", AGGR_CORE),
 	OPT_UINTEGER('D', "delay", &initial_delay,
 		     "ms to wait before starting measurement after program start"),
+	OPT_STRING(0, "events-file", &json_file, "json file",
+		   "Read event json file"),
 	OPT_END()
 	};
 	const char * const stat_usage[] = {
diff --git a/tools/perf/util/jevents.c b/tools/perf/util/jevents.c
new file mode 100644
index 0000000..023757c
--- /dev/null
+++ b/tools/perf/util/jevents.c
@@ -0,0 +1,247 @@
+/* Parse event JSON files */
+
+/*
+ * Copyright (c) 2014, Intel Corporation
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright notice,
+ * this list of conditions and the following disclaimer.
+ *
+ * 2. Redistributions in binary form must reproduce the above copyright
+ * notice, this list of conditions and the following disclaimer in the
+ * documentation and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
+ * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
+ * OF THE POSSIBILITY OF SUCH DAMAGE.
+*/
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+#include <ctype.h>
+#include "util/debug.h"
+#include "cache.h"
+#include "jsmn.h"
+#include "json.h"
+#include "jevents.h"
+
+static void addfield(char *map, char **dst, const char *sep,
+		     const char *a, jsmntok_t *bt)
+{
+	unsigned len = strlen(a) + 1 + strlen(sep);
+	int olen = *dst ? strlen(*dst) : 0;
+	int blen = bt ? json_len(bt) : 0;
+	char *out;
+
+	out = realloc(*dst, len + olen + blen);
+	if (!out) {
+		/* Don't add field in this case */
+		return;
+	}
+	*dst = out;
+
+	if (!olen)
+		*(*dst) = 0;
+	else
+		strcat(*dst, sep);
+	strcat(*dst, a);
+	if (bt)
+		strncat(*dst, map + bt->start, blen);
+}
+
+static void fixname(char *s)
+{
+	for (; *s; s++)
+		*s = tolower(*s);
+}
+
+static void fixdesc(char *s)
+{
+	char *e = s + strlen(s);
+
+	/* Remove trailing dots that look ugly in perf list */
+	--e;
+	while (e >= s && isspace(*e))
+		--e;
+	if (*e == '.')
+		*e = 0;
+}
+
+static struct msrmap {
+	const char *num;
+	const char *pname;
+} msrmap[] = {
+	{ "0x3F6", "ldlat=" },
+	{ "0x1A6", "offcore_rsp=" },
+	{ "0x1A7", "offcore_rsp=" },
+	{ NULL, NULL }
+};
+
+static struct field {
+	const char *field;
+	const char *kernel;
+} fields[] = {
+	{ "EventCode",	"event=" },
+	{ "UMask",	"umask=" },
+	{ "CounterMask", "cmask=" },
+	{ "Invert",	"inv=" },
+	{ "AnyThread",	"any=" },
+	{ "EdgeDetect",	"edge=" },
+	{ "SampleAfterValue", "period=" },
+	{ NULL, NULL }
+};
+
+static void cut_comma(char *map, jsmntok_t *newval)
+{
+	int i;
+
+	/* Cut off everything after comma */
+	for (i = newval->start; i < newval->end; i++) {
+		if (map[i] == ',')
+			newval->end = i;
+	}
+}
+
+static int match_field(char *map, jsmntok_t *field, int nz,
+		       char **event, jsmntok_t *val)
+{
+	struct field *f;
+	jsmntok_t newval = *val;
+
+	for (f = fields; f->field; f++)
+		if (json_streq(map, field, f->field) && nz) {
+			cut_comma(map, &newval);
+			addfield(map, event, ",", f->kernel, &newval);
+			return 1;
+		}
+	return 0;
+}
+
+static struct msrmap *lookup_msr(char *map, jsmntok_t *val)
+{
+	jsmntok_t newval = *val;
+	static bool warned;
+	int i;
+
+	cut_comma(map, &newval);
+	for (i = 0; msrmap[i].num; i++)
+		if (json_streq(map, &newval, msrmap[i].num))
+			return &msrmap[i];
+	if (!warned) {
+		warned = true;
+		pr_err("Unknown MSR in event file %.*s\n",
+			json_len(val), map + val->start);
+	}
+	return NULL;
+}
+
+#define EXPECT(e, t, m) do { if (!(e)) {			\
+	jsmntok_t *loc = (t);					\
+	if (!(t)->start && (t) > tokens)			\
+		loc = (t) - 1;					\
+		pr_err("%s:%d: " m ", got %s\n", fn,		\
+			json_line(map, loc),			\
+			json_name(t));				\
+	goto out_free;						\
+} } while (0)
+
+/* Call func with each event in the json file */
+
+int json_events(const char *fn,
+	  int (*func)(void *data, char *name, char *event, char *desc),
+	  void *data)
+{
+	int err = -EIO;
+	size_t size;
+	jsmntok_t *tokens, *tok;
+	int i, j, len;
+	char *map;
+
+	tokens = parse_json(fn, &map, &size, &len);
+	if (!tokens)
+		return -EIO;
+	EXPECT(tokens->type == JSMN_ARRAY, tokens, "expected top level array");
+	tok = tokens + 1;
+	for (i = 0; i < tokens->size; i++) {
+		char *event = NULL, *desc = NULL, *name = NULL;
+		struct msrmap *msr = NULL;
+		jsmntok_t *msrval = NULL;
+		jsmntok_t *precise = NULL;
+		jsmntok_t *obj = tok++;
+
+		EXPECT(obj->type == JSMN_OBJECT, obj, "expected object");
+		for (j = 0; j < obj->size; j += 2) {
+			jsmntok_t *field, *val;
+			int nz;
+
+			field = tok + j;
+			EXPECT(field->type == JSMN_STRING, tok + j,
+			       "Expected field name");
+			val = tok + j + 1;
+			EXPECT(val->type == JSMN_STRING, tok + j + 1,
+			       "Expected string value");
+
+			nz = !json_streq(map, val, "0");
+			if (match_field(map, field, nz, &event, val)) {
+				/* ok */
+			} else if (json_streq(map, field, "EventName")) {
+				addfield(map, &name, "", "", val);
+			} else if (json_streq(map, field, "BriefDescription")) {
+				addfield(map, &desc, "", "", val);
+				fixdesc(desc);
+			} else if (json_streq(map, field, "PEBS") && nz) {
+				precise = val;
+			} else if (json_streq(map, field, "MSRIndex") && nz) {
+				msr = lookup_msr(map, val);
+			} else if (json_streq(map, field, "MSRValue")) {
+				msrval = val;
+			} else if (json_streq(map, field, "Errata") &&
+				   !json_streq(map, val, "null")) {
+				addfield(map, &desc, ". ",
+					" Spec update: ", val);
+			} else if (json_streq(map, field, "Data_LA") && nz) {
+				addfield(map, &desc, ". ",
+					" Supports address when precise",
+					NULL);
+			}
+			/* ignore unknown fields */
+		}
+		if (precise && !strstr(desc, "(Precise Event)")) {
+			if (json_streq(map, precise, "2"))
+				addfield(map, &desc, " ", "(Must be precise)",
+						NULL);
+			else
+				addfield(map, &desc, " ",
+						"(Precise event)", NULL);
+		}
+		if (msr != NULL)
+			addfield(map, &event, ",", msr->pname, msrval);
+		fixname(name);
+		err = func(data, name, event, desc);
+		free(event);
+		free(desc);
+		free(name);
+		if (err)
+			break;
+		tok += j;
+	}
+	EXPECT(tok - tokens == len, tok, "unexpected objects at end");
+	err = 0;
+out_free:
+	free_json(map, size, tokens);
+	return err;
+}
diff --git a/tools/perf/util/jevents.h b/tools/perf/util/jevents.h
new file mode 100644
index 0000000..fbc4549
--- /dev/null
+++ b/tools/perf/util/jevents.h
@@ -0,0 +1,8 @@
+#ifndef JEVENTS_H
+#define JEVENTS_H 1
+
+int json_events(const char *fn,
+		int (*func)(void *data, char *name, char *event, char *desc),
+		void *data);
+
+#endif
diff --git a/tools/perf/util/json.c b/tools/perf/util/json.c
index 2219844..45acadf 100644
--- a/tools/perf/util/json.c
+++ b/tools/perf/util/json.c
@@ -37,6 +37,7 @@
 #include <unistd.h>
 #include "jsmn.h"
 #include "json.h"
+#include "util/debug.h"
 #include <linux/kernel.h>
 #include "debug.h"
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 623b107..d7e5e1b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -11,6 +11,9 @@
 #include "pmu.h"
 #include "parse-events.h"
 #include "cpumap.h"
+#include "jevents.h"
+
+const char *json_file;
 
 struct perf_pmu_format {
 	char *name;
@@ -316,6 +319,14 @@ static int pmu_aliases_parse(char *dir, struct list_head *head)
 	return ret;
 }
 
+static int add_alias(void *data, char *name, char *event, char *desc)
+{
+	struct list_head *head = (struct list_head *)data;
+
+	__perf_pmu__new_alias(head, name, NULL, desc, event);
+	return 0;
+}
+
 /*
  * Reading the pmu event aliases definition, which should be located at:
  * /sys/bus/event_source/devices/<dev>/events as sysfs group attributes.
@@ -471,6 +482,9 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	if (pmu_aliases(name, &aliases))
 		return NULL;
 
+	if (!strcmp(name, "cpu") && json_file)
+		json_events(json_file, add_alias, &aliases);
+
 	if (pmu_type(name, &type))
 		return NULL;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index d06496d..f8dac0f 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -77,4 +77,5 @@ int perf_pmu__test(void);
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
 
+extern const char *json_file;
 #endif /* __PMU_H */
-- 
1.7.9.5
