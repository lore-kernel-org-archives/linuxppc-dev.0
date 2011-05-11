Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id E18D3100889
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:41 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <b9e2ff2d16e4647af0047ddbf6146b6c7433ce6c.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:29:39 -0500
Subject: [PATCH 19/37] powerpc: consolidate ipi message mux and demux
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Consolidate the mux and demux of ipi messages into smp.c and call
a new smp_ops callback to actually trigger the ipi.

The powerpc architecture code is optimised for having 4 distinct
ipi triggers, which are mapped to 4 distinct messages (ipi many, ipi
single, scheduler ipi, and enter debugger).  However, several interrupt
controllers only provide a single software triggered interrupt that
can be delivered to each cpu.  To resolve this limitation, each smp_ops
implementation created a per-cpu variable that is manipulated with atomic
bitops.  Since these lines will be contended they are optimialy marked as
shared_aligned and take a full cache line for each cpu.  Distro kernels
may have 2 or 3 of these in their config, each taking per-cpu space
even though at most one will be in use.

This consolidation removes smp_message_recv and replaces the single call
actions cases with direct calls from the common message recognition loop.
The complicated debugger ipi case with its muxed crash handling code is
moved to debug_ipi_action which is now called from the demux code (instead
of the multi-message action calling smp_message_recv).

I put a call to reschedule_action to increase the likelyhood of correctly
merging the anticipated scheduler_ipi() hook coming from the scheduler
tree; that single required call can be inlined later.

The actual message decode is a copy of the old pseries xics code with its
memory barriers and cache line spacing, augmented with a per-cpu unsigned
long based on the book-e doorbell code.  The optional data is set via a
callback from the implementation and is passed to the new cause-ipi hook
along with the logical cpu number.  While currently only the doorbell
implemntation uses this data it should be almost zero cost to retrieve and
pass it -- it adds a single register load for the argument from the same
cache line to which we just completed a store and the register is dead
on return from the call.  I extended the data element from unsigned int
to unsigned long in case some other code wanted to associate a pointer.

The doorbell check_self is replaced by a call to smp_muxed_ipi_resend,
conditioned on the CPU_DBELL feature.  The ifdef guard could be relaxed
to CONFIG_SMP but I left it with BOOKE for now.

Also, the doorbell interrupt vector for book-e was not calling irq_enter
and irq_exit, which throws off cpu accounting and causes code to not
realize it is running in interrupt context.  Add the missing calls.

Signed-off-by: Milton Miller <miltonm@bga.com>
---

This requires patch 3780 be applied first for cell to compile.
---
 arch/powerpc/include/asm/dbell.h       |    3 +-
 arch/powerpc/include/asm/smp.h         |   14 +++--
 arch/powerpc/include/asm/xics.h        |    2 +-
 arch/powerpc/kernel/dbell.c            |   46 +++-------------
 arch/powerpc/kernel/irq.c              |    4 +-
 arch/powerpc/kernel/smp.c              |   92 +++++++++++++++++++++----------
 arch/powerpc/platforms/85xx/smp.c      |    6 ++-
 arch/powerpc/platforms/iseries/irq.c   |    3 +-
 arch/powerpc/platforms/iseries/smp.c   |   23 +-------
 arch/powerpc/platforms/iseries/smp.h   |    6 --
 arch/powerpc/platforms/powermac/smp.c  |   27 ++-------
 arch/powerpc/platforms/pseries/smp.c   |    3 +-
 arch/powerpc/sysdev/xics/icp-hv.c      |   10 +---
 arch/powerpc/sysdev/xics/icp-native.c  |   10 +---
 arch/powerpc/sysdev/xics/xics-common.c |   30 +----------
 15 files changed, 107 insertions(+), 172 deletions(-)
 delete mode 100644 arch/powerpc/platforms/iseries/smp.h

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 3269eb4..9c70d0c 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -27,9 +27,8 @@ enum ppc_dbell {
 	PPC_G_DBELL_MC = 4,	/* guest mcheck doorbell */
 };
 
-extern void doorbell_message_pass(int cpu, int msg);
+extern void doorbell_cause_ipi(int cpu, unsigned long data);
 extern void doorbell_exception(struct pt_regs *regs);
