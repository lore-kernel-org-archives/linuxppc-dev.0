Subject: [RFC] Test patch for Sandpoint X2
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Cc: mcclintock@freescale.com, mgreer@mvista.com
Content-Type: multipart/mixed; boundary="=-8erkP9KrkM1I5BEszs6f"
Message-Id: <1092926140.10314.101.camel@localhost>
Mime-Version: 1.0
Date: Thu, 19 Aug 2004 15:35:40 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-8erkP9KrkM1I5BEszs6f
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch puts support for Sandpoint X2 back into Linux 2.6.
Unlike my previous attempts, this patch detects the Sandpoint model at
runtime. I only have an X2 here, so I would appreciate reports of the
code being unbroken on the X3.

The patch causes EPIC_SERIAL_MODE to be a runtime rather than compile
time decision. It also changes the UART interrupts from level to edge,
which on my X2 is required in order to work with the serial driver in
2.6. I'd also like to know if this breaks the X3.

Any comments?

- Adrian Cox
Humboldt Solutions Ltd.



--=-8erkP9KrkM1I5BEszs6f
Content-Description: 
Content-Disposition: inline; filename=sandpoint-1.patch
Content-Type: text/x-patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/19 15:19:26+01:00 adrian@humboldt.co.uk
#   Reintroduce Sandpoint X2 support.
#   This is detected by a check early in booting, and requires the EPIC
#   serial mode to be set at run-time, rather than compile time.
#
# include/asm-ppc/open_pic.h
#   2004/08/19 15:15:03+01:00 adrian@humboldt.co.uk +4 -0
#   EPIC_SERIAL_MODE can now be detected at runtime.
#
# arch/ppc/syslib/open_pic.c
#   2004/08/19 15:15:03+01:00 adrian@humboldt.co.uk +7 -2
#   EPIC_SERIAL_MODE can now be detected at runtime.
#
# arch/ppc/syslib/mpc10x_common.c
#   2004/08/19 15:15:03+01:00 adrian@humboldt.co.uk +6 -7
#   EPIC_SERIAL_MODE can now be detected at runtime.
#
# arch/ppc/platforms/sandpoint.c
#   2004/08/19 15:15:03+01:00 adrian@humboldt.co.uk +86 -10
#   Introduce test for the Sandpoint X2 model.
#
diff -Nru a/arch/ppc/platforms/sandpoint.c b/arch/ppc/platforms/sandpoint.c
--- a/arch/ppc/platforms/sandpoint.c	Thu Aug 19 15:23:39 2004
+++ b/arch/ppc/platforms/sandpoint.c	Thu Aug 19 15:23:39 2004
@@ -60,11 +60,6 @@
  * of the amount of memory in the system.  Once a method of determining
  * what version of DINK initializes the system for us, if applicable, is
  * found, we can hopefully stop hardcoding 32MB of RAM.
- *
- * It is important to note that this code only supports the Sandpoint X3
- * (all flavors) platform, and it does not support the X2 anymore.  Code
- * that at one time worked on the X2 can be found at:
- * ftp://source.mvista.com/pub/linuxppc/obsolete/sandpoint/
  */

 #include <linux/config.h>
@@ -107,9 +102,13 @@

 #include "sandpoint.h"

+/* Set non-zero if an X2 Sandpoint detected. */
+static int sandpoint_is_x2;
+
 unsigned char __res[sizeof(bd_t)];

 static void sandpoint_halt(void);
+static void sandpoint_probe_type(void);

 /*
  * Define all of the IRQ senses and polarities.  Taken from the
@@ -129,7 +128,7 @@
  * Motorola SPS Sandpoint interrupt routing.
  */
 static inline int
-sandpoint_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+x3_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
 {
 	static char pci_irq_table[][4] =
 	/*
@@ -149,6 +148,27 @@
 	return PCI_IRQ_TABLE_LOOKUP;
 }

+static inline int
+x2_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	/*
+	 *	PCI IDSEL/INTPIN->INTLINE
+	 * 	   A   B   C   D
+	 */
+	{
+		{ 18,  0,  0,  0 },	/* IDSEL 11 - i8259 on Windbond */
+		{  0,  0,  0,  0 },	/* IDSEL 12 - unused */
+		{ 16, 17, 18, 19 },	/* IDSEL 13 - PCI slot 1 */
+		{ 17, 18, 19, 16 },	/* IDSEL 14 - PCI slot 2 */
+		{ 18, 19, 16, 17 },	/* IDSEL 15 - PCI slot 3 */
+		{ 19, 16, 17, 18 },	/* IDSEL 16 - PCI slot 4 */
+	};
+
+	const long min_idsel = 11, max_idsel = 16, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+}
+
 static void __init
 sandpoint_setup_winbond_83553(struct pci_controller *hose)
 {
@@ -216,6 +236,18 @@
 	return;
 }

