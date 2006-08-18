Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 71C6A67B6E
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 05:36:33 +1000 (EST)
Subject: [PATCH] [POWERPC] Rewrite the PPC 86xx IRQ handling to use Flat
	Device Tree
From: Jon Loeliger <jdl@freescale.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17637.1235.223857.925995@cargo.ozlabs.ibm.com>
References: <1155679316.10054.129.camel@cashmere.sps.mot.com>
	<17636.3393.801267.484874@cargo.ozlabs.ibm.com>
	<E1GDhtO-0002Mk-2j@jdl.com>
	<17637.1235.223857.925995@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1155929435.10054.212.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Fri, 18 Aug 2006 14:30:35 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


IRQ setup now comes from the Flat Device Tree and use the new generic
IRQ code.  Fixed the fsl_soc.c IRQ OF interrupt node parsing.
Removed some unused MPC86xx macro definition.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
(cherry picked from 919fede6edab94cccb3ca8c1c0b32fa62c9369a5 commit)
---

On Thu, 2006-08-17 at 19:07, Paul Mackerras wrote:
> The "Allow MPC8641 HPCN to build with CONFIG_PCI disabled too" patch
> depends on your "Rewrite the PPC 86xx IRQ handling to use Flat Device
> Tree" which isn't in the queue for 2.6.18, and doesn't apply for
> 2.6.18 since it depends on the constifying of get_property.

Paul,

This is the same patch from three weeks ago, cherry-picked out
of your master branch with the constification problem resolved
so that it will apply directly to your merge branch.

Without this patch, 86xx won't even build in 2.6.18 due
to the IRQ new world order.

Thanks,
jdl


 arch/powerpc/platforms/86xx/mpc8641_hpcn.h |   32 ---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |  324 +++++++++++++++-------------
 arch/powerpc/sysdev/fsl_soc.c              |   30 +--
 3 files changed, 188 insertions(+), 198 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc8641_hpcn.h b/arch/powerpc/platforms/86xx/mpc8641_hpcn.h
index 5d2bcf7..41e554c 100644
--- a/arch/powerpc/platforms/86xx/mpc8641_hpcn.h
+++ b/arch/powerpc/platforms/86xx/mpc8641_hpcn.h
@@ -16,38 +16,6 @@ #define __MPC8641_HPCN_H__
 
 #include <linux/init.h>
 
-/* PCI interrupt controller */
-#define PIRQA		3
-#define PIRQB		4
-#define PIRQC		5
-#define PIRQD		6
-#define PIRQ7		7
-#define PIRQE		9
-#define PIRQF		10
-#define PIRQG		11
-#define PIRQH		12
-
-/* PCI-Express memory map */
-#define MPC86XX_PCIE_LOWER_IO        0x00000000
-#define MPC86XX_PCIE_UPPER_IO        0x00ffffff
-
-#define MPC86XX_PCIE_LOWER_MEM       0x80000000
-#define MPC86XX_PCIE_UPPER_MEM       0x9fffffff
-
-#define MPC86XX_PCIE_IO_BASE         0xe2000000
-#define MPC86XX_PCIE_MEM_OFFSET      0x00000000
-
-#define MPC86XX_PCIE_IO_SIZE         0x01000000
-
-#define PCIE1_CFG_ADDR_OFFSET    (0x8000)
-#define PCIE1_CFG_DATA_OFFSET    (0x8004)
-
-#define PCIE2_CFG_ADDR_OFFSET    (0x9000)
-#define PCIE2_CFG_DATA_OFFSET    (0x9004)
-
-#define MPC86xx_PCIE_OFFSET PCIE1_CFG_ADDR_OFFSET
-#define MPC86xx_PCIE_SIZE	(0x1000)
-
 #define MPC86XX_RSTCR_OFFSET	(0xe00b0)	/* Reset Control Register */
 
 #endif	/* __MPC8641_HPCN_H__ */
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index ebae73e..146da30 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -37,6 +37,14 @@ #include <sysdev/fsl_soc.h>
 #include "mpc86xx.h"
 #include "mpc8641_hpcn.h"
 
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt...) do { printk(KERN_ERR fmt); } while(0)
+#else
+#define DBG(fmt...) do { } while(0)
+#endif
+
 #ifndef CONFIG_PCI
 unsigned long isa_io_base = 0;
 unsigned long isa_mem_base = 0;
