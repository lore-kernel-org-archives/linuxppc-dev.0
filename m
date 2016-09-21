Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfPGP0XfBzDshd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:50:20 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8LFn5ev131783
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 11:50:18 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25k6cm7swn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 11:50:17 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Thu, 22 Sep 2016 01:50:14 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 67DCF2CE805A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:50:13 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8LFoD3O393660
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:50:13 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8LFoC19006194
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:50:13 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, acme@kernel.org, kim.phillips@arm.com
Cc: linuxppc-dev@lists.ozlabs.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, treeze.taeung@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, markus@trippelsdorf.de,
 namhyung@kernel.org, pawel.moll@arm.com, chris.ryder@arm.com,
 jolsa@kernel.org, mhiramat@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v7 2/6] perf annotate: Add support for powerpc
Date: Wed, 21 Sep 2016 21:17:52 +0530
In-Reply-To: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1474472876-2706-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

Current perf can disassemble annotated function but it does not have
parsing logic for powerpc instructions. So all navigation options are
not available for powerpc.

Apart from that, Powerpc has long list of branch instructions and
hardcoding them in table appears to be error-prone. So, add function
to find instruction instead of creating table. This function dynamically
create table (list of 'struct ins'), and instead of creating object
every time, first check if list already contain object for that
instruction.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
Changes in v7:
  - Little bit change in initializing instruction list.

 tools/perf/util/annotate.c | 112 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 816aa2c..5aa72d9 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -531,6 +531,11 @@ static struct ins instructions_arm[] = {
 	{ .name = "retq",  .ops  = &ret_ops, },
 };
 
+struct instructions_powerpc {
+	struct ins *ins;
+	struct list_head list;
+};
+
 static int ins__key_cmp(const void *name, const void *insp)
 {
 	const struct ins *ins = insp;
@@ -546,6 +551,111 @@ static int ins__cmp(const void *a, const void *b)
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
+	static struct instructions_powerpc head = {
+		.list = LIST_HEAD_INIT(head.list),
+	};
+
+	/*
+	 * - Interested only if instruction starts with 'b'.
+	 * - Few start with 'b', but aren't branch instructions.
+	 */
+	if (name[0] != 'b'             ||
+	    !strncmp(name, "bcd", 3)   ||
+	    !strncmp(name, "brinc", 5) ||
+	    !strncmp(name, "bper", 4))
+		return NULL;
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
+	return list_add__ins_powerpc(&head, name, ops);
+}
+
 static void ins__sort(struct ins *instructions, int nmemb)
 {
 	qsort(instructions, nmemb, sizeof(struct ins), ins__cmp);
@@ -581,6 +691,8 @@ static struct ins *ins__find(const char *name)
 	} else if (!strcmp(norm_arch, "arm")) {
 		instructions = instructions_arm;
 		nmemb = ARRAY_SIZE(instructions_arm);
+	} else if (!strcmp(norm_arch, "powerpc")) {
+		return ins__find_powerpc(name);
 	} else {
 		pr_err("perf annotate not supported by %s arch\n", norm_arch);
 		return NULL;
-- 
2.5.5