+/* On the sandpoint X2, we must avoid sending configuration cycles to
+ * device #12 (IDSEL addr = AD12).
+ */
+static int
+x2_exclude_device(u_char bus, u_char devfn)
+{
+	if ((bus == 0) && (PCI_SLOT(devfn) == SANDPOINT_HOST_BRIDGE_IDSEL))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		return PCIBIOS_SUCCESSFUL;
+}
+
 static void __init
 sandpoint_find_bridges(void)
 {
@@ -241,7 +273,11 @@
 		ppc_md.pcibios_fixup = NULL;
 		ppc_md.pcibios_fixup_bus = NULL;
 		ppc_md.pci_swizzle = common_swizzle;
-		ppc_md.pci_map_irq = sandpoint_map_irq;
+		if (sandpoint_is_x2) {
+			ppc_md.pci_map_irq = x2_map_irq;
+			ppc_md.pci_exclude_device = x2_exclude_device;
+		} else
+			ppc_md.pci_map_irq = x3_map_irq;
 	}
 	else {
 		if (ppc_md.progress)
@@ -287,6 +323,11 @@
 static void __init
 sandpoint_setup_arch(void)
 {
+	/* Probe for Sandpoint model */
+	sandpoint_probe_type();
+	if (sandpoint_is_x2)
+		epic_serial_mode = 0;
+
 	loops_per_jiffy = 100000000 / HZ;

 #ifdef CONFIG_BLK_DEV_INITRD
@@ -355,13 +396,48 @@
 }

 /*
+ * To probe the Sandpoint type, we need to check for a connection between GPIO
+ * pins 6 and 7 on the NS87308 SuperIO.
+ */
+static void __init sandpoint_probe_type(void)
+{
+	u8 x;
+	/* First, ensure that the GPIO pins are enabled. */
+	SANDPOINT_87308_SELECT_DEV(0x07); /* Select GPIO logical device */
+	SANDPOINT_87308_CFG_OUTB(0x60, 0x07); /* Base address 0x700 */
+	SANDPOINT_87308_CFG_OUTB(0x61, 0x00);
+	SANDPOINT_87308_CFG_OUTB(0x30, 0x01); /* Enable */
+
+	/* Now, set pin 7 to output and pin 6 to input. */
+	outb((inb(0x701) | 0x80) & 0xbf, 0x701);
+	/* Set push-pull output */
+	outb(inb(0x702) | 0x80, 0x702);
+	/* Set pull-up on input */
+	outb(inb(0x703) | 0x40, 0x703);
+	/* Set output high and check */
+	x = inb(0x700);
+	outb(x | 0x80, 0x700);
+	x = inb(0x700);
+	sandpoint_is_x2 = ! (x & 0x40);
+	if (ppc_md.progress && sandpoint_is_x2)
+		ppc_md.progress("High output says X2", 0);
+	/* Set output low and check */
+	outb(x & 0x7f, 0x700);
+	sandpoint_is_x2 |= inb(0x700) & 0x40;
+	if (ppc_md.progress && sandpoint_is_x2)
+		ppc_md.progress("Low output says X2", 0);
+	if (ppc_md.progress && ! sandpoint_is_x2)
+		ppc_md.progress("Sandpoint is X3", 0);
+}
+
+/*
  * Fix IDE interrupts.
  */
 static int __init
 sandpoint_fix_winbond_83553(void)
 {
-	/* Make all 8259 interrupt level sensitive */
-	outb(0xf8, 0x4d0);
+	/* Make some 8259 interrupt level sensitive */
+	outb(0xe0, 0x4d0);
 	outb(0xde, 0x4d1);

 	return 0;
@@ -434,7 +510,7 @@
 	OpenPIC_NumInitSenses = sizeof(sandpoint_openpic_initsenses);

 	mpc10x_set_openpic();
-	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
+	openpic_hookup_cascade(sandpoint_is_x2 ? 17 : NUM_8259_INTERRUPTS, "82c59 cascade",
 			i8259_irq);

 	/*
diff -Nru a/arch/ppc/syslib/mpc10x_common.c b/arch/ppc/syslib/mpc10x_common.c
--- a/arch/ppc/syslib/mpc10x_common.c	Thu Aug 19 15:23:39 2004
+++ b/arch/ppc/syslib/mpc10x_common.c	Thu Aug 19 15:23:39 2004
@@ -43,7 +43,7 @@

 #ifdef CONFIG_MPC10X_OPENPIC
 #ifdef CONFIG_EPIC_SERIAL_MODE
-#define EPIC_IRQ_BASE 16
+#define EPIC_IRQ_BASE (epic_serial_mode ? 16 : 5)
 #else
 #define EPIC_IRQ_BASE 5
 #endif
@@ -69,20 +69,16 @@
 	.vendor		= OCP_VENDOR_MOTOROLA,
 	.function	= OCP_FUNC_IIC,
 	.index		= 0,
-	.irq		= MPC10X_I2C_IRQ,
 	.additions	= &mpc10x_i2c_data
 };

 static struct ocp_def mpc10x_dma_ocp[2] = {
 {	.vendor		= OCP_VENDOR_MOTOROLA,
 	.function	= OCP_FUNC_DMA,
-	.index		= 0,
-	.irq		= MPC10X_DMA0_IRQ
-},
+	.index		= 0 },
 {	.vendor		= OCP_VENDOR_MOTOROLA,
 	.function	= OCP_FUNC_DMA,
-	.index		= 1,
-	.irq		= MPC10X_DMA1_IRQ }
+	.index		= 1 }
 };

 /* Set resources to match bridge memory map */
@@ -292,12 +288,15 @@
 				MPC10X_EUMB_EPIC_SIZE);
 #endif
 		mpc10x_i2c_ocp.paddr = phys_eumb_base + MPC10X_EUMB_I2C_OFFSET;
+		mpc10x_i2c_ocp.irq = MPC10X_I2C_IRQ;
 		ocp_add_one_device(&mpc10x_i2c_ocp);
 		mpc10x_dma_ocp[0].paddr = phys_eumb_base +
 					MPC10X_EUMB_DMA_OFFSET + 0x100;
+		mpc10x_dma_ocp[0].irq = MPC10X_DMA0_IRQ;
 		ocp_add_one_device(&mpc10x_dma_ocp[0]);
 		mpc10x_dma_ocp[1].paddr = phys_eumb_base +
 					MPC10X_EUMB_DMA_OFFSET + 0x200;
+		mpc10x_dma_ocp[1].irq = MPC10X_DMA1_IRQ;
 		ocp_add_one_device(&mpc10x_dma_ocp[1]);
 	}

