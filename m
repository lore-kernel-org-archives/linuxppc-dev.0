Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E587DDED9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 15:03:34 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l7H53TsN020486
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 00:03:29 -0500
Date: Fri, 17 Aug 2007 00:03:48 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Fix interrupt routing and setup of ULI M1575 on
	FSL boards
Message-ID: <Pine.LNX.4.64.0708170003210.21006@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The interrupt routing in the device trees for the ULI M1575 was
inproperly using the interrupt line field as pci function.  Fixed
up the device tree's to actual conform for to specification and
changed the interrupt mapping code so it just uses a static mapping
setup as follows:

PIRQA - IRQ9
PIRQB - IRQ10
PIRQC - IRQ11
PIRQD - IRQ12
USB 1.1 OCHI (1c.0) - IRQ12
USB 1.1 OCHI (1c.1) - IRQ9
USB 1.1 OCHI (1c.2) - IRQ10
USB 1.1 ECHI (1c.3) - IRQ11
LAN (1b.0) - IRQ6
AC97 (1d.0) - IRQ6
Modem (1d.1) - IRQ6
HD Audio (1d.2) - IRQ6
SATA (1f.1) - IRQ5
SMB (1e.1) - IRQ7
PMU (1e.2) - IRQ7
PATA (1f.0) - IRQ14/15

Took the oppurtunity to refactor the code into a single file so we
don't have to duplicate these fixes on the two current boards in the
tree and several forth coming boards that will also need the code.

Fixed RTC support that requires a dummy memory read on the P2P bridge
to unlock the RTC and setup the default of the RTC alarm registers to
match with a basic x86 style CMOS RTC.

Moved code that poked ISA registers to a FIXUP_FINAL quirk to ensure
the PCI IO space has been setup properly before we start poking ISA
registers at random locations.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8544ds.dts        |   88 ++++------
 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |  114 +++----------
 arch/powerpc/platforms/85xx/Kconfig        |    1 +
 arch/powerpc/platforms/85xx/mpc8544_ds.c   |  214 ++----------------------
 arch/powerpc/platforms/86xx/Kconfig        |    1 +
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |  224 ++-----------------------
 arch/powerpc/platforms/Kconfig             |    8 +
 arch/powerpc/platforms/Makefile            |    3 +
 arch/powerpc/platforms/fsl_uli1575.c       |  255 ++++++++++++++++++++++++++++
 9 files changed, 363 insertions(+), 545 deletions(-)
 create mode 100644 arch/powerpc/platforms/fsl_uli1575.c

diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 4680e20..3e79bf0 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -44,8 +44,18 @@
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
 		device_type = "soc";
