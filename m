Date: Mon, 18 Nov 2002 12:27:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: John Traill <john.traill@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc-2.5 / Sandpoint X2
Message-ID: <20021118192740.GA18374@opus.bloom.county>
References: <3DD4E4D3.4030805@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DD4E4D3.4030805@motorola.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 15, 2002 at 12:13:07PM +0000, John Traill wrote:
>
> I'm having problems getting linuxppc-2.5 running on an X2 Sandpoint system.
> Firstly there are a couple of failures
> during the build relating to changes in the interrupt handling. I've made
> the obvious changes in sandpoint_setup.c
>
> openpic_init(1,0,NULL,-1) -> openpic_init(0)
> i8259_poll() -> i8259_irq(regs)
>
> The kernel boots, mounts file system etc...  but after "Freeing unused
> kernel memory: 96k init" no prompt - Initial
> debug shows that the kernel is executing some of the interrupt routines
> (sandpoint_get_irq(), openpic_irq() etc ).
> However I'm not sure if this is indicative of an error in the changes above
> or just the fact that the kernel isn't doing
> anything else but service irq's.
>
> Any help/pointers would be gratefully received.

You need more changes, no doubt. :)  The following patches made an X3
work, maybe a few months ago.  I didn't check them in at the time as X2
support was not working, and I hadn't figured out a good, 2.5 type
solution to the problem of the i8259 not being where expected (and Paul
had mentioned he didn't like the workaround in 2.4 for this and would
prefre something nicer for 2.5).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/ppc/platforms/sandpoint.h 1.1 vs edited =====
--- 1.1/arch/ppc/platforms/sandpoint.h	Sun Feb 10 04:21:52 2002
+++ edited/arch/ppc/platforms/sandpoint.h	Wed Nov  6 07:30:12 2002
@@ -21,6 +21,8 @@
 #ifndef __PPC_PLATFORMS_SANDPOINT_H
 #define __PPC_PLATFORMS_SANDPOINT_H

+#include <asm/ppcboot.h>
+
 #ifdef CONFIG_SANDPOINT_X3
 #define SANDPOINT_SIO_SLOT      0	/* Cascaded from EPIC IRQ 0 */
 #if 0
===== arch/ppc/platforms/sandpoint_pci.c 1.1 vs edited =====
--- 1.1/arch/ppc/platforms/sandpoint_pci.c	Sun Feb 10 04:21:52 2002
+++ edited/arch/ppc/platforms/sandpoint_pci.c	Wed Nov  6 07:30:12 2002
@@ -44,17 +44,10 @@
 		       0,  0,  0 },	/* IDSEL 11 - i8259 on Winbond */
 		{  0,  0,  0,  0 },	/* IDSEL 12 - unused */
 #ifdef CONFIG_SANDPOINT_X3
-#if 0	/* This is what it _should_ look like -- Dan */
-		{ 17, 20, 19, 18 },	/* IDSEL 13 - PCI slot 1 */
-		{ 18, 17, 20, 19 },	/* IDSEL 14 - PCI slot 2 */
-		{ 19, 18, 17, 20 },	/* IDSEL 15 - PCI slot 3 */
-		{ 20, 19, 18, 17 },	/* IDSEL 16 - PCI slot 4 */
-#else
 		{ 18, 21, 20, 19 },	/* IDSEL 13 - PCI slot 1 */
 		{ 19, 18, 21, 20 },	/* IDSEL 14 - PCI slot 2 */
 		{ 20, 19, 18, 21 },	/* IDSEL 15 - PCI slot 3 */
 		{ 21, 20, 19, 18 },	/* IDSEL 16 - PCI slot 4 */
-#endif
 #else
 		{ 16, 19, 18, 17 },	/* IDSEL 13 - PCI slot 1 */
 		{ 17, 16, 19, 18 },	/* IDSEL 14 - PCI slot 2 */
@@ -134,15 +127,18 @@
 	return;
 }

