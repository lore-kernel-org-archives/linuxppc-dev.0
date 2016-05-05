Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0zHD2DqyzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 01:24:56 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 6 May 2016 01:24:54 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8C3612BB005D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 01:24:51 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u45FOhof786744
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2016 01:24:51 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u45FOI0x019798
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2016 01:24:19 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] perf tools: add support for generating bpf prologue on powerpc
Date: Thu,  5 May 2016 20:53:19 +0530
Message-Id: <1462461799-17518-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Generalize existing macros to serve the purpose.

Cc: Wang Nan <wangnan0@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
With this patch:
    # ./perf test 37
    37: Test BPF filter                                          :
    37.1: Test basic BPF filtering                               : Ok
    37.2: Test BPF prologue generation                           : Ok
    37.3: Test BPF relocation checker                            : Ok

 tools/perf/arch/powerpc/Makefile          |  1 +
 tools/perf/arch/powerpc/util/dwarf-regs.c | 40 +++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index 56e05f1..cc39309 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -3,4 +3,5 @@ PERF_HAVE_DWARF_REGS := 1
 endif
 
 HAVE_KVM_STAT_SUPPORT := 1
+PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/powerpc/util/dwarf-regs.c b/tools/perf/arch/powerpc/util/dwarf-regs.c
index 733151c..41bdf95 100644
--- a/tools/perf/arch/powerpc/util/dwarf-regs.c
+++ b/tools/perf/arch/powerpc/util/dwarf-regs.c
@@ -10,19 +10,26 @@
  */
 
 #include <stddef.h>
+#include <errno.h>
+#include <string.h>
 #include <dwarf-regs.h>
-
+#include <linux/ptrace.h>
+#include <linux/kernel.h>
+#include "util.h"
 
 struct pt_regs_dwarfnum {
 	const char *name;
 	unsigned int dwarfnum;
+	unsigned int ptregs_offset;
 };
 
-#define STR(s) #s
-#define REG_DWARFNUM_NAME(r, num) {.name = r, .dwarfnum = num}
-#define GPR_DWARFNUM_NAME(num)	\
-	{.name = STR(%gpr##num), .dwarfnum = num}
-#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
+#define REG_DWARFNUM_NAME(r, num)					\
+		{.name = STR(%)STR(r), .dwarfnum = num,			\
+		.ptregs_offset = offsetof(struct pt_regs, r)}
+#define GPR_DWARFNUM_NAME(num)						\
+		{.name = STR(%gpr##num), .dwarfnum = num,		\
+		.ptregs_offset = offsetof(struct pt_regs, gpr[num])}
+#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0, .ptregs_offset = 0}
 
 /*
  * Reference:
@@ -61,12 +68,12 @@ static const struct pt_regs_dwarfnum regdwarfnum_table[] = {
 	GPR_DWARFNUM_NAME(29),
 	GPR_DWARFNUM_NAME(30),
 	GPR_DWARFNUM_NAME(31),
-	REG_DWARFNUM_NAME("%msr",   66),
-	REG_DWARFNUM_NAME("%ctr",   109),
-	REG_DWARFNUM_NAME("%link",  108),
-	REG_DWARFNUM_NAME("%xer",   101),
-	REG_DWARFNUM_NAME("%dar",   119),
-	REG_DWARFNUM_NAME("%dsisr", 118),
+	REG_DWARFNUM_NAME(msr,   66),
+	REG_DWARFNUM_NAME(ctr,   109),
+	REG_DWARFNUM_NAME(link,  108),
+	REG_DWARFNUM_NAME(xer,   101),
+	REG_DWARFNUM_NAME(dar,   119),
+	REG_DWARFNUM_NAME(dsisr, 118),
 	REG_DWARFNUM_END,
 };
 
@@ -86,3 +93,12 @@ const char *get_arch_regstr(unsigned int n)
 			return roff->name;
 	return NULL;
 }
+
+int regs_query_register_offset(const char *name)
+{
+	const struct pt_regs_dwarfnum *roff;
+	for (roff = regdwarfnum_table; roff->name != NULL; roff++)
+		if (!strcmp(roff->name, name))
+			return roff->ptregs_offset;
+	return -EINVAL;
+}
-- 
2.7.4
