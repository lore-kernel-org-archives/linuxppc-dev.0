Message-ID: <3B79B235.BCEB9131@mvista.com>
Date: Tue, 14 Aug 2001 19:20:21 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: James F Dougherty <jfd@GigabitNetworks.COM>, anj@aps.anl.gov,
	mporter@mvista.com, linuxppc-embedded@lists.linuxppc.org,
	cort@cs.nmt.edu, jfd@cs.stanford.edu
Subject: Re: MPC8240 EPIC Driver (Attached)
References: <200108140743.AAA05509@krakatoa.gigabitnetworks.com> <3B7963C3.36191B14@mvista.com> <3B799A0A.497DFF56@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------5EF9E8D050C5C996102048BB"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------5EF9E8D050C5C996102048BB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Mark A. Greer" wrote:

> I took a look around and I think I deleted what I had.....

Attached is a patch that works with Sandpoint X3, adds the new
serial mode interrupt stuff, and 8245.  You may have to manually
apply it, but it gets you started.

It's on my check-in list, but I have higher priority things at
the moment.  Like Mark said, I would like to see a better OpenPIC
solution that could also include EPIC and be a little more configurable.
I was hoping this would have happened by now, as I would have rather
added to that instead of propagating more hacks.


	-- Dan
--------------5EF9E8D050C5C996102048BB
Content-Type: text/plain; charset=us-ascii;
 name="x3patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x3patch"

diff -Naru linux-hhl20/arch/ppc/config.in hhl-sandpointx3/arch/ppc/config.in
--- linux-hhl20/arch/ppc/config.in	Wed May 23 15:46:02 2001
+++ hhl-sandpointx3/arch/ppc/config.in	Wed Jul 25 15:30:19 2001
@@ -198,6 +198,10 @@
   bool 'Thermal Management Support' CONFIG_TAU
 fi

+if [ "$CONFIG_SANDPOINT" = "y" ]; then
+  bool 'Sandpoint X3' CONFIG_SANDPOINT_X3
+fi
+
 # OpenFirmware is currently, and possibly only ever, found on machines which
 # fall under CONFIG_WORKSTATION_PPC, so:
 define_bool CONFIG_OPENFIRMWARE $CONFIG_WORKSTATION_PPC
diff -Naru linux-hhl20/arch/ppc/kernel/mpc10x.h hhl-sandpointx3/arch/ppc/kernel/mpc10x.h
--- linux-hhl20/arch/ppc/kernel/mpc10x.h	Wed Apr  4 13:39:08 2001
+++ hhl-sandpointx3/arch/ppc/kernel/mpc10x.h	Wed Jul 25 15:30:19 2001
@@ -46,6 +46,7 @@
 				  PCI_VENDOR_ID_MOTOROLA)
 #define	MPC10X_BRIDGE_8240	((0x0003 << 16) | PCI_VENDOR_ID_MOTOROLA)
 #define	MPC10X_BRIDGE_107	((0x0004 << 16) | PCI_VENDOR_ID_MOTOROLA)
+#define	MPC10X_BRIDGE_8245	((0x0006 << 16) | PCI_VENDOR_ID_MOTOROLA)

 /* Define the type of map to use */
 #define	MPC10X_MEM_MAP_A		1
diff -Naru linux-hhl20/arch/ppc/kernel/mpc10x_common.c hhl-sandpointx3/arch/ppc/kernel/mpc10x_common.c
--- linux-hhl20/arch/ppc/kernel/mpc10x_common.c	Wed Apr  4 13:15:07 2001
+++ hhl-sandpointx3/arch/ppc/kernel/mpc10x_common.c	Wed Jul 25 15:30:19 2001
@@ -85,6 +85,7 @@
 		case MPC10X_BRIDGE_106:
 		case MPC10X_BRIDGE_8240:
 		case MPC10X_BRIDGE_107:
+		case MPC10X_BRIDGE_8245:
 			break;
 		default:
 			if (ppc_md.progress)
diff -Naru linux-hhl20/arch/ppc/kernel/open_pic.c hhl-sandpointx3/arch/ppc/kernel/open_pic.c
--- linux-hhl20/arch/ppc/kernel/open_pic.c	Wed May 23 15:46:03 2001
+++ hhl-sandpointx3/arch/ppc/kernel/open_pic.c	Wed Jul 25 15:30:19 2001
@@ -48,6 +48,9 @@
 void openpic_eoi(void);
 static void openpic_set_priority(u_int pri);
 static void openpic_set_spurious(u_int vector);
