Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 06F84DE0C5
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 00:20:50 +1000 (EST)
Date: Thu, 8 May 2008 18:20:48 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/3] [POWERPC] turn fsl_uli1575 into PCI fixups library
Message-ID: <20080508142048.GB7172@polina.dev.rtsoft.ru>
References: <20080508142005.GA6749@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080508142005.GA6749@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With this patch we can choose which ULI fixups we want to apply
for the specific boards.

There are no changes to the fixups them selfs.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   |   11 ++-
 arch/powerpc/platforms/86xx/Kconfig        |    1 +
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |   90 ++-----------------------
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   12 ++-
 arch/powerpc/platforms/fsl_uli1575.c       |  100 ++++++++++++++++++++++++----
 include/asm-powerpc/fsl_uli1575.h          |   36 ++++++++++
 6 files changed, 145 insertions(+), 105 deletions(-)
 create mode 100644 include/asm-powerpc/fsl_uli1575.h

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index dfd8b4a..961a6d7 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -29,6 +29,7 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
+#include <asm/fsl_uli1575.h>
 #include <asm/i8259.h>
 
 #include <sysdev/fsl_soc.h>
@@ -114,9 +115,6 @@ void __init mpc85xx_ds_pic_init(void)
 
 #ifdef CONFIG_PCI
 static int primary_phb_addr;
-extern int uses_fsl_uli_m1575;
-extern int uli_exclude_device(struct pci_controller *hose,
-				u_char bus, u_char devfn);
 
 static int mpc85xx_exclude_device(struct pci_controller *hose,
 				   u_char bus, u_char devfn)
