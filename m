Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rR2SF1WsFzDqVp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 23:04:13 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5AD3O8v011111
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 09:04:11 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23fm6e68bp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 09:04:11 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 10 Jun 2016 18:34:07 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id AD5A43940064
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 18:34:05 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5AD45J136765902
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 18:34:05 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5AD43sN008636
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 18:34:05 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Anton Blanchard <anton@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: [PATCH 2/2] perf annotate: add powerpc support
Date: Fri, 10 Jun 2016 18:32:51 +0530
In-Reply-To: <6c96da46e8a3b44a3fdb2670897fae7a35c76460.1465563491.git.naveen.n.rao@linux.vnet.ibm.com>
References: <6c96da46e8a3b44a3fdb2670897fae7a35c76460.1465563491.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <6c96da46e8a3b44a3fdb2670897fae7a35c76460.1465563491.git.naveen.n.rao@linux.vnet.ibm.com>
References: <6c96da46e8a3b44a3fdb2670897fae7a35c76460.1465563491.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <21173b25482dd19f85416f02bc8050324fe5eb76.1465563491.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert ins__find() to a __weak function for generic functionality,
while adding a powerpc-specific variant. We look at the function name
for branch instructions and classify the instructions to one among a
branch, a function call (branch with LR update) or a function return
(branch to LR).

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Anton Blanchard <anton@ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Reported-by: Anton Blanchard <anton@ozlabs.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/util/Build      |  1 +
 tools/perf/arch/powerpc/util/annotate.c | 58 +++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.c              | 17 +++++-----
 tools/perf/util/annotate.h              |  9 +++++
 4 files changed, 76 insertions(+), 9 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/annotate.c

diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 90ad64b..d9e91d6 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -2,6 +2,7 @@ libperf-y += header.o
 libperf-y += sym-handling.o
 libperf-y += kvm-stat.o
 libperf-y += perf_regs.o
+libperf-y += annotate.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_DWARF) += skip-callchain-idx.o
diff --git a/tools/perf/arch/powerpc/util/annotate.c b/tools/perf/arch/powerpc/util/annotate.c
new file mode 100644
index 0000000..f069bd7
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/annotate.c
@@ -0,0 +1,58 @@
+#include "perf.h"
+#include "annotate.h"
+
+struct ins *ins__find(const char *name)
+{
+	int i;
+	struct ins *ins;
+
+	ins = zalloc(sizeof(struct ins));
+	if (!ins)
+		return NULL;
+
+	ins->name = strdup(name);
+	if (!ins->name)
+		return NULL;
+
+	if (name[0] == 'b') {
+		/* branch instructions */
+		ins->ops = &jump_ops;
+
+		/* these start with 'b', but aren't branch instructions */
+		if (!strncmp(name, "bcd", 3) ||
+				!strncmp(name, "brinc", 5) ||
+				!strncmp(name, "bper", 4))
+			return NULL;
+
+		i = strlen(name) - 1;
+		if (i < 0)
+			return NULL;
+
+		/* ignore optional hints at the end of the instructions */
+		if (name[i] == '+' || name[i] == '-')
+			i--;
+
+		if (name[i] == 'l' || (name[i] == 'a' && name[i-1] == 'l')) {
+			/*
+			 * if the instruction ends up with 'l' or 'la', then
+			 * those are considered 'calls' since they update LR.
+			 * ... except for 'bnl' which is branch if not less than
+			 * and the absolute form of the same.
+			 */
+			if (strcmp(name, "bnl") && strcmp(name, "bnl+") &&
+			    strcmp(name, "bnl-") && strcmp(name, "bnla") &&
+			    strcmp(name, "bnla+") && strcmp(name, "bnla-"))
+				ins->ops = &call_ops;
+		}
+		if (name[i] == 'r' && name[i-1] == 'l')
+			/*
+			 * instructions ending with 'lr' are considered to be
+			 * return instructions
+			 */
+			ins->ops = &ret_ops;
+
+		return ins;
+	}
+
+	return NULL;
+}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e871b4e..0fa4fc5 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -25,7 +25,6 @@ const char 	*disassembler_style;
 const char	*objdump_path;
 static regex_t	 file_lineno;
 
