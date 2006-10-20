Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 6BC7F679E7
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 10:52:36 +1000 (EST)
Date: Thu, 19 Oct 2006 19:52:26 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
	Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] Slight refactor of interrupt mapping for FSL parts (take 3)
Message-ID: <Pine.LNX.4.61.0610191947090.632@ld0175-tx32.am.freescale.net>
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
* Changed the arch/ppc platform files to specify PHY_POLL, instead of -1
* Changed the fixed phy to use PHY_IGNORE_INTERRUPT
* Added ethtool.h and mii.h to phy.h includes
---
The 3rd iteration of this patch.  Notice I removed the change to 
PHY_POLL's definition.  While I think it's a reasonable idea, I found 
several places where PHY_POLL is assumed to be <= 0, which may not be true 
on all architectures (Some could set it to be 32768, or something).  So 
for now, I'm going to hold off on that change.  Also, I know another patch 
has been submitted which adds the ethtool and mii headers to the phy 
header, but this patch requires it, in order to be warning-free.

 arch/powerpc/sysdev/fsl_soc.c                |   28 ++++++++++----------------
 arch/ppc/platforms/83xx/mpc834x_sys.c        |    4 ++--
 arch/ppc/platforms/85xx/mpc8540_ads.c        |    4 ++--
 arch/ppc/platforms/85xx/mpc8560_ads.c        |    4 ++--
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |    6 +++---
 arch/ppc/platforms/85xx/sbc8560.c            |    2 +-
 arch/ppc/platforms/85xx/stx_gp3.c            |    2 +-
 arch/ppc/platforms/85xx/tqm85xx.c            |    4 ++--
 arch/ppc/platforms/mpc8272ads_setup.c        |    6 +++---
 arch/ppc/platforms/mpc866ads_setup.c         |    4 ++--
 drivers/net/phy/fixed.c                      |    2 +-
 include/asm-powerpc/prom.h                   |    7 +++++++
 include/linux/phy.h                          |    3 +++
 13 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index dbe92ae..ad31e56 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -22,6 +22,7 @@ #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/phy.h>
 #include <linux/fsl_devices.h>
 #include <linux/fs_enet_pd.h>
 #include <linux/fs_uart_pd.h>
@@ -146,7 +147,7 @@ static int __init gfar_mdio_of_init(void
 		}
 
 		for (k = 0; k < 32; k++)
-			mdio_data.irq[k] = -1;
+			mdio_data.irq[k] = PHY_POLL;
 
 		while ((child = of_get_next_child(np, child)) != NULL) {
 			int irq = irq_of_parse_and_map(child, 0);
@@ -177,6 +178,7 @@ static const char *gfar_tx_intr = "tx";
 static const char *gfar_rx_intr = "rx";
 static const char *gfar_err_intr = "error";
 
+
 static int __init gfar_of_init(void)
 {
 	struct device_node *np;
@@ -204,8 +206,7 @@ static int __init gfar_of_init(void)
 		if (ret)
 			goto err;
 
-		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
-		r[1].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[1]);
 
 		model = get_property(np, "model", NULL);
 
@@ -214,12 +215,10 @@ static int __init gfar_of_init(void)
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
@@ -323,8 +322,7 @@ static int __init fsl_i2c_of_init(void)
 		if (ret)
 			goto err;
 
-		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
-		r[1].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[1]);
 
 		i2c_dev = platform_device_register_simple("fsl-i2c", i, r, 2);
 		if (IS_ERR(i2c_dev)) {
@@ -459,8 +457,7 @@ static int __init fsl_usb_of_init(void)
 		if (ret)
 			goto err;
 
-		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
-		r[1].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[1]);
 
 		usb_dev_mph =
 		    platform_device_register_simple("fsl-ehci", i, r, 2);
@@ -507,8 +504,7 @@ static int __init fsl_usb_of_init(void)
 		if (ret)
 			goto unreg_mph;
 
-		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
-		r[1].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[1]);
 
 		usb_dev_dr =
 		    platform_device_register_simple("fsl-ehci", i, r, 2);
