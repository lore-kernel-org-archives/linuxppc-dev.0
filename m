Message-ID: <3766CB53.2479F2D2@phx.mcd.mot.com>
Date: Tue, 15 Jun 1999 14:53:23 -0700
From: Johnnie Peters <jpeters@phx.mcd.mot.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: More Motorola diffs
Content-Type: multipart/mixed;
 boundary="------------6167392A8427956A75D8006D"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------6167392A8427956A75D8006D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Everybody,

Here is the next set of diff files for the Motorola platforms.  The
only read addition is new SMP code that gets the second processor up
and running on the Dual MTX and MVME4600 boards.  It runs into
a locking problem pretty quickly but I have been able to
completly compile the kernel a couple of times.

I welcome mail and suggestions for making it better.

Johnnie
--------------6167392A8427956A75D8006D
Content-Type: text/plain; charset=us-ascii;
 name="mot_diff6"
Content-Disposition: inline;
 filename="mot_diff6"
Content-Transfer-Encoding: 7bit

diff -u -r --new-file linux-2.2.10_4/arch/ppc/config.in linux-2.1/arch/ppc/config.in
--- linux-2.2.10_4/arch/ppc/config.in	Sat May 29 18:54:46 1999
+++ linux-2.1/arch/ppc/config.in	Tue Jun  1 13:27:51 1999
@@ -92,7 +92,6 @@
 bool 'Support for Open Firmware device tree in /proc' CONFIG_PROC_DEVICETREE
 bool 'Support for TotalImpact TotalMP' CONFIG_TOTALMP
 bool 'Support for early boot text console (BootX only)' CONFIG_BOOTX_TEXT
-bool 'Support for Motorola Hot Swap' CONFIG_MOTOROLA_HOTSWAP
 if [ "$CONFIG_PREP" = "y" -o "$CONFIG_ALL_PPC" = "y" ]; then
   bool 'PReP bootloader kernel arguments' CONFIG_CMDLINE_BOOL y
   if [ "$CONFIG_CMDLINE_BOOL" = "y" ] ; then
diff -u -r --new-file linux-2.2.10_4/arch/ppc/kernel/Makefile linux-2.1/arch/ppc/kernel/Makefile
--- linux-2.2.10_4/arch/ppc/kernel/Makefile	Sat May 29 18:54:49 1999
+++ linux-2.1/arch/ppc/kernel/Makefile	Tue Jun  1 10:05:19 1999
@@ -65,7 +65,7 @@
 	$(HOSTCC) -o find_name find_name.c
 
 checks: checks.c
-	$(HOSTCC) ${CFLAGS} -D__KERNEL__ -o checks checks.c
+	$(CC) ${CFLAGS} -D__KERNEL__ -o checks checks.c
 	./checks
 
 include $(TOPDIR)/Rules.make
--- linux-2.2.10_4/arch/ppc/kernel/i8259.c	Sun May 23 14:15:37 1999
+++ linux-2.1/arch/ppc/kernel/i8259.c	Wed Jun  2 16:40:40 1999
@@ -13,33 +13,32 @@
 int i8259_irq(int cpu)
 {
 	int irq;
+	unsigned char irr;
 	
         /*
          * Perform an interrupt acknowledge cycle on controller 1
-         */                                                             
-        outb(0x0C, 0x20);
-        irq = inb(0x20) & 7;                                   
-        if (irq == 2)                                                     
-        {                                                                   
-                /*                                     
+         */
+	irr = inb(0x20) & ~cached_21;
+	if (!irr) return -1;
+	irq = 0;
+	while ((irq < 7) && !(irr&0x01))
+	{
+		irq++;
+		irr >>= 1;
+	}
+        if (irq == 2)
+	{
+                /*
                  * Interrupt is cascaded so perform interrupt
                  * acknowledge on controller 2
                  */
-                outb(0x0C, 0xA0);                      
-                irq = (inb(0xA0) & 7) + 8;
-        }
-        else if (irq==7)                                
-        {
-                /*                               
-                 * This may be a spurious interrupt
-                 *                         
-                 * Read the interrupt status register. If the most
-                 * significant bit is not set then there is no valid
-		 * interrupt
-		 */
-		outb(0x0b, 0x20);
-		if(~inb(0x20)&0x80)
-			return -1;
+		irr = inb(0xA0) & ~cached_A1;
+		irq = 8;
+		while ((irq < 15) && !(irr&0x01))
+		{
+			irq++;
+			irr >>= 1;
+		}
 	}
 	return irq;
 }
@@ -53,13 +52,13 @@
                 cached_A1 |= 1 << (irq_nr-8);                                   
                 inb(0xA1);      /* DUMMY */                                     
                 outb(cached_A1,0xA1);                                           
-                outb(0x20,0xA0);        /* Non-specific EOI */             
-                outb(0x20,0x20);        /* Non-specific EOI to cascade */
+                outb(0x62,0x20);             /* Specific EOI to cascade */
+                outb(0x60|(irq_nr-8),0xA0);  /* Specific EOI */
         } else {                                                            
                 cached_21 |= 1 << irq_nr;                                   
                 inb(0x21);      /* DUMMY */                                 
                 outb(cached_21,0x21);
-                outb(0x20,0x20);        /* Non-specific EOI */                 
+                outb(0x60|irq_nr,0x20);      /* Specific EOI */
         }                                                                
 }
 
