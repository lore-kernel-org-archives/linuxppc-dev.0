Subject: [PATCH][RFC] OCP support for MPC107 and relatives
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: multipart/mixed; boundary="=-kvgBgN6jUz94RTg6XB7z"
Message-Id: <1087207803.7360.83.camel@newt>
Mime-Version: 1.0
Date: Mon, 14 Jun 2004 11:10:04 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-kvgBgN6jUz94RTg6XB7z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch is a start at adding the internal peripherals of the
MPC107/MPC8240/MPC8245 to the OCP bus. I've used thus in the 2.6 port of
my MPC107 I2C driver, which follows shortly. I intend to use this for
the DMA controller later, once I decide what device ID to give it.

I'm a little uncertain about OCP device IDs. Should there be a separate
I2C device ID for each different I2C programming interface from the same
vendor? Motorola have already given us two separate implementations on
PowerPC.

This is a little bit different from the PPC40x use of OCP, because it's
hard to calculate everything at compile time. This is particularly
caused by the pcore boards, which use the MPC107 but don't use the
interrupt controller.

I've compiled for pcore, lopec, sandpoint, and an in-house board without
errors. PowerPMC250 was broken before, and I have probably not repaired
it.

Any comments? (I'm away from email midweek, so I may not answer until
Friday.)

- Adrian Cox
Humboldt Solutions Ltd.


--=-kvgBgN6jUz94RTg6XB7z
Content-Description: 
Content-Disposition: inline; filename=ocp.patch
Content-Type: text/x-patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/14 10:15:20+01:00 adrian@humboldt.co.uk
#   Add OCP support for MPC10x peripherals, and tidy up OpenPic initialisation.
#
# include/asm-ppc/mpc10x.h
#   2004/06/14 10:14:53+01:00 adrian@humboldt.co.uk +3 -0
#   Add a new MPC10x OpenPIC setup function
#
# arch/ppc/syslib/mpc10x_common.c
#   2004/06/14 10:14:53+01:00 adrian@humboldt.co.uk +50 -3
#   Setup core_ocp structure based on the calls into the MPC10x setup routines.
#
# arch/ppc/syslib/Makefile
#   2004/06/14 10:14:53+01:00 adrian@humboldt.co.uk +4 -4
#   Use new config entry for the MPC10x internal OpenPIC.
#
# arch/ppc/platforms/sandpoint.c
#   2004/06/14 10:14:53+01:00 adrian@humboldt.co.uk +1 -11
#   Use new standardised mpc10x_set_openpic().
#
# arch/ppc/platforms/powerpmc250.c
#   2004/06/14 10:14:53+01:00 adrian@humboldt.co.uk +1 -1
#   Use new standardised mpc10x_set_openpic().
#
# arch/ppc/platforms/lopec_setup.c
#   2004/06/14 10:14:53+01:00 adrian@humboldt.co.uk +1 -14
#   Use new standardised mpc10x_set_openpic().
#
# arch/ppc/Kconfig
#   2004/06/14 10:14:53+01:00 adrian@humboldt.co.uk +6 -1
#   Add OCP support to MPC10x/EPIC combination.
#
diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	Mon Jun 14 10:18:30 2004
+++ b/arch/ppc/Kconfig	Mon Jun 14 10:18:30 2004
@@ -656,6 +656,11 @@
 	depends on PCORE || POWERPMC250 || LOPEC || SANDPOINT
 	default y

+config MPC10X_OPENPIC
+	bool
+	depends on POWERPMC250 || LOPEC || SANDPOINT
+	default y
+
 config MPC10X_STORE_GATHERING
 	bool "Enable MPC10x store gathering"
 	depends on MPC10X_BRIDGE
@@ -1279,7 +1284,7 @@

 config PPC_OCP
 	bool
-	depends on IBM_OCP
+	depends on IBM_OCP || MPC10X_BRIDGE
 	default y

 endmenu
diff -Nru a/arch/ppc/platforms/lopec_setup.c b/arch/ppc/platforms/lopec_setup.c
--- a/arch/ppc/platforms/lopec_setup.c	Mon Jun 14 10:18:30 2004
+++ b/arch/ppc/platforms/lopec_setup.c	Mon Jun 14 10:18:30 2004
@@ -193,21 +193,8 @@
 	OpenPIC_InitSenses = lopec_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof(lopec_openpic_initsenses);