@@ -591,8 +587,7 @@ static int __init fs_enet_of_init(void)
 		r[2].name = fcc_regs_c;
 		fs_enet_data.fcc_regs_c = r[2].start;
 
-		r[3].start = r[3].end = irq_of_parse_and_map(np, 0);
-		r[3].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[3]);
 
 		fs_enet_dev =
 		    platform_device_register_simple("fsl-cpm-fcc", i, &r[0], 4);
@@ -754,8 +749,7 @@ static int __init cpm_uart_of_init(void)
 			goto err;
 		r[1].name = scc_pram;
 
-		r[2].start = r[2].end = irq_of_parse_and_map(np, 0);
-		r[2].flags = IORESOURCE_IRQ;
+		of_irq_to_resource(np, 0, &r[2]);
 
 		cpm_uart_dev =
 		    platform_device_register_simple("fsl-cpm-scc:uart", i, &r[0], 3);
diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/platforms/83xx/mpc834x_sys.c
index 3397f0d..b84f8df 100644
--- a/arch/ppc/platforms/83xx/mpc834x_sys.c
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.c
@@ -121,8 +121,8 @@ #endif
 
 	mdata->irq[0] = MPC83xx_IRQ_EXT1;
 	mdata->irq[1] = MPC83xx_IRQ_EXT2;
-	mdata->irq[2] = -1;
-	mdata->irq[31] = -1;
+	mdata->irq[2] = PHY_POLL;
+	mdata->irq[31] = PHY_POLL;
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC83xx_TSEC1);
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
diff --git a/arch/ppc/platforms/mpc8272ads_setup.c b/arch/ppc/platforms/mpc8272ads_setup.c
index 1f9ea36..0bc0676 100644
--- a/arch/ppc/platforms/mpc8272ads_setup.c
+++ b/arch/ppc/platforms/mpc8272ads_setup.c
@@ -266,10 +266,10 @@ static void __init mpc8272ads_fixup_mdio
 					      int idx)
 {
 	m82xx_mii_bb_pdata.irq[0] = PHY_INTERRUPT;
-	m82xx_mii_bb_pdata.irq[1] = -1;
-	m82xx_mii_bb_pdata.irq[2] = -1;
+	m82xx_mii_bb_pdata.irq[1] = PHY_POLL;
+	m82xx_mii_bb_pdata.irq[2] = PHY_POLL;
 	m82xx_mii_bb_pdata.irq[3] = PHY_INTERRUPT;
-	m82xx_mii_bb_pdata.irq[31] = -1;
+	m82xx_mii_bb_pdata.irq[31] = PHY_POLL;
 
 
 	m82xx_mii_bb_pdata.mdio_dat.offset =
diff --git a/arch/ppc/platforms/mpc866ads_setup.c b/arch/ppc/platforms/mpc866ads_setup.c
index e95d2c1..8a0c07e 100644
--- a/arch/ppc/platforms/mpc866ads_setup.c
+++ b/arch/ppc/platforms/mpc866ads_setup.c
@@ -361,7 +361,7 @@ #endif
 
 	fmpi->mii_speed = ((((bd->bi_intfreq + 4999999) / 2500000) / 2) & 0x3F) << 1;
 	/* No PHY interrupt line here */
-	fmpi->irq[0xf] = -1;
+	fmpi->irq[0xf] = PHY_POLL;
 
 /* Since either of the uarts could be used as console, they need to ready */
 #ifdef CONFIG_SERIAL_CPM_SMC1
@@ -380,7 +380,7 @@ #endif
 
 	fmpi->mii_speed = ((((bd->bi_intfreq + 4999999) / 2500000) / 2) & 0x3F) << 1;
 	/* No PHY interrupt line here */
-	fmpi->irq[0xf] = -1;
+	fmpi->irq[0xf] = PHY_POLL;
 
 	return 0;
 }
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
index 9447a57..892d6ab 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -20,6 +20,9 @@ #define __PHY_H
 
 #include <linux/spinlock.h>
 #include <linux/device.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <asm/irq.h>
 
 #define PHY_BASIC_FEATURES	(SUPPORTED_10baseT_Half | \
 				 SUPPORTED_10baseT_Full | \
-- 
1.4.2.3