+/* On the sandpoint X2, we must avoid sending configuration cycles to
+ * device #12 (IDSEL addr = AD12).  This has been fixed in the X3.
+ */
 static int
 sandpoint_exclude_device(u_char bus, u_char devfn)
 {
-	if ((bus == 0) && (PCI_SLOT(devfn) == SANDPOINT_HOST_BRIDGE_IDSEL)) {
+#ifndef CONFIG_SANDPOINT_X3
+	if ((bus == 0) && (PCI_SLOT(devfn) == SANDPOINT_HOST_BRIDGE_IDSEL))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-	else {
+	else
+#endif
 		return PCIBIOS_SUCCESSFUL;
-	}
 }

 void __init
===== arch/ppc/platforms/sandpoint_setup.c 1.8 vs edited =====
--- 1.8/arch/ppc/platforms/sandpoint_setup.c	Fri Jul 26 00:04:28 2002
+++ edited/arch/ppc/platforms/sandpoint_setup.c	Wed Nov  6 07:30:13 2002
@@ -96,53 +96,28 @@
 extern u_int openpic_irq(void);
 extern void openpic_eoi(void);

-static void	sandpoint_halt(void);
+unsigned char __res[sizeof(bd_t)];

+static void sandpoint_halt(void);

 /*
- * *** IMPORTANT ***
- *
- * The first 16 entries of 'sandpoint_openpic_initsenses[]' are there and
- * initialized to 0 on purpose.  DO NOT REMOVE THEM as the 'offset' parameter
- * of 'openpic_init()' does not work for the sandpoint because the 8259
- * interrupt is NOT routed to the EPIC's IRQ 0 AND the EPIC's IRQ 0's offset is
- * the same as a normal openpic's IRQ 16 offset.
+ * Define all of the IRQ senses and polarities.  Taken from the
+ * Sandpoint X3 User's manual.
  */
 static u_char sandpoint_openpic_initsenses[] __initdata = {
-	0,	/* 0-15 not used by EPCI but by 8259 (std PC-type IRQs) */
-	0,	/* 1 */
-	0,	/* 2 */
-	0,	/* 3 */
-	0,	/* 4 */
-	0,	/* 5 */
-	0,	/* 6 */
-	0,	/* 7 */
-	0,	/* 8 */
-	0,	/* 9 */
-	0,	/* 10 */
-	0,	/* 11 */
-	0,	/* 12 */
-	0,	/* 13 */
-	0,	/* 14 */
-	0,	/* 15 */
 #ifdef CONFIG_SANDPOINT_X3
-	1,	/* 16: EPIC IRQ 0: Active Low -- SIOINT (8259) */
- 0, /* AACK!  Shouldn't need this.....see sandpoint_pci.c for more info */
-	1,	/* 17: EPIC IRQ 1: Active Low -- PCI Slot 1 */
-	1,	/* 18: EPIC IRQ 2: Active Low -- PCI Slot 2 */
-	1,	/* 19: EPIC IRQ 3: Active Low -- PCI Slot 3 */
-	1,	/* 20: EPIC IRQ 4: Active Low -- PCI Slot 4 */
-	0,	/* 21 -- Unused */
-	0,	/* 22 -- Unused */
-	1,	/* 23 -- IDE (Winbond INT C)  */
-	1,	/* 24 -- IDE (Winbond INT D)  */
-		/* 35 - 31 (EPIC 9 - 15) Unused */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 0: SIOINT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 2: PCI Slot 1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 3: PCI Slot 2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 4: PCI Slot 3 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 5: PCI Slot 4 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 8: IDE (INT C) */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE)	/* 9: IDE (INT D) */
 #else
-	1,	/* 16: EPIC IRQ 0: Active Low -- PCI intrs */
-	1,	/* 17: EPIC IRQ 1: Active Low -- PCI (possibly 8259) intrs */
-	1,	/* 18: EPIC IRQ 2: Active Low -- PCI (possibly 8259) intrs  */
-	1	/* 19: EPIC IRQ 3: Active Low -- PCI intrs */
-		/* 20: EPIC IRQ 4: Not used */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* EPIC IRQ 0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* EPIC IRQ 1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* EPIC IRQ 2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE)	/* EPIC IRQ 3 */
 #endif
 };

@@ -169,8 +144,8 @@
 	conswitchp = &dummy_con;
 #endif

-	printk("Motorola SPS Sandpoint Test Platform\n");
-	printk("Sandpoint port (MontaVista Software, Inc. (source@mvista.com))\n");
+	printk(KERN_INFO "Motorola SPS Sandpoint Test Platform\n");
+	printk(KERN_INFO "Port by MontaVista Software, Inc. (source@mvista.com)\n");

 	/* The Sandpoint rom doesn't enable any caches.  Do that now.
 	 * The 7450 portion will also set up the L3s once I get enough
@@ -178,14 +153,14 @@
 	 * and L2, the _set_L2CR is a no-op.
 	 */
 	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_SPEC7450) {
-		/* Just enable L2, the bits are different from others.
-		*/
+		/* Enable the L2. */
 		_set_L2CR(L2CR_L2E);
-	}
-	else {
-		/* The magic number for Sandpoint/74xx PrPMCs.
-		*/
-		_set_L2CR(0xbd014000);
+	} else if (cur_cpu_spec[0]->cpu_features & CPU_FTR_L2CR) {
+		/* All modules have 1MB of L2.  We also assume that an
+		 * L2 divisor of 3 will work.
+		 */
+		_set_L2CR(L2CR_L2E | L2CR_L2SIZ_1MB | L2CR_L2CLK_DIV3
+				| L2CR_L2RAM_PIPE | L2CR_L2OH_1_0 | L2CR_L2DF);
 	}
 }