@@ -44,205 +52,215 @@ unsigned long pci_dram_offset = 0;
 #endif
 
 
-/*
- * Internal interrupts are all Level Sensitive, and Positive Polarity
- */
-
-static u_char mpc86xx_hpcn_openpic_initsenses[] __initdata = {
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  0: Reserved */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  1: MCM */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  2: DDR DRAM */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  3: LBIU */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  4: DMA 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  5: DMA 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  6: DMA 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  7: DMA 3 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  8: PCIE1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  9: PCIE2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 10: Reserved */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 11: Reserved */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 12: DUART2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 13: TSEC 1 Transmit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 14: TSEC 1 Receive */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 15: TSEC 3 transmit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 16: TSEC 3 receive */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 17: TSEC 3 error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 18: TSEC 1 Receive/Transmit Error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 19: TSEC 2 Transmit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 20: TSEC 2 Receive */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 21: TSEC 4 transmit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 22: TSEC 4 receive */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 23: TSEC 4 error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 24: TSEC 2 Receive/Transmit Error */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 25: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 26: DUART1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 27: I2C */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 28: Performance Monitor */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 29: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 30: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 31: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 32: SRIO error/write-port unit */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 33: SRIO outbound doorbell */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 34: SRIO inbound doorbell */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 35: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 36: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 37: SRIO outbound message unit 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 38: SRIO inbound message unit 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 39: SRIO outbound message unit 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 40: SRIO inbound message unit 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 41: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 42: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 43: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 44: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 45: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 46: Unused */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 47: Unused */
-	0x0,						/* External  0: */
-	0x0,						/* External  1: */
-	0x0,						/* External  2: */
-	0x0,						/* External  3: */
-	0x0,						/* External  4: */
-	0x0,						/* External  5: */
-	0x0,						/* External  6: */
-	0x0,						/* External  7: */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External  8: Pixis FPGA */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* External  9: ULI 8259 INTR Cascade */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 10: Quad ETH PHY */
-	0x0,						/* External 11: */
-	0x0,
-	0x0,
-	0x0,
-	0x0,
-};
-
+static void mpc86xx_8259_cascade(unsigned int irq, struct irq_desc *desc,
+				 struct pt_regs *regs)
+{
+	unsigned int cascade_irq = i8259_irq(regs);
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq, regs);
+	desc->chip->eoi(irq);
+}
 
 void __init
 mpc86xx_hpcn_init_irq(void)
 {
 	struct mpic *mpic1;
+	struct device_node *np, *cascade_node = NULL;
+	int cascade_irq;
 	phys_addr_t openpic_paddr;
 
+	np = of_find_node_by_type(NULL, "open-pic");
+	if (np == NULL)
+		return;
+
 	/* Determine the Physical Address of the OpenPIC regs */
 	openpic_paddr = get_immrbase() + MPC86xx_OPENPIC_OFFSET;
 
 	/* Alloc mpic structure and per isu has 16 INT entries. */
-	mpic1 = mpic_alloc(openpic_paddr,
+	mpic1 = mpic_alloc(np, openpic_paddr,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			16, MPC86xx_OPENPIC_IRQ_OFFSET, 0, 250,
-			mpc86xx_hpcn_openpic_initsenses,
-			sizeof(mpc86xx_hpcn_openpic_initsenses),
+			16, NR_IRQS - 4,
 			" MPIC     ");
 	BUG_ON(mpic1 == NULL);
 
+	mpic_assign_isu(mpic1, 0, openpic_paddr + 0x10000);
+
 	/* 48 Internal Interrupts */
-	mpic_assign_isu(mpic1, 0, openpic_paddr + 0x10200);
-	mpic_assign_isu(mpic1, 1, openpic_paddr + 0x10400);
-	mpic_assign_isu(mpic1, 2, openpic_paddr + 0x10600);
+	mpic_assign_isu(mpic1, 1, openpic_paddr + 0x10200);
+	mpic_assign_isu(mpic1, 2, openpic_paddr + 0x10400);
+	mpic_assign_isu(mpic1, 3, openpic_paddr + 0x10600);
 
-	/* 16 External interrupts */
-	mpic_assign_isu(mpic1, 3, openpic_paddr + 0x10000);
+	/* 16 External interrupts
+	 * Moving them from [0 - 15] to [64 - 79]
+	 */
+	mpic_assign_isu(mpic1, 4, openpic_paddr + 0x10000);
 
 	mpic_init(mpic1);
 
 #ifdef CONFIG_PCI
-	mpic_setup_cascade(MPC86xx_IRQ_EXT9, i8259_irq_cascade, NULL);
-	i8259_init(0, I8259_OFFSET);
-#endif
-}
+	/* Initialize i8259 controller */
+	for_each_node_by_type(np, "interrupt-controller")
+		if (device_is_compatible(np, "chrp,iic")) {
+			cascade_node = np;
+			break;
+		}
+	if (cascade_node == NULL) {
+		printk(KERN_DEBUG "mpc86xxhpcn: no ISA interrupt controller\n");
+		return;
+	}
 
+	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
+	if (cascade_irq == NO_IRQ) {
+		printk(KERN_ERR "mpc86xxhpcn: failed to map cascade interrupt");
+		return;
+	}
+	DBG("mpc86xxhpcn: cascade mapped to irq %d\n", cascade_irq);
 
+	i8259_init(cascade_node, 0);
+	set_irq_chained_handler(cascade_irq, mpc86xx_8259_cascade);
+#endif
+}
 
 #ifdef CONFIG_PCI
