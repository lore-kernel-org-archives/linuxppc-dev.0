Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZtKK2T9CzDsYW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 08:25:41 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FMN2JG038192
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 18:25:38 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25fv62qe6f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 18:25:38 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 18:25:38 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v21 02/19] perf, tools,
 jevents: Program to convert JSON file to C style file
Date: Thu, 15 Sep 2016 15:24:39 -0700
In-Reply-To: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1473978296-20712-3-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andi Kleen <ak@linux.intel.com>

This is a modified version of an earlier patch by Andi Kleen.

We expect architectures to create JSON files describing the performance
monitoring (PMU) events that each CPU model/family of the architecture
supports.

Following is an example of the JSON file entry for an x86 event:

    	[
    	...
    	{
    	"EventCode": "0x00",
    	"UMask": "0x01",
    	"EventName": "INST_RETIRED.ANY",
    	"BriefDescription": "Instructions retired from execution.",
    	"PublicDescription": "Instructions retired from execution.",
    	"Counter": "Fixed counter 1",
    	"CounterHTOff": "Fixed counter 1",
    	"SampleAfterValue": "2000003",
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
    	},
    	...

    	]

All the PMU events supported by a CPU model/family must be grouped into
"topics" such as "Piplelining", "Floating-point", "Virtual-memory" etc.

All events belonging to a topic must be placed in a separate JSON file
(eg: "Pipeling.json") and all the topic JSON files for a CPU model must
be in a separate directory.

	Eg: for the CPU model "Silvermont_core":

    	$ ls tools/perf/pmu-events/arch/x86/Silvermont_core
    	Floating-point.json
    	Memory.json
    	Other.json
    	Pipelining.json
    	Virtualmemory.json

Finally, to allow multiple CPU models to share a single set of JSON files,
architectures must provide a mapping between a model and its set of events:

    	$ grep Silvermont tools/perf/pmu-events/arch/x86/mapfile.csv
    	GenuineIntel-6-4D,V13,Silvermont_core,core
    	GenuineIntel-6-4C,V13,Silvermont_core,core

which maps each CPU, identified by [vendor, family, model, version, type]
to a directory of JSON files. Thus two (or more) CPU models support the
set of PMU events listed in the directory.

    	tools/perf/pmu-events/arch/x86/Silvermont_core/

Given this organization of files, the program, jevents:

	- locates all JSON files for each CPU-model of the architecture,

	- parses all JSON files for the CPU-model and generates a C-style
	  "PMU-events table" (pmu-events.c) for the model

	- locates a mapfile for the architecture

	- builds a global table, mapping each model of CPU to the corresponding
	  PMU-events table.

The 'pmu-events.c' is generated when building perf and added to libperf.a.
The global table pmu_events_map[] table in this pmu-events.c will be used
in perf in a follow-on patch.

If the architecture does not have any JSON files or there is an error in
processing them, an empty mapping file is created. This would allow the
build of perf to proceed even if we are not able to provide aliases for
events.

The parser for JSON files allows parsing Intel style JSON event files. This
allows to use an Intel event list directly with perf. The Intel event lists
can be quite large and are too big to store in unswappable kernel memory.

The conversion from JSON to C-style is straight forward.  The parser knows
(very little) Intel specific information, and can be easily extended to
handle fields for other CPUs.

The parser code is partially shared with an independent parsing library,
which is 2-clause BSD licenced. To avoid any conflicts I marked those
files as BSD licenced too. As part of perf they become GPLv2.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
---
v2: Address review feedback. Rename option to --event-files
v3: Add JSON example
v4: Update manpages.
v5: Don't remove dot in fixname. Fix compile error. Add include
	protection. Comment realloc.
v6: Include debug/util.h
v7: (Sukadev Bhattiprolu)
	Rebase to 4.0 and fix some conflicts.
v8: (Sukadev Bhattiprolu)
	Move jevents.[hc] to tools/perf/pmu-events/
	Rewrite to locate and process arch specific JSON and "map" files;
	and generate a C file.
	(Removed acked-by Namhyung Kim due to modest changes to patch)
	Compile the generated pmu-events.c and add the pmu-events.o to
	libperf.a
