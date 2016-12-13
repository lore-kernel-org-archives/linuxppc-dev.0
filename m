Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdSfW2LFNzDw4j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 05:19:47 +1100 (AEDT)
Message-Id: <8f8cb2298b929e0db5181c273b638ea6f5bf41e0.1481652710.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1481652710.git.christophe.leroy@c-s.fr>
References: <cover.1481652710.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC 2/2] powerpc/8xx: Perf events on PPC 8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Date: Tue, 13 Dec 2016 19:19:43 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 8xx has no PMU, however some events can be emulated by other means.

This patch implements the following 4 events:
  cpu-cycles OR cycles                               [Hardware event]
  instructions                                       [Hardware event]
  dTLB-load-misses                                   [Hardware cache event]
  iTLB-load-misses                                   [Hardware cache event]

'cycles' event is implemented using the timebase clock. Timebase clock
corresponds to CPU clock divided by 16, so number of cycles is
approximatly 16 times the number of TB ticks

'instructions' is calculated by using instruction watchpoint counter.
We set counter A to count instructions at address greater than 0,
hence we count all instructions executed while MSR RI bit is set.
The counter is set to the maximum which is 0xffff. Every 65535
instructions, debug instruction breakpoint exception fires. The
exception handler increments a counter in memory which then
represent the upper part of the instruction counter.

On the 8xx, TLB misses are handled by software. It is therefore
easy to count all TLB misses.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/reg.h         |   2 +
 arch/powerpc/include/asm/reg_8xx.h     |   3 +
 arch/powerpc/kernel/head_8xx.S         |  45 +++++++-
 arch/powerpc/perf/8xx-pmu.c            | 181 +++++++++++++++++++++++++++++++++
 arch/powerpc/perf/Makefile             |   2 +
 arch/powerpc/platforms/Kconfig.cputype |   7 ++
 6 files changed, 237 insertions(+), 3 deletions(-)
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
index 52f3684..ae16fef 100644
--- a/arch/powerpc/include/asm/reg_8xx.h
+++ b/arch/powerpc/include/asm/reg_8xx.h
@@ -31,10 +31,13 @@
 #define SPRN_NRI	82	/* Non recoverable interrupt (EE=0, RI=0) */
 
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
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 5fcbd79..253a2ef 100644
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
@@ -430,6 +436,12 @@ DataStoreTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH2, r3
 	EXCEPTION_PROLOG_0
 	mfcr	r3
+#ifdef CONFIG_PPC_8xx_PERF_EVENT
+	lis	r10, (dtlb_miss_counter - PAGE_OFFSET)@ha
+	lwz	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
+	addi	r11, r11, 1
+	stw	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
+#endif
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
@@ -625,7 +637,21 @@ DataBreakpoint:
 	EXCEPTION_EPILOG_0
 	rfi
 
-	EXCEPTION(0x1d00, Trap_1d, unknown_exception, EXC_XFER_EE)
+	. = 0x1d00
+InstructionBreakpoint:
+	EXCEPTION_PROLOG_0
+#ifdef CONFIG_PPC_8xx_PERF_EVENT
+	lis	r10, (instruction_counter - PAGE_OFFSET)@ha
+	lwz	r11, (instruction_counter - PAGE_OFFSET)@l(r10)
+	addi	r11, r11, 1
+	stw	r11, (instruction_counter - PAGE_OFFSET)@l(r10)
+	lis	r10, 0xffff
+	ori	r10, r10, 0x01
+	mtspr	SPRN_COUNTA, r10
+#endif
+	EXCEPTION_EPILOG_0
+	rfi
+
 	EXCEPTION(0x1e00, Trap_1e, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x1f00, Trap_1f, unknown_exception, EXC_XFER_EE)
 
@@ -999,9 +1025,9 @@ initial_mmu:
 	lis	r8, IDC_ENABLE@h
 	mtspr	SPRN_DC_CST, r8
 #endif
-	/* Disable debug mode entry on data breakpoints */
+	/* Disable debug mode entry on breakpoints */
 	mfspr	r8, SPRN_DER
-	rlwinm	r8, r8, 0, ~0x8
+	rlwinm	r8, r8, 0, ~0xc
 	mtspr	SPRN_DER, r8
 	blr
 
