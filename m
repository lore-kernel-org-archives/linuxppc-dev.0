Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 090341A0225
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 19:47:44 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A2A20140776
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2015 19:47:41 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 9 Jul 2015 19:47:36 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 352AE357804C
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2015 19:47:30 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t699lJRU64749568
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Jul 2015 19:47:27 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t699kvOZ021127
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Jul 2015 19:46:57 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, mpe@ellerman.id.au
Subject: [PATCH V2] powerpc/irq: Enable some more exceptions in
 /proc/interrupts interface
Date: Thu,  9 Jul 2015 15:16:29 +0530
Message-Id: <1436435189-11152-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables facility unavailable exceptions for generic facility,
FPU, ALTIVEC and VSX in /proc/interrupts listing by incrementing their
newly added IRQ statistical counters as and when these exceptions happen.
This also adds couple of helper functions which will be called from within
the interrupt handler context to update their statistics. Similarly this
patch also enables alignment and program check exceptions as well.

	With this patch being applied, /proc/interrupts looks something
like this after running various workloads which create these exceptions.

--------------------------------------------------------------
           CPU0       CPU1
 16:      28477      35288      XICS   2 Level     IPI
 17:          0          0      XICS 4101 Level     virtio0
 18:          0          0      XICS 4100 Level     ohci_hcd:usb1
 19:     288146          0      XICS 4099 Level     virtio1
 20:          0          0      XICS 4096 Level     RAS_EPOW
 21:       6241      17364      XICS 4102 Level     ibmvscsi
 22:        133          0      XICS 4103 Level     hvc_console
LOC:      12617      24509   Local timer interrupts for timer event device
LOC:         98         73   Local timer interrupts for others
SPU:          0          0   Spurious interrupts
PMI:          0          0   Performance monitoring interrupts
MCE:          0          0   Machine check exceptions
DBL:          0          0   Doorbell interrupts
ALN:          0          0   Alignment exceptions
PRG:          0          0   Program check exceptions
FAC:          0          0   Facility unavailable exceptions
FPU:      12736       2458   FPU unavailable exceptions
ALT:     108313      24507   ALTIVEC unavailable exceptions
VSX:     408590    4943568   VSX unavailable exceptions
--------------------------------------------------------------

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Changes in V2:
- Fixed some typos in the final /proc/interrupts output
- Added support for alignment and program check exceptions

 arch/powerpc/include/asm/hardirq.h   |  6 ++++++
 arch/powerpc/kernel/exceptions-64s.S |  2 ++
 arch/powerpc/kernel/irq.c            | 35 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/traps.c          | 28 ++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index 8add8b8..ba51d3e 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -15,6 +15,12 @@ typedef struct {
 #ifdef CONFIG_PPC_DOORBELL
 	unsigned int doorbell_irqs;
 #endif
+	unsigned int alignment_exceptions;
+	unsigned int program_exceptions;
+	unsigned int fac_unav_exceptions;
+	unsigned int fpu_unav_exceptions;
+	unsigned int altivec_unav_exceptions;
+	unsigned int vsx_unav_exceptions;
 } ____cacheline_aligned irq_cpustat_t;
 
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0a0399c2..a86180c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1158,6 +1158,7 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
 	bl	load_up_fpu
+	bl	fpu_unav_exceptions_count
 	b	fast_exception_return
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 2:	/* User process was in a transaction */
@@ -1184,6 +1185,7 @@ BEGIN_FTR_SECTION
   END_FTR_SECTION_NESTED(CPU_FTR_TM, CPU_FTR_TM, 69)
 #endif
 	bl	load_up_altivec
+	bl	altivec_unav_exceptions_count
 	b	fast_exception_return
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 2:	/* User process was in a transaction */
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4509603..8b4d928 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -397,6 +397,35 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "  Doorbell interrupts\n");
 	}
 #endif
+	seq_printf(p, "%*s: ", prec, "ALN");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).alignment_exceptions);
+	seq_printf(p, "  Alignment exceptions\n");
+
+	seq_printf(p, "%*s: ", prec, "PRG");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).program_exceptions);
+	seq_printf(p, "  Program check exceptions\n");
+
+	seq_printf(p, "%*s: ", prec, "FAC");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).fac_unav_exceptions);
+	seq_printf(p, "  Facility unavailable exceptions\n");
+
+	seq_printf(p, "%*s: ", prec, "FPU");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).fpu_unav_exceptions);
+	seq_printf(p, "  FPU unavailable exceptions\n");
+
+	seq_printf(p, "%*s: ", prec, "ALT");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).altivec_unav_exceptions);
+	seq_printf(p, "  ALTIVEC unavailable exceptions\n");
+
+	seq_printf(p, "%*s: ", prec, "VSX");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).vsx_unav_exceptions);
+	seq_printf(p, "  VSX unavailable exceptions\n");
 
 	return 0;
 }