-extern void doorbell_check_self(void);
 extern void doorbell_setup_this_cpu(void);
 
 static inline void ppc_msgsnd(enum ppc_dbell type, u32 flags, u32 tag)
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 6f7c95c..9ae64bf 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -20,6 +20,7 @@
 #include <linux/threads.h>
 #include <linux/cpumask.h>
 #include <linux/kernel.h>
+#include <linux/irqreturn.h>
 
 #ifndef __ASSEMBLY__
 
@@ -37,6 +38,7 @@ extern void cpu_die(void);
 
 struct smp_ops_t {
 	void  (*message_pass)(int cpu, int msg);
+	void  (*cause_ipi)(int cpu, unsigned long data);
 	int   (*probe)(void);
 	int   (*kick_cpu)(int nr);
 	void  (*setup_cpu)(int nr);
@@ -49,7 +51,6 @@ struct smp_ops_t {
 };
 
 extern void smp_send_debugger_break(void);
-extern void smp_message_recv(int);
 extern void start_secondary_resume(void);
 extern void __devinit smp_generic_give_timebase(void);
 extern void __devinit smp_generic_take_timebase(void);
@@ -109,13 +110,16 @@ extern int cpu_to_core_id(int cpu);
 #define PPC_MSG_CALL_FUNC_SINGLE	2
 #define PPC_MSG_DEBUGGER_BREAK  3
 
-/*
- * irq controllers that have dedicated ipis per message and don't
- * need additional code in the action handler may use this
- */
+/* for irq controllers that have dedicated ipis per message (4) */
 extern int smp_request_message_ipi(int virq, int message);
 extern const char *smp_ipi_name[];
 
+/* for irq controllers with only a single ipi */
+extern void smp_muxed_ipi_set_data(int cpu, unsigned long data);
+extern void smp_muxed_ipi_message_pass(int cpu, int msg);
+extern void smp_muxed_ipi_resend(void);
+extern irqreturn_t smp_ipi_demux(void);
+
 void smp_init_iSeries(void);
 void smp_init_pSeries(void);
 void smp_init_cell(void);
diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
index 1750c8d..b183a40 100644
--- a/arch/powerpc/include/asm/xics.h
+++ b/arch/powerpc/include/asm/xics.h
@@ -40,7 +40,7 @@ struct icp_ops {
 	void (*teardown_cpu)(void);
 	void (*flush_ipi)(void);
 #ifdef CONFIG_SMP
-	void (*message_pass)(int cpu, int msg);
+	void (*cause_ipi)(int cpu, unsigned long data);
 	irq_handler_t ipi_action;
 #endif
 };
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index e49b24c..2cc451a 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -13,65 +13,35 @@
 #include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/threads.h>
-#include <linux/percpu.h>
+#include <linux/hardirq.h>
 
 #include <asm/dbell.h>
 #include <asm/irq_regs.h>
 
 #ifdef CONFIG_SMP
-struct doorbell_cpu_info {
-	unsigned long	messages;	/* current messages bits */
-	unsigned int	tag;		/* tag value */
-};
-
-static DEFINE_PER_CPU(struct doorbell_cpu_info, doorbell_cpu_info);
-
 void doorbell_setup_this_cpu(void)
 {
-	struct doorbell_cpu_info *info = &__get_cpu_var(doorbell_cpu_info);
+	unsigned long tag = mfspr(SPRN_PIR) & 0x3fff;
 
-	info->messages = 0;
-	info->tag = mfspr(SPRN_PIR) & 0x3fff;
+	smp_muxed_ipi_set_data(smp_processor_id(), tag);
 }
 
-void doorbell_message_pass(int cpu, int msg)
+void doorbell_cause_ipi(int cpu, unsigned long data)
 {
-	struct doorbell_cpu_info *info;
-
-	info = &per_cpu(doorbell_cpu_info, cpu);
-	set_bit(msg, &info->messages);
-	ppc_msgsnd(PPC_DBELL, 0, info->tag);
+	ppc_msgsnd(PPC_DBELL, 0, data);
 }
 
 void doorbell_exception(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	struct doorbell_cpu_info *info = &__get_cpu_var(doorbell_cpu_info);
-	int msg;
 
-	/* Warning: regs can be NULL when called from irq enable */
+	irq_enter();
 
-	if (!info->messages || (num_online_cpus() < 2))
-		goto out;
+	smp_ipi_demux();
 
-	for (msg = 0; msg < 4; msg++)
-		if (test_and_clear_bit(msg, &info->messages))
-			smp_message_recv(msg);
-
-out:
+	irq_exit();
 	set_irq_regs(old_regs);
 }
-
-void doorbell_check_self(void)
-{
-	struct doorbell_cpu_info *info = &__get_cpu_var(doorbell_cpu_info);
-
-	if (!info->messages)
-		return;
-
-	ppc_msgsnd(PPC_DBELL, 0, info->tag);
-}
-
 #else /* CONFIG_SMP */
 void doorbell_exception(struct pt_regs *regs)
 {
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index a81dd74..826552c 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -66,7 +66,6 @@
 #include <asm/ptrace.h>
 #include <asm/machdep.h>
 #include <asm/udbg.h>
-#include <asm/dbell.h>
 #include <asm/smp.h>
 
 #ifdef CONFIG_PPC64
@@ -160,7 +159,8 @@ notrace void arch_local_irq_restore(unsigned long en)
 
 #if defined(CONFIG_BOOKE) && defined(CONFIG_SMP)
 	/* Check for pending doorbell interrupts and resend to ourself */
-	doorbell_check_self();
+	if (cpu_has_feature(CPU_FTR_DBELL))
+		smp_muxed_ipi_resend();
 #endif
 
 	/*
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index b744114..72717e1 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -111,35 +111,6 @@ int __devinit smp_generic_kick_cpu(int nr)
 }
 #endif
 
-void smp_message_recv(int msg)
-{
-	switch(msg) {
-	case PPC_MSG_CALL_FUNCTION:
-		generic_smp_call_function_interrupt();
-		break;
-	case PPC_MSG_RESCHEDULE:
-		/* we notice need_resched on exit */
-		break;
-	case PPC_MSG_CALL_FUNC_SINGLE:
-		generic_smp_call_function_single_interrupt();
-		break;
-	case PPC_MSG_DEBUGGER_BREAK:
-		if (crash_ipi_function_ptr) {
-			crash_ipi_function_ptr(get_irq_regs());
-			break;
-		}
-#ifdef CONFIG_DEBUGGER
-		debugger_ipi(get_irq_regs());
-		break;
-#endif /* CONFIG_DEBUGGER */
-		/* FALLTHROUGH */
-	default:
-		printk("SMP %d: smp_message_recv(): unknown msg %d\n",
-		       smp_processor_id(), msg);
-		break;
-	}
-}
-
 static irqreturn_t call_function_action(int irq, void *data)
 {
 	generic_smp_call_function_interrupt();
@@ -160,7 +131,15 @@ static irqreturn_t call_function_single_action(int irq, void *data)
 
 static irqreturn_t debug_ipi_action(int irq, void *data)
 {
-	smp_message_recv(PPC_MSG_DEBUGGER_BREAK);
+	if (crash_ipi_function_ptr) {
+		crash_ipi_function_ptr(get_irq_regs());
+		return IRQ_HANDLED;
+	}
+
+#ifdef CONFIG_DEBUGGER
+	debugger_ipi(get_irq_regs());
+#endif /* CONFIG_DEBUGGER */
+
 	return IRQ_HANDLED;
 }
 
@@ -199,6 +178,59 @@ int smp_request_message_ipi(int virq, int msg)
 	return err;
 }
 
