Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 06 Nov 2006 18:05:58 +1100
Subject: [PATCH 27/27] powerpc: EMAC of_platform_device support for Cell using
	Axon
In-Reply-To: <1162796738.274582.277491064706.qpush@grosgo>
Message-Id: <20061106070714.89ADA67E2E@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds of_platform probing and basic dt support to ibm_emac.

It can still use some significant cleanup, along with a couple of bug
fixes that are still pending for some FIFO size issues, but it should
give in its current form an idea of the kind of transition we can expect
from arch/ppc to arch/powerpc for 4xx type devices

The patch is initially from Shaun Wetzstein with various changes of my
own. It's still not a finished work as I really need to create proper
of_platform_device/drivers for RGII and ZMII to avoid some of the ugliest
hacks in the current one. 

It might also be of some intersest to note how the main EMAC driver
"waits" for the other sub drivers to show up using multithreaded device
probing. It's handy, but it also means that stable interface numbering
will be near to impossible :(

The code should take advantage of the new bus device notifier thingy
too in order to sleep instead of poll when doing this wait.

Signed-off-by: Shaun Wetzstein <shaun@vnet.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/Kconfig                   |    1 
 drivers/net/Kconfig                    |   16 
 drivers/net/ibm_emac/ibm_emac.h        |   32 +
 drivers/net/ibm_emac/ibm_emac_busdev.h |   37 ++
 drivers/net/ibm_emac/ibm_emac_compat.h |   72 ++++
 drivers/net/ibm_emac/ibm_emac_core.c   |  566 ++++++++++++++++++++++++---------
 drivers/net/ibm_emac/ibm_emac_core.h   |   12 
 drivers/net/ibm_emac/ibm_emac_mal.c    |  220 ++++++++++--
 drivers/net/ibm_emac/ibm_emac_mal.h    |    6 
 drivers/net/ibm_emac/ibm_emac_phy.c    |    4 
 drivers/net/ibm_emac/ibm_emac_rgmii.c  |  137 +++++--
 drivers/net/ibm_emac/ibm_emac_rgmii.h  |   22 -
 drivers/net/ibm_emac/ibm_emac_tah.h    |    1 
 drivers/net/ibm_emac/ibm_emac_zmii.c   |  151 +++++---
 drivers/net/ibm_emac/ibm_emac_zmii.h   |   35 +-
 15 files changed, 972 insertions(+), 340 deletions(-)

Index: linux-cell/drivers/net/ibm_emac/ibm_emac_mal.c
===================================================================
--- linux-cell.orig/drivers/net/ibm_emac/ibm_emac_mal.c	2006-11-06 16:38:24.000000000 +1100
+++ linux-cell/drivers/net/ibm_emac/ibm_emac_mal.c	2006-11-06 16:38:27.000000000 +1100
@@ -27,7 +27,9 @@
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 
-#include <asm/ocp.h>
+#ifndef CONFIG_IBM_EMAC_OCP
+#include <asm/of_platform.h>
+#endif
 
 #include "ibm_emac_core.h"
 #include "ibm_emac_mal.h"
@@ -400,31 +402,12 @@ void *mal_dump_regs(struct ibm_ocp_mal *
 	return regs + 1;
 }
 
-static int __init mal_probe(struct ocp_device *ocpdev)
+static int __init mal_setup(struct ibm_ocp_mal *mal,
+			    struct ocp_func_mal_data *maldata,
+			    struct emac_subdev *dev)
 {
-	struct ibm_ocp_mal *mal;
-	struct ocp_func_mal_data *maldata;
 	int err = 0, i, bd_size;
 
-	MAL_DBG("%d: probe" NL, ocpdev->def->index);
-
-	maldata = ocpdev->def->additions;
-	if (maldata == NULL) {
-		printk(KERN_ERR "mal%d: missing additional data!\n",
-		       ocpdev->def->index);
-		return -ENODEV;
-	}
-
-	mal = kzalloc(sizeof(struct ibm_ocp_mal), GFP_KERNEL);
-	if (!mal) {
-		printk(KERN_ERR
-		       "mal%d: out of memory allocating MAL structure!\n",
-		       ocpdev->def->index);
-		return -ENOMEM;
-	}
-	mal->dcrbase = maldata->dcr_base;
-	mal->def = ocpdev->def;
-
 	INIT_LIST_HEAD(&mal->poll_list);
 	set_bit(__LINK_STATE_START, &mal->poll_dev.state);
 	mal->poll_dev.weight = CONFIG_IBM_EMAC_POLL_WEIGHT;
@@ -450,7 +433,7 @@ static int __init mal_probe(struct ocp_d
 	    (NUM_TX_BUFF * maldata->num_tx_chans +
 	     NUM_RX_BUFF * maldata->num_rx_chans);
 	mal->bd_virt =
-	    dma_alloc_coherent(&ocpdev->dev, bd_size, &mal->bd_dma, GFP_KERNEL);
+	    dma_alloc_coherent(&dev->dev, bd_size, &mal->bd_dma, GFP_KERNEL);
 
 	if (!mal->bd_virt) {
 		printk(KERN_ERR
@@ -471,19 +454,19 @@ static int __init mal_probe(struct ocp_d
 			     sizeof(struct mal_descriptor) *
 			     mal_rx_bd_offset(mal, i));
 
-	err = request_irq(maldata->serr_irq, mal_serr, 0, "MAL SERR", mal);
+	err = request_irq(maldata->serr_irq, mal_serr, IRQF_PROBE_SHARED|IRQF_SHARED, "MAL SERR", mal);
 	if (err)
 		goto fail2;
-	err = request_irq(maldata->txde_irq, mal_txde, 0, "MAL TX DE", mal);
+	err = request_irq(maldata->txde_irq, mal_txde, IRQF_PROBE_SHARED|IRQF_SHARED, "MAL TX DE", mal);
 	if (err)
 		goto fail3;
-	err = request_irq(maldata->txeob_irq, mal_txeob, 0, "MAL TX EOB", mal);
+	err = request_irq(maldata->txeob_irq, mal_txeob, IRQF_PROBE_SHARED|IRQF_SHARED, "MAL TX EOB", mal);
 	if (err)
 		goto fail4;
-	err = request_irq(maldata->rxde_irq, mal_rxde, 0, "MAL RX DE", mal);
+	err = request_irq(maldata->rxde_irq, mal_rxde, IRQF_PROBE_SHARED|IRQF_SHARED, "MAL RX DE", mal);
 	if (err)
 		goto fail5;
-	err = request_irq(maldata->rxeob_irq, mal_rxeob, 0, "MAL RX EOB", mal);
+	err = request_irq(maldata->rxeob_irq, mal_rxeob, IRQF_PROBE_SHARED|IRQF_SHARED, "MAL RX EOB", mal);
 	if (err)
 		goto fail6;
 
@@ -491,7 +474,7 @@ static int __init mal_probe(struct ocp_d
 	set_mal_dcrn(mal, MAL_IER, MAL_IER_EVENTS);
 
 	/* Advertise this instance to the rest of the world */
-	ocp_set_drvdata(ocpdev, mal);
+	bus_set_drvdata(dev, mal);
 
 	mal_dbg_register(mal->def->index, mal);
 
@@ -499,24 +482,141 @@ static int __init mal_probe(struct ocp_d
 	       mal->def->index, maldata->num_tx_chans, maldata->num_rx_chans);
 	return 0;
 
-      fail6:
+ fail6:
 	free_irq(maldata->rxde_irq, mal);
-      fail5:
+ fail5:
 	free_irq(maldata->txeob_irq, mal);
-      fail4:
+ fail4:
 	free_irq(maldata->txde_irq, mal);
-      fail3:
+ fail3:
 	free_irq(maldata->serr_irq, mal);
-      fail2:
-	dma_free_coherent(&ocpdev->dev, bd_size, mal->bd_virt, mal->bd_dma);
-      fail:
+ fail2:
+	dma_free_coherent(&dev->dev, bd_size, mal->bd_virt, mal->bd_dma);
+ fail:
+	return err;
+}
+
+
+#ifdef CONFIG_IBM_EMAC_OCP
+static int __init mal_probe(struct emac_subdev *dev)
+{
+	struct ibm_ocp_mal *mal;
+	struct ocp_func_mal_data *maldata;
+	int err = 0;
+
+	MAL_DBG("%d: probe" NL, dev->def->index);
+
+	maldata = dev->def->additions;
+	if (maldata == NULL) {
+		printk(KERN_ERR "mal%d: missing additional data!\n",
+		       dev->def->index);
+		return -ENODEV;
+	}
+
+	mal = kzalloc(sizeof(struct ibm_ocp_mal), GFP_KERNEL);
+	if (!mal) {
+		printk(KERN_ERR
+		       "mal%d: out of memory allocating MAL structure!\n",
+		       dev->def->index);
+		return -ENOMEM;
+	}
+	mal->dcrbase = maldata->dcr_base;
+	mal->def = dev->def;
+
+	err = mal_setup(mal, maldata, dev);
+	if (err != 0)
+		goto fail;
+	return 0;
+ fail:
+	kfree(mal);
+}
+
+#else
+static int __init mal_probe(struct emac_subdev *dev,
+			    const struct of_device_id *match)
+{
+	struct ibm_ocp_mal *mal;
+	struct ocp_func_mal_data *maldata;
+	int err = 0;
+
+	static int index = 0;
+	u32 *data;
+
+	MAL_DBG("%d: probe" NL, index);
+
+	mal = kzalloc(sizeof(struct ibm_ocp_mal) +
+		      sizeof(struct ocp_def) +
+ 		      sizeof(struct ocp_func_mal_data), GFP_KERNEL);
+	if (!mal) {
+		printk(KERN_ERR
+		       "mal%d: out of memory allocating MAL structure!\n",
+		       index);
+		return -ENOMEM;
+	}
+	mal->def = (struct ocp_def *)(mal + 1);
+	mal->def->additions = (void *)(mal->def + 1);
+	mal->def->index = index++;
+	maldata = mal->def->additions;
+
+	data = (u32 *)get_property(dev->node, "num-tx-chans", NULL);
+	if (data == NULL) {
+		printk(KERN_ERR
+		       "mal%d: can't find MAL num-tx-chans property!\n",
+		       mal->def->index);
+		err = -ENODEV;
+		goto fail;
+	}
+	maldata->num_tx_chans = data[0];
+
+	data = (u32 *)get_property(dev->node, "num-rx-chans", NULL);
+	if (data == NULL) {
+		printk(KERN_ERR
+		       "mal%d: can't find MAL num-rx-chans property!\n",
+		       mal->def->index);
+		err = -ENODEV;
+		goto fail;
+	}
+	maldata->num_rx_chans = data[0];
+
+	maldata->dcr_base = dcr_resource_start(dev->node, 0);
+	if (maldata->dcr_base == 0) {
+		printk(KERN_ERR
+		       "mal%d: can't find DCR resource!\n", mal->def->index);
+		err = -ENODEV;
+		goto fail;
+	}
+	mal->dcrbase = maldata->dcr_base;
+        mal->dcrhost = dcr_map(dev->node, mal->dcrbase, 0x100);
+	if (!DCR_MAP_OK(mal->dcrhost)) {
+		printk(KERN_ERR
+		       "emac%d: can't map DCRs!\n", mal->def->index);
+		err = -ENODEV;
+		goto fail;
+	}
+
+	maldata->txeob_irq = irq_of_parse_and_map(dev->node, 2);
+	maldata->rxeob_irq = irq_of_parse_and_map(dev->node, 3);
+	maldata->serr_irq = irq_of_parse_and_map(dev->node, 4);
+	maldata->txde_irq = irq_of_parse_and_map(dev->node, 5);
+	maldata->rxde_irq = irq_of_parse_and_map(dev->node, 6);
+
+	err = mal_setup(mal, maldata, dev);
+	if (err != 0)
+		goto fail_unmap;
+	return 0;
+
+ fail_unmap:
+	dcr_unmap(mal->dcrhost, mal->dcrbase, 0x100);
+ fail:
 	kfree(mal);
+
 	return err;
 }
+#endif
 
-static void __exit mal_remove(struct ocp_device *ocpdev)
+static int __exit mal_remove(struct emac_subdev *dev)
 {
-	struct ibm_ocp_mal *mal = ocp_get_drvdata(ocpdev);
+	struct ibm_ocp_mal *mal = bus_get_drvdata(dev);
 	struct ocp_func_mal_data *maldata = mal->def->additions;
 
 	MAL_DBG("%d: remove" NL, mal->def->index);
@@ -534,7 +634,7 @@ static void __exit mal_remove(struct ocp
 		       mal->def->index);
 	}
 
-	ocp_set_drvdata(ocpdev, NULL);
+	bus_set_drvdata(dev, NULL);
 
 	free_irq(maldata->serr_irq, mal);
 	free_irq(maldata->txde_irq, mal);
@@ -546,15 +646,20 @@ static void __exit mal_remove(struct ocp
 
 	mal_dbg_register(mal->def->index, NULL);
 
-	dma_free_coherent(&ocpdev->dev,
+	dma_free_coherent(&dev->dev,
 			  sizeof(struct mal_descriptor) *
 			  (NUM_TX_BUFF * maldata->num_tx_chans +
 			   NUM_RX_BUFF * maldata->num_rx_chans), mal->bd_virt,
 			  mal->bd_dma);
 
 	kfree(mal);
+
+#ifndef CONFIG_IBM_EMAC_OCP
+	return 0;
+#endif
 }
 
+#ifdef CONFIG_IBM_EMAC_OCP
 /* Structure for a device driver */
 static struct ocp_device_id mal_ids[] = {
 	{ .vendor = OCP_VENDOR_IBM, .function = OCP_FUNC_MAL },
@@ -568,15 +673,46 @@ static struct ocp_driver mal_driver = {
 	.probe = mal_probe,
 	.remove = mal_remove,
 };
+#else
+static struct of_device_id mal_platform_match[] =
+{
+	{
+		.type		= "mal",
+	},
+	{},
+};
+
+static struct of_platform_driver mal_of_driver = {
+	.name = "mal",
+	.match_table = mal_platform_match,
+
+	.probe = mal_probe,
+	.remove = mal_remove,
+};
+#endif
 
 int __init mal_init(void)
 {
+	int rc;
+
 	MAL_DBG(": init" NL);
-	return ocp_register_driver(&mal_driver);
+
+#ifdef CONFIG_IBM_EMAC_OCP
+	rc = ocp_register_driver(&mal_driver);
+	if (rc) return rc;
+#else
+	of_register_platform_driver(&mal_of_driver);
+	rc = 0;
+#endif
+	return rc;
 }
 
 void __exit mal_exit(void)
 {
 	MAL_DBG(": exit" NL);
+#ifdef CONFIG_IBM_EMAC_OCP
 	ocp_unregister_driver(&mal_driver);
+#else
+	of_unregister_platform_driver(&mal_of_driver);
+#endif
 }
Index: linux-cell/drivers/net/ibm_emac/ibm_emac_mal.h
===================================================================
--- linux-cell.orig/drivers/net/ibm_emac/ibm_emac_mal.h	2006-11-06 16:38:24.000000000 +1100
+++ linux-cell/drivers/net/ibm_emac/ibm_emac_mal.h	2006-11-06 16:38:27.000000000 +1100
@@ -26,6 +26,10 @@
 #include <asm/io.h>
 #include <asm/dcr.h>
 
+#ifndef CONFIG_IBM_EMAC_OCP
+#include "ibm_emac_compat.h"
+#endif
+
 /*
  * These MAL "versions" probably aren't the real versions IBM uses for these 
  * MAL cores, I assigned them just to make #ifdefs in this file nicer and 
@@ -35,7 +39,7 @@
     defined(CONFIG_440EP) || defined(CONFIG_440GR) || defined(CONFIG_NP405H)
 #define MAL_VERSION		1
 #elif defined(CONFIG_440GP) || defined(CONFIG_440GX) || defined(CONFIG_440SP) || \
-      defined(CONFIG_440SPE)
+      defined(CONFIG_440SPE) || defined(CONFIG_PPC_CELL)
 #define MAL_VERSION		2
 #else
 #error "Unknown SoC, please check chip manual and choose MAL 'version'"
Index: linux-cell/drivers/net/Kconfig
===================================================================
--- linux-cell.orig/drivers/net/Kconfig	2006-11-06 16:38:24.000000000 +1100
+++ linux-cell/drivers/net/Kconfig	2006-11-06 16:38:27.000000000 +1100
@@ -1201,11 +1201,19 @@ config IBMVETH
 
 config IBM_EMAC
 	tristate "PowerPC 4xx on-chip Ethernet support"
-	depends on 4xx
+	depends on NET_ETHERNET && PPC_DCR
 	help
 	  This driver supports the PowerPC 4xx EMAC family of on-chip
           Ethernet controllers.
 
+config IBM_EMAC_OCP
+	bool "On-Chip Peripheral bus support (PPC32 only)"
+	depends on IBM_EMAC && 4xx && !PPC_MERGE
+	default y
+	help
+	  Adds support for OCP bus probing.  Selecting 'No' here
+	  causes the driver to use OF platform bus probing.
+
 config IBM_EMAC_RXB
 	int "Number of receive buffers"
 	depends on IBM_EMAC
@@ -1256,14 +1264,14 @@ config IBM_EMAC_DEBUG
 
 config IBM_EMAC_ZMII
 	bool
-	depends on IBM_EMAC && (NP405H || NP405L || 44x)
+	depends on IBM_EMAC && (NP405H || NP405L || 44x || PPC_CELL)
 	default y
 
 config IBM_EMAC_RGMII
 	bool
-	depends on IBM_EMAC && 440GX
+	depends on IBM_EMAC && (440GX || PPC_CELL)
 	default y
-		
+
 config IBM_EMAC_TAH
 	bool
 	depends on IBM_EMAC && 440GX
Index: linux-cell/drivers/net/ibm_emac/ibm_emac.h
===================================================================
--- linux-cell.orig/drivers/net/ibm_emac/ibm_emac.h	2006-11-06 16:38:24.000000000 +1100
+++ linux-cell/drivers/net/ibm_emac/ibm_emac.h	2006-11-06 16:38:27.000000000 +1100
@@ -22,14 +22,6 @@
 
 #include <linux/types.h>
 
-/* This is a simple check to prevent use of this driver on non-tested SoCs */
-#if !defined(CONFIG_405GP) && !defined(CONFIG_405GPR) && !defined(CONFIG_405EP) && \
-    !defined(CONFIG_440GP) && !defined(CONFIG_440GX) && !defined(CONFIG_440SP) && \
-    !defined(CONFIG_440EP) && !defined(CONFIG_NP405H) && !defined(CONFIG_440SPE) && \
-    !defined(CONFIG_440GR)
-#error	"Unknown SoC. Please, check chip user manual and make sure EMAC defines are OK"
-#endif
-
 /* EMAC registers 		Write Access rules */
 struct emac_regs {
 	u32 mr0;		/* special 	*/
@@ -112,10 +104,16 @@ struct emac_regs {
 #define EMAC_MR1_MWSW_001		0x00000000
 #define EMAC_MR1_BASE(opb)		(EMAC_MR1_TFS_2K | EMAC_MR1_TR0_MULT)
 #else
+#define EMAC_MR1_RFS_2K			0x00100000
 #define EMAC_MR1_RFS_4K			0x00180000
 #define EMAC_MR1_RFS_16K		0x00280000
+#if defined(CONFIG_PPC_CELL)
+#define EMAC_RX_FIFO_SIZE(gige)		2048
+#else
 #define EMAC_RX_FIFO_SIZE(gige)		((gige) ? 16384 : 4096)
+#endif
 #define EMAC_MR1_TFS_2K			0x00020000
+#define EMAC_MR1_TFS_4K			0x00030000
 #define EMAC_MR1_TR			0x00008000
 #define EMAC_MR1_MWSW_001		0x00001000
 #define EMAC_MR1_JPSM			0x00000800
@@ -129,9 +127,14 @@ struct emac_regs {
 					 (freq) <= 66  ? EMAC_MR1_OBCI_66 : \
 					 (freq) <= 83  ? EMAC_MR1_OBCI_83 : \
 					 (freq) <= 100 ? EMAC_MR1_OBCI_100 : EMAC_MR1_OBCI_100P)
+#if defined(CONFIG_PPC_CELL)
+#define EMAC_MR1_BASE(opb)		(EMAC_MR1_TFS_4K | EMAC_MR1_TR | \
+					 EMAC_MR1_OBCI(opb))
+#else
 #define EMAC_MR1_BASE(opb)		(EMAC_MR1_TFS_2K | EMAC_MR1_TR | \
 					 EMAC_MR1_OBCI(opb))
 #endif
+#endif
 
 /* EMACx_TMR0 */
 #define EMAC_TMR0_GNP			0x80000000
@@ -227,9 +230,17 @@ struct emac_regs {
 #define EMAC_STACR_PHYD_SHIFT		16
 #define EMAC_STACR_OC			0x00008000
 #define EMAC_STACR_PHYE			0x00004000
-#define EMAC_STACR_STAC_MASK		0x00003000
 #define EMAC_STACR_STAC_READ		0x00001000
+
+/* XXX FIXME */
+#if defined(CONFIG_PPC_CELL)
+#define EMAC_STACR_STAC_MASK		0x00001800
+#define EMAC_STACR_STAC_WRITE		0x00000800
+#else
+#define EMAC_STACR_STAC_MASK		0x00003000
 #define EMAC_STACR_STAC_WRITE		0x00002000
+#endif
+
 #if !defined(CONFIG_IBM_EMAC4)
 #define EMAC_STACR_OPBC_MASK		0x00000C00
 #define EMAC_STACR_OPBC_50		0x00000000
@@ -250,8 +261,9 @@ struct emac_regs {
 /*
  * For the 440SPe, AMCC inexplicably changed the polarity of
  * the "operation complete" bit in the MII control register.
+ * XXX FIXME
  */
-#if defined(CONFIG_440SPE)
+#if defined(CONFIG_440SPE) || defined(CONFIG_PPC_CELL)
 static inline int emac_phy_done(u32 stacr)
 {
 	return !(stacr & EMAC_STACR_OC);
Index: linux-cell/drivers/net/ibm_emac/ibm_emac_core.h
===================================================================
--- linux-cell.orig/drivers/net/ibm_emac/ibm_emac_core.h	2006-11-06 16:38:24.000000000 +1100
+++ linux-cell/drivers/net/ibm_emac/ibm_emac_core.h	2006-11-06 16:38:27.000000000 +1100
@@ -22,7 +22,6 @@
 
 #include <linux/netdevice.h>
 #include <linux/dma-mapping.h>
-#include <asm/ocp.h>
 
 #include "ibm_emac.h"
 #include "ibm_emac_phy.h"
@@ -30,6 +29,10 @@
 #include "ibm_emac_rgmii.h"
 #include "ibm_emac_mal.h"
 #include "ibm_emac_tah.h"
+#include "ibm_emac_busdev.h"
+#ifndef CONFIG_IBM_EMAC_OCP
+#include "ibm_emac_compat.h"
+#endif
 
 #define NUM_TX_BUFF			CONFIG_IBM_EMAC_TXB
 #define NUM_RX_BUFF			CONFIG_IBM_EMAC_RXB
@@ -168,7 +171,7 @@ struct ocp_enet_private {
 	int				rx_sync_size;
 
 	struct ibm_emac_stats 		stats;
-	struct ocp_device		*tah_dev;
+	struct emac_subdev		*tah_dev;
 
 	struct ibm_ocp_mal		*mal;
 	struct mal_commac		commac;
@@ -176,10 +179,11 @@ struct ocp_enet_private {
 	struct sk_buff			*tx_skb[NUM_TX_BUFF];
 	struct sk_buff			*rx_skb[NUM_RX_BUFF];
 
-	struct ocp_device		*zmii_dev;
+	struct emac_subdev		*zmii_dev;
 	int				zmii_input;
 	struct ocp_enet_private		*mdio_dev;
-	struct ocp_device		*rgmii_dev;
+
+	struct emac_subdev		*rgmii_dev;
 	int				rgmii_input;
 
 	struct ocp_def			*def;
Index: linux-cell/drivers/net/ibm_emac/ibm_emac_zmii.h
===================================================================
--- linux-cell.orig/drivers/net/ibm_emac/ibm_emac_zmii.h	2006-11-06 16:38:24.000000000 +1100
+++ linux-cell/drivers/net/ibm_emac/ibm_emac_zmii.h	2006-11-06 16:38:27.000000000 +1100
@@ -20,7 +20,8 @@
 #define _IBM_EMAC_ZMII_H_
 
 #include <linux/init.h>
-#include <asm/ocp.h>
+
+#include "ibm_emac_busdev.h"
 
 /* ZMII bridge registers */
 struct zmii_regs {
@@ -40,35 +41,35 @@ struct ibm_ocp_zmii {
 #ifdef CONFIG_IBM_EMAC_ZMII
 int zmii_attach(void *emac) __init;
 
-void __zmii_fini(struct ocp_device *ocpdev, int input) __exit;
-static inline void zmii_fini(struct ocp_device *ocpdev, int input)
+void __zmii_fini(struct emac_subdev *dev, int input) __exit;
+static inline void zmii_fini(struct emac_subdev *dev, int input)
 {
-	if (ocpdev)
-		__zmii_fini(ocpdev, input);
+	if (dev)
+		__zmii_fini(dev, input);
 }
 
-void __zmii_enable_mdio(struct ocp_device *ocpdev, int input);
-static inline void zmii_enable_mdio(struct ocp_device *ocpdev, int input)
+void __zmii_enable_mdio(struct emac_subdev *dev, int input);
+static inline void zmii_enable_mdio(struct emac_subdev *dev, int input)
 {
-	if (ocpdev)
-		__zmii_enable_mdio(ocpdev, input);
+	if (dev)
+		__zmii_enable_mdio(dev, input);
 }
 
-void __zmii_set_speed(struct ocp_device *ocpdev, int input, int speed);
-static inline void zmii_set_speed(struct ocp_device *ocpdev, int input,
+void __zmii_set_speed(struct emac_subdev *dev, int input, int speed);
+static inline void zmii_set_speed(struct emac_subdev *dev, int input,
 				  int speed)
 {
-	if (ocpdev)
-		__zmii_set_speed(ocpdev, input, speed);
+	if (dev)
+		__zmii_set_speed(dev, input, speed);
 }
 
-int __zmii_get_regs_len(struct ocp_device *ocpdev);
-static inline int zmii_get_regs_len(struct ocp_device *ocpdev)
+int __zmii_get_regs_len(struct emac_subdev *dev);
+static inline int zmii_get_regs_len(struct emac_subdev *dev)
 {
-	return ocpdev ? __zmii_get_regs_len(ocpdev) : 0;
+	return dev ? __zmii_get_regs_len(dev) : 0;
 }
 
-void *zmii_dump_regs(struct ocp_device *ocpdev, void *buf);
+void *zmii_dump_regs(struct emac_subdev *dev, void *buf);
 
 #else
 # define zmii_attach(x)		0
Index: linux-cell/drivers/net/ibm_emac/ibm_emac_tah.h
===================================================================
--- linux-cell.orig/drivers/net/ibm_emac/ibm_emac_tah.h	2006-11-06 16:38:24.000000000 +1100
+++ linux-cell/drivers/net/ibm_emac/ibm_emac_tah.h	2006-11-06 16:38:27.000000000 +1100
@@ -18,7 +18,6 @@
 #define _IBM_EMAC_TAH_H
 
 #include <linux/init.h>
-#include <asm/ocp.h>
 
 /* TAH */
 struct tah_regs {
Index: linux-cell/drivers/net/ibm_emac/ibm_emac_core.c
===================================================================
--- linux-cell.orig/drivers/net/ibm_emac/ibm_emac_core.c	2006-11-06 16:38:24.000000000 +1100
+++ linux-cell/drivers/net/ibm_emac/ibm_emac_core.c	2006-11-06 16:38:27.000000000 +1100
@@ -41,7 +41,11 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/uaccess.h>
-#include <asm/ocp.h>
+#include <asm/dcr.h>
+
+#ifndef CONFIG_IBM_EMAC_OCP
+#include <asm/of_platform.h>
+#endif
 
 #include "ibm_emac_core.h"
 #include "ibm_emac_debug.h"
@@ -72,6 +76,10 @@ MODULE_AUTHOR
     ("Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>");
 MODULE_LICENSE("GPL");
 
+#ifdef CONFIG_PPC64
+#define cacheable_memcpy(d,s,n) memcpy((d),(s),(n))
+#endif
+
 /* minimum number of free TX descriptors required to wake up TX process */
 #define EMAC_TX_WAKEUP_THRESH		(NUM_TX_BUFF / 4)
 
@@ -386,7 +394,11 @@ static inline u32 emac_iff2rmr(struct ne
 
 static inline int emac_opb_mhz(void)
 {
+#ifdef FIX_ME
 	return (ocp_sys_info.opb_bus_freq + 500000) / 1000000;
+#else
+	return 133;
+#endif
 }
 
 /* BHs disabled */
@@ -421,7 +433,12 @@ static int emac_configure(struct ocp_ene
 			out_be32(&p->ipcr, 0xdeadbeef);
 		} else
 			r |= EMAC_MR1_MF_1000;
+
+#if defined(CONFIG_PPC_CELL)
+		r |= EMAC_MR1_RFS_2K;
+#else
 		r |= EMAC_MR1_RFS_16K;
+#endif
 		gige = 1;
 
 		if (dev->ndev->mtu > ETH_DATA_LEN) {
@@ -435,7 +452,11 @@ static int emac_configure(struct ocp_ene
 		dev->stop_timeout = STOP_TIMEOUT_100;
 		/* Fall through */
 	default:
+#if defined(CONFIG_PPC_CELL)
+		r |= EMAC_MR1_RFS_2K;
+#else
 		r |= EMAC_MR1_RFS_4K;
+#endif
 		gige = 0;
 		break;
 	}
@@ -552,6 +573,16 @@ static void emac_full_tx_reset(struct ne
 	netif_wake_queue(ndev);
 }
 
+static void mii_enable_mdio(struct ocp_enet_private *dev)
+{
+       if (dev) {
+               if (dev->zmii_dev)
+                       zmii_enable_mdio(dev->zmii_dev, dev->zmii_input);
+               else
+                       rgmii_enable_mdio(dev->rgmii_dev, dev->rgmii_input);
+       }
+}
+
 static int __emac_mdio_read(struct ocp_enet_private *dev, u8 id, u8 reg)
 {
 	struct emac_regs __iomem *p = dev->emacp;
@@ -561,7 +592,7 @@ static int __emac_mdio_read(struct ocp_e
 	DBG2("%d: mdio_read(%02x,%02x)" NL, dev->def->index, id, reg);
 
 	/* Enable proper MDIO port */
-	zmii_enable_mdio(dev->zmii_dev, dev->zmii_input);
+	mii_enable_mdio(dev);
 
 	/* Wait for management interface to become idle */
 	n = 10;
@@ -610,7 +641,7 @@ static void __emac_mdio_write(struct ocp
 	     val);
 
 	/* Enable proper MDIO port */
-	zmii_enable_mdio(dev->zmii_dev, dev->zmii_input);
+	mii_enable_mdio(dev);
 
 	/* Wait for management interface to be idle */
 	n = 10;
@@ -1240,6 +1271,7 @@ static void emac_parse_tx_error(struct o
 static void emac_poll_tx(void *param)
 {
 	struct ocp_enet_private *dev = param;
+
 	DBG2("%d: poll_tx, %d %d" NL, dev->def->index, dev->tx_cnt,
 	     dev->ack_slot);
 
@@ -1612,24 +1644,28 @@ static struct net_device_stats *emac_sta
 	return nst;
 }
 
-static void emac_remove(struct ocp_device *ocpdev)
+static int emac_remove(struct emac_subdev *dev)
 {
-	struct ocp_enet_private *dev = ocp_get_drvdata(ocpdev);
+	struct ocp_enet_private *edev = bus_get_drvdata(dev);
 
-	DBG("%d: remove" NL, dev->def->index);
+ 	DBG("%d: remove" NL, edev->def->index);
 
-	ocp_set_drvdata(ocpdev, NULL);
-	unregister_netdev(dev->ndev);
+ 	bus_set_drvdata(dev, 0);
+ 	unregister_netdev(edev->ndev);
 
-	tah_fini(dev->tah_dev);
-	rgmii_fini(dev->rgmii_dev, dev->rgmii_input);
-	zmii_fini(dev->zmii_dev, dev->zmii_input);
+  	tah_fini(dev->tah_dev);
+ 	rgmii_fini(edev->rgmii_dev, edev->rgmii_input);
+ 	zmii_fini(edev->zmii_dev, edev->zmii_input);
 
-	emac_dbg_register(dev->def->index, NULL);
+ 	emac_dbg_register(edev->def->index, 0);
 
-	mal_unregister_commac(dev->mal, &dev->commac);
-	iounmap(dev->emacp);
-	kfree(dev->ndev);
+ 	mal_unregister_commac(edev->mal, &edev->commac);
+ 	iounmap((void *)edev->emacp);
+ 	kfree(edev->ndev);
+
+#ifndef CONFIG_IBM_EMAC_OCP
+ 	return 0;
+#endif
 }
 
 static struct mal_commac_ops emac_commac_ops = {
@@ -1938,119 +1974,61 @@ static int emac_ioctl(struct net_device 
 	}
 }
 
-static int __init emac_probe(struct ocp_device *ocpdev)
+static int __init emac_setup(struct net_device *ndev,
+			     struct ocp_func_emac_data *emacdata,
+			     struct emac_subdev *dev)
 {
-	struct ocp_func_emac_data *emacdata = ocpdev->def->additions;
-	struct net_device *ndev;
-	struct ocp_device *maldev;
-	struct ocp_enet_private *dev;
+	struct ocp_enet_private *edev = ndev->priv;
 	int err, i;
 
-	DBG("%d: probe" NL, ocpdev->def->index);
-
-	if (!emacdata) {
-		printk(KERN_ERR "emac%d: Missing additional data!\n",
-		       ocpdev->def->index);
-		return -ENODEV;
-	}
-
-	/* Allocate our net_device structure */
-	ndev = alloc_etherdev(sizeof(struct ocp_enet_private));
-	if (!ndev) {
-		printk(KERN_ERR "emac%d: could not allocate ethernet device!\n",
-		       ocpdev->def->index);
-		return -ENOMEM;
-	}
-	dev = ndev->priv;
-	dev->ndev = ndev;
-	dev->ldev = &ocpdev->dev;
-	dev->def = ocpdev->def;
-	SET_MODULE_OWNER(ndev);
-
-	/* Find MAL device we are connected to */
-	maldev =
-	    ocp_find_device(OCP_VENDOR_IBM, OCP_FUNC_MAL, emacdata->mal_idx);
-	if (!maldev) {
-		printk(KERN_ERR "emac%d: unknown mal%d device!\n",
-		       dev->def->index, emacdata->mal_idx);
-		err = -ENODEV;
-		goto out;
-	}
-	dev->mal = ocp_get_drvdata(maldev);
-	if (!dev->mal) {
-		printk(KERN_ERR "emac%d: mal%d hasn't been initialized yet!\n",
-		       dev->def->index, emacdata->mal_idx);
-		err = -ENODEV;
-		goto out;
-	}
+	printk("emac_setup, commac @%p\n", &edev->commac);
 
 	/* Register with MAL */
-	dev->commac.ops = &emac_commac_ops;
-	dev->commac.dev = dev;
-	dev->commac.tx_chan_mask = MAL_CHAN_MASK(emacdata->mal_tx_chan);
-	dev->commac.rx_chan_mask = MAL_CHAN_MASK(emacdata->mal_rx_chan);
-	err = mal_register_commac(dev->mal, &dev->commac);
+	edev->commac.ops = &emac_commac_ops;
+	edev->commac.dev = edev;
+	edev->commac.tx_chan_mask = MAL_CHAN_MASK(emacdata->mal_tx_chan);
+	edev->commac.rx_chan_mask = MAL_CHAN_MASK(emacdata->mal_rx_chan);
+	err = mal_register_commac(edev->mal, &edev->commac);
 	if (err) {
 		printk(KERN_ERR "emac%d: failed to register with mal%d!\n",
-		       dev->def->index, emacdata->mal_idx);
+		       edev->def->index, emacdata->mal_idx);
 		goto out;
 	}
-	dev->rx_skb_size = emac_rx_skb_size(ndev->mtu);
-	dev->rx_sync_size = emac_rx_sync_size(ndev->mtu);
+	edev->rx_skb_size = emac_rx_skb_size(ndev->mtu);
+	edev->rx_sync_size = emac_rx_sync_size(ndev->mtu);
 
 	/* Get pointers to BD rings */
-	dev->tx_desc =
-	    dev->mal->bd_virt + mal_tx_bd_offset(dev->mal,
+	edev->tx_desc =
+	    edev->mal->bd_virt + mal_tx_bd_offset(edev->mal,
 						 emacdata->mal_tx_chan);
-	dev->rx_desc =
-	    dev->mal->bd_virt + mal_rx_bd_offset(dev->mal,
+	edev->rx_desc =
+	    edev->mal->bd_virt + mal_rx_bd_offset(edev->mal,
 						 emacdata->mal_rx_chan);
 
-	DBG("%d: tx_desc %p" NL, ocpdev->def->index, dev->tx_desc);
-	DBG("%d: rx_desc %p" NL, ocpdev->def->index, dev->rx_desc);
+	DBG("%d: tx_desc %p" NL, edev->def->index, edev->tx_desc);
+	DBG("%d: rx_desc %p" NL, edev->def->index, edev->rx_desc);
 
 	/* Clean rings */
-	memset(dev->tx_desc, 0, NUM_TX_BUFF * sizeof(struct mal_descriptor));
-	memset(dev->rx_desc, 0, NUM_RX_BUFF * sizeof(struct mal_descriptor));
-
-	/* If we depend on another EMAC for MDIO, check whether it was probed already */
-	if (emacdata->mdio_idx >= 0 && emacdata->mdio_idx != ocpdev->def->index) {
-		struct ocp_device *mdiodev =
-		    ocp_find_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC,
-				    emacdata->mdio_idx);
-		if (!mdiodev) {
-			printk(KERN_ERR "emac%d: unknown emac%d device!\n",
-			       dev->def->index, emacdata->mdio_idx);
-			err = -ENODEV;
-			goto out2;
-		}
-		dev->mdio_dev = ocp_get_drvdata(mdiodev);
-		if (!dev->mdio_dev) {
-			printk(KERN_ERR
-			       "emac%d: emac%d hasn't been initialized yet!\n",
-			       dev->def->index, emacdata->mdio_idx);
-			err = -ENODEV;
-			goto out2;
-		}
-	}
+	memset(edev->tx_desc, 0, NUM_TX_BUFF * sizeof(struct mal_descriptor));
+	memset(edev->rx_desc, 0, NUM_RX_BUFF * sizeof(struct mal_descriptor));
 
 	/* Attach to ZMII, if needed */
-	if ((err = zmii_attach(dev)) != 0)
+	if ((err = zmii_attach(edev)) != 0)
 		goto out2;
 
 	/* Attach to RGMII, if needed */
-	if ((err = rgmii_attach(dev)) != 0)
+	if ((err = rgmii_attach(edev)) != 0)
 		goto out3;
 
 	/* Attach to TAH, if needed */
-	if ((err = tah_attach(dev)) != 0)
+	if ((err = tah_attach(edev)) != 0)
 		goto out4;
 
 	/* Map EMAC regs */
-	dev->emacp = ioremap(dev->def->paddr, sizeof(struct emac_regs));
-	if (!dev->emacp) {
+	edev->emacp = ioremap(edev->def->paddr, sizeof(struct emac_regs));
+	if (!edev->emacp) {
 		printk(KERN_ERR "emac%d: could not ioremap device registers!\n",
-		       dev->def->index);
+		       edev->def->index);
 		err = -ENOMEM;
 		goto out5;
 	}
@@ -2060,43 +2038,43 @@ static int __init emac_probe(struct ocp_
 		ndev->dev_addr[i] = emacdata->mac_addr[i];
 
 	/* Set some link defaults before we can find out real parameters */
-	dev->phy.speed = SPEED_100;
-	dev->phy.duplex = DUPLEX_FULL;
-	dev->phy.autoneg = AUTONEG_DISABLE;
-	dev->phy.pause = dev->phy.asym_pause = 0;
-	dev->stop_timeout = STOP_TIMEOUT_100;
-	init_timer(&dev->link_timer);
-	dev->link_timer.function = emac_link_timer;
-	dev->link_timer.data = (unsigned long)dev;
+	edev->phy.speed = SPEED_100;
+	edev->phy.duplex = DUPLEX_FULL;
+	edev->phy.autoneg = AUTONEG_DISABLE;
+	edev->phy.pause = edev->phy.asym_pause = 0;
+	edev->stop_timeout = STOP_TIMEOUT_100;
+	init_timer(&edev->link_timer);
+	edev->link_timer.function = emac_link_timer;
+	edev->link_timer.data = (unsigned long)edev;
 
 	/* Find PHY if any */
-	dev->phy.dev = ndev;
-	dev->phy.mode = emacdata->phy_mode;
+	edev->phy.dev = ndev;
+	edev->phy.mode = emacdata->phy_mode;
 	if (emacdata->phy_map != 0xffffffff) {
 		u32 phy_map = emacdata->phy_map | busy_phy_map;
 		u32 adv;
 
-		DBG("%d: PHY maps %08x %08x" NL, dev->def->index,
+		DBG("%d: PHY maps %08x %08x" NL, edev->def->index,
 		    emacdata->phy_map, busy_phy_map);
 
-		EMAC_RX_CLK_TX(dev->def->index);
+		EMAC_RX_CLK_TX(edev->def->index);
 
-		dev->phy.mdio_read = emac_mdio_read;
-		dev->phy.mdio_write = emac_mdio_write;
+		edev->phy.mdio_read = emac_mdio_read;
+		edev->phy.mdio_write = emac_mdio_write;
 
 		/* Configure EMAC with defaults so we can at least use MDIO
 		 * This is needed mostly for 440GX
 		 */
-		if (emac_phy_gpcs(dev->phy.mode)) {
+		if (emac_phy_gpcs(edev->phy.mode)) {
 			/* XXX
 			 * Make GPCS PHY address equal to EMAC index.
 			 * We probably should take into account busy_phy_map
 			 * and/or phy_map here.
 			 */
-			dev->phy.address = dev->def->index;
+			edev->phy.address = edev->def->index;
 		}
 		
-		emac_configure(dev);
+		emac_configure(edev);
 
 		for (i = 0; i < 0x20; phy_map >>= 1, ++i)
 			if (!(phy_map & 1)) {
@@ -2104,35 +2082,35 @@ static int __init emac_probe(struct ocp_
 				busy_phy_map |= 1 << i;
 
 				/* Quick check if there is a PHY at the address */
-				r = emac_mdio_read(dev->ndev, i, MII_BMCR);
+				r = emac_mdio_read(edev->ndev, i, MII_BMCR);
 				if (r == 0xffff || r < 0)
 					continue;
-				if (!mii_phy_probe(&dev->phy, i))
+				if (!mii_phy_probe(&edev->phy, i))
 					break;
 			}
 		if (i == 0x20) {
 			printk(KERN_WARNING "emac%d: can't find PHY!\n",
-			       dev->def->index);
+			       edev->def->index);
 			goto out6;
 		}
 
 		/* Init PHY */
-		if (dev->phy.def->ops->init)
-			dev->phy.def->ops->init(&dev->phy);
+		if (edev->phy.def->ops->init)
+			edev->phy.def->ops->init(&edev->phy);
 		
 		/* Disable any PHY features not supported by the platform */
-		dev->phy.def->features &= ~emacdata->phy_feat_exc;
+		edev->phy.def->features &= ~emacdata->phy_feat_exc;
 
 		/* Setup initial link parameters */
-		if (dev->phy.features & SUPPORTED_Autoneg) {
-			adv = dev->phy.features;
+		if (edev->phy.features & SUPPORTED_Autoneg) {
+			adv = edev->phy.features;
 #if !defined(CONFIG_40x)
 			adv |= ADVERTISED_Pause | ADVERTISED_Asym_Pause;
 #endif
 			/* Restart autonegotiation */
-			dev->phy.def->ops->setup_aneg(&dev->phy, adv);
+			edev->phy.def->ops->setup_aneg(&edev->phy, adv);
 		} else {
-			u32 f = dev->phy.def->features;
+			u32 f = edev->phy.def->features;
 			int speed = SPEED_10, fd = DUPLEX_HALF;
 
 			/* Select highest supported speed/duplex */
@@ -2150,22 +2128,22 @@ static int __init emac_probe(struct ocp_
 				fd = DUPLEX_FULL;
 
 			/* Force link parameters */
-			dev->phy.def->ops->setup_forced(&dev->phy, speed, fd);
+			edev->phy.def->ops->setup_forced(&edev->phy, speed, fd);
 		}
 	} else {
-		emac_reset(dev);
+		emac_reset(edev);
 
 		/* PHY-less configuration.
 		 * XXX I probably should move these settings to emacdata
 		 */
-		dev->phy.address = -1;
-		dev->phy.features = SUPPORTED_100baseT_Full | SUPPORTED_MII;
-		dev->phy.pause = 1;
+		edev->phy.address = -1;
+		edev->phy.features = SUPPORTED_100baseT_Full | SUPPORTED_MII;
+		edev->phy.pause = 1;
 	}
 
 	/* Fill in the driver function table */
 	ndev->open = &emac_open;
-	if (dev->tah_dev) {
+	if (edev->tah_dev) {
 		ndev->hard_start_xmit = &emac_start_xmit_sg;
 		ndev->features |= NETIF_F_IP_CSUM | NETIF_F_SG;
 	} else
@@ -2178,7 +2156,7 @@ static int __init emac_probe(struct ocp_
 	ndev->do_ioctl = &emac_ioctl;
 	if (emac_phy_supports_gige(emacdata->phy_mode)) {
 		ndev->change_mtu = &emac_change_mtu;
-		dev->commac.ops = &emac_commac_sg_ops;
+		edev->commac.ops = &emac_commac_sg_ops;
 	}
 	SET_ETHTOOL_OPS(ndev, &emac_ethtool_ops);
 
@@ -2188,39 +2166,295 @@ static int __init emac_probe(struct ocp_
 	err = register_netdev(ndev);
 	if (err) {
 		printk(KERN_ERR "emac%d: failed to register net device (%d)!\n",
-		       dev->def->index, err);
+		       edev->def->index, err);
 		goto out6;
 	}
 
-	ocp_set_drvdata(ocpdev, dev);
+	bus_set_drvdata(dev, edev);
 
 	printk("%s: emac%d, MAC %02x:%02x:%02x:%02x:%02x:%02x\n",
-	       ndev->name, dev->def->index,
+	       ndev->name, edev->def->index,
 	       ndev->dev_addr[0], ndev->dev_addr[1], ndev->dev_addr[2],
 	       ndev->dev_addr[3], ndev->dev_addr[4], ndev->dev_addr[5]);
 
-	if (dev->phy.address >= 0)
+	if (edev->phy.address >= 0)
 		printk("%s: found %s PHY (0x%02x)\n", ndev->name,
-		       dev->phy.def->name, dev->phy.address);
+		       edev->phy.def->name, edev->phy.address);
 
-	emac_dbg_register(dev->def->index, dev);
+	emac_dbg_register(edev->def->index, edev);
 
 	return 0;
-      out6:
-	iounmap(dev->emacp);
-      out5:
-	tah_fini(dev->tah_dev);
-      out4:
-	rgmii_fini(dev->rgmii_dev, dev->rgmii_input);
-      out3:
-	zmii_fini(dev->zmii_dev, dev->zmii_input);
-      out2:
-	mal_unregister_commac(dev->mal, &dev->commac);
-      out:
+ out6:
+	iounmap(edev->emacp);
+ out5:
+	tah_fini(edev->tah_dev);
+ out4:
+	rgmii_fini(edev->rgmii_dev, edev->rgmii_input);
+ out3:
+	zmii_fini(edev->zmii_dev, edev->zmii_input);
+ out2:
+	mal_unregister_commac(edev->mal, &edev->commac);
+ out:
+	return err;
+}
+
+#ifdef CONFIG_IBM_EMAC_OCP
+static int __init emac_probe(struct ocp_device *dev)
+{
+	struct ocp_func_emac_data *emacdata = dev->def->additions;
+	struct emac_subdev *maldev;
+	struct net_device *ndev;
+	struct ocp_enet_private *edev;
+	int err, i;
+
+	DBG("%d: probe" NL, dev->def->index);
+
+	if (!emacdata) {
+		printk(KERN_ERR "emac%d: Missing additional data!\n",
+		       dev->def->index);
+		return -ENODEV;
+	}
+
+	/* Allocate our net_device structure */
+	ndev = alloc_etherdev(sizeof(struct ocp_enet_private));
+	if (!ndev) {
+		printk(KERN_ERR "emac%d: could not allocate ethernet device!\n",
+		       ocpdev->def->index);
+		return -ENOMEM;
+	}
+	dev = ndev->priv;
+	dev->ndev = ndev;
+	dev->ldev = &ocpdev->dev;
+	dev->def = ocpdev->def;
+	SET_MODULE_OWNER(ndev);
+
+	/* If we depend on another EMAC for MDIO, check whether it was probed already */
+	if (emacdata->mdio_idx >= 0 && emacdata->mdio_idx != edev->def->index) {
+		struct ocp_device *mdiodev =
+		    ocp_find_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC,
+				    emacdata->mdio_idx);
+		if (!mdiodev) {
+			printk(KERN_ERR "emac%d: unknown emac%d device!\n",
+			       edev->def->index, emacdata->mdio_idx);
+			err = -ENODEV;
+			goto out;
+		}
+		edev->mdio_dev = bus_get_drvdata(mdiodev);
+		if (!edev->mdio_dev) {
+			printk(KERN_ERR
+			       "emac%d: emac%d hasn't been initialized yet!\n",
+			       edev->def->index, emacdata->mdio_idx);
+			err = -ENODEV;
+			goto out;
+		}
+	}
+
+	maldev = ocp_find_device(OCP_VENDOR_IBM, OCP_FUNC_MAL,
+				 emacdata->mal_idx);
+	if (!maldev) {
+		printk(KERN_ERR "emac%d: unknown mal%d device!\n",
+		       edev->def->index, emacdata->mal_idx);
+		err = -ENODEV;
+		goto out;
+	}
+	edev->mal = bus_get_drvdata(maldev);
+	if (!edev->mal) {
+		printk(KERN_ERR "emac%d: mal%d hasn't been initialized yet!\n",
+		       edev->def->index, emacdata->mal_idx);
+		err = -ENODEV;
+		goto out;
+	}
+
+	err = emac_setup(ndev, emacdata, dev);
+	if (err != 0)
+		goto out;
+	return 0;
+ out:
 	kfree(ndev);
+
 	return err;
 }
 
+#else
+static unsigned int * ibm_emac_get_property(int dev_nr,
+			 	      struct device_node * node,
+				      const char * name)
+{
+	unsigned int * ret = (unsigned int *)get_property(node, name, NULL);
+	if (!ret) {
+		printk(KERN_ERR
+		       "emac%d: can't find EMAC %s property!\n",
+		       dev_nr, name);
+	}
+	return ret;
+}
+
+static struct emac_subdev *emac_wait_subdev(struct device_node *np)
+{
+	struct emac_subdev *sd;
+	int timeout = 10;
+
+	while(timeout--) {
+		sd = of_find_device_by_node(np);
+		if (sd != NULL && bus_get_drvdata(sd) != NULL)
+			return sd;
+		of_dev_put(sd);
+		msleep(1);
+	}
+	printk(KERN_ERR "emac: timed out waiting for %s driver\n",
+	       np->full_name);
+	return NULL;
+}
+
+static int __init emac_probe(struct of_device *dev,
+			     const struct of_device_id *match)
+{
+	struct ocp_func_emac_data *emacdata = NULL;
+ 	struct net_device *ndev = NULL;
+ 	struct emac_subdev *maldev;
+ 	struct ocp_enet_private *edev;
+	struct device_node *malnode;
+ 	int err = -ENODEV;
+ 	static int index = 0;
+	struct resource r;
+ 	const u32 *phy_dev, *phy_port, *data;
+
+ 	emacdata = kzalloc(sizeof(struct ocp_func_emac_data) +
+ 			   sizeof(struct ocp_def), GFP_KERNEL);
+ 	if (!emacdata) {
+ 		printk(KERN_ERR
+ 		       "emac%d: could not allocate EMAC data structure!\n",
+ 		       index);
+ 		return -ENOMEM;
+ 	}
+
+ 	emacdata->rgmii_idx = -1;
+ 	emacdata->zmii_idx = -1;
+ 	emacdata->mdio_idx = -1;
+ 	emacdata->mal_idx = -1;
+ 	emacdata->tah_idx = -1;
+
+	data = ibm_emac_get_property(index, dev->node, "phy-map");
+	if (!data) goto out;
+	emacdata->phy_map = *data;
+
+	data = ibm_emac_get_property(index, dev->node, "phy-mode");
+	if (!data) goto out;
+	emacdata->phy_mode = *data;
+
+	phy_dev = ibm_emac_get_property(index, dev->node, "phy-device");
+	if (!phy_dev) goto out;
+	phy_port = ibm_emac_get_property(index, dev->node, "phy-port");
+	if (!phy_port) goto out;
+
+	switch (emacdata->phy_mode) {
+		case PHY_MODE_RGMII :
+		case PHY_MODE_GMII :
+		case PHY_MODE_TBI :
+		case PHY_MODE_RTBI :
+			emacdata->rgmii_idx = *phy_dev;
+			emacdata->rgmii_mux = *phy_port;
+			break;
+		case PHY_MODE_MII :
+		case PHY_MODE_RMII :
+ 		case PHY_MODE_SMII :
+		case PHY_MODE_NA :
+ 			emacdata->zmii_idx = *phy_dev;
+			emacdata->zmii_mux = *phy_port;
+		default :
+			printk(KERN_ERR
+			       "emac%d: invalid EMAC phy-mode value %d!\n",
+ 			       index, emacdata->phy_mode);
+			goto out;
+	}
+	data = ibm_emac_get_property(index, dev->node, "mal-device");
+	if (!data) goto out;
+	emacdata->mal_idx = *data;
+
+	data = ibm_emac_get_property(index, dev->node, "mal-rx-channel");
+	if (!data) goto out;
+	emacdata->mal_rx_chan = *data;
+
+	data = ibm_emac_get_property(index, dev->node, "mal-tx-channel");
+	if (!data) goto out;
+	emacdata->mal_tx_chan = *data;
+
+	data = ibm_emac_get_property(index, dev->node, "local-mac-address");
+	if (!data) goto out;
+	memcpy(emacdata->mac_addr, (u8 *)data, sizeof emacdata->mac_addr);
+
+	if (of_address_to_resource(dev->node, 0, &r)) {
+		printk(KERN_ERR
+		       "emac%d: can't find EMAC register property!\n",
+		       index);
+		goto out;
+	}
+
+	/* Allocate our net_device structure */
+	ndev = alloc_etherdev(sizeof(struct ocp_enet_private));
+	if (!ndev) {
+		printk(KERN_ERR
+		       "emac%d: could not allocate ethernet device!\n",
+		       index);
+		kfree(emacdata);
+		err = -ENOMEM;
+		goto out;
+	}
+	edev = ndev->priv;
+	memset(edev, 0, sizeof(struct ocp_enet_private));
+
+	edev->ndev = ndev;
+	edev->ldev = &dev->dev;
+	edev->def = (struct ocp_def *)(emacdata + 1);
+	edev->def->additions = emacdata;
+	edev->def->index = index++;
+	edev->def->paddr = r.start;
+	edev->def->irq = irq_of_parse_and_map(dev->node, 0);
+	SET_MODULE_OWNER(ndev);
+
+  	/* Find MAL device we are connected to */
+	data = get_property(dev->node, "mal-device", NULL);
+	if (data == NULL) {
+		printk(KERN_ERR "emac%d: can't find mal-device property !\n",
+		      edev->def->index);
+		goto out;
+	}
+	malnode = of_find_node_by_phandle(*data);
+	if (malnode == NULL) {
+		printk(KERN_ERR "emac%d: can't locate MAL device !\n",
+		       edev->def->index);
+		goto out;
+	}
+	maldev = emac_wait_subdev(malnode);
+	if (!maldev) {
+		printk(KERN_ERR "emac%d: unknown mal%d device!\n",
+		       edev->def->index, emacdata->mal_idx);
+		err = -ENODEV;
+		goto out;
+	}
+	edev->mal = bus_get_drvdata(maldev);
+	if (!edev->mal) {
+		printk(KERN_ERR "emac%d: mal%d hasn't been initialized yet!\n",
+		       edev->def->index, emacdata->mal_idx);
+		err = -ENODEV;
+		goto out;
+	}
+
+	err = emac_setup(ndev, emacdata, dev);
+	if (err != 0)
+		goto out;
+	return 0;
+
+ out:
+	kfree(ndev);
+	kfree(emacdata);
+
+	return err;
+}
+
+#endif
+
+#ifdef CONFIG_IBM_EMAC_OCP
 static struct ocp_device_id emac_ids[] = {
 	{ .vendor = OCP_VENDOR_IBM, .function = OCP_FUNC_EMAC },
 	{ .vendor = OCP_VENDOR_INVALID}
@@ -2232,6 +2466,28 @@ static struct ocp_driver emac_driver = {
 	.probe = emac_probe,
 	.remove = emac_remove,
 };
+#else
+static struct of_device_id emac_platform_match[] =
+{
+	{
+		.name		= "ethernet",
+		.type		= "network",
+	},
+	{},
+};
+
+static struct of_platform_driver emac_driver = {
+	.name = "emac",
+	.match_table = emac_platform_match,
+
+	.probe = emac_probe,
+	.remove = emac_remove,
+
+	.driver = {
+		.multithread_probe = 1,
+	},
+};
+#endif
 
 static int __init emac_init(void)
 {
@@ -2243,12 +2499,16 @@ static int __init emac_init(void)
 		return -ENODEV;
 
 	EMAC_CLK_INTERNAL;
+#ifdef CONFIG_IBM_EMAC_OCP
 	if (ocp_register_driver(&emac_driver)) {
 		EMAC_CLK_EXTERNAL;
 		ocp_unregister_driver(&emac_driver);
 		mal_exit();
 		return -ENODEV;
 	}
+#else
+	of_register_platform_driver(&emac_driver);
+#endif
 	EMAC_CLK_EXTERNAL;
 
 	emac_init_debug();
@@ -2258,7 +2518,11 @@ static int __init emac_init(void)
 static void __exit emac_exit(void)
 {
 	DBG(": exit" NL);
+#ifdef CONFIG_IBM_EMAC_OCP
 	ocp_unregister_driver(&emac_driver);
+#else
+	of_unregister_platform_driver(&emac_driver);
+#endif
 	mal_exit();
 	emac_fini_debug();
 }
Index: linux-cell/drivers/net/ibm_emac/ibm_emac_rgmii.c
===================================================================
--- linux-cell.orig/drivers/net/ibm_emac/ibm_emac_rgmii.c	2006-11-06 16:38:24.000000000 +1100
+++ linux-cell/drivers/net/ibm_emac/ibm_emac_rgmii.c	2006-11-06 16:38:27.000000000 +1100
@@ -20,10 +20,20 @@
 #include <linux/ethtool.h>
 #include <asm/io.h>
 
+#ifndef CONFIG_IBM_EMAC_OCP
+#include <asm/of_platform.h>
+#endif
+
+#include "ibm_emac_busdev.h"
 #include "ibm_emac_core.h"
 #include "ibm_emac_debug.h"
 
-/* RGMIIx_FER */
+/* RGMIIx_FER XXXX  */
+#if defined(CONFIG_PPC_CELL)
+#define RGMII_FER_MDI(idx)	(0x80000000 >> ((idx) + 12))
+#define RGMII_FER_MDI_ALL	(RGMII_FER_MDI(0) | RGMII_FER_MDI(1) | \
+				 RGMII_FER_MDI(2) | RGMII_FER_MDI(3))
+#endif
 #define RGMII_FER_MASK(idx)	(0x7 << ((idx) * 4))
 #define RGMII_FER_RTBI(idx)	(0x4 << ((idx) * 4))
 #define RGMII_FER_RGMII(idx)	(0x5 << ((idx) * 4))
@@ -58,6 +68,8 @@ static inline const char *rgmii_mode_nam
 	default:
 		BUG();
 	}
+
+	return NULL;
 }
 
 static inline u32 rgmii_mode_mask(int mode, int input)
@@ -74,49 +86,62 @@ static inline u32 rgmii_mode_mask(int mo
 	default:
 		BUG();
 	}
+
+	return 0;
 }
 
-static int __init rgmii_init(struct ocp_device *ocpdev, int input, int mode)
+static int __init rgmii_init(struct emac_subdev *dev, int input, int mode)
 {
-	struct ibm_ocp_rgmii *dev = ocp_get_drvdata(ocpdev);
+	struct ibm_ocp_rgmii *rdev = bus_get_drvdata(dev);
 	struct rgmii_regs *p;
+	struct resource r;
 
-	RGMII_DBG("%d: init(%d, %d)" NL, ocpdev->def->index, input, mode);
+	RGMII_DBG(": init(%d, %d)" NL, input, mode);
 
-	if (!dev) {
-		dev = kzalloc(sizeof(struct ibm_ocp_rgmii), GFP_KERNEL);
-		if (!dev) {
+	if (!rdev) {
+		rdev = kzalloc(sizeof(struct ibm_ocp_rgmii), GFP_KERNEL);
+		if (!rdev) {
 			printk(KERN_ERR
-			       "rgmii%d: couldn't allocate device structure!\n",
-			       ocpdev->def->index);
+			       "rgmii: couldn't allocate device structure!\n");
 			return -ENOMEM;
 		}
 
-		p = (struct rgmii_regs *)ioremap(ocpdev->def->paddr,
+#ifdef CONFIG_IBM_EMAC_OCP
+		p = (struct rgmii_regs *)ioremap(dev->def->paddr,
 						 sizeof(struct rgmii_regs));
+#else
+		if (of_address_to_resource(dev->node, 0, &r)) {
+			of_node_put(dev->node);
+			printk(KERN_ERR
+			       "rgmii: can't find RGMII register property!\n");
+			kfree(rdev);
+			return -EINVAL;
+		}
+		p = (struct rgmii_regs *)ioremap(r.start, sizeof *p);
+#endif
 		if (!p) {
 			printk(KERN_ERR
-			       "rgmii%d: could not ioremap device registers!\n",
-			       ocpdev->def->index);
-			kfree(dev);
+			       "rgmii: could not ioremap device registers!\n");
+			kfree(rdev);
 			return -ENOMEM;
 		}
 
-		dev->base = p;
-		ocp_set_drvdata(ocpdev, dev);
+		rdev->base = p;
+
+		bus_set_drvdata(dev, rdev);
 
 		/* Disable all inputs by default */
 		out_be32(&p->fer, 0);
 	} else
-		p = dev->base;
+		p = rdev->base;
 
 	/* Enable this input */
 	out_be32(&p->fer, in_be32(&p->fer) | rgmii_mode_mask(mode, input));
 
-	printk(KERN_NOTICE "rgmii%d: input %d in %s mode\n",
-	       ocpdev->def->index, input, rgmii_mode_name(mode));
+	printk(KERN_NOTICE "rgmii: input %d in %s mode\n",
+	       input, rgmii_mode_name(mode));
 
-	++dev->users;
+	++rdev->users;
 	return 0;
 }
 
@@ -127,74 +152,102 @@ int __init rgmii_attach(void *emac)
 
 	/* Check if we need to attach to a RGMII */
 	if (emacdata->rgmii_idx >= 0 && rgmii_valid_mode(emacdata->phy_mode)) {
-		dev->rgmii_input = emacdata->rgmii_mux;
+#ifdef CONFIG_IBM_EMAC_OCP
 		dev->rgmii_dev =
 		    ocp_find_device(OCP_VENDOR_IBM, OCP_FUNC_RGMII,
 				    emacdata->rgmii_idx);
+#else
+		struct device_node * node =
+			of_find_node_by_phandle(emacdata->rgmii_idx);
+		if (!node) {
+			printk(KERN_ERR
+			       "emac%d: rgmii%d can't find PHY device node!\n",
+			       dev->def->index, emacdata->rgmii_idx);
+			return -ENODEV;
+		}
+		dev->rgmii_dev = of_find_device_by_node(node);
+#endif
+		dev->rgmii_input = emacdata->rgmii_mux;
+
 		if (!dev->rgmii_dev) {
 			printk(KERN_ERR "emac%d: unknown rgmii%d!\n",
 			       dev->def->index, emacdata->rgmii_idx);
 			return -ENODEV;
 		}
+
 		if (rgmii_init
 		    (dev->rgmii_dev, dev->rgmii_input, emacdata->phy_mode)) {
 			printk(KERN_ERR
-			       "emac%d: rgmii%d initialization failed!\n",
-			       dev->def->index, emacdata->rgmii_idx);
+			       "emac: rgmii%d initialization failed!\n",
+			       emacdata->rgmii_idx);
 			return -ENODEV;
 		}
 	}
 	return 0;
 }
 
-void rgmii_set_speed(struct ocp_device *ocpdev, int input, int speed)
+void rgmii_enable_mdio(struct emac_subdev *dev, int input)
+{
+	struct ibm_ocp_rgmii *rdev = bus_get_drvdata(dev);
+	u32 fer = in_be32(&rdev->base->fer) & ~RGMII_FER_MDI_ALL;
+
+	RGMII_DBG2(": mdio(%d)" NL, input);
+
+	out_be32(&rdev->base->fer, fer | RGMII_FER_MDI(input));
+}
+
+void rgmii_set_speed(struct emac_subdev *dev, int input, int speed)
 {
-	struct ibm_ocp_rgmii *dev = ocp_get_drvdata(ocpdev);
-	u32 ssr = in_be32(&dev->base->ssr) & ~RGMII_SSR_MASK(input);
+	struct ibm_ocp_rgmii *rdev = bus_get_drvdata(dev);
+	u32 ssr = in_be32(&rdev->base->ssr) & ~RGMII_SSR_MASK(input);
 
-	RGMII_DBG("%d: speed(%d, %d)" NL, ocpdev->def->index, input, speed);
+	RGMII_DBG(": speed(%d, %d)" NL, input, speed);
 
 	if (speed == SPEED_1000)
 		ssr |= RGMII_SSR_1000(input);
 	else if (speed == SPEED_100)
 		ssr |= RGMII_SSR_100(input);
 
-	out_be32(&dev->base->ssr, ssr);
+	out_be32(&rdev->base->ssr, ssr);
 }
 
-void __exit __rgmii_fini(struct ocp_device *ocpdev, int input)
+void __exit __rgmii_fini(struct emac_subdev *dev, int input)
 {
-	struct ibm_ocp_rgmii *dev = ocp_get_drvdata(ocpdev);
-	BUG_ON(!dev || dev->users == 0);
+	struct ibm_ocp_rgmii *rdev = bus_get_drvdata(dev);
+	BUG_ON(!rdev || rdev->users == 0);
 
-	RGMII_DBG("%d: fini(%d)" NL, ocpdev->def->index, input);
+	RGMII_DBG(": fini(%d)" NL, input);
 
 	/* Disable this input */
-	out_be32(&dev->base->fer,
-		 in_be32(&dev->base->fer) & ~RGMII_FER_MASK(input));
+	out_be32(&rdev->base->fer,
+		 in_be32(&rdev->base->fer) & ~RGMII_FER_MASK(input));
 
-	if (!--dev->users) {
+	if (!--rdev->users) {
 		/* Free everything if this is the last user */
-		ocp_set_drvdata(ocpdev, NULL);
-		iounmap((void *)dev->base);
-		kfree(dev);
+		bus_set_drvdata(dev, NULL);
+		iounmap((void *)rdev->base);
+		kfree(rdev);
 	}
 }
 
-int __rgmii_get_regs_len(struct ocp_device *ocpdev)
+int __rgmii_get_regs_len(struct emac_subdev *dev)
 {
 	return sizeof(struct emac_ethtool_regs_subhdr) +
 	    sizeof(struct rgmii_regs);
 }
 
-void *rgmii_dump_regs(struct ocp_device *ocpdev, void *buf)
+void *rgmii_dump_regs(struct emac_subdev *dev, void *buf)
 {
-	struct ibm_ocp_rgmii *dev = ocp_get_drvdata(ocpdev);
+	struct ibm_ocp_rgmii *rdev = bus_get_drvdata(dev);
 	struct emac_ethtool_regs_subhdr *hdr = buf;
 	struct rgmii_regs *regs = (struct rgmii_regs *)(hdr + 1);
 
 	hdr->version = 0;
-	hdr->index = ocpdev->def->index;
-	memcpy_fromio(regs, dev->base, sizeof(struct rgmii_regs));
+#ifdef CONFIG_IBM_EMAC_OCP
+	hdr->index = pdev->def->index;
+#else
+	hdr->index = 0;
+#endif
+	memcpy_fromio(regs, rdev->base, sizeof(struct rgmii_regs));
 	return regs + 1;
 }
Index: linux-cell/drivers/net/ibm_emac/ibm_emac_rgmii.h
===================================================================
--- linux-cell.orig/drivers/net/ibm_emac/ibm_emac_rgmii.h	2006-11-06 16:38:24.000000000 +1100
+++ linux-cell/drivers/net/ibm_emac/ibm_emac_rgmii.h	2006-11-06 16:38:27.000000000 +1100
@@ -21,6 +21,7 @@
 #ifndef _IBM_EMAC_RGMII_H_
 #define _IBM_EMAC_RGMII_H_
 
+#include "ibm_emac_busdev.h"
 
 /* RGMII bridge */
 struct rgmii_regs {
@@ -37,22 +38,23 @@ struct ibm_ocp_rgmii {
 #ifdef CONFIG_IBM_EMAC_RGMII
 int rgmii_attach(void *emac) __init;
 
-void __rgmii_fini(struct ocp_device *ocpdev, int input) __exit;
-static inline void rgmii_fini(struct ocp_device *ocpdev, int input)
+void __rgmii_fini(struct emac_subdev *dev, int input) __exit;
+static inline void rgmii_fini(struct emac_subdev *dev, int input)
 {
-	if (ocpdev)
-		__rgmii_fini(ocpdev, input);
+	if (dev)
+		__rgmii_fini(dev, input);
 }
 
-void rgmii_set_speed(struct ocp_device *ocpdev, int input, int speed);
-
-int __rgmii_get_regs_len(struct ocp_device *ocpdev);
-static inline int rgmii_get_regs_len(struct ocp_device *ocpdev)
+int __rgmii_get_regs_len(struct emac_subdev *dev);
+static inline int rgmii_get_regs_len(struct emac_subdev *dev)
 {
-	return ocpdev ? __rgmii_get_regs_len(ocpdev) : 0;
+	return dev ? __rgmii_get_regs_len(dev) : 0;
 }
 
-void *rgmii_dump_regs(struct ocp_device *ocpdev, void *buf);
+void rgmii_set_speed(struct emac_subdev *dev, int input, int speed);
+void rgmii_enable_mdio(struct emac_subdev *dev, int input);
+void *rgmii_dump_regs(struct emac_subdev *dev, void *buf);
+
 #else
 # define rgmii_attach(x)	0
 # define rgmii_fini(x,y)	((void)0)
Index: linux-cell/drivers/net/ibm_emac/ibm_emac_zmii.c
===================================================================
--- linux-cell.orig/drivers/net/ibm_emac/ibm_emac_zmii.c	2006-11-06 16:38:24.000000000 +1100
+++ linux-cell/drivers/net/ibm_emac/ibm_emac_zmii.c	2006-11-06 16:38:27.000000000 +1100
@@ -20,6 +20,10 @@
 #include <linux/ethtool.h>
 #include <asm/io.h>
 
+#ifndef CONFIG_IBM_EMAC_OCP
+#include <asm/of_platform.h>
+#endif
+
 #include "ibm_emac_core.h"
 #include "ibm_emac_debug.h"
 
@@ -60,6 +64,8 @@ static inline const char *zmii_mode_name
 	default:
 		BUG();
 	}
+
+	return NULL;
 }
 
 static inline u32 zmii_mode_mask(int mode, int input)
@@ -76,41 +82,53 @@ static inline u32 zmii_mode_mask(int mod
 	}
 }
 
-static int __init zmii_init(struct ocp_device *ocpdev, int input, int *mode)
+static int __init zmii_init(struct emac_subdev *dev, int input, int *mode)
 {
-	struct ibm_ocp_zmii *dev = ocp_get_drvdata(ocpdev);
+	struct ibm_ocp_zmii *zdev = bus_get_drvdata(dev);
 	struct zmii_regs __iomem *p;
+	unsigned long *reg;
 
-	ZMII_DBG("%d: init(%d, %d)" NL, ocpdev->def->index, input, *mode);
+	ZMII_DBG(": init(%d, %d)" NL, input, *mode);
 
-	if (!dev) {
-		dev = kzalloc(sizeof(struct ibm_ocp_zmii), GFP_KERNEL);
-		if (!dev) {
+	if (!zdev) {
+		zdev = kzalloc(sizeof(struct ibm_ocp_zmii), GFP_KERNEL);
+		if (!zdev) {
 			printk(KERN_ERR
-			       "zmii%d: couldn't allocate device structure!\n",
-			       ocpdev->def->index);
+			       "zmii: couldn't allocate device structure!\n");
 			return -ENOMEM;
 		}
-		dev->mode = PHY_MODE_NA;
+		zdev->mode = PHY_MODE_NA;
 
+#ifdef CONFIG_IBM_EMAC_OCP
 		p = ioremap(ocpdev->def->paddr, sizeof(struct zmii_regs));
+#else
+		reg = (unsigned long *)get_property(dev->node, "reg", NULL);
+ 		if (reg == NULL) {
+ 			of_node_put(dev->node);
+ 			printk(KERN_ERR
+ 			       "rgmii: can't find ZMII register property!\n");
+ 			kfree(zdev);
+ 			return -EINVAL;
+ 		}
+
+ 		p = (struct zmii_regs *)ioremap(reg[0], reg[1]);
+#endif
 		if (!p) {
 			printk(KERN_ERR
-			       "zmii%d: could not ioremap device registers!\n",
-			       ocpdev->def->index);
-			kfree(dev);
+			       "zmii: could not ioremap device registers!\n");
+			kfree(zdev);
 			return -ENOMEM;
 		}
-		dev->base = p;
-		ocp_set_drvdata(ocpdev, dev);
+		zdev->base = p;
+		bus_set_drvdata(dev, dev);
 		
 		/* We may need FER value for autodetection later */
-		dev->fer_save = in_be32(&p->fer);
+		zdev->fer_save = in_be32(&p->fer);
 
 		/* Disable all inputs by default */
 		out_be32(&p->fer, 0);
 	} else
-		p = dev->base;
+		p = zdev->base;
 
 	if (!zmii_valid_mode(*mode)) {
 		/* Probably an EMAC connected to RGMII, 
@@ -124,30 +142,29 @@ static int __init zmii_init(struct ocp_d
 	 * Please, always specify PHY mode in your board port to avoid
 	 * any surprises.
 	 */
-	if (dev->mode == PHY_MODE_NA) {
+	if (zdev->mode == PHY_MODE_NA) {
 		if (*mode == PHY_MODE_NA) {
-			u32 r = dev->fer_save;
+			u32 r = zdev->fer_save;
 
-			ZMII_DBG("%d: autodetecting mode, FER = 0x%08x" NL,
-				 ocpdev->def->index, r);
+			ZMII_DBG(": autodetecting mode, FER = 0x%08x" NL, r);
 			
 			if (r & (ZMII_FER_MII(0) | ZMII_FER_MII(1)))
-				dev->mode = PHY_MODE_MII;
+				zdev->mode = PHY_MODE_MII;
 			else if (r & (ZMII_FER_RMII(0) | ZMII_FER_RMII(1)))
-				dev->mode = PHY_MODE_RMII;
+				zdev->mode = PHY_MODE_RMII;
 			else
-				dev->mode = PHY_MODE_SMII;
+				zdev->mode = PHY_MODE_SMII;
 		} else
-			dev->mode = *mode;
+			zdev->mode = *mode;
 
-		printk(KERN_NOTICE "zmii%d: bridge in %s mode\n",
-		       ocpdev->def->index, zmii_mode_name(dev->mode));
+		printk(KERN_NOTICE "zmii: bridge in %s mode\n",
+		       zmii_mode_name(zdev->mode));
 	} else {
 		/* All inputs must use the same mode */
-		if (*mode != PHY_MODE_NA && *mode != dev->mode) {
+		if (*mode != PHY_MODE_NA && *mode != zdev->mode) {
 			printk(KERN_ERR
-			       "zmii%d: invalid mode %d specified for input %d\n",
-			       ocpdev->def->index, *mode, input);
+			       "zmii: invalid mode %d specified for input %d\n",
+			       *mode, input);
 			return -EINVAL;
 		}
 	}
@@ -155,12 +172,12 @@ static int __init zmii_init(struct ocp_d
 	/* Report back correct PHY mode, 
 	 * it may be used during PHY initialization.
 	 */
-	*mode = dev->mode;
+	*mode = zdev->mode;
 
 	/* Enable this input */
-	out_be32(&p->fer, in_be32(&p->fer) | zmii_mode_mask(dev->mode, input));
+	out_be32(&p->fer, in_be32(&p->fer) | zmii_mode_mask(zdev->mode, input));
       out:
-	++dev->users;
+	++zdev->users;
 	return 0;
 }
 
@@ -170,10 +187,24 @@ int __init zmii_attach(void *emac)
 	struct ocp_func_emac_data *emacdata = dev->def->additions;
 
 	if (emacdata->zmii_idx >= 0) {
-		dev->zmii_input = emacdata->zmii_mux;
+#ifdef CONFIG_IBM_EMAC_OCP
 		dev->zmii_dev =
 		    ocp_find_device(OCP_VENDOR_IBM, OCP_FUNC_ZMII,
 				    emacdata->zmii_idx);
+#else
+ 		struct device_node * node =
+ 			of_find_node_by_phandle(emacdata->zmii_idx);
+ 		if (!node || strcmp(node->type, "zmii")) {
+ 			printk(KERN_ERR
+ 			       "emac: zmii%d can't find PHY device node!\n",
+ 			       emacdata->zmii_idx);
+ 			return -ENODEV;
+ 		}
+
+ 		dev->zmii_dev = of_find_device_by_node(node);
+#endif
+ 		dev->zmii_input = emacdata->zmii_mux;
+
 		if (!dev->zmii_dev) {
 			printk(KERN_ERR "emac%d: unknown zmii%d!\n",
 			       dev->def->index, emacdata->zmii_idx);
@@ -190,64 +221,68 @@ int __init zmii_attach(void *emac)
 	return 0;
 }
 
-void __zmii_enable_mdio(struct ocp_device *ocpdev, int input)
+void __zmii_enable_mdio(struct emac_subdev *dev, int input)
 {
-	struct ibm_ocp_zmii *dev = ocp_get_drvdata(ocpdev);
-	u32 fer = in_be32(&dev->base->fer) & ~ZMII_FER_MDI_ALL;
+	struct ibm_ocp_zmii *zdev = bus_get_drvdata(dev);
+	u32 fer = in_be32(&zdev->base->fer) & ~ZMII_FER_MDI_ALL;
 
-	ZMII_DBG2("%d: mdio(%d)" NL, ocpdev->def->index, input);
+	ZMII_DBG2(": mdio(%d)" NL, input);
 
-	out_be32(&dev->base->fer, fer | ZMII_FER_MDI(input));
+	out_be32(&zdev->base->fer, fer | ZMII_FER_MDI(input));
 }
 
-void __zmii_set_speed(struct ocp_device *ocpdev, int input, int speed)
+void __zmii_set_speed(struct emac_subdev *dev, int input, int speed)
 {
-	struct ibm_ocp_zmii *dev = ocp_get_drvdata(ocpdev);
-	u32 ssr = in_be32(&dev->base->ssr);
+	struct ibm_ocp_zmii *zdev = bus_get_drvdata(dev);
+	u32 ssr = in_be32(&zdev->base->ssr);
 
-	ZMII_DBG("%d: speed(%d, %d)" NL, ocpdev->def->index, input, speed);
+	ZMII_DBG(": speed(%d, %d)" NL, input, speed);
 
 	if (speed == SPEED_100)
 		ssr |= ZMII_SSR_SP(input);
 	else
 		ssr &= ~ZMII_SSR_SP(input);
 
-	out_be32(&dev->base->ssr, ssr);
+	out_be32(&zdev->base->ssr, ssr);
 }
 
-void __exit __zmii_fini(struct ocp_device *ocpdev, int input)
+void __exit __zmii_fini(struct emac_subdev *dev, int input)
 {
-	struct ibm_ocp_zmii *dev = ocp_get_drvdata(ocpdev);
-	BUG_ON(!dev || dev->users == 0);
+	struct ibm_ocp_zmii *zdev = bus_get_drvdata(dev);
+	BUG_ON(!zdev || zdev->users == 0);
 
-	ZMII_DBG("%d: fini(%d)" NL, ocpdev->def->index, input);
+	ZMII_DBG(": fini(%d)" NL, input);
 
 	/* Disable this input */
-	out_be32(&dev->base->fer,
-		 in_be32(&dev->base->fer) & ~zmii_mode_mask(dev->mode, input));
+	out_be32(&zdev->base->fer,
+		 in_be32(&zdev->base->fer) & ~zmii_mode_mask(zdev->mode, input));
 
-	if (!--dev->users) {
+	if (!--zdev->users) {
 		/* Free everything if this is the last user */
-		ocp_set_drvdata(ocpdev, NULL);
-		iounmap(dev->base);
-		kfree(dev);
+		bus_set_drvdata(dev, NULL);
+		iounmap(zdev->base);
+		kfree(zdev);
 	}
 }
 
-int __zmii_get_regs_len(struct ocp_device *ocpdev)
+int __zmii_get_regs_len(struct emac_subdev *dev)
 {
 	return sizeof(struct emac_ethtool_regs_subhdr) +
 	    sizeof(struct zmii_regs);
 }
 
-void *zmii_dump_regs(struct ocp_device *ocpdev, void *buf)
+void *zmii_dump_regs(struct emac_subdev *dev, void *buf)
 {
-	struct ibm_ocp_zmii *dev = ocp_get_drvdata(ocpdev);
+	struct ibm_ocp_zmii *zdev = bus_get_drvdata(dev);
 	struct emac_ethtool_regs_subhdr *hdr = buf;
 	struct zmii_regs *regs = (struct zmii_regs *)(hdr + 1);
 
 	hdr->version = 0;
-	hdr->index = ocpdev->def->index;
-	memcpy_fromio(regs, dev->base, sizeof(struct zmii_regs));
+#ifdef CONFIG_IBM_EMAC_OCP
+	hdr->index = dev->def->index;
+#else
+	hdr->index = 0;
+#endif
+	memcpy_fromio(regs, zdev->base, sizeof(struct zmii_regs));
 	return regs + 1;
 }
Index: linux-cell/drivers/net/ibm_emac/ibm_emac_phy.c
===================================================================
--- linux-cell.orig/drivers/net/ibm_emac/ibm_emac_phy.c	2006-11-06 16:38:24.000000000 +1100
+++ linux-cell/drivers/net/ibm_emac/ibm_emac_phy.c	2006-11-06 16:38:27.000000000 +1100
@@ -20,7 +20,11 @@
 #include <linux/ethtool.h>
 #include <linux/delay.h>
 
+#ifdef CONFIG_IBM_EMAC_OCP
 #include <asm/ocp.h>
+#else
+#include "ibm_emac_compat.h"
+#endif
 
 #include "ibm_emac_phy.h"
 
Index: linux-cell/drivers/net/ibm_emac/ibm_emac_compat.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/drivers/net/ibm_emac/ibm_emac_compat.h	2006-11-06 16:38:27.000000000 +1100
@@ -0,0 +1,72 @@
+#ifndef __IBM_EMAC_COMPAT_H_
+#define __IBM_EMAC_COMPAT_H_
+
+#include <linux/types.h>
+
+/*
+ * Definitions in this file are used for compatability when compiling
+ * the driver without the OCP bus type.  Once arch/ppc merges with
+ * arch/powerpc, the OCP residue could be removed. -swetz
+ */
+
+/*
+ * OCP device definition.
+ *
+ * Minimal definition needed to compile without ocp.h
+ *
+ */
+struct ocp_def {
+	int		index;
+	phys_addr_t	paddr;
+	int	  	irq;
+	void		*additions;
+};
+
+/*
+ * Additional MAL platform data obtained from the device-tree.
+ */
+struct ocp_func_mal_data {
+	int	num_tx_chans;	/* Number of TX channels */
+	int	num_rx_chans;	/* Number of RX channels */
+	int 	txeob_irq;	/* TX End Of Buffer IRQ  */
+	int 	rxeob_irq;	/* RX End Of Buffer IRQ  */
+	int	txde_irq;	/* TX Descriptor Error IRQ */
+	int	rxde_irq;	/* RX Descriptor Error IRQ */
+	int	serr_irq;	/* MAL System Error IRQ    */
+	int	dcr_base;	/* MALx_CFG DCR number   */
+};
+
+/*
+ * Additional EMAC platform data obtained from the device-tree.
+ */
+struct ocp_func_emac_data {
+	int	rgmii_idx;	/* RGMII device index or -1 */
+	int	rgmii_mux;	/* RGMII input of this EMAC */
+	int	zmii_idx;	/* ZMII device index or -1 */
+	int	zmii_mux;	/* ZMII input of this EMAC */
+	int	mal_idx;	/* MAL device index */
+	int	mal_rx_chan;	/* MAL rx channel number */
+	int	mal_tx_chan;	/* MAL tx channel number */
+	int	wol_irq;	/* WOL interrupt */
+	int	mdio_idx;	/* EMAC idx of MDIO master or -1 */
+	int	tah_idx;	/* TAH device index or -1 */
+	int	phy_mode;	/* PHY type or configurable mode */
+	u8	mac_addr[6];	/* EMAC mac address */
+	u32	phy_map;	/* EMAC phy map */
+	u32	phy_feat_exc;	/* Excluded PHY features */
+};
+
+/*
+ * PHY mode settings (EMAC <-> ZMII/RGMII bridge <-> PHY)
+ */
+#define PHY_MODE_NA	0
+#define PHY_MODE_MII	1
+#define PHY_MODE_RMII	2
+#define PHY_MODE_SMII	3
+#define PHY_MODE_RGMII	4
+#define PHY_MODE_TBI	5
+#define PHY_MODE_GMII	6
+#define PHY_MODE_RTBI	7
+#define PHY_MODE_SGMII	8
+
+#endif /* __IBM_EMAC_COMPAT_H_ */
Index: linux-cell/drivers/net/ibm_emac/ibm_emac_busdev.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/drivers/net/ibm_emac/ibm_emac_busdev.h	2006-11-06 16:38:27.000000000 +1100
@@ -0,0 +1,37 @@
+#ifndef __IBM_EMAC_BUSDEV_H_
+#define __IBM_EMAC_BUSDEV_H_
+
+#include <linux/types.h>
+
+#ifdef CONFIG_IBM_EMAC_OCP
+#include <asm/ocp.h>
+
+#define emac_subdev ocp_device
+
+static inline void * bus_get_drvdata (struct emac_subdev *dev)
+{
+	return ocp_get_drvdata(dev);
+}
+
+static inline void bus_set_drvdata (struct emac_subdev *dev, void *data)
+{
+	ocp_set_drvdata(dev, data);
+}
+#else
+#include <asm/of_device.h>
+
+#define emac_subdev of_device
+
+static inline void * bus_get_drvdata (struct emac_subdev *dev)
+{
+	return dev_get_drvdata(&dev->dev);
+}
+
+static inline void bus_set_drvdata (struct emac_subdev *dev, void *data)
+{
+	dev_set_drvdata(&dev->dev, data);
+}
+#endif
+
+#endif /* __IBM_EMAC_BUSDEV_H_ */
+
Index: linux-cell/arch/powerpc/Kconfig
===================================================================
--- linux-cell.orig/arch/powerpc/Kconfig	2006-11-06 16:38:24.000000000 +1100
+++ linux-cell/arch/powerpc/Kconfig	2006-11-06 16:38:27.000000000 +1100
@@ -481,6 +481,7 @@ config PPC_IBM_CELL_BLADE
 	select MMIO_NVRAM
 	select PPC_UDBG_16550
 	select UDBG_RTAS_CONSOLE
+	select IBM_EMAC4
 
 config UDBG_RTAS_CONSOLE
 	bool "RTAS based debug console"
