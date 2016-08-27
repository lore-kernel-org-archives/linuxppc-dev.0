Return-Path: <kim.phillips@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sLfGP0L37zDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Aug 2016 10:40:44 +1000 (AEST)
Date: Fri, 26 Aug 2016 19:40:38 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Taeung Song
 <treeze.taeung@gmail.com>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>, <markus@trippelsdorf.de>,
 <chris.ryder@arm.com>, Pawel Moll <pawel.moll@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, <rmk+kernel@arm.linux.org.uk>, Jiri Olsa
 <jolsa@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Hemant Kumar
 <hemant@linux.vnet.ibm.com>
Subject: [PATCH] perf annotate: cross arch annotate support fixes for ARM
Message-Id: <20160826194038.00013aacbce1cd8aebae8df4@arm.com>
In-Reply-To: <57BFEF2B.7080105@linux.vnet.ibm.com>
References: <1471611578-11255-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1471611578-11255-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20160822180151.241ad87ad1befd72bd46c2ec@arm.com>
 <CAM9d7cgXL7vnFS32=2wGDkMry7cbeAe2N0NnmhJscvNA1vb4Vg@mail.gmail.com>
 <20160823153617.c0bb45eeefe993c554cb792a@arm.com>
 <57BFEF2B.7080105@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For ARM we remove the list that contains non-arm insns, and
instead add more maintainable branch instruction regex logic.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 177 +++++++++++++++++----------------------------
 1 file changed, 67 insertions(+), 110 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b2c6cf3..52316f3 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -26,6 +26,7 @@
 const char 	*disassembler_style;
 const char	*objdump_path;
 static regex_t	 file_lineno;
+static regex_t	 arm_call_insn, arm_jump_insn;
 
 static struct ins *ins__find(const char *name, const char *norm_arch);
 static int disasm_line__parse(char *line, char **namep, char **rawp);
@@ -449,98 +450,7 @@ static struct ins instructions_x86[] = {
 	{ .name = "retq",  .ops  = &ret_ops, },
 };
 
