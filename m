Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rR2SF5SrSzDqX1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 23:04:13 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5AD3Yqv132916
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 09:04:11 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23fm5y6ceu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 09:04:11 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 10 Jun 2016 18:34:07 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 40EBE3940073
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 18:34:04 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5AD43Za39387196
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 18:34:03 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5AD409L008367
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 18:34:03 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Anton Blanchard <anton@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: [PATCH 1/2] perf annotate: generalize handling of ret instructions
Date: Fri, 10 Jun 2016 18:32:50 +0530
Message-Id: <6c96da46e8a3b44a3fdb2670897fae7a35c76460.1465563491.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce helper to detect ret instructions and use the same in the tui.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Anton Blanchard <anton@ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/ui/browsers/annotate.c | 20 +++++++++-----------
 tools/perf/util/annotate.c        | 10 ++++++++++
 tools/perf/util/annotate.h        |  1 +
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 4fc208e..dcfaf7a 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -222,16 +222,14 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 			} else if (ins__is_call(dl->ins)) {
 				ui_browser__write_graph(browser, SLSMG_RARROW_CHAR);
 				SLsmg_write_char(' ');
+			} else if (ins__is_ret(dl->ins)) {
+				ui_browser__write_graph(browser, SLSMG_LARROW_CHAR);
+				SLsmg_write_char(' ');
 			} else {
 				ui_browser__write_nstring(browser, " ", 2);
 			}
 		} else {
-			if (strcmp(dl->name, "retq")) {
-				ui_browser__write_nstring(browser, " ", 2);
-			} else {
-				ui_browser__write_graph(browser, SLSMG_LARROW_CHAR);
-				SLsmg_write_char(' ');
-			}
+			ui_browser__write_nstring(browser, " ", 2);
 		}
 
 		disasm_line__scnprintf(dl, bf, sizeof(bf), !annotate_browser__opts.use_offset);
@@ -842,14 +840,14 @@ show_help:
 				ui_helpline__puts("Huh? No selection. Report to linux-kernel@vger.kernel.org");
 			else if (browser->selection->offset == -1)
 				ui_helpline__puts("Actions are only available for assembly lines.");
-			else if (!browser->selection->ins) {
-				if (strcmp(browser->selection->name, "retq"))
-					goto show_sup_ins;
+			else if (!browser->selection->ins)
+				goto show_sup_ins;
+			else if (ins__is_ret(browser->selection->ins))
 				goto out;
-			} else if (!(annotate_browser__jump(browser) ||
+			else if (!(annotate_browser__jump(browser) ||
 				     annotate_browser__callq(browser, evsel, hbt))) {
 show_sup_ins:
-				ui_helpline__puts("Actions are only available for 'callq', 'retq' & jump instructions.");
+				ui_helpline__puts("Actions are only available for function call/return & jump/branch instructions.");
 			}
 			continue;
 		case 't':
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 7e5a1e8..e871b4e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -354,6 +354,15 @@ static struct ins_ops nop_ops = {
 	.scnprintf = nop__scnprintf,
 };
 
+static struct ins_ops ret_ops = {
+	.scnprintf = ins__raw_scnprintf,
+};
+
+bool ins__is_ret(const struct ins *ins)
+{
+	return ins->ops == &ret_ops;
+}
+
 static struct ins instructions[] = {
 	{ .name = "add",   .ops  = &mov_ops, },
 	{ .name = "addl",  .ops  = &mov_ops, },
@@ -444,6 +453,7 @@ static struct ins instructions[] = {
 	{ .name = "xadd",  .ops  = &mov_ops, },
 	{ .name = "xbeginl", .ops  = &jump_ops, },
 	{ .name = "xbeginq", .ops  = &jump_ops, },
+	{ .name = "retq",  .ops  = &ret_ops, },
 };
 
 static int ins__key_cmp(const void *name, const void *insp)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 9241f8c..720a4c0 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -48,6 +48,7 @@ struct ins {
 
 bool ins__is_jump(const struct ins *ins);
 bool ins__is_call(const struct ins *ins);
+bool ins__is_ret(const struct ins *ins);
 int ins__scnprintf(struct ins *ins, char *bf, size_t size, struct ins_operands *ops);
 
 struct annotation;
-- 
2.8.2
