Message-ID: <37572360.2762DEBD@phx.mcd.mot.com>
Date: Thu, 03 Jun 1999 17:52:48 -0700
From: Johnnie Peters <jpeters@phx.mcd.mot.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Support for Motorola Platforms
Content-Type: multipart/mixed;
 boundary="------------B3EA4C4ABB452A06CD15D3B5"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------B3EA4C4ABB452A06CD15D3B5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Everybody,

Here are the changes to the vger tree for Motorola platform support.
They are current to the vger tree from about noon pacific time today.

I hope somebody finds them usefull.

Johnnie Peters
Motorola Computer Group
--------------B3EA4C4ABB452A06CD15D3B5
Content-Type: text/plain; charset=us-ascii;
 name="mot_diff5"
Content-Disposition: inline;
 filename="mot_diff5"
Content-Transfer-Encoding: 7bit

diff -u -r --new-file linux-2.2.10_2/arch/ppc/boot/misc.c linux.jp/arch/ppc/boot/misc.c
--- linux-2.2.10_2/arch/ppc/boot/misc.c	Sat May 29 18:54:47 1999
+++ linux.jp/arch/ppc/boot/misc.c	Fri May 28 07:52:00 1999
@@ -1,7 +1,7 @@
 /*
  * misc.c
  *
- * $Id: misc.c,v 1.64.2.2 1999/05/29 19:09:29 cort Exp $
+ * $Id: misc.c,v 1.27 1999/05/28 14:52:00 jpeters Exp $
  * 
  * Adapted for PowerPC by Gary Thomas
  *
@@ -311,6 +311,26 @@
 
 unsigned char sanity[0x2000];
 
+/*
+ * This routine is used to park the second processor on the 
+ * Motorola dual processor platforms.  This will be replaced
+ * in the future by the functionality to start it.
+ */
+void
+park_cpus()
+{
+	volatile unsigned long *smp_iar = &(hold_residual->VitalProductData.SmpIar);
+	int i;
+	
+	/* Wait for indication to park. */
+	while (*smp_iar == 0) {
+                for (i=0; i < 512; i++);
+	}
+
+	/* Wait forever */
+	while(1);
+}
+
 unsigned long
 decompress_kernel(unsigned long load_addr, int num_words, unsigned long cksum,
 		  RESIDUAL *residual, void *OFW_interface)
@@ -368,6 +388,16 @@
 					keyb_present = 0;	/* no keyboard */
 				}
 			}
+
+			/* If this is a multiprocessor system then
+			 * park the other processor so that the
+			 * kernel knows where to find them.
+			 */
+			if (residual->MaxNumCpus > 1) {
+				residual->VitalProductData.SmpIar = park_cpus;
+				residual->Cpus[1].CpuState = CPU_GOOD;
+				hold_residual->Cpus[1].CpuState = CPU_GOOD_FW;
+			}
 		}
 		memcpy(hold_residual,residual,sizeof(RESIDUAL));
 	} else {
@@ -465,22 +495,23 @@
 		puts(" ");
 		puthex((unsigned long)zimage_size+(unsigned long)zimage_start);
 		puts("\n");
-	}
 
-	/* relocate initrd */
-	if ( initrd_start )
-	{
+		/* relocate initrd */
+		if ( initrd_start )
+		{
+			puts("initrd at:     "); puthex(initrd_start);
+			puts(" "); puthex(initrd_end); puts("\n");
+			avail_ram = (char *)PAGE_ALIGN(
+				(unsigned long)zimage_size+(unsigned long)zimage_start);
+			memcpy ((void *)avail_ram, (void *)initrd_start, INITRD_SIZE );
+			initrd_start = (unsigned long)avail_ram;
+			initrd_end = initrd_start + INITRD_SIZE;
+			puts("relocated to:  "); puthex(initrd_start);
+			puts(" "); puthex(initrd_end); puts("\n");
+		}
+	} else if ( initrd_start ) {
 		puts("initrd at:     "); puthex(initrd_start);
 		puts(" "); puthex(initrd_end); puts("\n");
-#ifdef OMIT
-		avail_ram = (char *)PAGE_ALIGN(
-			(unsigned long)zimage_size+(unsigned long)zimage_start);
-		memcpy ((void *)avail_ram, (void *)initrd_start, INITRD_SIZE );
-		initrd_start = (unsigned long)avail_ram;
-		initrd_end = initrd_start + INITRD_SIZE;
-		puts("relocated to:  "); puthex(initrd_start);
-		puts(" "); puthex(initrd_end); puts("\n");
-#endif
 	}
 
 	avail_ram = (char *)0x00400000;