-static struct ins instructions_arm[] = {
-	{ .name = "add",   .ops  = &mov_ops, },
-	{ .name = "addl",  .ops  = &mov_ops, },
-	{ .name = "addq",  .ops  = &mov_ops, },
-	{ .name = "addw",  .ops  = &mov_ops, },
-	{ .name = "and",   .ops  = &mov_ops, },
-	{ .name = "b",     .ops  = &jump_ops, }, /* might also be a call */
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
-	{ .name = "bts",   .ops  = &mov_ops, },
-	{ .name = "call",  .ops  = &call_ops, },
-	{ .name = "callq", .ops  = &call_ops, },
-	{ .name = "cmp",   .ops  = &mov_ops, },
-	{ .name = "cmpb",  .ops  = &mov_ops, },
-	{ .name = "cmpl",  .ops  = &mov_ops, },
-	{ .name = "cmpq",  .ops  = &mov_ops, },
-	{ .name = "cmpw",  .ops  = &mov_ops, },
-	{ .name = "cmpxch", .ops  = &mov_ops, },
-	{ .name = "dec",   .ops  = &dec_ops, },
-	{ .name = "decl",  .ops  = &dec_ops, },
-	{ .name = "imul",  .ops  = &mov_ops, },
-	{ .name = "inc",   .ops  = &dec_ops, },
-	{ .name = "incl",  .ops  = &dec_ops, },
-	{ .name = "ja",	   .ops  = &jump_ops, },
-	{ .name = "jae",   .ops  = &jump_ops, },
-	{ .name = "jb",	   .ops  = &jump_ops, },
-	{ .name = "jbe",   .ops  = &jump_ops, },
-	{ .name = "jc",	   .ops  = &jump_ops, },
-	{ .name = "jcxz",  .ops  = &jump_ops, },
-	{ .name = "je",	   .ops  = &jump_ops, },
-	{ .name = "jecxz", .ops  = &jump_ops, },
-	{ .name = "jg",	   .ops  = &jump_ops, },
-	{ .name = "jge",   .ops  = &jump_ops, },
-	{ .name = "jl",    .ops  = &jump_ops, },
-	{ .name = "jle",   .ops  = &jump_ops, },
-	{ .name = "jmp",   .ops  = &jump_ops, },
-	{ .name = "jmpq",  .ops  = &jump_ops, },
-	{ .name = "jna",   .ops  = &jump_ops, },
-	{ .name = "jnae",  .ops  = &jump_ops, },
-	{ .name = "jnb",   .ops  = &jump_ops, },
-	{ .name = "jnbe",  .ops  = &jump_ops, },
-	{ .name = "jnc",   .ops  = &jump_ops, },
-	{ .name = "jne",   .ops  = &jump_ops, },
-	{ .name = "jng",   .ops  = &jump_ops, },
-	{ .name = "jnge",  .ops  = &jump_ops, },
-	{ .name = "jnl",   .ops  = &jump_ops, },
-	{ .name = "jnle",  .ops  = &jump_ops, },
-	{ .name = "jno",   .ops  = &jump_ops, },
-	{ .name = "jnp",   .ops  = &jump_ops, },
-	{ .name = "jns",   .ops  = &jump_ops, },
-	{ .name = "jnz",   .ops  = &jump_ops, },
-	{ .name = "jo",	   .ops  = &jump_ops, },
-	{ .name = "jp",	   .ops  = &jump_ops, },
-	{ .name = "jpe",   .ops  = &jump_ops, },
-	{ .name = "jpo",   .ops  = &jump_ops, },
-	{ .name = "jrcxz", .ops  = &jump_ops, },
-	{ .name = "js",	   .ops  = &jump_ops, },
-	{ .name = "jz",	   .ops  = &jump_ops, },
-	{ .name = "lea",   .ops  = &mov_ops, },
-	{ .name = "lock",  .ops  = &lock_ops, },
-	{ .name = "mov",   .ops  = &mov_ops, },
-	{ .name = "movb",  .ops  = &mov_ops, },
-	{ .name = "movdqa",.ops  = &mov_ops, },
-	{ .name = "movl",  .ops  = &mov_ops, },
-	{ .name = "movq",  .ops  = &mov_ops, },
-	{ .name = "movslq", .ops  = &mov_ops, },
-	{ .name = "movzbl", .ops  = &mov_ops, },
-	{ .name = "movzwl", .ops  = &mov_ops, },
-	{ .name = "nop",   .ops  = &nop_ops, },
-	{ .name = "nopl",  .ops  = &nop_ops, },
-	{ .name = "nopw",  .ops  = &nop_ops, },
-	{ .name = "or",    .ops  = &mov_ops, },
-	{ .name = "orl",   .ops  = &mov_ops, },
-	{ .name = "test",  .ops  = &mov_ops, },
-	{ .name = "testb", .ops  = &mov_ops, },
-	{ .name = "testl", .ops  = &mov_ops, },
-	{ .name = "xadd",  .ops  = &mov_ops, },
-	{ .name = "xbeginl", .ops  = &jump_ops, },
-	{ .name = "xbeginq", .ops  = &jump_ops, },
-	{ .name = "retq",  .ops  = &ret_ops, },
-};
-
-struct instructions_powerpc {
+struct instructions_arch {
 	struct ins *ins;
 	struct list_head list;
 };
@@ -560,41 +470,41 @@ static int ins__cmp(const void *a, const void *b)
 	return strcmp(ia->name, ib->name);
 }
 