diff -u -r --new-file linux-2.2.10_4/arch/ppc/kernel/irq.c linux-2.1/arch/ppc/kernel/irq.c
--- linux-2.2.10_4/arch/ppc/kernel/irq.c	Sat May 29 18:54:49 1999
+++ linux-2.1/arch/ppc/kernel/irq.c	Tue Jun  1 10:05:21 1999
@@ -1,5 +1,5 @@
 /*
- * $Id: irq.c,v 1.105.2.1 1999/05/29 19:10:05 cort Exp $
+ * $Id: irq.c,v 1.29 1999/06/01 17:05:21 jpeters Exp $
  *
  *  arch/ppc/kernel/irq.c
  *
@@ -139,13 +139,16 @@
 		/* Free */
 		for (p = &irq_desc[irq].action; (action = *p) != NULL; p = &action->next)
 		{
-			/* Found it - now free it */
-			save_flags(flags);
-			cli();
-			*p = action->next;
-			restore_flags(flags);
-			irq_kfree(action);
-			return 0;
+			if (action->dev_id == dev_id)
+			{
+				/* Found it - now free it */
+				save_flags(flags);
+				cli();
+				*p = action->next;
+				restore_flags(flags);
+				irq_kfree(action);
+				return 0;
+			}
 		}
 		return -ENOENT;
 	}
diff -u -r --new-file linux-2.2.10_4/arch/ppc/kernel/prep_pci.c linux-2.1/arch/ppc/kernel/prep_pci.c
--- linux-2.2.10_4/arch/ppc/kernel/prep_pci.c	Sun May 23 14:15:39 1999
+++ linux-2.1/arch/ppc/kernel/prep_pci.c	Wed Jun  9 13:14:20 1999
@@ -34,6 +34,9 @@
 
 /* How is the 82378 PIRQ mapping setup? */
 unsigned char *Motherboard_routes;
+void (*Motherboard_non0)(struct pci_dev *);
+
+void Mesquite_Map_Non0(struct pci_dev *);
 
 /* Used for Motorola to store system config register */
 static unsigned long	*ProcInfo;
@@ -682,8 +685,9 @@
 #define MOT_RAVEN_PRESENT	0x1
 #define MOT_HAWK_PRESENT	0x2
 
-int prep_keybd_present = 1;
+extern int kbd_present;
 int MotMPIC = 0;
+int mot_multi = 0;
 
 __initfunc(int raven_init(void))
 {
@@ -740,13 +744,18 @@
 	 */
 	ProcInfo = (unsigned long *)ioremap(0xfef80400, 4);
 
+	/* Indicate to system if this is a multiprocessor board */
+	if (!(*ProcInfo & MOT_PROC2_BIT)) {
+		mot_multi = 1;
+	}
+
 	/* This is a hack.  If this is a 2300 or 2400 mot board then there is
 	 * no keyboard controller and we have to indicate that.
 	 */
 	base_mod = inb(MOTOROLA_BASETYPE_REG);
 	if ((MotMPIC == MOT_HAWK_PRESENT) || (base_mod == 0xF9) ||
 	    (base_mod == 0xFA) || (base_mod == 0xE1))
-		prep_keybd_present = 0;
+		kbd_present = 0;
 
 	return 1;
 }
