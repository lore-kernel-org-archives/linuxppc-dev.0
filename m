Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE8A3DDE4A
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:51:20 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 21/25] [POWERPC] 85xxCDS: Delay 8259 cascade hookup.
Date: Mon, 23 Jul 2007 15:50:08 -0500
Message-Id: <11852238432011-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11852238421611-git-send-email-galak@kernel.crashing.org>
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
	<11852238411823-git-send-email-galak@kernel.crashing.org>
	<11852238421611-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Randy Vinson <rvinson@mvista.com>

The interrupts of an E100 card inserted in PCI slot 4 may be on at bootup.
The resulting interrupt flood interacts with the 8259 cascade handler and
prevents proper boot up. There is a quirk for the E100 that will disable
the E100's interrupts but to use it, the 8259 cascade hookup must be
delayed until after the quirk has run. This patch delays the 8259 cascade
hookup by registering a device_initcall() which runs after the PCI quirk
for the E100.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   33 +++++++++++++++++++---------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index e77c869..902a61a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -183,10 +183,6 @@ static void __init mpc85xx_cds_pic_init(void)
 	struct mpic *mpic;
 	struct resource r;
 	struct device_node *np = NULL;
-#if defined(CONFIG_PPC_I8259) && defined(CONFIG_PCI)
-	struct device_node *cascade_node = NULL;
-	int cascade_irq;
-#endif
 
 	np = of_find_node_by_type(np, "open-pic");
 
@@ -210,8 +206,16 @@ static void __init mpc85xx_cds_pic_init(void)
 	of_node_put(np);
 
 	mpic_init(mpic);
+}
 
 #if defined(CONFIG_PPC_I8259) && defined(CONFIG_PCI)
+static int mpc85xx_cds_8259_attach(void)
+{
+	int ret;
+	struct device_node *np = NULL;
+	struct device_node *cascade_node = NULL;
+	int cascade_irq;
+
 	/* Initialize the i8259 controller */
 	for_each_node_by_type(np, "interrupt-controller")
 		if (of_device_is_compatible(np, "chrp,iic")) {
@@ -221,13 +225,13 @@ static void __init mpc85xx_cds_pic_init(void)
 
 	if (cascade_node == NULL) {
 		printk(KERN_DEBUG "Could not find i8259 PIC\n");
-		return;
+		return -ENODEV;
 	}
 
 	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
 	if (cascade_irq == NO_IRQ) {
 		printk(KERN_ERR "Failed to map cascade interrupt\n");
-		return;
+		return -ENXIO;
 	}
 
 	i8259_init(cascade_node, 0);
@@ -239,14 +243,21 @@ static void __init mpc85xx_cds_pic_init(void)
 	 *  disabled when the last user of the shared IRQ line frees their
 	 *  interrupt.
 	 */
-	if (setup_irq(cascade_irq, &mpc85xxcds_8259_irqaction))
+	if ((ret = setup_irq(cascade_irq, &mpc85xxcds_8259_irqaction))) {
 		printk(KERN_ERR "Failed to setup cascade interrupt\n");
-	else
-		/* Success. Connect our low-level cascade handler. */
-		set_irq_handler(cascade_irq, mpc85xx_8259_cascade_handler);
-#endif /* CONFIG_PPC_I8259 */
+		return ret;
+	}
+
+	/* Success. Connect our low-level cascade handler. */
+	set_irq_handler(cascade_irq, mpc85xx_8259_cascade_handler);
+
+	return 0;
 }
 
+device_initcall(mpc85xx_cds_8259_attach);
+
+#endif /* CONFIG_PPC_I8259 */
+
 /*
  * Setup the architecture
  */
-- 
1.5.2.2
