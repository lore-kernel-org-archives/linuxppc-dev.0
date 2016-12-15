Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfY4J0VZ4zDt1h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 23:42:24 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: Perf events on PPC 8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Message-Id: <20161215124219.1E4C268021@localhost.localdomain>
Date: Thu, 15 Dec 2016 13:42:18 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch has been reworked since RFC version. In the RFC, this patch
was preceded by a patch clearing MSR RI for all PPC32 at all time at
exception prologs. Now MSR RI clearing is done only when this 8xx perf
events functionality is compiled in, it is therefore limited to 8xx
and merged inside this patch.
Other main changes have been to take into account detailed review from
Peter Zijlstra. The instructions counter has been reworked to behave
as a free running counter like the three other counters.

The 8xx has no PMU, however some events can be emulated by other means.

This patch implements the following events (as reported by 'perf list'):
  cpu-cycles OR cycles				[Hardware event]
  instructions					[Hardware event]
  dTLB-load-misses				[Hardware cache event]
  iTLB-load-misses				[Hardware cache event]

'cycles' event is implemented using the timebase clock. Timebase clock
corresponds to CPU clock divided by 16, so number of cycles is
approximatly 16 times the number of TB ticks

On the 8xx, TLB misses are handled by software. It is therefore
easy to count all TLB misses each time the TLB miss exception is
called.

'instructions' is calculated by using instruction watchpoint counter.
This patch sets counter A to count instructions at address greater
than 0, hence we count all instructions executed while MSR RI bit is
set. The counter is set to the maximum which is 0xffff. Every 65535
instructions, debug instruction breakpoint exception fires. The
exception handler increments a counter in memory which then
represent the upper part of the instruction counter. We therefore
end up with a 48 bits counter. In order to avoid unnecessary overhead
while no perf event is active, this counter is started when the first
event referring to this counter is added, and the counter is stopped
when the last event referring to it is deleted. In order to properly
support breakpoint exceptions, MSR RI bit has to be unset in exception
epilogs in order to avoid breakpoint exceptions during critical
sections during changes to SRR0 and SRR1 would be problematic.

All counters are handled as free running counters.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/reg.h         |   2 +
 arch/powerpc/include/asm/reg_8xx.h     |   4 +
 arch/powerpc/kernel/entry_32.S         |  15 +++
 arch/powerpc/kernel/head_8xx.S         |  46 ++++++++-
 arch/powerpc/perf/8xx-pmu.c            | 173 +++++++++++++++++++++++++++++++++
 arch/powerpc/perf/Makefile             |   2 +
 arch/powerpc/platforms/Kconfig.cputype |   7 ++
 7 files changed, 248 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/perf/8xx-pmu.c

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 0d4531a..9098b35 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -548,7 +548,9 @@
 #define SPRN_IBAT7U	0x236		/* Instruction BAT 7 Upper Register */
 #define SPRN_ICMP	0x3D5		/* Instruction TLB Compare Register */
 #define SPRN_ICTC	0x3FB	/* Instruction Cache Throttling Control Reg */
+#ifndef SPRN_ICTRL
 #define SPRN_ICTRL	0x3F3	/* 1011 7450 icache and interrupt ctrl */
+#endif
 #define ICTRL_EICE	0x08000000	/* enable icache parity errs */
 #define ICTRL_EDC	0x04000000	/* enable dcache parity errs */
 #define ICTRL_EICP	0x00000100	/* enable icache par. check */
diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
index c52725b..ae16fef 100644
--- a/arch/powerpc/include/asm/reg_8xx.h
+++ b/arch/powerpc/include/asm/reg_8xx.h
@@ -28,12 +28,16 @@
 /* Special MSR manipulation registers */
 #define SPRN_EIE	80	/* External interrupt enable (EE=1, RI=1) */
 #define SPRN_EID	81	/* External interrupt disable (EE=0, RI=1) */
+#define SPRN_NRI	82	/* Non recoverable interrupt (EE=0, RI=0) */
 
 /* Debug registers */
+#define SPRN_CMPA	144
+#define SPRN_COUNTA	150
 #define SPRN_CMPE	152
 #define SPRN_CMPF	153
 #define SPRN_LCTRL1	156
 #define SPRN_LCTRL2	157