@@ -759,33 +768,34 @@
 	const char	*name;
 	unsigned char	*map;
 	unsigned char	*routes;
+	void		(*map_non0_bus)(struct pci_dev *);	/* For boards with more than bus 0 devices. */
 } mot_info[] = {
-	{0x300, 0x00, 0x00, "MVME 2400",			Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x010, 0x00, 0x00, "Genesis",				Genesis_pci_IRQ_map,	Genesis_pci_IRQ_routes},
-	{0x020, 0x00, 0x00, "Powerstack (Series E)",		Comet_pci_IRQ_map,	Comet_pci_IRQ_routes},
-	{0x040, 0x00, 0x00, "Blackhawk (Powerstack)",		Blackhawk_pci_IRQ_map,	Blackhawk_pci_IRQ_routes},
-	{0x050, 0x00, 0x00, "Omaha (PowerStack II Pro3000)",	Omaha_pci_IRQ_map,	Omaha_pci_IRQ_routes},
-	{0x060, 0x00, 0x00, "Utah (Powerstack II Pro4000)",	Utah_pci_IRQ_map,	Utah_pci_IRQ_routes},
-	{0x0A0, 0x00, 0x00, "Powerstack (Series EX)",		Comet2_pci_IRQ_map,	Comet2_pci_IRQ_routes},
-	{0x1E0, 0xE0, 0x00, "Mesquite cPCI (MCP750)",		Mesquite_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xE1, 0x00, "Sitka cPCI (MCPN750)",		Sitka_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xE2, 0x00, "Mesquite cPCI (MCP750) w/ HAC",	Mesquite_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xF6, 0x80, "MTX Plus",				MTXplus_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xF6, 0x81, "Dual MTX Plus",			MTXplus_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xF7, 0x80, "MTX wo/ Parallel Port",		MTX_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xF7, 0x81, "Dual MTX wo/ Parallel Port",	MTX_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xF8, 0x80, "MTX w/ Parallel Port",		MTX_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xF8, 0x81, "Dual MTX w/ Parallel Port",	MTX_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xF9, 0x00, "MVME 2300",			Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xFA, 0x00, "MVME 2300SC/2600",			Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xFB, 0x00, "MVME 2600 with MVME712M",		Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xFC, 0x00, "MVME 2600/2700 with MVME761",	Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xFD, 0x80, "MVME 3600 with MVME712M",		Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xFD, 0x81, "MVME 4600 with MVME712M",		Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xFE, 0x80, "MVME 3600 with MVME761",		Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xFE, 0x81, "MVME 4600 with MVME761",		Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x1E0, 0xFF, 0x00, "MVME 1600-001 or 1600-011",	Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes},
-	{0x000, 0x00, 0x00, "",					NULL,			NULL}
+	{0x300, 0x00, 0x00, "MVME 2400",			Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x010, 0x00, 0x00, "Genesis",				Genesis_pci_IRQ_map,	Genesis_pci_IRQ_routes, NULL},
+	{0x020, 0x00, 0x00, "Powerstack (Series E)",		Comet_pci_IRQ_map,	Comet_pci_IRQ_routes,	NULL},
+	{0x040, 0x00, 0x00, "Blackhawk (Powerstack)",		Blackhawk_pci_IRQ_map,	Blackhawk_pci_IRQ_routes, NULL},
+	{0x050, 0x00, 0x00, "Omaha (PowerStack II Pro3000)",	Omaha_pci_IRQ_map,	Omaha_pci_IRQ_routes,	NULL},
+	{0x060, 0x00, 0x00, "Utah (Powerstack II Pro4000)",	Utah_pci_IRQ_map,	Utah_pci_IRQ_routes,	NULL},
+	{0x0A0, 0x00, 0x00, "Powerstack (Series EX)",		Comet2_pci_IRQ_map,	Comet2_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xE0, 0x00, "Mesquite cPCI (MCP750)",		Mesquite_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xE1, 0x00, "Sitka cPCI (MCPN750)",		Sitka_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xE2, 0x00, "Mesquite cPCI (MCP750) w/ HAC",	Mesquite_pci_IRQ_map,	Raven_pci_IRQ_routes,	Mesquite_Map_Non0},
+	{0x1E0, 0xF6, 0x80, "MTX Plus",				MTXplus_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xF6, 0x81, "Dual MTX Plus",			MTXplus_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xF7, 0x80, "MTX wo/ Parallel Port",		MTX_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xF7, 0x81, "Dual MTX wo/ Parallel Port",	MTX_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xF8, 0x80, "MTX w/ Parallel Port",		MTX_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xF8, 0x81, "Dual MTX w/ Parallel Port",	MTX_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xF9, 0x00, "MVME 2300",			Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xFA, 0x00, "MVME 2300SC/2600",			Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xFB, 0x00, "MVME 2600 with MVME712M",		Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xFC, 0x00, "MVME 2600/2700 with MVME761",	Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xFD, 0x80, "MVME 3600 with MVME712M",		Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xFD, 0x81, "MVME 4600 with MVME712M",		Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xFE, 0x80, "MVME 3600 with MVME761",		Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xFE, 0x81, "MVME 4600 with MVME761",		Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x1E0, 0xFF, 0x00, "MVME 1600-001 or 1600-011",	Genesis2_pci_IRQ_map,	Raven_pci_IRQ_routes,	NULL},
+	{0x000, 0x00, 0x00, "",					NULL,			NULL,	NULL}
 };
 
 __initfunc(unsigned long prep_route_pci_interrupts(void))
