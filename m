Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A8BA1A0E01
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 07:24:08 +1000 (AEST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 27 May 2015 15:24:06 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 73E5119D8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 15:15:05 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4RLO3ce37224488
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 14:24:03 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4RLO2WC012076
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 15:24:03 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/10] jevents: Program to convert JSON file to C style file
Date: Wed, 27 May 2015 14:23:21 -0700
Message-Id: <1432761809-4344-3-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
v9: [Sukadev Bhattiprolu/Andi Kleen] Rename ->vfm to ->cpuid and use
	that field to encode the PVR in Power.
	Allow blank lines in mapfile.
	[Jiri Olsa] Pass ARCH as a parameter to jevents so we don't have
	to detect it.
	[Jiri Olsa] Use the infrastrastructure to build pmu-events/perf
	(Makefile changes from Jiri included in this patch).
	[Jiri Olsa, Andi Kleen] Detect changes to JSON files and rebuild
	pmu-events.o only if necessary.
---
 tools/perf/Makefile.perf           |   25 +-
 tools/perf/pmu-events/Build        |   10 +
 tools/perf/pmu-events/README       |   67 ++++
 tools/perf/pmu-events/jevents.c    |  684 ++++++++++++++++++++++++++++++++++++
 tools/perf/pmu-events/jevents.h    |   17 +
 tools/perf/pmu-events/pmu-events.h |   35 ++
 6 files changed, 834 insertions(+), 4 deletions(-)
 create mode 100644 tools/perf/pmu-events/Build
 create mode 100644 tools/perf/pmu-events/README
 create mode 100644 tools/perf/pmu-events/jevents.c
 create mode 100644 tools/perf/pmu-events/jevents.h
 create mode 100644 tools/perf/pmu-events/pmu-events.h

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c43a205..b4752067 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -270,14 +270,29 @@ strip: $(PROGRAMS) $(OUTPUT)perf
 
 PERF_IN := $(OUTPUT)perf-in.o
 
+JEVENTS       := $(OUTPUT)pmu-events/jevents
+JEVENTS_IN    := $(OUTPUT)pmu-events/jevents-in.o
+PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
+
+export JEVENTS
+
 export srctree OUTPUT RM CC LD AR CFLAGS V BISON FLEX
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 
 $(PERF_IN): $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h FORCE
 	$(Q)$(MAKE) $(build)=perf
 
-$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN)
-	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(PERF_IN) $(LIBS) -o $@
+$(JEVENTS_IN): FORCE
+	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=jevents
+
+$(JEVENTS): $(JEVENTS_IN)
+	$(QUIET_LINK)$(CC) $(JEVENTS_IN) -o $@
+
+$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
+
+$(PMU_EVENTS_IN): $(JEVENTS) FORCE
+	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
 $(GTK_IN): FORCE
 	$(Q)$(MAKE) $(build)=gtk
@@ -306,6 +321,8 @@ perf.spec $(SCRIPTS) \
 ifneq ($(OUTPUT),)
 %.o: $(OUTPUT)%.o
 	@echo "    # Redirected target $@ => $(OUTPUT)$@"
+pmu-events/%.o: $(OUTPUT)pmu-events/%.o
+	@echo "    # Redirected target $@ => $(OUTPUT)$@"
 util/%.o: $(OUTPUT)util/%.o
 	@echo "    # Redirected target $@ => $(OUTPUT)$@"
 bench/%.o: $(OUTPUT)bench/%.o
@@ -529,8 +546,8 @@ clean: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean config-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIB_FILE) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(LANG_BINDINGS)
 	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) .config-detected
-	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32
-	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex*
+	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32 $(OUTPUT)pmu-events/jevents $(srctree)/tools/perf/pmu-events/pmu-events.c
+	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* $(OUTPUT)pmu-events/pmu-events.c
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
 	$(python-clean)
 
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
new file mode 100644
index 0000000..7e0c85c
--- /dev/null
+++ b/tools/perf/pmu-events/Build
@@ -0,0 +1,10 @@
+jevents-y	+= json.o jsmn.o jevents.o
+pmu-events-y	+= pmu-events.o
+JSON		=  $(shell find pmu-events/arch/$(ARCH) -name '*.json')
+
+#
+# Locate/process JSON files in pmu-events/arch/
+# directory and create tables in pmu-events.c.
+#
+$(OUTPUT)pmu-events/pmu-events.c: $(JSON)
+	$(Q)$(call echo-cmd,gen)$(JEVENTS) $(ARCH) pmu-events/arch $(OUTPUT)pmu-events/pmu-events.c
diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
new file mode 100644
index 0000000..3d362fb
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
+	CPUID,Version,JSON/file/path/name,Type
+
+where:
+
+	Comma:
+		is the required field delimiter (i.e other fields cannot
+		have commas within them)
+
+	CPUID:
+		represents is an arch-specific CPUID for the set of CPUs
+		that use the PMU events specified in JSON/file/path/name.
+		(Multiple CPU ids can point to the same JSON/file/path/name)
+
+	Version:
+		is the Version of the mapfile.
+
+	JSON/file/path/name:
+		is the pathname for the JSON file, relative to the directory
+		containing the mapfile.
+
+	Type:
+		indicates whether the events or "core" or "uncore" events.
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
new file mode 100644
index 0000000..03f7b65
--- /dev/null
+++ b/tools/perf/pmu-events/jevents.c
@@ -0,0 +1,684 @@
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
+			printf("Mapfile %s: line %d too long, aborting\n",
+					fpath, line_num);
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
+	int flags;
+	int maxfds;
+	char dirname[PATH_MAX];
+
+	const char *arch;
+	const char *output_file;
+	const char *start_dirname;
+
+	if (argc < 4) {
+		printf("Usage: %s <arch> <starting_dir> <output_file>\n",
+				argv[0]);
+		return 1;
+	}
+
+	arch = argv[1];
+	start_dirname = argv[2];
+	output_file = argv[3];
+
+	unlink(output_file);
+	eventsfp = fopen(output_file, "a");
+	if (!eventsfp) {
+		printf("%s Unable to create required file %s (%s)\n",
+				argv[0], output_file, strerror(errno));
+		return 2;
+	}
+
+	/* Include pmu-events.h first */
+	fprintf(eventsfp, "#include \"../../pmu-events/pmu-events.h\"\n");
+
+	sprintf(dirname, "%s/%s", start_dirname, arch);
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
+	flags = FTW_DEPTH;
+
+	maxfds = get_maxfds();
+	mapfile = NULL;
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
index 0000000..39fec04
--- /dev/null
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -0,0 +1,35 @@
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
1.7.9.5