diff -u -r --new-file linux-2.2.10_2/arch/ppc/config.in linux.jp/arch/ppc/config.in
--- linux-2.2.10_2/arch/ppc/config.in	Sat May 29 18:54:46 1999
+++ linux.jp/arch/ppc/config.in	Tue Jun  1 13:27:51 1999
@@ -1,4 +1,4 @@
@@ -92,7 +92,6 @@
 bool 'Support for Open Firmware device tree in /proc' CONFIG_PROC_DEVICETREE
 bool 'Support for TotalImpact TotalMP' CONFIG_TOTALMP
 bool 'Support for early boot text console (BootX only)' CONFIG_BOOTX_TEXT
-bool 'Support for Motorola Hot Swap' CONFIG_MOTOROLA_HOTSWAP
 if [ "$CONFIG_PREP" = "y" -o "$CONFIG_ALL_PPC" = "y" ]; then
   bool 'PReP bootloader kernel arguments' CONFIG_CMDLINE_BOOL y
   if [ "$CONFIG_CMDLINE_BOOL" = "y" ] ; then
@@ -146,6 +145,9 @@
   bool 'Network device support' CONFIG_NETDEVICES
   if [ "$CONFIG_NETDEVICES" = "y" ]; then
     source drivers/net/Config.in
+    if [ "$CONFIG_ATM" = "y" ]; then
+      source drivers/atm/Config.in
+    fi
   fi
   endmenu
 fi
diff -u -r --new-file linux-2.2.10_2/arch/ppc/kernel/Makefile linux.jp/arch/ppc/kernel/Makefile
--- linux-2.2.10_2/arch/ppc/kernel/Makefile	Sat May 29 18:54:49 1999
+++ linux.jp/arch/ppc/kernel/Makefile	Tue Jun  1 10:05:19 1999
@@ -65,7 +65,7 @@
 	$(HOSTCC) -o find_name find_name.c
 
 checks: checks.c
-	$(HOSTCC) ${CFLAGS} -D__KERNEL__ -o checks checks.c
+	$(CC) ${CFLAGS} -D__KERNEL__ -o checks checks.c
 	./checks
 
 include $(TOPDIR)/Rules.make
diff -u -r --new-file linux-2.2.10_2/arch/ppc/kernel/i8259.c linux.jp/arch/ppc/kernel/i8259.c
--- linux-2.2.10_2/arch/ppc/kernel/i8259.c	Sun May 23 14:15:37 1999
+++ linux.jp/arch/ppc/kernel/i8259.c	Wed Jun  2 16:40:40 1999
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
 
diff -u -r --new-file linux-2.2.10_2/arch/ppc/kernel/irq.c linux.jp/arch/ppc/kernel/irq.c
--- linux-2.2.10_2/arch/ppc/kernel/irq.c	Sat May 29 18:54:49 1999
+++ linux.jp/arch/ppc/kernel/irq.c	Tue Jun  1 10:05:21 1999
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
diff -u -r --new-file linux-2.2.10_2/arch/ppc/kernel/prep_pci.c linux.jp/arch/ppc/kernel/prep_pci.c
--- linux-2.2.10_2/arch/ppc/kernel/prep_pci.c	Sun May 23 14:15:39 1999
+++ linux.jp/arch/ppc/kernel/prep_pci.c	Tue Jun  1 13:28:26 1999
@@ -34,6 +34,9 @@
 
 /* How is the 82378 PIRQ mapping setup? */
 unsigned char *Motherboard_routes;
