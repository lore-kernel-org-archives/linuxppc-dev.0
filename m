Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C08091A02AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 10:02:43 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:02:41 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 291A538C8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:02:39 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4K02dF459048188
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 00:02:39 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4K02coL004402
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:02:38 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/4] perf: jevents: Program to convert JSON file to C style
 file
Date: Tue, 19 May 2015 17:02:08 -0700
Message-Id: <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
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

This is a modified version of an earlier patch by Andi Kleen.

We expect architectures to describe the performance monitoring events
for each CPU in a corresponding JSON file, which look like:

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

We also expect the architectures to provide a mapping between individual
CPUs to their JSON files. Eg:

	GenuineIntel-6-1E,V1,/NHM-EP/NehalemEP_core_V1.json,core

which maps each CPU, identified by [vendor, family, model, version, type]
to a JSON file.

Given these files, the program, jevents::
	- locates all JSON files for the architecture,
	- parses each JSON file and generates a C-style "PMU-events table"
	  (pmu-events.c)
	- locates a mapfile for the architecture
	- builds a global table, mapping each model of CPU to the
	  corresponding PMU-events table.

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
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

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
---
 tools/perf/Build                   |    1 +
 tools/perf/Makefile.perf           |    4 +-
 tools/perf/pmu-events/Build        |   38 ++
 tools/perf/pmu-events/README       |   67 ++++
 tools/perf/pmu-events/jevents.c    |  700 ++++++++++++++++++++++++++++++++++++
 tools/perf/pmu-events/jevents.h    |   17 +
 tools/perf/pmu-events/pmu-events.h |   39 ++
 7 files changed, 865 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/pmu-events/Build
 create mode 100644 tools/perf/pmu-events/README
 create mode 100644 tools/perf/pmu-events/jevents.c
 create mode 100644 tools/perf/pmu-events/jevents.h
 create mode 100644 tools/perf/pmu-events/pmu-events.h

diff --git a/tools/perf/Build b/tools/perf/Build
index b77370e..40bffa0 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -36,6 +36,7 @@ CFLAGS_builtin-help.o      += $(paths)
 CFLAGS_builtin-timechart.o += $(paths)
 CFLAGS_perf.o              += -DPERF_HTML_PATH="BUILD_STR($(htmldir_SQ))" -include $(OUTPUT)PERF-VERSION-FILE
 
+libperf-y += pmu-events/
 libperf-y += util/
 libperf-y += arch/
 libperf-y += ui/
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c43a205..d078c71 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -306,6 +306,8 @@ perf.spec $(SCRIPTS) \
 ifneq ($(OUTPUT),)
 %.o: $(OUTPUT)%.o
 	@echo "    # Redirected target $@ => $(OUTPUT)$@"
+pmu-events/%.o: $(OUTPUT)pmu-events/%.o
+	@echo "    # Redirected target $@ => $(OUTPUT)$@"
 util/%.o: $(OUTPUT)util/%.o
 	@echo "    # Redirected target $@ => $(OUTPUT)$@"
 bench/%.o: $(OUTPUT)bench/%.o
@@ -529,7 +531,7 @@ clean: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean config-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIB_FILE) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(LANG_BINDINGS)
 	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) .config-detected