+static void openpic_enable_sie(void);
+static void openpic_eicr_set_clk(u_int clkval);
+static void openpic_reset(void);

 #ifdef CONFIG_SMP
 /* Interprocessor Interrupts */
@@ -71,7 +74,6 @@
  * for completeness and future reference.
  */
 #ifdef notused
-static void openpic_reset(void);
 static void openpic_enable_8259_pass_through(void);
 static u_int openpic_get_priority(void);
 static u_int openpic_get_spurious(void);
@@ -269,6 +271,9 @@
 		return;
 	}
 	OpenPIC = (volatile struct OpenPIC *)OpenPIC_Addr;
+#ifdef CONFIG_SANDPOINT_X3
+	openpic_reset();
+#endif

 	if ( ppc_md.progress ) ppc_md.progress("openpic enter",0x122);

@@ -385,8 +390,15 @@
 				"82c59 cascade", NULL))
 			printk("Unable to get OpenPIC IRQ 0 for cascade\n");
 	}
-	openpic_set_priority(0);
+#ifdef CONFIG_SANDPOINT_X3
 	openpic_disable_8259_pass_through();
+	openpic_eicr_set_clk(7);	/* Slowest value until we know better */
+	openpic_enable_sie();
+	openpic_set_priority(0);
+#else
+ 	openpic_set_priority(0);
+ 	openpic_disable_8259_pass_through();
+#endif

 	if (ppc_md.progress) ppc_md.progress("openpic exit",0x222);
 }
@@ -424,13 +436,15 @@
 #endif
 }

-#ifdef notused
 static void openpic_reset(void)
 {
 	openpic_setfield(&OpenPIC->Global.Global_Configuration0,
 			 OPENPIC_CONFIG_RESET);
+	while (openpic_readfield(&OpenPIC->Global.Global_Configuration0,
+			 OPENPIC_CONFIG_RESET) != 0);
 }

