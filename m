Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm1yM3xBxzDr68
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 14:40:43 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u684dRlW045957
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 00:40:41 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xmp34t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Jul 2016 00:40:41 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Fri, 8 Jul 2016 14:40:38 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E66993578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 14:40:36 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u684eaSa3080642
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 14:40:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u684eZf9010755
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 14:40:36 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, acme@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: anton@ozlabs.org, mpe@ellerman.id.au, ananth@in.ibm.com, dja@axtens.net,
 naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.vnet.ibm.com,
 David.Laight@ACULAB.COM, rmk+kernel@arm.linux.org.uk
Subject: [PATCH v4 3/3] perf annotate: add powerpc support
Date: Fri,  8 Jul 2016 10:10:13 +0530
In-Reply-To: <1467952813-5797-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1467952813-5797-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1467952813-5797-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Powerpc has long list of branch instructions and hardcoding them in
table appears to be error-prone. So, add new function to find
instruction instead of creating table. This function dynamically
create table(list of 'struct ins'), and instead of creating object
every time, first check if list already contain object for that
instruction.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
Chnages in v4:
  - Added support for branch instructions that includes 'ctr'

 tools/perf/util/annotate.c | 155 +++++++++++++++++++++++++++++++++++++++++++--
 tools/perf/util/annotate.h |   3 +-
 2 files changed, 150 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 32889ce..9de1271 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -55,10 +55,15 @@ int ins__scnprintf(struct ins *ins, char *bf, size_t size,
 	return ins__raw_scnprintf(ins, bf, size, ops);
 }
 
-static int call__parse(struct ins_operands *ops, const char *norm_arch)
+static int call__parse(char *ins_name, struct ins_operands *ops,
+		       const char *norm_arch)
 {
 	char *endptr, *tok, *name;
 
+	/* Special case for powerpc */
+	if (!strcmp(norm_arch, NORM_POWERPC) && strstr(ins_name, "ctr"))
+		return 0;
+
 	ops->target.addr = strtoull(ops->raw, &endptr, 16);
 
 	name = strchr(endptr, '<');
@@ -117,7 +122,7 @@ bool ins__is_call(const struct ins *ins)
 	return ins->ops == &call_ops;
 }
 