+struct cpu_messages {
+	unsigned long messages;		/* current messages bits */
+	unsigned long data;		/* data for cause ipi */
+};
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct cpu_messages, ipi_message);
+
+void smp_muxed_ipi_set_data(int cpu, unsigned long data)
+{
+	struct cpu_messages *info = &per_cpu(ipi_message, cpu);
+
+	info->data = data;
+}
+
+void smp_muxed_ipi_message_pass(int cpu, int msg)
+{
+	struct cpu_messages *info = &per_cpu(ipi_message, cpu);
+	unsigned long *tgt = &info->messages;
+
+	set_bit(msg, tgt);
+	mb();
+	smp_ops->cause_ipi(cpu, info->data);
+}
+
+void smp_muxed_ipi_resend(void)
+{
+	struct cpu_messages *info = &__get_cpu_var(ipi_message);
+	unsigned long *tgt = &info->messages;
+
+	if (*tgt)
+		smp_ops->cause_ipi(smp_processor_id(), info->data);
+}
+
+irqreturn_t smp_ipi_demux(void)
+{
+	struct cpu_messages *info = &__get_cpu_var(ipi_message);
+	unsigned long *tgt = &info->messages;
+
+	mb();	/* order any irq clear */
+	while (*tgt) {
+		if (test_and_clear_bit(PPC_MSG_CALL_FUNCTION, tgt))
+			generic_smp_call_function_interrupt();
+		if (test_and_clear_bit(PPC_MSG_RESCHEDULE, tgt))
+			reschedule_action(0, NULL); /* upcoming sched hook */
+		if (test_and_clear_bit(PPC_MSG_CALL_FUNC_SINGLE, tgt))
+			generic_smp_call_function_single_interrupt();
+#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
+		if (test_and_clear_bit(PPC_MSG_DEBUGGER_BREAK, tgt))
+			debug_ipi_action(0, NULL);
+#endif
+	}
+	return IRQ_HANDLED;
+}
+
 void smp_send_reschedule(int cpu)
 {
 	if (likely(smp_ops))
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index fe3f6a3..d6a93a1 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -235,8 +235,10 @@ void __init mpc85xx_smp_init(void)
 		smp_85xx_ops.message_pass = smp_mpic_message_pass;
 	}
 
