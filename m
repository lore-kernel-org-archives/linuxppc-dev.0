Return-Path: <afleming@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 2D2F067CC4
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 06:57:26 +1000 (EST)
Date: Mon, 16 Oct 2006 15:57:19 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH] Slight refactor of interrupt mapping for FSL parts
Message-ID: <Pine.LNX.4.61.0610161554580.6266@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Cleaned up interrupt mapping a little by adding a helper
  function which parses the irq out of the device-tree, and puts
  it into a resource.
* Changed the PHY Layer to use NO_IRQ instead of -1 for PHY_POLL.
  This means that polling will always be used if mapping the
  interrupt fails for any reason.
---
 arch/powerpc/sysdev/fsl_soc.c |   33 ++++++++++++++++-----------------
 include/linux/phy.h           |    2 +-
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index dbe92ae..aa24b51 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -146,7 +146,7 @@ static int __init gfar_mdio_of_init(void
 		}
 
 		for (k = 0; k < 32; k++)
-			mdio_data.irq[k] = -1;
+			mdio_data.irq[k] = NO_IRQ;
 
 		while ((child = of_get_next_child(np, child)) != NULL) {
 			int irq = irq_of_parse_and_map(child, 0);
@@ -177,6 +177,13 @@ static const char *gfar_tx_intr = "tx";
 static const char *gfar_rx_intr = "rx";
 static const char *gfar_err_intr = "error";
 
+
+void of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
+{
+	r->start = r->end = irq_of_parse_and_map(dev, index);
+	r->flags = IORESOURCE_IRQ;
+}
+
 static int __init gfar_of_init(void)
 {
 	struct device_node *np;
@@ -204,8 +211,7 @@ static int __init gfar_of_init(void)
 		if (ret)
 			goto err;
 
-		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
-		r[1].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[1]);
 
 		model = get_property(np, "model", NULL);
 
@@ -214,12 +220,10 @@ static int __init gfar_of_init(void)
 			r[1].name = gfar_tx_intr;
 
 			r[2].name = gfar_rx_intr;
-			r[2].start = r[2].end = irq_of_parse_and_map(np, 1);
-			r[2].flags = IORESOURCE_IRQ;
+			of_irq_to_resource(np, 1, &r[2]);
 
 			r[3].name = gfar_err_intr;
-			r[3].start = r[3].end = irq_of_parse_and_map(np, 2);
-			r[3].flags = IORESOURCE_IRQ;
+			of_irq_to_resource(np, 2, &r[3]);
 
 			n_res += 2;
 		}
@@ -323,8 +327,7 @@ static int __init fsl_i2c_of_init(void)
 		if (ret)
 			goto err;
 
-		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
-		r[1].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[1]);
 
 		i2c_dev = platform_device_register_simple("fsl-i2c", i, r, 2);
 		if (IS_ERR(i2c_dev)) {
@@ -459,8 +462,7 @@ static int __init fsl_usb_of_init(void)
 		if (ret)
 			goto err;
 
-		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
-		r[1].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[1]);
 
 		usb_dev_mph =
 		    platform_device_register_simple("fsl-ehci", i, r, 2);
@@ -507,8 +509,7 @@ static int __init fsl_usb_of_init(void)
 		if (ret)
 			goto unreg_mph;
 
-		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
-		r[1].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[1]);
 
 		usb_dev_dr =
 		    platform_device_register_simple("fsl-ehci", i, r, 2);
@@ -591,8 +592,7 @@ static int __init fs_enet_of_init(void)
 		r[2].name = fcc_regs_c;
 		fs_enet_data.fcc_regs_c = r[2].start;
 
-		r[3].start = r[3].end = irq_of_parse_and_map(np, 0);
-		r[3].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[3]);
 
 		fs_enet_dev =
 		    platform_device_register_simple("fsl-cpm-fcc", i, &r[0], 4);
@@ -754,8 +754,7 @@ static int __init cpm_uart_of_init(void)
 			goto err;
 		r[1].name = scc_pram;
 
-		r[2].start = r[2].end = irq_of_parse_and_map(np, 0);
-		r[2].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[2]);
 
 		cpm_uart_dev =
 		    platform_device_register_simple("fsl-cpm-scc:uart", i, &r[0], 3);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 9447a57..d7b3751 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -37,7 +37,7 @@ #define PHY_GBIT_FEATURES	(PHY_BASIC_FEA
  * or not desired for this PHY.  Set to PHY_IGNORE_INTERRUPT if
  * the attached driver handles the interrupt
  */
-#define PHY_POLL		-1
+#define PHY_POLL		NO_IRQ
 #define PHY_IGNORE_INTERRUPT	-2
 
 #define PHY_HAS_INTERRUPT	0x00000001
-- 
1.4.2.3
