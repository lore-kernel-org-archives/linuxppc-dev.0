Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sG33T49DNzDr7v
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 23:00:21 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7JCxEKi121666
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 09:00:19 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24wqk5gw1e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 09:00:18 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Fri, 19 Aug 2016 23:00:15 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3BF7F3578057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 23:00:12 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7JD0CDO31850534
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 23:00:12 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7JD098a020137
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 23:00:12 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
 treeze.taeung@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 markus@trippelsdorf.de, chris.ryder@arm.com, pawel.moll@arm.com,
 mhiramat@kernel.org, rmk+kernel@arm.linux.org.uk, jolsa@kernel.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com, namhyung@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v6 2/7] perf annotate: Add cross arch annotate support
Date: Fri, 19 Aug 2016 18:29:33 +0530
In-Reply-To: <1471611578-11255-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1471611578-11255-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1471611578-11255-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
Changes in v6:
  - Instead of adding only those instructions defined in #ifdef __arm__,
    add all instructions from default table to arm table.

 tools/perf/builtin-top.c          |   2 +-
 tools/perf/ui/browsers/annotate.c |   3 +-
 tools/perf/ui/gtk/annotate.c      |   2 +-
 tools/perf/util/annotate.c        | 187 ++++++++++++++++++++++++++++++--------
 tools/perf/util/annotate.h        |   5 +-
 5 files changed, 157 insertions(+), 42 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a3223aa..fdd4203 100644
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
index 2e2d100..21c5e10 100644
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
index 25a9259..14a8808 100644
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
 
@@ -363,14 +365,92 @@ bool ins__is_ret(const struct ins *ins)
 	return ins->ops == &ret_ops;
 }
 
-static struct ins instructions[] = {
+static struct ins instructions_x86[] = {
+	{ .name = "add",   .ops  = &mov_ops, },
+	{ .name = "addl",  .ops  = &mov_ops, },
+	{ .name = "addq",  .ops  = &mov_ops, },
+	{ .name = "addw",  .ops  = &mov_ops, },
+	{ .name = "and",   .ops  = &mov_ops, },
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
 	{ .name = "add",   .ops  = &mov_ops, },
 	{ .name = "addl",  .ops  = &mov_ops, },
 	{ .name = "addq",  .ops  = &mov_ops, },
 	{ .name = "addw",  .ops  = &mov_ops, },
 	{ .name = "and",   .ops  = &mov_ops, },
-#ifdef __arm__
-	{ .name = "b",     .ops  = &jump_ops, }, // might also be a call
+	{ .name = "b",     .ops  = &jump_ops, }, /* might also be a call */
 	{ .name = "bcc",   .ops  = &jump_ops, },
 	{ .name = "bcs",   .ops  = &jump_ops, },
 	{ .name = "beq",   .ops  = &jump_ops, },
@@ -382,7 +462,6 @@ static struct ins instructions[] = {
 	{ .name = "blt",   .ops  = &jump_ops, },
 	{ .name = "blx",   .ops  = &call_ops, },
 	{ .name = "bne",   .ops  = &jump_ops, },
-#endif
 	{ .name = "bts",   .ops  = &mov_ops, },
 	{ .name = "call",  .ops  = &call_ops, },
 	{ .name = "callq", .ops  = &call_ops, },
@@ -471,24 +550,48 @@ static int ins__cmp(const void *a, const void *b)
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
@@ -715,17 +818,24 @@ int hist_entry__inc_addr_samples(struct hist_entry *he, int evidx, u64 ip)
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
 
+	dl->ins = ins__find(dl->name, norm_arch);
 	if (dl->ins == NULL)
 		return;
 
 	if (!dl->ins->ops)
 		return;
 
-	if (dl->ins->ops->parse && dl->ins->ops->parse(&dl->ops) < 0)
+	if (dl->ins->ops->parse &&
+	    dl->ins->ops->parse(&dl->ops, norm_arch) < 0)
 		dl->ins = NULL;
 }
 
@@ -767,7 +877,8 @@ out_free_name:
 }
 
 static struct disasm_line *disasm_line__new(s64 offset, char *line,
-					size_t privsize, int line_nr)
+					size_t privsize, int line_nr,
+					char *arch)
 {
 	struct disasm_line *dl = zalloc(sizeof(*dl) + privsize);
 
@@ -782,7 +893,7 @@ static struct disasm_line *disasm_line__new(s64 offset, char *line,
 			if (disasm_line__parse(dl->line, &dl->name, &dl->ops.raw) < 0)
 				goto out_free_line;
 
-			disasm_line__init_ins(dl);
+			disasm_line__init_ins(dl, arch);
 		}
 	}
 
@@ -1005,7 +1116,7 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
  */
 static int symbol__parse_objdump_line(struct symbol *sym, struct map *map,
 				      FILE *file, size_t privsize,
-				      int *line_nr)
+				      int *line_nr, char *arch)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct disasm_line *dl;
@@ -1066,7 +1177,8 @@ static int symbol__parse_objdump_line(struct symbol *sym, struct map *map,
 			parsed_line = tmp2 + 1;
 	}
 
-	dl = disasm_line__new(offset, parsed_line, privsize, *line_nr);
+	dl = disasm_line__new(offset, parsed_line, privsize,
+			      *line_nr, arch);
 	free(line);
 	(*line_nr)++;
 
@@ -1197,7 +1309,8 @@ fallback:
 	return 0;
 }
 
-int symbol__disassemble(struct symbol *sym, struct map *map, size_t privsize)
+int symbol__disassemble(struct symbol *sym, struct map *map, size_t privsize,
+			char *arch)
 {
 	struct dso *dso = map->dso;
 	char command[PATH_MAX * 2];
@@ -1313,7 +1426,7 @@ int symbol__disassemble(struct symbol *sym, struct map *map, size_t privsize)
 	nline = 0;
 	while (!feof(file)) {
 		if (symbol__parse_objdump_line(sym, map, file, privsize,
-			    &lineno) < 0)
+			    &lineno, arch) < 0)
 			break;
 		nline++;
 	}
@@ -1710,7 +1823,7 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 	struct rb_root source_line = RB_ROOT;
 	u64 len;
 
-	if (symbol__disassemble(sym, map, 0) < 0)
+	if (symbol__disassemble(sym, map, 0, perf_evsel__env_arch(evsel)) < 0)
 		return -1;
 
 	len = symbol__size(sym);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index f67ccb0..5cfad4e 100644
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
 
-int symbol__disassemble(struct symbol *sym, struct map *map, size_t privsize);
+int symbol__disassemble(struct symbol *sym, struct map *map, size_t privsize,
+			char *arch);
 
 enum symbol_disassemble_errno {
 	SYMBOL_ANNOTATE_ERRNO__SUCCESS		= 0,
-- 
2.5.5