@@ -846,6 +856,7 @@
 		Motherboard_map_name = (unsigned char *)mot_info[mot_entry].name;
 		Motherboard_map = mot_info[mot_entry].map;
 		Motherboard_routes = mot_info[mot_entry].routes;
+		Motherboard_non0 = mot_info[mot_entry].map_non0_bus;
 
 		if (!(mot_info[entry].cpu_type & 0x100)) {
 			/* AJF adjust level/edge control according to routes */
@@ -976,6 +987,93 @@
 	return 0;
 }
 
+static unsigned int pci_localpirqs[4] =
+{
+	24,
+	25,
+	26,
+	27
+};
+
+static unsigned int pci_remotepirqs[4] =
+{
+	28,
+	29,
+	30,
+	31
+};
+
+static unsigned int pci_remotedev = 0xc0;
+
+void
+Mesquite_Map_Non0(struct pci_dev *pdev)
+{
+	struct pci_bus  *pbus;          /* Parent Bus Structure Pointer */
+	unsigned int    devnum;         /* Accumulated Device Number */
+	unsigned int    irq;            /* IRQ Value */
+
+	/*
+	**    Device Interrupt Line register initialization.
+	**    The IRQ line number will be generated after
+	**    taking into account all the PCI-2-PCI bridge
+	**    devices between the device and the Host Bridge.
+	*/
+	devnum = PCI_SLOT(pdev->devfn);
+	pbus = pdev->bus;
+
+	while ((pbus->parent)->primary != (pbus->parent)->secondary)
+	{
+	    devnum += PCI_SLOT((pbus->self)->devfn);
+
+	    pbus = pbus->parent;
+	}
+
+	devnum &= 0x03;
+
+	/*
+	**    By default, get the PCI local domain IRQ value.
+	*/
+	irq = pci_localpirqs[devnum];
+
+	/*
+	**    Determine if the device is located in the
+	**    remote domain or not. We must find the
+	**    domain's bridge device located on bus 0.
+	*/
+	pbus = pdev->bus;
+
+	while (pbus->primary != 0)
+	    pbus = pbus->parent;
+
+	/*
+	**    Check the device/function of domain's bridge
+	**    device against the remote device/function.
+	**    If the same, then the device is located in
+	**    the remote domain. Thus, get the PCI remote
+	**    domain IRQ value.
+	*/
+	if ((pbus->self)->devfn == pci_remotedev)
+        irq = pci_remotepirqs[devnum];
+
+	/*
+	**    Validate the IRQ number.
+	*/
+	if (irq <= 255)
+	{
+	    /*
+	    **    Set the device's Interrupt Line register
+	    **    to the IRQ number and save it in the
+	    **    device's structure.
+	    */
+
+	    pci_write_config_byte(pdev, PCI_INTERRUPT_LINE, (u8)irq);
+
+	    pdev->irq = irq;
+
+	}
+	return;
+}
+
 __initfunc(
 void
 prep_pcibios_fixup(void))
