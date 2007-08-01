Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4EA2BDDEE1
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 18:06:19 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l7186CrV010307
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Aug 2007 01:06:13 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l718671N021205
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Aug 2007 03:06:12 -0500 (CDT)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org, galak@kernel.crashing.org
Subject: [PATCH 2/2] Remove ULI chip quirks functions from MPC8641HPCN and
	MPC8544DS boards.
Date: Wed,  1 Aug 2007 16:14:28 +0800
Message-Id: <11859560704050-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11859560694083-git-send-email-wei.zhang@freescale.com>
References: <11859560681182-git-send-email-wei.zhang@freescale.com>
	<11859560694083-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove ULI chip quirks functions from MPC8641HPCN and MPC8544DS boards.
Use common quirks functions instead.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/platforms/85xx/Kconfig        |    1 +
 arch/powerpc/platforms/85xx/mpc8544_ds.c   |  207 --------------------------
 arch/powerpc/platforms/86xx/Kconfig        |    1 +
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |  217 ----------------------------
 4 files changed, 2 insertions(+), 424 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index f581840..34306a7 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -32,6 +32,7 @@ config MPC85xx_MDS
 config MPC8544_DS
 	bool "Freescale MPC8544 DS"
 	select PPC_I8259
+	select PPC_PCI_QUIRKS
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC8544 DS board
diff --git a/arch/powerpc/platforms/85xx/mpc8544_ds.c b/arch/powerpc/platforms/85xx/mpc8544_ds.c
index 4905f6f..9b9a1f1 100644
--- a/arch/powerpc/platforms/85xx/mpc8544_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8544_ds.c
@@ -113,213 +113,6 @@ void __init mpc8544_ds_pic_init(void)
 #endif	/* CONFIG_PPC_I8259 */
 }
 
-#ifdef CONFIG_PCI
-enum pirq { PIRQA = 8, PIRQB, PIRQC, PIRQD, PIRQE, PIRQF, PIRQG, PIRQH };
-
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
-{
-	unsigned char c;
-
-	pci_read_config_byte(dev, 0x83, &c);
-	c |= 0x80;		/* read/write lock */
-	pci_write_config_byte(dev, 0x83, c);
-
-	pci_write_config_byte(dev, 0x09, 0x01);	/* Base class code: storage */
-	pci_write_config_byte(dev, 0x0a, 0x06);	/* IDE disk */
-
-	pci_read_config_byte(dev, 0x83, &c);
-	c &= 0x7f;
-	pci_write_config_byte(dev, 0x83, c);
-
-	pci_read_config_byte(dev, 0x84, &c);
-	c |= 0x01;				/* emulated PATA mode enabled */
-	pci_write_config_byte(dev, 0x84, c);
-}
-
-/* PATA */
-static void __devinit quirk_uli5229(struct pci_dev *dev)
-{
-	unsigned short temp;
-	pci_write_config_word(dev, 0x04, 0x0405);	/* MEM IO MSI */
-	pci_read_config_word(dev, 0x4a, &temp);
-	temp |= 0x1000;				/* Enable Native IRQ 14/15 */
-	pci_write_config_word(dev, 0x4a, temp);
-}
-
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
-}
-
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
-#endif	/* CONFIG_PCI */
 
 /*
  * Setup the architecture
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 343b76d..9cebfc6 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -6,6 +6,7 @@ choice
 config MPC8641_HPCN
 	bool "Freescale MPC8641 HPCN"
 	select PPC_I8259
+	select PPC_PCI_QUIRKS
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC8641 HPCN board.
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index e9eaa07..b958f0e 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -106,223 +106,6 @@ mpc86xx_hpcn_init_irq(void)
 #endif
 }
 
-#ifdef CONFIG_PCI
-
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
-{
-	unsigned char c;
-
-	pci_read_config_byte(dev,0x83,&c);
-	c |= 0x80;
-	pci_write_config_byte(dev, 0x83, c);
-
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
-
-static void __devinit early_uli5249(struct pci_dev *dev)
-{
-	unsigned char temp;
-	pci_write_config_word(dev, 0x04, 0x0007);
-	pci_read_config_byte(dev, 0x7c, &temp);
-	pci_write_config_byte(dev, 0x7c, 0x80);
-	pci_write_config_byte(dev, 0x09, 0x01);
-	pci_write_config_byte(dev, 0x7c, temp);
-	dev->class |= 0x1;
-}
-
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
-#endif /* CONFIG_PCI */
-
 
 static void __init
 mpc86xx_hpcn_setup_arch(void)
-- 
1.5.1