-/*
- * interrupt routing
- */
 
-int
-mpc86xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+enum pirq{PIRQA = 8, PIRQB, PIRQC, PIRQD, PIRQE, PIRQF, PIRQG, PIRQH};
+const unsigned char uli1575_irq_route_table[16] = {
+	0, 	/* 0: Reserved */
+	0x8, 	/* 1: 0b1000 */
+	0, 	/* 2: Reserved */
+	0x2,	/* 3: 0b0010 */
+	0x4,	/* 4: 0b0100 */
+	0x5, 	/* 5: 0b0101 */
+	0x7,	/* 6: 0b0111 */
+	0x6,	/* 7: 0b0110 */
+	0, 	/* 8: Reserved */
+	0x1,	/* 9: 0b0001 */
+	0x3,	/* 10: 0b0011 */
+	0x9,	/* 11: 0b1001 */
+	0xb,	/* 12: 0b1011 */
+	0, 	/* 13: Reserved */
+	0xd,	/* 14, 0b1101 */
+	0xf,	/* 15, 0b1111 */
+};
+
+static int __devinit
+get_pci_irq_from_of(struct pci_controller *hose, int slot, int pin)
 {
-	static char pci_irq_table[][4] = {
-		/*
-		 *      PCI IDSEL/INTPIN->INTLINE
-		 *       A      B      C      D
-		 */
-		{PIRQA, PIRQB, PIRQC, PIRQD},   /* IDSEL 17 -- PCI Slot 1 */
-		{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 18 -- PCI Slot 2 */
-		{0, 0, 0, 0},			/* IDSEL 19 */
-		{0, 0, 0, 0},			/* IDSEL 20 */
-		{0, 0, 0, 0},			/* IDSEL 21 */
-		{0, 0, 0, 0},			/* IDSEL 22 */
-		{0, 0, 0, 0},			/* IDSEL 23 */
-		{0, 0, 0, 0},			/* IDSEL 24 */
-		{0, 0, 0, 0},			/* IDSEL 25 */
-		{PIRQD, PIRQA, PIRQB, PIRQC},	/* IDSEL 26 -- PCI Bridge*/
-		{PIRQC, 0, 0, 0},		/* IDSEL 27 -- LAN */
-		{PIRQE, PIRQF, PIRQH, PIRQ7},	/* IDSEL 28 -- USB 1.1 */
-		{PIRQE, PIRQF, PIRQG, 0},	/* IDSEL 29 -- Audio & Modem */
-		{PIRQH, 0, 0, 0},		/* IDSEL 30 -- LPC & PMU*/
-		{PIRQD, 0, 0, 0},		/* IDSEL 31 -- ATA */
-	};
-
-	const long min_idsel = 17, max_idsel = 31, irqs_per_slot = 4;
-	return PCI_IRQ_TABLE_LOOKUP + I8259_OFFSET;
+	struct of_irq oirq;
+	u32 laddr[3];
+	struct device_node *hosenode = hose ? hose->arch_data : NULL;
+
+	if (!hosenode) return -EINVAL;
+
+	laddr[0] = (hose->first_busno << 16) | (PCI_DEVFN(slot, 0) << 8);
+	laddr[1] = laddr[2] = 0;
+	of_irq_map_raw(hosenode, &pin, laddr, &oirq);
+	DBG("mpc86xx_hpcn: pci irq addr %x, slot %d, pin %d, irq %d\n",
+			laddr[0], slot, pin, oirq.specifier[0]);
+	return oirq.specifier[0];
 }
 
-static void __devinit quirk_ali1575(struct pci_dev *dev)
+static void __devinit quirk_uli1575(struct pci_dev *dev)
 {
 	unsigned short temp;
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	unsigned char irq2pin[16];
+	unsigned long pirq_map_word = 0;
+	u32 irq;
+	int i;
 
 	/*
-	 * ALI1575 interrupts route table setup:
+	 * ULI1575 interrupts route setup
+	 */
+	memset(irq2pin, 0, 16); /* Initialize default value 0 */
+
+	/*
+	 * PIRQA -> PIRQD mapping read from OF-tree
+	 *
+	 * interrupts for PCI slot0 -- PIRQA / PIRQB / PIRQC / PIRQD
+	 *                PCI slot1 -- PIRQB / PIRQC / PIRQD / PIRQA
+	 */
+	for (i = 0; i < 4; i++){
+		irq = get_pci_irq_from_of(hose, 17, i + 1);
+		if (irq > 0 && irq < 16)
+			irq2pin[irq] = PIRQA + i;
+		else
+			printk(KERN_WARNING "ULI1575 device"
+			    "(slot %d, pin %d) irq %d is invalid.\n",
+			    17, i, irq);
+	}
+
+	/*
+	 * PIRQE -> PIRQF mapping set manually
 	 *
 	 * IRQ pin   IRQ#
-	 * PIRQA ---- 3
-	 * PIRQB ---- 4
-	 * PIRQC ---- 5
-	 * PIRQD ---- 6
 	 * PIRQE ---- 9
 	 * PIRQF ---- 10
 	 * PIRQG ---- 11
 	 * PIRQH ---- 12
-	 *
-	 * interrupts for PCI slot0 -- PIRQA / PIRQB / PIRQC / PIRQD
-	 *                PCI slot1 -- PIRQB / PIRQC / PIRQD / PIRQA
 	 */
-	pci_write_config_dword(dev, 0x48, 0xb9317542);
+	for (i = 0; i < 4; i++) irq2pin[i + 9] = PIRQE + i;
+
+	/* Set IRQ-PIRQ Mapping to ULI1575 */
+	for (i = 0; i < 16; i++)
+		if (irq2pin[i])
+			pirq_map_word |= (uli1575_irq_route_table[i] & 0xf)
+				<< ((irq2pin[i] - PIRQA) * 4);
 
-	/* USB 1.1 OHCI controller 1, interrupt: PIRQE */
-	pci_write_config_byte(dev, 0x86, 0x0c);
+	/* ULI1575 IRQ mapping conf register default value is 0xb9317542 */
+	DBG("Setup ULI1575 IRQ mapping configuration register value = 0x%x\n",
+			pirq_map_word);
+	pci_write_config_dword(dev, 0x48, pirq_map_word);
 
-	/* USB 1.1 OHCI controller 2, interrupt: PIRQF */
-	pci_write_config_byte(dev, 0x87, 0x0d);
+#define ULI1575_SET_DEV_IRQ(slot, pin, reg) 				\
+	do { 								\
+		int irq; 						\
+		irq = get_pci_irq_from_of(hose, slot, pin); 		\
+		if (irq > 0 && irq < 16) 				\
+			pci_write_config_byte(dev, reg, irq2pin[irq]); 	\
+		else							\
+			printk(KERN_WARNING "ULI1575 device"		\
+			    "(slot %d, pin %d) irq %d is invalid.\n",	\
+			    slot, pin, irq);				\
+	} while(0)
 
-	/* USB 1.1 OHCI controller 3, interrupt: PIRQH */
-	pci_write_config_byte(dev, 0x88, 0x0f);
+	/* USB 1.1 OHCI controller 1, slot 28, pin 1 */
+	ULI1575_SET_DEV_IRQ(28, 1, 0x86);
 
-	/* USB 2.0 controller, interrupt: PIRQ7 */
-	pci_write_config_byte(dev, 0x74, 0x06);
+	/* USB 1.1 OHCI controller 2, slot 28, pin 2 */
+	ULI1575_SET_DEV_IRQ(28, 2, 0x87);
 
-	/* Audio controller, interrupt: PIRQE */
-	pci_write_config_byte(dev, 0x8a, 0x0c);
+	/* USB 1.1 OHCI controller 3, slot 28, pin 3 */
+	ULI1575_SET_DEV_IRQ(28, 3, 0x88);
 
-	/* Modem controller, interrupt: PIRQF */
-	pci_write_config_byte(dev, 0x8b, 0x0d);
+	/* USB 2.0 controller, slot 28, pin 4 */
+	irq = get_pci_irq_from_of(hose, 28, 4);
+	if (irq >= 0 && irq <=15)
+		pci_write_config_dword(dev, 0x74, uli1575_irq_route_table[irq]);
 
-	/* HD audio controller, interrupt: PIRQG */
-	pci_write_config_byte(dev, 0x8c, 0x0e);
+	/* Audio controller, slot 29, pin 1 */
+	ULI1575_SET_DEV_IRQ(29, 1, 0x8a);
 
-	/* Serial ATA interrupt: PIRQD */
-	pci_write_config_byte(dev, 0x8d, 0x0b);
+	/* Modem controller, slot 29, pin 2 */
+	ULI1575_SET_DEV_IRQ(29, 2, 0x8b);
 
-	/* SMB interrupt: PIRQH */
-	pci_write_config_byte(dev, 0x8e, 0x0f);
+	/* HD audio controller, slot 29, pin 3 */
+	ULI1575_SET_DEV_IRQ(29, 3, 0x8c);
 
-	/* PMU ACPI SCI interrupt: PIRQH */
-	pci_write_config_byte(dev, 0x8f, 0x0f);
+	/* SMB interrupt: slot 30, pin 1 */
+	ULI1575_SET_DEV_IRQ(30, 1, 0x8e);
+
+	/* PMU ACPI SCI interrupt: slot 30, pin 2 */
+	ULI1575_SET_DEV_IRQ(30, 2, 0x8f);
+
+	/* Serial ATA interrupt: slot 31, pin 1 */
+	ULI1575_SET_DEV_IRQ(31, 1, 0x8d);
 
 	/* Primary PATA IDE IRQ: 14
 	 * Secondary PATA IDE IRQ: 15
 	 */
-	pci_write_config_byte(dev, 0x44, 0x3d);
-	pci_write_config_byte(dev, 0x75, 0x0f);
+	pci_write_config_byte(dev, 0x44, 0x30 | uli1575_irq_route_table[14]);
+	pci_write_config_byte(dev, 0x75, uli1575_irq_route_table[15]);
 
 	/* Set IRQ14 and IRQ15 to legacy IRQs */
 	pci_read_config_word(dev, 0x46, &temp);
@@ -264,6 +282,8 @@ static void __devinit quirk_ali1575(stru
 	 */
 	outb(0xfa, 0x4d0);
 	outb(0x1e, 0x4d1);
+
+#undef ULI1575_SET_DEV_IRQ
 }
 
 static void __devinit quirk_uli5288(struct pci_dev *dev)
@@ -306,7 +326,7 @@ static void __devinit early_uli5249(stru
 	dev->class |= 0x1;
 }
 
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_ali1575);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
@@ -337,8 +357,6 @@ #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		add_bridge(np);
 
-	ppc_md.pci_swizzle = common_swizzle;
-	ppc_md.pci_map_irq = mpc86xx_map_irq;
 	ppc_md.pci_exclude_device = mpc86xx_exclude_device;
 #endif
 
@@ -377,6 +395,15 @@ mpc86xx_hpcn_show_cpuinfo(struct seq_fil
 }
 
 
+void __init mpc86xx_hpcn_pcibios_fixup(void)
+{
+	struct pci_dev *dev = NULL;
+
+	for_each_pci_dev(dev)
+		pci_read_irq_line(dev);
+}
+
+
 /*
  * Called very early, device-tree isn't unflattened
  */
@@ -431,6 +458,7 @@ define_machine(mpc86xx_hpcn) {
 	.setup_arch		= mpc86xx_hpcn_setup_arch,
 	.init_IRQ		= mpc86xx_hpcn_init_irq,
 	.show_cpuinfo		= mpc86xx_hpcn_show_cpuinfo,
+	.pcibios_fixup		= mpc86xx_hpcn_pcibios_fixup,
 	.get_irq		= mpic_get_irq,
 	.restart		= mpc86xx_restart,
 	.time_init		= mpc86xx_time_init,
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 12b6560..ef10bcf 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -85,11 +85,8 @@ static int __init gfar_mdio_of_init(void
 			mdio_data.irq[k] = -1;
 
 		while ((child = of_get_next_child(np, child)) != NULL) {
-			if (child->n_intrs) {
-				u32 *id =
-				    (u32 *) get_property(child, "reg", NULL);
-				mdio_data.irq[*id] = child->intrs[0].line;
-			}
+			u32 *id = get_property(child, "reg", NULL);
+			mdio_data.irq[*id] = irq_of_parse_and_map(child, 0);
 		}
 
 		ret =
@@ -131,6 +128,7 @@ static int __init gfar_of_init(void)
 		char *model;
 		void *mac_addr;
 		phandle *ph;
+		int n_res = 1;
 
 		memset(r, 0, sizeof(r));
 		memset(&gfar_data, 0, sizeof(gfar_data));
@@ -139,8 +137,7 @@ static int __init gfar_of_init(void)
 		if (ret)
 			goto err;
 
-		r[1].start = np->intrs[0].line;
-		r[1].end = np->intrs[0].line;
+		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
 		r[1].flags = IORESOURCE_IRQ;
 
 		model = get_property(np, "model", NULL);
@@ -150,19 +147,19 @@ static int __init gfar_of_init(void)
 			r[1].name = gfar_tx_intr;
 
 			r[2].name = gfar_rx_intr;
-			r[2].start = np->intrs[1].line;
-			r[2].end = np->intrs[1].line;
+			r[2].start = r[2].end = irq_of_parse_and_map(np, 1);
 			r[2].flags = IORESOURCE_IRQ;
 
 			r[3].name = gfar_err_intr;
-			r[3].start = np->intrs[2].line;
-			r[3].end = np->intrs[2].line;
+			r[3].start = r[3].end = irq_of_parse_and_map(np, 2);
 			r[3].flags = IORESOURCE_IRQ;
+
+			n_res += 2;
 		}
 
 		gfar_dev =
 		    platform_device_register_simple("fsl-gianfar", i, &r[0],
-						    np->n_intrs + 1);
+						    n_res + 1);
 
 		if (IS_ERR(gfar_dev)) {
 			ret = PTR_ERR(gfar_dev);
@@ -259,8 +256,7 @@ static int __init fsl_i2c_of_init(void)
 		if (ret)
 			goto err;
 
-		r[1].start = np->intrs[0].line;
-		r[1].end = np->intrs[0].line;
+		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
 		r[1].flags = IORESOURCE_IRQ;
 
 		i2c_dev = platform_device_register_simple("fsl-i2c", i, r, 2);
@@ -396,8 +392,7 @@ static int __init fsl_usb_of_init(void)
 		if (ret)
 			goto err;
 
-		r[1].start = np->intrs[0].line;
-		r[1].end = np->intrs[0].line;
+		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
 		r[1].flags = IORESOURCE_IRQ;
 
 		usb_dev_mph =
@@ -445,8 +440,7 @@ static int __init fsl_usb_of_init(void)
 		if (ret)
 			goto unreg_mph;
 
-		r[1].start = np->intrs[0].line;
-		r[1].end = np->intrs[0].line;
+		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
 		r[1].flags = IORESOURCE_IRQ;
 
 		usb_dev_dr =
-- 
2006_06_07.01.gittree_pull-dirty
