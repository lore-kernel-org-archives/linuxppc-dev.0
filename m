Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm1yK3SGtzDr5n
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 14:40:41 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u684dPUh127826
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 00:40:39 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xnwd6h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Jul 2016 00:40:39 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Fri, 8 Jul 2016 14:40:36 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 978012CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 14:40:32 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u684eWA05898704
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 14:40:32 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u684eVjv010654
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 14:40:32 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, acme@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: anton@ozlabs.org, mpe@ellerman.id.au, ananth@in.ibm.com, dja@axtens.net,
 naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.vnet.ibm.com,
 David.Laight@ACULAB.COM, rmk+kernel@arm.linux.org.uk
Subject: [PATCH v4 2/3] perf annotate: Enable cross arch annotate
Date: Fri,  8 Jul 2016 10:10:12 +0530
In-Reply-To: <1467952813-5797-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1467952813-5797-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1467952813-5797-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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

Current implementation does not contain logic of record on one arch
and annotating on other. This remote annotate is partially possible
with current implementation for x86 (or may be arm as well) only.
But, to make remote annotation work properly, all architecture
instruction tables need to be included in the perf binary. And while
annotating, look for instruction table where perf.data was recorded.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
Changes in v4:
  - __maybe_unused was misplaced at few location. Corrected it

 tools/perf/builtin-top.c          |   2 +-
 tools/perf/ui/browsers/annotate.c |   3 +-
 tools/perf/ui/gtk/annotate.c      |   2 +-
 tools/perf/util/annotate.c        | 134 ++++++++++++++++++++++++--------------
 tools/perf/util/annotate.h        |   5 +-
 5 files changed, 93 insertions(+), 53 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 07fc792..d4fd947 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -128,7 +128,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__annotate(sym, map, 0);
+	err = symbol__annotate(sym, map, 0, NULL);
 	if (err == 0) {
 out_assign:
 		top->sym_filter_entry = he;
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 29dc6d2..3a652a6f 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -1050,7 +1050,8 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 		  (nr_pcnt - 1);
 	}
 