-static struct ins *ins__find(const char *name);
 static int disasm_line__parse(char *line, char **namep, char **rawp);
 
 static void ins__delete(struct ins_operands *ops)
@@ -107,7 +106,7 @@ static int call__scnprintf(struct ins *ins, char *bf, size_t size,
 	return scnprintf(bf, size, "%-6.6s *%" PRIx64, ins->name, ops->target.addr);
 }
 
-static struct ins_ops call_ops = {
+struct ins_ops call_ops = {
 	.parse	   = call__parse,
 	.scnprintf = call__scnprintf,
 };
@@ -137,7 +136,7 @@ static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 	return scnprintf(bf, size, "%-6.6s %" PRIx64, ins->name, ops->target.offset);
 }
 
-static struct ins_ops jump_ops = {
+struct ins_ops jump_ops = {
 	.parse	   = jump__parse,
 	.scnprintf = jump__scnprintf,
 };
@@ -230,7 +229,7 @@ static void lock__delete(struct ins_operands *ops)
 	zfree(&ops->target.name);
 }
 
-static struct ins_ops lock_ops = {
+struct ins_ops lock_ops = {
 	.free	   = lock__delete,
 	.parse	   = lock__parse,
 	.scnprintf = lock__scnprintf,
@@ -298,7 +297,7 @@ static int mov__scnprintf(struct ins *ins, char *bf, size_t size,
 			 ops->target.name ?: ops->target.raw);
 }
 
-static struct ins_ops mov_ops = {
+struct ins_ops mov_ops = {
 	.parse	   = mov__parse,
 	.scnprintf = mov__scnprintf,
 };
@@ -339,7 +338,7 @@ static int dec__scnprintf(struct ins *ins, char *bf, size_t size,
 			 ops->target.name ?: ops->target.raw);
 }
 
-static struct ins_ops dec_ops = {
+struct ins_ops dec_ops = {
 	.parse	   = dec__parse,
 	.scnprintf = dec__scnprintf,
 };
@@ -350,11 +349,11 @@ static int nop__scnprintf(struct ins *ins __maybe_unused, char *bf, size_t size,
 	return scnprintf(bf, size, "%-6.6s", "nop");
 }
 
-static struct ins_ops nop_ops = {
+struct ins_ops nop_ops = {
 	.scnprintf = nop__scnprintf,
 };
 
-static struct ins_ops ret_ops = {
+struct ins_ops ret_ops = {
 	.scnprintf = ins__raw_scnprintf,
 };
 
@@ -478,7 +477,7 @@ static void ins__sort(void)
 	qsort(instructions, nmemb, sizeof(struct ins), ins__cmp);
 }
 
-static struct ins *ins__find(const char *name)
+__weak struct ins *ins__find(const char *name)
 {
 	const int nmemb = ARRAY_SIZE(instructions);
 	static bool sorted;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 720a4c0..6d89c1d 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -50,6 +50,15 @@ bool ins__is_jump(const struct ins *ins);
 bool ins__is_call(const struct ins *ins);
 bool ins__is_ret(const struct ins *ins);
 int ins__scnprintf(struct ins *ins, char *bf, size_t size, struct ins_operands *ops);
+struct ins *ins__find(const char *name);
+
+extern struct ins_ops call_ops;
+extern struct ins_ops jump_ops;
+extern struct ins_ops ret_ops;
+extern struct ins_ops mov_ops;
+extern struct ins_ops lock_ops;
+extern struct ins_ops dec_ops;
+extern struct ins_ops nop_ops;
 
 struct annotation;
 
-- 
2.8.2
