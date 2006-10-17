Return-Path: <afleming@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 4ABC367C0A
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 16:28:04 +1000 (EST)
Date: Tue, 17 Oct 2006 01:27:50 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
	Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] Slight refactor of interrupt mapping for FSL parts
Message-ID: <Pine.LNX.4.61.0610170125160.10940@ld0175-tx32.am.freescale.net>
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

* Cleaned up interrupt mapping a little by adding a helper
  function which parses the irq out of the device-tree, and puts
  it into a resource.
* Changed the PHY Layer to use NO_IRQ instead of -1 for PHY_POLL.
  This means that polling will always be used if mapping the
  interrupt fails for any reason.
* Changed the arch/ppc platform files to specify PHY_POLL, instead of -1
* Changed the fixed phy to use PHY_IGNORE_INTERRUPT
---
This is a respin of the patch to reply to comments from the community

 arch/powerpc/sysdev/fsl_soc.c                |   27 ++++++++++----------------
 arch/ppc/platforms/85xx/mpc8540_ads.c        |    4 ++--
 arch/ppc/platforms/85xx/mpc8560_ads.c        |    4 ++--
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |    6 +++---
 arch/ppc/platforms/85xx/sbc8560.c            |    2 +-
 arch/ppc/platforms/85xx/stx_gp3.c            |    2 +-
 arch/ppc/platforms/85xx/tqm85xx.c            |    4 ++--
 drivers/net/phy/fixed.c                      |    2 +-
 include/asm-powerpc/prom.h                   |    7 +++++++
 include/linux/phy.h                          |    7 ++++++-
 10 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index dbe92ae..9ed3b27 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -146,7 +146,7 @@ static int __init gfar_mdio_of_init(void
 		}
 
 		for (k = 0; k < 32; k++)
-			mdio_data.irq[k] = -1;
+			mdio_data.irq[k] = NO_IRQ;
 
 		while ((child = of_get_next_child(np, child)) != NULL) {
 			int irq = irq_of_parse_and_map(child, 0);
@@ -177,6 +177,7 @@ static const char *gfar_tx_intr = "tx";
 static const char *gfar_rx_intr = "rx";
 static const char *gfar_err_intr = "error";
 
+
 static int __init gfar_of_init(void)
 {
 	struct device_node *np;
@@ -204,8 +205,7 @@ static int __init gfar_of_init(void)
 		if (ret)
 			goto err;
 
-		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
-		r[1].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[1]);
 
 		model = get_property(np, "model", NULL);
 
@@ -214,12 +214,10 @@ static int __init gfar_of_init(void)
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
@@ -323,8 +321,7 @@ static int __init fsl_i2c_of_init(void)
 		if (ret)
 			goto err;
 
-		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
-		r[1].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[1]);
 
 		i2c_dev = platform_device_register_simple("fsl-i2c", i, r, 2);
 		if (IS_ERR(i2c_dev)) {
@@ -459,8 +456,7 @@ static int __init fsl_usb_of_init(void)
 		if (ret)
 			goto err;
 
-		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
-		r[1].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[1]);
 
 		usb_dev_mph =
 		    platform_device_register_simple("fsl-ehci", i, r, 2);
@@ -507,8 +503,7 @@ static int __init fsl_usb_of_init(void)
 		if (ret)
 			goto unreg_mph;
 
-		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
-		r[1].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[1]);
 
 		usb_dev_dr =
 		    platform_device_register_simple("fsl-ehci", i, r, 2);
@@ -591,8 +586,7 @@ static int __init fs_enet_of_init(void)
 		r[2].name = fcc_regs_c;
 		fs_enet_data.fcc_regs_c = r[2].start;
 
-		r[3].start = r[3].end = irq_of_parse_and_map(np, 0);
-		r[3].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[3]);
 
 		fs_enet_dev =
 		    platform_device_register_simple("fsl-cpm-fcc", i, &r[0], 4);
@@ -754,8 +748,7 @@ static int __init cpm_uart_of_init(void)
 			goto err;
 		r[1].name = scc_pram;
 
-		r[2].start = r[2].end = irq_of_parse_and_map(np, 0);
-		r[2].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[2]);
 
 		cpm_uart_dev =
 		    platform_device_register_simple("fsl-cpm-scc:uart", i, &r[0], 3);
diff --git a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/platforms/85xx/mpc8540_ads.c
index 4f839da..00a3ba5 100644
--- a/arch/ppc/platforms/85xx/mpc8540_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c
@@ -92,9 +92,9 @@ #endif
 
 	mdata->irq[0] = MPC85xx_IRQ_EXT5;
 	mdata->irq[1] = MPC85xx_IRQ_EXT5;
-	mdata->irq[2] = -1;
+	mdata->irq[2] = PHY_POLL;
 	mdata->irq[3] = MPC85xx_IRQ_EXT5;
-	mdata->irq[31] = -1;
+	mdata->irq[31] = PHY_POLL;
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
diff --git a/arch/ppc/platforms/85xx/mpc8560_ads.c b/arch/ppc/platforms/85xx/mpc8560_ads.c
index 14ecec7..3a06046 100644
--- a/arch/ppc/platforms/85xx/mpc8560_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8560_ads.c
@@ -156,9 +156,9 @@ #endif
 
 	mdata->irq[0] = MPC85xx_IRQ_EXT5;
 	mdata->irq[1] = MPC85xx_IRQ_EXT5;