-	if (symbol__annotate(sym, map, sizeof_bdl) < 0) {
+	if (symbol__annotate(sym, map, sizeof_bdl,
+			     perf_evsel__env_arch(evsel)) < 0) {
 		ui__error("%s", ui_helpline__last_msg);
 		goto out_free_offsets;
 	}
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 9c7ff8d..d7150b3 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -166,7 +166,7 @@ static int symbol__gtk_annotate(struct symbol *sym, struct map *map,
 	if (map->dso->annotate_warned)
 		return -1;
 
-	if (symbol__annotate(sym, map, 0) < 0) {
+	if (symbol__annotate(sym, map, 0, perf_evsel__env_arch(evsel)) < 0) {
 		ui__error("%s", ui_helpline__current);
 		return -1;
 	}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e9825fe..32889ce 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -20,12 +20,14 @@
 #include <regex.h>
 #include <pthread.h>
 #include <linux/bitops.h>
+#include <sys/utsname.h>
+#include "../arch/common.h"
 
 const char 	*disassembler_style;
 const char	*objdump_path;
 static regex_t	 file_lineno;
 
-static struct ins *ins__find(const char *name);
+static struct ins *ins__find(const char *name, const char *norm_arch);
 static int disasm_line__parse(char *line, char **namep, char **rawp);
 
 static void ins__delete(struct ins_operands *ops)
@@ -53,7 +55,7 @@ int ins__scnprintf(struct ins *ins, char *bf, size_t size,
 	return ins__raw_scnprintf(ins, bf, size, ops);
 }
 
-static int call__parse(struct ins_operands *ops)
+static int call__parse(struct ins_operands *ops, const char *norm_arch)
 {
 	char *endptr, *tok, *name;
 
@@ -65,10 +67,8 @@ static int call__parse(struct ins_operands *ops)
 
 	name++;
 
-#ifdef __arm__
-	if (strchr(name, '+'))
+	if (!strcmp(norm_arch, NORM_ARM) && strchr(name, '+'))
 		return -1;
-#endif
 
 	tok = strchr(name, '>');
 	if (tok == NULL)
@@ -117,7 +117,8 @@ bool ins__is_call(const struct ins *ins)
 	return ins->ops == &call_ops;
 }
 
-static int jump__parse(struct ins_operands *ops)
+static int jump__parse(struct ins_operands *ops,
+		       const char *norm_arch __maybe_unused)
 {
 	const char *s = strchr(ops->raw, '+');
 
@@ -172,7 +173,7 @@ static int comment__symbol(char *raw, char *comment, u64 *addrp, char **namep)
 	return 0;
 }
 
-static int lock__parse(struct ins_operands *ops)
+static int lock__parse(struct ins_operands *ops, const char *norm_arch)
 {
 	char *name;
 
@@ -183,7 +184,7 @@ static int lock__parse(struct ins_operands *ops)
 	if (disasm_line__parse(ops->raw, &name, &ops->locked.ops->raw) < 0)
 		goto out_free_ops;
 
-	ops->locked.ins = ins__find(name);
+	ops->locked.ins = ins__find(name, norm_arch);
 	free(name);
 
 	if (ops->locked.ins == NULL)
@@ -193,7 +194,7 @@ static int lock__parse(struct ins_operands *ops)
 		return 0;
 
 	if (ops->locked.ins->ops->parse &&
-	    ops->locked.ins->ops->parse(ops->locked.ops) < 0)
+	    ops->locked.ins->ops->parse(ops->locked.ops, norm_arch) < 0)
 		goto out_free_ops;
 
 	return 0;
@@ -236,7 +237,7 @@ static struct ins_ops lock_ops = {
 	.scnprintf = lock__scnprintf,
 };
 
-static int mov__parse(struct ins_operands *ops)
+static int mov__parse(struct ins_operands *ops, const char *norm_arch)
 {
 	char *s = strchr(ops->raw, ','), *target, *comment, prev;
 
@@ -251,11 +252,11 @@ static int mov__parse(struct ins_operands *ops)
 		return -1;
 
 	target = ++s;
-#ifdef __arm__
-	comment = strchr(s, ';');
-#else
-	comment = strchr(s, '#');
-#endif
+
+	if (!strcmp(norm_arch, NORM_ARM))
+		comment = strchr(s, ';');
+	else
+		comment = strchr(s, '#');
 
 	if (comment != NULL)
 		s = comment - 1;
@@ -303,7 +304,8 @@ static struct ins_ops mov_ops = {
 	.scnprintf = mov__scnprintf,
 };
 
-static int dec__parse(struct ins_operands *ops)
+static int dec__parse(struct ins_operands *ops,
+		      const char *norm_arch __maybe_unused)
 {
 	char *target, *comment, *s, prev;
 
@@ -363,26 +365,12 @@ bool ins__is_ret(const struct ins *ins)
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
-	{ .name = "bcc",   .ops  = &jump_ops, },
-	{ .name = "bcs",   .ops  = &jump_ops, },
-	{ .name = "beq",   .ops  = &jump_ops, },
-	{ .name = "bge",   .ops  = &jump_ops, },
-	{ .name = "bgt",   .ops  = &jump_ops, },
-	{ .name = "bhi",   .ops  = &jump_ops, },
-	{ .name = "bl",    .ops  = &call_ops, },
-	{ .name = "bls",   .ops  = &jump_ops, },
-	{ .name = "blt",   .ops  = &jump_ops, },
-	{ .name = "blx",   .ops  = &call_ops, },
-	{ .name = "bne",   .ops  = &jump_ops, },
-#endif
 	{ .name = "bts",   .ops  = &mov_ops, },
 	{ .name = "call",  .ops  = &call_ops, },
 	{ .name = "callq", .ops  = &call_ops, },
@@ -456,6 +444,21 @@ static struct ins instructions[] = {
 	{ .name = "retq",  .ops  = &ret_ops, },
 };
 
+static struct ins instructions_arm[] = {
+	{ .name = "b",     .ops  = &jump_ops, }, /* might also be a call */
+	{ .name = "bcc",   .ops  = &jump_ops, },
+	{ .name = "bcs",   .ops  = &jump_ops, },
+	{ .name = "beq",   .ops  = &jump_ops, },
+	{ .name = "bge",   .ops  = &jump_ops, },
+	{ .name = "bgt",   .ops  = &jump_ops, },
+	{ .name = "bhi",   .ops  = &jump_ops, },
+	{ .name = "bl",    .ops  = &call_ops, },
+	{ .name = "bls",   .ops  = &jump_ops, },
+	{ .name = "blt",   .ops  = &jump_ops, },
+	{ .name = "blx",   .ops  = &call_ops, },
+	{ .name = "bne",   .ops  = &jump_ops, },
+};
+
 static int ins__key_cmp(const void *name, const void *insp)
 {
 	const struct ins *ins = insp;
@@ -471,24 +474,48 @@ static int ins__cmp(const void *a, const void *b)
 	return strcmp(ia->name, ib->name);
 }
 
-static void ins__sort(void)
+static void ins__sort(struct ins *instructions, int nmemb)
 {
-	const int nmemb = ARRAY_SIZE(instructions);
-
 	qsort(instructions, nmemb, sizeof(struct ins), ins__cmp);
 }
 
-static struct ins *ins__find(const char *name)
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
+static struct ins *ins__find(const char *name, const char *norm_arch)
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
+	if (!strcmp(norm_arch, NORM_X86)) {
+		instructions = instructions_x86;
+		nmemb = ARRAY_SIZE(instructions_x86);
+	} else if (!strcmp(norm_arch, NORM_ARM)) {
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
 
 int symbol__annotate_init(struct map *map __maybe_unused, struct symbol *sym)
@@ -715,9 +742,16 @@ int hist_entry__inc_addr_samples(struct hist_entry *he, int evidx, u64 ip)
 	return symbol__inc_addr_samples(he->ms.sym, he->ms.map, evidx, ip);
 }
 
-static void disasm_line__init_ins(struct disasm_line *dl)
+static void disasm_line__init_ins(struct disasm_line *dl, char *arch)
 {
-	dl->ins = ins__find(dl->name);
+	const char *norm_arch = annotate__norm_arch(arch);
+
+	if (!norm_arch) {
+		pr_err("Can not annotate. Could not determine architecture.");
+		return;
+	}
+
+	dl->ins = ins__find(dl->name, norm_arch);
 
 	if (dl->ins == NULL)
 		return;
@@ -725,7 +759,8 @@ static void disasm_line__init_ins(struct disasm_line *dl)
 	if (!dl->ins->ops)
 		return;
 
-	if (dl->ins->ops->parse && dl->ins->ops->parse(&dl->ops) < 0)
+	if (dl->ins->ops->parse &&
+	    dl->ins->ops->parse(&dl->ops, norm_arch) < 0)
 		dl->ins = NULL;
 }
 
@@ -767,7 +802,8 @@ out_free_name:
 }
 
 static struct disasm_line *disasm_line__new(s64 offset, char *line,
-					size_t privsize, int line_nr)
+					size_t privsize, int line_nr,
+					char *arch)
 {
 	struct disasm_line *dl = zalloc(sizeof(*dl) + privsize);
 
@@ -782,7 +818,7 @@ static struct disasm_line *disasm_line__new(s64 offset, char *line,
 			if (disasm_line__parse(dl->line, &dl->name, &dl->ops.raw) < 0)
 				goto out_free_line;
 
-			disasm_line__init_ins(dl);
+			disasm_line__init_ins(dl, arch);
 		}
 	}
 
@@ -1005,7 +1041,7 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
  */
 static int symbol__parse_objdump_line(struct symbol *sym, struct map *map,
 				      FILE *file, size_t privsize,
-				      int *line_nr)
+				      int *line_nr, char *arch)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct disasm_line *dl;
@@ -1066,7 +1102,8 @@ static int symbol__parse_objdump_line(struct symbol *sym, struct map *map,
 			parsed_line = tmp2 + 1;
 	}
 
-	dl = disasm_line__new(offset, parsed_line, privsize, *line_nr);
+	dl = disasm_line__new(offset, parsed_line, privsize,
+				*line_nr, arch);
 	free(line);
 	(*line_nr)++;
 
@@ -1123,7 +1160,8 @@ static void delete_last_nop(struct symbol *sym)
 	}
 }
 
