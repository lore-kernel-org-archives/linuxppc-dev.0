Date: Thu, 11 Dec 2003 12:18:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: org@stop.crashing.org, linuxppc-dev@lists.linuxppc.org,
	Dan Malek <dan@embeddededge.com>
Subject: 8xx drivers for 2.6
Message-ID: <20031211191854.GK23731@stop.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0035_01C3C0AC.5AD8C750x"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


------=_NextPart_000_0035_01C3C0AC.5AD8C750x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ok.  I've gone and ported the 8xx serial driver, and other misc 8xx
things up to what 2.6 wants them to be, as well as a few of the simpler
changes to head_8xx.S.  You can get the patch at
http://stop.crashing.org:16080/~trini/XXX-mpc8xx_round_one.patch
or below.  There are a few issues that could still use additional work
(serial), and in 2.6 having request_8xxirq becomes much uglier because
of the irqreturn_t stuff (at least I couldn't make it happen w/o chaning
<linux/interrupt.h>, and I never did figure out why cond_syscall()
doesn't work in some files but not others.

Dan, if you have _anything_ done for head_8xx.S can you please post it?
Thanks.

--
Tom Rini
http://gate.crashing.org/~trini/

------=_NextPart_000_0035_01C3C0AC.5AD8C750x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=8xx_io.patch

diff -Nru a/arch/ppc/8xx_io/commproc.c b/arch/ppc/8xx_io/commproc.c
--- a/arch/ppc/8xx_io/commproc.c	Thu Dec 11 12:14:00 2003
+++ b/arch/ppc/8xx_io/commproc.c	Thu Dec 11 12:14:00 2003
@@ -33,6 +33,7 @@
 #include <asm/pgtable.h>
 #include <asm/8xx_immap.h>
 #include <asm/commproc.h>
+#include <asm/io.h>

 extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep);

@@ -49,13 +50,13 @@
 	void	*dev_id;
 };
 static	struct	cpm_action cpm_vecs[CPMVEC_NR];
-static	void	cpm_interrupt(int irq, void * dev, struct pt_regs * regs);
+static	irqreturn_t cpm_interrupt(int irq, void * dev, struct pt_regs * regs);
 static	void	cpm_error_interrupt(void *, struct pt_regs * regs);
 static	void	alloc_host_memory(void);

 #if 1
 void