@@ -1000,6 +1098,9 @@
 			if (dev->bus->number == 0) {
                        		dev->irq = openpic_to_irq(Motherboard_map[PCI_SLOT(dev->devfn)]);
 				pcibios_write_config_byte(dev->bus->number, dev->devfn, PCI_INTERRUPT_PIN, dev->irq);
+			} else {
+				if (Motherboard_non0 != NULL)
+					Motherboard_non0(dev);
 			}
 		}
 		return;
diff -u -r --new-file linux-2.2.10_4/arch/ppc/kernel/prep_setup.c linux-2.1/arch/ppc/kernel/prep_setup.c
--- linux-2.2.10_4/arch/ppc/kernel/prep_setup.c	Sat May 29 18:54:50 1999
+++ linux-2.1/arch/ppc/kernel/prep_setup.c	Wed Jun  9 13:14:21 1999
@@ -84,7 +84,6 @@
 extern unsigned char pckbd_sysrq_xlate[128];
 
 extern void prep_setup_pci_ptrs(void);
-extern void chrp_do_IRQ(struct pt_regs *regs, int cpu, int isfake);
 extern char saved_command_line[256];
 
 int _prep_type;
@@ -704,15 +703,27 @@
 }
 #endif
 
+unsigned long *MotSave_SmpIar;
+unsigned char *MotSave_CpusState[2];
+
 __initfunc(void
 prep_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	  unsigned long r6, unsigned long r7))
 {
+	RESIDUAL *old_res = (RESIDUAL *)(r3 + KERNELBASE);
+
 	/* make a copy of residual data */
 	if ( r3 )
 	{
 		memcpy((void *)res,(void *)(r3+KERNELBASE),
 		       sizeof(RESIDUAL));
+
+		/* These need to be saved for the Motorola Prep 
+		 * MVME4600 and Dual MTX boards.
+		 */
+		MotSave_SmpIar = &old_res->VitalProductData.SmpIar;
+		MotSave_CpusState[0] = &old_res->Cpus[0].CpuState;
+		MotSave_CpusState[1] = &old_res->Cpus[1].CpuState;
 	}
 
 	isa_io_base = PREP_ISA_IO_BASE;
diff -u -r --new-file linux-2.2.10_4/arch/ppc/kernel/smp.c linux-2.1/arch/ppc/kernel/smp.c
--- linux-2.2.10_4/arch/ppc/kernel/smp.c	Sat May 29 18:54:51 1999
+++ linux-2.1/arch/ppc/kernel/smp.c	Wed Jun  9 13:14:22 1999
@@ -1,5 +1,5 @@
 /*
- * $Id: smp.c,v 1.49.2.1 1999/05/29 19:10:20 cort Exp $
+ * $Id: smp.c,v 1.16 1999/06/09 20:14:22 jpeters Exp $
  *
  * Smp support for ppc.
  *
@@ -57,6 +57,10 @@
 extern int cpu_idle(void *unused);
 u_int openpic_read(volatile u_int *addr);
 
+extern int mot_multi;
+extern unsigned long *MotSave_SmpIar;
+extern unsigned char *MotSave_CpusState[2];
+
 /* register for interrupting the secondary processor on the powersurge */
 #define PSURGE_INTR	((volatile unsigned *)0xf80000c0)
 
@@ -171,7 +175,7 @@
 void smp_message_pass(int target, int msg, unsigned long data, int wait)
 {
 	int i;
-	if ( !(_machine & (_MACH_Pmac|_MACH_chrp)) )
+	if ( !(_machine & (_MACH_Pmac|_MACH_chrp|_MACH_prep)) )
 		return;
 
 	spin_lock(&mesg_pass_lock);
@@ -197,8 +201,8 @@
 		break;
 	}
 	
-	if ( _machine == _MACH_Pmac )
-	{
+	switch (_machine) {
+	case _MACH_Pmac:
 		/* interrupt secondary processor */
 		out_be32(PSURGE_INTR, ~0);
 		out_be32(PSURGE_INTR, 0);
@@ -208,10 +212,10 @@
 		 */
 		/* interrupt primary */
 		/**(volatile unsigned long *)(0xf3019000);*/
-	}
+		break;
 	
-	if ( _machine == _MACH_chrp )
-	{
+	case _MACH_chrp:
+	case _MACH_prep:
 		/*
 		 * There has to be some way of doing this better -
 		 * perhaps a sent-to-all or send-to-all-but-self
@@ -234,6 +238,7 @@
 			openpic_cause_IPI(target, 0, 1U << target);
 			break;
 		}
+		break;
 	}
 	
 	spin_unlock(&mesg_pass_lock);
@@ -274,8 +279,10 @@
 
 	if ( !(_machine & (_MACH_Pmac|_MACH_chrp)) )
 	{
-		printk("SMP not supported on this machine.\n");
-		return;
+		if (!((_machine & _MACH_prep) && mot_multi)) {
+			printk("SMP not supported on this machine.\n");
+			return;
+		}
 	}
 	
 	switch ( _machine )
@@ -293,6 +300,10 @@
 		       smp_num_cpus,
 		       10/*openpic_read(&OpenPIC->Processor[0]._Who_Am_I)*/);
 		break;
+	case _MACH_prep:
+		/* assume 2 for now == fix later -- Johnnie */
+                smp_num_cpus = 2;  
+                break;
 	}
 
 	/*
@@ -332,6 +343,11 @@
 		case _MACH_chrp:
 			*(unsigned long *)KERNELBASE = i;
 			asm volatile("dcbf 0,%0"::"r"(KERNELBASE):"memory");
+			break;
+		case _MACH_prep:
+			*MotSave_SmpIar = (unsigned long)__secondary_start_psurge - KERNELBASE;
+			*MotSave_CpusState[1] = CPU_GOOD;
+			printk("CPU1 reset, waiting\n");
 			break;
 		}
 		
--- linux-2.2.10_4/drivers/block/cmd646.c	Sun May 23 14:15:57 1999
+++ linux-2.1/drivers/block/cmd646.c	Mon Dec 21 17:23:53 1998
@@ -1,4 +1,4 @@
-/* $Id: cmd646.c,v 1.11 1998/12/13 08:36:54 davem Exp $
+/* $Id: cmd646.c,v 1.3 1998/12/22 00:23:53 jpeters Exp $
  * cmd646.c: Enable interrupts at initialization time on Ultra/PCI machines.
  *           Note, this driver is not used at all on other systems because
  *           there the "BIOS" has done all of the following already.
diff -u -r --new-file linux-2.2.10_4/drivers/block/genhd.c linux-2.1/drivers/block/genhd.c
--- linux-2.2.10_4/drivers/block/genhd.c	Sun May 23 14:15:58 1999
+++ linux-2.1/drivers/block/genhd.c	Wed May 26 13:16:46 1999
@@ -816,12 +831,12 @@
 	magic = label->magic_mushroom;
 	if(be32_to_cpu(magic) != SGI_LABEL_MAGIC) {
 		printk("Dev %s SGI disklabel: bad magic %08x\n",
		       kdevname(dev), magic);
 		brelse(bh);
 		return 0;
 	}
 	ui = ((unsigned int *) (label + 1)) - 1;
-	for(csum = 0; ui >= ((unsigned int *) label);) {
+	or(csum = 0; ui >= ((unsigned int *) label);) {
 		cs = *ui--;
 		csum += be32_to_cpu(cs);
 	}
diff -u -r --new-file linux-2.2.10_4/drivers/char/Config.in linux-2.1/drivers/char/Config.in
--- linux-2.2.10_4/drivers/char/Config.in	Sun May 23 14:16:02 1999
+++ linux-2.1/drivers/char/Config.in	Mon May 10 11:43:17 1999
@@ -64,6 +64,9 @@
 	tristate 'Logitech busmouse support' CONFIG_BUSMOUSE
 	tristate 'Microsoft busmouse support' CONFIG_MS_BUSMOUSE
 	bool 'PS/2 mouse (aka "auxiliary device") support' CONFIG_PSMOUSE
+	if [ "$CONFIG_PSMOUSE" = "y" ]; then
+		bool '  Init PS/2 mouse' INITIALIZE_PSMOUSE
+	fi
 	tristate 'C&T 82C710 mouse port support (as on TI Travelmate)' CONFIG_82C710_MOUSE
 	tristate 'PC110 digitizer pad support' CONFIG_PC110_PAD
 	endmenu
diff -u -r --new-file linux-2.2.10_4/drivers/char/keyboard.c linux-2.1/drivers/char/keyboard.c
--- linux-2.2.10_4/drivers/char/keyboard.c	Sun May 23 14:16:04 1999
+++ linux-2.1/drivers/char/keyboard.c	Wed May 26 08:41:51 1999
@@ -67,6 +67,9 @@
 struct wait_queue * keypress_wait = NULL;
 struct console;
 
+/* Keyboard presence flag */
+int kbd_present = 1;   /* Keyboard present by default */
+
 int keyboard_wait_for_keypress(struct console *co)
 {
 	sleep_on(&keypress_wait);
@@ -909,8 +913,15 @@
 
 	ttytab = console_driver.table;
 
-	kbd_init_hw();
-	init_bh(KEYBOARD_BH, kbd_bh);
-	mark_bh(KEYBOARD_BH);
-	return 0;
+	if (kbd_present)
+	{
+		kbd_init_hw();
+
+		init_bh(KEYBOARD_BH, kbd_bh);
+		mark_bh(KEYBOARD_BH);
+
+		return 0;
+	}
+	else
+		return 1;
 }
diff -u -r --new-file linux-2.2.10_4/drivers/char/pc_keyb.c linux-2.1/drivers/char/pc_keyb.c
--- linux-2.2.10_4/drivers/char/pc_keyb.c	Sun May 23 14:16:05 1999
+++ linux-2.1/drivers/char/pc_keyb.c	Wed Apr 28 10:53:34 1999
@@ -848,7 +848,8 @@
 		aux_count--;
 		return -EBUSY;
 	}
	kb_wait();
	kbd_write(KBD_CNTL_REG, KBD_CCMD_MOUSE_ENABLE);	/* Enable the
 							   auxiliary port on
 							   controller. */
 	aux_write_ack(AUX_ENABLE_DEV); /* Enable aux device */