+#ifdef notused
 static void openpic_enable_8259_pass_through(void)
 {
 	openpic_clearfield(&OpenPIC->Global.Global_Configuration0,
@@ -442,6 +456,18 @@
 {
 	openpic_setfield(&OpenPIC->Global.Global_Configuration0,
 			 OPENPIC_CONFIG_8259_PASSTHROUGH_DISABLE);
+}
+
+static void openpic_enable_sie(void)
+{
+	openpic_setfield(&OpenPIC->Global.Global_Configuration1,
+			 OPENPIC_EICR_SIE);
+}
+
+static void openpic_eicr_set_clk(u_int clkval)
+{
+	openpic_writefield(&OpenPIC->Global.Global_Configuration1,
+			 OPENPIC_EICR_S_CLK_MASK, (clkval << 28));
 }

 #ifdef CONFIG_SMP
diff -Naru linux-hhl20/arch/ppc/kernel/open_pic_defs.h hhl-sandpointx3/arch/ppc/kernel/open_pic_defs.h
--- linux-hhl20/arch/ppc/kernel/open_pic_defs.h	Wed May 23 15:46:03 2001
+++ hhl-sandpointx3/arch/ppc/kernel/open_pic_defs.h	Wed Jul 25 15:30:19 2001
@@ -206,6 +206,14 @@
 #define OPENPIC_CONFIG_BASE_MASK		0x000fffff

     /*
+     *  Global Configuration Register 1
+     *  This is the EICR on EPICs.
+     */
+
+#define OPENPIC_EICR_S_CLK_MASK			0x70000000
+#define OPENPIC_EICR_SIE			0x08000000
+
+    /*
      *  Vendor Identification Register
      */

diff -Naru linux-hhl20/arch/ppc/kernel/sandpoint.h hhl-sandpointx3/arch/ppc/kernel/sandpoint.h
--- linux-hhl20/arch/ppc/kernel/sandpoint.h	Wed Mar 28 09:05:21 2001
+++ hhl-sandpointx3/arch/ppc/kernel/sandpoint.h	Wed Jul 25 15:30:19 2001
@@ -21,11 +21,29 @@
 #ifndef __PPC_KERNEL_SANDPOINT_H
 #define __PPC_KERNEL_SANDPOINT_H

+#ifdef CONFIG_SANDPOINT_X3
+#define SANDPOINT_SIO_SLOT      0	/* Cascaded from EPIC IRQ 0 */
+#if 0
+/* The Sandpoint X3 allows the IDE interrupt to be directly connected
+ * from the Windbond (PCI INTC or INTD) to the serial EPIC.  Someday
+ * we should try this, but it was easier to use the existing 83c553
+ * initialization than change it to route the different interrupts :-).
+ *	-- Dan
+ */
+#define SANDPOINT_IDE_INT0	23	/* EPIC 7 */
+#define SANDPOINT_IDE_INT1	24	/* EPIC 8 */
+#else
+#define SANDPOINT_IDE_INT0	14	/* 8259 Test */
+#define SANDPOINT_IDE_INT1	15	/* 8259 Test */
+#endif
+#else
 /*
  * Define the PCI slot that the 8259 is sharing interrupts with.
  * Valid values are 1 (PCI slot 2) and 2 (PCI slot 3).
  */
 #define SANDPOINT_SIO_SLOT      1
+#endif
+
 #define	SANDPOINT_SIO_IRQ	(SANDPOINT_SIO_SLOT + NUM_8259_INTERRUPTS)

 void sandpoint_find_bridges(void);
diff -Naru linux-hhl20/arch/ppc/kernel/sandpoint_pci.c hhl-sandpointx3/arch/ppc/kernel/sandpoint_pci.c
--- linux-hhl20/arch/ppc/kernel/sandpoint_pci.c	Tue Apr  3 11:47:38 2001
+++ hhl-sandpointx3/arch/ppc/kernel/sandpoint_pci.c	Wed Jul 25 15:30:19 2001
@@ -45,10 +45,24 @@
 		{ SANDPOINT_SIO_IRQ,
 		       0,  0,  0 },	/* IDSEL 11 - i8259 on Winbond */
 		{  0,  0,  0,  0 },	/* IDSEL 12 - unused */
+#ifdef CONFIG_SANDPOINT_X3
+#if 0	/* This is what it _should_ look like -- Dan */
+		{ 17, 20, 19, 18 },	/* IDSEL 13 - PCI slot 1 */
+		{ 18, 17, 20, 19 },	/* IDSEL 14 - PCI slot 2 */
+		{ 19, 18, 17, 20 },	/* IDSEL 15 - PCI slot 3 */
+		{ 20, 19, 18, 17 },	/* IDSEL 16 - PCI slot 4 */
+#else
+		{ 18, 21, 20, 19 },	/* IDSEL 13 - PCI slot 1 */
+		{ 19, 18, 21, 20 },	/* IDSEL 14 - PCI slot 2 */
+		{ 20, 19, 18, 21 },	/* IDSEL 15 - PCI slot 3 */
+		{ 21, 20, 19, 18 },	/* IDSEL 16 - PCI slot 4 */
+#endif
+#else
 		{ 16, 19, 18, 17 },	/* IDSEL 13 - PCI slot 1 */
 		{ 17, 16, 19, 18 },	/* IDSEL 14 - PCI slot 2 */
 		{ 18, 17, 16, 19 },	/* IDSEL 15 - PCI slot 3 */
 		{ 19, 18, 17, 16 },	/* IDSEL 16 - PCI slot 4 */
+#endif
 	};

 	const long min_idsel = 11, max_idsel = 16, irqs_per_slot = 4;
diff -Naru linux-hhl20/arch/ppc/kernel/sandpoint_setup.c hhl-sandpointx3/arch/ppc/kernel/sandpoint_setup.c
--- linux-hhl20/arch/ppc/kernel/sandpoint_setup.c	Thu Mar 29 21:41:29 2001
+++ hhl-sandpointx3/arch/ppc/kernel/sandpoint_setup.c	Wed Jul 25 15:30:19 2001
@@ -36,6 +36,25 @@
  * 	S5: up
  * 	S6: down
  *
+ * Up/Down are obviously relative to the way the board is installed in
+ * your system :-).  "Down" is toward the PPMC module (which is actually
+ * "up" in my system). -- Dan
+ *
+ * Since Motorola listened to our suggestions for improvement, we now have
+ * the Sandpoint X3 board.  All of the PCI slots are available, it uses
+ * the serial interrupt interface (just a hardware thing we need to
+ * configure properly).
+ *
+ * Use the default X3 switch settings.  The interrupts are then:
+ *		EPIC	Source
+ *		  0	SIOINT 		(8259, active low)
+ *		  1	PCI #1
+ *		  2	PCI #2
+ *		  3	PCI #3
+ *		  4	PCI #4
+ *		  7	Winbond INTC	(IDE interrupt)
+ *		  8	Winbond INTD	(IDE interrupt)
+ *
  * *** IMPORTANT ***
  *
  * This port will not work properly as is.  You must apply the following patch:
