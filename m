Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id E7DE6DDF18
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 08:05:33 +1000 (EST)
Message-ID: <4671BBAA.40102@mvista.com>
Date: Thu, 14 Jun 2007 15:05:30 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [PATCH] 85xxCDS: Delay 8259 cascade hookup.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The interrupts of an E100 card inserted in PCI slot 4 may be on at bootup.
The resulting interrupt flood interacts with the 8259 cascade handler and
prevents proper boot up. There is a quirk for the E100 that will disable
the E100's interrupts but to use it, the 8259 cascade hookup must be
delayed until after the quirk has run. This patch delays the 8259 cascade
hookup by registering a device_initcall() which runs after the PCI quirk
for the E100.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
---
NOTE: This is a follow-up to my previous 8259 cascade patch. I
encountered this problem on the 8548CDS system I use for test.
I'm not sure it is an isolated incident or a common occurance. I'm
posting this patch in case it's common.
 
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   33 +++++++++++++++++++---------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index a8720bf..939285a 100644
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
 
@@ -231,8 +227,16 @@ static void __init mpc85xx_cds_pic_init(void)
 	mpic_assign_isu(mpic, 14, r.start + 0x10100);
 
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
@@ -242,13 +246,13 @@ static void __init mpc85xx_cds_pic_init(void)
 
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
@@ -260,14 +264,21 @@ static void __init mpc85xx_cds_pic_init(void)
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
1.5.0.GIT