-	mdata->irq[2] = -1;
+	mdata->irq[2] = PHY_POLL;
 	mdata->irq[3] = MPC85xx_IRQ_EXT5;
-	mdata->irq[31] = -1;
+	mdata->irq[31] = PHY_POLL;
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
diff --git a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
index 5ce0f69..2d59eb7 100644
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
@@ -451,9 +451,9 @@ #endif
 
 	mdata->irq[0] = MPC85xx_IRQ_EXT5;
 	mdata->irq[1] = MPC85xx_IRQ_EXT5;
-	mdata->irq[2] = -1;
-	mdata->irq[3] = -1;
-	mdata->irq[31] = -1;
+	mdata->irq[2] = PHY_POLL;
+	mdata->irq[3] = PHY_POLL;
+	mdata->irq[31] = PHY_POLL;
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
diff --git a/arch/ppc/platforms/85xx/sbc8560.c b/arch/ppc/platforms/85xx/sbc8560.c
index 764d580..1d10ab9 100644
--- a/arch/ppc/platforms/85xx/sbc8560.c
+++ b/arch/ppc/platforms/85xx/sbc8560.c
@@ -129,7 +129,7 @@ #endif
 
 	mdata->irq[25] = MPC85xx_IRQ_EXT6;
 	mdata->irq[26] = MPC85xx_IRQ_EXT7;
-	mdata->irq[31] = -1;
+	mdata->irq[31] = PHY_POLL;
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
diff --git a/arch/ppc/platforms/85xx/stx_gp3.c b/arch/ppc/platforms/85xx/stx_gp3.c
index 4bb18ab..b1f5b73 100644
--- a/arch/ppc/platforms/85xx/stx_gp3.c
+++ b/arch/ppc/platforms/85xx/stx_gp3.c
@@ -123,7 +123,7 @@ #endif
 
 	mdata->irq[2] = MPC85xx_IRQ_EXT5;
 	mdata->irq[4] = MPC85xx_IRQ_EXT5;
-	mdata->irq[31] = -1;
+	mdata->irq[31] = PHY_POLL;
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
diff --git a/arch/ppc/platforms/85xx/tqm85xx.c b/arch/ppc/platforms/85xx/tqm85xx.c
index dd45f2e..4ee2bd1 100644
--- a/arch/ppc/platforms/85xx/tqm85xx.c
+++ b/arch/ppc/platforms/85xx/tqm85xx.c
@@ -137,9 +137,9 @@ #endif /* CONFIG_MPC8560 */
 
 	mdata->irq[0] = MPC85xx_IRQ_EXT8;
 	mdata->irq[1] = MPC85xx_IRQ_EXT8;
-	mdata->irq[2] = -1;
+	mdata->irq[2] = PHY_POLL;
 	mdata->irq[3] = MPC85xx_IRQ_EXT8;
-	mdata->irq[31] = -1;
+	mdata->irq[31] = PHY_POLL;
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
diff --git a/drivers/net/phy/fixed.c b/drivers/net/phy/fixed.c
index f14e992..096d4a1 100644
--- a/drivers/net/phy/fixed.c
+++ b/drivers/net/phy/fixed.c
@@ -254,7 +254,7 @@ static int fixed_mdio_register_device(in
 		goto device_create_fail;
 	}
 
-	phydev->irq = -1;
+	phydev->irq = PHY_IGNORE_INTERRUPT;
 	phydev->dev.bus = &mdio_bus_type;
 
 	if(number)
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 5246297..39f04ef 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -17,6 +17,7 @@ #ifdef __KERNEL__
  */
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/platform_device.h>
 #include <asm/atomic.h>
 
 /* Definitions used by the flattened device tree */
@@ -331,6 +332,12 @@ extern int of_irq_map_one(struct device_
 struct pci_dev;
 extern int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq);
 
+static inline void of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
+{
+	r->start = r->end = irq_of_parse_and_map(dev, index);
+	r->flags = IORESOURCE_IRQ;
+}
+
 
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_PROM_H */
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 9447a57..4dbffe4 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -20,6 +20,7 @@ #define __PHY_H
 
 #include <linux/spinlock.h>
 #include <linux/device.h>
+#include <asm/irq.h>
 
 #define PHY_BASIC_FEATURES	(SUPPORTED_10baseT_Half | \
 				 SUPPORTED_10baseT_Full | \
@@ -37,7 +38,11 @@ #define PHY_GBIT_FEATURES	(PHY_BASIC_FEA
  * or not desired for this PHY.  Set to PHY_IGNORE_INTERRUPT if
  * the attached driver handles the interrupt
  */
-#define PHY_POLL		-1
+#ifndef NO_IRQ
+#define NO_IRQ 0
+#endif
+
+#define PHY_POLL		NO_IRQ
 #define PHY_IGNORE_INTERRUPT	-2
 
 #define PHY_HAS_INTERRUPT	0x00000001
-- 
1.4.2.3