-	if (cpu_has_feature(CPU_FTR_DBELL))
-		smp_85xx_ops.message_pass = doorbell_message_pass;
+	if (cpu_has_feature(CPU_FTR_DBELL)) {
+		smp_85xx_ops.message_pass = smp_muxed_ipi_message_pass;
+		smp_85xx_ops.cause_ipi = doorbell_cause_ipi;
+	}
 
 	BUG_ON(!smp_85xx_ops.message_pass);
 
diff --git a/arch/powerpc/platforms/iseries/irq.c b/arch/powerpc/platforms/iseries/irq.c
index 375c21c..b210345 100644
--- a/arch/powerpc/platforms/iseries/irq.c
+++ b/arch/powerpc/platforms/iseries/irq.c
@@ -42,7 +42,6 @@
 #include "irq.h"
 #include "pci.h"
 #include "call_pci.h"
-#include "smp.h"
 
 #ifdef CONFIG_PCI
 
@@ -316,7 +315,7 @@ unsigned int iSeries_get_irq(void)
 #ifdef CONFIG_SMP
 	if (get_lppaca()->int_dword.fields.ipi_cnt) {
 		get_lppaca()->int_dword.fields.ipi_cnt = 0;
-		iSeries_smp_message_recv();
+		smp_ipi_demux();
 	}
 #endif /* CONFIG_SMP */
 	if (hvlpevent_is_pending())
diff --git a/arch/powerpc/platforms/iseries/smp.c b/arch/powerpc/platforms/iseries/smp.c
index dcdbc5d..e3265ad 100644
--- a/arch/powerpc/platforms/iseries/smp.c
+++ b/arch/powerpc/platforms/iseries/smp.c
@@ -42,26 +42,8 @@
 #include <asm/cputable.h>
 #include <asm/system.h>
 
-#include "smp.h"
-
-static unsigned long iSeries_smp_message[NR_CPUS];
-
-void iSeries_smp_message_recv(void)
-{
-	int cpu = smp_processor_id();
-	int msg;
-
-	if (num_online_cpus() < 2)
-		return;
-
-	for (msg = 0; msg < 4; msg++)
-		if (test_and_clear_bit(msg, &iSeries_smp_message[cpu]))
-			smp_message_recv(msg);
-}
-
-static void smp_iSeries_message_pass(int cpu, int msg)
+static void smp_iSeries_cause_ipi(int cpu, unsigned long data)
 {
-	set_bit(msg, &iSeries_smp_message[cpu]);
 	HvCall_sendIPI(&(paca[cpu]));
 }
 