+#define SPRN_ICTRL	158
 #define SPRN_BAR	159
 
 /* Commands.  Only the first few are available to the instruction cache.
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 980626a..f3e4fc1 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -205,6 +205,9 @@ transfer_to_handler_cont:
 	mflr	r9
 	lwz	r11,0(r9)		/* virtual address of handler */
 	lwz	r9,4(r9)		/* where to go when done */
+#ifdef CONFIG_PPC_8xx_PERF_EVENT
+	mtspr	SPRN_NRI, r0
+#endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	lis	r12,reenable_mmu@h
 	ori	r12,r12,reenable_mmu@l
@@ -292,6 +295,9 @@ stack_ovf:
 	lis	r9,StackOverflow@ha
 	addi	r9,r9,StackOverflow@l
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
+#ifdef CONFIG_PPC_8xx_PERF_EVENT
+	mtspr	SPRN_NRI, r0
+#endif
 	mtspr	SPRN_SRR0,r9
 	mtspr	SPRN_SRR1,r10
 	SYNC
@@ -418,6 +424,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	lwz	r7,_NIP(r1)
 	lwz	r2,GPR2(r1)
 	lwz	r1,GPR1(r1)
+#ifdef CONFIG_PPC_8xx_PERF_EVENT
+	mtspr	SPRN_NRI, r0
+#endif
 	mtspr	SPRN_SRR0,r7
 	mtspr	SPRN_SRR1,r8
 	SYNC
@@ -701,6 +710,9 @@ fast_exception_return:
 	lwz	r10,_LINK(r11)
 	mtlr	r10
 	REST_GPR(10, r11)
+#ifdef CONFIG_PPC_8xx_PERF_EVENT
+	mtspr	SPRN_NRI, r0
+#endif
 	mtspr	SPRN_SRR1,r9
 	mtspr	SPRN_SRR0,r12
 	REST_GPR(9, r11)
@@ -949,6 +961,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	.globl exc_exit_restart
 exc_exit_restart:
 	lwz	r12,_NIP(r1)
+#ifdef CONFIG_PPC_8xx_PERF_EVENT
+	mtspr	SPRN_NRI, r0
+#endif
 	mtspr	SPRN_SRR0,r12
 	mtspr	SPRN_SRR1,r9
 	REST_4GPRS(9, r1)
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 5fcbd79..c032fe8c 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -329,6 +329,12 @@ InstructionTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH2, r3
 #endif
 	EXCEPTION_PROLOG_0
+#ifdef CONFIG_PPC_8xx_PERF_EVENT
+	lis	r10, (itlb_miss_counter - PAGE_OFFSET)@ha
+	lwz	r11, (itlb_miss_counter - PAGE_OFFSET)@l(r10)
+	addi	r11, r11, 1
+	stw	r11, (itlb_miss_counter - PAGE_OFFSET)@l(r10)
+#endif
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
@@ -429,6 +435,12 @@ InstructionTLBMiss:
 DataStoreTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH2, r3
 	EXCEPTION_PROLOG_0
+#ifdef CONFIG_PPC_8xx_PERF_EVENT
+	lis	r10, (dtlb_miss_counter - PAGE_OFFSET)@ha
+	lwz	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
+	addi	r11, r11, 1
+	stw	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
+#endif
 	mfcr	r3
 
 	/* If we are faulting a kernel address, we have to use the
@@ -625,7 +637,22 @@ DataBreakpoint:
 	EXCEPTION_EPILOG_0
 	rfi
 
+#ifdef CONFIG_PPC_8xx_PERF_EVENT
+	. = 0x1d00
+InstructionBreakpoint:
+	EXCEPTION_PROLOG_0
+	lis	r10, (instruction_counter - PAGE_OFFSET)@ha
+	lwz	r11, (instruction_counter - PAGE_OFFSET)@l(r10)
+	addi	r11, r11, -1
+	stw	r11, (instruction_counter - PAGE_OFFSET)@l(r10)
+	lis	r10, 0xffff
+	ori	r10, r10, 0x01
+	mtspr	SPRN_COUNTA, r10
+	EXCEPTION_EPILOG_0
+	rfi
+#else
 	EXCEPTION(0x1d00, Trap_1d, unknown_exception, EXC_XFER_EE)
+#endif
 	EXCEPTION(0x1e00, Trap_1e, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x1f00, Trap_1f, unknown_exception, EXC_XFER_EE)
 
@@ -999,9 +1026,13 @@ initial_mmu:
 	lis	r8, IDC_ENABLE@h
 	mtspr	SPRN_DC_CST, r8
 #endif
-	/* Disable debug mode entry on data breakpoints */
+	/* Disable debug mode entry on breakpoints */
 	mfspr	r8, SPRN_DER
