Return-Path: <BATV+d77fcd8de74931f46600+4639+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1CN96JylzDqHw
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 10:30:01 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Wang Nan <wangnan0@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/17] perf tools powerpc: Add support for generating bpf
 prologue
Date: Thu,  5 May 2016 21:29:29 -0300
Message-Id: <1462494580-27164-7-git-send-email-acme@kernel.org>
In-Reply-To: <1462494580-27164-1-git-send-email-acme@kernel.org>
References: <1462494580-27164-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

Generalize existing macros to serve the purpose.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1462461799-17518-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/Makefile          |  1 +
 tools/perf/arch/powerpc/util/dwarf-regs.c | 40 +++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index 56e05f126ad8..cc3930904d68 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -3,4 +3,5 @@ PERF_HAVE_DWARF_REGS := 1
 endif
 
 HAVE_KVM_STAT_SUPPORT := 1
+PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/powerpc/util/dwarf-regs.c b/tools/perf/arch/powerpc/util/dwarf-regs.c
index 733151cdf46e..41bdf9530d82 100644
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
2.5.5