-m8xx_cpm_reset()
+m8xx_cpm_reset(void)
 {
 	volatile immap_t	 *imp;
 	volatile cpm8xx_t	*commproc;
@@ -191,7 +192,7 @@

 /* CPM interrupt controller interrupt.
 */
-static	void
+static	irqreturn_t
 cpm_interrupt(int irq, void * dev, struct pt_regs * regs)
 {
 	uint	vec;
@@ -212,7 +213,8 @@
 	 * indicator.
 	 */
 	((immap_t *)IMAP_ADDR)->im_cpic.cpic_cisr = (1 << vec);
-
+
+	return IRQ_HANDLED;
 }

 /* The CPM can generate the error interrupt when there is a race condition
diff -Nru a/arch/ppc/8xx_io/uart.c b/arch/ppc/8xx_io/uart.c
--- a/arch/ppc/8xx_io/uart.c	Thu Dec 11 12:14:00 2003
+++ b/arch/ppc/8xx_io/uart.c	Thu Dec 11 12:14:00 2003
@@ -22,9 +22,12 @@
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/tty.h>
-#include <linux/tty_flip.h>
+#include <linux/tty_flip.h>	/* still needed? - Tom */
+#include <linux/tty_driver.h>
+#include <linux/types.h>	/* needed? -- Tom */
 #include <linux/serial.h>
 #include <linux/serialP.h>
+#include <linux/serial_reg.h>	/* needed? -- Tom */
 #include <linux/major.h>
 #include <linux/string.h>
 #include <linux/fcntl.h>
@@ -79,14 +82,8 @@
 static char *serial_name = "CPM UART driver";
 static char *serial_version = "0.03";

-static DECLARE_TASK_QUEUE(tq_serial);
-
 static struct tty_driver *serial_driver;
-static int serial_console_setup(struct console *co, char *options);
-
-static void serial_console_write(struct console *c, const char *s,
-				unsigned count);
-static struct tty_driver *serial_console_device(struct console *c, int *index)
+static struct console sercons;

 #if defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 static unsigned long break_pressed; /* break, really ... */
@@ -145,19 +142,22 @@
 static struct serial_state rs_table[] = {
 	/* UART CLK   PORT          IRQ      FLAGS  NUM   */
 #ifndef CONFIG_SCC3_ENET	/* SMC1 not usable with Ethernet on SCC3 */
-  	{ 0,     0, PROFF_SMC1, CPMVEC_SMC1,   0,    0 },    /* SMC1 ttyS0 */
+	{ port: PROFF_SMC1, irq: CPMVEC_SMC1 },	/* SMC1 ttyS0 */
 #endif
 #if !defined(CONFIG_USB_MPC8xx) && !defined(CONFIG_USB_CLIENT_MPC8xx)
 # ifdef CONFIG_SMC2_UART
-  	{ 0,     0, PROFF_SMC2, CPMVEC_SMC2,   0,    1 },    /* SMC2 ttyS1 */
+	{ port: PROFF_SMC2, irq: CPMVEC_SMC2 },	/* SMC1 ttyS1 */
 # endif
 # ifdef CONFIG_USE_SCC_IO
-  	{ 0,     0, PROFF_SCC2, CPMVEC_SCC2,   0,    (NUM_IS_SCC | 1) },    /* SCC2 ttyS2 */
-  	{ 0,     0, PROFF_SCC3, CPMVEC_SCC3,   0,    (NUM_IS_SCC | 2) },    /* SCC3 ttyS3 */
+	{ port: PROFF_SCC2, irq: CPMVEC_SCC2,
+		flags: (NUM_IS_SCC | 1) },	/* SCC2 ttyS2 */
+	{ port: PROFF_SCC3, irq: CPMVEC_SCC3,
+		flags: (NUM_IS_SCC | 2) },	/* SCC3 ttyS3 */
 # endif
   #else /* CONFIG_USB_xxx */
 # ifdef CONFIG_USE_SCC_IO
-  	{ 0,     0, PROFF_SCC3, CPMVEC_SCC3,   0,    (NUM_IS_SCC | 2) },    /* SCC3 ttyS3 */
+	{ port: PROFF_SCC3, irq: CPMVEC_SCC3,
+		flags: (NUM_IS_SCC | 2) },	/* SCC3 ttyS3 */
 # endif
 #endif	/* CONFIG_USB_xxx */
 };
@@ -190,8 +190,8 @@
 	unsigned long		event;
 	unsigned long		last_active;
 	int			blocked_open; /* # of blocked opens */
-	struct tq_struct	tqueue;
-	struct tq_struct	tqueue_hangup;
+	struct work_struct	work;
+	struct work_struct	hangup;
 	wait_queue_head_t	open_wait;
 	wait_queue_head_t	close_wait;

@@ -209,15 +209,6 @@
 	 unsigned char		*tx_va_base;
 } ser_info_t;

-static struct console sercons = {
-	.name =		"ttyS",
-	.write =	serial_console_write,
-	.device =	serial_console_device,
-	.setup =	serial_console_setup,
-	.flags =	CON_PRINTBUFFER,
-	.index =	CONFIG_SERIAL_CONSOLE_PORT,
-};
-
 static void change_speed(ser_info_t *info);
 static void rs_8xx_wait_until_sent(struct tty_struct *tty, int timeout);

@@ -329,18 +320,6 @@
  * -----------------------------------------------------------------------
  */

-/*
- * This routine is used by the interrupt handler to schedule
- * processing in the software interrupt portion of the driver.
- */
-static _INLINE_ void rs_sched_event(ser_info_t *info,
-				  int event)
-{
-	info->event |= 1 << event;
-	queue_task(&info->tqueue, &tq_serial);
-	mark_bh(SERIAL_BH);
-}
-
 static _INLINE_ void receive_chars(ser_info_t *info, struct pt_regs *regs)
 {
 	struct tty_struct *tty = info->tty;
@@ -498,7 +477,7 @@
 	}
 	info->rx_cur = (cbd_t *)bdp;

