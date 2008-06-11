Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 3CC51DDF37
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 19:45:22 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 255BF29EBB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 11:43:42 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 06546-06 for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 11:43:07 +0200 (CEST)
Received: from archvile.prtnl (archvile.prtnl [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id 0D2FD29EC8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 11:43:04 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2/2] Re-added support for FEC on MPC5121 from Freescale LTIB
Date: Wed, 11 Jun 2008 11:44:44 +0200
References: <200806111143.08905.david.jander@protonic.nl>
In-Reply-To: <200806111143.08905.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806111144.44218.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

to current head

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/fs_enet/Kconfig        |   16 ++++-
 drivers/net/fs_enet/fec_mpc5121.h  |  120 ++++++++++++++++++++++++++++++++++++
 drivers/net/fs_enet/fs_enet-main.c |   90 +++++++++++++++++++++++----
 drivers/net/fs_enet/fs_enet.h      |   14 +++-
 drivers/net/fs_enet/mac-fec.c      |   22 ++++++-
 drivers/net/fs_enet/mii-fec.c      |   10 +++-
 6 files changed, 249 insertions(+), 23 deletions(-)
 create mode 100644 drivers/net/fs_enet/fec_mpc5121.h

diff --git a/drivers/net/fs_enet/Kconfig b/drivers/net/fs_enet/Kconfig
index 562ea68..8eea038 100644
--- a/drivers/net/fs_enet/Kconfig
+++ b/drivers/net/fs_enet/Kconfig
@@ -1,9 +1,17 @@
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
+	select PPC_CPM_NEW_BINDING
+	default n
+
 config FS_ENET_HAS_SCC
 	bool "Chip has an SCC usable for ethernet"
 	depends on FS_ENET && (CPM1 || CPM2)
@@ -16,13 +24,15 @@ config FS_ENET_HAS_FCC
 
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
diff --git a/drivers/net/fs_enet/fec_mpc5121.h b/drivers/net/fs_enet/fec_mpc5121.h
new file mode 100644
index 0000000..b8a69d4
--- /dev/null
+++ b/drivers/net/fs_enet/fec_mpc5121.h
@@ -0,0 +1,120 @@
+/*
+ * Copyright (C) 2007,2008 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: John Rigby, <jrigby@freescale.com>
+ *
+ * Modified version of drivers/net/fec.h:
+ *
+ *	fec.h  --  Fast Ethernet Controller for Motorola ColdFire SoC
+ *		   processors.
+ *
+ *	(C) Copyright 2000-2005, Greg Ungerer (gerg@snapgear.com)
+ *	(C) Copyright 2000-2001, Lineo (www.lineo.com)
+ *
+ * This is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef FEC_MPC5121_H
+#define FEC_MPC5121_H
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
+/*
+ *	Define the buffer descriptor structure.
+ */
+typedef struct bufdesc {
+	unsigned short	cbd_sc;			/* Control and status info */
+	unsigned short	cbd_datlen;		/* Data length */
+	unsigned long	cbd_bufaddr;		/* Buffer address */
+} cbd_t;
+
+/*
+ *	The following definitions courtesy of commproc.h, which where
+ *	Copyright (c) 1997 Dan Malek (dmalek@jlc.net).
+ */
+#define BD_SC_EMPTY     ((ushort)0x8000)        /* Recieve is empty */
+#define BD_SC_READY     ((ushort)0x8000)        /* Transmit is ready */
+#define BD_SC_WRAP      ((ushort)0x2000)        /* Last buffer descriptor */
+#define BD_SC_INTRPT    ((ushort)0x1000)        /* Interrupt on change */
+#define BD_SC_CM        ((ushort)0x0200)        /* Continous mode */
+#define BD_SC_ID        ((ushort)0x0100)        /* Rec'd too many idles */
+#define BD_SC_P         ((ushort)0x0100)        /* xmt preamble */
+#define BD_SC_BR        ((ushort)0x0020)        /* Break received */
+#define BD_SC_FR        ((ushort)0x0010)        /* Framing error */
+#define BD_SC_PR        ((ushort)0x0008)        /* Parity error */
+#define BD_SC_OV        ((ushort)0x0002)        /* Overrun */
+#define BD_SC_CD        ((ushort)0x0001)        /* ?? */
+
+/* Buffer descriptor control/status used by Ethernet receive.
+*/
+#define BD_ENET_RX_EMPTY        ((ushort)0x8000)
+#define BD_ENET_RX_WRAP         ((ushort)0x2000)
+#define BD_ENET_RX_INTR         ((ushort)0x1000)
+#define BD_ENET_RX_LAST         ((ushort)0x0800)
+#define BD_ENET_RX_FIRST        ((ushort)0x0400)
+#define BD_ENET_RX_MISS         ((ushort)0x0100)
+#define BD_ENET_RX_LG           ((ushort)0x0020)
+#define BD_ENET_RX_NO           ((ushort)0x0010)
+#define BD_ENET_RX_SH           ((ushort)0x0008)
+#define BD_ENET_RX_CR           ((ushort)0x0004)
+#define BD_ENET_RX_OV           ((ushort)0x0002)
+#define BD_ENET_RX_CL           ((ushort)0x0001)
+#define BD_ENET_RX_STATS        ((ushort)0x013f)        /* All status bits */
+
+/* Buffer descriptor control/status used by Ethernet transmit.
+*/
+#define BD_ENET_TX_READY        ((ushort)0x8000)
+#define BD_ENET_TX_PAD          ((ushort)0x4000)
+#define BD_ENET_TX_WRAP         ((ushort)0x2000)
+#define BD_ENET_TX_INTR         ((ushort)0x1000)
+#define BD_ENET_TX_LAST         ((ushort)0x0800)
+#define BD_ENET_TX_TC           ((ushort)0x0400)
+#define BD_ENET_TX_DEF          ((ushort)0x0200)
+#define BD_ENET_TX_HB           ((ushort)0x0100)
+#define BD_ENET_TX_LC           ((ushort)0x0080)
+#define BD_ENET_TX_RL           ((ushort)0x0040)
+#define BD_ENET_TX_RCMASK       ((ushort)0x003c)
+#define BD_ENET_TX_UN           ((ushort)0x0002)
+#define BD_ENET_TX_CSL          ((ushort)0x0001)
+#define BD_ENET_TX_STATS        ((ushort)0x03ff)        /* All status bits */
+
+#endif /* FEC_MPC5121_H */
diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index 31c9693..4ca8513 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -69,6 +69,7 @@ MODULE_PARM_DESC(fs_enet_debug,
 static void fs_enet_netpoll(struct net_device *dev);
 #endif
 
+#define ENET_RX_ALIGN 16
 static void fs_set_multicast_list(struct net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
@@ -592,6 +593,33 @@ void fs_cleanup_bds(struct net_device *dev)
 
 /**********************************************************************************/
 
+#define TX_ALIGN_WORKAROUND
+#ifdef TX_ALIGN_WORKAROUND
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
+
 static int fs_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
@@ -600,6 +628,7 @@ static int fs_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	u16 sc;
 	unsigned long flags;
 
+	skb = aligntxskb(dev, skb);
 	spin_lock_irqsave(&fep->tx_lock, flags);
 
 	/*
@@ -951,7 +980,7 @@ static int fs_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
 	struct mii_ioctl_data *mii = (struct mii_ioctl_data *)&rq->ifr_data;
-
+	printk("<1> %s: %s (%d)\n",__FILE__,__FUNCTION__,__LINE__);
 	if (!netif_running(dev))
 		return -EINVAL;
 
@@ -1147,6 +1176,7 @@ static int fs_cleanup_instance(struct net_device *ndev)
 
 /**************************************************************************************/
 
+#ifndef CONFIG_FS_ENET_MPC5121_FEC
 /* handy pointer to the immap */
 void __iomem *fs_enet_immap = NULL;
 
@@ -1168,6 +1198,10 @@ static void cleanup_immap(void)
 	iounmap(fs_enet_immap);
 #endif
 }
+#else
+#define setup_immap() 0
+#define cleanup_immap() do {} while (0)
+#endif
 
 /**************************************************************************************/
 
@@ -1370,10 +1404,17 @@ static struct of_device_id fs_enet_match[] = {
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
@@ -1431,15 +1472,42 @@ static int fs_enet_remove(struct device *dev)
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
+#ifndef CONFIG_FS_ENET_MPC5121_FEC
 	.name	  	= "fsl-cpm-fec",
+#else
+	.name	  	= "fsl-mpc5121-fec",
+#endif
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
@@ -1447,10 +1515,8 @@ static struct device_driver fs_enet_scc_driver = {
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
@@ -1458,10 +1524,8 @@ static struct device_driver fs_enet_fcc_driver = {
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
index e05389c..56d3f14 100644
--- a/drivers/net/fs_enet/fs_enet.h
+++ b/drivers/net/fs_enet/fs_enet.h
@@ -9,11 +9,17 @@
 #include <linux/dma-mapping.h>
 
 #include <linux/fs_enet_pd.h>
+#ifndef CONFIG_FS_ENET_MPC5121_FEC
 #include <asm/fs_pd.h>
+#else
+#include "fec_mpc5121.h"
+#endif
 
 #ifdef CONFIG_CPM1
 #include <asm/cpm1.h>
+#endif
 
+#if defined(CONFIG_CPM1) || defined(CONFIG_FS_ENET_MPC5121_FEC)
 struct fec_info {
 	fec_t __iomem *fecp;
 	u32 mii_speed;
@@ -170,10 +176,10 @@ void fs_enet_platform_cleanup(void);
 #define __cbd_in16(addr)	__raw_readw(addr)
 #else
 /* for others play it safe */
-#define __cbd_out32(addr, x)	out_be32(addr, x)
-#define __cbd_out16(addr, x)	out_be16(addr, x)
-#define __cbd_in32(addr)	in_be32(addr)
-#define __cbd_in16(addr)	in_be16(addr)
+#define __cbd_out32(addr, x)	out_be32((volatile void __iomem *)addr, x)
+#define __cbd_out16(addr, x)	out_be16((volatile void __iomem *)addr, x)
+#define __cbd_in32(addr)	in_be32((volatile void __iomem *)addr)
+#define __cbd_in16(addr)	in_be16((volatile void __iomem *)addr)
 #endif
 
 /* write */
diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c
index 8a311d1..d4de57f 100644
--- a/drivers/net/fs_enet/mac-fec.c
+++ b/drivers/net/fs_enet/mac-fec.c
@@ -42,6 +42,9 @@
 #include <asm/mpc8xx.h>
 #include <asm/cpm1.h>
 #endif
+#ifdef CONFIG_FS_ENET_MPC5121_FEC
+#include "fec_mpc5121.h"
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
