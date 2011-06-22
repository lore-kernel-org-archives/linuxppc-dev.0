Return-Path: <B07421@freescale.com>
Received: from CH1EHSOBE013.bigfish.com (ch1ehsobe005.messaging.microsoft.com
	[216.32.181.185]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 936D2B6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jun 2011 07:19:58 +1000 (EST)
Date: Wed, 22 Jun 2011 16:19:49 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH v2] powerpc/book3e-64: reraise doorbell when masked by
	soft-irq-disable
Message-ID: <20110622211949.GA23063@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: Remove the soft irq enable code made unnecessary by this.

 arch/powerpc/include/asm/smp.h       |    1 -
 arch/powerpc/kernel/exceptions-64e.S |   22 +++++++++++++++++++++-
 arch/powerpc/kernel/irq.c            |    6 ------
 arch/powerpc/kernel/smp.c            |    8 --------
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index b2a4c2d..15a70b7 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -119,7 +119,6 @@ extern const char *smp_ipi_name[];
 /* for irq controllers with only a single ipi */
 extern void smp_muxed_ipi_set_data(int cpu, unsigned long data);
 extern void smp_muxed_ipi_message_pass(int cpu, int msg);
-extern void smp_muxed_ipi_resend(void);
 extern irqreturn_t smp_ipi_demux(void);
 
 void smp_init_iSeries(void);
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index d24d440..429983c 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -120,6 +120,12 @@
 	std	r14,PACA_EXMC+EX_R14(r13);				    \
 	std	r15,PACA_EXMC+EX_R15(r13)
 
+#define PROLOG_ADDITION_DOORBELL_GEN					    \
+	lbz	r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
+	cmpwi	cr0,r11,0;		/* yes -> go out of line */	    \
+	beq	masked_doorbell_book3e
+
+
 /* Core exception code for all exceptions except TLB misses.
  * XXX: Needs to make SPRN_SPRG_GEN depend on exception type
  */
@@ -522,7 +528,13 @@ kernel_dbg_exc:
 	MASKABLE_EXCEPTION(0x260, perfmon, .performance_monitor_exception, ACK_NONE)
 
 /* Doorbell interrupt */
-	MASKABLE_EXCEPTION(0x2070, doorbell, .doorbell_exception, ACK_NONE)
+	START_EXCEPTION(doorbell)
+	NORMAL_EXCEPTION_PROLOG(0x2070, PROLOG_ADDITION_DOORBELL)
+	EXCEPTION_COMMON(0x2070, PACA_EXGEN, INTS_DISABLE_ALL)
+	CHECK_NAPPING()
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.doorbell_exception
+	b	.ret_from_except_lite
 
 /* Doorbell critical Interrupt */
 	START_EXCEPTION(doorbell_crit);
@@ -545,8 +557,16 @@ kernel_dbg_exc:
  * An interrupt came in while soft-disabled; clear EE in SRR1,
  * clear paca->hard_enabled and return.
  */
+masked_doorbell_book3e:
+	mtcr	r10
+	/* Resend the doorbell to fire again when ints enabled */
+	mfspr	r10,SPRN_PIR
+	PPC_MSGSND(r10)
+	b	masked_interrupt_book3e_common
+
 masked_interrupt_book3e:
 	mtcr	r10
+masked_interrupt_book3e_common:
 	stb	r11,PACAHARDIRQEN(r13)
 	mfspr	r10,SPRN_SRR1
 	rldicl	r11,r10,48,1		/* clear MSR_EE */
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 5b428e3..62f5457 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -157,12 +157,6 @@ notrace void arch_local_irq_restore(unsigned long en)
 	if (get_hard_enabled())
 		return;
 
-#if defined(CONFIG_BOOKE) && defined(CONFIG_SMP)
-	/* Check for pending doorbell interrupts and resend to ourself */
-	if (cpu_has_feature(CPU_FTR_DBELL))
-		smp_muxed_ipi_resend();
-#endif
-
 	/*
 	 * Need to hard-enable interrupts here.  Since currently disabled,
 	 * no need to take further asm precautions against preemption; but
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 2975f64..6c8e739 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -202,14 +202,6 @@ void smp_muxed_ipi_message_pass(int cpu, int msg)
 	smp_ops->cause_ipi(cpu, info->data);
 }
 
-void smp_muxed_ipi_resend(void)
-{
-	struct cpu_messages *info = &__get_cpu_var(ipi_message);
-
-	if (info->messages)
-		smp_ops->cause_ipi(smp_processor_id(), info->data);
-}
-
 irqreturn_t smp_ipi_demux(void)
 {
 	struct cpu_messages *info = &__get_cpu_var(ipi_message);
-- 
1.7.4.1