@@ -966,8 +967,10 @@
 	queue->head = queue->tail = 0;
 	queue->proc_list = NULL;
 
-#ifdef INITIALIZE_MOUSE
-	kbd_write(KBD_CNTL_REG, KBD_CCMD_MOUSE_ENABLE);	/* Enable Aux. */
+#ifdef INITIALIZE_PSMOUSE
+	kbd_write(KBD_CNTL_REG, KBD_CCMD_MOUSE_ENABLE); /* Enable Aux. */
+	aux_write_ack(AUX_RESET);
+	aux_write_ack(AUX_SET_DEFAULT);
 	aux_write_ack(AUX_SET_SAMPLE);
 	aux_write_ack(100);			/* 100 samples/sec */
 	aux_write_ack(AUX_SET_RES);
diff -u -r --new-file linux-2.2.10_4/drivers/char/pc_keyb.h linux-2.1/drivers/char/pc_keyb.h
--- linux-2.2.10_4/drivers/char/pc_keyb.h	Sun May 23 14:16:05 1999
+++ linux-2.1/drivers/char/pc_keyb.h	Tue Mar 16 22:11:10 1999
@@ -14,7 +14,6 @@
 #define KBD_REPORT_UNKN			/* Report unknown scan codes */
 #define KBD_REPORT_TIMEOUTS		/* Report keyboard timeouts */
 #undef KBD_IS_FOCUS_9000		/* We have the brain-damaged FOCUS-9000 keyboard */