-int symbol__annotate(struct symbol *sym, struct map *map, size_t privsize)
+int symbol__annotate(struct symbol *sym, struct map *map, size_t privsize,
+		     char *arch)
 {
 	struct dso *dso = map->dso;
 	char *filename = dso__build_id_filename(dso, NULL, 0);
@@ -1271,7 +1309,7 @@ fallback:
 	nline = 0;
 	while (!feof(file)) {
 		if (symbol__parse_objdump_line(sym, map, file, privsize,
-			    &lineno) < 0)
+			    &lineno, arch) < 0)
 			break;
 		nline++;
 	}
@@ -1663,7 +1701,7 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 	struct rb_root source_line = RB_ROOT;
 	u64 len;
 
-	if (symbol__annotate(sym, map, 0) < 0)
+	if (symbol__annotate(sym, map, 0, perf_evsel__env_arch(evsel)) < 0)
 		return -1;
 
 	len = symbol__size(sym);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index a23084f..4902138 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -36,7 +36,7 @@ struct ins_operands {
 
 struct ins_ops {
 	void (*free)(struct ins_operands *ops);
-	int (*parse)(struct ins_operands *ops);
+	int (*parse)(struct ins_operands *ops, const char *norm_arch);
 	int (*scnprintf)(struct ins *ins, char *bf, size_t size,
 			 struct ins_operands *ops);
 };
@@ -155,7 +155,8 @@ int hist_entry__inc_addr_samples(struct hist_entry *he, int evidx, u64 addr);
 int symbol__alloc_hist(struct symbol *sym);
 void symbol__annotate_zero_histograms(struct symbol *sym);
 
-int symbol__annotate(struct symbol *sym, struct map *map, size_t privsize);
+int symbol__annotate(struct symbol *sym, struct map *map, size_t privsize,
+		     char *arch);
 
 int symbol__annotate_init(struct map *map, struct symbol *sym);
 int symbol__annotate_printf(struct symbol *sym, struct map *map,
-- 
2.5.5