@@ -133,6 +131,13 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 
 	return PCIBIOS_SUCCESSFUL;
 }
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5249, quirk_final_uli5249);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x1575, quirk_final_uli1575);
 #endif	/* CONFIG_PCI */
 
 /*
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 053f49a..39c02af 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -21,6 +21,7 @@ config SBC8641D
 config MPC8610_HPCD
 	bool "Freescale MPC8610 HPCD"
 	select DEFAULT_UIMAGE
+	select FSL_ULI1575
 	help
 	  This option enables support for the MPC8610 HPCD board.
 
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index e415353..2fa672b 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -34,6 +34,7 @@
 #include <asm/udbg.h>
 
 #include <asm/mpic.h>
+#include <asm/fsl_uli1575.h>
 
 #include <linux/of_platform.h>
 #include <sysdev/fsl_pci.h>
@@ -224,93 +225,12 @@ static void __init mpc86xx_hpcd_init_irq(void)
 }
 
 #ifdef CONFIG_PCI
-static void __devinit quirk_uli1575(struct pci_dev *dev)
-{
-	u32 temp32;
-
-	/* Disable INTx */
-	pci_read_config_dword(dev, 0x48, &temp32);
-	pci_write_config_dword(dev, 0x48, (temp32 | 1<<26));
-
-	/* Enable sideband interrupt */
-	pci_read_config_dword(dev, 0x90, &temp32);
-	pci_write_config_dword(dev, 0x90, (temp32 | 1<<22));
-}
-
-static void __devinit quirk_uli5288(struct pci_dev *dev)
-{
-	unsigned char c;
-	unsigned short temp;
-
-	/* Interrupt Disable, Needed when SATA disabled */
-	pci_read_config_word(dev, PCI_COMMAND, &temp);
-	temp |= 1<<10;
-	pci_write_config_word(dev, PCI_COMMAND, temp);
-
-	pci_read_config_byte(dev, 0x83, &c);
-	c |= 0x80;
-	pci_write_config_byte(dev, 0x83, c);
-
-	pci_write_config_byte(dev, PCI_CLASS_PROG, 0x01);
-	pci_write_config_byte(dev, PCI_CLASS_DEVICE, 0x06);
-
-	pci_read_config_byte(dev, 0x83, &c);
-	c &= 0x7f;
-	pci_write_config_byte(dev, 0x83, c);
-}
-
-/*
- * Since 8259PIC was disabled on the board, the IDE device can not
- * use the legacy IRQ, we need to let the IDE device work under
- * native mode and use the interrupt line like other PCI devices.
- * IRQ14 is a sideband interrupt from IDE device to CPU and we use this
- * as the interrupt for IDE device.
- */
-static void __devinit quirk_uli5229(struct pci_dev *dev)
-{
-	unsigned char c;
-
-	pci_read_config_byte(dev, 0x4b, &c);
-	c |= 0x10;
-	pci_write_config_byte(dev, 0x4b, c);
-}
-
-/*
- * SATA interrupt pin bug fix
- * There's a chip bug for 5288, The interrupt pin should be 2,
- * not the read only value 1, So it use INTB#, not INTA# which
- * actually used by the IDE device 5229.
- * As of this bug, during the PCI initialization, 5288 read the
- * irq of IDE device from the device tree, this function fix this
- * bug by re-assigning a correct irq to 5288.
- *
- */
-static void __devinit final_uli5288(struct pci_dev *dev)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	struct device_node *hosenode = hose ? hose->dn : NULL;
-	struct of_irq oirq;
-	int virq, pin = 2;
-	u32 laddr[3];
-
-	if (!hosenode)
-		return;
-
-	laddr[0] = (hose->first_busno << 16) | (PCI_DEVFN(31, 0) << 8);
-	laddr[1] = laddr[2] = 0;
-	of_irq_map_raw(hosenode, &pin, 1, laddr, &oirq);
-	virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
-				     oirq.size);
-	dev->irq = virq;
-}
-
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5288, final_uli5288);
+MACH_PCI_FIXUP_HEADER(mpc86xx_hpcd, PCI_VENDOR_ID_AL, 0x1575, hpcd_quirk_uli1575);
+MACH_PCI_FIXUP_HEADER(mpc86xx_hpcd, PCI_VENDOR_ID_AL, 0x5288, hpcd_quirk_uli5288);
+MACH_PCI_FIXUP_HEADER(mpc86xx_hpcd, PCI_VENDOR_ID_AL, 0x5229, hpcd_quirk_uli5229);
+MACH_PCI_FIXUP_FINAL(mpc86xx_hpcd, PCI_VENDOR_ID_AL, 0x5288, hpcd_final_uli5288);
 #endif /* CONFIG_PCI */
 
-
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 
 static u32 get_busfreq(void)
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index f13704a..4e1ee2e 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -29,6 +29,7 @@
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
 #include <asm/i8259.h>
+#include <asm/fsl_uli1575.h>
 
 #include <asm/mpic.h>
 
@@ -107,10 +108,6 @@ mpc86xx_hpcn_init_irq(void)
 }
 
 #ifdef CONFIG_PCI