@@ -120,11 +139,25 @@
 	0,	/* 13 */
 	0,	/* 14 */
 	0,	/* 15 */
+#ifdef CONFIG_SANDPOINT_X3
+	1,	/* 16: EPIC IRQ 0: Active Low -- SIOINT (8259) */
+ 0, /* AACK!  Shouldn't need this.....see sandpoint_pci.c for more info */
+	1,	/* 17: EPIC IRQ 1: Active Low -- PCI Slot 1 */
+	1,	/* 18: EPIC IRQ 2: Active Low -- PCI Slot 2 */
+	1,	/* 19: EPIC IRQ 3: Active Low -- PCI Slot 3 */
+	1,	/* 20: EPIC IRQ 4: Active Low -- PCI Slot 4 */
+	0,	/* 21 -- Unused */
+	0,	/* 22 -- Unused */
+	1,	/* 23 -- IDE (Winbond INT C)  */
+	1,	/* 24 -- IDE (Winbond INT D)  */
+		/* 35 - 31 (EPIC 9 - 15) Unused */
+#else
 	1,	/* 16: EPIC IRQ 0: Active Low -- PCI intrs */
 	1,	/* 17: EPIC IRQ 1: Active Low -- PCI (possibly 8259) intrs */
 	1,	/* 18: EPIC IRQ 2: Active Low -- PCI (possibly 8259) intrs  */
 	1	/* 19: EPIC IRQ 3: Active Low -- PCI intrs */
 		/* 20: EPIC IRQ 4: Not used */
+#endif
 };

 static void __init
@@ -242,6 +275,9 @@
  * Slot numbering is confusing.  Sometimes in the documentation they
  * use 0,1,2,3 and others 1,2,3,4.  We will use slots 1,2,3,4 and
  * map this to IRQ 16, 17, 18, 19.
+ * For Sandpoint X3, this has been better designed.  The 8259 is
+ * cascaded from EPIC IRQ0, IRQ1-4 map to PCI slots 1-4, IDE is on
+ * EPIC 7 and 8.
  */
 static void __init
 sandpoint_init_IRQ(void)
@@ -444,9 +480,9 @@
 	        sandpoint_ide_probe();

 	if (base == sandpoint_ide_regbase[0])
-		return 14;
+		return SANDPOINT_IDE_INT0;
 	else if (base == sandpoint_ide_regbase[1])
-		return 15;
+		return SANDPOINT_IDE_INT1;
 	else
 		return 0;
 }
@@ -504,11 +540,11 @@

 	if (data_port == sandpoint_ide_regbase[0]) {
 		alt_status_base = sandpoint_ide_ctl_regbase[0] + 2;
-		hw->irq = 14;
+		hw->irq = SANDPOINT_IDE_INT0;
 	}
 	else if (data_port == sandpoint_ide_regbase[1]) {
 		alt_status_base = sandpoint_ide_ctl_regbase[1] + 2;
-		hw->irq = 15;
+		hw->irq = SANDPOINT_IDE_INT1;
 	}
 	else {
 		alt_status_base = 0;
diff -Naru linux-hhl20/arch/ppc/kernel/setup.c hhl-sandpointx3/arch/ppc/kernel/setup.c
--- linux-hhl20/arch/ppc/kernel/setup.c	Wed May 23 15:46:03 2001
+++ hhl-sandpointx3/arch/ppc/kernel/setup.c	Wed Jul 25 15:30:19 2001
@@ -434,6 +434,9 @@
 		case 0x0081:
 			len += sprintf(len+buffer, "82xx\n");
 			break;
+		case 0x8081:
+			len += sprintf(len+buffer, "8245\n");
+			break;
 		case 0x4011:
 			len += sprintf(len+buffer, "405GP\n");
 			break;
diff -Naru linux-hhl20/include/asm-ppc/processor.h hhl-sandpointx3/include/asm-ppc/processor.h
--- linux-hhl20/include/asm-ppc/processor.h	Wed May 23 15:46:09 2001
+++ hhl-sandpointx3/include/asm-ppc/processor.h	Wed Jul 25 15:32:58 2001
@@ -469,6 +469,7 @@
 #define	PVR_860		PVR_821
 #define	PVR_7400       	0x000C0000
 #define	PVR_8240	0x00810100
+#define	PVR_8245	0x80810100
 #define	PVR_8260	PVR_8240



--------------5EF9E8D050C5C996102048BB--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