@@ -214,7 +189,7 @@
 /*
  * Initialize the ISA devices on the Nat'l PC87308VUL SuperIO chip.
  */
-static void __init
+static int __init
 sandpoint_setup_natl_87308(void)
 {
 	u_char	reg;
@@ -241,29 +216,29 @@
 	outb(reg, SIO_CONFIG_RD);
 	outb(reg, SIO_CONFIG_RD);       /* Have to write twice to change! */

-	return;
+	return 0;
 }

+arch_initcall(sandpoint_setup_natl_87308);
+
 /*
  * Fix IDE interrupts.
  */
-static void __init
+static int __init
 sandpoint_fix_winbond_83553(void)
 {
 	/* Make all 8259 interrupt level sensitive */
 	outb(0xf8, 0x4d0);
 	outb(0xde, 0x4d1);

-	return;
+	return 0;
 }

-static void __init
-sandpoint_init2(void)
-{
-	/* Do Sandpoint board specific initialization.  */
-	sandpoint_fix_winbond_83553();
-	sandpoint_setup_natl_87308();
+arch_initcall(sandpoint_fix_winbond_83553);

+static int __init
+sandpoint_request_io(void)
+{
 	request_region(0x00,0x20,"dma1");
 	request_region(0x20,0x20,"pic1");
 	request_region(0x40,0x20,"timer");
@@ -271,9 +246,11 @@
 	request_region(0xa0,0x20,"pic2");
 	request_region(0xc0,0x20,"dma2");

-	return;
+	return 0;
 }

+arch_initcall(sandpoint_request_io);
+
 /*
  * Interrupt setup and service.  Interrrupts on the Sandpoint come
  * from the four PCI slots plus the 8259 in the Winbond Super I/O (SIO).
@@ -291,61 +268,83 @@
 {
 	int i;

-	/*
-	 * 3 things cause us to jump through some hoops:
-	 *   1) the EPIC on the 8240 & 107 are not full-blown openpic pic's
-	 *   2) the 8259 is NOT cascaded on the openpic IRQ 0
-	 *   3) the 8259 shares its interrupt line with some PCI interrupts.
-	 *
-	 * What we'll do is set up the 8259 to be level sensitive, active low
-	 * just like a PCI device.  Then, when an interrupt on the IRQ that is
-	 * shared with the 8259 comes in, we'll take a peek at the 8259 to see
-	 * it its generating an interrupt.  If it is, we'll handle the 8259
-	 * interrupt.  Otherwise, we'll handle it just like a normal PCI
-	 * interrupt.  This does give the 8259 interrupts a higher priority
-	 * than the EPIC ones--hopefully, not a problem.
-	 */
 	OpenPIC_InitSenses = sandpoint_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof(sandpoint_openpic_initsenses);

-	openpic_init(1, 0, NULL, -1);
+	/*
+	 * We need to tell openpic_set_sources where things actually are.
+	 * mpc10x_common will setup OpenPIC_Addr at ioremap(EUMB phys base +
+	 * EPIC offset (0x40000));  The EPIC IRQ Register Address Map -
+	 * Interrupt Source Configuration Registers gives these numbers
+	 * as offsets starting at 0x50200, we need to adjust occordinly.
+	 */
+
+#ifdef CONFIG_SANDPOINT_X3
+#if 0
+	/* Map serial interrupt 0 */
+	openpic_set_sources(0, 1, OpenPIC_Addr + 0x10200);
+	/* Map serial interrupts 2-5 */
+	openpic_set_sources(1, 4, OpenPIC_Addr + 0x10240);
+	/* Map serial interrupts 8-9 */
+	openpic_set_sources(5, 2, OpenPIC_Addr + 0x10300);
+	/* Skip reserved space and map i2c and DMA Ch[01] */
+	openpic_set_sources(7, 3, OpenPIC_Addr + 0x11020);
+	/* Skip reserved space and map Message Unit Interrupt (I2O) */
+	openpic_set_sources(10, 1, OpenPIC_Addr + 0x110C0);
+#else
+	/* Map serial interrupts 0-15 */
+	openpic_set_sources(0, 16, OpenPIC_Addr + 0x10200);
+#endif
+#else
+	/* Map EPIC IRQs 0-3 */
+	openpic_set_sources(0, 4, OpenPIC_Addr + 0x10200);
+	/* Skip reserved space and map i2c and DMA Ch[01] */
+	openpic_set_sources(4, 3, OpenPIC_Addr + 0x11020);
+	/* Skip reserved space and map Message Unit Interrupt (I2O) */
+	openpic_set_sources(7, 1, OpenPIC_Addr + 0x110C0);
+#error "No way to hook up i8259 cascade currently."
+#endif
+
+	openpic_init(NUM_8259_INTERRUPTS);

 	/*
-	 * openpic_init() has set up irq_desc[0-23] to be openpic
-	 * interrupts.  We need to set irq_desc[0-15] to be 8259 interrupts.
-	 * We then need to request and enable the 8259 irq.
+	 * openpic_init() has set up irq_desc[16-31] to be openpic
+	 * interrupts.  We need to set irq_desc[0-15] to be i8259
+	 * interrupts.
 	 */
 	for(i=0; i < NUM_8259_INTERRUPTS; i++)
 		irq_desc[i].handler = &i8259_pic;

-	if (request_irq(SANDPOINT_SIO_IRQ, no_action, SA_INTERRUPT,
-			"8259 cascade to EPIC", NULL)) {
-
-		printk("Unable to get OpenPIC IRQ %d for cascade\n",
-			SANDPOINT_SIO_IRQ);
-	}
-
-	i8259_init(NULL);
+	/*
+	 * The EPIC allows for a read in the range of 0xFEF00000 ->
+	 * 0xFEFFFFFF to generate a PCI interrupt-acknowledge transaction.
+	 */
+	i8259_init(0xfef00000);
 }

