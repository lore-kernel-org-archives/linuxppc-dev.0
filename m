Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 0EB87DE648
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 22:13:01 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2/2] Re-added support for FEC on MPC5121 from Freescale LTIB
	to current head
Date: Thu, 12 Jun 2008 13:45:52 +0200
References: <200806121344.26883.david.jander@protonic.nl>
In-Reply-To: <200806121344.26883.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806121345.52293.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: David Jander <david@protonic.nl>
---
 arch/powerpc/platforms/Kconfig     |    2 +-
 drivers/net/fec.h                  |   43 ++++++++++++++++++++
 drivers/net/fs_enet/Kconfig        |   22 +++++++++-
 drivers/net/fs_enet/fs_enet-main.c |   76 ++++++++++++++++++++++++++++++------
 drivers/net/fs_enet/fs_enet.h      |   17 +++++---
 drivers/net/fs_enet/mac-fec.c      |   22 +++++++++-
 drivers/net/fs_enet/mii-fec.c      |   10 ++++-
 7 files changed, 167 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 87454c5..a96937f 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -288,7 +288,7 @@ config CPM2
 
 config PPC_CPM_NEW_BINDING
 	bool
-	depends on CPM1 || CPM2
+	depends on CPM1 || CPM2 || FS_ENET_MPC5121_FEC
 	default y
 
 config AXON_RAM
diff --git a/drivers/net/fec.h b/drivers/net/fec.h
index 292719d..5c9fe34 100644
--- a/drivers/net/fec.h
+++ b/drivers/net/fec.h
@@ -59,6 +59,7 @@ typedef struct fec {
 } fec_t;
 
 #else
+#if !defined(CONFIG_FS_ENET_MPC5121_FEC)
 
 /*
  *	Define device register set address map.
@@ -97,6 +98,48 @@ typedef struct fec {
 	unsigned long	fec_fifo_ram[112];	/* FIFO RAM buffer */
 } fec_t;
 
+#else /* CONFIG_FS_ENET_MPC5121_FEC */
+
+typedef struct fec {
+	u32 fec_reserved0;
+	u32 fec_ievent;		/* Interrupt event reg */
+	u32 fec_imask;		/* Interrupt mask reg */
+	u32 fec_reserved1;
+	u32 fec_r_des_active;	/* Receive descriptor reg */
+	u32 fec_x_des_active;	/* Transmit descriptor reg */
+	u32 fec_reserved2[3];
+	u32 fec_ecntrl;		/* Ethernet control reg */
+	u32 fec_reserved3[6];
+	u32 fec_mii_data;		/* MII manage frame reg */
+	u32 fec_mii_speed;		/* MII speed control reg */
+	u32 fec_reserved4[7];
+	u32 fec_mib_ctrlstat;	/* MIB control/status reg */
+	u32 fec_reserved5[7];
+	u32 fec_r_cntrl;		/* Receive control reg */
+	u32 fec_reserved6[15];
+	u32 fec_x_cntrl;		/* Transmit Control reg */
+	u32 fec_reserved7[7];
+	u32 fec_addr_low;		/* Low 32bits MAC address */
+	u32 fec_addr_high;		/* High 16bits MAC address */
+	u32 fec_opd;		/* Opcode + Pause duration */
+	u32 fec_reserved8[10];
+	u32 fec_hash_table_high;	/* High 32bits hash table */
+	u32 fec_hash_table_low;	/* Low 32bits hash table */
+	u32 fec_grp_hash_table_high;/* High 32bits hash table */
+	u32 fec_grp_hash_table_low;	/* Low 32bits hash table */
+	u32 fec_reserved9[7];
+	u32 fec_x_wmrk;		/* FIFO transmit water mark */
+	u32 fec_reserved10;
+	u32 fec_r_bound;		/* FIFO receive bound reg */
+	u32 fec_r_fstart;		/* FIFO receive start reg */
+	u32 fec_reserved11[11];
+	u32 fec_r_des_start;	/* Receive descriptor ring */
+	u32 fec_x_des_start;	/* Transmit descriptor ring */
+	u32 fec_r_buff_size;	/* Maximum receive buff size */
+	u32 fec_dma_control;	/* DMA Endian and other ctrl */
+} fec_t;
+
+#endif /* CONFIG_FS_ENET_MPC5121_FEC */
 #endif /* CONFIG_M5272 */
 
 