-	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32
+	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32 $(OUTPUT)pmu-events/jevents
 	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex*
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
 	$(python-clean)
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
new file mode 100644
index 0000000..7a2aaaf
--- /dev/null
+++ b/tools/perf/pmu-events/Build
@@ -0,0 +1,38 @@
+.SUFFIXES:
+
+libperf-y += pmu-events.o
+
+JEVENTS =	$(OUTPUT)pmu-events/jevents
+JEVENTS_OBJS =	$(OUTPUT)pmu-events/json.o $(OUTPUT)pmu-events/jsmn.o \
+		$(OUTPUT)pmu-events/jevents.o
+
+PMU_EVENTS =	$(srctree)/tools/perf/pmu-events/
+
+all: $(OUTPUT)pmu-events.o
+
+$(OUTPUT)pmu-events/jevents: $(JEVENTS_OBJS)
+	$(call rule_mkdir)
+	$(CC) -o $@ $(JEVENTS_OBJS)
+
+#
+# Look for JSON files in $(PMU_EVENTS)/arch directory,
+# process them and create tables in $(PMU_EVENTS)/pmu-events.c
+#
+pmu-events/pmu-events.c: $(JEVENTS) FORCE
+	$(JEVENTS) $(PMU_EVENTS)/arch $(PMU_EVENTS)/pmu-events.c
+ 
+
+#
+# If we fail to build pmu-events.o, it could very well be due to
+# inconsistencies between the architecture's mapfile.csv and the
+# directory tree. If the compilation of the pmu-events.c generated
+# by jevents fails, create an "empty" mapping table in pmu-events.c
+# so the build of perf can succeed even if we are not able to use
+# the PMU event aliases.
+#
+
+clean:
+	rm -f $(JEVENTS_OBJS) $(JEVENTS) $(OUTPUT)pmu-events.o \
+		$(PMU_EVENTS)pmu-events.c
+
+FORCE:
diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
new file mode 100644
index 0000000..d9ed641
--- /dev/null
+++ b/tools/perf/pmu-events/README
@@ -0,0 +1,67 @@
+The contents of this directory allows users to specify PMU events
+in their CPUs by their symbolic names rather than raw event codes
+(see example below).
+
+
+The main program in this directory, is the 'jevents', which is built
+and executed _before_ the perf binary itself is built.
+
+The 'jevents' program tries to locate and process JSON files in the directory
+tree tools/perf/pmu-events/arch/xxx. 
+
+	- Regular files with .json extension in the name are assumed to be
+	  JSON files.
+
+	- Regular files with base name starting with 'mapfile' are assumed to
+	  be a CSV file that - maps a specific CPU to its set of PMU events.
+
+Directories are traversed but all other files are ignored.
+
+Using the JSON files and the mapfile, 'jevents' generates a C source file,
+'pmu-events.c', which encodes the two sets of tables:
+
+	- Set of 'PMU events tables' for all known CPUs in the architecture
+
+	- A 'mapping table' that maps a CPU ot its 'PMU events table'
+
+The 'pmu-events.h' has an extern declaration for the mapping table and the
+generated 'pmu-events.c' defines this table.
+
+After the 'pmu-events.c' is generated, it is compiled and the resulting
+'pmu-events.o' is added to 'libperf.a' which is then used by perf to process
+PMU event aliases. eg:
+
+	$ perf stat -e pm_1plus_ppc_cmpl sleep 1
+
+where pm_1plus_ppc_cmpl is a Power8 PMU event.
+
+In case of errors when processing files in the tools/perf/pmu-events/arch
+directory, 'jevents' tries to create an empty mapping file to allow perf
+build to succeed even if the PMU event aliases cannot be used.
+
+However some errors in processing may cause the perf build to fail.
+
+The mapfile format is expected to be:
+
+	VFM,Version,JSON_file_path_name,Type
+
+where:
+	Comma:
+		is the required field delimiter.
+
+	VFM:
+		represents vendor, family, model of the CPU. Architectures
+		can use a delimiter other than comma to further separate the
+		fields if they so choose. Architectures should implement the
+		function arch_pmu_events_match_cpu() and can use the
+		VFM, Version and Type fields to uniquely identify a CPU.
+
+	Version:
+		is the CPU version (PVR in case of Powerpc)
+
+	JSON_file_path_name:
+		is the pathname for the JSON file, relative to the directory
+		containing the mapfile.
+
+	Type:
+		indicates whether the events or "core" or "uncore" events.
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
new file mode 100644
index 0000000..3afa6e9
--- /dev/null
+++ b/tools/perf/pmu-events/jevents.c
@@ -0,0 +1,700 @@
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
+#include <sys/utsname.h>
+#include <sys/time.h>			/* getrlimit */
+#include <sys/resource.h>		/* getrlimit */
+#include <ftw.h>
+#include <sys/stat.h>
+#include "jsmn.h"
+#include "json.h"
+#include "jevents.h"
+
+#ifndef  __maybe_unused
+#define __maybe_unused                  __attribute__((unused))
+#endif
+
+int verbose = 1;
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
+static void print_events_table_prefix(FILE *fp, const char *tblname)
+{
+	fprintf(fp, "struct pmu_event %s[] = {\n", tblname);
+}
+
+static int print_events_table_entry(void *data, char *name, char *event,
+				    char *desc)
+{
+	FILE *outfp = data;
+	/*
+	 * TODO: Remove formatting chars after debugging to reduce
+	 *	 string lengths.
+	 */
+	fprintf(outfp, "{\n");
+
+	fprintf(outfp, "\t.name = \"%s\",\n", name);
+	fprintf(outfp, "\t.event = \"%s\",\n", event);
+	fprintf(outfp, "\t.desc = \"%s\",\n", desc);
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
+
+static char *file_name_to_table_name(char *fname)
+{
+	unsigned int i, j;
+	int c;
+	int n = 1024;		/* use max variable length? */
+	char *tblname;
+	char *p;
+
+	tblname = malloc(n);
+	if (!tblname)
+		return NULL;
+
+	p = basename(fname);
+
+	memset(tblname, 0, n);
+
+	/* Ensure table name starts with an alphabetic char */
+	strcpy(tblname, "pme_");
+
+	n = strlen(fname) + strlen(tblname);
+	n = min(1024, n);
+
+	for (i = 0, j = strlen(tblname); i < strlen(fname); i++, j++) {
+		c = p[i];
+		if (isalnum(c) || c == '_')
+			tblname[j] = c;
+		else if (c == '-')
+			tblname[j] = '_';
+		else if (c == '.') {
+			tblname[j] = '\0';
+			break;
+		} else {
+			printf("Invalid character '%c' in file name %s\n",
+					c, p);
+			free(tblname);
+			return NULL;
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
+	fprintf(outfp, "\t.vfm = 0,\n");
+	fprintf(outfp, "\t.version = 0,\n");
+	fprintf(outfp, "\t.type = 0,\n");
+	fprintf(outfp, "\t.table = 0,\n");
+	fprintf(outfp, "},\n");
+
+	/* and finally, the closing curly bracket for the struct */
+	fprintf(outfp, "};\n");
+}
+
+/*
+ * Process the JSON file @json_file and write a table of PMU events found in
+ * the JSON file to the outfp.
+ */
+static int process_json(FILE *outfp, const char *json_file)
+{
+	char *tblname;
+	int err;
+
+	/*
+	 * Drop file name suffix. Replace hyphens with underscores.
+	 * Fail if file name contains any alphanum characters besides
+	 * underscores.
+	 */
+	tblname = file_name_to_table_name((char *)json_file);
+	if (!tblname) {
+		printf("Error determining table name for %s\n", json_file);
+		return -1;
+	}
+
+	print_events_table_prefix(outfp, tblname);
+
+	err = json_events(json_file, print_events_table_entry, outfp);
+
+	if (err) {
+		printf("Translation failed\n");
+		_Exit(1);
+	}
+
+	print_events_table_suffix(outfp);
+
+	return 0;
+}
+
+static int process_mapfile(FILE *outfp, char *fpath)
+{
+	int n = 16384;
+	FILE *mapfp;
+	char *save;
+	char *line, *p;
+	int line_num;
+	char *tblname;
+
+	printf("Processing mapfile %s\n", fpath);
+
+	line = malloc(n);
+	if (!line)
+		return -1;
+
+	mapfp = fopen(fpath, "r");
+	if (!mapfp) {
+		printf("Error %s opening %s\n", strerror(errno), fpath);
+		return -1;
+	}
+
+	print_mapping_table_prefix(outfp);
+
+	line_num = 0;
+	while (1) {
+		char *vfm, *version, *type, *fname;
+
+		line_num++;
+		p = fgets(line, n, mapfp);
+		if (!p)
+			break;
+
+		if (line[0] == '#')
+			continue;
+
+		if (line[strlen(line)-1] != '\n') {
+			/* TODO Deal with lines longer than 16K */
+			printf("Mapfile %s: line %d too long, aborting\n",
+					fpath, line_num);
+			return -1;
+		}
+		line[strlen(line)-1] = '\0';
+
+		vfm = strtok_r(p, ",", &save);
+		version = strtok_r(NULL, ",", &save);
+		fname = strtok_r(NULL, ",", &save);
+		type = strtok_r(NULL, ",", &save);
+
+		tblname = file_name_to_table_name(fname);
+		fprintf(outfp, "{\n");
+		fprintf(outfp, "\t.vfm = \"%s\",\n", vfm);
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
+	printf("Creating empty pmu_events_map[] table\n");
+
+	/* Unlink file to clear any partial writes to it */
+	unlink(output_file);
+
+	outfp = fopen(output_file, "a");
+	if (!outfp) {
+		perror("fopen()");
+		_Exit(1);
+	}
+
+	fprintf(outfp, "#include \"pmu-events.h\"\n");
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
+FILE *eventsfp;
+char *mapfile;
+
+static int process_one_file(const char *fpath, const struct stat *sb,
+				int typeflag __maybe_unused,
+				struct FTW *ftwbuf __maybe_unused)
+{
+	char *bname;
+
+	if (!S_ISREG(sb->st_mode))
+		return 0;
+
+	/*
+	 * Save the mapfile name for now. We will process mapfile
+	 * after processing all JSON files (so we can write out the
+	 * mapping table after all PMU events tables).
+	 *
+	 * Allow for optional .csv on mapfile name.
+	 *
+	 * TODO: Allow for multiple mapfiles? Punt for now.
+	 */
+	bname = basename((char *)fpath);
+	if (!strncmp(bname, "mapfile", 7)) {
+		if (mapfile) {
+			printf("Multiple mapfiles? Using %s, ignoring %s\n",
+					mapfile, fpath);
+		} else {
+			mapfile = strdup(fpath);
+		}
+		return 0;
+	}
+
+	/*
+	 * If the file name does not have a .json extension,
+	 * ignore it. It could be a readme.txt for instance.
+	 */
+	bname += strlen(bname) - 5;
+	if (strncmp(bname, ".json", 5)) {
+		printf("Ignoring file without .json suffix %s\n", fpath);
+		return 0;
+	}
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
+	if (process_json(eventsfp, fpath)) {
+		printf("Error processing JSON file %s, ignoring all\n", fpath);
+		return -1;
+	}
+
+	return 0;
+}
+
+#ifndef PATH_MAX
+#define PATH_MAX	4096
+#endif
+
+/*
+ * Starting in directory 'start_dirname', find the "mapfile.csv" and
+ * the set of JSON files for this architecture.
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
+	int flags;
+	int maxfds;
+	const char *arch;
+	struct utsname uts;
+
+	char dirname[PATH_MAX];
+
+	const char *output_file = "pmu-events.c";
+	const char *start_dirname = "arch";
+
+	if (argc > 1)
+		start_dirname = argv[1];
+
+	if (argc > 2)
+		output_file = argv[2];
+
+	unlink(output_file);
+	eventsfp = fopen(output_file, "a");
+	if (!eventsfp) {
+		printf("%s Unable to create required file %s (%s)\n",
+				argv[0], output_file, strerror(errno));
+		_Exit(1);
+	}
+
+	rc = uname(&uts);
+	if (rc < 0) {
+		printf("%s: uname() failed: %s\n", argv[0], strerror(errno));
+		goto empty_map;
+	}
+
+	/* TODO: Add other flavors of machine type here */
+	if (!strcmp(uts.machine, "ppc64"))
+		arch = "powerpc";
+	else if (!strcmp(uts.machine, "i686"))
+		arch = "x86";
+	else if (!strcmp(uts.machine, "x86_64"))
+		arch = "x86";
+	else {
+		printf("%s: Unknown architecture %s\n", argv[0], uts.machine);
+		goto empty_map;
+	}
+
+	/* Include pmu-events.h first */
+	fprintf(eventsfp, "#include \"pmu-events.h\"\n");
+
+	sprintf(dirname, "%s/%s", start_dirname, arch);
+
+	/*
+	 * Treat symlinks of JSON files as regular files for now and create
+	 * separate tables for each symlink (presumably, each symlink refers
+	 * to specific version of the CPU).
+	 *
+	 * TODO: Maybe add another level of mapping if necessary to allow
+	 *	 several processor versions (i.e symlinks) share a table
+	 *	 of PMU events.
+	 */
+	maxfds = get_maxfds();
+	mapfile = NULL;
+	flags = FTW_DEPTH;
+	rc = nftw(dirname, process_one_file, maxfds, flags);
+	if (rc) {
+		printf("%s: Error walking file tree %s\n", argv[0], dirname);
+		goto empty_map;
+	}
+
+	if (!mapfile) {
+		printf("No CPU->JSON mapping?\n");
+		goto empty_map;
+	}
+
+	if (process_mapfile(eventsfp, mapfile)) {
+		printf("Error processing mapfile %s\n", mapfile);
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
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
new file mode 100644
index 0000000..a24faef
--- /dev/null
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -0,0 +1,39 @@
+#ifndef PMU_EVENTS_H
+#define PMU_EVENTS_H
+
+/*
+ * Describe each PMU event. Each CPU has a table of these
+ * events.
+ */
+struct pmu_event {
+	const char *name;
+	const char *event;
+	const char *desc;
+};
+
+/*
+ *
+ * Map a CPU to its table of PMU events. The CPU is identified, in
+ * an arch-specific manner, in arch_pmu_events_match_cpu(), by one
+ * or more of the following attributes:
+ *
+ *	vendor, family, model, revision, type
+ *
+ * TODO: Split vfm into individual fields or leave it to architectures
+ *	 to split it with an alternate delimiter like hyphen in the
+ *	 mapfile?
+ */
+struct pmu_events_map {
+	const char *vfm;		/* vendor, family, model */
+	const char *version;
+	const char *type;		/* core, uncore etc */
+	struct pmu_event *table;
+};
+
+/*
+ * Global table mapping each known CPU for the architecture to its
+ * table of PMU-Events.
+ */
+extern struct pmu_events_map pmu_events_map[];
+
+#endif
-- 
1.7.9.5