-		ranges = <0 e0000000 00100000>;
-		reg = <e0000000 00100000>;	// CCSRBAR 1M
+
+
+		ranges = <00001000 e0001000 000ff000
+			  80000000 80000000 20000000
+			  a0000000 a0000000 10000000
+			  b0000000 b0000000 00100000
+			  c0000000 c0000000 20000000
+			  b0100000 b0100000 00100000
+			  e1000000 e1000000 00010000
+			  e1010000 e1010000 00010000
+			  e1020000 e1020000 00010000>;
+		reg = <e0000000 00001000>;	// CCSRBAR 1M
 		bus-frequency = <0>;		// Filled out by uboot.

 		memory-controller@2000 {
@@ -161,8 +171,8 @@
 			interrupt-parent = <&mpic>;
 			interrupts = <18 2>;
 			bus-range = <0 ff>;
-			ranges = <02000000 0 80000000 80000000 0 10000000
-				  01000000 0 00000000 e2000000 0 00800000>;
+			ranges = <02000000 0 c0000000 c0000000 0 20000000
+				  01000000 0 00000000 e1000000 0 00010000>;
 			clock-frequency = <3f940aa>;
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
@@ -178,8 +188,8 @@
 			#address-cells = <3>;
 			reg = <9000 1000>;
 			bus-range = <0 ff>;
-			ranges = <02000000 0 90000000 90000000 0 10000000
-				  01000000 0 00000000 e3000000 0 00800000>;
+			ranges = <02000000 0 80000000 80000000 0 20000000
+				  01000000 0 00000000 e1010000 0 00010000>;
 			clock-frequency = <1fca055>;
 			interrupt-parent = <&mpic>;
 			interrupts = <1a 2>;
@@ -202,7 +212,7 @@
 			reg = <a000 1000>;
 			bus-range = <0 ff>;
 			ranges = <02000000 0 a0000000 a0000000 0 10000000
-				  01000000 0 00000000 e2800000 0 00800000>;
+				  01000000 0 00000000 e1020000 0 00010000>;
 			clock-frequency = <1fca055>;
 			interrupt-parent = <&mpic>;
 			interrupts = <19 2>;
@@ -224,49 +234,29 @@
 			#address-cells = <3>;
 			reg = <b000 1000>;
 			bus-range = <0 ff>;
-			ranges = <02000000 0 b0000000 b0000000 0 10000000
-				  01000000 0 00000000 e3800000 0 00800000>;
+			ranges = <02000000 0 b0000000 b0000000 0 00100000
+				  01000000 0 00000000 b0100000 0 00100000>;
 			clock-frequency = <1fca055>;
 			interrupt-parent = <&mpic>;
 			interrupts = <1b 2>;
-			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map-mask = <fb00 0 0 0>;
 			interrupt-map = <
-
-				// IDSEL 0x1a
-				d000 0 0 1 &i8259 6 2
-				d000 0 0 2 &i8259 3 2
-				d000 0 0 3 &i8259 4 2
-				d000 0 0 4 &i8259 5 2
-
-				// IDSEL 0x1b
-				d800 0 0 1 &i8259 5 2
-				d800 0 0 2 &i8259 0 0
-				d800 0 0 3 &i8259 0 0
-				d800 0 0 4 &i8259 0 0
-
 				// IDSEL 0x1c  USB
-				e000 0 0 1 &i8259 9 2
-				e000 0 0 2 &i8259 a 2
-				e000 0 0 3 &i8259 c 2
-				e000 0 0 4 &i8259 7 2
+				e000 0 0 0 &i8259 c 2
+				e100 0 0 0 &i8259 9 2
+				e200 0 0 0 &i8259 a 2
+				e300 0 0 0 &i8259 b 2

 				// IDSEL 0x1d  Audio
-				e800 0 0 1 &i8259 9 2
-				e800 0 0 2 &i8259 a 2
-				e800 0 0 3 &i8259 b 2
-				e800 0 0 4 &i8259 0 0
+				e800 0 0 0 &i8259 6 2

 				// IDSEL 0x1e Legacy
-				f000 0 0 1 &i8259 c 2
-				f000 0 0 2 &i8259 0 0
-				f000 0 0 3 &i8259 0 0
-				f000 0 0 4 &i8259 0 0
+				f000 0 0 0 &i8259 7 2
+				f100 0 0 0 &i8259 7 2

 				// IDSEL 0x1f IDE/SATA
-				f800 0 0 1 &i8259 6 2
-				f800 0 0 2 &i8259 0 0
-				f800 0 0 3 &i8259 0 0
-				f800 0 0 4 &i8259 0 0
+				f800 0 0 0 &i8259 e 2
+				f900 0 0 0 &i8259 5 2
 			>;
 			uli1575@0 {
 				reg = <0 0 0 0 0>;
@@ -274,10 +264,10 @@
 				#address-cells = <3>;
 				ranges = <02000000 0 b0000000
 					  02000000 0 b0000000
-					  0 10000000
+					  0 00100000
 					  01000000 0 00000000
 					  01000000 0 00000000
-					  0 00080000>;
+					  0 00100000>;

 				pci_bridge@0 {
 					reg = <0 0 0 0 0>;
@@ -285,10 +275,10 @@
 					#address-cells = <3>;
 					ranges = <02000000 0 b0000000
 						  02000000 0 b0000000
-						  0 20000000
+						  0 00100000
 						  01000000 0 00000000
 						  01000000 0 00000000
-						  0 00100000>;
+						  0 00100000>;

 					isa@1e {
 						device_type = "isa";
@@ -296,7 +286,8 @@
 						#size-cells = <1>;
 						#address-cells = <2>;
 						reg = <f000 0 0 0 0>;
-						ranges = <1 0 01000000 0 0
+						ranges = <1 0
+							  01000000 0 0
 							  00001000>;
 						interrupt-parent = <&i8259>;

@@ -312,8 +303,7 @@
 							built-in;
 							compatible = "chrp,iic";
 							interrupts = <9 2>;
-							interrupt-parent =
-								<&mpic>;
+							interrupt-parent = <&mpic>;
 						};

 						i8042@60 {
@@ -321,8 +311,7 @@
 							#address-cells = <1>;
 							reg = <1 60 1 1 64 1>;
 							interrupts = <1 3 c 3>;
-							interrupt-parent =
-								<&i8259>;
+							interrupt-parent = <&i8259>;

 							keyboard@0 {
 								reg = <0>;
@@ -336,8 +325,7 @@
 						};

 						rtc@70 {
-							compatible =
-								"pnpPNP,b00";
+							compatible = "pnpPNP,b00";
 							reg = <1 70 2>;
 						};

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 5d82709..b0166e5 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -224,98 +224,36 @@
 			clock-frequency = <1fca055>;
 			interrupt-parent = <&mpic>;
 			interrupts = <18 2>;
-			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map-mask = <fb00 0 0 0>;
 			interrupt-map = <
 				/* IDSEL 0x11 */
-				8800 0 0 1 &i8259 3 2
-				8800 0 0 2 &i8259 4 2
-				8800 0 0 3 &i8259 5 2
-				8800 0 0 4 &i8259 6 2
+				8800 0 0 1 &i8259 9 2
+				8800 0 0 2 &i8259 a 2
+				8800 0 0 3 &i8259 b 2
+				8800 0 0 4 &i8259 c 2

 				/* IDSEL 0x12 */
-				9000 0 0 1 &i8259 4 2
-				9000 0 0 2 &i8259 5 2
-				9000 0 0 3 &i8259 6 2
-				9000 0 0 4 &i8259 3 2
-
-				/* IDSEL 0x13 */
-				9800 0 0 1 &i8259 0 0
-				9800 0 0 2 &i8259 0 0
-				9800 0 0 3 &i8259 0 0
-				9800 0 0 4 &i8259 0 0
-
-				/* IDSEL 0x14 */
-				a000 0 0 1 &i8259 0 0
-				a000 0 0 2 &i8259 0 0
-				a000 0 0 3 &i8259 0 0
-				a000 0 0 4 &i8259 0 0
-
-				/* IDSEL 0x15 */
-				a800 0 0 1 &i8259 0 0
-				a800 0 0 2 &i8259 0 0
-				a800 0 0 3 &i8259 0 0
-				a800 0 0 4 &i8259 0 0
-
-				/* IDSEL 0x16 */
-				b000 0 0 1 &i8259 0 0
-				b000 0 0 2 &i8259 0 0
-				b000 0 0 3 &i8259 0 0
-				b000 0 0 4 &i8259 0 0
-
-				/* IDSEL 0x17 */
-				b800 0 0 1 &i8259 0 0
-				b800 0 0 2 &i8259 0 0
-				b800 0 0 3 &i8259 0 0
-				b800 0 0 4 &i8259 0 0
-
-				/* IDSEL 0x18 */
-				c000 0 0 1 &i8259 0 0
-				c000 0 0 2 &i8259 0 0
-				c000 0 0 3 &i8259 0 0
-				c000 0 0 4 &i8259 0 0
-
-				/* IDSEL 0x19 */
-				c800 0 0 1 &i8259 0 0
-				c800 0 0 2 &i8259 0 0
-				c800 0 0 3 &i8259 0 0
-				c800 0 0 4 &i8259 0 0
-
-				/* IDSEL 0x1a */
-				d000 0 0 1 &i8259 6 2
-				d000 0 0 2 &i8259 3 2
-				d000 0 0 3 &i8259 4 2
-				d000 0 0 4 &i8259 5 2
-
-
-				/* IDSEL 0x1b */
-				d800 0 0 1 &i8259 5 2
-				d800 0 0 2 &i8259 0 0
-				d800 0 0 3 &i8259 0 0
-				d800 0 0 4 &i8259 0 0
-
-				/* IDSEL 0x1c */
-				e000 0 0 1 &i8259 9 2
-				e000 0 0 2 &i8259 a 2
-				e000 0 0 3 &i8259 c 2
-				e000 0 0 4 &i8259 7 2
-
-				/* IDSEL 0x1d */
-				e800 0 0 1 &i8259 9 2
-				e800 0 0 2 &i8259 a 2
-				e800 0 0 3 &i8259 b 2
-				e800 0 0 4 &i8259 0 0
-
-				/* IDSEL 0x1e */
-				f000 0 0 1 &i8259 c 2
-				f000 0 0 2 &i8259 0 0
-				f000 0 0 3 &i8259 0 0
-				f000 0 0 4 &i8259 0 0
-
-				/* IDSEL 0x1f */
-				f800 0 0 1 &i8259 6 2
-				f800 0 0 2 &i8259 0 0
-				f800 0 0 3 &i8259 0 0
-				f800 0 0 4 &i8259 0 0
+				9000 0 0 1 &i8259 a 2
+				9000 0 0 2 &i8259 b 2
+				9000 0 0 3 &i8259 c 2
+				9000 0 0 4 &i8259 9 2
+
+				// IDSEL 0x1c  USB
+				e000 0 0 0 &i8259 c 2
+				e100 0 0 0 &i8259 9 2
+				e200 0 0 0 &i8259 a 2
+				e300 0 0 0 &i8259 b 2
+
+				// IDSEL 0x1d  Audio
+				e800 0 0 0 &i8259 6 2
+
+				// IDSEL 0x1e Legacy
+				f000 0 0 0 &i8259 7 2
+				f100 0 0 0 &i8259 7 2
+
+				// IDSEL 0x1f IDE/SATA
+				f800 0 0 0 &i8259 e 2
+				f900 0 0 0 &i8259 5 2
 				>;
 			uli1575@0 {
 				reg = <0 0 0 0 0>;
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index f581840..f620171 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -33,6 +33,7 @@ config MPC8544_DS
 	bool "Freescale MPC8544 DS"
 	select PPC_I8259
 	select DEFAULT_UIMAGE
+	select FSL_ULI1575
 	help
 	  This option enables support for the MPC8544 DS board

diff --git a/arch/powerpc/platforms/85xx/mpc8544_ds.c b/arch/powerpc/platforms/85xx/mpc8544_ds.c
index 4905f6f..0f834d8 100644
--- a/arch/powerpc/platforms/85xx/mpc8544_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8544_ds.c
@@ -114,211 +114,25 @@ void __init mpc8544_ds_pic_init(void)
 }

 #ifdef CONFIG_PCI
-enum pirq { PIRQA = 8, PIRQB, PIRQC, PIRQD, PIRQE, PIRQF, PIRQG, PIRQH };
+extern int uses_fsl_uli_m1575;
+extern int uli_exclude_device(struct pci_controller *hose,
+				u_char bus, u_char devfn);

-/*
- * Value in  table -- IRQ number
- */
-const unsigned char uli1575_irq_route_table[16] = {
-	0,		/* 0: Reserved */
-	0x8,
-	0,		/* 2: Reserved */
-	0x2,
-	0x4,
-	0x5,
-	0x7,
-	0x6,
-	0,		/* 8: Reserved */
-	0x1,
-	0x3,
-	0x9,
-	0xb,
-	0,		/* 13: Reserved */
-	0xd,
-	0xf,
-};
-
-static int __devinit
-get_pci_irq_from_of(struct pci_controller *hose, int slot, int pin)
-{
-	struct of_irq oirq;
-	u32 laddr[3];
-	struct device_node *hosenode = hose ? hose->arch_data : NULL;
-
-	if (!hosenode)
-		return -EINVAL;
-
-	laddr[0] = (hose->first_busno << 16) | (PCI_DEVFN(slot, 0) << 8);
-	laddr[1] = laddr[2] = 0;
-	of_irq_map_raw(hosenode, &pin, 1, laddr, &oirq);
-	DBG("mpc8544_ds: pci irq addr %x, slot %d, pin %d, irq %d\n",
-	    laddr[0], slot, pin, oirq.specifier[0]);
-	return oirq.specifier[0];
-}
-
-/*8259*/
-static void __devinit quirk_uli1575(struct pci_dev *dev)
-{
-	unsigned short temp;
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	unsigned char irq2pin[16];
-	unsigned long pirq_map_word = 0;
-	u32 irq;
-	int i;
-
-	/*
-	 * ULI1575 interrupts route setup
-	 */
-	memset(irq2pin, 0, 16);	/* Initialize default value 0 */
-
-	irq2pin[6]=PIRQA+3;	/* enabled mapping for IRQ6 to PIRQD, used by SATA */
-
-	/*
-	 * PIRQE -> PIRQF mapping set manually
-	 *
-	 * IRQ pin   IRQ#
-	 * PIRQE ---- 9
-	 * PIRQF ---- 10
-	 * PIRQG ---- 11
-	 * PIRQH ---- 12
-	 */
-	for (i = 0; i < 4; i++)
-		irq2pin[i + 9] = PIRQE + i;
-
-	/* Set IRQ-PIRQ Mapping to ULI1575 */
-	for (i = 0; i < 16; i++)
-		if (irq2pin[i])
-			pirq_map_word |= (uli1575_irq_route_table[i] & 0xf)
-			    << ((irq2pin[i] - PIRQA) * 4);
-
-	pirq_map_word |= 1<<26;	/* disable INTx in EP mode*/
-
-	/* ULI1575 IRQ mapping conf register default value is 0xb9317542 */
-	DBG("Setup ULI1575 IRQ mapping configuration register value = 0x%x\n",
-		(int)pirq_map_word);
-	pci_write_config_dword(dev, 0x48, pirq_map_word);
-
-#define ULI1575_SET_DEV_IRQ(slot, pin, reg)				\
-	do {								\
-		int irq;						\
-		irq = get_pci_irq_from_of(hose, slot, pin);		\
-		if (irq > 0 && irq < 16) 				\
-			pci_write_config_byte(dev, reg, irq2pin[irq]);	\
-		else							\
-			printk(KERN_WARNING "ULI1575 device"		\
-				"(slot %d, pin %d) irq %d is invalid.\n", \
-				slot, pin, irq);			\
-	} while(0)
-
-	/* USB 1.1 OHCI controller 1, slot 28, pin 1 */
-	ULI1575_SET_DEV_IRQ(28, 1, 0x86);
-
-	/* USB 1.1 OHCI controller 2, slot 28, pin 2 */
-	ULI1575_SET_DEV_IRQ(28, 2, 0x87);
-
-	/* USB 1.1 OHCI controller 3, slot 28, pin 3 */
-	ULI1575_SET_DEV_IRQ(28, 3, 0x88);
-
-	/* USB 2.0 controller, slot 28, pin 4 */
-	irq = get_pci_irq_from_of(hose, 28, 4);
-	if (irq >= 0 && irq <= 15)
-		pci_write_config_dword(dev, 0x74, uli1575_irq_route_table[irq]);
-
-	/* Audio controller, slot 29, pin 1 */
-	ULI1575_SET_DEV_IRQ(29, 1, 0x8a);
-
-	/* Modem controller, slot 29, pin 2 */
-	ULI1575_SET_DEV_IRQ(29, 2, 0x8b);
-
-	/* HD audio controller, slot 29, pin 3 */
-	ULI1575_SET_DEV_IRQ(29, 3, 0x8c);
-
-	/* SMB interrupt: slot 30, pin 1 */
-	ULI1575_SET_DEV_IRQ(30, 1, 0x8e);
-
-	/* PMU ACPI SCI interrupt: slot 30, pin 2 */
-	ULI1575_SET_DEV_IRQ(30, 2, 0x8f);
-
-	/* Serial ATA interrupt: slot 31, pin 1 */
-	ULI1575_SET_DEV_IRQ(31, 1, 0x8d);
-
-	/* Primary PATA IDE IRQ: 14
-	 * Secondary PATA IDE IRQ: 15
-	 */
-	pci_write_config_byte(dev, 0x44, 0x30 | uli1575_irq_route_table[14]);
-	pci_write_config_byte(dev, 0x75, uli1575_irq_route_table[15]);
-
-	/* Set IRQ14 and IRQ15 to legacy IRQs */
-	pci_read_config_word(dev, 0x46, &temp);
-	temp |= 0xc000;
-	pci_write_config_word(dev, 0x46, temp);
-
-	/* Set i8259 interrupt trigger
-	 * IRQ 3:  Level
-	 * IRQ 4:  Level
-	 * IRQ 5:  Level
-	 * IRQ 6:  Level
-	 * IRQ 7:  Level
-	 * IRQ 9:  Level
-	 * IRQ 10: Level
-	 * IRQ 11: Level
-	 * IRQ 12: Level
-	 * IRQ 14: Edge
-	 * IRQ 15: Edge
-	 */
-	outb(0xfa, 0x4d0);
-	outb(0x1e, 0x4d1);
-
-#undef ULI1575_SET_DEV_IRQ
-}
-
-/* SATA */
-static void __devinit quirk_uli5288(struct pci_dev *dev)
+static int mpc85xx_exclude_device(struct pci_controller *hose,
+				   u_char bus, u_char devfn)
 {
-	unsigned char c;
-
-	pci_read_config_byte(dev, 0x83, &c);
-	c |= 0x80;		/* read/write lock */
-	pci_write_config_byte(dev, 0x83, c);
-
-	pci_write_config_byte(dev, 0x09, 0x01);	/* Base class code: storage */
-	pci_write_config_byte(dev, 0x0a, 0x06);	/* IDE disk */
+	struct device_node* node;
+	struct resource rsrc;

-	pci_read_config_byte(dev, 0x83, &c);
-	c &= 0x7f;
-	pci_write_config_byte(dev, 0x83, c);
-
-	pci_read_config_byte(dev, 0x84, &c);
-	c |= 0x01;				/* emulated PATA mode enabled */
-	pci_write_config_byte(dev, 0x84, c);
-}
+	node = (struct device_node *)hose->arch_data;
+	of_address_to_resource(node, 0, &rsrc);

-/* PATA */
-static void __devinit quirk_uli5229(struct pci_dev *dev)
-{
-	unsigned short temp;
-	pci_write_config_word(dev, 0x04, 0x0405);	/* MEM IO MSI */
-	pci_read_config_word(dev, 0x4a, &temp);
-	temp |= 0x1000;				/* Enable Native IRQ 14/15 */
-	pci_write_config_word(dev, 0x4a, temp);
-}
+	if ((rsrc.start & 0xfffff) == 0xb000) {
+		return uli_exclude_device(hose, bus, devfn);
+	}

-/*Bridge*/
-static void __devinit early_uli5249(struct pci_dev *dev)
-{
-	unsigned char temp;
-	pci_write_config_word(dev, 0x04, 0x0007);	/* mem access */
-	pci_read_config_byte(dev, 0x7c, &temp);
-	pci_write_config_byte(dev, 0x7c, 0x80);	/* R/W lock control */
-	pci_write_config_byte(dev, 0x09, 0x01);	/* set as pci-pci bridge */
-	pci_write_config_byte(dev, 0x7c, temp);	/* restore pci bus debug control */
-	dev->class |= 0x1;
+	return PCIBIOS_SUCCESSFUL;
 }
-
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
 #endif	/* CONFIG_PCI */

 /*
@@ -342,6 +156,8 @@ static void __init mpc8544_ds_setup_arch(void)
 		else
 			fsl_add_bridge(np, 0);
 	}
+	uses_fsl_uli_m1575 = 1;
+	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif

 	printk("MPC8544 DS board from Freescale Semiconductor\n");
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 343b76d..685b2fb 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -7,6 +7,7 @@ config MPC8641_HPCN
 	bool "Freescale MPC8641 HPCN"
 	select PPC_I8259
 	select DEFAULT_UIMAGE
+	select FSL_ULI1575
 	help
 	  This option enables support for the MPC8641 HPCN board.

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index e9eaa07..56b27ca 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -107,220 +107,25 @@ mpc86xx_hpcn_init_irq(void)
 }

 #ifdef CONFIG_PCI
+extern int uses_fsl_uli_m1575;
+extern int uli_exclude_device(struct pci_controller *hose,
+				u_char bus, u_char devfn);

-enum pirq{PIRQA = 8, PIRQB, PIRQC, PIRQD, PIRQE, PIRQF, PIRQG, PIRQH};
-const unsigned char uli1575_irq_route_table[16] = {
-	0, 	/* 0: Reserved */
-	0x8, 	/* 1: 0b1000 */
-	0, 	/* 2: Reserved */
-	0x2,	/* 3: 0b0010 */
-	0x4,	/* 4: 0b0100 */
-	0x5, 	/* 5: 0b0101 */
-	0x7,	/* 6: 0b0111 */
-	0x6,	/* 7: 0b0110 */
-	0, 	/* 8: Reserved */
-	0x1,	/* 9: 0b0001 */
-	0x3,	/* 10: 0b0011 */
-	0x9,	/* 11: 0b1001 */
-	0xb,	/* 12: 0b1011 */
-	0, 	/* 13: Reserved */
-	0xd,	/* 14, 0b1101 */
-	0xf,	/* 15, 0b1111 */
-};
-
-static int __devinit
-get_pci_irq_from_of(struct pci_controller *hose, int slot, int pin)
-{
-	struct of_irq oirq;
-	u32 laddr[3];
-	struct device_node *hosenode = hose ? hose->arch_data : NULL;
-
-	if (!hosenode) return -EINVAL;
-
-	laddr[0] = (hose->first_busno << 16) | (PCI_DEVFN(slot, 0) << 8);
-	laddr[1] = laddr[2] = 0;
-	of_irq_map_raw(hosenode, &pin, 1, laddr, &oirq);
-	DBG("mpc86xx_hpcn: pci irq addr %x, slot %d, pin %d, irq %d\n",
-			laddr[0], slot, pin, oirq.specifier[0]);
-	return oirq.specifier[0];
-}
-
-static void __devinit quirk_uli1575(struct pci_dev *dev)
-{
-	unsigned short temp;
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	unsigned char irq2pin[16], c;
-	unsigned long pirq_map_word = 0;
-	u32 irq;
-	int i;
-
-	/*
-	 * ULI1575 interrupts route setup
-	 */
-	memset(irq2pin, 0, 16); /* Initialize default value 0 */
-
-	/*
-	 * PIRQA -> PIRQD mapping read from OF-tree
-	 *
-	 * interrupts for PCI slot0 -- PIRQA / PIRQB / PIRQC / PIRQD
-	 *                PCI slot1 -- PIRQB / PIRQC / PIRQD / PIRQA
-	 */
-	for (i = 0; i < 4; i++){
-		irq = get_pci_irq_from_of(hose, 17, i + 1);
-		if (irq > 0 && irq < 16)
-			irq2pin[irq] = PIRQA + i;
-		else
-			printk(KERN_WARNING "ULI1575 device"
-			    "(slot %d, pin %d) irq %d is invalid.\n",
-			    17, i, irq);
-	}
-
-	/*
-	 * PIRQE -> PIRQF mapping set manually
-	 *
-	 * IRQ pin   IRQ#
-	 * PIRQE ---- 9
-	 * PIRQF ---- 10
-	 * PIRQG ---- 11
-	 * PIRQH ---- 12
-	 */
-	for (i = 0; i < 4; i++) irq2pin[i + 9] = PIRQE + i;
-
-	/* Set IRQ-PIRQ Mapping to ULI1575 */
-	for (i = 0; i < 16; i++)
-		if (irq2pin[i])
-			pirq_map_word |= (uli1575_irq_route_table[i] & 0xf)
-				<< ((irq2pin[i] - PIRQA) * 4);
-
-	/* ULI1575 IRQ mapping conf register default value is 0xb9317542 */
-	DBG("Setup ULI1575 IRQ mapping configuration register value = 0x%x\n",
-			pirq_map_word);
-	pci_write_config_dword(dev, 0x48, pirq_map_word);
-
-#define ULI1575_SET_DEV_IRQ(slot, pin, reg) 				\
-	do { 								\
-		int irq; 						\
-		irq = get_pci_irq_from_of(hose, slot, pin); 		\
-		if (irq > 0 && irq < 16) 				\
-			pci_write_config_byte(dev, reg, irq2pin[irq]); 	\
-		else							\
-			printk(KERN_WARNING "ULI1575 device"		\
-			    "(slot %d, pin %d) irq %d is invalid.\n",	\
-			    slot, pin, irq);				\
-	} while(0)
-
-	/* USB 1.1 OHCI controller 1, slot 28, pin 1 */
-	ULI1575_SET_DEV_IRQ(28, 1, 0x86);
-
-	/* USB 1.1 OHCI controller 2, slot 28, pin 2 */
-	ULI1575_SET_DEV_IRQ(28, 2, 0x87);
-
-	/* USB 1.1 OHCI controller 3, slot 28, pin 3 */
-	ULI1575_SET_DEV_IRQ(28, 3, 0x88);
-
-	/* USB 2.0 controller, slot 28, pin 4 */
-	irq = get_pci_irq_from_of(hose, 28, 4);
-	if (irq >= 0 && irq <=15)
-		pci_write_config_dword(dev, 0x74, uli1575_irq_route_table[irq]);
-
-	/* Audio controller, slot 29, pin 1 */
-	ULI1575_SET_DEV_IRQ(29, 1, 0x8a);
-
-	/* Modem controller, slot 29, pin 2 */
-	ULI1575_SET_DEV_IRQ(29, 2, 0x8b);
-
-	/* HD audio controller, slot 29, pin 3 */
-	ULI1575_SET_DEV_IRQ(29, 3, 0x8c);
-
-	/* SMB interrupt: slot 30, pin 1 */
-	ULI1575_SET_DEV_IRQ(30, 1, 0x8e);
-
-	/* PMU ACPI SCI interrupt: slot 30, pin 2 */
-	ULI1575_SET_DEV_IRQ(30, 2, 0x8f);
-
-	/* Serial ATA interrupt: slot 31, pin 1 */
-	ULI1575_SET_DEV_IRQ(31, 1, 0x8d);
-
-	/* Primary PATA IDE IRQ: 14
-	 * Secondary PATA IDE IRQ: 15
-	 */
-	pci_write_config_byte(dev, 0x44, 0x30 | uli1575_irq_route_table[14]);
-	pci_write_config_byte(dev, 0x75, uli1575_irq_route_table[15]);
-
-	/* Set IRQ14 and IRQ15 to legacy IRQs */
-	pci_read_config_word(dev, 0x46, &temp);
-	temp |= 0xc000;
-	pci_write_config_word(dev, 0x46, temp);
-
-	/* Set i8259 interrupt trigger
-	 * IRQ 3:  Level
-	 * IRQ 4:  Level
-	 * IRQ 5:  Level
-	 * IRQ 6:  Level
-	 * IRQ 7:  Level
-	 * IRQ 9:  Level
-	 * IRQ 10: Level
-	 * IRQ 11: Level
-	 * IRQ 12: Level
-	 * IRQ 14: Edge
-	 * IRQ 15: Edge
-	 */
-	outb(0xfa, 0x4d0);
-	outb(0x1e, 0x4d1);
-
-#undef ULI1575_SET_DEV_IRQ
-
-	/* Disable the HD interface and enable the AC97 interface. */
-	pci_read_config_byte(dev, 0xb8, &c);
-	c &= 0x7f;
-	pci_write_config_byte(dev, 0xb8, c);
-}
-
-static void __devinit quirk_uli5288(struct pci_dev *dev)
+static int mpc86xx_exclude_device(struct pci_controller *hose,
+				   u_char bus, u_char devfn)
 {
-	unsigned char c;
+	struct device_node* node;
+	struct resource rsrc;

-	pci_read_config_byte(dev,0x83,&c);
-	c |= 0x80;
-	pci_write_config_byte(dev, 0x83, c);
+	node = (struct device_node *)hose->arch_data;
+	of_address_to_resource(node, 0, &rsrc);

-	pci_write_config_byte(dev, 0x09, 0x01);
-	pci_write_config_byte(dev, 0x0a, 0x06);
-
-	pci_read_config_byte(dev,0x83,&c);
-	c &= 0x7f;
-	pci_write_config_byte(dev, 0x83, c);
-
-	pci_read_config_byte(dev,0x84,&c);
-	c |= 0x01;
-	pci_write_config_byte(dev, 0x84, c);
-}
-
-static void __devinit quirk_uli5229(struct pci_dev *dev)
-{
-	unsigned short temp;
-	pci_write_config_word(dev, 0x04, 0x0405);
-	dev->class &= ~0x5;
-	pci_read_config_word(dev, 0x4a, &temp);
-	temp |= 0x1000;
-	pci_write_config_word(dev, 0x4a, temp);
-}
+	if ((rsrc.start & 0xfffff) == 0x8000) {
+		return uli_exclude_device(hose, bus, devfn);
+	}

-static void __devinit early_uli5249(struct pci_dev *dev)
-{
-	unsigned char temp;
-	pci_write_config_word(dev, 0x04, 0x0007);
-	pci_read_config_byte(dev, 0x7c, &temp);
-	pci_write_config_byte(dev, 0x7c, 0x80);
-	pci_write_config_byte(dev, 0x09, 0x01);
-	pci_write_config_byte(dev, 0x7c, temp);
-	dev->class |= 0x1;
+	return PCIBIOS_SUCCESSFUL;
 }
-
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
 #endif /* CONFIG_PCI */


@@ -353,6 +158,9 @@ mpc86xx_hpcn_setup_arch(void)
 		else
 			fsl_add_bridge(np, 0);
 	}
+	uses_fsl_uli_m1575 = 1;
+	ppc_md.pci_exclude_device = mpc86xx_exclude_device;
+
 #endif

 	printk("MPC86xx HPCN board from Freescale Semiconductor\n");
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 932538a..cfc2497 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -282,4 +282,12 @@ config AXON_RAM
 	  minor numbers are available in /proc/devices, /proc/partitions or
 	  in /sys/block/axonram?/dev.

+config FSL_ULI1575
+	bool
+	default n
+	help
+	  Supports for the ULI1575 PCIe south bridge that exists on some
+	  Freescale reference boards. The boards all use the ULI in pretty
+	  much the same way.
+
 endmenu
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index d6e041a..d44e832 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -1,3 +1,6 @@
+
+obj-$(CONFIG_FSL_ULI1575)	+= fsl_uli1575.o
+
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_PMAC)		+= powermac/
 else
diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
new file mode 100644
index 0000000..af2321f
--- /dev/null
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -0,0 +1,255 @@
+/*
+ * ULI M1575 setup code - specific to Freescale boards
+ *
+ * Copyright 2007 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/mc146818rtc.h>
+
+#include <asm/system.h>
+#include <asm/pci-bridge.h>
+
+#define ULI_PIRQA	0x08
+#define ULI_PIRQB	0x09
+#define ULI_PIRQC	0x0a
+#define ULI_PIRQD	0x0b
+#define ULI_PIRQE	0x0c
+#define ULI_PIRQF	0x0d
+#define ULI_PIRQG	0x0e
+
+#define ULI_8259_NONE	0x00
+#define ULI_8259_IRQ1	0x08
+#define ULI_8259_IRQ3	0x02
+#define ULI_8259_IRQ4	0x04
+#define ULI_8259_IRQ5	0x05
+#define ULI_8259_IRQ6	0x07
+#define ULI_8259_IRQ7	0x06
+#define ULI_8259_IRQ9	0x01
+#define ULI_8259_IRQ10	0x03
+#define ULI_8259_IRQ11	0x09
+#define ULI_8259_IRQ12	0x0b
+#define ULI_8259_IRQ14	0x0d
+#define ULI_8259_IRQ15	0x0f
+
+u8 uli_pirq_to_irq[8] = {
+	ULI_8259_IRQ9,		/* PIRQA */
+	ULI_8259_IRQ10,		/* PIRQB */
+	ULI_8259_IRQ11,		/* PIRQC */
+	ULI_8259_IRQ12,		/* PIRQD */
+	ULI_8259_IRQ5,		/* PIRQE */
+	ULI_8259_IRQ6,		/* PIRQF */
+	ULI_8259_IRQ7,		/* PIRQG */
+	ULI_8259_NONE,		/* PIRQH */
+};
+
+/* set in board code if you want this quirks to do something */
+int uses_fsl_uli_m1575;
+
+/* Bridge */
+static void __devinit early_uli5249(struct pci_dev *dev)
+{
+	unsigned char temp;
+
+	if (!uses_fsl_uli_m1575)
+		return;
+
+	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_IO |
+		 PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
+
+	/* read/write lock */
+	pci_read_config_byte(dev, 0x7c, &temp);
+	pci_write_config_byte(dev, 0x7c, 0x80);
+
+	/* set as P2P bridge */
+	pci_write_config_byte(dev, PCI_CLASS_PROG, 0x01);
+	dev->class |= 0x1;
+
+	/* restore lock */
+	pci_write_config_byte(dev, 0x7c, temp);
+}
+
+
+static void __devinit quirk_uli1575(struct pci_dev *dev)
+{
+	int i;
+
+	if (!uses_fsl_uli_m1575)
+		return;
+
+	/*
+	 * ULI1575 interrupts route setup
+	 */
+
+	/* ULI1575 IRQ mapping conf register maps PIRQx to IRQn */
+	for (i = 0; i < 4; i++) {
+		u8 val = uli_pirq_to_irq[i*2] | (uli_pirq_to_irq[i*2+1] << 4);
+		pci_write_config_byte(dev, 0x48 + i, val);
+	}
+
+	/* USB 1.1 OHCI controller 1: dev 28, func 0 - IRQ12 */
+	pci_write_config_byte(dev, 0x86, ULI_PIRQD);
+
+	/* USB 1.1 OHCI controller 2: dev 28, func 1 - IRQ9 */
+	pci_write_config_byte(dev, 0x87, ULI_PIRQA);
+
+	/* USB 1.1 OHCI controller 3: dev 28, func 2 - IRQ10 */
+	pci_write_config_byte(dev, 0x88, ULI_PIRQB);
+
+	/* Lan controller: dev 27, func 0 - IRQ6 */
+	pci_write_config_byte(dev, 0x89, ULI_PIRQF);
+
+	/* AC97 Audio controller: dev 29, func 0 - IRQ6 */
+	pci_write_config_byte(dev, 0x8a, ULI_PIRQF);
+
+	/* Modem controller: dev 29, func 1 - IRQ6 */
+	pci_write_config_byte(dev, 0x8b, ULI_PIRQF);
+
+	/* HD Audio controller: dev 29, func 2 - IRQ6 */
+	pci_write_config_byte(dev, 0x8c, ULI_PIRQF);
+
+	/* SATA controller: dev 31, func 1 - IRQ5 */
+	pci_write_config_byte(dev, 0x8d, ULI_PIRQE);
+
+	/* SMB interrupt: dev 30, func 1 - IRQ7 */
+	pci_write_config_byte(dev, 0x8e, ULI_PIRQG);
+
+	/* PMU ACPI SCI interrupt: dev 30, func 2 - IRQ7 */
+	pci_write_config_byte(dev, 0x8f, ULI_PIRQG);
+
+	/* USB 2.0 controller: dev 28, func 3 */
+	pci_write_config_byte(dev, 0x74, ULI_8259_IRQ11);
+
+	/* Primary PATA IDE IRQ: 14
+	 * Secondary PATA IDE IRQ: 15
+	 */
+	pci_write_config_byte(dev, 0x44, 0x30 | ULI_8259_IRQ14);
+	pci_write_config_byte(dev, 0x75, ULI_8259_IRQ15);
+}
+
+static void __devinit quirk_final_uli1575(struct pci_dev *dev)
+{
+	/* Set i8259 interrupt trigger
+	 * IRQ 3:  Level
+	 * IRQ 4:  Level
+	 * IRQ 5:  Level
+	 * IRQ 6:  Level
+	 * IRQ 7:  Level
+	 * IRQ 9:  Level
+	 * IRQ 10: Level
+	 * IRQ 11: Level
+	 * IRQ 12: Level
+	 * IRQ 14: Edge
+	 * IRQ 15: Edge
+	 */
+	if (!uses_fsl_uli_m1575)
+		return;
+
+	outb(0xfa, 0x4d0);
+	outb(0x1e, 0x4d1);
+
+	/* setup RTC */
+	CMOS_WRITE(RTC_SET, RTC_CONTROL);
+	CMOS_WRITE(RTC_24H, RTC_CONTROL);
+
+	/* ensure month, date, and week alarm fields are ignored */
+	CMOS_WRITE(0, RTC_VALID);
+
+	outb_p(0x7c, 0x72);
+	outb_p(RTC_ALARM_DONT_CARE, 0x73);
+
+	outb_p(0x7d, 0x72);
+	outb_p(RTC_ALARM_DONT_CARE, 0x73);
+}
+
+/* SATA */
+static void __devinit quirk_uli5288(struct pci_dev *dev)
+{
+	unsigned char c;
+	unsigned int d;
+
+	if (!uses_fsl_uli_m1575)
+		return;
+
+	/* read/write lock */
+	pci_read_config_byte(dev, 0x83, &c);
+	pci_write_config_byte(dev, 0x83, c|0x80);
+
+	pci_read_config_dword(dev, PCI_CLASS_REVISION, &d);
+	d = (d & 0xff) | (PCI_CLASS_STORAGE_SATA_AHCI << 8);
+	pci_write_config_dword(dev, PCI_CLASS_REVISION, d);
+
+	/* restore lock */
+	pci_write_config_byte(dev, 0x83, c);
+
+	/* disable emulated PATA mode enabled */
+	pci_read_config_byte(dev, 0x84, &c);
+	pci_write_config_byte(dev, 0x84, c & ~0x01);
+}
+
+/* PATA */
+static void __devinit quirk_uli5229(struct pci_dev *dev)
+{
+	unsigned short temp;
+
+	if (!uses_fsl_uli_m1575)
+		return;
+
+	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE |
+		PCI_COMMAND_MASTER | PCI_COMMAND_IO);
+
+	/* Enable Native IRQ 14/15 */
+	pci_read_config_word(dev, 0x4a, &temp);
+	pci_write_config_word(dev, 0x4a, temp | 0x1000);
+}
+
+/* We have to do a dummy read on the P2P for the RTC to work, WTF */
+static void __devinit quirk_final_uli5249(struct pci_dev *dev)
+{
+	int i;
+	u8 *dummy;
+	struct pci_bus *bus = dev->bus;
+
+	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
+		if ((bus->resource[i]) &&
+			(bus->resource[i]->flags & IORESOURCE_MEM)) {
+			dummy = ioremap(bus->resource[i]->start, 0x4);
+			if (dummy) {
+				in_8(dummy);
+				iounmap(dummy);
+			}
+			break;
+		}
+	}
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5249, quirk_final_uli5249);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x1575, quirk_final_uli1575);
+
+int uli_exclude_device(struct pci_controller *hose,
+			u_char bus, u_char devfn)
+{
+	if (bus == (hose->first_busno + 2)) {
+		/* exclude Modem controller */
+		if ((PCI_SLOT(devfn) == 29) && (PCI_FUNC(devfn) == 1))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		/* exclude HD Audio controller */
+		if ((PCI_SLOT(devfn) == 29) && (PCI_FUNC(devfn) == 2))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
-- 
1.5.2.2