-	/*
-	 * We need to tell openpic_set_sources where things actually are.
-	 * mpc10x_common will setup OpenPIC_Addr at ioremap(EUMB phys base +
-	 * EPIC offset (0x40000));  The EPIC IRQ Register Address Map -
-	 * Interrupt Source Configuration Registers gives these numbers
-	 * as offsets starting at 0x50200, we need to adjust occordinly.
-	 */
-	/* Map serial interrupts 0-15 */
-	openpic_set_sources(0, 16, OpenPIC_Addr + 0x10200);
-	/* Skip reserved space and map i2c and DMA Ch[01] */
-	openpic_set_sources(16, 3, OpenPIC_Addr + 0x11020);
-	/* Skip reserved space and map Message Unit Interrupt (I2O) */
-	openpic_set_sources(19, 1, OpenPIC_Addr + 0x110C0);
+	mpc10x_set_openpic();

-	openpic_init(NUM_8259_INTERRUPTS);
 	/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
 	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
 			&i8259_irq);
diff -Nru a/arch/ppc/platforms/powerpmc250.c b/arch/ppc/platforms/powerpmc250.c
--- a/arch/ppc/platforms/powerpmc250.c	Mon Jun 14 10:18:30 2004
+++ b/arch/ppc/platforms/powerpmc250.c	Mon Jun 14 10:18:30 2004
@@ -197,7 +197,7 @@

 	OpenPIC_InitSenses = powerpmc250_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof(powerpmc250_openpic_initsenses);
-	openpic_init(1, 0, 0, -1);
+	mpc10x_set_openpic();
 }

 /*
diff -Nru a/arch/ppc/platforms/sandpoint.c b/arch/ppc/platforms/sandpoint.c
--- a/arch/ppc/platforms/sandpoint.c	Mon Jun 14 10:18:30 2004
+++ b/arch/ppc/platforms/sandpoint.c	Mon Jun 14 10:18:30 2004
@@ -433,17 +433,7 @@
 	OpenPIC_InitSenses = sandpoint_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof(sandpoint_openpic_initsenses);

-	/*
-	 * We need to tell openpic_set_sources where things actually are.
-	 * mpc10x_common will setup OpenPIC_Addr at ioremap(EUMB phys base +
-	 * EPIC offset (0x40000));  The EPIC IRQ Register Address Map -
-	 * Interrupt Source Configuration Registers gives these numbers
-	 * as offsets starting at 0x50200, we need to adjust occordinly.
-	 */
-	/* Map serial interrupts 0-15 */
-	openpic_set_sources(0, 16, OpenPIC_Addr + 0x10200);
-
-	openpic_init(NUM_8259_INTERRUPTS);
+	mpc10x_set_openpic();
 	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
 			i8259_irq);

diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	Mon Jun 14 10:18:30 2004
+++ b/arch/ppc/syslib/Makefile	Mon Jun 14 10:18:30 2004
@@ -45,7 +45,7 @@
 obj-$(CONFIG_GEMINI)		+= open_pic.o indirect_pci.o
 obj-$(CONFIG_K2)		+= i8259.o indirect_pci.o todc_time.o \
 					pci_auto.o
-obj-$(CONFIG_LOPEC)		+= pci_auto.o open_pic.o i8259.o todc_time.o
+obj-$(CONFIG_LOPEC)		+= i8259.o pci_auto.o todc_time.o
 obj-$(CONFIG_MCPN765)		+= todc_time.o indirect_pci.o pci_auto.o \
 					open_pic.o i8259.o hawk_common.o
 obj-$(CONFIG_MENF1)		+= todc_time.o i8259.o mpc10x_common.o \
@@ -55,15 +55,14 @@
 obj-$(CONFIG_OCOTEA)		+= indirect_pci.o pci_auto.o todc_time.o
 obj-$(CONFIG_PAL4)		+= cpc700_pic.o
 obj-$(CONFIG_PCORE)		+= todc_time.o i8259.o pci_auto.o
-obj-$(CONFIG_POWERPMC250)	+= open_pic.o pci_auto.o
+obj-$(CONFIG_POWERPMC250)	+= pci_auto.o
 obj-$(CONFIG_PPLUS)		+= hawk_common.o open_pic.o i8259.o \
 				   indirect_pci.o todc_time.o pci_auto.o
 obj-$(CONFIG_PRPMC750)		+= open_pic.o indirect_pci.o pci_auto.o \
 					hawk_common.o
 obj-$(CONFIG_HARRIER)		+= harrier.o
 obj-$(CONFIG_PRPMC800)		+= open_pic.o indirect_pci.o pci_auto.o
-obj-$(CONFIG_SANDPOINT)		+= i8259.o open_pic.o pci_auto.o todc_time.o
-obj-$(CONFIG_SA107)		+= i8259.o open_pic.o
+obj-$(CONFIG_SANDPOINT)		+= i8259.o pci_auto.o todc_time.o
 obj-$(CONFIG_SBC82xx)		+= todc_time.o
 obj-$(CONFIG_SPRUCE)		+= cpc700_pic.o indirect_pci.o pci_auto.o \
 				   todc_time.o
