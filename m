Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXTsv5l3kzDvx5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 02:57:23 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB5FrucD104839
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 10:57:17 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2759qnx9qt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Dec 2016 10:57:17 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Mon, 5 Dec 2016 21:27:13 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id D55EF394004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 21:27:06 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB5Fv6Jv23199932
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 21:27:06 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB5Fv2Qt013248
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 21:27:06 +0530
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
 chris.ryder@arm.com, mhiramat@kernel.org, kim.phillips@arm.com,
 treeze.taeung@gmail.com, markus@trippelsdorf.de,
 naveen.n.rao@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v8 3/3] perf annotate: Fix jump target outside of function
 address range
Date: Mon,  5 Dec 2016 21:26:47 +0530
In-Reply-To: <1480953407-7605-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1480953407-7605-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1480953407-7605-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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
        v  jbe    10
        v  jmpq   fffffffffffffdd0
           nop
    10:    mov    _DYNAMIC+0x2e8,%rax
           movl   -bashx16,%fs:(%rax)
           mov    -bashxffffffff,%eax
           retq

perf annotate after applying patch:

  __GI___sigaction  /usr/lib64/libc-2.22.so
           lea    -0x20(%rdi),%eax
           cmp    -bashx1,%eax
        v  jbe    10
        ^  jmpq   34ac0 <__GI___libc_sigaction>
           nop
    10:    mov    _DYNAMIC+0x2e8,%rax
           movl   -bashx16,%fs:(%rax)
           mov    -bashxffffffff,%eax
           retq

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
Changes in v8:
  - v7: https://lkml.org/lkml/2016/9/21/436
  - Rebased to acme/perf/core.
  - No logical changes. (Cross arch annotate patches are in. This patch
    is for hardening annotate.)

tools/perf/ui/browsers/annotate.c |  5 +++--
 tools/perf/util/annotate.c        | 14 +++++++++-----
 tools/perf/util/annotate.h        |  5 +++--
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ec7a30f..ba36aac 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -215,7 +215,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 			ui_browser__set_color(browser, color);
 		if (dl->ins.ops && dl->ins.ops->scnprintf) {
 			if (ins__is_jump(&dl->ins)) {
-				bool fwd = dl->ops.target.offset > (u64)dl->offset;
+				bool fwd = dl->ops.target.offset > dl->offset;
 
 				ui_browser__write_graph(browser, fwd ? SLSMG_DARROW_CHAR :
 								    SLSMG_UARROW_CHAR);
@@ -245,7 +245,8 @@ static bool disasm_line__is_valid_jump(struct disasm_line *dl, struct symbol *sy
 {
 	if (!dl || !dl->ins.ops || !ins__is_jump(&dl->ins)
 	    || !disasm_line__has_offset(dl)
-	    || dl->ops.target.offset >= symbol__size(sym))
+	    || dl->ops.target.offset < 0
+	    || dl->ops.target.offset >= (s64)symbol__size(sym))
 		return false;
 
 	return true;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 590244e..c81a395 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -230,10 +230,12 @@ static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *op
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
@@ -241,7 +243,7 @@ static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *op
 static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops)
 {
-	if (!ops->target.addr)
+	if (!ops->target.addr || ops->target.offset < 0)
 		return ins__raw_scnprintf(ins, bf, size, ops);
 
 	return scnprintf(bf, size, "%-6.6s %" PRIx64, ins->name, ops->target.offset);
@@ -1209,9 +1211,11 @@ static int symbol__parse_objdump_line(struct symbol *sym, struct map *map,
 	if (dl == NULL)
 		return -1;
 
-	if (dl->ops.target.offset == UINT64_MAX)
+	if (!disasm_line__has_offset(dl)) {
 		dl->ops.target.offset = dl->ops.target.addr -
 					map__rip_2objdump(map, sym->start);
+		dl->ops.target.offset_avail = true;
+	}
 
 	/* kcore has no symbols, so add the call target name */
 	if (dl->ins.ops && ins__is_call(&dl->ins) && !dl->ops.target.name) {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 87e4cad..09776b5 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -24,7 +24,8 @@ struct ins_operands {
 		char	*raw;
 		char	*name;
 		u64	addr;
-		u64	offset;
+		s64	offset;
+		bool	offset_avail;
 	} target;
 	union {
 		struct {
@@ -68,7 +69,7 @@ struct disasm_line {
 
 static inline bool disasm_line__has_offset(const struct disasm_line *dl)
 {
-	return dl->ops.target.offset != UINT64_MAX;
+	return dl->ops.target.offset_avail;
 }
 
 void disasm_line__free(struct disasm_line *dl);
-- 
2.4.11