diff -Nru a/arch/ppc/syslib/open_pic.c b/arch/ppc/syslib/open_pic.c
--- a/arch/ppc/syslib/open_pic.c	Thu Aug 19 15:23:39 2004
+++ b/arch/ppc/syslib/open_pic.c	Thu Aug 19 15:23:39 2004
@@ -261,6 +261,9 @@
 #endif /* CONFIG_SMP */

 #ifdef CONFIG_EPIC_SERIAL_MODE
+/* On platforms that may use EPIC serial mode, the default is enabled. */
+int epic_serial_mode = 1;
+
 static void __init openpic_eicr_set_clk(u_int clkval)
 {
 	openpic_writefield(&OpenPIC->Global.Global_Configuration1,
@@ -415,8 +418,10 @@
 	openpic_set_spurious(OPENPIC_VEC_SPURIOUS+offset);
 	openpic_disable_8259_pass_through();
 #ifdef CONFIG_EPIC_SERIAL_MODE
-	openpic_eicr_set_clk(7);	/* Slowest value until we know better */
-	openpic_enable_sie();
+	if (epic_serial_mode) {
+		openpic_eicr_set_clk(7);	/* Slowest value until we know better */
+		openpic_enable_sie();
+	}
 #endif
 	openpic_set_priority(0);

diff -Nru a/include/asm-ppc/open_pic.h b/include/asm-ppc/open_pic.h
--- a/include/asm-ppc/open_pic.h	Thu Aug 19 15:23:39 2004
+++ b/include/asm-ppc/open_pic.h	Thu Aug 19 15:23:39 2004
@@ -37,6 +37,10 @@
 extern u_char *OpenPIC_InitSenses;
 extern void* OpenPIC_Addr;

+#ifdef CONFIG_EPIC_SERIAL_MODE
+extern int epic_serial_mode;
+#endif
+
 /* Exported functions */
 extern void openpic_set_sources(int first_irq, int num_irqs, void *isr);
 extern void openpic_init(int linux_irq_offset);

--=-8erkP9KrkM1I5BEszs6f--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