diff --git a/drivers/net/fs_enet/Kconfig b/drivers/net/fs_enet/Kconfig
index 562ea68..5e2520b 100644
--- a/drivers/net/fs_enet/Kconfig
+++ b/drivers/net/fs_enet/Kconfig
@@ -1,9 +1,23 @@
 config FS_ENET
        tristate "Freescale Ethernet Driver"
-       depends on CPM1 || CPM2
+       depends on CPM1 || CPM2 || FS_ENET_MPC5121_FEC
        select MII
        select PHYLIB
 
+config FS_ENET_MPC5121_FEC
+	bool "Freescale MPC512x FEC driver"
+	depends on PPC_MPC512x
+	select FS_ENET
+	select FS_ENET_HAS_FEC
+
+config FS_ENET_TX_ALIGN_WORKAROUND
+	bool "MPC5121 FEC driver TX alignment workaround"
+	depends on FS_ENET_MPC5121_FEC
+	help
+	  Workaround for a problem with early Freescale MPC5121 chips.
+	  If unsure say 'y'
+	default y
+
 config FS_ENET_HAS_SCC
 	bool "Chip has an SCC usable for ethernet"
 	depends on FS_ENET && (CPM1 || CPM2)
@@ -16,13 +30,15 @@ config FS_ENET_HAS_FCC
 
 config FS_ENET_HAS_FEC
 	bool "Chip has an FEC usable for ethernet"
-	depends on FS_ENET && CPM1
+	depends on FS_ENET && (CPM1 || FS_ENET_MPC5121_FEC)
 	select FS_ENET_MDIO_FEC
 	default y
 
+
 config FS_ENET_MDIO_FEC
 	tristate "MDIO driver for FEC"
-	depends on FS_ENET && CPM1
+	depends on FS_ENET && (CPM1 || FS_ENET_MPC5121_FEC)
+
 
 config FS_ENET_MDIO_FCC
 	tristate "MDIO driver for FCC"
diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index 31c9693..54f0079 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -592,6 +592,31 @@ void fs_cleanup_bds(struct net_device *dev)
 
 /**********************************************************************************/
 
+#ifdef CONFIG_FS_ENET_TX_ALIGN_WORKAROUND
+static struct sk_buff *aligntxskb(struct net_device *dev, struct sk_buff *skb)
+{
+	struct sk_buff *skbn;
+	skbn = dev_alloc_skb(ENET_RX_FRSIZE+0x20);
+	if (skbn)
+		skb_align(skbn, 0x20);
+
+	if (!skbn) { 
+	    printk(KERN_WARNING DRV_MODULE_NAME
+		    ": %s Memory squeeze, dropping tx packet.\n",
+		    dev->name);
+		dev_kfree_skb_any(skb);
+		return NULL;
+	}
+
+	skb_copy_from_linear_data(skb, skbn->data, skb->len);
+	skb_put(skbn, skb->len);
+	dev_kfree_skb_any(skb);
+	return skbn;
+}
+#else
+#define aligntxskb(skb) skb
+#endif
+
 static int fs_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
@@ -600,6 +625,7 @@ static int fs_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	u16 sc;
 	unsigned long flags;
 
