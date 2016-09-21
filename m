Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfPGZ0YmrzDsgq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:50:29 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8LFo5iX092311
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 11:50:27 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25kkrsjck9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 11:50:24 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Thu, 22 Sep 2016 01:50:11 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BC20B357805B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:50:08 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8LFo8tW3473786
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:50:08 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8LFo7d4006058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:50:08 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, acme@kernel.org, kim.phillips@arm.com
Cc: linuxppc-dev@lists.ozlabs.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, treeze.taeung@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, markus@trippelsdorf.de,
 namhyung@kernel.org, pawel.moll@arm.com, chris.ryder@arm.com,
 jolsa@kernel.org, mhiramat@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v7 1/6] perf annotate: Add cross arch annotate support
Date: Wed, 21 Sep 2016 21:17:51 +0530
In-Reply-To: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1474472876-2706-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change current data structures and function to enable cross arch
annotate.

Current perf implementation does not support cross arch annotate.
To make it truly cross arch, instruction table of all arch should
be present in perf binary. And use appropriate table based on arch
where perf.data was recorded.

Record on arm:
  $ ./perf record -a

Report -> Annotate on x86:
  $ ./perf report -i perf.data.arm --vmlinux vmlinux.arm

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
Changes in v7:
  - Make norm_arch as global var instead of passing them to each parser.
  - Address other review comments.

 tools/perf/builtin-top.c          |   2 +-
 tools/perf/ui/browsers/annotate.c |   3 +-
 tools/perf/ui/gtk/annotate.c      |   2 +-
 tools/perf/util/annotate.c        | 151 ++++++++++++++++++++++++++++++++------
 tools/perf/util/annotate.h        |   3 +-
 5 files changed, 134 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 4007857..41ecdd6 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -129,7 +129,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__disassemble(sym, map, 0);
+	err = symbol__disassemble(sym, map, 0, NULL);
 	if (err == 0) {
 out_assign:
 		top->sym_filter_entry = he;
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 4c18271..214a14a 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -1050,7 +1050,8 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 		  (nr_pcnt - 1);
 	}
 
