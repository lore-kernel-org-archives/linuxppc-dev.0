Date: Fri, 2 Nov 2001 00:18:34 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: APUS irq patch
Message-ID: <Pine.LNX.4.33.0111020007080.8971-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Here is the next APUS patch. The patch applies basically to stable and
devel (only the last patch fails on stable, but can be ignored).
This patch converts the irq assembly in head.S into C, the only problem is
that I needed to change a prototype in <linux/irq.h>, as some additional
info has to be saved/restored during an irq.

bye, Roman

--- arch/ppc/kernel/apus_setup.c	2001/10/25 19:30:42	1.1.1.14
+++ arch/ppc/kernel/apus_setup.c	2001/10/29 23:09:38	1.26
@@ -755,30 +708,39 @@
 int apus_get_irq(struct pt_regs* regs)
 {
 #ifdef CONFIG_APUS
-	int level = apus_get_IPL();
+	unsigned char ipl_emu;
+	unsigned int level;

+	APUS_WRITE(APUS_IPL_EMU, IPLEMU_SETRESET|IPLEMU_DISABLEINT);
+	APUS_READ(APUS_IPL_EMU, ipl_emu);
+	regs->mq = ipl_emu;
+
+	level = (ipl_emu >> 3) & 7;
+	APUS_WRITE(APUS_IPL_EMU, IPLEMU_SETRESET|level);
+	level ^= 7;
+	APUS_WRITE(APUS_IPL_EMU, IPLEMU_DISABLEINT|level);
+
 #ifdef __INTERRUPT_DEBUG
 	printk("<%d:%d>", level, apus_get_prev_IPL(regs));
 #endif

-	if (0 == level)
-		return -8;
-	if (7 == level)
-		return -9;
-
 	return level + IRQ_AMIGA_AUTO;
 #else
 	return 0;
 #endif
 }
+

-void apus_post_irq(struct pt_regs* regs, int level)
+void apus_end_irq(struct pt_regs* regs, unsigned int irq)
 {
+	unsigned char ipl_emu;
 #ifdef __INTERRUPT_DEBUG
 	printk("{%d}", apus_get_prev_IPL(regs));
 #endif
-	/* Restore IPL to the previous value */
-	apus_set_IPL(apus_get_prev_IPL(regs));
+	ipl_emu = regs->mq & 7;
+	APUS_WRITE(APUS_IPL_EMU, IPLEMU_SETRESET|ipl_emu);
+	ipl_emu ^= 7;
+	APUS_WRITE(APUS_IPL_EMU, ipl_emu);
 }

 /****************************************************** keyboard */
@@ -958,6 +926,7 @@
 	amiga_enable_irq,
 	amiga_disable_irq,
 	0,
+	apus_end_irq,
 	0
 };

@@ -1074,9 +1054,6 @@
 	ppc_md.irq_cannonicalize = apus_irq_cannonicalize;
 	ppc_md.init_IRQ       = apus_init_IRQ;
 	ppc_md.get_irq        = apus_get_irq;
-
-#error Should use the ->end() member of irq_desc[x]. -- Cort
-	/*ppc_md.post_irq       = apus_post_irq;*/

 #ifdef CONFIG_HEARTBEAT
 	ppc_md.heartbeat      = apus_heartbeat;
--- arch/ppc/kernel/head.S	2001/10/25 19:30:56	1.1.1.20
+++ arch/ppc/kernel/head.S	2001/10/25 22:02:39	1.24
@@ -385,19 +401,15 @@
 /* External interrupt */
 	. = 0x500;
 HardwareInterrupt:
-	EXCEPTION_PROLOG;
+	EXCEPTION_PROLOG
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r20,MSR_KERNEL
-#ifndef CONFIG_APUS
 	li	r4,0
 	bl	transfer_to_handler
 	.globl do_IRQ_intercept
 do_IRQ_intercept:
 	.long	do_IRQ;
 	.long	ret_from_intercept
-#else
-	bl	apus_interrupt_entry
-#endif /* CONFIG_APUS */

 /* Alignment exception */
 	. = 0x600
@@ -1172,63 +1184,7 @@
 	sync				/* additional sync needed on g4 */
 	isync				/* No speculative loading until now */
 	blr
-
-apus_interrupt_entry:
-	/* This is horrible, but there's no way around it. Enable the
-	 * data cache so the IRQ hardware register can be accessed
-	 * without cache intervention. Then disable interrupts and get
-	 * the current emulated m68k IPL value.
-	 */
-
-	mfmsr	20
-	xori	r20,r20,MSR_DR
-	SYNC
-	mtmsr	r20
-	isync
-
-	lis	r4,APUS_IPL_EMU@h
-
-	li	r20,(IPLEMU_SETRESET|IPLEMU_DISABLEINT)
-	stb	r20,APUS_IPL_EMU@l(r4)
-	eieio
-
-	lbz	r3,APUS_IPL_EMU@l(r4)
-
-	li	r2,IPLEMU_IPLMASK
-	rlwinm. r20,r3,32-3,29,31
-	bne	2f
-	mr	r20,r2		/* lvl7! Need to reset state machine. */
-	b	3f
-2:	cmp	0,r20,r2
-	beq	1f
-3:	eieio
-	stb     r2,APUS_IPL_EMU@l(r4)
-	ori	r20,r20,IPLEMU_SETRESET
-	eieio
-	stb     r20,APUS_IPL_EMU@l(r4)
-1:	eieio
-	li	r20,IPLEMU_DISABLEINT
-	stb	r20,APUS_IPL_EMU@l(r4)
-
-	/* At this point we could do some magic to avoid the overhead
-	 * of calling the C interrupt handler in case of a spurious
-	 * interrupt. Could not get a simple hack to work though.
-	 */
-
-	mfmsr	r20
-	xori	r20,r20,MSR_DR
-	SYNC
-	mtmsr	r20
-	isync