+/*
+ * Because the Sandpoint X2 has the i8259 cascade sharing an IRQ with a
+ * PCI device, if we have a possible cascade IRQ we need to see if the
+ * i8259 has something pending.  The only issue here is that the cascade
+ * IRQs will get a higher priority than an OpenPIC one, but this should be
+ * OK.
+ */
 static int
 sandpoint_get_irq(struct pt_regs *regs)
 {
-        int	irq, cascade_irq;
+        int irq, cascade_irq;

 	irq = openpic_irq();

 	if (irq == SANDPOINT_SIO_IRQ) {
-		cascade_irq = i8259_poll();
+		cascade_irq = i8259_irq(regs);

 		if (cascade_irq != -1) {
 			irq = cascade_irq;
 			openpic_eoi();
 		}
-	}
-	else if (irq == OPENPIC_VEC_SPURIOUS) {
+	} else if (irq == OPENPIC_VEC_SPURIOUS + 16)
 		irq = -1;
-	}

 	return irq;
 }
@@ -363,18 +362,18 @@
 	}
 }

-static ulong __init
+static unsigned long __init
 sandpoint_find_end_of_memory(void)
 {
-	ulong	size = 0;
+	bd_t *bp = (bd_t *)__res;

-#if 0	/* Leave out until DINK sets mem ctlr correctly */
-	size = mpc10x_get_mem_size(MPC10X_MEM_MAP_B);
-#else
-	size = 32*1024*1024;
-#endif
+	if (bp->bi_memsize)
+		return bp->bi_memsize;

-	return size;
+	/* This might be fixed in DINK32 12.4, or we'll have another
+	 * way to determine the correct memory size anyhow. */
+	/* return mpc10x_get_mem_size(MPC10X_MEM_MAP_B); */
+	return 32*1024*1024;
 }

 static void __init
@@ -418,14 +417,8 @@
 static int
 sandpoint_show_cpuinfo(struct seq_file *m)
 {
-	uint pvid;
-
-	pvid = mfspr(PVR);
-
 	seq_printf(m, "vendor\t\t: Motorola SPS\n");
 	seq_printf(m, "machine\t\t: Sandpoint\n");
-	seq_printf(m, "processor\t: PVID: 0x%x, vendor: %s\n",
-			pvid, (pvid & (1<<15) ? "IBM" : "Motorola"));

 	return 0;
 }
