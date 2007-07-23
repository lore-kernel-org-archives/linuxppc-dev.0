Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BFF57DDE2C
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:51:18 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 19/25] [POWERPC] 85xxCDS: Allow 8259 cascade to share an MPIC
	interrupt line.
Date: Mon, 23 Jul 2007 15:50:06 -0500
Message-Id: <11852238411823-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11852238392809-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
	<11852238193371-git-send-email-galak@kernel.crashing.org>
	<1185223821183-git-send-email-galak@kernel.crashing.org>
	<11852238233066-git-send-email-galak@kernel.crashing.org>
	<11852238241475-git-send-email-galak@kernel.crashing.org>
	<11852238253550-git-send-email-galak@kernel.crashing.org>
	<11852238271141-git-send-email-galak@kernel.crashing.org>
	<11852238283648-git-send-email-galak@kernel.crashing.org>
	<1185223830411-git-send-email-galak@kernel.crashing.org>
	<11852238322319-git-send-email-galak@kernel.crashing.org>
	<11852238333649-git-send-email-galak@kernel.crashing.org>
	<11852238353292-git-send-email-galak@kernel.crashing.org>
	<11852238362041-git-send-email-galak@kernel.crashing.org>
	<11852238383453-git-send-email-galak@kernel.crashing.org>
	<11852238392809-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Randy Vinson <rvinson@mvista.com>

The Freescale MPC8555CDS and MPC8548CDS reference hardware has a legacy
8259 interrupt controller pair contained within a VIA VT82C686B Southbridge
on the main carrier board. The processor complex plugs into the carrier
card using a PCI slot which limits the available interrupts to the
INTA-INTD PCI interrupts. The output of the 8259 cascade pair is routed
through a gate array and connected to the PCI INTA interrupt line.
The normal interrupt chaining hook (set_irq_chained_handler) does
not allow sharing of the chained interrupt which prevents the
use of PCI INTA by PCI devices. This patch allows the 8259 cascade
pair to share their interrupt line with PCI devices.

NOTE: The addition of the .end routine for the MPIC is not strictly
necessary for this patch. It's there so this code will run from within
the threaded interrupt context used by the Real Time patch.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/Kconfig       |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   37 ++++++++++++++++++++++++----
 arch/powerpc/sysdev/mpic.c                |    1 +
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 99bb74d..f581840 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -18,6 +18,7 @@ config MPC8560_ADS
 config MPC85xx_CDS
 	bool "Freescale MPC85xx CDS"
 	select DEFAULT_UIMAGE
+	select PPC_I8259
 	help
 	  This option enables support for the MPC85xx CDS board
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 71200bd..81b7062 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -24,6 +24,7 @@
 #include <linux/seq_file.h>
 #include <linux/initrd.h>
 #include <linux/module.h>
+#include <linux/interrupt.h>
 #include <linux/fsl_devices.h>
 
 #include <asm/system.h>
@@ -119,16 +120,30 @@ DECLARE_PCI_FIXUP_EARLY(0x3fff, 0x1957, skip_fake_bridge);
 DECLARE_PCI_FIXUP_EARLY(0xff3f, 0x5719, skip_fake_bridge);
 
 #ifdef CONFIG_PPC_I8259
-#warning The i8259 PIC support is currently broken
-static void mpc85xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
+static void mpc85xx_8259_cascade_handler(unsigned int irq,
+					 struct irq_desc *desc)
 {
 	unsigned int cascade_irq = i8259_irq();
 
 	if (cascade_irq != NO_IRQ)
+		/* handle an interrupt from the 8259 */
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	/* check for any interrupts from the shared IRQ line */
+	handle_fasteoi_irq(irq, desc);
 }
+
+static irqreturn_t mpc85xx_8259_cascade_action(int irq, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
+static struct irqaction mpc85xxcds_8259_irqaction = {
+	.handler = mpc85xx_8259_cascade_action,
+	.flags = IRQF_SHARED,
+	.mask = CPU_MASK_NONE,
+	.name = "8259 cascade",
+};
 #endif /* PPC_I8259 */
 #endif /* CONFIG_PCI */
 
@@ -137,7 +152,7 @@ static void __init mpc85xx_cds_pic_init(void)
 	struct mpic *mpic;
 	struct resource r;
 	struct device_node *np = NULL;
-#ifdef CONFIG_PPC_I8259
+#if defined(CONFIG_PPC_I8259) && defined(CONFIG_PCI)
 	struct device_node *cascade_node = NULL;
 	int cascade_irq;
 #endif
@@ -165,7 +180,7 @@ static void __init mpc85xx_cds_pic_init(void)
 
 	mpic_init(mpic);
 
-#ifdef CONFIG_PPC_I8259
+#if defined(CONFIG_PPC_I8259) && defined(CONFIG_PCI)
 	/* Initialize the i8259 controller */
 	for_each_node_by_type(np, "interrupt-controller")
 		if (of_device_is_compatible(np, "chrp,iic")) {
@@ -187,7 +202,17 @@ static void __init mpc85xx_cds_pic_init(void)
 	i8259_init(cascade_node, 0);
 	of_node_put(cascade_node);
 
-	set_irq_chained_handler(cascade_irq, mpc85xx_8259_cascade);
+	/*
+	 *  Hook the interrupt to make sure desc->action is never NULL.
+	 *  This is required to ensure that the interrupt does not get
+	 *  disabled when the last user of the shared IRQ line frees their
+	 *  interrupt.
+	 */
+	if (setup_irq(cascade_irq, &mpc85xxcds_8259_irqaction))
+		printk(KERN_ERR "Failed to setup cascade interrupt\n");
+	else
+		/* Success. Connect our low-level cascade handler. */
+		set_irq_handler(cascade_irq, mpc85xx_8259_cascade_handler);
 #endif /* CONFIG_PPC_I8259 */
 }
 
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 74c64c0..17ece50 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -836,6 +836,7 @@ static struct irq_chip mpic_irq_chip = {
 	.mask		= mpic_mask_irq,
 	.unmask		= mpic_unmask_irq,
 	.eoi		= mpic_end_irq,
+	.end		= mpic_unmask_irq,
 	.set_type	= mpic_set_irq_type,
 };
 
-- 
1.5.2.2