-	stw	r3,(_CCR+4)(r21);
-
-	addi	r3,r1,STACK_FRAME_OVERHEAD;
-	li	r20,MSR_KERNEL;
-	bl	transfer_to_handler;
-	.long	do_IRQ;
-	.long	ret_from_except
-
 /***********************************************************************
  *  Please note that on APUS the exception handlers are located at the
  *  physical address 0xfff0000. For this reason, the exception handlers
--- arch/ppc/kernel/i8259.c	2001/07/08 15:57:31	1.1.1.6
+++ arch/ppc/kernel/i8259.c	2001/11/01 22:30:26
@@ -114,7 +114,7 @@
 	spin_unlock_irqrestore(&i8259_lock, flags);
 }

-static void i8259_end_irq(unsigned int irq)
+static void i8259_end_irq(struct pt_regs* regs, unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
 		i8259_unmask_irq(irq);
--- arch/ppc/kernel/irq.c	2001/10/16 15:53:49	1.1.1.18
+++ arch/ppc/kernel/irq.c	2001/10/17 22:56:12	1.11
@@ -527,7 +527,7 @@
 	 */
 	if (irq_desc[irq].handler) {
 		if (irq_desc[irq].handler->end)
-			irq_desc[irq].handler->end(irq);
+			irq_desc[irq].handler->end(regs, irq);
 		else if (irq_desc[irq].handler->enable)
 			irq_desc[irq].handler->enable(irq);
 	}
--- arch/ppc/kernel/open_pic.c	2001/10/25 19:30:53	1.1.1.16
+++ arch/ppc/kernel/open_pic.c	2001/11/01 22:30:27
@@ -84,7 +84,7 @@
 /*
  * Description of the openpic for the higher-level irq code
  */
-static void openpic_end_irq(unsigned int irq_nr);
+static void openpic_end_irq(struct pt_regs* regs, unsigned int irq_nr);
 static void openpic_ack_irq(unsigned int irq_nr);
 static void openpic_set_affinity(unsigned int irq_nr, unsigned long cpumask);

@@ -100,7 +100,7 @@
 };

 #ifdef CONFIG_SMP
-static void openpic_end_ipi(unsigned int irq_nr);
+static void openpic_end_ipi(struct pt_regs* regs, unsigned int irq_nr);
 static void openpic_ack_ipi(unsigned int irq_nr);
 static void openpic_enable_ipi(unsigned int irq_nr);
 static void openpic_disable_ipi(unsigned int irq_nr);
@@ -749,7 +749,7 @@
 	openpic_eoi();
 }

-static void openpic_end_irq(unsigned int irq_nr)
+static void openpic_end_irq(struct pt_regs* regs, unsigned int irq_nr)
 {
 	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
 		openpic_enable_irq(irq_nr);
@@ -766,7 +766,7 @@
 	openpic_eoi();
 }

-static void openpic_end_ipi(unsigned int irq_nr)
+static void openpic_end_ipi(struct pt_regs* regs, unsigned int irq_nr)
 {
 }

--- arch/ppc/kernel/pmac_pic.c	2001/10/16 15:53:40	1.1.1.13
+++ arch/ppc/kernel/pmac_pic.c	2001/11/01 22:30:30
@@ -124,7 +124,7 @@
         pmac_set_irq_mask(irq_nr);
 }

-static void __pmac pmac_end_irq(unsigned int irq_nr)
+static void __pmac pmac_end_irq(struct pt_regs* regs, unsigned int irq_nr)
 {
 	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))) {
         	set_bit(irq_nr, ppc_cached_irq_mask);
--- arch/ppc/kernel/xics.c	2001/07/08 15:57:58	1.1.1.5
+++ arch/ppc/kernel/xics.c	2001/11/01 22:30:30
@@ -24,7 +24,7 @@
 void xics_enable_irq(u_int irq);
 void xics_disable_irq(u_int irq);
 void xics_mask_and_ack_irq(u_int irq);
-void xics_end_irq(u_int irq);
+void xics_end_irq(struct pt_regs* regs, u_int irq);

 struct hw_interrupt_type xics_pic = {
 	" XICS     ",
@@ -120,7 +120,7 @@

 void
 xics_end_irq(
-	u_int	irq
+	struct pt_regs* regs, u_int	irq
 	)
 {
 	int cpu = smp_processor_id();
--- include/linux/irq.h	2001/10/16 18:57:02	1.1.1.6
+++ include/linux/irq.h	2001/10/17 22:56:15	1.4
@@ -43,7 +43,7 @@
 	void (*enable)(unsigned int irq);
 	void (*disable)(unsigned int irq);
 	void (*ack)(unsigned int irq);
-	void (*end)(unsigned int irq);
+	void (*end)(struct pt_regs* regs, unsigned int irq);
 	void (*set_affinity)(unsigned int irq, unsigned long mask);
 };


------------ linuxppc_2_4_devel only!

--- arch/ppc/kernel/ppc8xx_pic.c.org	Thu Nov  1 23:49:06 2001
+++ arch/ppc/kernel/ppc8xx_pic.c	Thu Nov  1 23:49:40 2001
@@ -44,7 +44,7 @@
 						ppc_cached_irq_mask[word];
 }

-static void m8xx_end_irq(unsigned int irq_nr)
+static void m8xx_end_irq(struct pt_regs* regs, unsigned int irq_nr)
 {
 	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))) {
 		int bit, word;


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