-	queue_task(&tty->flip.tqueue, &tq_timer);
+	schedule_work(&tty->flip.work);
 }

 static _INLINE_ void receive_break(ser_info_t *info, struct pt_regs *regs)
@@ -526,7 +505,7 @@
 	*(tty->flip.char_buf_ptr++) = 0;
 	tty->flip.count++;

-	queue_task(&tty->flip.tqueue, &tq_timer);
+	schedule_work(&tty->flip.work);
 }

 static _INLINE_ void transmit_chars(ser_info_t *info, struct pt_regs *regs)
@@ -534,7 +513,7 @@

 	if ((info->flags & TX_WAKEUP) ||
 	    (info->tty->flags & (1 << TTY_DO_WRITE_WAKEUP))) {
-		rs_sched_event(info, RS_EVENT_WRITE_WAKEUP);
+		schedule_work(&info->work);
 	}

 #ifdef SERIAL_DEBUG_INTR
@@ -584,7 +563,7 @@
 			printk("scheduling hangup...");
 #endif
 			MOD_INC_USE_COUNT;
-			if (schedule_task(&info->tqueue_hangup) == 0)
+			if (schedule_work(&info->hangup) == 0)
 				MOD_DEC_USE_COUNT;
 		}
 	}
@@ -671,20 +650,6 @@
  * -------------------------------------------------------------------
  */

-/*
- * This routine is used to handle the "bottom half" processing for the
- * serial driver, known also the "software interrupt" processing.
- * This processing is done at the kernel interrupt level, after the
- * rs_interrupt() has returned, BUT WITH INTERRUPTS TURNED ON.  This
- * is where time-consuming activities which can not be done in the
- * interrupt driver proper are done; the interrupt driver schedules
- * them using rs_sched_event(), and they get done here.
- */
-static void do_serial_bh(void)
-{
-	run_task_queue(&tq_serial);
-}
-
 static void do_softint(void *private_)
 {
 	ser_info_t	*info = (ser_info_t *) private_;
@@ -703,11 +668,11 @@
 }

 /*
- * This routine is called from the scheduler tqueue when the interrupt
+ * This routine is called from the scheduler work_struct when the interrupt
  * routine has signalled that a hangup has occurred.  The path of
  * hangup processing is:
  *
- * 	serial interrupt routine -> (scheduler tqueue) ->
+ * 	serial interrupt routine -> (scheduler work_struct) ->
  * 	do_serial_hangup() -> tty->hangup() -> rs_hangup()
  *
  */
@@ -1779,7 +1744,7 @@
 	 */
 	char_time = 1;
 	if (timeout)
-		char_time = min(char_time, timeout);
+		char_time = min(char_time, (unsigned long)timeout);
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 	printk("In rs_wait_until_sent(%d) check=%lu...", timeout, char_time);
 	printk("jiff=%lu...", jiffies);
@@ -1853,7 +1818,6 @@
 #ifdef DO_THIS_LATER
 	DECLARE_WAITQUEUE(wait, current);
 #endif
-	struct serial_state *state = info->state;
 	int		retval;
 	int		do_clocal = 0;

@@ -1894,7 +1858,7 @@
 	/*
 	 * Block waiting for the carrier detect and the line to become
 	 * free (i.e., not in use by the callout).  While we are in
-	 * this loop, state->count is dropped by one, so that
+	 * this loop, info->state->count is dropped by one, so that
 	 * rs_close() knows when to free things.  We restore it upon
 	 * exit, either normal or abnormal.
 	 */
@@ -1903,11 +1867,11 @@
 	add_wait_queue(&info->open_wait, &wait);
 #ifdef SERIAL_DEBUG_OPEN
 	printk("block_til_ready before block: ttys%d, count = %d\n",
-	       state->line, state->count);
+	       info->state->line, info->state->count);
 #endif
 	cli();
 	if (!tty_hung_up_p(filp))
