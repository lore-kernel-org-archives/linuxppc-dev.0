Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFs3h5R77zDr6G
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 15:29:52 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7J5Sg9U104075
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 01:29:50 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24wbwyxm5h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 01:29:50 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Fri, 19 Aug 2016 10:59:46 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 25A9BE005A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 11:03:59 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7J5TOB440960132
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 10:59:24 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7J5TIVi000739
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 10:59:23 +0530
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
 treeze.taeung@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 markus@trippelsdorf.de, chris.ryder@arm.com, pawel.moll@arm.com,
 mhiramat@kernel.org, rmk+kernel@arm.linux.org.uk, jolsa@kernel.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com, namhyung@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v5 3/7] perf annotate: Add support for powerpc
Date: Fri, 19 Aug 2016 10:59:02 +0530
In-Reply-To: <1471584546-11080-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1471584546-11080-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1471584546-11080-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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
Changes in v5:
  - Removed hacks for instructions like bctr and bctrl from this patch.

 tools/perf/util/annotate.c | 116 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index deb9af0..0b64841 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -459,6 +459,11 @@ static struct ins instructions_arm[] = {
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
@@ -474,6 +479,115 @@ static int ins__cmp(const void *a, const void *b)
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
+	 */
+	if (name[0] != 'b'             ||
+	    !strncmp(name, "bcd", 3)   ||
+	    !strncmp(name, "brinc", 5) ||
+	    !strncmp(name, "bper", 4))
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
+	return list_add__ins_powerpc(&head, name, ops);
+}
+
 static void ins__sort(struct ins *instructions, int nmemb)
 {
 	qsort(instructions, nmemb, sizeof(struct ins), ins__cmp);
@@ -509,6 +623,8 @@ static struct ins *ins__find(const char *name, const char *norm_arch)
 	} else if (!strcmp(norm_arch, NORM_ARM)) {
 		instructions = instructions_arm;
 		nmemb = ARRAY_SIZE(instructions_arm);
+	} else if (!strcmp(norm_arch, NORM_POWERPC)) {
+		return ins__find_powerpc(name);
 	} else {
 		pr_err("perf annotate not supported by %s arch\n", norm_arch);
 		return NULL;
-- 
2.5.5
