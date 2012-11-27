Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 10/16] powerpc: Add transactional memory unavaliable execption
 handler
Date: Tue, 27 Nov 2012 13:48:02 +1100
Message-Id: <1353984488-1283-11-git-send-email-mikey@neuling.org>
In-Reply-To: <1353984488-1283-1-git-send-email-mikey@neuling.org>
References: <1353984488-1283-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These should never happen since we always turn on MSR TM when in userspace. We
don't do lazy TM.

Hence if we hit this, we barf and kill the task as something's gone horribly
wrong.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/exceptions-64s.S |   19 +++++++++++++++++++
 arch/powerpc/kernel/traps.c          |   21 +++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 32fc04f..d97cea4 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -313,6 +313,9 @@ vsx_unavailable_pSeries_1:
 	. = 0xf40
 	b	vsx_unavailable_pSeries
 
+	. = 0xf60
+	b	tm_unavailable_pSeries
+
 #ifdef CONFIG_CBE_RAS
 	STD_EXCEPTION_HV(0x1200, 0x1202, cbe_system_error)
 	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1202)
@@ -526,6 +529,8 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_206)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf20)
 	STD_EXCEPTION_PSERIES(., 0xf40, vsx_unavailable)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf40)
+	STD_EXCEPTION_PSERIES(., 0xf60, tm_unavailable)
+	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf60)
 
 /*
  * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
@@ -815,6 +820,10 @@ vsx_unavailable_relon_pSeries_1:
 	. = 0x4f40
 	b	vsx_unavailable_relon_pSeries
 
+tm_unavailable_relon_pSeries_1:
+	. = 0x4f60
+	b	tm_unavailable_relon_pSeries
+
 #ifdef CONFIG_CBE_RAS
 	STD_RELON_EXCEPTION_HV(0x5200, 0x1202, cbe_system_error)
 #endif /* CONFIG_CBE_RAS */
@@ -1174,6 +1183,15 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	b	.ret_from_except
 
 	.align	7
+	.globl tm_unavailable_common
+tm_unavailable_common:
+	EXCEPTION_PROLOG_COMMON(0xf60, PACA_EXGEN)
+	bl	.save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.tm_unavailable_exception
+	b	.ret_from_except
+
+	.align	7
 	.globl	__end_handlers
 __end_handlers:
 
@@ -1387,6 +1405,7 @@ _GLOBAL(do_stab_bolted)
 	STD_RELON_EXCEPTION_PSERIES(., 0xf00, performance_monitor)
 	STD_RELON_EXCEPTION_PSERIES(., 0xf20, altivec_unavailable)
 	STD_RELON_EXCEPTION_PSERIES(., 0xf40, vsx_unavailable)
+	STD_RELON_EXCEPTION_PSERIES(., 0xf60, tm_unavailable)
 
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 /*
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 8fed874..4acd98d 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1171,6 +1171,27 @@ void vsx_unavailable_exception(struct pt_regs *regs)
 	die("Unrecoverable VSX Unavailable Exception", regs, SIGABRT);
 }
 
+void tm_unavailable_exception(struct pt_regs *regs)
+{
+	/* We restore the interrupt state now */
+	if (!arch_irq_disabled_regs(regs))
+		local_irq_enable();
+
+	/* Currently we never expect a TMU exception.  Catch
+	 * this and kill the process!
+	 */
+	printk(KERN_EMERG "Unexpected TM unavailable exception at %lx "
+	       "(msr %lx)\n",
+	       regs->nip, regs->msr);
+
+	if (user_mode(regs)) {
+		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
+		return;
+	}
+
+	die("Unexpected TM unavailable exception", regs, SIGABRT);
+}
+
 void performance_monitor_exception(struct pt_regs *regs)
 {
 	__get_cpu_var(irq_stat).pmu_irqs++;
-- 
1.7.9.5
