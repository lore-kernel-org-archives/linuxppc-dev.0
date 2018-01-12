Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJ2XR6pNszF0kW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 23:45:26 +1100 (AEDT)
Message-Id: <9eae58412d91e7218a47733b47e14faee9864476.1515759812.git.christophe.leroy@c-s.fr>
In-Reply-To: <bb30d80cc985d7307fa1286c9e6824230698919b.1515759812.git.christophe.leroy@c-s.fr>
References: <bb30d80cc985d7307fa1286c9e6824230698919b.1515759812.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/8] powerpc/8xx: Only perform perf counting when perf is in
 use.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 12 Jan 2018 13:45:23 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In TLB miss handlers, updating the perf counter is only useful
when performing a perf analysis. As it has a noticeable overhead,
let's only do it when needed.

In order to do so, the exit of the miss handlers will be patched
when starting/stopping 'perf': the first register restore
instruction of each exit point will be replaced by a jump to
the counting code.

Once this is done, CONFIG_PPC_8xx_PERF_EVENT becomes useless as
this feature doesn't add any overhead.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/ppc-opcode.h  |  2 ++
 arch/powerpc/kernel/entry_32.S         | 10 +++----
 arch/powerpc/kernel/head_8xx.S         | 47 ++++++++++++++++++++----------
 arch/powerpc/perf/8xx-pmu.c            | 52 +++++++++++++++++++++++++++++++---
 arch/powerpc/perf/Makefile             |  2 +-
 arch/powerpc/platforms/Kconfig.cputype |  7 -----
 6 files changed, 88 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index ce0930d68857..ab5c1588b487 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -236,6 +236,7 @@
 #define PPC_INST_RFCI			0x4c000066
 #define PPC_INST_RFDI			0x4c00004e
 #define PPC_INST_RFMCI			0x4c00004c
+#define PPC_INST_MFSPR			0x7c0002a6
 #define PPC_INST_MFSPR_DSCR		0x7c1102a6
 #define PPC_INST_MFSPR_DSCR_MASK	0xfc1ffffe
 #define PPC_INST_MTSPR_DSCR		0x7c1103a6
@@ -383,6 +384,7 @@
 #define __PPC_ME64(s)	__PPC_MB64(s)
 #define __PPC_BI(s)	(((s) & 0x1f) << 16)
 #define __PPC_CT(t)	(((t) & 0x0f) << 21)
+#define __PPC_SPR(r)	((((r) & 0x1f) << 16) | ((((r) >> 5) & 0x1f) << 11))
 
 /*
  * Only use the larx hint bit on 64bit CPUs. e500v1/v2 based CPUs will treat a
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index e780e1fbf6c2..eb8d01bae8c6 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -211,7 +211,7 @@ transfer_to_handler_cont:
 	mflr	r9
 	lwz	r11,0(r9)		/* virtual address of handler */
 	lwz	r9,4(r9)		/* where to go when done */
-#ifdef CONFIG_PPC_8xx_PERF_EVENT
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
 	mtspr	SPRN_NRI, r0
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -301,7 +301,7 @@ stack_ovf:
 	lis	r9,StackOverflow@ha
 	addi	r9,r9,StackOverflow@l
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
-#ifdef CONFIG_PPC_8xx_PERF_EVENT
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
 	mtspr	SPRN_NRI, r0
 #endif
 	mtspr	SPRN_SRR0,r9
@@ -430,7 +430,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	lwz	r7,_NIP(r1)
 	lwz	r2,GPR2(r1)
 	lwz	r1,GPR1(r1)
-#ifdef CONFIG_PPC_8xx_PERF_EVENT
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
 	mtspr	SPRN_NRI, r0
 #endif
 	mtspr	SPRN_SRR0,r7
@@ -727,7 +727,7 @@ fast_exception_return:
 	lwz	r10,_LINK(r11)
 	mtlr	r10
 	REST_GPR(10, r11)
-#ifdef CONFIG_PPC_8xx_PERF_EVENT
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
 	mtspr	SPRN_NRI, r0
 #endif
 	mtspr	SPRN_SRR1,r9
@@ -978,7 +978,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	.globl exc_exit_restart
 exc_exit_restart:
 	lwz	r12,_NIP(r1)
-#ifdef CONFIG_PPC_8xx_PERF_EVENT
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
 	mtspr	SPRN_NRI, r0
 #endif
 	mtspr	SPRN_SRR0,r12
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index eda582b96dbf..641c9a9d4db2 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -304,12 +304,6 @@ InstructionTLBMiss:
 #if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
 	mtspr	SPRN_SPRG_SCRATCH2, r12
 #endif