-static struct ins *list_add__ins_powerpc(struct instructions_powerpc *head,
+static struct ins *list_add__ins_arch(struct instructions_arch *head,
 					 const char *name, struct ins_ops *ops)
 {
-	struct instructions_powerpc *ins_powerpc;
+	struct instructions_arch *ins_arch;
 	struct ins *ins;
 
 	ins = zalloc(sizeof(struct ins));
 	if (!ins)
 		return NULL;
 
-	ins_powerpc = zalloc(sizeof(struct instructions_powerpc));
-	if (!ins_powerpc)
+	ins_arch = zalloc(sizeof(struct instructions_arch));
+	if (!ins_arch)
 		goto out_free_ins;
 
 	ins->name = strdup(name);
 	if (!ins->name)
-		goto out_free_ins_power;
+		goto out_free_ins_arch;
 
 	ins->ops = ops;
-	ins_powerpc->ins = ins;
-	list_add_tail(&(ins_powerpc->list), &(head->list));
+	ins_arch->ins = ins;
+	list_add_tail(&(ins_arch->list), &(head->list));
 
 	return ins;
 
-out_free_ins_power:
-	zfree(&ins_powerpc);
+out_free_ins_arch:
+	zfree(&ins_arch);
 out_free_ins:
 	zfree(&ins);
 	return NULL;
 }
 
-static struct ins *list_search__ins_powerpc(struct instructions_powerpc *head,
+static struct ins *list_search__ins_arch(struct instructions_arch *head,
 					    const char *name)
 {
-	struct instructions_powerpc *pos;
+	struct instructions_arch *pos;
 
 	list_for_each_entry(pos, &head->list, list) {
 		if (!strcmp(pos->ins->name, name))
@@ -608,7 +518,7 @@ static struct ins *ins__find_powerpc(const char *name)
 	int i;
 	struct ins *ins;
 	struct ins_ops *ops;
-	static struct instructions_powerpc head;
+	static struct instructions_arch head;
 	static bool list_initialized;
 
 	/*
@@ -629,7 +539,7 @@ static struct ins *ins__find_powerpc(const char *name)
 	/*
 	 * Return if we already have object of 'struct ins' for this instruction
 	 */
-	ins = list_search__ins_powerpc(&head, name);
+	ins = list_search__ins_arch(&head, name);
 	if (ins)
 		return ins;
 
@@ -666,7 +576,44 @@ static struct ins *ins__find_powerpc(const char *name)
 	 * Add instruction to list so next time no need to
 	 * allocate memory for it.
 	 */
-	return list_add__ins_powerpc(&head, name, ops);
+	return list_add__ins_arch(&head, name, ops);
+}
+
+static struct ins *ins__find_arm(const char *name)
+{
+	struct ins *ins;
+	struct ins_ops *ops = &mov_ops;
+	static struct instructions_arch head;
+	static bool list_initialized;
+	regmatch_t match[2];
+	int ret;
+
+	if (!list_initialized) {
+		INIT_LIST_HEAD(&head.list);
+		list_initialized = true;
+	}
+
+	/*
+	 * Return if we already have object of 'struct ins' for this instruction
+	 */
+	ins = list_search__ins_arch(&head, name);
+	if (ins)
+		return ins;
+
+	ret = regexec(&arm_call_insn, name, 2, match, 0);
+	if (!ret) {
+		ops = &call_ops;
+	} else {
+		ret = regexec(&arm_jump_insn, name, 2, match, 0);
+		if (!ret)
+			ops = &jump_ops;
+	}
+
+	/*
+	 * Add instruction to list so next time no need to
+	 * allocate memory for it.
+	 */
+	return list_add__ins_arch(&head, name, ops);
 }
 
 static void ins__sort(struct ins *instructions, int nmemb)
@@ -686,15 +633,26 @@ static const char *annotate__norm_arch(char *arch)
 	return normalize_arch(arch);
 }
 
+#define ARM_CONDS "(cc|cs|eq|ge|gt|hi|le|ls|lt|mi|ne|pl|vc|vs)"
+
 static struct ins *ins__find(const char *name, const char *norm_arch)
 {
 	static bool sorted;
 	struct ins *instructions;
-	int nmemb;
+	int nmemb, ret;
 
 	if (!sorted) {
 		ins__sort(instructions_x86, ARRAY_SIZE(instructions_x86));
-		ins__sort(instructions_arm, ARRAY_SIZE(instructions_arm));
+		if (!strcmp(norm_arch, NORM_ARM)) {
+			ret = regcomp(&arm_call_insn,
+				      "^blx?" ARM_CONDS "?$", REG_EXTENDED);
+			ret |= regcomp(&arm_jump_insn,
+				       "^bx?" ARM_CONDS "?$", REG_EXTENDED);
+			if (ret) {
+				pr_err("regcomp failed\n");
+				return NULL;
+			}
+		}
 		sorted = true;
 	}
 
@@ -702,8 +660,7 @@ static struct ins *ins__find(const char *name, const char *norm_arch)
 		instructions = instructions_x86;
 		nmemb = ARRAY_SIZE(instructions_x86);
 	} else if (!strcmp(norm_arch, NORM_ARM)) {
-		instructions = instructions_arm;
-		nmemb = ARRAY_SIZE(instructions_arm);
+		return ins__find_arm(name);
 	} else if (!strcmp(norm_arch, NORM_POWERPC)) {
 		return ins__find_powerpc(name);
 	} else {
-- 
2.9.3