+void (*Motherboard_non0)(struct pci_dev *);
+
+void Mesquite_Map_Non0(struct pci_dev *);
 
 /* Used for Motorola to store system config register */
 static unsigned long	*ProcInfo;
@@ -682,7 +685,7 @@
 #define MOT_RAVEN_PRESENT	0x1
 #define MOT_HAWK_PRESENT	0x2
 
-int prep_keybd_present = 1;
+extern int kbd_present;
 int MotMPIC = 0;
 
 __initfunc(int raven_init(void))
@@ -746,7 +749,7 @@
 	base_mod = inb(MOTOROLA_BASETYPE_REG);
 	if ((MotMPIC == MOT_HAWK_PRESENT) || (base_mod == 0xF9) ||
 	    (base_mod == 0xFA) || (base_mod == 0xE1))
-		prep_keybd_present = 0;
+		kbd_present = 0;
 
 	return 1;
 }
@@ -759,33 +762,34 @@
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
@@ -846,6 +850,7 @@
 		Motherboard_map_name = (unsigned char *)mot_info[mot_entry].name;
 		Motherboard_map = mot_info[mot_entry].map;
 		Motherboard_routes = mot_info[mot_entry].routes;
+		Motherboard_non0 = mot_info[mot_entry].map_non0_bus;
 
 		if (!(mot_info[entry].cpu_type & 0x100)) {
 			/* AJF adjust level/edge control according to routes */
@@ -976,6 +981,93 @@
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
@@ -1000,6 +1092,9 @@
 			if (dev->bus->number == 0) {
                        		dev->irq = openpic_to_irq(Motherboard_map[PCI_SLOT(dev->devfn)]);
 				pcibios_write_config_byte(dev->bus->number, dev->devfn, PCI_INTERRUPT_PIN, dev->irq);
+			} else {
+				if (Motherboard_non0 != NULL)
+					Motherboard_non0(dev);
 			}
 		}
 		return;
diff -u -r --new-file linux-2.2.10_2/arch/ppc/kernel/prep_setup.c linux.jp/arch/ppc/kernel/prep_setup.c
--- linux-2.2.10_2/arch/ppc/kernel/prep_setup.c	Sat May 29 18:54:50 1999
+++ linux.jp/arch/ppc/kernel/prep_setup.c	Sat May 29 22:00:37 1999
@@ -84,7 +84,6 @@
 extern unsigned char pckbd_sysrq_xlate[128];
 
 extern void prep_setup_pci_ptrs(void);
-extern void chrp_do_IRQ(struct pt_regs *regs, int cpu, int isfake);
 extern char saved_command_line[256];
 
 int _prep_type;