-#ifdef CONFIG_PPC_8xx_PERF_EVENT
-	lis	r10, (itlb_miss_counter - PAGE_OFFSET)@ha
-	lwz	r11, (itlb_miss_counter - PAGE_OFFSET)@l(r10)
-	addi	r11, r11, 1
-	stw	r11, (itlb_miss_counter - PAGE_OFFSET)@l(r10)
-#endif
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
@@ -392,6 +386,20 @@ _ENTRY(ITLBMiss_cmp)
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
 	/* Restore registers */
+_ENTRY(itlb_miss_exit_1)
+	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
+	mfspr	r12, SPRN_SPRG_SCRATCH2
+#endif
+	rfi
+#ifdef CONFIG_PERF_EVENTS
+_ENTRY(itlb_miss_perf)
+	lis	r10, (itlb_miss_counter - PAGE_OFFSET)@ha
+	lwz	r11, (itlb_miss_counter - PAGE_OFFSET)@l(r10)
+	addi	r11, r11, 1
+	stw	r11, (itlb_miss_counter - PAGE_OFFSET)@l(r10)
+#endif
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 #if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
@@ -429,12 +437,6 @@ DataStoreTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH0, r10
 	mtspr	SPRN_SPRG_SCRATCH1, r11
 	mtspr	SPRN_SPRG_SCRATCH2, r12
-#ifdef CONFIG_PPC_8xx_PERF_EVENT
-	lis	r10, (dtlb_miss_counter - PAGE_OFFSET)@ha
-	lwz	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
-	addi	r11, r11, 1
-	stw	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
-#endif
 	mfcr	r12
 
 	/* If we are faulting a kernel address, we have to use the
@@ -526,6 +528,18 @@ _ENTRY(DTLBMiss_jmp)
 
 	/* Restore registers */
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
+_ENTRY(dtlb_miss_exit_1)
+	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	mfspr	r12, SPRN_SPRG_SCRATCH2
+	rfi
+#ifdef CONFIG_PERF_EVENTS
+_ENTRY(dtlb_miss_perf)
+	lis	r10, (dtlb_miss_counter - PAGE_OFFSET)@ha
+	lwz	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
+	addi	r11, r11, 1
+	stw	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
+#endif
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 	mfspr	r12, SPRN_SPRG_SCRATCH2
@@ -635,7 +649,7 @@ DataBreakpoint:
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 	rfi
 
-#ifdef CONFIG_PPC_8xx_PERF_EVENT
+#ifdef CONFIG_PERF_EVENTS
 	. = 0x1d00
 InstructionBreakpoint:
 	mtspr	SPRN_SPRG_SCRATCH0, r10
@@ -675,6 +689,7 @@ DTLBMissIMMR:
 
 	li	r11, RPN_PATTERN
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
+_ENTRY(dtlb_miss_exit_2)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 	mfspr	r12, SPRN_SPRG_SCRATCH2
@@ -692,6 +707,7 @@ DTLBMissLinear:
 
 	li	r11, RPN_PATTERN
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
+_ENTRY(dtlb_miss_exit_3)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 	mfspr	r12, SPRN_SPRG_SCRATCH2
@@ -708,6 +724,7 @@ ITLBMissLinear:
 			  _PAGE_PRESENT
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
+_ENTRY(itlb_miss_exit_2)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 	mfspr	r12, SPRN_SPRG_SCRATCH2
@@ -1039,7 +1056,7 @@ initial_mmu:
 #endif
 	/* Disable debug mode entry on breakpoints */
 	mfspr	r8, SPRN_DER
-#ifdef CONFIG_PPC_8xx_PERF_EVENT
+#ifdef CONFIG_PERF_EVENTS
 	rlwinm	r8, r8, 0, ~0xc
 #else
 	rlwinm	r8, r8, 0, ~0x8
@@ -1072,7 +1089,7 @@ swapper_pg_dir:
 abatron_pteptrs:
 	.space	8
 
-#ifdef CONFIG_PPC_8xx_PERF_EVENT
+#ifdef CONFIG_PERF_EVENTS
 	.globl	itlb_miss_counter
 itlb_miss_counter:
 	.space	4
diff --git a/arch/powerpc/perf/8xx-pmu.c b/arch/powerpc/perf/8xx-pmu.c
index 3c39f05f0af3..6c0020d1c561 100644
--- a/arch/powerpc/perf/8xx-pmu.c
+++ b/arch/powerpc/perf/8xx-pmu.c
@@ -18,6 +18,7 @@
 #include <asm/machdep.h>
 #include <asm/firmware.h>
 #include <asm/ptrace.h>
+#include <asm/code-patching.h>
 
 #define PERF_8xx_ID_CPU_CYCLES		1
 #define PERF_8xx_ID_HW_INSTRUCTIONS	2
@@ -30,8 +31,13 @@
 
 extern unsigned long itlb_miss_counter, dtlb_miss_counter;
 extern atomic_t instruction_counter;