@@ -93,7 +75,8 @@ static void __devinit smp_iSeries_setup_cpu(int nr)
 }
 
 static struct smp_ops_t iSeries_smp_ops = {
-	.message_pass = smp_iSeries_message_pass,
+	.message_pass = smp_muxed_ipi_message_pass,
+	.cause_ipi    = smp_iSeries_cause_ipi,
 	.probe        = smp_iSeries_probe,
 	.kick_cpu     = smp_iSeries_kick_cpu,
 	.setup_cpu    = smp_iSeries_setup_cpu,
diff --git a/arch/powerpc/platforms/iseries/smp.h b/arch/powerpc/platforms/iseries/smp.h
deleted file mode 100644
index d501f7d..0000000
--- a/arch/powerpc/platforms/iseries/smp.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _PLATFORMS_ISERIES_SMP_H
-#define _PLATFORMS_ISERIES_SMP_H
-
-extern void iSeries_smp_message_recv(void);
-
-#endif	/* _PLATFORMS_ISERIES_SMP_H */
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index c49e719..a340107 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -156,28 +156,13 @@ static inline void psurge_clr_ipi(int cpu)
 /*
  * On powersurge (old SMP powermac architecture) we don't have
  * separate IPIs for separate messages like openpic does.  Instead
- * we have a bitmap for each processor, where a 1 bit means that
- * the corresponding message is pending for that processor.
- * Ideally each cpu's entry would be in a different cache line.
+ * use the generic demux helpers
  *  -- paulus.
  */
-static unsigned long psurge_smp_message[NR_CPUS];
-
 void psurge_smp_message_recv(void)
 {
-	int cpu = smp_processor_id();
-	int msg;
-
-	/* clear interrupt */
-	psurge_clr_ipi(cpu);
-
-	if (num_online_cpus() < 2)
-		return;
-
-	/* make sure there is a message there */
-	for (msg = 0; msg < 4; msg++)
-		if (test_and_clear_bit(msg, &psurge_smp_message[cpu]))
-			smp_message_recv(msg);
+	psurge_clr_ipi(smp_processor_id());
+	smp_ipi_demux();
 }
 
 irqreturn_t psurge_primary_intr(int irq, void *d)
@@ -186,9 +171,8 @@ irqreturn_t psurge_primary_intr(int irq, void *d)
 	return IRQ_HANDLED;
 }
 
-static void smp_psurge_message_pass(int cpu, int msg)
+static void smp_psurge_cause_ipi(int cpu, unsigned long data)
 {
-	set_bit(msg, &psurge_smp_message[cpu]);
 	psurge_set_ipi(cpu);
 }
 
