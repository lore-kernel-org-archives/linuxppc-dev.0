Date: Wed, 15 May 2002 10:11:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH 2.5] More i8259 cleanups
Message-ID: <20020515171104.GQ721@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hey all.  I've been doing more OpenPIC/i8259 work and here's the next
patch I'll be pushing to linuxppc-2.5 soon.  What I've done is change
what openpic_init() does and create a few new calls as well.

First, openpic_init() now takes a 'linux_irq_offset' parameter.  This is
mostly what the 'offset' param was before.  But it's now no longer tied
to the cascade irq[1].  This is just where we want to start mapping
OpenPIC IRQs to Linux IRQs.  Second, it now takes 'openpic_serial_mode'
which is if the OpenPIC is running in serial interrupt mode or not.
This is so we can eliminate CONFIG_EPIC_SERIAL_MODE.  Also, it removes
the 'main_pic' argument.  After talking to Paul, we don't think
openpic_init() works with main_pic == 0.  Is anyone using openpic_init()
with main_pic == 0?

Next, there's now openpic_init_cascade() (or should this be called
openpic_hookup_cascade() ?) which takes the Linux IRQ number a cascade
is attached to and the name of it.  This might allow (but is untested)
multiple cascades, if xxxx_get_irq() knows which IRQs are cascaded, and
is a small step at allowing an arbitrary cascade.

Also, we now always setup IRQs with a priority of '8' and now we have
openpic_init_nmi_irq(), which will correctly set the priority of the NMI
IRQ.  This allows us to stop passing in 'programmer_switch_irq' to
openpic_init.  This is untested however.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

[1]: This isn't tested yet, but I'll try and test this shortly once I
have a sandpoint.

===== arch/ppc/kernel/open_pic.c 1.12 vs edited =====
--- 1.12/arch/ppc/kernel/open_pic.c	Wed May  1 07:37:15 2002
+++ edited/arch/ppc/kernel/open_pic.c	Wed May 15 07:51:51 2002
@@ -263,7 +263,6 @@
 }
 #endif /* CONFIG_SMP */

-#if defined(CONFIG_EPIC_SERIAL_MODE) || defined(CONFIG_PMAC_PBOOK)
 static void openpic_reset(void)
 {
 	openpic_setfield(&OpenPIC->Global.Global_Configuration0,
@@ -272,9 +271,7 @@
 				 OPENPIC_CONFIG_RESET))
 		mb();
 }
-#endif