+#ifdef CONFIG_PPC_8xx_PERF_EVENT
+	rlwinm	r8, r8, 0, ~0xc
+#else
 	rlwinm	r8, r8, 0, ~0x8
+#endif
 	mtspr	SPRN_DER, r8
 	blr
 
@@ -1036,3 +1067,16 @@ cpu6_errata_word:
 	.space	16
 #endif
 
+#ifdef CONFIG_PPC_8xx_PERF_EVENT
+	.globl	itlb_miss_counter
+itlb_miss_counter:
+	.space	4
+
+	.globl	dtlb_miss_counter
+dtlb_miss_counter:
+	.space	4
+
+	.globl	instruction_counter
+instruction_counter:
+	.space	4
+#endif
diff --git a/arch/powerpc/perf/8xx-pmu.c b/arch/powerpc/perf/8xx-pmu.c
new file mode 100644
index 0000000..3c39f05
--- /dev/null
+++ b/arch/powerpc/perf/8xx-pmu.c
@@ -0,0 +1,173 @@
+/*
+ * Performance event support - PPC 8xx
+ *
+ * Copyright 2016 Christophe Leroy, CS Systemes d'Information
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/perf_event.h>
+#include <linux/percpu.h>
+#include <linux/hardirq.h>
+#include <asm/pmc.h>
+#include <asm/machdep.h>
+#include <asm/firmware.h>
+#include <asm/ptrace.h>
+
+#define PERF_8xx_ID_CPU_CYCLES		1
+#define PERF_8xx_ID_HW_INSTRUCTIONS	2
+#define PERF_8xx_ID_ITLB_LOAD_MISS	3
+#define PERF_8xx_ID_DTLB_LOAD_MISS	4
+
+#define C(x)	PERF_COUNT_HW_CACHE_##x
+#define DTLB_LOAD_MISS	(C(DTLB) | (C(OP_READ) << 8) | (C(RESULT_MISS) << 16))
+#define ITLB_LOAD_MISS	(C(ITLB) | (C(OP_READ) << 8) | (C(RESULT_MISS) << 16))
+
+extern unsigned long itlb_miss_counter, dtlb_miss_counter;
+extern atomic_t instruction_counter;
+
+static atomic_t insn_ctr_ref;
+
+static s64 get_insn_ctr(void)
+{
+	int ctr;
+	unsigned long counta;
+
+	do {
+		ctr = atomic_read(&instruction_counter);
+		counta = mfspr(SPRN_COUNTA);
+	} while (ctr != atomic_read(&instruction_counter));
+
+	return ((s64)ctr << 16) | (counta >> 16);
+}
+
+static int event_type(struct perf_event *event)
+{
+	switch (event->attr.type) {
+	case PERF_TYPE_HARDWARE:
+		if (event->attr.config == PERF_COUNT_HW_CPU_CYCLES)
+			return PERF_8xx_ID_CPU_CYCLES;
+		if (event->attr.config == PERF_COUNT_HW_INSTRUCTIONS)
+			return PERF_8xx_ID_HW_INSTRUCTIONS;
+		break;
+	case PERF_TYPE_HW_CACHE:
+		if (event->attr.config == ITLB_LOAD_MISS)
+			return PERF_8xx_ID_ITLB_LOAD_MISS;
+		if (event->attr.config == DTLB_LOAD_MISS)
+			return PERF_8xx_ID_DTLB_LOAD_MISS;
+		break;
+	case PERF_TYPE_RAW:
+		break;
+	default:
+		return -ENOENT;
+	}
+	return -EOPNOTSUPP;
+}
+
+static int mpc8xx_pmu_event_init(struct perf_event *event)
+{
+	int type = event_type(event);
+
+	if (type < 0)
+		return type;
+	return 0;
+}
+
+static int mpc8xx_pmu_add(struct perf_event *event, int flags)
+{
+	int type = event_type(event);
+	s64 val = 0;
+
+	if (type < 0)
+		return type;
+
+	switch (type) {
+	case PERF_8xx_ID_CPU_CYCLES:
+		val = get_tb();
+		break;
+	case PERF_8xx_ID_HW_INSTRUCTIONS:
+		if (atomic_inc_return(&insn_ctr_ref) == 1)
+			mtspr(SPRN_ICTRL, 0xc0080007);
+		val = get_insn_ctr();
+		break;
+	case PERF_8xx_ID_ITLB_LOAD_MISS:
+		val = itlb_miss_counter;
+		break;
+	case PERF_8xx_ID_DTLB_LOAD_MISS:
+		val = dtlb_miss_counter;
+		break;
+	}
+	local64_set(&event->hw.prev_count, val);
+	return 0;
+}
+
+static void mpc8xx_pmu_read(struct perf_event *event)
+{
+	int type = event_type(event);
+	s64 prev, val = 0, delta = 0;
+
+	if (type < 0)
+		return;
+
+	do {
+		prev = local64_read(&event->hw.prev_count);
+		switch (type) {
+		case PERF_8xx_ID_CPU_CYCLES:
+			val = get_tb();
+			delta = 16 * (val - prev);
+			break;
+		case PERF_8xx_ID_HW_INSTRUCTIONS:
+			val = get_insn_ctr();
+			delta = prev - val;
+			if (delta < 0)
+				delta += 0x1000000000000LL;
+			break;
+		case PERF_8xx_ID_ITLB_LOAD_MISS:
+			val = itlb_miss_counter;
+			delta = (s64)((s32)val - (s32)prev);
+			break;
+		case PERF_8xx_ID_DTLB_LOAD_MISS:
+			val = dtlb_miss_counter;
+			delta = (s64)((s32)val - (s32)prev);
+			break;
+		}
+	} while (local64_cmpxchg(&event->hw.prev_count, prev, val) != prev);
+
+	local64_add(delta, &event->count);
+}
+
+static void mpc8xx_pmu_del(struct perf_event *event, int flags)
+{
+	mpc8xx_pmu_read(event);
+	if (event_type(event) != PERF_8xx_ID_HW_INSTRUCTIONS)
+		return;
+
+	/* If it was the last user, stop counting to avoid useles overhead */
+	if (atomic_dec_return(&insn_ctr_ref) == 0)
+		mtspr(SPRN_ICTRL, 7);
+}
+
+static struct pmu mpc8xx_pmu = {
+	.event_init	= mpc8xx_pmu_event_init,
+	.add		= mpc8xx_pmu_add,
+	.del		= mpc8xx_pmu_del,
+	.read		= mpc8xx_pmu_read,
+	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT |
+			  PERF_PMU_CAP_NO_NMI,
+};
+
+static int init_mpc8xx_pmu(void)
+{
+	mtspr(SPRN_ICTRL, 7);
+	mtspr(SPRN_CMPA, 0);
+	mtspr(SPRN_COUNTA, 0xffff);
+
+	return perf_pmu_register(&mpc8xx_pmu, "cpu", PERF_TYPE_RAW);
+}
+
+early_initcall(init_mpc8xx_pmu);
diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index f102d53..4d606b9 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -13,5 +13,7 @@ obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o e6500-pmu.o
 
 obj-$(CONFIG_HV_PERF_CTRS) += hv-24x7.o hv-gpci.o hv-common.o
 
+obj-$(CONFIG_PPC_8xx_PERF_EVENT) += 8xx-pmu.o
+
 obj-$(CONFIG_PPC64)		+= $(obj64-y)
 obj-$(CONFIG_PPC32)		+= $(obj32-y)
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 6e89e5a..99b0ae8 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -172,6 +172,13 @@ config PPC_FPU
 	bool
 	default y if PPC64
 
+config PPC_8xx_PERF_EVENT
+	bool "PPC 8xx perf events"
+	depends on PPC_8xx && PERF_EVENTS
+	help
+	  This is Performance Events support for PPC 8xx. The 8xx doesn't
+	  have a PMU but some events are emulated using 8xx features.
+
 config FSL_EMB_PERFMON
 	bool "Freescale Embedded Perfmon"
 	depends on E500 || PPC_83xx
-- 
2.10.1