-		state->count--;
+		info->state->count--;
 	sti();
 	info->blocked_open++;
 	while (1) {
@@ -1940,18 +1904,18 @@
 		}
 #ifdef SERIAL_DEBUG_OPEN
 		printk("block_til_ready blocking: ttys%d, count = %d\n",
-		       info->line, state->count);
+		       info->line, info->state->count);
 #endif
 		schedule();
 	}
 	current->state = TASK_RUNNING;
 	remove_wait_queue(&info->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
-		state->count++;
+		info->state->count++;
 	info->blocked_open--;
 #ifdef SERIAL_DEBUG_OPEN
 	printk("block_til_ready after blocking: ttys%d, count = %d\n",
-	       info->line, state->count);
+	       info->line, info->state->count);
 #endif
 #endif /* DO_THIS_LATER */
 	if (retval)
@@ -2292,6 +2256,7 @@
 }
 #endif

+#if defined(CONFIG_KGDB) || defined(CONFIG_XMON)
 /*
  * Receive character from the serial port.  This only works well
  * before the port is initialized for real use.
@@ -2367,6 +2332,7 @@

 	return((int)c);
 }
+#endif

 #ifdef CONFIG_XMON
 int
@@ -2461,9 +2427,11 @@
 /*
  *	Register console.
  */
-static void __init console_8xx_init(long kmem_start, long kmem_end)
+static int __init console_8xx_init(void)
 {
 	register_console(&sercons);
+
+	return 0;
 }
 console_initcall(console_8xx_init);
 #endif
@@ -2514,8 +2482,6 @@
 	if (!serial_driver)
 		return -ENOMEM;

-	init_bh(SERIAL_BH, do_serial_bh);
-
 	show_serial_version();

 	/* Initialize the tty_driver structure */