-#ifdef CONFIG_EPIC_SERIAL_MODE
 static void openpic_enable_sie(void)
 {
 	openpic_setfield(&OpenPIC->Global.Global_Configuration1,
@@ -286,7 +283,6 @@
 	openpic_writefield(&OpenPIC->Global.Global_Configuration1,
 			 OPENPIC_EICR_S_CLK_MASK, (clkval << 28));
 }
-#endif

 void openpic_set_sources(int first_irq, int num_irqs, void *first_ISR)
 {
@@ -302,7 +298,7 @@
 		ISR[i] = src;
 }

-void __init openpic_init(int main_pic, int offset, int programmer_switch_irq)
+void __init openpic_init(int linux_irq_offset, int openpic_serial_mode)
 {
 	u_int t, i;
 	u_int timerfreq;
@@ -314,11 +310,9 @@
 	}
 	OpenPIC = (volatile struct OpenPIC *)OpenPIC_Addr;

-#ifdef CONFIG_EPIC_SERIAL_MODE
-	/* Have to start from ground zero.
-	*/
-	openpic_reset();
-#endif
+	/* Make sure we have all the right bits set for serial mode */
+	if (openpic_serial_mode)
+		openpic_reset();

 	if (ppc_md.progress) ppc_md.progress("openpic enter", 0x122);

@@ -351,16 +345,13 @@
 		printk("OpenPIC timer frequency is %d.%06d MHz\n",
 		       timerfreq / 1000000, timerfreq % 1000000);

-	if (!main_pic)
-		return;
-
-	open_pic_irq_offset = offset;
+	open_pic_irq_offset = linux_irq_offset;

 	/* Initialize timer interrupts */
 	if ( ppc_md.progress ) ppc_md.progress("openpic timer",0x3ba);
 	for (i = 0; i < OPENPIC_NUM_TIMERS; i++) {
 		/* Disabled, Priority 0 */
-		openpic_inittimer(i, 0, OPENPIC_VEC_TIMER+i+offset);
+		openpic_inittimer(i, 0, OPENPIC_VEC_TIMER+i+linux_irq_offset);
 		/* No processor */
 		openpic_maptimer(i, 0);
 	}
@@ -370,10 +361,12 @@
 	if ( ppc_md.progress ) ppc_md.progress("openpic ipi",0x3bb);
 	for (i = 0; i < OPENPIC_NUM_IPI; i++) {
 		/* Disabled, Priority 10..13 */
-		openpic_initipi(i, 10+i, OPENPIC_VEC_IPI+i+offset);
+		openpic_initipi(i, 10+i, OPENPIC_VEC_IPI+i+linux_irq_offset);
 		/* IPIs are per-CPU */
-		irq_desc[OPENPIC_VEC_IPI+i+offset].status |= IRQ_PER_CPU;
-		irq_desc[OPENPIC_VEC_IPI+i+offset].handler = &open_pic_ipi;
+		irq_desc[OPENPIC_VEC_IPI+i+linux_irq_offset].status |=
+			IRQ_PER_CPU;
+		irq_desc[OPENPIC_VEC_IPI+i+linux_irq_offset].handler =
+			&open_pic_ipi;
 	}
 #endif

@@ -384,15 +377,14 @@

 	/* Init all external sources, including possibly the cascade. */
 	for (i = 0; i < NumSources; i++) {
-		int pri, sense;
+		int sense;

 		if (ISR[i] == 0)
 			continue;

 		/* the bootloader may have left it enabled (bad !) */
-		openpic_disable_irq(i+offset);
+		openpic_disable_irq(i+linux_irq_offset);

-		pri = (i == programmer_switch_irq)? 9: 8;
 		/*
 		 * We find the vale from either the InitSenses table
 		 * or assume a negative polarity level interrupt.
@@ -400,39 +392,47 @@
 		sense = (i < OpenPIC_NumInitSenses)? OpenPIC_InitSenses[i]: 1;

 		if ((sense & IRQ_SENSE_MASK) == 1)
-			irq_desc[i+offset].status = IRQ_LEVEL;
+			irq_desc[i+linux_irq_offset].status = IRQ_LEVEL;

-		/* Enabled, Priority 8 or 9 */
-		openpic_initirq(i, pri, i+offset, (sense & IRQ_POLARITY_MASK),
+		/* Enabled, Priority 8 */
+		openpic_initirq(i, 8, i+linux_irq_offset,
+				(sense & IRQ_POLARITY_MASK),
 				(sense & IRQ_SENSE_MASK));
 		/* Processor 0 */
 		openpic_mapirq(i, 1<<0, 0);
 	}

 	/* Init descriptors */
-	for (i = offset; i < NumSources + offset; i++)
+	for (i = linux_irq_offset; i < NumSources + linux_irq_offset; i++)
 		irq_desc[i].handler = &open_pic;

 	/* Initialize the spurious interrupt */
 	if (ppc_md.progress) ppc_md.progress("openpic spurious",0x3bd);
-	openpic_set_spurious(OPENPIC_VEC_SPURIOUS+offset);
+	openpic_set_spurious(OPENPIC_VEC_SPURIOUS+linux_irq_offset);

-	/* Initialize the cascade */
-	if (offset) {
-		if (request_irq(offset, no_action, SA_INTERRUPT,
-				"82c59 cascade", NULL))
-			printk("Unable to get OpenPIC IRQ 0 for cascade\n");
-	}
  	openpic_disable_8259_pass_through();
-#ifdef CONFIG_EPIC_SERIAL_MODE
-	openpic_eicr_set_clk(7);	/* Slowest value until we know better */
-	openpic_enable_sie();
-#endif
+	if (openpic_serial_mode) {
+		/* Slowest value until we know better */
+		openpic_eicr_set_clk(7);
+		openpic_enable_sie();
+	}
 	openpic_set_priority(0);

 	if (ppc_md.progress) ppc_md.progress("openpic exit",0x222);
 }

+/*
+ * This will hook up a casacade to the OpenPIC.
+ *
+ * irq: The LinuxIRQ the cascade is attached to.
+ */
+void openpic_init_cascade(u_int irq, char *name)
+{
+	if (request_irq(irq, no_action, SA_INTERRUPT, name, NULL))
+		printk("Unable to get OpenPIC IRQ %d for cascade\n",
+				irq - open_pic_irq_offset);
+}
+
 #ifdef notused
 static void openpic_enable_8259_pass_through(void)
 {
@@ -441,6 +441,9 @@
 }
 #endif /* notused */

+/*
+ * Make sure that we don't pass i8259 interrupts through to the CPU.
+ */
 static void openpic_disable_8259_pass_through(void)
 {
 	openpic_setfield(&OpenPIC->Global.Global_Configuration0,
@@ -655,11 +658,10 @@

 /*
  *
- * All functions below take an offset'ed irq argument
+ * All functions below take an offset'ed irq argument unless otherwise noted.
  *
  */

-
 /*
  *  Enable/disable an external interrupt source
  *
@@ -735,6 +737,30 @@
 				(sense ? OPENPIC_SENSE_LEVEL : OPENPIC_SENSE_EDGE));
 }

+/*
+ * Initalize the interrupt source which will generate an NMI (and disable it).
+ *
+ * irq: The logical IRQ which generates an NMI.
+ */
+void __init
+openpic_init_nmi_irq(u_int irq)
+{
+	int sense;
+
+	sense = (irq < OpenPIC_NumInitSenses) ? OpenPIC_InitSenses[irq] : 1;
+
+	openpic_safe_writefield(&ISR[irq]->Vector_Priority,
+				OPENPIC_PRIORITY_MASK | OPENPIC_VECTOR_MASK |
+				OPENPIC_SENSE_MASK | OPENPIC_POLARITY_MASK,
+				(9 << OPENPIC_PRIORITY_SHIFT) |
+				(irq + open_pic_irq_offset) |
+				((sense & IRQ_POLARITY_MASK) ?
+				 OPENPIC_POLARITY_POSITIVE :
+				 OPENPIC_POLARITY_NEGATIVE) |
+				((sense & IRQ_SENSE_MASK) ? OPENPIC_SENSE_LEVEL
+				 : OPENPIC_SENSE_EDGE));
+}
+
 /*
  *  Map an interrupt source to one or more CPUs
  */
===== arch/ppc/platforms/chrp_setup.c 1.20 vs edited =====
--- 1.20/arch/ppc/platforms/chrp_setup.c	Thu May  9 00:26:18 2002
+++ edited/arch/ppc/platforms/chrp_setup.c	Wed May 15 07:36:12 2002
@@ -388,7 +388,6 @@
 	int i;
 	unsigned long chrp_int_ack;
 	unsigned char init_senses[NR_IRQS - NUM_8259_INTERRUPTS];
-	int nmi_irq = -1;
 #if defined(CONFIG_VT) && defined(CONFIG_ADB_KEYBOARD) && defined(XMON)
 	struct device_node *kbd;
 #endif
@@ -411,8 +410,10 @@
 	OpenPIC_InitSenses = init_senses;
 	OpenPIC_NumInitSenses = NR_IRQS - NUM_8259_INTERRUPTS;

-	openpic_init(1, NUM_8259_INTERRUPTS, nmi_irq);
-
+	openpic_init(NUM_8259_INTERRUPTS, 0);
+	/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
+	openpic_init_cascade(NUM_8259_INTERRUPTS, "82c59 cascade");
+
 	for (i = 0; i < NUM_8259_INTERRUPTS; i++)
 		irq_desc[i].handler = &i8259_pic;
 	i8259_init(chrp_int_ack);
===== arch/ppc/platforms/lopec_setup.c 1.4 vs edited =====
--- 1.4/arch/ppc/platforms/lopec_setup.c	Wed May  1 07:37:15 2002
+++ edited/arch/ppc/platforms/lopec_setup.c	Wed May 15 07:35:55 2002
@@ -217,7 +217,9 @@
 	/* Skip reserved space and map Message Unit Interrupt (I2O) */
 	openpic_set_sources(19, 1, OpenPIC_Addr + 0x110C0);

-	openpic_init(1, NUM_8259_INTERRUPTS, -1);
+	openpic_init(NUM_8259_INTERRUPTS, 1);
+	/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
+	openpic_init_cascade(NUM_8259_INTERRUPTS, "82c59 cascade");

 	/* Map i8259 interrupts */
 	for(i = 0; i < NUM_8259_INTERRUPTS; i++)
===== arch/ppc/platforms/pmac_pic.c 1.13 vs edited =====
--- 1.13/arch/ppc/platforms/pmac_pic.c	Thu May  9 00:26:18 2002
+++ edited/arch/ppc/platforms/pmac_pic.c	Wed May 15 07:35:01 2002
@@ -375,26 +375,28 @@
 		printk("PowerMac using OpenPIC irq controller\n");
 		if (irqctrler->n_addrs > 0)
 		{
-			int nmi_irq = -1;
 			unsigned char senses[NR_IRQS];
-#ifdef CONFIG_XMON
-			struct device_node* pswitch;

-			pswitch = find_devices("programmer-switch");
-			if (pswitch && pswitch->n_intrs)
-				nmi_irq = pswitch->intrs[0].line;
-#endif /* CONFIG_XMON */
 			prom_get_irq_senses(senses, 0, NR_IRQS);
 			OpenPIC_InitSenses = senses;
 			OpenPIC_NumInitSenses = NR_IRQS;
 			ppc_md.get_irq = openpic_get_irq;
 			OpenPIC_Addr = ioremap(irqctrler->addrs[0].address,
 					       irqctrler->addrs[0].size);
-			openpic_init(1, 0, nmi_irq);
+			openpic_init(0, 0);
 #ifdef CONFIG_XMON
-			if (nmi_irq >= 0)
-				request_irq(nmi_irq, xmon_irq, 0,
-					    "NMI - XMON", 0);
+			{
+				struct device_node* pswitch;
+				int nmi_irq;
+
+				pswitch = find_devices("programmer-switch");
+				if (pswitch && pswitch->n_intrs) {
+					nmi_irq = pswitch->intrs[0].line;
+					openpic_init_nmi_irq(nmi_irq);
+					request_irq(nmi_irq, xmon_irq, 0,
+							"NMI - XMON", 0);
+				}
+			}
 #endif	/* CONFIG_XMON */
 			return;
 		}
===== arch/ppc/platforms/prep_setup.c 1.22 vs edited =====
--- 1.22/arch/ppc/platforms/prep_setup.c	Thu May  2 18:43:12 2002
+++ edited/arch/ppc/platforms/prep_setup.c	Wed May 15 07:35:01 2002
@@ -691,8 +691,11 @@
 {
 	int i;

-	if (OpenPIC_Addr != NULL)
-		openpic_init(1, NUM_8259_INTERRUPTS, -1);
+	if (OpenPIC_Addr != NULL) {
+		openpic_init(NUM_8259_INTERRUPTS, 0);
+		/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
+		openpic_init_cascade(NUM_8259_INTERRUPTS, "82c59 cascade");
+	}
 	for ( i = 0 ; i < NUM_8259_INTERRUPTS ; i++ )
 		irq_desc[i].handler = &i8259_pic;
 	i8259_init(MPC10X_MAPA_PCI_INTACK_ADDR);
===== include/asm-ppc/open_pic.h 1.10 vs edited =====
--- 1.10/include/asm-ppc/open_pic.h	Wed May  1 07:37:15 2002
+++ edited/include/asm-ppc/open_pic.h	Wed May 15 07:35:01 2002
@@ -55,7 +55,9 @@

 /* Exported functions */
 extern void openpic_set_sources(int first_irq, int num_irqs, void *isr);
-extern void openpic_init(int, int, int);
+extern void openpic_init(int linux_irq_offset, int openpic_serial_mode);
+extern void openpic_init_cascade(u_int irq, char *name);
+extern void openpic_init_nmi_irq(u_int irq);
 extern u_int openpic_irq(void);
 extern void openpic_eoi(void);
 extern void openpic_request_IPIs(void);

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
