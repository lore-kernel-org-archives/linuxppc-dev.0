Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtCHw1l3TzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:03:24 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/25] perf unwind: Support for powerpc
Date: Wed, 21 Jun 2017 15:02:26 -0300
Message-Id: <20170621180245.23134-7-acme@kernel.org>
In-Reply-To: <20170621180245.23134-1-acme@kernel.org>
References: <20170621180245.23134-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paolo Bonzini <pbonzini@redhat.com>

Porting PPC to libdw only needs an architecture-specific hook to move
the register state from perf to libdw.

The ARM and x86 architectures already use libdw, and it is useful to
have as much common code for the unwinder as possible.  Mark Wielaard
has contributed a frame-based unwinder to libdw, so that unwinding works
even for binaries that do not have CFI information.  In addition,
libunwind is always preferred to libdw by the build machinery so this
cannot introduce regressions on machines that have both libunwind and
libdw installed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Milian Wolff <milian.wolff@kdab.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1496312681-20133-1-git-send-email-pbonzini@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config                  |  2 +-
 tools/perf/arch/powerpc/util/Build          |  2 +
 tools/perf/arch/powerpc/util/unwind-libdw.c | 73 +++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/powerpc/util/unwind-libdw.c

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 1f4fbc9a3292..bdf0e87f9b29 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -61,7 +61,7 @@ endif
 # Disable it on all other architectures in case libdw unwind
 # support is detected in system. Add supported architectures
 # to the check.
-ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm))
+ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm powerpc))
   NO_LIBDW_DWARF_UNWIND := 1
 endif
 
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 90ad64b231cd..2e6595310420 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -5,4 +5,6 @@ libperf-y += perf_regs.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_DWARF) += skip-callchain-idx.o
+
 libperf-$(CONFIG_LIBUNWIND) += unwind-libunwind.o
+libperf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/arch/powerpc/util/unwind-libdw.c
new file mode 100644
index 000000000000..3a24b3c43273
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/unwind-libdw.c
@@ -0,0 +1,73 @@
+#include <elfutils/libdwfl.h>
+#include "../../util/unwind-libdw.h"
+#include "../../util/perf_regs.h"
+#include "../../util/event.h"
+
+/* See backends/ppc_initreg.c and backends/ppc_regs.c in elfutils.  */
+static const int special_regs[3][2] = {
+	{ 65, PERF_REG_POWERPC_LINK },
+	{ 101, PERF_REG_POWERPC_XER },
+	{ 109, PERF_REG_POWERPC_CTR },
+};
+
+bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
+{
+	struct unwind_info *ui = arg;
+	struct regs_dump *user_regs = &ui->sample->user_regs;
+	Dwarf_Word dwarf_regs[32], dwarf_nip;
+	size_t i;
+
+#define REG(r) ({						\
+	Dwarf_Word val = 0;					\
+	perf_reg_value(&val, user_regs, PERF_REG_POWERPC_##r);	\
+	val;							\
+})
+
+	dwarf_regs[0]  = REG(R0);
+	dwarf_regs[1]  = REG(R1);
+	dwarf_regs[2]  = REG(R2);
+	dwarf_regs[3]  = REG(R3);
+	dwarf_regs[4]  = REG(R4);
+	dwarf_regs[5]  = REG(R5);
+	dwarf_regs[6]  = REG(R6);
+	dwarf_regs[7]  = REG(R7);
+	dwarf_regs[8]  = REG(R8);
+	dwarf_regs[9]  = REG(R9);
+	dwarf_regs[10] = REG(R10);
+	dwarf_regs[11] = REG(R11);
+	dwarf_regs[12] = REG(R12);
+	dwarf_regs[13] = REG(R13);
+	dwarf_regs[14] = REG(R14);
+	dwarf_regs[15] = REG(R15);
+	dwarf_regs[16] = REG(R16);
+	dwarf_regs[17] = REG(R17);
+	dwarf_regs[18] = REG(R18);
+	dwarf_regs[19] = REG(R19);
+	dwarf_regs[20] = REG(R20);
+	dwarf_regs[21] = REG(R21);
+	dwarf_regs[22] = REG(R22);
+	dwarf_regs[23] = REG(R23);
+	dwarf_regs[24] = REG(R24);
+	dwarf_regs[25] = REG(R25);
+	dwarf_regs[26] = REG(R26);
+	dwarf_regs[27] = REG(R27);
+	dwarf_regs[28] = REG(R28);
+	dwarf_regs[29] = REG(R29);
+	dwarf_regs[30] = REG(R30);
+	dwarf_regs[31] = REG(R31);
+	if (!dwfl_thread_state_registers(thread, 0, 32, dwarf_regs))
+		return false;
+
+	dwarf_nip = REG(NIP);
+	dwfl_thread_state_register_pc(thread, dwarf_nip);
+	for (i = 0; i < ARRAY_SIZE(special_regs); i++) {
+		Dwarf_Word val = 0;
+		perf_reg_value(&val, user_regs, special_regs[i][1]);
+		if (!dwfl_thread_state_registers(thread,
+						 special_regs[i][0], 1,
+						 &val))
+			return false;
+	}
+
+	return true;
+}
-- 
2.9.4
