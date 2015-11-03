Return-Path: <anju@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 60A201A03EF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 17:10:18 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 3 Nov 2015 11:40:14 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A38523940057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 11:40:05 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA36A5PV43843834
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 11:40:05 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA36A4w5014004
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 11:40:05 +0530
From: Anju T <anju@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
 acme@redhat.com, dsahern@gmail.com, jolsa@redhat.com,
 hemant@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH V3 2/3] perf/powerpc :add support for sampling intr machine
 state
Date: Tue,  3 Nov 2015 11:40:01 +0530
Message-Id: <1446531002-16582-3-git-send-email-anju@linux.vnet.ibm.com>
In-Reply-To: <1446531002-16582-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1446531002-16582-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The perf infrastructure uses a bit mask to find out
valid registers to display. Define a register mask
for supported registers defined in asm/perf_regs.h.
The bit positions also correspond to register IDs
which is used by perf infrastructure to fetch the register
values.CONFIG_HAVE_PERF_REGS enables
sampling of the interrupted machine state.

Signed-off-by: Anju T <anju@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig          |  1 +
 arch/powerpc/perf/Makefile    |  2 +
 arch/powerpc/perf/perf_regs.c | 92 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
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
index f9c083a..cbae78a 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -7,6 +7,8 @@ obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
 				   power5+-pmu.o power6-pmu.o power7-pmu.o \
 				   power8-pmu.o
 obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
+obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o
+
 
 obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
 obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o e6500-pmu.o
diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
new file mode 100644
index 0000000..0520492
--- /dev/null
+++ b/arch/powerpc/perf/perf_regs.c
@@ -0,0 +1,92 @@
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
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR0, gpr[0]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR1, gpr[1]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR2, gpr[2]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR3, gpr[3]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR4, gpr[4]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR5, gpr[5]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR6, gpr[6]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR7, gpr[7]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR8, gpr[8]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR9, gpr[9]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR10, gpr[10]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR11, gpr[11]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR12, gpr[12]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR13, gpr[13]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR14, gpr[14]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR15, gpr[15]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR16, gpr[16]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR17, gpr[17]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR18, gpr[18]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR19, gpr[19]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR20, gpr[20]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR21, gpr[21]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR22, gpr[22]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR23, gpr[23]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR24, gpr[24]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR25, gpr[25]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR26, gpr[26]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR27, gpr[27]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR28, gpr[28]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR29, gpr[29]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR30, gpr[30]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR31, gpr[31]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_NIP, nip),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_MSR, msr),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_ORIG_R3, orig_gpr3),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_CTR, ctr),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_LNK, link),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_XER, xer),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_CCR, ccr),
+#ifdef __powerpc64__
+	PT_REGS_OFFSET(PERF_REG_POWERPC_SOFTE, softe),
+#else
+	PT_REGS_OFFSET(PERF_REG_POWERPC_MQ, mq),
+#endif
+	PT_REGS_OFFSET(PERF_REG_POWERPC_TRAP, trap),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_DAR, dar),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_DSISR, dsisr),
+};
+
+u64 perf_reg_value(struct pt_regs *regs, int idx)
+{
+	if (WARN_ON_ONCE(idx >= PERF_REG_POWERPC_MAX))
+		return 0;
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
+	return PERF_SAMPLE_REGS_ABI_64;
+}
+
+void perf_get_regs_user(struct perf_regs *regs_user,
+			struct pt_regs *regs,
+			struct pt_regs *regs_user_copy)
+{
+	/*
+	 *TODO : Update this function when
+	 *PERF_SAMPLE_REGS_USER is enabled
+	 */
+	return;
+}
-- 
2.1.0
