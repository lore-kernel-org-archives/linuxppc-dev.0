Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A652BDDEE3
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 09:04:18 +1000 (EST)
Date: Thu, 12 Jun 2008 03:04:17 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/4] powerpc/85xx/86xx: some refactoring for fsl_uli1575 code
Message-ID: <20080611230417.GB21351@polina.dev.rtsoft.ru>
References: <20080611230250.GA13412@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080611230250.GA13412@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

- Get rid of uses_fsl_uli_m1575, it does not scale for all cases.
  Instead, let's explicitly use machine_is() for each fixup.
- Factor out MPC8610HPCD quirks to fsl_uli1575, and protect them with
  machine_is(). One step closer to multiplatform kernels.
- Actually use fsl_uli1575 on MPC8610HPCD, so RTC quirk will be applied.
- RTC quirk applies to all boards though, so no machine_is() checks.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   |    2 -
 arch/powerpc/platforms/86xx/Kconfig        |    1 +
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |   87 ---------------------
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 -
 arch/powerpc/platforms/fsl_uli1575.c       |  115 ++++++++++++++++++++++++++--
 5 files changed, 108 insertions(+), 99 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index b010dc9..f21e7a6 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -115,7 +115,6 @@ void __init mpc85xx_ds_pic_init(void)
 
 #ifdef CONFIG_PCI
 static int primary_phb_addr;
-extern int uses_fsl_uli_m1575;
 extern int uli_exclude_device(struct pci_controller *hose,
 				u_char bus, u_char devfn);
 
@@ -161,7 +160,6 @@ static void __init mpc85xx_ds_setup_arch(void)
 		}
 	}
 
-	uses_fsl_uli_m1575 = 1;
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 
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
index eb16208..539a6ad 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -78,93 +78,6 @@ static void __init mpc86xx_hpcd_init_irq(void)
 	mpic_init(mpic1);
 }
 
-#ifdef CONFIG_PCI
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
-#endif /* CONFIG_PCI */
-
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 
 static u32 get_busfreq(void)
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index f13704a..22ce0f3 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -107,7 +107,6 @@ mpc86xx_hpcn_init_irq(void)
 }
 
 #ifdef CONFIG_PCI
-extern int uses_fsl_uli_m1575;
 extern int uli_exclude_device(struct pci_controller *hose,
 				u_char bus, u_char devfn);
 
@@ -149,7 +148,6 @@ mpc86xx_hpcn_setup_arch(void)
 			fsl_add_bridge(np, 0);
 	}
 
-	uses_fsl_uli_m1575 = 1;
 	ppc_md.pci_exclude_device = mpc86xx_exclude_device;
 
 #endif
diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index 756561c..ef74a07 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -51,15 +51,13 @@ u8 uli_pirq_to_irq[8] = {
 	ULI_8259_NONE,		/* PIRQH */
 };
 
-/* set in board code if you want this quirks to do something */
-int uses_fsl_uli_m1575;
-
 /* Bridge */
 static void __devinit early_uli5249(struct pci_dev *dev)
 {
 	unsigned char temp;
 
-	if (!uses_fsl_uli_m1575)
+	if (!machine_is(mpc86xx_hpcn) && !machine_is(mpc8544_ds) &&
+			!machine_is(mpc8572_ds))
 		return;
 
 	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_IO |
@@ -82,7 +80,8 @@ static void __devinit quirk_uli1575(struct pci_dev *dev)
 {
 	int i;
 
-	if (!uses_fsl_uli_m1575)
+	if (!machine_is(mpc86xx_hpcn) && !machine_is(mpc8544_ds) &&
+			!machine_is(mpc8572_ds))
 		return;
 
 	/*
@@ -150,7 +149,8 @@ static void __devinit quirk_final_uli1575(struct pci_dev *dev)
 	 * IRQ 14: Edge
 	 * IRQ 15: Edge
 	 */
-	if (!uses_fsl_uli_m1575)
+	if (!machine_is(mpc86xx_hpcn) && !machine_is(mpc8544_ds) &&
+			!machine_is(mpc8572_ds))
 		return;
 
 	outb(0xfa, 0x4d0);
@@ -176,7 +176,8 @@ static void __devinit quirk_uli5288(struct pci_dev *dev)
 	unsigned char c;
 	unsigned int d;
 
-	if (!uses_fsl_uli_m1575)
+	if (!machine_is(mpc86xx_hpcn) && !machine_is(mpc8544_ds) &&
+			!machine_is(mpc8572_ds))
 		return;
 
 	/* read/write lock */
@@ -200,7 +201,8 @@ static void __devinit quirk_uli5229(struct pci_dev *dev)
 {
 	unsigned short temp;
 
-	if (!uses_fsl_uli_m1575)
+	if (!machine_is(mpc86xx_hpcn) && !machine_is(mpc8544_ds) &&
+			!machine_is(mpc8572_ds))
 		return;
 
 	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE |
@@ -238,6 +240,103 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5249, quirk_final_uli5249);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x1575, quirk_final_uli1575);
 
+static void __devinit hpcd_quirk_uli1575(struct pci_dev *dev)
+{
+	u32 temp32;
+
+	if (!machine_is(mpc86xx_hpcd))
+		return;
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
+static void __devinit hpcd_quirk_uli5288(struct pci_dev *dev)
+{
+	unsigned char c;
+	unsigned short temp;
+
+	if (!machine_is(mpc86xx_hpcd))
+		return;
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
+static void __devinit hpcd_quirk_uli5229(struct pci_dev *dev)
+{
+	unsigned char c;
+
+	if (!machine_is(mpc86xx_hpcd))
+		return;
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
+static void __devinit hpcd_final_uli5288(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct device_node *hosenode = hose ? hose->dn : NULL;
+	struct of_irq oirq;
+	int virq, pin = 2;
+	u32 laddr[3];
+
+	if (!machine_is(mpc86xx_hpcd))
+		return;
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
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, hpcd_quirk_uli1575);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, hpcd_quirk_uli5288);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, hpcd_quirk_uli5229);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5288, hpcd_final_uli5288);
+
 int uli_exclude_device(struct pci_controller *hose,
 			u_char bus, u_char devfn)
 {
-- 
1.5.5.4