-extern int uses_fsl_uli_m1575;
-extern int uli_exclude_device(struct pci_controller *hose,
-				u_char bus, u_char devfn);
-
 static int mpc86xx_exclude_device(struct pci_controller *hose,
 				   u_char bus, u_char devfn)
 {
@@ -126,6 +123,13 @@ static int mpc86xx_exclude_device(struct pci_controller *hose,
 
 	return PCIBIOS_SUCCESSFUL;
 }
+
+MACH_PCI_FIXUP_EARLY(mpc86xx_hpcn, PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
+MACH_PCI_FIXUP_HEADER(mpc86xx_hpcn, PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
+MACH_PCI_FIXUP_HEADER(mpc86xx_hpcn, PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
+MACH_PCI_FIXUP_HEADER(mpc86xx_hpcn, PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
+MACH_PCI_FIXUP_FINAL(mpc86xx_hpcn, PCI_VENDOR_ID_AL, 0x5249, quirk_final_uli5249);
+MACH_PCI_FIXUP_FINAL(mpc86xx_hpcn, PCI_VENDOR_ID_AL, 0x1575, quirk_final_uli1575);
 #endif /* CONFIG_PCI */
 
 
diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index afc9141..63ea4eb 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -17,6 +17,7 @@
 
 #include <asm/system.h>
 #include <asm/pci-bridge.h>
+#include <asm/fsl_uli1575.h>
 
 #define ULI_PIRQA	0x08
 #define ULI_PIRQB	0x09
@@ -55,7 +56,7 @@ u8 uli_pirq_to_irq[8] = {
 int uses_fsl_uli_m1575;
 
 /* Bridge */
-static void __devinit early_uli5249(struct pci_dev *dev)
+void __devinit early_uli5249(struct pci_dev *dev)
 {
 	unsigned char temp;
 
@@ -77,8 +78,7 @@ static void __devinit early_uli5249(struct pci_dev *dev)
 	pci_write_config_byte(dev, 0x7c, temp);
 }
 
-
-static void __devinit quirk_uli1575(struct pci_dev *dev)
+void __devinit quirk_uli1575(struct pci_dev *dev)
 {
 	int i;
 
@@ -135,7 +135,7 @@ static void __devinit quirk_uli1575(struct pci_dev *dev)
 	pci_write_config_byte(dev, 0x75, ULI_8259_IRQ15);
 }
 
-static void __devinit quirk_final_uli1575(struct pci_dev *dev)
+void __devinit quirk_final_uli1575(struct pci_dev *dev)
 {
 	/* Set i8259 interrupt trigger
 	 * IRQ 3:  Level
@@ -171,7 +171,7 @@ static void __devinit quirk_final_uli1575(struct pci_dev *dev)
 }
 
 /* SATA */
-static void __devinit quirk_uli5288(struct pci_dev *dev)
+void __devinit quirk_uli5288(struct pci_dev *dev)
 {
 	unsigned char c;
 	unsigned int d;
@@ -196,7 +196,7 @@ static void __devinit quirk_uli5288(struct pci_dev *dev)
 }
 
 /* PATA */
-static void __devinit quirk_uli5229(struct pci_dev *dev)
+void __devinit quirk_uli5229(struct pci_dev *dev)
 {
 	unsigned short temp;
 
@@ -212,7 +212,7 @@ static void __devinit quirk_uli5229(struct pci_dev *dev)
 }
 
 /* We have to do a dummy read on the P2P for the RTC to work, WTF */
-static void __devinit quirk_final_uli5249(struct pci_dev *dev)
+void __devinit quirk_final_uli5249(struct pci_dev *dev)
 {
 	int i;
 	u8 *dummy;
@@ -231,12 +231,86 @@ static void __devinit quirk_final_uli5249(struct pci_dev *dev)
 	}
 }
 
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5249, quirk_final_uli5249);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x1575, quirk_final_uli1575);
+
+void __devinit hpcd_quirk_uli1575(struct pci_dev *dev)
+{
+	u32 temp32;
+
+	/* Disable INTx */
+	pci_read_config_dword(dev, 0x48, &temp32);
+	pci_write_config_dword(dev, 0x48, (temp32 | 1<<26));
+
+	/* Enable sideband interrupt */
+	pci_read_config_dword(dev, 0x90, &temp32);
+	pci_write_config_dword(dev, 0x90, (temp32 | 1<<22));
+}
+
+void __devinit hpcd_quirk_uli5288(struct pci_dev *dev)
+{
+	unsigned char c;
+	unsigned short temp;
+
+	/* Interrupt Disable, Needed when SATA disabled */
+	pci_read_config_word(dev, PCI_COMMAND, &temp);
+	temp |= 1<<10;
+	pci_write_config_word(dev, PCI_COMMAND, temp);
+
+	pci_read_config_byte(dev, 0x83, &c);
+	c |= 0x80;
+	pci_write_config_byte(dev, 0x83, c);
+
+	pci_write_config_byte(dev, PCI_CLASS_PROG, 0x01);
+	pci_write_config_byte(dev, PCI_CLASS_DEVICE, 0x06);
+
+	pci_read_config_byte(dev, 0x83, &c);
+	c &= 0x7f;
+	pci_write_config_byte(dev, 0x83, c);
+}
+
+/*
+ * Since 8259PIC was disabled on the board, the IDE device can not
+ * use the legacy IRQ, we need to let the IDE device work under
+ * native mode and use the interrupt line like other PCI devices.
+ * IRQ14 is a sideband interrupt from IDE device to CPU and we use this
+ * as the interrupt for IDE device.
+ */
+void __devinit hpcd_quirk_uli5229(struct pci_dev *dev)
+{
+	unsigned char c;
+
+	pci_read_config_byte(dev, 0x4b, &c);
+	c |= 0x10;
+	pci_write_config_byte(dev, 0x4b, c);
+}
+
+/*
+ * SATA interrupt pin bug fix
+ * There's a chip bug for 5288, The interrupt pin should be 2,
+ * not the read only value 1, So it use INTB#, not INTA# which
+ * actually used by the IDE device 5229.
+ * As of this bug, during the PCI initialization, 5288 read the
+ * irq of IDE device from the device tree, this function fix this
+ * bug by re-assigning a correct irq to 5288.
+ *
+ */
+void __devinit hpcd_final_uli5288(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct device_node *hosenode = hose ? hose->dn : NULL;
+	struct of_irq oirq;
+	int virq, pin = 2;
+	u32 laddr[3];
+
+	if (!hosenode)
+		return;
+
+	laddr[0] = (hose->first_busno << 16) | (PCI_DEVFN(31, 0) << 8);
+	laddr[1] = laddr[2] = 0;
+	of_irq_map_raw(hosenode, &pin, 1, laddr, &oirq);
+	virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
+				     oirq.size);
+	dev->irq = virq;
+}
 
 int uli_exclude_device(struct pci_controller *hose,
 			u_char bus, u_char devfn)
diff --git a/include/asm-powerpc/fsl_uli1575.h b/include/asm-powerpc/fsl_uli1575.h
new file mode 100644
index 0000000..9755c5c
--- /dev/null
+++ b/include/asm-powerpc/fsl_uli1575.h
@@ -0,0 +1,36 @@
+/*
+ * ULI M1575 setup code - specific to Freescale boards
+ *
+ * Copyright (c) 2007 Freescale Semiconductor Inc.
+ * Copyright (c) 2008 MontaVista Software, Inc.
+ *                    Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_POWERPC_FSL_ULI1575_H
+#define __ASM_POWERPC_FSL_ULI1575_H
+
+struct pci_controller;
+struct pci_dev;
+
+extern int uses_fsl_uli_m1575;
+extern int uli_exclude_device(struct pci_controller *hose,
+			      u_char bus, u_char devfn);
+
+extern void __devinit early_uli5249(struct pci_dev *dev);
+extern void __devinit quirk_uli1575(struct pci_dev *dev);
+extern void __devinit quirk_final_uli1575(struct pci_dev *dev);
+extern void __devinit quirk_uli5288(struct pci_dev *dev);
+extern void __devinit quirk_uli5229(struct pci_dev *dev);
+extern void __devinit quirk_final_uli5249(struct pci_dev *dev);
+
+extern void __devinit hpcd_quirk_uli1575(struct pci_dev *dev);
+extern void __devinit hpcd_quirk_uli5288(struct pci_dev *dev);
+extern void __devinit hpcd_quirk_uli5229(struct pci_dev *dev);
+extern void __devinit hpcd_final_uli5288(struct pci_dev *dev);
+
+#endif /* __ASM_POWERPC_FSL_ULI1575_H */
-- 
1.5.5.1