@@ -526,28 +519,21 @@
 static __inline__ void
 sandpoint_set_bat(void)
 {
-	unsigned long   bat3u, bat3l;
-	static int	mapping_set = 0;
-
-	if (!mapping_set) {
+	unsigned long bat3u, bat3l;

-		__asm__ __volatile__(
-		" lis %0,0xf800\n \
-		  ori %1,%0,0x002a\n \
-		  ori %0,%0,0x0ffe\n \
-		  mtspr 0x21e,%0\n \
-		  mtspr 0x21f,%1\n \
-		  isync\n \
-		  sync "
-		  : "=r" (bat3u), "=r" (bat3l));
-
-		mapping_set = 1;
-	}
-
-	return;
+	__asm__ __volatile__(
+			" lis %0,0xf800\n	\
+			ori %1,%0,0x002a\n	\
+			ori %0,%0,0x0ffe\n	\
+			mtspr 0x21e,%0\n	\
+			mtspr 0x21f,%1\n	\
+			isync\n			\
+			sync "
+			: "=r" (bat3u), "=r" (bat3l));
 }

-#ifdef	CONFIG_SERIAL_TEXT_DEBUG
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+#include <linux/serial.h>
 #include <linux/serialP.h>
 #include <linux/serial_reg.h>
 #include <asm/serial.h>
@@ -556,34 +542,34 @@
 	SERIAL_PORT_DFNS	/* Defined in <asm/serial.h> */
 };

+volatile unsigned char *com_port;
+volatile unsigned char *com_port_lsr;
+
 static void
+serial_writechar(char c)
+{
+	while ((*com_port_lsr & UART_LSR_THRE) == 0)
+		;
+	*com_port = c;
+}
+
+void
 sandpoint_progress(char *s, unsigned short hex)
 {
 	volatile char c;
-	volatile unsigned long com_port;
-	u16 shift;

-	com_port = rs_table[0].port;
-	shift = rs_table[0].iomem_reg_shift;
+	com_port = (volatile unsigned char *) rs_table[0].port;
+	com_port_lsr = com_port + UART_LSR;

-	while ((c = *s++) != 0) {
-		while ((*((volatile unsigned char *)com_port +
-				(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-		                ;
-	        *(volatile unsigned char *)com_port = c;
-
-		if (c == '\n') {
-			while ((*((volatile unsigned char *)com_port +
-				(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-					;
-	        	*(volatile unsigned char *)com_port = '\r';
-		}
-	}
+	while ((c = *s++) != 0)
+		serial_writechar(c);
+
+	/* Most messages don't have a newline in them */
+	serial_writechar('\n');
+	serial_writechar('\r');
 }
 #endif	/* CONFIG_SERIAL_TEXT_DEBUG */

-__init void sandpoint_setup_pci_ptrs(void);
-
 TODC_ALLOC();

 void __init
@@ -592,6 +578,32 @@
 {
 	parse_bootinfo(find_bootinfo());

+	/* ASSUMPTION:  If both r3 (bd_t pointer) and r6 (cmdline pointer)
+	 * are non-zero, then we should use the board info from the bd_t
+	 * structure and the cmdline pointed to by r6 instead of the
+	 * information from birecs, if any.  Otherwise, use the information
+	 * from birecs as discovered by the preceeding call to
+	 * parse_bootinfo().  This rule should work with both PPCBoot, which
+	 * uses a bd_t board info structure, and the kernel boot wrapper,
+	 * which uses birecs.
+	 */
+	if ( r3 && r6) {
+		/* copy board info structure */
+		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
+		/* copy command line */
+		*(char *)(r7+KERNELBASE) = 0;
+		strcpy(cmd_line, (char *)(r6+KERNELBASE));
+	}
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	/* take care of initrd if we have one */
+	if ( r4 )
+	{
+		initrd_start = r4 + KERNELBASE;
+		initrd_end = r5 + KERNELBASE;
+	}
+#endif /* CONFIG_BLK_DEV_INITRD */
+
 	/* Map in board regs, etc. */
 	sandpoint_set_bat();

@@ -607,7 +619,6 @@
 	ppc_md.irq_cannonicalize = sandpoint_irq_cannonicalize;
 	ppc_md.init_IRQ = sandpoint_init_IRQ;
 	ppc_md.get_irq = sandpoint_get_irq;
-	ppc_md.init = sandpoint_init2;

 	ppc_md.restart = sandpoint_restart;
 	ppc_md.power_off = sandpoint_power_off;
@@ -631,8 +642,6 @@

 #ifdef	CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = sandpoint_progress;
-#else	/* !CONFIG_SERIAL_TEXT_DEBUG */
-	ppc_md.progress = NULL;
 #endif	/* CONFIG_SERIAL_TEXT_DEBUG */

 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
@@ -640,6 +649,4 @@
         ppc_ide_md.default_io_base = sandpoint_ide_default_io_base;
         ppc_ide_md.ide_init_hwif = sandpoint_ide_init_hwif_ports;
 #endif
-
-	return;
 }

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
