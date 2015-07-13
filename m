Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3CC11A02BE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 18:17:03 +1000 (AEST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 18221140773
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 18:17:02 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 13 Jul 2015 13:46:59 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6327D394005B
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 13:46:56 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6D8GtbD37617752
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 13:46:55 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6D71H0h004484
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 12:31:18 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, mpe@ellerman.id.au
Subject: [PATCH V3] powerpc/irq: Enable some more exceptions in
 /proc/interrupts interface
Date: Mon, 13 Jul 2015 13:46:06 +0530
Message-Id: <1436775366-21945-1-git-send-email-khandual@linux.vnet.ibm.com>
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
 16:       5734      24129      XICS   2 Level     IPI
 17:          0          0      XICS 4101 Level     virtio0
 18:          0          0      XICS 4100 Level     ohci_hcd:usb1
 19:      13920          0      XICS 4099 Level     virtio1
 20:          0          0      XICS 4096 Level     RAS_EPOW
 21:       6160       3241      XICS 4102 Level     ibmvscsi
 22:          1          0      XICS 4103 Level     hvc_console
LOC:       6825       3556   Local timer interrupts for timer event device
LOC:         22         41   Local timer interrupts for others
SPU:          1          0   Spurious interrupts
PMI:          0          0   Performance monitoring interrupts
MCE:          0          0   Machine check exceptions
DBL:          0          0   Doorbell interrupts
ALN:          0          0   Alignment exceptions
PRG:          0          0   Program check exceptions
FAC:          7         14   Facility unavailable exceptions
FPU:       2928       3162   FPU unavailable exceptions
ALT:      12950      15536   AltiVec unavailable exceptions
VSX:      12930     220183   VSX unavailable exceptions
--------------------------------------------------------------

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Changes in V3:
- Changed the display string from "ALTIVEC" to "AltiVec"
- Now captured "Facility unavailable exceptions" in the example

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
index 4509603..60773b3 100644
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
+	seq_printf(p, "  AltiVec unavailable exceptions\n");
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
index 37de90f..d6248c4 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1139,6 +1139,8 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 	enum ctx_state prev_state = exception_enter();
 	unsigned int reason = get_reason(regs);
 
+	__this_cpu_inc(irq_stat.program_exceptions);
+
 	/* We can now get here via a FP Unavailable exception if the core
 	 * has no FPU, in that case the reason flags will be 0 */
 
@@ -1262,6 +1264,8 @@ void alignment_exception(struct pt_regs *regs)
 	enum ctx_state prev_state = exception_enter();
 	int sig, code, fixed = 0;
 
+	__this_cpu_inc(irq_stat.alignment_exceptions);
+
 	/* We restore the interrupt state now */
 	if (!arch_irq_disabled_regs(regs))
 		local_irq_enable();
@@ -1324,6 +1328,8 @@ void kernel_fp_unavailable_exception(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
 
+	__this_cpu_inc(irq_stat.fpu_unav_exceptions);
+
 	printk(KERN_EMERG "Unrecoverable FP Unavailable Exception "
 			  "%lx at %lx\n", regs->trap, regs->nip);
 	die("Unrecoverable FP Unavailable Exception", regs, SIGABRT);
@@ -1335,6 +1341,8 @@ void altivec_unavailable_exception(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
 
+	__this_cpu_inc(irq_stat.altivec_unav_exceptions);
+
 	if (user_mode(regs)) {
 		/* A user program has executed an altivec instruction,
 		   but this kernel doesn't support altivec. */
@@ -1352,6 +1360,8 @@ bail:
 
 void vsx_unavailable_exception(struct pt_regs *regs)
 {
+	__this_cpu_inc(irq_stat.vsx_unav_exceptions);
+
 	if (user_mode(regs)) {
 		/* A user program has executed an vsx instruction,
 		   but this kernel doesn't support vsx. */
@@ -1383,6 +1393,8 @@ void facility_unavailable_exception(struct pt_regs *regs)
 	u8 status;
 	bool hv;
 
+	__this_cpu_inc(irq_stat.fac_unav_exceptions);
+
 	hv = (regs->trap == 0xf80);
 	if (hv)
 		value = mfspr(SPRN_HFSCR);
@@ -1455,10 +1467,22 @@ void facility_unavailable_exception(struct pt_regs *regs)
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
@@ -1495,6 +1519,8 @@ void fp_unavailable_tm(struct pt_regs *regs)
 
 void altivec_unavailable_tm(struct pt_regs *regs)
 {
+	__this_cpu_inc(irq_stat.altivec_unav_exceptions);
+
 	/* See the comments in fp_unavailable_tm().  This function operates
 	 * the same way.
 	 */
@@ -1517,6 +1543,8 @@ void vsx_unavailable_tm(struct pt_regs *regs)
 {
 	unsigned long orig_msr = regs->msr;
 
+	__this_cpu_inc(irq_stat.vsx_unav_exceptions);
+
 	/* See the comments in fp_unavailable_tm().  This works similarly,
 	 * though we're loading both FP and VEC registers in here.
 	 *
-- 
2.1.0