@@ -428,7 +412,8 @@ void __init smp_psurge_give_timebase(void)
 
 /* PowerSurge-style Macs */
 struct smp_ops_t psurge_smp_ops = {
-	.message_pass	= smp_psurge_message_pass,
+	.message_pass	= smp_muxed_ipi_message_pass,
+	.cause_ipi	= smp_psurge_cause_ipi,
 	.probe		= smp_psurge_probe,
 	.kick_cpu	= smp_psurge_kick_cpu,
 	.setup_cpu	= smp_psurge_setup_cpu,
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 95f5781..fbffd7e 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -207,7 +207,8 @@ static struct smp_ops_t pSeries_mpic_smp_ops = {
 };
 
 static struct smp_ops_t pSeries_xics_smp_ops = {
-	.message_pass	= NULL,	/* Filled at runtime by xics_smp_probe() */
+	.message_pass	= smp_muxed_ipi_message_pass,
+	.cause_ipi	= NULL,	/* Filled at runtime by xics_smp_probe() */
 	.probe		= xics_smp_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
 	.setup_cpu	= smp_xics_setup_cpu,
diff --git a/arch/powerpc/sysdev/xics/icp-hv.c b/arch/powerpc/sysdev/xics/icp-hv.c
index 234764c..9518d36 100644
--- a/arch/powerpc/sysdev/xics/icp-hv.c
+++ b/arch/powerpc/sysdev/xics/icp-hv.c
@@ -118,12 +118,8 @@ static void icp_hv_set_cpu_priority(unsigned char cppr)
 
 #ifdef CONFIG_SMP
 
-static void icp_hv_message_pass(int cpu, int msg)
+static void icp_hv_cause_ipi(int cpu, unsigned long data)
 {
-	unsigned long *tgt = &per_cpu(xics_ipi_message, cpu);
-
-	set_bit(msg, tgt);
-	mb();
 	icp_hv_set_qirr(cpu, IPI_PRIORITY);
 }
 
@@ -133,7 +129,7 @@ static irqreturn_t icp_hv_ipi_action(int irq, void *dev_id)
 
 	icp_hv_set_qirr(cpu, 0xff);
 
-	return xics_ipi_dispatch(cpu);
+	return smp_ipi_demux();
 }
 
 #endif /* CONFIG_SMP */
@@ -146,7 +142,7 @@ static const struct icp_ops icp_hv_ops = {
 	.flush_ipi	= icp_hv_flush_ipi,
 #ifdef CONFIG_SMP
 	.ipi_action	= icp_hv_ipi_action,
-	.message_pass	= icp_hv_message_pass,
+	.cause_ipi	= icp_hv_cause_ipi,
 #endif
 };
 
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index 246500e..1f15ad4 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -134,12 +134,8 @@ static unsigned int icp_native_get_irq(void)
 
 #ifdef CONFIG_SMP
 
-static void icp_native_message_pass(int cpu, int msg)
+static void icp_native_cause_ipi(int cpu, unsigned long data)
 {
-	unsigned long *tgt = &per_cpu(xics_ipi_message, cpu);
-
-	set_bit(msg, tgt);
-	mb();
 	icp_native_set_qirr(cpu, IPI_PRIORITY);
 }
 
@@ -149,7 +145,7 @@ static irqreturn_t icp_native_ipi_action(int irq, void *dev_id)
 
 	icp_native_set_qirr(cpu, 0xff);
 
-	return xics_ipi_dispatch(cpu);
+	return smp_ipi_demux();
 }
 
 #endif /* CONFIG_SMP */
@@ -267,7 +263,7 @@ static const struct icp_ops icp_native_ops = {
 	.flush_ipi	= icp_native_flush_ipi,
 #ifdef CONFIG_SMP
 	.ipi_action	= icp_native_ipi_action,
-	.message_pass	= icp_native_message_pass,
+	.cause_ipi	= icp_native_cause_ipi,
 #endif
 };
 
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index a0576b7..a31a710 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -126,32 +126,6 @@ void xics_mask_unknown_vec(unsigned int vec)
 
 #ifdef CONFIG_SMP
 
-DEFINE_PER_CPU_SHARED_ALIGNED(unsigned long, xics_ipi_message);
-
-irqreturn_t xics_ipi_dispatch(int cpu)
-{
-	unsigned long *tgt = &per_cpu(xics_ipi_message, cpu);
-
-	mb();	/* order mmio clearing qirr */
-	while (*tgt) {
-		if (test_and_clear_bit(PPC_MSG_CALL_FUNCTION, tgt)) {
-			smp_message_recv(PPC_MSG_CALL_FUNCTION);
-		}
-		if (test_and_clear_bit(PPC_MSG_RESCHEDULE, tgt)) {
-			smp_message_recv(PPC_MSG_RESCHEDULE);
-		}
-		if (test_and_clear_bit(PPC_MSG_CALL_FUNC_SINGLE, tgt)) {
-			smp_message_recv(PPC_MSG_CALL_FUNC_SINGLE);
-		}
-#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
-		if (test_and_clear_bit(PPC_MSG_DEBUGGER_BREAK, tgt)) {
-			smp_message_recv(PPC_MSG_DEBUGGER_BREAK);
-		}
-#endif
-	}
-	return IRQ_HANDLED;
-}
-
 static void xics_request_ipi(void)
 {
 	unsigned int ipi;
@@ -170,8 +144,8 @@ static void xics_request_ipi(void)
 
 int __init xics_smp_probe(void)
 {
-	/* Setup message_pass callback  based on which ICP is used */
-	smp_ops->message_pass = icp_ops->message_pass;
+	/* Setup cause_ipi callback  based on which ICP is used */
+	smp_ops->cause_ipi = icp_ops->cause_ipi;
 
 	/* Register all the IPIs */
 	xics_request_ipi();
-- 
1.7.0.4
