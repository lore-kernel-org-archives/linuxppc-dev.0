Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 054A31A198B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 20:27:09 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A84141402C9
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 20:27:08 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 8 Jul 2015 20:26:57 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EC055357804F
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 20:26:54 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t68AQkRP67043514
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2015 20:26:54 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t68AQMZo021728
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2015 20:26:22 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, mpe@ellerman.id.au
Subject: [PATCH] powerpc/irq: Enable facility unavailable exceptions in
 /proc/interrupts
Date: Wed,  8 Jul 2015 15:56:04 +0530
Message-Id: <1436351164-4835-1-git-send-email-khandual@linux.vnet.ibm.com>
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
respective newly added IRQ statistical counters as and when these IRQs
happen. This also adds multiple helper functions which will be called
from within the interrupt handler context to update their statistics.

	With this patch being applied, /proc/interrupts looks something
like this after running various workloads which create these exceptions.

------------------------------------------------------------------------
           CPU0       CPU1
 16:       4262       6166      XICS   2 Level     IPI
 17:          0          0      XICS 4101 Level     virtio0
 18:          0          0      XICS 4100 Level     ohci_hcd:usb1
 20:          0          0      XICS 4096 Level     RAS_EPOW
 21:       5730       1744      XICS 4102 Level     ibmvscsi
 22:        147          0      XICS 4103 Level     hvc_console
 24:          0          0      XICS 4104 Level     virtio1-config
 25:         19        167      XICS 4105 Level     virtio1-input.0
 26:          1          0      XICS 4106 Level     virtio1-output.0
LOC:       5278       7996   Local timer interrupts for timer event device
LOC:         49         24   Local timer interrupts for others
SPU:          0          0   Spurious interrupts
PMI:          0          0   Performance monitoring interrupts
MCE:          0          0   Machine check exceptions
DBL:          0          0   Doorbell interrupts
FAC:          0          0   Facility unavailable excpetions
FPU:      12172       2549   FPU unavailable excpetions
ALT:      22454       7226   ALTIVEC unavailable excpetions
VSX:         14         90   VSX unavailable excpetions
-----------------------------------------------------------------------

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hardirq.h   |  4 ++++
 arch/powerpc/kernel/exceptions-64s.S |  2 ++
 arch/powerpc/kernel/irq.c            | 23 +++++++++++++++++++++++
 arch/powerpc/kernel/traps.c          | 29 +++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index 8add8b8..bd31390 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -15,6 +15,10 @@ typedef struct {
 #ifdef CONFIG_PPC_DOORBELL
 	unsigned int doorbell_irqs;
 #endif
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
index 4509603..fa6559c 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -397,6 +397,25 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "  Doorbell interrupts\n");
 	}
 #endif
+	seq_printf(p, "%*s: ", prec, "FAC");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).fac_unav_exceptions);
+	seq_printf(p, "  Facility unavailable excpetions\n");
+
+	seq_printf(p, "%*s: ", prec, "FPU");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).fpu_unav_exceptions);
+	seq_printf(p, "  FPU unavailable excpetions\n");
+
+	seq_printf(p, "%*s: ", prec, "ALT");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).altivec_unav_exceptions);
+	seq_printf(p, "  ALTIVEC unavailable excpetions\n");
+
+	seq_printf(p, "%*s: ", prec, "VSX");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).vsx_unav_exceptions);
+	seq_printf(p, "  VSX unavailable excpetions\n");
 
 	return 0;
 }
@@ -416,6 +435,10 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 #ifdef CONFIG_PPC_DOORBELL
 	sum += per_cpu(irq_stat, cpu).doorbell_irqs;
 #endif
+	sum += per_cpu(irq_stat, cpu).fac_unav_exceptions;
+	sum += per_cpu(irq_stat, cpu).fpu_unav_exceptions;
+	sum += per_cpu(irq_stat, cpu).altivec_unav_exceptions;
+	sum += per_cpu(irq_stat, cpu).vsx_unav_exceptions;
 
 	return sum;
 }
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 6530f1b..25fd58d 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1322,6 +1322,8 @@ void kernel_fp_unavailable_exception(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
 
+	__this_cpu_inc(irq_stat.fpu_unav_exceptions);
+
 	printk(KERN_EMERG "Unrecoverable FP Unavailable Exception "
 			  "%lx at %lx\n", regs->trap, regs->nip);
 	die("Unrecoverable FP Unavailable Exception", regs, SIGABRT);
@@ -1333,6 +1335,8 @@ void altivec_unavailable_exception(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
 
+	__this_cpu_inc(irq_stat.altivec_unav_exceptions);
+
 	if (user_mode(regs)) {
 		/* A user program has executed an altivec instruction,
 		   but this kernel doesn't support altivec. */
@@ -1350,6 +1354,8 @@ bail:
 
 void vsx_unavailable_exception(struct pt_regs *regs)
 {
+	__this_cpu_inc(irq_stat.vsx_unav_exceptions);
+
 	if (user_mode(regs)) {
 		/* A user program has executed an vsx instruction,
 		   but this kernel doesn't support vsx. */
@@ -1381,6 +1387,8 @@ void facility_unavailable_exception(struct pt_regs *regs)
 	u8 status;
 	bool hv;
 
+	__this_cpu_inc(irq_stat.fac_unav_exceptions);
+
 	hv = (regs->trap == 0xf80);
 	if (hv)
 		value = mfspr(SPRN_HFSCR);
@@ -1453,10 +1461,27 @@ void facility_unavailable_exception(struct pt_regs *regs)
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
+void vsx_unav_exceptions_count(void)
+{
+	__this_cpu_inc(irq_stat.vsx_unav_exceptions);
+}
+
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 
 void fp_unavailable_tm(struct pt_regs *regs)
 {
+	__this_cpu_inc(irq_stat.fpu_unav_exceptions);
+
 	/* Note:  This does not handle any kind of FP laziness. */
 
 	TM_DEBUG("FP Unavailable trap whilst transactional at 0x%lx, MSR=%lx\n",
@@ -1493,6 +1518,8 @@ void fp_unavailable_tm(struct pt_regs *regs)
 
 void altivec_unavailable_tm(struct pt_regs *regs)
 {
+	__this_cpu_inc(irq_stat.altivec_unav_exceptions);
+
 	/* See the comments in fp_unavailable_tm().  This function operates
 	 * the same way.
 	 */
@@ -1515,6 +1542,8 @@ void vsx_unavailable_tm(struct pt_regs *regs)
 {
 	unsigned long orig_msr = regs->msr;
 
+	__this_cpu_inc(irq_stat.vsx_unav_exceptions);
+
 	/* See the comments in fp_unavailable_tm().  This works similarly,
 	 * though we're loading both FP and VEC registers in here.
 	 *
-- 
2.1.0