diff -u -r --new-file linux-2.2.10_2/drivers/block/cmd646.c linux.jp/drivers/block/cmd646.c
--- linux-2.2.10_2/drivers/block/cmd646.c	Sun May 23 14:15:57 1999
+++ linux.jp/drivers/block/cmd646.c	Mon Dec 21 17:23:53 1998
@@ -1,4 +1,4 @@
-/* $Id: cmd646.c,v 1.11 1998/12/13 08:36:54 davem Exp $
+/* $Id: cmd646.c,v 1.3 1998/12/22 00:23:53 jpeters Exp $
  * cmd646.c: Enable interrupts at initialization time on Ultra/PCI machines.
  *           Note, this driver is not used at all on other systems because
  *           there the "BIOS" has done all of the following already.
diff -u -r --new-file linux-2.2.10_2/drivers/block/genhd.c linux.jp/drivers/block/genhd.c
--- linux-2.2.10_2/drivers/block/genhd.c	Sun May 23 14:15:58 1999
+++ linux.jp/drivers/block/genhd.c	Wed May 26 13:16:46 1999
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
diff -u -r --new-file linux-2.2.10_2/drivers/char/Config.in linux.jp/drivers/char/Config.in
--- linux-2.2.10_2/drivers/char/Config.in	Sun May 23 14:16:02 1999
+++ linux.jp/drivers/char/Config.in	Mon May 10 11:43:17 1999
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
diff -u -r --new-file linux-2.2.10_2/drivers/char/keyboard.c linux.jp/drivers/char/keyboard.c
--- linux-2.2.10_2/drivers/char/keyboard.c	Sun May 23 14:16:04 1999
+++ linux.jp/drivers/char/keyboard.c	Wed May 26 08:41:51 1999
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
diff -u -r --new-file linux-2.2.10_2/drivers/char/pc_keyb.c linux.jp/drivers/char/pc_keyb.c
--- linux-2.2.10_2/drivers/char/pc_keyb.c	Sun May 23 14:16:05 1999
+++ linux.jp/drivers/char/pc_keyb.c	Wed Apr 28 10:53:34 1999
@@ -848,7 +848,8 @@
 		aux_count--;
 		return -EBUSY;
 	}
+	kb_wait();
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
diff -u -r --new-file linux-2.2.10_2/drivers/char/pc_keyb.h linux.jp/drivers/char/pc_keyb.h
--- linux-2.2.10_2/drivers/char/pc_keyb.h	Sun May 23 14:16:05 1999
+++ linux.jp/drivers/char/pc_keyb.h	Tue Mar 16 22:11:10 1999
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
 
diff -u -r --new-file linux-2.2.10_2/drivers/pci/oldproc.c linux.jp/drivers/pci/oldproc.c
--- linux-2.2.10_2/drivers/pci/oldproc.c	Sun May 23 14:16:37 1999
+++ linux.jp/drivers/pci/oldproc.c	Mon May 24 15:12:17 1999
@@ -763,6 +764,7 @@
 	      case PCI_VENDOR_ID_SMC2:		return "SMC";
 	      case PCI_VENDOR_ID_VORTEX:	return "VORTEX";
 	      case PCI_VENDOR_ID_EF:		return "Efficient Networks";
+	      case PCI_VENDOR_ID_IDT:		return "IDT";
 	      case PCI_VENDOR_ID_FORE:		return "Fore Systems";
 	      case PCI_VENDOR_ID_IMAGINGTECH:	return "Imaging Technology";
 	      case PCI_VENDOR_ID_PHILIPS:	return "Philips";
diff -u -r --new-file linux-2.2.10_2/include/asm-ppc/io.h linux.jp/include/asm-ppc/io.h
--- linux-2.2.10_2/include/asm-ppc/io.h	Sun May 23 14:17:24 1999
+++ linux.jp/include/asm-ppc/io.h	Thu Jun  3 12:41:15 1999
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
diff -u -r --new-file linux-2.2.10_2/include/linux/pci.h linux.jp/include/linux/pci.h
--- linux-2.2.10_2/include/linux/pci.h	Sun May 23 14:17:29 1999
+++ linux.jp/include/linux/pci.h	Thu Jun  3 12:40:56 1999
@@ -794,6 +794,9 @@
 #define PCI_DEVICE_ID_EF_ATM_FPGA	0x0000
 #define PCI_DEVICE_ID_EF_ATM_ASIC	0x0002
 
+#define PCI_VENDOR_ID_IDT		0x111d
+#define PCI_DEVICE_ID_IDT_NICSTAR	0x0001
+
 #define PCI_VENDOR_ID_FORE		0x1127
 #define PCI_DEVICE_ID_FORE_PCA200PC	0x0210
 #define PCI_DEVICE_ID_FORE_PCA200E	0x0300

--------------B3EA4C4ABB452A06CD15D3B5--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