v9: [Sukadev Bhattiprolu/Andi Kleen] Rename ->vfm to ->cpuid and use
	that field to encode the PVR in Power.
	Allow blank lines in mapfile.
	[Jiri Olsa] Pass ARCH as a parameter to jevents so we don't have
	to detect it.
	[Jiri Olsa] Use the infrastrastructure to build pmu-events/perf
	(Makefile changes from Jiri included in this patch).
	[Jiri Olsa, Andi Kleen] Detect changes to JSON files and rebuild
	pmu-events.o only if necessary.

v11: 	- [Andi Kleen] Add mapfile, jevents dependency on pmu-events.c
	- [Jiri Olsa] Be silient if arch doesn't have JSON files
	- Also silence 'jevents' when parsing JSON files unless V=1 is
	  specified during build. Cleanup error messages.

v14:-	- [Jiri Olsa] Fix compile error with DEBUG=1; drop unlink() and
	  use "w" mode with fopen(); simplify file_name_to_table_name()

v15:	- Fix minor conflict in tools/perf/Makefile.perf when rebasing
	  to recent perf/core.

v16:	- Rebase to upstream; fix conflicts in tools/perf/Makefile.perf

v18:	- Rebase to upstream; fix conflicts in tools/perf/Makefile.perf

v20: 	- Rebase to upstream; rename a local variable to 'ldirname' to avoid
	  collision with the dirname().

v21:	- Breakup the large JSON files into separate topics like
	  Pipelining.json, Cache.json etc (by Jiri Olsa).
	- Ensure BriefDescription field is non-null before adding extra
	  description for PEBS events.
---
 tools/perf/Makefile.perf           |  28 +-
 tools/perf/pmu-events/Build        |  11 +
 tools/perf/pmu-events/jevents.c    | 766 +++++++++++++++++++++++++++++++++++++
 tools/perf/pmu-events/jevents.h    |  17 +
 tools/perf/pmu-events/json.h       |   6 +
 tools/perf/pmu-events/pmu-events.h |  36 ++
 6 files changed, 860 insertions(+), 4 deletions(-)
 create mode 100644 tools/perf/pmu-events/Build
 create mode 100644 tools/perf/pmu-events/jevents.c
 create mode 100644 tools/perf/pmu-events/jevents.h
 create mode 100644 tools/perf/pmu-events/pmu-events.h

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 828cfd7..0abebcb 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -347,6 +347,14 @@ PERF_IN := $(OUTPUT)perf-in.o
 export srctree OUTPUT RM CC LD AR CFLAGS V BISON FLEX AWK
 include $(srctree)/tools/build/Makefile.include
 
+JEVENTS       := $(OUTPUT)pmu-events/jevents
+JEVENTS_IN    := $(OUTPUT)pmu-events/jevents-in.o
+PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
+
+export JEVENTS
+
+build := -f $(srctree)/tools/build/Makefile.build dir=. obj
+
 $(PERF_IN): prepare FORCE
 	@(test -f ../../include/uapi/linux/perf_event.h && ( \
         (diff -B ../include/uapi/linux/perf_event.h ../../include/uapi/linux/perf_event.h >/dev/null) \
@@ -434,9 +442,18 @@ $(PERF_IN): prepare FORCE
 	|| echo "Warning: tools/include/linux/coresight-pmu.h differs from kernel" >&2 )) || true
 	$(Q)$(MAKE) $(build)=perf
 
-$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
+$(JEVENTS_IN): FORCE
+	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=jevents
+
+$(JEVENTS): $(JEVENTS_IN)
+	$(QUIET_LINK)$(CC) $(JEVENTS_IN) -o $@
+
+$(PMU_EVENTS_IN): $(JEVENTS) FORCE
+	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
+
+$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS) \
-		$(PERF_IN) $(LIBS) -o $@
+		$(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
 
 $(GTK_IN): fixdep FORCE
 	$(Q)$(MAKE) $(build)=gtk
@@ -465,6 +482,8 @@ perf.spec $(SCRIPTS) \
 ifneq ($(OUTPUT),)
 %.o: $(OUTPUT)%.o
 	@echo "    # Redirected target $@ => $(OUTPUT)$@"
+pmu-events/%.o: $(OUTPUT)pmu-events/%.o
+	@echo "    # Redirected target $@ => $(OUTPUT)$@"
 util/%.o: $(OUTPUT)util/%.o
 	@echo "    # Redirected target $@ => $(OUTPUT)$@"
 bench/%.o: $(OUTPUT)bench/%.o
@@ -720,10 +739,11 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIB_FILE) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(LANG_BINDINGS)
 	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
