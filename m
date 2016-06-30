Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rg8Qd1ylszDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:14:49 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5U6ECD4010931
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 02:14:47 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23usub94wx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 02:14:47 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 16:14:44 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C9348357805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:14:41 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5U6EfvI17957074
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:14:41 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5U6Eeqh022585
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:14:41 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, acme@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: anton@ozlabs.org, mpe@ellerman.id.au, ananth@in.ibm.com, dja@axtens.net,
 naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.vnet.ibm.com,
 David.Laight@ACULAB.COM
Subject: [PATCH v3 3/4] perf annotate: add powerpc support
Date: Thu, 30 Jun 2016 11:44:21 +0530
In-Reply-To: <1467267262-4589-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1467267262-4589-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1467267262-4589-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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
Changes in v3:
  - Optimized code
  - Corrected one memory leak

 tools/perf/util/annotate.c | 126 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 36a5825..b87eac7 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -461,6 +461,11 @@ static struct ins instructions_arm[] = {
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
@@ -476,6 +481,125 @@ static int ins__cmp(const void *a, const void *b)
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
+	 * - Let's also ignore instructions involving 'ctr' and
+	 *   'tar' since target branch addresses for those can't
+	 *   be determined statically.
+	 */
+	if (name[0] != 'b'             ||
+	    !strncmp(name, "bcd", 3)   ||
+	    !strncmp(name, "brinc", 5) ||
+	    !strncmp(name, "bper", 4)  ||
+	    strstr(name, "ctr")        ||
+	    strstr(name, "tar"))
+		return NULL;
+
+	if (!list_initialized) {
+		INIT_LIST_HEAD(&head.list);
+		list_initialized = true;
+	}
+
+	/*
+	 * Return if we already have object of 'struct ins' for this
+	 * instruction
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
@@ -511,6 +635,8 @@ static struct ins *ins__find(const char *name, const char *norm_arch)
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