@@ -2614,15 +2580,13 @@
 		info = kmalloc(sizeof(ser_info_t), GFP_KERNEL);
 		if (info) {
 			__clear_user(info,sizeof(ser_info_t));
-			init_waitqueue_head(&info->open_wait);
-			init_waitqueue_head(&info->close_wait);
 			info->magic = SERIAL_MAGIC;
-			info->flags = state->flags;
-			info->tqueue.routine = do_softint;
-			info->tqueue.data = info;
-			info->tqueue_hangup.routine = do_serial_hangup;
-			info->tqueue_hangup.data = info;
 			info->line = i;
+			info->flags = state->flags;
+			INIT_WORK(&info->work, do_softint, info);
+			INIT_WORK(&info->hangup, do_serial_hangup, info);
+			init_waitqueue_head(&info->open_wait);
+			init_waitqueue_head(&info->close_wait);
 			info->state = state;
 			state->info = (struct async_struct *)info;

@@ -2654,16 +2618,6 @@
 			bdp->cbd_sc = BD_SC_WRAP | BD_SC_EMPTY | BD_SC_INTRPT;

 			idx = PORT_NUM(info->state->smc_scc_num);
-			if (info->state->smc_scc_num & NUM_IS_SCC) {
-				scp = &cp->cp_scc[idx];
-				sup = (scc_uart_t *)&cp->cp_dparam[state->port];
-				sup->scc_genscc.scc_rbase = dp_addr;
-			}
-			else {
-				sp = &cp->cp_smc[idx];
-				up = (smc_uart_t *)&cp->cp_dparam[state->port];
-				up->smc_rbase = dp_addr;
-			}

 			dp_addr = m8xx_cpm_dpalloc(sizeof(cbd_t) * TX_NUM_FIFO);

@@ -2689,7 +2643,9 @@
 			bdp->cbd_sc = (BD_SC_WRAP | BD_SC_INTRPT);

 			if (info->state->smc_scc_num & NUM_IS_SCC) {
-				sup->scc_genscc.scc_tbase = dp_addr;
+				scp = &cp->cp_scc[idx];
+				sup = (scc_uart_t *)&cp->cp_dparam[state->port];
+				sup->scc_genscc.scc_rbase = dp_addr;

 				/* Set up the uart parameters in the
 				 * parameter ram.
@@ -2756,6 +2712,8 @@
 				 * parallel I/O.  On 823/850 these are on
 				 * port A for SMC2.
 				 */
+				up = (smc_uart_t *)&cp->cp_dparam[state->port];
+				up->smc_rbase = dp_addr;
 #ifndef CONFIG_ALTSMC2
 				iobits = 0xc0 << (idx * 4);
 				cp->cp_pbpar |= iobits;
@@ -2813,6 +2771,7 @@
 				/* Set UART mode, 8 bit, no parity, one stop.
 				 * Enable receive and transmit.
 				 */
+				sp = &cp->cp_smc[idx];
 				sp->smc_smcmr = smcr_mk_clen(9) | SMCMR_SM_UART;

 				/* Disable all interrupts and clear all pending
@@ -2877,14 +2836,6 @@
 	cp = cpmp;	/* Get pointer to Communication Processor */

 	idx = PORT_NUM(ser->smc_scc_num);
-	if (ser->smc_scc_num & NUM_IS_SCC) {
-		scp = &cp->cp_scc[idx];
-		sup = (scc_uart_t *)&cp->cp_dparam[ser->port];
-	}
-	else {
-		sp = &cp->cp_smc[idx];
-		up = (smc_uart_t *)&cpmp->cp_dparam[ser->port];
-	}

 	/* When we get here, the CPM has been reset, so we need
 	 * to configure the port.
@@ -2910,10 +2861,10 @@
 	bdp->cbd_bufaddr = iopa(mem_addr);
 	(bdp+1)->cbd_bufaddr = iopa(mem_addr+4);

-	consinfo.rx_va_base = mem_addr;
-	consinfo.rx_bd_base = bdp;
-	consinfo.tx_va_base = mem_addr + 4;
-	consinfo.tx_bd_base = bdp+1;
+	consinfo.rx_va_base = (unsigned char *)mem_addr;
+	consinfo.rx_bd_base = (cbd_t *)bdp;
+	consinfo.tx_va_base = (unsigned char *)mem_addr + 4;
+	consinfo.tx_bd_base = (cbd_t *)bdp+1;

 	/* For the receive, set empty and wrap.
 	 * For transmit, set wrap.
@@ -2924,6 +2875,8 @@
 	/* Set up the uart parameters in the parameter ram.
 	*/
 	if (ser->smc_scc_num & NUM_IS_SCC) {
+		scp = &cp->cp_scc[idx];
+		sup = (scc_uart_t *)&cp->cp_dparam[ser->port];

 		sup->scc_genscc.scc_rbase = dp_addr;
 		sup->scc_genscc.scc_tbase = dp_addr + sizeof(cbd_t);
@@ -2984,6 +2937,8 @@

 	}
 	else {
+		up = (smc_uart_t *)&cpmp->cp_dparam[ser->port];
+
 		up->smc_rbase = dp_addr;	/* Base of receive buffer desc. */
 		up->smc_tbase = dp_addr+sizeof(cbd_t);	/* Base of xmt buffer desc. */
 		up->smc_rfcr = SMC_EB;
@@ -3004,6 +2959,7 @@
 		/* Set UART mode, 8 bit, no parity, one stop.
 		 * Enable receive and transmit.
 		 */
+		sp = &cp->cp_smc[idx];
 		sp->smc_smcmr = smcr_mk_clen(9) |  SMCMR_SM_UART;

 		/* And finally, enable Rx and Tx.
@@ -3017,3 +2973,12 @@

 	return 0;
 }
+
+static struct console sercons = {
+	.name =		"ttyS",
+	.write =	serial_console_write,
+	.device =	serial_console_device,
+	.setup =	serial_console_setup,
+	.flags =	CON_PRINTBUFFER,
+	.index =	CONFIG_SERIAL_CONSOLE_PORT,
+};
diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile	Thu Dec 11 12:14:00 2003
+++ b/arch/ppc/kernel/Makefile	Thu Dec 11 12:14:00 2003
@@ -30,7 +30,7 @@
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_TAU)		+= temp.o

-ifdef CONFIG_MATH_EMULATION
+ifndef CONFIG_MATH_EMULATION
 obj-$(CONFIG_8xx)		+= softemu8xx.o
 endif

diff -Nru a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
--- a/arch/ppc/kernel/head_8xx.S	Thu Dec 11 12:14:00 2003
+++ b/arch/ppc/kernel/head_8xx.S	Thu Dec 11 12:14:00 2003
@@ -36,14 +36,6 @@
 	.globl	_stext
 _stext:

-/*
- * _start is defined this way because the XCOFF loader in the OpenFirmware
- * on the powermac expects the entry point to be a procedure descriptor.
- */
-	.text
-	.globl	_start
-_start:
-
 /* MPC8xx
  * This port was done on an MBX board with an 860.  Right now I only
  * support an ELF compressed (zImage) boot from EPPC-Bug because the
@@ -78,14 +70,11 @@
  *	-- Dan
  */

-	.globl	__start
-__start:
 	mr	r31,r3			/* save parameters */
 	mr	r30,r4
 	mr	r29,r5
 	mr	r28,r6
 	mr	r27,r7
-	li	r24,0			/* cpu # */

 	/* We have to turn on the MMU right away so we get cache modes
 	 * set correctly.
@@ -151,22 +140,22 @@
 /*
  * Exception vectors.
  */
+
+#define FINISH_EXCEPTION(func)			\
+	bl	transfer_to_handler;		\
+	.long	func;				\
+	.long	ret_from_except
+
 #define STD_EXCEPTION(n, label, hdlr)		\
 	. = n;					\
 label:						\
 	EXCEPTION_PROLOG;			\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;	\
 	li	r20,MSR_KERNEL;			\
-	bl	transfer_to_handler; 		\
-	.long	hdlr;				\
-	.long	ret_from_except
+	FINISH_EXCEPTION(hdlr)

 /* System reset */
-#ifdef CONFIG_SMP /* MVME/MTX start the secondary here */
-	STD_EXCEPTION(0x100, Reset, __secondary_start_psurge)
-#else
 	STD_EXCEPTION(0x100, Reset, UnknownException)
-#endif

 /* Machine check */
 	STD_EXCEPTION(0x200, MachineCheck, MachineCheckException)
@@ -186,9 +175,7 @@
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r20,MSR_KERNEL
 	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
-	bl	transfer_to_handler
-	.long	do_page_fault
-	.long	ret_from_except
+	FINISH_EXCEPTION(do_page_fault)

 /* Instruction access exception.
  * This is "never generated" by the MPC8xx.  We jump to it for other
@@ -202,9 +189,7 @@
 	mr	r5,r23
 	li	r20,MSR_KERNEL
 	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
-	bl	transfer_to_handler
-	.long	do_page_fault
-	.long	ret_from_except
+	FINISH_EXCEPTION(do_page_fault)

 /* External interrupt */
 	. = 0x500;
@@ -213,12 +198,7 @@
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r20,MSR_KERNEL
 	li	r4,0
-	bl	transfer_to_handler
-	.globl do_IRQ_intercept
-do_IRQ_intercept:
-	.long	do_IRQ;
-	.long	ret_from_intercept
-
+	FINISH_EXCEPTION(do_IRQ)

 /* Alignment exception */
 	. = 0x600
@@ -231,9 +211,7 @@
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r20,MSR_KERNEL
 	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
-	bl	transfer_to_handler
-	.long	AlignmentException
-	.long	ret_from_except
+	FINISH_EXCEPTION(AlignmentException)

 /* Program check exception */
 	. = 0x700
@@ -242,9 +220,7 @@
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r20,MSR_KERNEL
 	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
-	bl	transfer_to_handler
-	.long	ProgramCheckException
-	.long	ret_from_except
+	FINISH_EXCEPTION(ProgramCheckException)

 /* No FPU on MPC8xx.  This exception is not supposed to happen.
 */
@@ -255,11 +231,7 @@
 	EXCEPTION_PROLOG
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r20,MSR_KERNEL
-	bl	transfer_to_handler
-	.globl timer_interrupt_intercept
-timer_interrupt_intercept:
-	.long	timer_interrupt
-	.long	ret_from_intercept
+	FINISH_EXCEPTION(timer_interrupt)

 	STD_EXCEPTION(0xa00, Trap_0a, UnknownException)
 	STD_EXCEPTION(0xb00, Trap_0b, UnknownException)
@@ -271,9 +243,7 @@
 	stw	r3,ORIG_GPR3(r21)
 	li	r20,MSR_KERNEL
 	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
-	bl	transfer_to_handler
-	.long	DoSyscall
-	.long	ret_from_except
+	FINISH_EXCEPTION(DoSyscall)

 /* Single step - not used on 601 */
 	STD_EXCEPTION(0xd00, SingleStep, SingleStepException)
@@ -322,7 +292,7 @@
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	andi.	r21, r20, 0x0800	/* Address >= 0x80000000 */
+	andi.	r21, r20, 0x8000	/* Address >= 0x80000000 */
 	beq	3f
 	lis	r21, swapper_pg_dir@h
 	ori	r21, r21, swapper_pg_dir@l
@@ -406,7 +376,7 @@
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	andi.	r21, r20, 0x0800
+	andi.	r21, r20, 0x8000
 	beq	3f
 	lis	r21, swapper_pg_dir@h
 	ori	r21, r21, swapper_pg_dir@l
@@ -549,7 +519,7 @@
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	andi.	r21, r20, 0x0800
+	andi.	r21, r20, 0x8000
 	beq	3f
 	lis	r21, swapper_pg_dir@h
 	ori	r21, r21, swapper_pg_dir@l
diff -Nru a/arch/ppc/kernel/irq.c b/arch/ppc/kernel/irq.c
--- a/arch/ppc/kernel/irq.c	Thu Dec 11 12:14:00 2003
+++ b/arch/ppc/kernel/irq.c	Thu Dec 11 12:14:00 2003
@@ -217,6 +217,10 @@

 EXPORT_SYMBOL(free_irq);

+#ifdef CONFIG_8xx
+#define request_irq request_8xxirq
+#endif
+
 int request_irq(unsigned int irq,
 	irqreturn_t (*handler)(int, void *, struct pt_regs *),
 	unsigned long irqflags, const char * devname, void *dev_id)
diff -Nru a/arch/ppc/kernel/softemu8xx.c b/arch/ppc/kernel/softemu8xx.c
--- a/arch/ppc/kernel/softemu8xx.c	Thu Dec 11 12:14:00 2003
+++ b/arch/ppc/kernel/softemu8xx.c	Thu Dec 11 12:14:00 2003
@@ -133,7 +133,7 @@
 			print_8xx_pte(current->mm,regs->nip);
 			pa = get_8xx_pte(current->mm,regs->nip) & PAGE_MASK;
 			pa |= (regs->nip & ~PAGE_MASK);
-			pa = __va(pa);
+			pa = (unsigned long)__va(pa);
 			printk("Kernel VA for NIP %x ", pa);
 			print_8xx_pte(current->mm,pa);
 		}
diff -Nru a/arch/ppc/kernel/syscalls.c b/arch/ppc/kernel/syscalls.c
--- a/arch/ppc/kernel/syscalls.c	Thu Dec 11 12:14:00 2003
+++ b/arch/ppc/kernel/syscalls.c	Thu Dec 11 12:14:00 2003
@@ -271,5 +271,3 @@
 {
 	return sys_fadvise64_64(fd, offset, len, advice);
 }
-
-cond_syscall(sys_pciconfig_iobase);
diff -Nru a/arch/ppc/mm/fault.c b/arch/ppc/mm/fault.c
--- a/arch/ppc/mm/fault.c	Thu Dec 11 12:14:00 2003
+++ b/arch/ppc/mm/fault.c	Thu Dec 11 12:14:00 2003
@@ -359,7 +359,6 @@
 	pgd_t *dir;
 	pmd_t *pmd;
 	pte_t *pte;
-	struct mm_struct *mm;

 	if (address < TASK_SIZE)
 		return NULL;
diff -Nru a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
--- a/arch/ppc/syslib/m8xx_setup.c	Thu Dec 11 12:14:00 2003
+++ b/arch/ppc/syslib/m8xx_setup.c	Thu Dec 11 12:14:00 2003
@@ -117,9 +117,11 @@
 }

 /* A place holder for time base interrupts, if they are ever enabled. */
-void timebase_interrupt(int irq, void * dev, struct pt_regs * regs)
+irqreturn_t timebase_interrupt(int irq, void * dev, struct pt_regs * regs)
 {
 	printk ("timebase_interrupt()\n");
+
+	return IRQ_HANDLED;
 }

 /* The decrementer counts at the system (internal) clock frequency divided by
@@ -214,14 +216,13 @@
 m8xx_restart(char *cmd)
 {
 	__volatile__ unsigned char dummy;
-	uint	msr;

 	cli();
 	((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr |= 0x00000080;

 	/* Clear the ME bit in MSR to cause checkstop on machine check
 	*/
-	mtmsr(mfmsr(msr) & ~0x1000);
+	mtmsr(mfmsr() & ~0x1000);

 	dummy = ((immap_t *)IMAP_ADDR)->im_clkrst.res[0];
 	printk("Restart failed\n");
diff -Nru a/arch/ppc/syslib/ppc8xx_pic.c b/arch/ppc/syslib/ppc8xx_pic.c
--- a/arch/ppc/syslib/ppc8xx_pic.c	Thu Dec 11 12:14:00 2003
+++ b/arch/ppc/syslib/ppc8xx_pic.c	Thu Dec 11 12:14:00 2003
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
+#include <linux/interrupt.h>
 #include <asm/irq.h>
 #include <asm/8xx_immap.h>
 #include <asm/mpc8xx.h>
diff -Nru a/include/asm-ppc/mpc8xx.h b/include/asm-ppc/mpc8xx.h
--- a/include/asm-ppc/mpc8xx.h	Thu Dec 11 12:14:00 2003
+++ b/include/asm-ppc/mpc8xx.h	Thu Dec 11 12:14:00 2003
@@ -96,8 +96,10 @@
 extern unsigned char __res[];

 struct pt_regs;
+typedef int irqreturn_t;	/* FIXME -- Tom */
+
 extern int request_8xxirq(unsigned int irq,
-		       void (*handler)(int, void *, struct pt_regs *),
+		       irqreturn_t (*handler)(int, void *, struct pt_regs *),
 		       unsigned long flags,
 		       const char *device,
 		       void *dev_id);
diff -Nru a/include/linux/interrupt.h b/include/linux/interrupt.h
--- a/include/linux/interrupt.h	Thu Dec 11 12:14:00 2003
+++ b/include/linux/interrupt.h	Thu Dec 11 12:14:00 2003
@@ -26,7 +26,9 @@
  * IRQ_HANDLED means that we did have a valid interrupt and handled it.
  * IRQ_RETVAL(x) selects on the two depending on x being non-zero (for handled)
  */
+#ifndef __CONFIG_8xx_DEFS
 typedef int irqreturn_t;
+#endif

 #define IRQ_NONE	(0)
 #define IRQ_HANDLED	(1)
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Thu Dec 11 12:14:00 2003
+++ b/kernel/sys.c	Thu Dec 11 12:14:00 2003
@@ -251,6 +251,7 @@
 cond_syscall(sys_epoll_wait)
 cond_syscall(sys_pciconfig_read)
 cond_syscall(sys_pciconfig_write)
+cond_syscall(sys_pciconfig_iobase)

 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {

------=_NextPart_000_0035_01C3C0AC.5AD8C750x--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