-#undef INITIALIZE_MOUSE			/* Define if your PS/2 mouse needs initialization. */
 
 
 
@@ -113,6 +112,7 @@
 #define AUX_SET_SAMPLE		0xF3	/* Set sample rate */
 #define AUX_ENABLE_DEV		0xF4	/* Enable aux device */
 #define AUX_DISABLE_DEV		0xF5	/* Disable aux device */
+#define AUX_SET_DEFAULT		0xF6	/* Set to default state */
 #define AUX_RESET		0xFF	/* Reset aux device */
 #define AUX_ACK			0xFA	/* Command byte ACK. */
 
diff -u -r --new-file linux-2.2.10_4/drivers/pci/oldproc.c linux-2.1/drivers/pci/oldproc.c
--- linux-2.2.10_4/drivers/pci/oldproc.c	Tue Jun 15 08:35:34 1999
+++ linux-2.1/drivers/pci/oldproc.c	Tue Jun 15 10:09:51 1999
@@ -378,9 +378,10 @@
 	DEVICE( VORTEX,		VORTEX_GDT6557RP2,"GDT 6557RP2"),
 	DEVICE( VORTEX,		VORTEX_GDT6x11RP2,"GDT 6111RP2/6511RP2"),
 	DEVICE( VORTEX,		VORTEX_GDT6x21RP2,"GDT 6121RP2/6521RP2"),
	DEVICE( EF,		EF_ATM_FPGA,   	"155P-MF1 (FPGA)"),
	DEVICE( EF,		EF_ATM_ASIC,    "155P-MF1 (ASIC)"),
	DEVICE( IDT,		IDT_NICSTAR,	"NICStAR"),
	DEVICE( FORE,		FORE_PCA200PC,  "PCA-200PC"),
 	DEVICE( FORE,		FORE_PCA200E,	 "PCA-200E"),
 	DEVICE( IMAGINGTECH,	IMAGINGTECH_ICPCI, "MVC IC-PCI"),
 	DEVICE( PHILIPS,	PHILIPS_SAA7145,"SAA7145"),