+extern unsigned int itlb_miss_perf, dtlb_miss_perf;
+extern unsigned int itlb_miss_exit_1, itlb_miss_exit_2;
+extern unsigned int dtlb_miss_exit_1, dtlb_miss_exit_2, dtlb_miss_exit_3;
 
 static atomic_t insn_ctr_ref;
+static atomic_t itlb_miss_ref;
+static atomic_t dtlb_miss_ref;
 
 static s64 get_insn_ctr(void)
 {
@@ -96,9 +102,24 @@ static int mpc8xx_pmu_add(struct perf_event *event, int flags)
 		val = get_insn_ctr();
 		break;
 	case PERF_8xx_ID_ITLB_LOAD_MISS:
+		if (atomic_inc_return(&itlb_miss_ref) == 1) {
+			unsigned long target = (unsigned long)&itlb_miss_perf;
+
+			patch_branch(&itlb_miss_exit_1, target, 0);
+#ifndef CONFIG_PIN_TLB_TEXT
+			patch_branch(&itlb_miss_exit_2, target, 0);
+#endif
+		}
 		val = itlb_miss_counter;
 		break;
 	case PERF_8xx_ID_DTLB_LOAD_MISS:
+		if (atomic_inc_return(&dtlb_miss_ref) == 1) {
+			unsigned long target = (unsigned long)&dtlb_miss_perf;
+
+			patch_branch(&dtlb_miss_exit_1, target, 0);
+			patch_branch(&dtlb_miss_exit_2, target, 0);
+			patch_branch(&dtlb_miss_exit_3, target, 0);
+		}
 		val = dtlb_miss_counter;
 		break;
 	}
@@ -143,13 +164,36 @@ static void mpc8xx_pmu_read(struct perf_event *event)
 
 static void mpc8xx_pmu_del(struct perf_event *event, int flags)
 {
+	/* mfspr r10, SPRN_SPRG_SCRATCH0 */
+	unsigned int insn = PPC_INST_MFSPR | __PPC_RS(R10) |
+			    __PPC_SPR(SPRN_SPRG_SCRATCH0);
+
 	mpc8xx_pmu_read(event);
-	if (event_type(event) != PERF_8xx_ID_HW_INSTRUCTIONS)
-		return;
 
 	/* If it was the last user, stop counting to avoid useles overhead */
-	if (atomic_dec_return(&insn_ctr_ref) == 0)
-		mtspr(SPRN_ICTRL, 7);
+	switch (event_type(event)) {
+	case PERF_8xx_ID_CPU_CYCLES:
+		break;
+	case PERF_8xx_ID_HW_INSTRUCTIONS:
+		if (atomic_dec_return(&insn_ctr_ref) == 0)
+			mtspr(SPRN_ICTRL, 7);
+		break;
+	case PERF_8xx_ID_ITLB_LOAD_MISS:
+		if (atomic_dec_return(&itlb_miss_ref) == 0) {
+			patch_instruction(&itlb_miss_exit_1, insn);
+#ifndef CONFIG_PIN_TLB_TEXT
+			patch_instruction(&itlb_miss_exit_2, insn);
+#endif
+		}
+		break;
+	case PERF_8xx_ID_DTLB_LOAD_MISS:
+		if (atomic_dec_return(&dtlb_miss_ref) == 0) {
+			patch_instruction(&dtlb_miss_exit_1, insn);
+			patch_instruction(&dtlb_miss_exit_2, insn);
+			patch_instruction(&dtlb_miss_exit_3, insn);
+		}
+		break;
+	}
 }
 
 static struct pmu mpc8xx_pmu = {
diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index 225c9c86d7c0..57ebc655d2ac 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o e6500-pmu.o
 
 obj-$(CONFIG_HV_PERF_CTRS) += hv-24x7.o hv-gpci.o hv-common.o
 
-obj-$(CONFIG_PPC_8xx_PERF_EVENT) += 8xx-pmu.o
+obj-$(CONFIG_PPC_8xx) += 8xx-pmu.o
 
 obj-$(CONFIG_PPC64)		+= $(obj64-y)
 obj-$(CONFIG_PPC32)		+= $(obj32-y)
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 73a7ea333e9e..8944b24d2218 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -168,13 +168,6 @@ config PPC_FPU
 	bool
 	default y if PPC64
 
-config PPC_8xx_PERF_EVENT
-	bool "PPC 8xx perf events"
-	depends on PPC_8xx && PERF_EVENTS
-	help
-	  This is Performance Events support for PPC 8xx. The 8xx doesn't
-	  have a PMU but some events are emulated using 8xx features.
-
 config FSL_EMB_PERFMON
 	bool "Freescale Embedded Perfmon"
 	depends on E500 || PPC_83xx
-- 
2.13.3