-	err = symbol__disassemble(sym, map, sizeof_bdl);
+	err = symbol__disassemble(sym, map, sizeof_bdl,
+				  perf_evsel__env_arch(evsel));
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 42d3199..c127aba 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -167,7 +167,7 @@ static int symbol__gtk_annotate(struct symbol *sym, struct map *map,
 	if (map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__disassemble(sym, map, 0);
+	err = symbol__disassemble(sym, map, 0, perf_evsel__env_arch(evsel));
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index aeb5a44..816aa2c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -21,10 +21,13 @@
 #include <regex.h>
 #include <pthread.h>
 #include <linux/bitops.h>
+#include <sys/utsname.h>
+#include "../arch/common.h"
 
 const char 	*disassembler_style;
 const char	*objdump_path;
 static regex_t	 file_lineno;
+static char	*norm_arch;
 
 static struct ins *ins__find(const char *name);
 static int disasm_line__parse(char *line, char **namep, char **rawp);
@@ -66,10 +69,8 @@ static int call__parse(struct ins_operands *ops, struct map *map)
 
 	name++;
 
-#ifdef __arm__
-	if (strchr(name, '+'))
+	if (!strcmp(norm_arch, "arm") && strchr(name, '+'))
 		return -1;
-#endif
 
 	tok = strchr(name, '>');
 	if (tok == NULL)
@@ -252,16 +253,12 @@ static int mov__parse(struct ins_operands *ops, struct map *map __maybe_unused)
 		return -1;
 
 	target = ++s;
-#ifdef __arm__
+
 	comment = strchr(s, ';');
-#else
-	comment = strchr(s, '#');
-#endif
+	if (comment == NULL)
+		comment = strchr(s, '#');
 
-	if (comment != NULL)
-		s = comment - 1;
-	else
-		s = strchr(s, '\0') - 1;
+	s = (comment != NULL) ? comment - 1 : strchr(s, '\0') - 1;
 
 	while (s > target && isspace(s[0]))
 		--s;
@@ -364,14 +361,92 @@ bool ins__is_ret(const struct ins *ins)
 	return ins->ops == &ret_ops;
 }
 
-static struct ins instructions[] = {
+static struct ins instructions_x86[] = {
 	{ .name = "add",   .ops  = &mov_ops, },
 	{ .name = "addl",  .ops  = &mov_ops, },
 	{ .name = "addq",  .ops  = &mov_ops, },
 	{ .name = "addw",  .ops  = &mov_ops, },
 	{ .name = "and",   .ops  = &mov_ops, },
-#ifdef __arm__
-	{ .name = "b",     .ops  = &jump_ops, }, // might also be a call
+	{ .name = "bts",   .ops  = &mov_ops, },
+	{ .name = "call",  .ops  = &call_ops, },
+	{ .name = "callq", .ops  = &call_ops, },
+	{ .name = "cmp",   .ops  = &mov_ops, },
+	{ .name = "cmpb",  .ops  = &mov_ops, },
+	{ .name = "cmpl",  .ops  = &mov_ops, },
+	{ .name = "cmpq",  .ops  = &mov_ops, },
+	{ .name = "cmpw",  .ops  = &mov_ops, },
+	{ .name = "cmpxch", .ops  = &mov_ops, },
+	{ .name = "dec",   .ops  = &dec_ops, },
+	{ .name = "decl",  .ops  = &dec_ops, },
+	{ .name = "imul",  .ops  = &mov_ops, },
+	{ .name = "inc",   .ops  = &dec_ops, },
+	{ .name = "incl",  .ops  = &dec_ops, },
+	{ .name = "ja",	   .ops  = &jump_ops, },
+	{ .name = "jae",   .ops  = &jump_ops, },
+	{ .name = "jb",	   .ops  = &jump_ops, },
+	{ .name = "jbe",   .ops  = &jump_ops, },
+	{ .name = "jc",	   .ops  = &jump_ops, },
+	{ .name = "jcxz",  .ops  = &jump_ops, },
+	{ .name = "je",	   .ops  = &jump_ops, },
+	{ .name = "jecxz", .ops  = &jump_ops, },
+	{ .name = "jg",	   .ops  = &jump_ops, },
+	{ .name = "jge",   .ops  = &jump_ops, },
+	{ .name = "jl",    .ops  = &jump_ops, },
+	{ .name = "jle",   .ops  = &jump_ops, },
+	{ .name = "jmp",   .ops  = &jump_ops, },
+	{ .name = "jmpq",  .ops  = &jump_ops, },
+	{ .name = "jna",   .ops  = &jump_ops, },
+	{ .name = "jnae",  .ops  = &jump_ops, },
+	{ .name = "jnb",   .ops  = &jump_ops, },
+	{ .name = "jnbe",  .ops  = &jump_ops, },
+	{ .name = "jnc",   .ops  = &jump_ops, },
+	{ .name = "jne",   .ops  = &jump_ops, },
+	{ .name = "jng",   .ops  = &jump_ops, },
+	{ .name = "jnge",  .ops  = &jump_ops, },
+	{ .name = "jnl",   .ops  = &jump_ops, },
+	{ .name = "jnle",  .ops  = &jump_ops, },
+	{ .name = "jno",   .ops  = &jump_ops, },
+	{ .name = "jnp",   .ops  = &jump_ops, },
+	{ .name = "jns",   .ops  = &jump_ops, },
+	{ .name = "jnz",   .ops  = &jump_ops, },
+	{ .name = "jo",	   .ops  = &jump_ops, },
+	{ .name = "jp",	   .ops  = &jump_ops, },
+	{ .name = "jpe",   .ops  = &jump_ops, },
+	{ .name = "jpo",   .ops  = &jump_ops, },
+	{ .name = "jrcxz", .ops  = &jump_ops, },
+	{ .name = "js",	   .ops  = &jump_ops, },
+	{ .name = "jz",	   .ops  = &jump_ops, },
+	{ .name = "lea",   .ops  = &mov_ops, },
+	{ .name = "lock",  .ops  = &lock_ops, },
+	{ .name = "mov",   .ops  = &mov_ops, },
+	{ .name = "movb",  .ops  = &mov_ops, },
+	{ .name = "movdqa", .ops  = &mov_ops, },
+	{ .name = "movl",  .ops  = &mov_ops, },
+	{ .name = "movq",  .ops  = &mov_ops, },
+	{ .name = "movslq", .ops  = &mov_ops, },
+	{ .name = "movzbl", .ops  = &mov_ops, },
+	{ .name = "movzwl", .ops  = &mov_ops, },
+	{ .name = "nop",   .ops  = &nop_ops, },
+	{ .name = "nopl",  .ops  = &nop_ops, },
+	{ .name = "nopw",  .ops  = &nop_ops, },
+	{ .name = "or",    .ops  = &mov_ops, },
+	{ .name = "orl",   .ops  = &mov_ops, },
+	{ .name = "test",  .ops  = &mov_ops, },
+	{ .name = "testb", .ops  = &mov_ops, },
+	{ .name = "testl", .ops  = &mov_ops, },
+	{ .name = "xadd",  .ops  = &mov_ops, },
+	{ .name = "xbeginl", .ops  = &jump_ops, },
+	{ .name = "xbeginq", .ops  = &jump_ops, },
+	{ .name = "retq",  .ops  = &ret_ops, },
+};
+
+static struct ins instructions_arm[] = {
+	{ .name = "add",   .ops  = &mov_ops, },
+	{ .name = "addl",  .ops  = &mov_ops, },
+	{ .name = "addq",  .ops  = &mov_ops, },
+	{ .name = "addw",  .ops  = &mov_ops, },
+	{ .name = "and",   .ops  = &mov_ops, },
+	{ .name = "b",     .ops  = &jump_ops, }, /* might also be a call */
 	{ .name = "bcc",   .ops  = &jump_ops, },
 	{ .name = "bcs",   .ops  = &jump_ops, },
 	{ .name = "beq",   .ops  = &jump_ops, },
@@ -383,7 +458,6 @@ static struct ins instructions[] = {
 	{ .name = "blt",   .ops  = &jump_ops, },
 	{ .name = "blx",   .ops  = &call_ops, },
 	{ .name = "bne",   .ops  = &jump_ops, },
-#endif
 	{ .name = "bts",   .ops  = &mov_ops, },
 	{ .name = "call",  .ops  = &call_ops, },
 	{ .name = "callq", .ops  = &call_ops, },
@@ -472,24 +546,48 @@ static int ins__cmp(const void *a, const void *b)
 	return strcmp(ia->name, ib->name);
 }
 
-static void ins__sort(void)
+static void ins__sort(struct ins *instructions, int nmemb)
 {
-	const int nmemb = ARRAY_SIZE(instructions);
-
 	qsort(instructions, nmemb, sizeof(struct ins), ins__cmp);
 }
 
+static const char *annotate__norm_arch(char *arch)
+{
+	struct utsname uts;
+
+	if (!arch) { /* Assume we are annotating locally. */
+		if (uname(&uts) < 0)
+			return NULL;
+		arch = uts.machine;
+	}
+	return normalize_arch(arch);
+}
+
 static struct ins *ins__find(const char *name)
 {
-	const int nmemb = ARRAY_SIZE(instructions);
 	static bool sorted;
+	struct ins *instructions;
+	int nmemb;
 
 	if (!sorted) {
-		ins__sort();
+		ins__sort(instructions_x86, ARRAY_SIZE(instructions_x86));
+		ins__sort(instructions_arm, ARRAY_SIZE(instructions_arm));
 		sorted = true;
 	}
 
-	return bsearch(name, instructions, nmemb, sizeof(struct ins), ins__key_cmp);
+	if (!strcmp(norm_arch, "x86")) {
+		instructions = instructions_x86;
+		nmemb = ARRAY_SIZE(instructions_x86);
+	} else if (!strcmp(norm_arch, "arm")) {
+		instructions = instructions_arm;
+		nmemb = ARRAY_SIZE(instructions_arm);
+	} else {
+		pr_err("perf annotate not supported by %s arch\n", norm_arch);
+		return NULL;
+	}
+
+	return bsearch(name, instructions, nmemb, sizeof(struct ins),
+			ins__key_cmp);
 }
 
 int symbol__alloc_hist(struct symbol *sym)
@@ -1280,7 +1378,8 @@ fallback:
 	return 0;
 }
 
-int symbol__disassemble(struct symbol *sym, struct map *map, size_t privsize)
+int symbol__disassemble(struct symbol *sym, struct map *map, size_t privsize,
+			char *arch)
 {
 	struct dso *dso = map->dso;
 	char command[PATH_MAX * 2];
@@ -1297,6 +1396,12 @@ int symbol__disassemble(struct symbol *sym, struct map *map, size_t privsize)
 	if (err)
 		return err;
 
+	norm_arch = (char *) annotate__norm_arch(arch);
+	if (!norm_arch) {
+		pr_err("Can not annotate. Could not determine architecture.");
+		return -1;
+	}
+
 	pr_debug("%s: filename=%s, sym=%s, start=%#" PRIx64 ", end=%#" PRIx64 "\n", __func__,
 		 symfs_filename, sym->name, map->unmap_ip(map, sym->start),
 		 map->unmap_ip(map, sym->end));
@@ -1793,7 +1898,7 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 	struct rb_root source_line = RB_ROOT;
 	u64 len;
 
-	if (symbol__disassemble(sym, map, 0) < 0)
+	if (symbol__disassemble(sym, map, 0, perf_evsel__env_arch(evsel)) < 0)
 		return -1;
 
 	len = symbol__size(sym);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 5bbcec1..4400269 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -156,7 +156,8 @@ int hist_entry__inc_addr_samples(struct hist_entry *he, int evidx, u64 addr);
 int symbol__alloc_hist(struct symbol *sym);
 void symbol__annotate_zero_histograms(struct symbol *sym);
 
-int symbol__disassemble(struct symbol *sym, struct map *map, size_t privsize);
+int symbol__disassemble(struct symbol *sym, struct map *map, size_t privsize,
+			char *arch);
 
 enum symbol_disassemble_errno {
 	SYMBOL_ANNOTATE_ERRNO__SUCCESS		= 0,
-- 
2.5.5
