Date: Sat, 10 Nov 2001 23:10:25 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: APUS irq patch
Message-ID: <Pine.LNX.4.33.0111102221430.12896-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Here is a new patch to update APUS irq handling.
First, it moves the assembly part in head.S to apus_get_irq, which uses a
local table instead of the stack now to save some additional irq context.
Second, the major change of this patch is to convert APUS to use the
general irq management code.

bye, Roman

--- arch/ppc/amiga/amiints.c	Sat Nov 10 20:21:14 2001
+++ arch/ppc/amiga/amiints.c	Sat Nov 10 22:56:20 2001
@@ -42,6 +42,8 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel_stat.h>
 #include <linux/init.h>

@@ -78,7 +80,7 @@

 static void ami_badint(int irq, void *dev_id, struct pt_regs *fp)
 {
-	num_spurious += 1;
+/*	num_spurious += 1;*/
 }

 /*
@@ -97,19 +99,6 @@
 {
 	int i;

-	/* initialize handlers */
-	for (i = 0; i < AMI_STD_IRQS; i++) {
-		if (ami_servers[i]) {
-			ami_irq_list[i] = NULL;
-		} else {
-			ami_irq_list[i] = new_irq_node();
-			ami_irq_list[i]->handler = ami_badint;
-			ami_irq_list[i]->flags   = 0;
-			ami_irq_list[i]->dev_id  = NULL;
-			ami_irq_list[i]->devname = NULL;
-			ami_irq_list[i]->next    = NULL;
-		}
-	}
 	for (i = 0; i < AMI_IRQS; i++)
 		ami_ablecount[i] = 0;

@@ -350,20 +339,24 @@

 inline void amiga_do_irq(int irq, struct pt_regs *fp)
 {
+	irq_desc_t *desc = irq_desc + irq;
+	struct irqaction *action = desc->action;
+
 	kstat.irqs[0][irq]++;
-	ami_irq_list[irq]->handler(irq, ami_irq_list[irq]->dev_id, fp);
+	action->handler(irq, action->dev_id, fp);
 }

 void amiga_do_irq_list(int irq, struct pt_regs *fp)
 {
-	irq_node_t *node;
+	irq_desc_t *desc = irq_desc + irq;
+	struct irqaction *action;

 	kstat.irqs[0][irq]++;

 	custom.intreq = ami_intena_vals[irq];

-	for (node = ami_irq_list[irq]; node; node = node->next)
-		node->handler(irq, node->dev_id, fp);
+	for (action = desc->action; action; action = action->next)
+		action->handler(irq, action->dev_id, fp);
 }

 /*
@@ -469,9 +462,15 @@
 /* The PPC irq handling links all handlers requested on the same vector
    and executes them in a loop. Having ami_badint at the end of the chain
    is a bad idea. */
