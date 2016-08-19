Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sG34L6VcJzDr9y
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 23:01:06 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7JCxIVs065566
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 09:01:05 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24wfj5jfc1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 09:01:05 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Fri, 19 Aug 2016 23:01:02 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BF32B3578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 23:00:59 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7JD0x2N22347886
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 23:00:59 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7JD0vDB023963
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 23:00:59 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
 treeze.taeung@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 markus@trippelsdorf.de, chris.ryder@arm.com, pawel.moll@arm.com,
 mhiramat@kernel.org, rmk+kernel@arm.linux.org.uk, jolsa@kernel.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com, namhyung@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v6 7/7] perf annotate: Fix jump target outside of function
 address range
Date: Fri, 19 Aug 2016 18:29:38 +0530
In-Reply-To: <1471611578-11255-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1471611578-11255-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1471611578-11255-8-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If jump target is outside of function range, perf is not handling it
correctly. Especially when target address is lesser than function start
address, target offset will be negative. But, target address declared
to be unsigned, converts negative number into 2's complement. See below
example. Here target of 'jumpq' instruction at 34cf8 is 34ac0 which is
lesser than function start address(34cf0).

        34ac0 - 34cf0 = -0x230 = 0xfffffffffffffdd0

Objdump output:

  0000000000034cf0 <__sigaction>:
  __GI___sigaction():
    34cf0: lea    -0x20(%rdi),%eax
    34cf3: cmp    -bashx1,%eax
    34cf6: jbe    34d00 <__sigaction+0x10>
    34cf8: jmpq   34ac0 <__GI___libc_sigaction>
    34cfd: nopl   (%rax)
    34d00: mov    0x386161(%rip),%rax        # 3bae68 <_DYNAMIC+0x2e8>
    34d07: movl   -bashx16,%fs:(%rax)
    34d0e: mov    -bashxffffffff,%eax
    34d13: retq

perf annotate before applying patch:

  __GI___sigaction  /usr/lib64/libc-2.22.so
           lea    -0x20(%rdi),%eax
           cmp    -bashx1,%eax
        V  jbe    10
        V  jmpq   fffffffffffffdd0
           nop
    10:    mov    _DYNAMIC+0x2e8,%rax
           movl   -bashx16,%fs:(%rax)
           mov    -bashxffffffff,%eax
           retq

perf annotate after applying patch:

  __GI___sigaction  /usr/lib64/libc-2.22.so
           lea    -0x20(%rdi),%eax
           cmp    -bashx1,%eax
        V  jbe    10
        ^  jmpq   34ac0 <__GI___libc_sigaction>
           nop
    10:    mov    _DYNAMIC+0x2e8,%rax
           movl   -bashx16,%fs:(%rax)
           mov    -bashxffffffff,%eax
           retq

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
Changes in v6:
  - No changes

 tools/perf/ui/browsers/annotate.c |  5 +++--
 tools/perf/util/annotate.c        | 14 +++++++++-----
 tools/perf/util/annotate.h        |  5 +++--
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 21c5e10..c13df5b 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -215,7 +215,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 			ui_browser__set_color(browser, color);
 		if (dl->ins && dl->ins->ops->scnprintf) {
 			if (ins__is_jump(dl->ins)) {
-				bool fwd = dl->ops.target.offset > (u64)dl->offset;
+				bool fwd = dl->ops.target.offset > dl->offset;
 
 				ui_browser__write_graph(browser, fwd ? SLSMG_DARROW_CHAR :
 								    SLSMG_UARROW_CHAR);
@@ -245,7 +245,8 @@ static bool disasm_line__is_valid_jump(struct disasm_line *dl, struct symbol *sy
 {
 	if (!dl || !dl->ins || !ins__is_jump(dl->ins)
 	    || !disasm_line__has_offset(dl)
-	    || dl->ops.target.offset >= symbol__size(sym))
+	    || dl->ops.target.offset < 0
+	    || dl->ops.target.offset >= (s64)symbol__size(sym))
 		return false;
 
 	return true;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 73c4f48..9409d54 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -124,10 +124,12 @@ static int jump__parse(struct ins_operands *ops,
 	else
 		ops->target.addr = strtoull(ops->raw, NULL, 16);
 
-	if (s++ != NULL)
+	if (s++ != NULL) {
 		ops->target.offset = strtoull(s, NULL, 16);
-	else
-		ops->target.offset = UINT64_MAX;
+		ops->target.offset_avail = true;
+	} else {
+		ops->target.offset_avail = false;
+	}
 
 	return 0;
 }
@@ -135,7 +137,7 @@ static int jump__parse(struct ins_operands *ops,
 static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops)
 {
-	if (!ops->target.addr)
+	if (!ops->target.addr || ops->target.offset < 0)
 		return ins__raw_scnprintf(ins, bf, size, ops);
 
 	return scnprintf(bf, size, "%-6.6s %" PRIx64, ins->name, ops->target.offset);
@@ -1304,9 +1306,11 @@ static int symbol__parse_objdump_line(struct symbol *sym, struct map *map,
 	if (dl == NULL)
 		return -1;
 
-	if (dl->ops.target.offset == UINT64_MAX)
+	if (!disasm_line__has_offset(dl)) {
 		dl->ops.target.offset = dl->ops.target.addr -
 					map__rip_2objdump(map, sym->start);
+		dl->ops.target.offset_avail = true;
+	}
 
 	/* kcore has no symbols, so add the call target name */
 	if (dl->ins && ins__is_call(dl->ins) && !dl->ops.target.name) {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 5cfad4e..5787ed8 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -19,7 +19,8 @@ struct ins_operands {
 		char	*raw;
 		char	*name;
 		u64	addr;
-		u64	offset;
+		s64	offset;
+		bool    offset_avail;
 	} target;
 	union {
 		struct {
@@ -67,7 +68,7 @@ struct disasm_line {
 
 static inline bool disasm_line__has_offset(const struct disasm_line *dl)
 {
-	return dl->ops.target.offset != UINT64_MAX;
+	return dl->ops.target.offset_avail;
 }
 
 void disasm_line__free(struct disasm_line *dl);
-- 
2.5.5