@@ -74,5 +73,6 @@
 endif
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_MPC10X_BRIDGE)     += mpc10x_common.o indirect_pci.o
+obj-$(CONFIG_MPC10X_OPENPIC)	+= open_pic.o
 obj-$(CONFIG_40x)		+= dcr.o
 obj-$(CONFIG_BOOKE)		+= dcr.o
diff -Nru a/arch/ppc/syslib/mpc10x_common.c b/arch/ppc/syslib/mpc10x_common.c
--- a/arch/ppc/syslib/mpc10x_common.c	Mon Jun 14 10:18:30 2004
+++ b/arch/ppc/syslib/mpc10x_common.c	Mon Jun 14 10:18:30 2004
@@ -30,7 +30,25 @@
 #include <asm/pci-bridge.h>
 #include <asm/open_pic.h>
 #include <asm/mpc10x.h>
+#include <asm/ocp.h>

+/* The OCP structure is fixed by code below, before OCP initialises.
+   paddr depends on where the board places the EUMB.
+    - fixed in mpc10x_bridge_init().
+   irq depends on two things:
+    > does the board use the EPIC at all? (PCORE does not).
+    > is the EPIC in serial or parallel mode?
+    - fixed in mpc10x_set_openpic().
+*/
+struct ocp_def core_ocp[] = {
+	{ .vendor	= OCP_VENDOR_MOTOROLA,
+	  .function	= OCP_FUNC_IIC,
+	  .index	= 0,
+	  .irq		= OCP_IRQ_NA
+	},
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
+};

 /* Set resources to match bridge memory map */
 void __init
@@ -213,7 +231,10 @@
 					byte);
 	}

-	if (host_bridge != MPC10X_BRIDGE_106) {
+	if (host_bridge == MPC10X_BRIDGE_106) {
+		/* On-chip peripherals were introduced with the MPC107/MPC8240 */
+		core_ocp[0].vendor = OCP_VENDOR_INVALID;
+	} else {
 		early_read_config_byte(hose,
 				       0,
 				       PCI_DEVFN(0,0),
@@ -231,11 +252,14 @@
 					 PCI_DEVFN(0,0),
 					 MPC10X_CFG_EUMBBAR,
 					 phys_eumb_base);
-
-		/* Map EPIC register part of EUMB into vitual memory */
+#ifdef CONFIG_MPC10X_OPENPIC
+		/* Map EPIC register part of EUMB into vitual memory  - PCORE
+		   uses an i8259 instead of EPIC. */
 		OpenPIC_Addr =
 			ioremap(phys_eumb_base + MPC10X_EUMB_EPIC_OFFSET,
 				MPC10X_EUMB_EPIC_SIZE);
+#endif
+		core_ocp[0].paddr = phys_eumb_base + MPC10X_EUMB_I2C_OFFSET;
 	}

 #ifdef CONFIG_MPC10X_STORE_GATHERING
@@ -397,3 +421,26 @@

 	return 0;
 }
+
+#ifdef CONFIG_MPC10X_OPENPIC
+void __init mpc10x_set_openpic(void)
+{
+#ifdef CONFIG_EPIC_SERIAL_MODE
+#define EPIC_IRQ_BASE 16
+	/* Map 16 serial IRQs */
+	openpic_set_sources(0, 16, OpenPIC_Addr + 0x10200);
+#else
+#define EPIC_IRQ_BASE 5
+	/* Map EPIC IRQs 0-4 */
+	openpic_set_sources(0, 5, OpenPIC_Addr + 0x10200);
+#endif
+	/* Skip reserved space and map i2c and DMA Ch[01] */
+	openpic_set_sources(EPIC_IRQ_BASE, 3, OpenPIC_Addr + 0x11020);
+	/* Skip reserved space and map Message Unit Interrupt (I2O) */
+	openpic_set_sources(EPIC_IRQ_BASE + 3, 1, OpenPIC_Addr + 0x110C0);
+
+	core_ocp[0].irq = NUM_8259_INTERRUPTS + EPIC_IRQ_BASE;
+
+	openpic_init(NUM_8259_INTERRUPTS);
+}
+#endif
diff -Nru a/include/asm-ppc/mpc10x.h b/include/asm-ppc/mpc10x.h
--- a/include/asm-ppc/mpc10x.h	Mon Jun 14 10:18:30 2004
+++ b/include/asm-ppc/mpc10x.h	Mon Jun 14 10:18:30 2004
@@ -164,4 +164,7 @@
 int mpc10x_enable_store_gathering(struct pci_controller *hose);
 int mpc10x_disable_store_gathering(struct pci_controller *hose);

+/* For MPC107 boards that use the built-in openpic */
+void mpc10x_set_openpic(void);
+
 #endif	/* __PPC_KERNEL_MPC10X_H */

--=-kvgBgN6jUz94RTg6XB7z--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