@@ -1036,3 +1062,16 @@ cpu6_errata_word:
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
index 0000000..0988b6d
--- /dev/null
+++ b/arch/powerpc/perf/8xx-pmu.c
@@ -0,0 +1,181 @@
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
+extern unsigned long itlb_miss_counter, dtlb_miss_counter, instruction_counter;
+
+int event_type(struct perf_event *event)
+{
+	switch (event->attr.type) {
+	case PERF_TYPE_HARDWARE:
+		if (event->attr.config == PERF_COUNT_HW_CPU_CYCLES)
+			return PERF_8xx_ID_CPU_CYCLES;
+		if (event->attr.config == PERF_COUNT_HW_INSTRUCTIONS)
+			return PERF_8xx_ID_HW_INSTRUCTIONS;
+		break;
+
+	case PERF_TYPE_HW_CACHE:
+		if (event->attr.config == ITLB_LOAD_MISS)
+			return PERF_8xx_ID_ITLB_LOAD_MISS;
+		if (event->attr.config == DTLB_LOAD_MISS)
+			return PERF_8xx_ID_DTLB_LOAD_MISS;
+		break;
+
+	case PERF_TYPE_RAW:
+		break;
+
+	default:
+		return -ENOENT;
+	}
+	return -EOPNOTSUPP;
+}
+
+
+int mpc8xx_pmu_event_init(struct perf_event *event)
+{
+	int type = event_type(event);
+
+	switch (type) {
+	case PERF_8xx_ID_CPU_CYCLES:
+	case PERF_8xx_ID_ITLB_LOAD_MISS:
+	case PERF_8xx_ID_DTLB_LOAD_MISS:
+		break;
+	case PERF_8xx_ID_HW_INSTRUCTIONS:
+		mtspr(SPRN_CMPA, 0);
+		break;
+	default:
+		return type;
+	}
+	return 0;
+}
+
+int mpc8xx_pmu_add(struct perf_event *event, int flags)
+{
+	int type = event_type(event);
+	s64 val;
+
+	switch (type) {
+	case PERF_8xx_ID_CPU_CYCLES:
+		val = get_tb();
+		break;
+	case PERF_8xx_ID_HW_INSTRUCTIONS:
+		val = (instruction_counter << 16) | 0xffff;
+		mtspr(SPRN_COUNTA, 0xffff0001);
+		mtspr(SPRN_ICTRL, 0xc0080007);
+		break;
+	case PERF_8xx_ID_ITLB_LOAD_MISS:
+		val = itlb_miss_counter;
+		break;
+	case PERF_8xx_ID_DTLB_LOAD_MISS:
+		val = dtlb_miss_counter;
+		break;
+	default:
+		break;
+	}
+	local64_set(&event->hw.prev_count, val);
+	return 0;
+}
+
+void mpc8xx_pmu_read(struct perf_event *event)
+{
+	int type = event_type(event);
+	s64 prev, val, delta;
+
+	prev = local64_read(&event->hw.prev_count);
+	switch (type) {
+	case PERF_8xx_ID_CPU_CYCLES:
+		val = get_tb();
+		delta = 16 * (val - prev);
+		break;
+	case PERF_8xx_ID_HW_INSTRUCTIONS:
+		mtspr(SPRN_ICTRL, 7);
+		val = (instruction_counter << 16) | (0xffff - (mfspr(SPRN_COUNTA) >> 16));
+		mtspr(SPRN_ICTRL, 0xc0080007);
+		delta = val - prev;
+		break;
+	case PERF_8xx_ID_ITLB_LOAD_MISS:
+		val = itlb_miss_counter;
+		delta = val - prev;
+		break;
+	case PERF_8xx_ID_DTLB_LOAD_MISS:
+		val = dtlb_miss_counter;
+		delta = val - prev;
+		break;
+	default:
+		break;
+	}
+	local64_set(&event->hw.prev_count, val);
+	local64_add(delta, &event->count);
+}
+
+void mpc8xx_pmu_del(struct perf_event *event, int flags)
+{
+	int type = event_type(event);
+	s64 prev, val;
+
+	prev = local64_read(&event->hw.prev_count);
+	switch (type) {
+	case PERF_8xx_ID_HW_INSTRUCTIONS:
+		mtspr(SPRN_ICTRL, 7);
+		val = (instruction_counter << 16) | (0xffff - (mfspr(SPRN_COUNTA) >> 16));
+		local64_add(val - prev, &event->count);
+		break;
+	case PERF_8xx_ID_CPU_CYCLES:
+	case PERF_8xx_ID_ITLB_LOAD_MISS:
+	case PERF_8xx_ID_DTLB_LOAD_MISS:
+		mpc8xx_pmu_read(event);
+		break;
+	default:
+		break;
+	}
+}
+
+void mpc8xx_pmu_start(struct perf_event *event, int flags)
+{
+}
+
+void mpc8xx_pmu_stop(struct perf_event *event, int flags)
+{
+}
+
+static struct pmu mpc8xx_pmu = {
+	.event_init	= mpc8xx_pmu_event_init,
+	.add		= mpc8xx_pmu_add,
+	.del		= mpc8xx_pmu_del,
+	.start		= mpc8xx_pmu_start,
+	.stop		= mpc8xx_pmu_stop,
+	.read		= mpc8xx_pmu_read,
+};
+
+static int init_mpc8xx_pmu(void)
+{
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