-	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32
+	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32 $(OUTPUT)pmu-events/jevents $(srctree)/tools/perf/pmu-events/pmu-events.c
 	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c $(OUTPUT)fixdep \
-		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c
+		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
+		$(OUTPUT)pmu-events/pmu-events.c
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
 	$(python-clean)
 
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
new file mode 100644
index 0000000..d2f3430
--- /dev/null
+++ b/tools/perf/pmu-events/Build
@@ -0,0 +1,11 @@
+jevents-y	+= json.o jsmn.o jevents.o
+pmu-events-y	+= pmu-events.o
+JDIR		=  pmu-events/arch/$(ARCH)
+JSON		=  $(shell [ -d $(JDIR) ] &&				\
+			find $(JDIR) -name '*.json' -o -name 'mapfile.csv')
+#
+# Locate/process JSON files in pmu-events/arch/
+# directory and create tables in pmu-events.c.
+#
+$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JEVENTS)
+	$(Q)$(call echo-cmd,gen)$(JEVENTS) $(ARCH) pmu-events/arch $(OUTPUT)pmu-events/pmu-events.c $(V)
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
new file mode 100644
index 0000000..a9ca86d
--- /dev/null
+++ b/tools/perf/pmu-events/jevents.c
@@ -0,0 +1,766 @@
+#define  _XOPEN_SOURCE 500	/* needed for nftw() */
+
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
+#include <unistd.h>
+#include <stdarg.h>
+#include <libgen.h>
+#include <dirent.h>
+#include <sys/time.h>			/* getrlimit */
+#include <sys/resource.h>		/* getrlimit */
+#include <ftw.h>
+#include <sys/stat.h>
+#include "jsmn.h"
+#include "json.h"
+#include "jevents.h"
+
+#ifndef __maybe_unused
+#define __maybe_unused                  __attribute__((unused))
+#endif
+
+int verbose;
+char *prog;
+
+int eprintf(int level, int var, const char *fmt, ...)
+{
+
+	int ret;
+	va_list args;
+
+	if (var < level)
+		return 0;
+
+	va_start(args, fmt);
+
+	ret = vfprintf(stderr, fmt, args);
+
+	va_end(args);
+
+	return ret;
+}
+
+__attribute__((weak)) char *get_cpu_str(void)
+{
+	return NULL;
+}
+
+static void addfield(char *map, char **dst, const char *sep,
+		     const char *a, jsmntok_t *bt)
+{
+	unsigned int len = strlen(a) + 1 + strlen(sep);
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
+		pr_err("%s: Unknown MSR in event file %.*s\n", prog,
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
+#define TOPIC_DEPTH 256
+static char *topic_array[TOPIC_DEPTH];
+static int   topic_level;
+
+static char *get_topic(void)
+{
+	char *tp_old, *tp = NULL;
+	int i;
+
+	for (i = 0; i < topic_level + 1; i++) {
+		int n;
+
+		tp_old = tp;
+		n = asprintf(&tp, "%s%s", tp ?: "", topic_array[i]);
+		if (n < 0) {
+			pr_info("%s: asprintf() error %s\n", prog);
+			return NULL;
+		}
+		free(tp_old);
+	}
+
+	for (i = 0; i < (int) strlen(tp); i++) {
+		char c = tp[i];
+
+		if (c == '-')
+			tp[i] = ' ';
+		else if (c == '.') {
+			tp[i] = '\0';
+			break;
+		}
+	}
+
+	return tp;
+}
+
+static int add_topic(int level, char *bname)
+{
+	char *topic;
+
+	level -= 2;
+
+	if (level >= TOPIC_DEPTH)
+		return -EINVAL;
+
+	topic = strdup(bname);
+	if (!topic) {
+		pr_info("%s: strdup() error %s for file %s\n", prog,
+				strerror(errno), bname);
+		return -ENOMEM;
+	}
+
+	free(topic_array[topic_level]);
+	topic_array[topic_level] = topic;
+	topic_level              = level;
+	return 0;
+}
+
+struct perf_entry_data {
+	FILE *outfp;
+	char *topic;
+};
+
+static int close_table;
+
+static void print_events_table_prefix(FILE *fp, const char *tblname)
+{
+	fprintf(fp, "struct pmu_event %s[] = {\n", tblname);
+	close_table = 1;
+}
+
+static int print_events_table_entry(void *data, char *name, char *event,
+				    char *desc)
+{
+	struct perf_entry_data *pd = data;
+	FILE *outfp = pd->outfp;
+	char *topic = pd->topic;
+
+	/*
+	 * TODO: Remove formatting chars after debugging to reduce
+	 *	 string lengths.
+	 */
+	fprintf(outfp, "{\n");
+
+	fprintf(outfp, "\t.name = \"%s\",\n", name);
+	fprintf(outfp, "\t.event = \"%s\",\n", event);
+	fprintf(outfp, "\t.desc = \"%s\",\n", desc);
+	fprintf(outfp, "\t.topic = \"%s\",\n", topic);
+
+	fprintf(outfp, "},\n");
+
+	return 0;
+}
+
+static void print_events_table_suffix(FILE *outfp)
+{
+	fprintf(outfp, "{\n");
+
+	fprintf(outfp, "\t.name = 0,\n");
+	fprintf(outfp, "\t.event = 0,\n");
+	fprintf(outfp, "\t.desc = 0,\n");
+
+	fprintf(outfp, "},\n");
+	fprintf(outfp, "};\n");
+	close_table = 0;
+}
+
+/* Call func with each event in the json file */
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
+	if (!fn)
+		return -ENOENT;
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
+		if (precise && desc && !strstr(desc, "(Precise Event)")) {
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
+
+static char *file_name_to_table_name(char *fname)
+{
+	unsigned int i;
+	int n;
+	int c;
+	char *tblname;
+
+	/*
+	 * Ensure tablename starts with alphabetic character.
+	 * Derive rest of table name from basename of the JSON file,
+	 * replacing hyphens and stripping out .json suffix.
+	 */
+	n = asprintf(&tblname, "pme_%s", basename(fname));
+	if (n < 0) {
+		pr_info("%s: asprintf() error %s for file %s\n", prog,
+				strerror(errno), fname);
+		return NULL;
+	}
+
+	for (i = 0; i < strlen(tblname); i++) {
+		c = tblname[i];
+
+		if (c == '-')
+			tblname[i] = '_';
+		else if (c == '.') {
+			tblname[i] = '\0';
+			break;
+		} else if (!isalnum(c) && c != '_') {
+			pr_err("%s: Invalid character '%c' in file name %s\n",
+					prog, c, basename(fname));
+			free(tblname);
+			tblname = NULL;
+			break;
+		}
+	}
+
+	return tblname;
+}
+
+static void print_mapping_table_prefix(FILE *outfp)
+{
+	fprintf(outfp, "struct pmu_events_map pmu_events_map[] = {\n");
+}
+
+static void print_mapping_table_suffix(FILE *outfp)
+{
+	/*
+	 * Print the terminating, NULL entry.
+	 */
+	fprintf(outfp, "{\n");
+	fprintf(outfp, "\t.cpuid = 0,\n");
+	fprintf(outfp, "\t.version = 0,\n");
+	fprintf(outfp, "\t.type = 0,\n");
+	fprintf(outfp, "\t.table = 0,\n");
+	fprintf(outfp, "},\n");
+
+	/* and finally, the closing curly bracket for the struct */
+	fprintf(outfp, "};\n");
+}
+
+static int process_mapfile(FILE *outfp, char *fpath)
+{
+	int n = 16384;
+	FILE *mapfp;
+	char *save = NULL;
+	char *line, *p;
+	int line_num;
+	char *tblname;
+
+	pr_info("%s: Processing mapfile %s\n", prog, fpath);
+
+	line = malloc(n);
+	if (!line)
+		return -1;
+
+	mapfp = fopen(fpath, "r");
+	if (!mapfp) {
+		pr_info("%s: Error %s opening %s\n", prog, strerror(errno),
+				fpath);
+		return -1;
+	}
+
+	print_mapping_table_prefix(outfp);
+
+	line_num = 0;
+	while (1) {
+		char *cpuid, *version, *type, *fname;
+
+		line_num++;
+		p = fgets(line, n, mapfp);
+		if (!p)
+			break;
+
+		if (line[0] == '#' || line[0] == '\n')
+			continue;
+
+		if (line[strlen(line)-1] != '\n') {
+			/* TODO Deal with lines longer than 16K */
+			pr_info("%s: Mapfile %s: line %d too long, aborting\n",
+					prog, fpath, line_num);
+			return -1;
+		}
+		line[strlen(line)-1] = '\0';
+
+		cpuid = strtok_r(p, ",", &save);
+		version = strtok_r(NULL, ",", &save);
+		fname = strtok_r(NULL, ",", &save);
+		type = strtok_r(NULL, ",", &save);
+
+		tblname = file_name_to_table_name(fname);
+		fprintf(outfp, "{\n");
+		fprintf(outfp, "\t.cpuid = \"%s\",\n", cpuid);
+		fprintf(outfp, "\t.version = \"%s\",\n", version);
+		fprintf(outfp, "\t.type = \"%s\",\n", type);
+
+		/*
+		 * CHECK: We can't use the type (eg "core") field in the
+		 * table name. For us to do that, we need to somehow tweak
+		 * the other caller of file_name_to_table(), process_json()
+		 * to determine the type. process_json() file has no way
+		 * of knowing these are "core" events unless file name has
+		 * core in it. If filename has core in it, we can safely
+		 * ignore the type field here also.
+		 */
+		fprintf(outfp, "\t.table = %s\n", tblname);
+		fprintf(outfp, "},\n");
+	}
+
+	print_mapping_table_suffix(outfp);
+
+	return 0;
+}
+
+/*
+ * If we fail to locate/process JSON and map files, create a NULL mapping
+ * table. This would at least allow perf to build even if we can't find/use
+ * the aliases.
+ */
+static void create_empty_mapping(const char *output_file)
+{
+	FILE *outfp;
+
+	pr_info("%s: Creating empty pmu_events_map[] table\n", prog);
+
+	/* Truncate file to clear any partial writes to it */
+	outfp = fopen(output_file, "w");
+	if (!outfp) {
+		perror("fopen()");
+		_Exit(1);
+	}
+
+	fprintf(outfp, "#include \"../../pmu-events/pmu-events.h\"\n");
+	print_mapping_table_prefix(outfp);
+	print_mapping_table_suffix(outfp);
+	fclose(outfp);
+}
+
+static int get_maxfds(void)
+{
+	struct rlimit rlim;
+
+	if (getrlimit(RLIMIT_NOFILE, &rlim) == 0)
+		return rlim.rlim_max;
+
+	return 512;
+}
+
+/*
+ * nftw() doesn't let us pass an argument to the processing function,
+ * so use a global variables.
+ */
+static FILE *eventsfp;
+static char *mapfile;
+
+static int process_one_file(const char *fpath, const struct stat *sb,
+			    int typeflag, struct FTW *ftwbuf)
+{
+	char *tblname, *bname  = (char *) fpath + ftwbuf->base;
+	int is_dir  = typeflag == FTW_D;
+	int is_file = typeflag == FTW_F;
+	int level   = ftwbuf->level;
+	int err = 0;
+
+	pr_debug("%s %d %7jd %-20s %s\n",
+		 is_file ? "f" : is_dir ? "d" : "x",
+		 level, sb->st_size, bname, fpath);
+
+	/* base dir */
+	if (level == 0)
+		return 0;
+
+	/* model directory, reset topic */
+	if (level == 1 && is_dir) {
+		if (close_table)
+			print_events_table_suffix(eventsfp);
+
+		/*
+		 * Drop file name suffix. Replace hyphens with underscores.
+		 * Fail if file name contains any alphanum characters besides
+		 * underscores.
+		 */
+		tblname = file_name_to_table_name(bname);
+		if (!tblname) {
+			pr_info("%s: Error determining table name for %s\n", prog,
+				bname);
+			return -1;
+		}
+
+		print_events_table_prefix(eventsfp, tblname);
+		return 0;
+	}
+
+	/*
+	 * Save the mapfile name for now. We will process mapfile
+	 * after processing all JSON files (so we can write out the
+	 * mapping table after all PMU events tables).
+	 *
+	 * TODO: Allow for multiple mapfiles? Punt for now.
+	 */
+	if (level == 1 && is_file) {
+		if (!strncmp(bname, "mapfile.csv", 11)) {
+			if (mapfile) {
+				pr_info("%s: Many mapfiles? Using %s, ignoring %s\n",
+						prog, mapfile, fpath);
+			} else {
+				mapfile = strdup(fpath);
+			}
+			return 0;
+		}
+
+		pr_info("%s: Ignoring file %s\n", prog, fpath);
+		return 0;
+	}
+
+	/*
+	 * If the file name does not have a .json extension,
+	 * ignore it. It could be a readme.txt for instance.
+	 */
+	if (is_file) {
+		char *suffix = bname + strlen(bname) - 5;
+
+		if (strncmp(suffix, ".json", 5)) {
+			pr_info("%s: Ignoring file without .json suffix %s\n", prog,
+				fpath);
+			return 0;
+		}
+	}
+
+	if (level > 1 && add_topic(level, bname))
+		return -ENOMEM;
+
+	/*
+	 * Assume all other files are JSON files.
+	 *
+	 * If mapfile refers to 'power7_core.json', we create a table
+	 * named 'power7_core'. Any inconsistencies between the mapfile
+	 * and directory tree could result in build failure due to table
+	 * names not being found.
+	 *
+	 * Atleast for now, be strict with processing JSON file names.
+	 * i.e. if JSON file name cannot be mapped to C-style table name,
+	 * fail.
+	 */
+	if (is_file) {
+		struct perf_entry_data data = {
+			.topic = get_topic(),
+			.outfp = eventsfp,
+		};
+
+		err = json_events(fpath, print_events_table_entry, &data);
+
+		free(data.topic);
+	}
+
+	return err;
+}
+
+#ifndef PATH_MAX
+#define PATH_MAX	4096
+#endif
+
+/*
+ * Starting in directory 'start_dirname', find the "mapfile.csv" and
+ * the set of JSON files for the architecture 'arch'.
+ *
+ * From each JSON file, create a C-style "PMU events table" from the
+ * JSON file (see struct pmu_event).
+ *
+ * From the mapfile, create a mapping between the CPU revisions and
+ * PMU event tables (see struct pmu_events_map).
+ *
+ * Write out the PMU events tables and the mapping table to pmu-event.c.
+ *
+ * If unable to process the JSON or arch files, create an empty mapping
+ * table so we can continue to build/use  perf even if we cannot use the
+ * PMU event aliases.
+ */
+int main(int argc, char *argv[])
+{
+	int rc;
+	int maxfds;
+	char ldirname[PATH_MAX];
+
+	const char *arch;
+	const char *output_file;
+	const char *start_dirname;
+
+	prog = basename(argv[0]);
+	if (argc < 4) {
+		pr_err("Usage: %s <arch> <starting_dir> <output_file>\n", prog);
+		return 1;
+	}
+
+	arch = argv[1];
+	start_dirname = argv[2];
+	output_file = argv[3];
+
+	if (argc > 4)
+		verbose = atoi(argv[4]);
+
+	eventsfp = fopen(output_file, "w");
+	if (!eventsfp) {
+		pr_err("%s Unable to create required file %s (%s)\n",
+				prog, output_file, strerror(errno));
+		return 2;
+	}
+
+	/* Include pmu-events.h first */
+	fprintf(eventsfp, "#include \"../../pmu-events/pmu-events.h\"\n");
+
+	sprintf(ldirname, "%s/%s", start_dirname, arch);
+
+	/*
+	 * The mapfile allows multiple CPUids to point to the same JSON file,
+	 * so, not sure if there is a need for symlinks within the pmu-events
+	 * directory.
+	 *
+	 * For now, treat symlinks of JSON files as regular files and create
+	 * separate tables for each symlink (presumably, each symlink refers
+	 * to specific version of the CPU).
+	 */
+
+	maxfds = get_maxfds();
+	mapfile = NULL;
+	rc = nftw(ldirname, process_one_file, maxfds, 0);
+	if (rc && verbose) {
+		pr_info("%s: Error walking file tree %s\n", prog, ldirname);
+		goto empty_map;
+	} else if (rc) {
+		goto empty_map;
+	}
+
+	if (close_table)
+		print_events_table_suffix(eventsfp);
+
+	if (!mapfile) {
+		pr_info("%s: No CPU->JSON mapping?\n", prog);
+		goto empty_map;
+	}
+
+	if (process_mapfile(eventsfp, mapfile)) {
+		pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
+		goto empty_map;
+	}
+
+	return 0;
+
+empty_map:
+	fclose(eventsfp);
+	create_empty_mapping(output_file);
+	return 0;
+}
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
new file mode 100644
index 0000000..996601f
--- /dev/null
+++ b/tools/perf/pmu-events/jevents.h
@@ -0,0 +1,17 @@
+#ifndef JEVENTS_H
+#define JEVENTS_H 1
+
+int json_events(const char *fn,
+		int (*func)(void *data, char *name, char *event, char *desc),
+		void *data);
+char *get_cpu_str(void);
+
+#ifndef min
+#define min(x, y) ({                            \
+	typeof(x) _min1 = (x);                  \
+	typeof(y) _min2 = (y);                  \
+	(void) (&_min1 == &_min2);              \
+	_min1 < _min2 ? _min1 : _min2; })
+#endif
+
+#endif
diff --git a/tools/perf/pmu-events/json.h b/tools/perf/pmu-events/json.h
index 6b8337e..5339704 100644
--- a/tools/perf/pmu-events/json.h
+++ b/tools/perf/pmu-events/json.h
@@ -24,6 +24,12 @@ extern int eprintf(int level, int var, const char *fmt, ...);
 #define pr_err(fmt, ...) \
 	eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
 
+#define pr_info(fmt, ...) \
+	eprintf(1, verbose, pr_fmt(fmt), ##__VA_ARGS__)
+
+#define pr_debug(fmt, ...) \
+	eprintf(2, verbose, pr_fmt(fmt), ##__VA_ARGS__)
+
 #ifndef roundup
 #define roundup(x, y) (                                \
 {                                                      \
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
new file mode 100644
index 0000000..70d5479
--- /dev/null
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -0,0 +1,36 @@
+#ifndef PMU_EVENTS_H
+#define PMU_EVENTS_H
+
+/*
+ * Describe each PMU event. Each CPU has a table of PMU events.
+ */
+struct pmu_event {
+	const char *name;
+	const char *event;
+	const char *desc;
+	const char *topic;
+};
+
+/*
+ *
+ * Map a CPU to its table of PMU events. The CPU is identified by the
+ * cpuid field, which is an arch-specific identifier for the CPU.
+ * The identifier specified in tools/perf/pmu-events/arch/xxx/mapfile
+ * must match the get_cpustr() in tools/perf/arch/xxx/util/header.c)
+ *
+ * The  cpuid can contain any character other than the comma.
+ */
+struct pmu_events_map {
+	const char *cpuid;
+	const char *version;
+	const char *type;		/* core, uncore etc */
+	struct pmu_event *table;
+};
+
+/*
+ * Global table mapping each known CPU for the architecture to its
+ * table of PMU events.
+ */
+extern struct pmu_events_map pmu_events_map[];
+
+#endif
-- 
1.8.3.1
