Return-Path: <anju@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 377431A0908
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 16:04:12 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Sat, 20 Feb 2016 15:04:11 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B0CBC357803F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 16:04:07 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1K53xhN45547696
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 16:04:07 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1K53Z4R001552
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 16:03:35 +1100
From: Anju T <anju@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mpe@ellerman.id.au, maddy@linux.vnet.ibm.com, jolsa@redhat.com,
 dsahern@gmail.com, acme@redhat.com, sukadev@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V11 2/4] perf/powerpc: add support for sampling intr machine
 state
Date: Sat, 20 Feb 2016 10:32:46 +0530
Message-Id: <1455944568-7231-3-git-send-email-anju@linux.vnet.ibm.com>
In-Reply-To: <1455944568-7231-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1455944568-7231-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The perf infrastructure uses a bit mask to find out valid
registers to display. Define a register mask for supported
registers defined in asm/perf_regs.h. The bit positions also
correspond to register IDs which is used by perf infrastructure
to fetch the register values. CONFIG_HAVE_PERF_REGS enables
sampling of the interrupted machine state.

Signed-off-by: Anju T <anju@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig          |  1 +
 arch/powerpc/perf/Makefile    |  1 +
 arch/powerpc/perf/perf_regs.c | 91 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 arch/powerpc/perf/perf_regs.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9a7057e..c4ce60d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -119,6 +119,7 @@ config PPC
 	select GENERIC_ATOMIC64 if PPC32
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_REGS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
 	select ARCH_WANT_IPC_PARSE_VERSION
diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index f9c083a..2f2d3d2 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -8,6 +8,7 @@ obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
 				   power8-pmu.o
 obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
 
+obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o
 obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
 obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o e6500-pmu.o
 
diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
new file mode 100644
index 0000000..ae0759c
--- /dev/null
+++ b/arch/powerpc/perf/perf_regs.c
@@ -0,0 +1,91 @@
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/perf_event.h>
+#include <linux/bug.h>
+#include <linux/stddef.h>
+#include <asm/ptrace.h>
+#include <asm/perf_regs.h>
+
+#define PT_REGS_OFFSET(id, r) [id] = offsetof(struct pt_regs, r)
+
+#define REG_RESERVED (~((1ULL << PERF_REG_POWERPC_MAX) - 1))
+
+static unsigned int pt_regs_offset[PERF_REG_POWERPC_MAX] = {
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R0, gpr[0]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R1, gpr[1]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R2, gpr[2]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R3, gpr[3]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R4, gpr[4]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R5, gpr[5]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R6, gpr[6]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R7, gpr[7]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R8, gpr[8]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R9, gpr[9]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R10, gpr[10]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R11, gpr[11]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R12, gpr[12]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R13, gpr[13]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R14, gpr[14]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R15, gpr[15]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R16, gpr[16]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R17, gpr[17]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R18, gpr[18]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R19, gpr[19]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R20, gpr[20]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R21, gpr[21]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R22, gpr[22]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R23, gpr[23]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R24, gpr[24]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R25, gpr[25]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R26, gpr[26]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R27, gpr[27]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R28, gpr[28]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R29, gpr[29]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R30, gpr[30]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_R31, gpr[31]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_NIP, nip),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_MSR, msr),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_ORIG_R3, orig_gpr3),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_CTR, ctr),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_LNK, link),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_XER, xer),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_CCR, ccr),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_SOFTE, softe),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_TRAP, trap),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_DAR, dar),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_DSISR, dsisr),
+};
+
+u64 perf_reg_value(struct pt_regs *regs, int idx)
+{
+	if (WARN_ON_ONCE(idx >= PERF_REG_POWERPC_MAX))
+		return 0;
+
+	return regs_get_register(regs, pt_regs_offset[idx]);
+}
+
+int perf_reg_validate(u64 mask)
+{
+	if (!mask || mask & REG_RESERVED)
+		return -EINVAL;
+	return 0;
+}
+
+u64 perf_reg_abi(struct task_struct *task)
+{
+#ifdef __powerpc64__
+	if (!test_tsk_thread_flag(task, TIF_32BIT))
+		return PERF_SAMPLE_REGS_ABI_64;
+	else
+#endif
+	return PERF_SAMPLE_REGS_ABI_32;
+}
+
+void perf_get_regs_user(struct perf_regs *regs_user,
+			struct pt_regs *regs,
+			struct pt_regs *regs_user_copy)
+{
+	regs_user->regs = task_pt_regs(current);
+	regs_user->abi  = perf_reg_abi(current);
+}
-- 
2.1.0