@@ -416,6 +445,12 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 #ifdef CONFIG_PPC_DOORBELL
 	sum += per_cpu(irq_stat, cpu).doorbell_irqs;
 #endif
+	sum += per_cpu(irq_stat, cpu).alignment_exceptions;
+	sum += per_cpu(irq_stat, cpu).program_exceptions;
+	sum += per_cpu(irq_stat, cpu).fac_unav_exceptions;
+	sum += per_cpu(irq_stat, cpu).fpu_unav_exceptions;
+	sum += per_cpu(irq_stat, cpu).altivec_unav_exceptions;
+	sum += per_cpu(irq_stat, cpu).vsx_unav_exceptions;
 
 	return sum;
 }
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 6530f1b..9b6511c 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1137,6 +1137,8 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 	enum ctx_state prev_state = exception_enter();
 	unsigned int reason = get_reason(regs);
 
+	__this_cpu_inc(irq_stat.program_exceptions);
+
 	/* We can now get here via a FP Unavailable exception if the core
 	 * has no FPU, in that case the reason flags will be 0 */
 
@@ -1260,6 +1262,8 @@ void alignment_exception(struct pt_regs *regs)
 	enum ctx_state prev_state = exception_enter();
 	int sig, code, fixed = 0;
 
+	__this_cpu_inc(irq_stat.alignment_exceptions);
+
 	/* We restore the interrupt state now */
 	if (!arch_irq_disabled_regs(regs))
 		local_irq_enable();
@@ -1322,6 +1326,8 @@ void kernel_fp_unavailable_exception(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
 
+	__this_cpu_inc(irq_stat.fpu_unav_exceptions);
+
 	printk(KERN_EMERG "Unrecoverable FP Unavailable Exception "
 			  "%lx at %lx\n", regs->trap, regs->nip);
 	die("Unrecoverable FP Unavailable Exception", regs, SIGABRT);
@@ -1333,6 +1339,8 @@ void altivec_unavailable_exception(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
 
+	__this_cpu_inc(irq_stat.altivec_unav_exceptions);
+
 	if (user_mode(regs)) {
 		/* A user program has executed an altivec instruction,
 		   but this kernel doesn't support altivec. */
@@ -1350,6 +1358,8 @@ bail:
 
 void vsx_unavailable_exception(struct pt_regs *regs)
 {
+	__this_cpu_inc(irq_stat.vsx_unav_exceptions);
+
 	if (user_mode(regs)) {
 		/* A user program has executed an vsx instruction,
 		   but this kernel doesn't support vsx. */
@@ -1381,6 +1391,8 @@ void facility_unavailable_exception(struct pt_regs *regs)
 	u8 status;
 	bool hv;
 
+	__this_cpu_inc(irq_stat.fac_unav_exceptions);
+
 	hv = (regs->trap == 0xf80);
 	if (hv)
 		value = mfspr(SPRN_HFSCR);
@@ -1453,10 +1465,22 @@ void facility_unavailable_exception(struct pt_regs *regs)
 }
 #endif
 
+void fpu_unav_exceptions_count(void)
+{
+	__this_cpu_inc(irq_stat.fpu_unav_exceptions);
+}
+
+void altivec_unav_exceptions_count(void)
+{
+	__this_cpu_inc(irq_stat.altivec_unav_exceptions);
+}
+
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 
 void fp_unavailable_tm(struct pt_regs *regs)
 {
+	__this_cpu_inc(irq_stat.fpu_unav_exceptions);
+
 	/* Note:  This does not handle any kind of FP laziness. */
 
 	TM_DEBUG("FP Unavailable trap whilst transactional at 0x%lx, MSR=%lx\n",
@@ -1493,6 +1517,8 @@ void fp_unavailable_tm(struct pt_regs *regs)
 
 void altivec_unavailable_tm(struct pt_regs *regs)
 {
+	__this_cpu_inc(irq_stat.altivec_unav_exceptions);
+
 	/* See the comments in fp_unavailable_tm().  This function operates
 	 * the same way.
 	 */
@@ -1515,6 +1541,8 @@ void vsx_unavailable_tm(struct pt_regs *regs)
 {
 	unsigned long orig_msr = regs->msr;
 
+	__this_cpu_inc(irq_stat.vsx_unav_exceptions);
+
 	/* See the comments in fp_unavailable_tm().  This works similarly,
 	 * though we're loading both FP and VEC registers in here.
 	 *
-- 
2.1.0