@@ -778,6 +779,7 @@
 	      case PCI_VENDOR_ID_SMC2:		return "SMC";
 	      case PCI_VENDOR_ID_VORTEX:	return "VORTEX";
 	      case PCI_VENDOR_ID_EF:		return "Efficient Networks";
+	      case PCI_VENDOR_ID_IDT:		return "IDT";
 	      case PCI_VENDOR_ID_FORE:		return "Fore Systems";
 	      case PCI_VENDOR_ID_IMAGINGTECH:	return "Imaging Technology";
 	      case PCI_VENDOR_ID_PHILIPS:	return "Philips";
diff -u -r --new-file linux-2.2.10_4/include/asm-ppc/io.h linux-2.1/include/asm-ppc/io.h
--- linux-2.2.10_4/include/asm-ppc/io.h	Sun May 23 14:17:24 1999
+++ linux-2.1/include/asm-ppc/io.h	Tue May  4 15:25:53 1999
@@ -42,7 +42,7 @@
 #define writeb(b,addr) out_8((volatile unsigned char *)(addr), (b))
 #if defined(CONFIG_APUS)
 #define readw(addr) (*(volatile unsigned short *) (addr))
-#define readl(addr) (*(volatile unsigned int *) (addr))
+#define readl(addr) in_le32((volatile unsigned *)(addr))
 #define writew(b,addr) ((*(volatile unsigned short *) (addr)) = (b))
 #define writel(b,addr) ((*(volatile unsigned int *) (addr)) = (b))
 #else
@@ -77,7 +77,7 @@
 #define outb_p(val, port)	out_8((unsigned char *)((port)+_IO_BASE), (val))
 #define inw_p(port)		in_le16((unsigned short *)((port)+_IO_BASE))
 #define outw_p(val, port)	out_le16((unsigned short *)((port)+_IO_BASE), (val))
-#define inl_p(port)		in_le32(((unsigned *)(port)+_IO_BASE))
+#define inl_p(port)		in_le32((unsigned *)((port)+_IO_BASE))
 #define outl_p(val, port)	out_le32((unsigned *)((port)+_IO_BASE), (val))
 
 extern void _insb(volatile unsigned char *port, void *buf, int ns);
diff -u -r --new-file linux-2.2.10_4/include/linux/pci.h linux-2.1/include/linux/pci.h
--- linux-2.2.10_4/include/linux/pci.h	Tue Jun 15 08:36:00 1999
+++ linux-2.1/include/linux/pci.h	Tue Jun 15 10:10:12 1999
@@ -794,6 +794,9 @@
 #define PCI_DEVICE_ID_EF_ATM_FPGA	0x0000
 #define PCI_DEVICE_ID_EF_ATM_ASIC	0x0002
 
+#define PCI_VENDOR_ID_IDT		0x111d
+#define PCI_DEVICE_ID_IDT_NICSTAR	0x0001
+
 #define PCI_VENDOR_ID_FORE		0x1127
 #define PCI_DEVICE_ID_FORE_PCA200PC	0x0210
 #define PCI_DEVICE_ID_FORE_PCA200E	0x0300

--------------6167392A8427956A75D8006D--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