-void (*amiga_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
-	NULL, ami_int1, NULL, ami_int3,
-	ami_int4, ami_int5, NULL, ami_int7
+struct irqaction amiga_sys_irqaction[AUTO_IRQS] = {
+	{ handler: ami_badint, name: "spurious int" },
+	{ handler: ami_int1, name: "int1 handler" },
+	{ 0, /* CIAA */ },
+	{ handler: ami_int3, name: "int3 handler" },
+	{ handler: ami_int4, name: "int4 handler" },
+	{ handler: ami_int5, name: "int5 handler" },
+	{ 0, /* CIAB */ },
+	{ handler: ami_int7, name: "int7 handler" },
 };
 #else
 void (*amiga_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
--- arch/ppc/amiga/cia.c	Sat Nov 10 20:24:14 2001
+++ arch/ppc/amiga/cia.c	Sat Nov 10 22:58:12 2001
@@ -16,7 +16,8 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel_stat.h>
 #include <linux/init.h>

@@ -99,15 +100,13 @@
 }

 /*
- *  Enable or disable CIA interrupts, return old interrupt mask,
- *  interrupts will only be enabled if a handler exists
+ *  Enable or disable CIA interrupts, return old interrupt mask.
  */

 static unsigned char cia_able_irq_private(struct ciabase *base,
 					  unsigned char mask)
 {
-	u_char old, tmp;
-	int i;
+	u_char old;

 	old = base->icr_mask;
 	base->icr_data |= base->cia->icr;
@@ -117,12 +116,7 @@
 	else
 		base->icr_mask &= ~mask;
 	base->icr_mask &= CIA_ICR_ALL;
-	for (i = 0, tmp = 1; i < CIA_IRQS; i++, tmp <<= 1) {
-		if ((tmp & base->icr_mask) && !base->irq_list[i].handler) {
-			base->icr_mask &= ~tmp;
-			base->cia->icr = tmp;
-		}
-	}
+
 	if (base->icr_data & base->icr_mask)
 		custom.intreq = IF_SETCLR | base->int_mask;
 	return old;
@@ -185,38 +179,42 @@
 static void cia_handler(int irq, void *dev_id, struct pt_regs *fp)
 {
 	struct ciabase *base = (struct ciabase *)dev_id;
+	irq_desc_t *desc;
+	struct irqaction *action;
 	int i;
 	unsigned char ints;

 	irq = base->cia_irq;
+	desc = irq_desc + irq;
 	ints = cia_set_irq_private(base, CIA_ICR_ALL);
 	custom.intreq = base->int_mask;
 	for (i = 0; i < CIA_IRQS; i++, irq++) {
 		if (ints & 1) {
 			kstat.irqs[0][irq]++;
-			base->irq_list[i].handler(irq, base->irq_list[i].dev_id, fp);
+			action = desc->action;
+			action->handler(irq, action->dev_id, fp);
 		}
 		ints >>= 1;
+		desc++;
 	}
 	amiga_do_irq_list(base->server_irq, fp);
 }

 void __init cia_init_IRQ(struct ciabase *base)
 {
-	int i;
-
-	/* init isr handlers */
-	for (i = 0; i < CIA_IRQS; i++) {
-		base->irq_list[i].handler = NULL;
-		base->irq_list[i].flags   = 0;
-	}
+	extern struct irqaction amiga_sys_irqaction[AUTO_IRQS];
+	struct irqaction *action;

 	/* clear any pending interrupt and turn off all interrupts */
 	cia_set_irq_private(base, CIA_ICR_ALL);
 	cia_able_irq_private(base, CIA_ICR_ALL);

 	/* install CIA handler */
-	request_irq(base->handler_irq, cia_handler, 0, base->name, base);
+	action = &amiga_sys_irqaction[base->handler_irq-IRQ_AMIGA_AUTO];
+	action->handler = cia_handler;
+	action->dev_id = base;
+	action->name = base->name;
+	setup_irq(base->handler_irq, &amiga_sys_irqaction[base->handler_irq-IRQ_AMIGA_AUTO]);

 	custom.intena = IF_SETCLR | base->int_mask;
 }
--- arch/ppc/amiga/config.c	Sat Nov 10 20:24:35 2001
+++ arch/ppc/amiga/config.c	Sat Nov 10 20:34:45 2001
@@ -413,16 +413,16 @@
   mach_keyb_init       = amiga_keyb_init;
   mach_kbdrate         = amiga_kbdrate;
   mach_init_IRQ        = amiga_init_IRQ;
-  mach_default_handler = &amiga_default_handler;
 #ifndef CONFIG_APUS
+  mach_default_handler = &amiga_default_handler;
   mach_request_irq     = amiga_request_irq;
   mach_free_irq        = amiga_free_irq;
   enable_irq           = amiga_enable_irq;
   disable_irq          = amiga_disable_irq;
+  mach_get_irq_list    = amiga_get_irq_list;
 #endif
   mach_get_model       = amiga_get_model;
   mach_get_hardware_list = amiga_get_hardware_list;
-  mach_get_irq_list    = amiga_get_irq_list;
   mach_gettimeoffset   = amiga_gettimeoffset;
   if (AMIGAHW_PRESENT(A3000_CLK)){
     mach_gettod  = a3000_gettod;
--- arch/ppc/kernel/apus_setup.c	Sat Nov 10 20:31:04 2001
+++ arch/ppc/kernel/apus_setup.c	Sat Nov 10 23:00:10 2001
@@ -77,6 +77,8 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/machdep.h>
+#include <asm/keyboard.h>
+#include <asm/time.h>

 unsigned long m68k_machtype;
 char debug_device[6] = "";
@@ -751,33 +753,47 @@
 }
 #endif

+static unsigned char last_ipl[8];
+
 int apus_get_irq(struct pt_regs* regs)
 {
-#ifdef CONFIG_APUS
-	int level = apus_get_IPL();
+	unsigned char ipl_emu, mask;
+	unsigned int level;

-#ifdef __INTERRUPT_DEBUG
-	printk("<%d:%d>", level, apus_get_prev_IPL(regs));
-#endif
+	APUS_READ(APUS_IPL_EMU, ipl_emu);
+	level = (ipl_emu >> 3) & IPLEMU_IPLMASK;
+	mask = IPLEMU_SETRESET|IPLEMU_DISABLEINT|level;
+	level ^= 7;
+
+	/* Save previous IPL value */
+	if (last_ipl[level])
+		return -2;
+	last_ipl[level] = ipl_emu;
+
+	/* Set to current IPL value */
+	APUS_WRITE(APUS_IPL_EMU, mask);
+	APUS_WRITE(APUS_IPL_EMU, IPLEMU_DISABLEINT|level);

-	if (0 == level)
-		return -8;
-	if (7 == level)
-		return -9;

-	return level + IRQ_AMIGA_AUTO;
-#else
-	return 0;
+#ifdef __INTERRUPT_DEBUG
+	printk("<%d:%d>", level, ~ipl_emu & IPLEMU_IPLMASK);
 #endif
+	return level + IRQ_AMIGA_AUTO;
 }

-void apus_post_irq(struct pt_regs* regs, int level)
+void apus_end_irq(unsigned int irq)
 {
+	unsigned char ipl_emu;
+	unsigned int level = irq - IRQ_AMIGA_AUTO;
 #ifdef __INTERRUPT_DEBUG
-	printk("{%d}", apus_get_prev_IPL(regs));
+	printk("{%d}", ~last_ipl[level] & IPLEMU_IPLMASK);
 #endif
 	/* Restore IPL to the previous value */
-	apus_set_IPL(apus_get_prev_IPL(regs));
+	ipl_emu = last_ipl[level] & IPLEMU_IPLMASK;
+	APUS_WRITE(APUS_IPL_EMU, IPLEMU_SETRESET|IPLEMU_DISABLEINT|ipl_emu);
+	last_ipl[level] = 0;
+	ipl_emu ^= 7;
+	APUS_WRITE(APUS_IPL_EMU, IPLEMU_DISABLEINT|ipl_emu);
 }

 /****************************************************** keyboard */
@@ -947,17 +963,21 @@
 	return NULL;
 }

+extern struct irqaction amiga_sys_irqaction[AUTO_IRQS];
+
+
 extern void amiga_enable_irq(unsigned int irq);
 extern void amiga_disable_irq(unsigned int irq);

+struct hw_interrupt_type amiga_sys_irqctrl = {
+	typename: "Amiga IPL",
+	end: apus_end_irq,
+};
+
 struct hw_interrupt_type amiga_irqctrl = {
-	" Amiga  ",
-	NULL,
-	NULL,
-	amiga_enable_irq,
-	amiga_disable_irq,
-	0,
-	0
+	typename: "Amiga    ",
+	enable: amiga_enable_irq,
+	disable: amiga_disable_irq,
 };

 #define HARDWARE_MAPPED_SIZE (512*1024)
@@ -1027,18 +1047,23 @@
 __init
 void apus_init_IRQ(void)
 {
+	struct irqaction *action;
 	int i;

-	for ( i = 0 ; i < NR_IRQS ; i++ )
-		irq_desc[i].handler = &amiga_irqctrl;
-
-	for (i = 0; i < NUM_IRQ_NODES; i++)
-		nodes[i].handler = NULL;
+#ifdef CONFIG_PCI
+        apus_setup_pci_ptrs();
+#endif

-	for (i = 0; i < AUTO_IRQS; i++) {
-		if (amiga_default_handler[i] != NULL)
-			sys_request_irq(i, amiga_default_handler[i],
-					0, default_names[i], NULL);
+	for ( i = 0 ; i < AMI_IRQS; i++ ) {
+		irq_desc[i].status = IRQ_LEVEL;
+		if (i < IRQ_AMIGA_AUTO) {
+			irq_desc[i].handler = &amiga_irqctrl;
+		} else {
+			irq_desc[i].handler = &amiga_sys_irqctrl;
+			action = &amiga_sys_irqaction[i-IRQ_AMIGA_AUTO];
+			if (action->name)
+				setup_irq(i, action);
+		}
 	}

 	amiga_init_IRQ();
@@ -1074,10 +1099,7 @@
 	ppc_md.irq_cannonicalize = apus_irq_cannonicalize;
 	ppc_md.init_IRQ       = apus_init_IRQ;
 	ppc_md.get_irq        = apus_get_irq;
-
-#error Should use the ->end() member of irq_desc[x]. -- Cort
-	/*ppc_md.post_irq       = apus_post_irq;*/
-
+
 #ifdef CONFIG_HEARTBEAT
 	ppc_md.heartbeat      = apus_heartbeat;
 	ppc_md.heartbeat_count = 1;
--- arch/ppc/kernel/head.S	Sat Nov 10 20:31:25 2001
+++ arch/ppc/kernel/head.S	Sat Nov 10 21:52:28 2001
@@ -373,16 +373,12 @@
 	EXCEPTION_PROLOG;
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
@@ -1157,62 +1153,6 @@
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
-
-	stw	r3,(_CCR+4)(r21);
-
-	addi	r3,r1,STACK_FRAME_OVERHEAD;
-	li	r20,MSR_KERNEL;
-	bl	transfer_to_handler;
-	.long	do_IRQ;
-	.long	ret_from_except

 /***********************************************************************
  *  Please note that on APUS the exception handlers are located at the
--- arch/ppc/kernel/irq.c	Sat Nov 10 20:31:39 2001
+++ arch/ppc/kernel/irq.c	Sat Nov 10 20:34:45 2001
@@ -189,9 +189,6 @@
  * now, this is what I need. -- Dan
  */
 #define request_irq	request_8xxirq
-#elif defined(CONFIG_APUS)
-#define request_irq	request_sysirq
-#define free_irq	sys_free_irq
 #endif

 void free_irq(unsigned int irq, void* dev_id)
@@ -373,9 +370,6 @@

 int get_irq_list(char *buf)
 {
-#ifdef CONFIG_APUS
-	return apus_get_irq_list (buf);
-#else
 	int i, len = 0, j;
 	struct irqaction * action;

@@ -423,7 +417,6 @@
 #endif
 	len += sprintf(buf+len, "BAD: %10u\n", ppc_spurious_interrupts);
 	return len;
-#endif /* CONFIG_APUS */
 }

 static inline void


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