+	skb = aligntxskb(dev, skb);
 	spin_lock_irqsave(&fep->tx_lock, flags);
 
 	/*
@@ -1370,10 +1396,17 @@ static struct of_device_id fs_enet_match[] = {
 	},
 #endif
 #ifdef CONFIG_FS_ENET_HAS_FEC
+#ifndef CONFIG_FS_ENET_MPC5121_FEC
 	{
 		.compatible = "fsl,pq1-fec-enet",
 		.data = (void *)&fs_fec_ops,
 	},
+#else
+	{
+		.compatible = "fsl,mpc5121-fec",
+		.data = (void *)&fs_fec_ops,
+	},
+#endif
 #endif
 	{}
 };
@@ -1431,15 +1464,38 @@ static int fs_enet_remove(struct device *dev)
 	return fs_cleanup_instance(dev_get_drvdata(dev));
 }
 
+#ifdef CONFIG_PM
+static int fs_enet_suspend(struct device *dev, pm_message_t state)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+
+	if (netif_running(ndev))
+		fs_enet_close(ndev);
+
+	return 0;
+}
+
+static int fs_enet_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+
+	if (netif_running(ndev))
+		fs_enet_open(ndev);
+
+	return 0;
+}
+#else
+#define fs_enet_suspend	NULL
+#define fs_enet_resume	NULL
+#endif
+
 static struct device_driver fs_enet_fec_driver = {
 	.name	  	= "fsl-cpm-fec",
 	.bus		= &platform_bus_type,
 	.probe		= fs_enet_probe,
 	.remove		= fs_enet_remove,
-#ifdef CONFIG_PM
-/*	.suspend	= fs_enet_suspend,	TODO */
-/*	.resume		= fs_enet_resume,	TODO */
-#endif
+	.suspend	= fs_enet_suspend,
+	.resume		= fs_enet_resume,
 };
 
 static struct device_driver fs_enet_scc_driver = {
@@ -1447,10 +1503,8 @@ static struct device_driver fs_enet_scc_driver = {
 	.bus		= &platform_bus_type,
 	.probe		= fs_enet_probe,
 	.remove		= fs_enet_remove,
-#ifdef CONFIG_PM
-/*	.suspend	= fs_enet_suspend,	TODO */
-/*	.resume		= fs_enet_resume,	TODO */
-#endif
+	.suspend	= fs_enet_suspend,
+	.resume		= fs_enet_resume,
 };
 
 static struct device_driver fs_enet_fcc_driver = {
@@ -1458,10 +1512,8 @@ static struct device_driver fs_enet_fcc_driver = {
 	.bus		= &platform_bus_type,
 	.probe		= fs_enet_probe,
 	.remove		= fs_enet_remove,
-#ifdef CONFIG_PM
-/*	.suspend	= fs_enet_suspend,	TODO */
-/*	.resume		= fs_enet_resume,	TODO */
-#endif
+	.suspend	= fs_enet_suspend,
+	.resume		= fs_enet_resume,
 };
 
 static int __init fs_init(void)
diff --git a/drivers/net/fs_enet/fs_enet.h b/drivers/net/fs_enet/fs_enet.h
index e05389c..ea3cf2f 100644
--- a/drivers/net/fs_enet/fs_enet.h
+++ b/drivers/net/fs_enet/fs_enet.h
@@ -10,10 +10,15 @@
 
 #include <linux/fs_enet_pd.h>
 #include <asm/fs_pd.h>
+#ifdef CONFIG_FS_ENET_MPC5121_FEC
+#include "../fec.h"
+#endif
 
 #ifdef CONFIG_CPM1
 #include <asm/cpm1.h>
+#endif
 
+#if defined(CONFIG_CPM1) || defined(CONFIG_FS_ENET_MPC5121_FEC)
 struct fec_info {
 	fec_t __iomem *fecp;
 	u32 mii_speed;
@@ -177,14 +182,14 @@ void fs_enet_platform_cleanup(void);
 #endif
 
 /* write */
-#define CBDW_SC(_cbd, _sc) 		__cbd_out16(&(_cbd)->cbd_sc, (_sc))
-#define CBDW_DATLEN(_cbd, _datlen)	__cbd_out16(&(_cbd)->cbd_datlen, (_datlen))
-#define CBDW_BUFADDR(_cbd, _bufaddr)	__cbd_out32(&(_cbd)->cbd_bufaddr, (_bufaddr))
+#define CBDW_SC(_cbd, _sc) 		__cbd_out16((volatile void __iomem *)&(_cbd)->cbd_sc, (_sc))
+#define CBDW_DATLEN(_cbd, _datlen)	__cbd_out16((volatile void __iomem *)&(_cbd)->cbd_datlen, (_datlen))
+#define CBDW_BUFADDR(_cbd, _bufaddr)	__cbd_out32((volatile void __iomem *)&(_cbd)->cbd_bufaddr, (_bufaddr))
 
 /* read */
-#define CBDR_SC(_cbd) 			__cbd_in16(&(_cbd)->cbd_sc)
-#define CBDR_DATLEN(_cbd)		__cbd_in16(&(_cbd)->cbd_datlen)
-#define CBDR_BUFADDR(_cbd)		__cbd_in32(&(_cbd)->cbd_bufaddr)
+#define CBDR_SC(_cbd) 			__cbd_in16((volatile void __iomem *)&(_cbd)->cbd_sc)
+#define CBDR_DATLEN(_cbd)		__cbd_in16((volatile void __iomem *)&(_cbd)->cbd_datlen)
+#define CBDR_BUFADDR(_cbd)		__cbd_in32((volatile void __iomem *)&(_cbd)->cbd_bufaddr)
 
 /* set bits */
 #define CBDS_SC(_cbd, _sc) 		CBDW_SC(_cbd, CBDR_SC(_cbd) | (_sc))
diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c
index 8a311d1..ddbe548 100644
--- a/drivers/net/fs_enet/mac-fec.c
+++ b/drivers/net/fs_enet/mac-fec.c
@@ -42,6 +42,9 @@
 #include <asm/mpc8xx.h>
 #include <asm/cpm1.h>
 #endif
+#ifdef CONFIG_FS_ENET_MPC5121_FEC
+#include "../fec.h"
+#endif
 
 #ifdef CONFIG_PPC_CPM_NEW_BINDING
 #include <asm/of_device.h>
@@ -306,7 +309,9 @@ static void restart(struct net_device *dev)
 	 * Set maximum receive buffer size.
 	 */
 	FW(fecp, r_buff_size, PKT_MAXBLR_SIZE);
+#ifndef CONFIG_FS_ENET_MPC5121_FEC
 	FW(fecp, r_hash, PKT_MAXBUF_SIZE);
+#endif
 
 	/* get physical address */
 	rx_bd_base_phys = fep->ring_mem_addr;
@@ -320,10 +325,17 @@ static void restart(struct net_device *dev)
 
 	fs_init_bds(dev);
 
+#ifndef CONFIG_FS_ENET_MPC5121_FEC
 	/*
 	 * Enable big endian and don't care about SDMA FC.
 	 */
 	FW(fecp, fun_code, 0x78000000);
+#else
+	/*
+	 * Set DATA_BO and DESC_BO and leave the rest unchanged
+	 */
+	FS(fecp, dma_control, 0xc0000000);
+#endif
 
 	/*
 	 * Set MII speed.
@@ -334,11 +346,13 @@ static void restart(struct net_device *dev)
 	 * Clear any outstanding interrupt.
 	 */
 	FW(fecp, ievent, 0xffc0);
+#ifndef CONFIG_FS_ENET_MPC5121_FEC
 #ifndef CONFIG_PPC_MERGE
 	FW(fecp, ivec, (fep->interrupt / 2) << 29);
 #else
 	FW(fecp, ivec, (virq_to_hw(fep->interrupt) / 2) << 29);
 #endif
+#endif
 
 	/*
 	 * adjust to speed (only for DUET & RMII)
@@ -368,9 +382,13 @@ static void restart(struct net_device *dev)
 		out_be32(&immap->im_cpm.cp_cptr, cptr);
 	}
 #endif
-
-
+#ifdef CONFIG_FS_ENET_MPC5121_FEC
+	FW(fecp, r_cntrl, PKT_MAXBUF_SIZE<<16);	/* max frame size */
+	FS(fecp, r_cntrl, FEC_RCNTRL_MII_MODE); /* MII enable */
+#else
 	FW(fecp, r_cntrl, FEC_RCNTRL_MII_MODE);	/* MII enable */
+#endif
+
 	/*
 	 * adjust to duplex mode
 	 */
diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fec.c
index f0014cf..5d9b846 100644
--- a/drivers/net/fs_enet/mii-fec.c
+++ b/drivers/net/fs_enet/mii-fec.c
@@ -38,6 +38,7 @@
 
 #ifdef CONFIG_PPC_CPM_NEW_BINDING
 #include <asm/of_platform.h>
+#include <asm/time.h>
 #endif
 
 #include "fs_enet.h"
@@ -71,7 +72,7 @@ static int fs_mii_fec_init(struct fec_info* fec, struct fs_mii_fec_platform_info
 {
 	struct resource *r;
 	fec_t __iomem *fecp;
-	char* name = "fsl-cpm-fec";
+	char *name = "fsl-cpm-fec";
 
 	/* we need fec in order to be useful */
 	struct platform_device *fec_pdev =
@@ -261,9 +262,16 @@ static int fs_enet_mdio_remove(struct of_device *ofdev)
 }
 
 static struct of_device_id fs_enet_mdio_fec_match[] = {
+#ifdef CONFIG_FS_ENET_FEC
 	{
 		.compatible = "fsl,pq1-fec-mdio",
 	},
+#endif
+#ifdef CONFIG_FS_ENET_MPC5121_FEC
+	{
+		.compatible = "fsl,mpc5121-fec-mdio",
+	},
+#endif
 	{},
 };
 
-- 
1.5.4.3