-static int jump__parse(struct ins_operands *ops,
+static int jump__parse(char *ins_name __maybe_unused, struct ins_operands *ops,
 		       const char *norm_arch __maybe_unused)
 {
 	const char *s = strchr(ops->raw, '+');
@@ -135,6 +140,13 @@ static int jump__parse(struct ins_operands *ops,
 static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops)
 {
+	/*
+	 * Instructions that does not include target address in operand
+	 * like 'bctr' for powerpc.
+	 */
+	if (!ops->target.addr)
+		return scnprintf(bf, size, "%-6.6s", ins->name);
+
 	return scnprintf(bf, size, "%-6.6s %" PRIx64, ins->name, ops->target.offset);
 }
 
@@ -173,7 +185,8 @@ static int comment__symbol(char *raw, char *comment, u64 *addrp, char **namep)
 	return 0;
 }
 
-static int lock__parse(struct ins_operands *ops, const char *norm_arch)
+static int lock__parse(char *ins_name, struct ins_operands *ops,
+		       const char *norm_arch)
 {
 	char *name;
 
@@ -194,7 +207,8 @@ static int lock__parse(struct ins_operands *ops, const char *norm_arch)
 		return 0;
 
 	if (ops->locked.ins->ops->parse &&
-	    ops->locked.ins->ops->parse(ops->locked.ops, norm_arch) < 0)
+	    ops->locked.ins->ops->parse(ins_name,
+			ops->locked.ops, norm_arch) < 0)
 		goto out_free_ops;
 
 	return 0;
@@ -237,7 +251,8 @@ static struct ins_ops lock_ops = {
 	.scnprintf = lock__scnprintf,
 };
 
-static int mov__parse(struct ins_operands *ops, const char *norm_arch)
+static int mov__parse(char *ins_name __maybe_unused, struct ins_operands *ops,
+		      const char *norm_arch)
 {
 	char *s = strchr(ops->raw, ','), *target, *comment, prev;
 
@@ -304,7 +319,7 @@ static struct ins_ops mov_ops = {
 	.scnprintf = mov__scnprintf,
 };
 
-static int dec__parse(struct ins_operands *ops,
+static int dec__parse(char *ins_name __maybe_unused, struct ins_operands *ops,
 		      const char *norm_arch __maybe_unused)
 {
 	char *target, *comment, *s, prev;
@@ -459,6 +474,11 @@ static struct ins instructions_arm[] = {
 	{ .name = "bne",   .ops  = &jump_ops, },
 };
 
+struct instructions_powerpc {
+	struct ins *ins;
+	struct list_head list;
+};
+
 static int ins__key_cmp(const void *name, const void *insp)
 {
 	const struct ins *ins = insp;
@@ -474,6 +494,125 @@ static int ins__cmp(const void *a, const void *b)
 	return strcmp(ia->name, ib->name);
 }
 
+static struct ins *list_add__ins_powerpc(struct instructions_powerpc *head,
+					 const char *name, struct ins_ops *ops)
+{
+	struct instructions_powerpc *ins_powerpc;
+	struct ins *ins;
+
+	ins = zalloc(sizeof(struct ins));
+	if (!ins)
+		return NULL;
+
+	ins_powerpc = zalloc(sizeof(struct instructions_powerpc));
+	if (!ins_powerpc)
+		goto out_free_ins;
+
+	ins->name = strdup(name);
+	if (!ins->name)
+		goto out_free_ins_power;
+
+	ins->ops = ops;
+	ins_powerpc->ins = ins;
+	list_add_tail(&(ins_powerpc->list), &(head->list));
+
+	return ins;
+
+out_free_ins_power:
+	zfree(&ins_powerpc);
+out_free_ins:
+	zfree(&ins);
+	return NULL;
+}
+
+static struct ins *list_search__ins_powerpc(struct instructions_powerpc *head,
+					    const char *name)
+{
+	struct instructions_powerpc *pos;
+
+	list_for_each_entry(pos, &head->list, list) {
+		if (!strcmp(pos->ins->name, name))
+			return pos->ins;
+	}
+	return NULL;
+}
+
+static struct ins *ins__find_powerpc(const char *name)
+{
+	int i;
+	struct ins *ins;
+	struct ins_ops *ops;
+	static struct instructions_powerpc head;
+	static bool list_initialized;
+
+	/*
+	 * - Interested only if instruction starts with 'b'.
+	 * - Few start with 'b', but aren't branch instructions.
+	 * - Let's also ignore instructions involving 'tar' since target
+	 *   branch addresses for those can't be determined statically.
+	 *   (same for instruction involving 'ctr'. But they are very
+	 *    common so not filtering them.)
+	 */
+
+	if (name[0] != 'b'             ||
+	    !strncmp(name, "bcd", 3)   ||
+	    !strncmp(name, "brinc", 5) ||
+	    !strncmp(name, "bper", 4)  ||
+	    strstr(name, "tar"))
+		return NULL;
+
+	if (!list_initialized) {
+		INIT_LIST_HEAD(&head.list);
+		list_initialized = true;
+	}
+
+	/*
+	 * Return if we already have object of 'struct ins' for this instruction
+	 */
+	ins = list_search__ins_powerpc(&head, name);
+	if (ins)
+		return ins;
+
+	ops = &jump_ops;
+
+	i = strlen(name) - 1;
+	if (i < 0)
+		return NULL;
+
+	/* ignore optional hints at the end of the instructions */
+	if (name[i] == '+' || name[i] == '-')
+		i--;
+
+	if (name[i] == 'l' || (name[i] == 'a' && name[i-1] == 'l')) {
+		/*
+		 * if the instruction ends up with 'l' or 'la', then
+		 * those are considered 'calls' since they update LR.
+		 * ... except for 'bnl' which is branch if not less than
+		 * and the absolute form of the same.
+		 */
+		if (strcmp(name, "bnl") && strcmp(name, "bnl+") &&
+		    strcmp(name, "bnl-") && strcmp(name, "bnla") &&
+		    strcmp(name, "bnla+") && strcmp(name, "bnla-"))
+			ops = &call_ops;
+	}
+	if (name[i] == 'r' && name[i-1] == 'l')
+		/*
+		 * instructions ending with 'lr' are considered to be
+		 * return instructions
+		 */
+		ops = &ret_ops;
+
+	/*
+	 * Add instruction to list so next time no need to
+	 * allocate memory for it.
+	 */
+	ins = list_add__ins_powerpc(&head, name, ops);
+	if (ins)
+		return ins;
+
+	return NULL;
+}
+
 static void ins__sort(struct ins *instructions, int nmemb)
 {
 	qsort(instructions, nmemb, sizeof(struct ins), ins__cmp);
@@ -509,6 +648,8 @@ static struct ins *ins__find(const char *name, const char *norm_arch)
 	} else if (!strcmp(norm_arch, NORM_ARM)) {
 		instructions = instructions_arm;
 		nmemb = ARRAY_SIZE(instructions_arm);
+	} else if (!strcmp(norm_arch, NORM_POWERPC)) {
+		return ins__find_powerpc(name);
 	} else {
 		pr_err("perf annotate not supported by %s arch\n", norm_arch);
 		return NULL;
@@ -760,7 +901,7 @@ static void disasm_line__init_ins(struct disasm_line *dl, char *arch)
 		return;
 
 	if (dl->ins->ops->parse &&
-	    dl->ins->ops->parse(&dl->ops, norm_arch) < 0)
+	    dl->ins->ops->parse(dl->name, &dl->ops, norm_arch) < 0)
 		dl->ins = NULL;
 }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 4902138..ce77d35 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -36,7 +36,8 @@ struct ins_operands {
 
 struct ins_ops {
 	void (*free)(struct ins_operands *ops);
-	int (*parse)(struct ins_operands *ops, const char *norm_arch);
+	int (*parse)(char *name, struct ins_operands *ops,
+		     const char *norm_arch);
 	int (*scnprintf)(struct ins *ins, char *bf, size_t size,
 			 struct ins_operands *ops);
 };
-- 
2.5.5
