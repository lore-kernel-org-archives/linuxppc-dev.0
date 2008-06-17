Return-Path: <jcrigby@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id A63DFDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jun 2008 03:33:40 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so3468269ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jun 2008 10:33:35 -0700 (PDT)
Message-ID: <4b73d43f0806171033h72bca1dia98748522a7021b2@mail.gmail.com>
Date: Tue, 17 Jun 2008 11:33:33 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "David Jander" <david.jander@protonic.nl>
Subject: Re: [PATCH 2/2] Re-added support for FEC on MPC5121 from Freescale
	LTIB
In-Reply-To: <200806111144.44218.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_13951_27510133.1213724013340"
References: <200806111143.08905.david.jander@protonic.nl>
	<200806111144.44218.david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_13951_27510133.1213724013340
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

David,

Sorry for the late response but I have been away for the last week.

This looks like a verbatim copy of the patches authored by me in ltib.  I
think it is considered gauche to submit someone else's work with your
Signed-off-by.

Others have already spoken of the problems with this patch.  I am working on
an alternative with far fewer ifdefs that may actually pass review.  It has
passed an off line review by Scott Wood.

I'll submit my latest patch and we will see what people think.

John

On Wed, Jun 11, 2008 at 3:44 AM, David Jander <david.jander@protonic.nl>
wrote:

> to current head
>
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  drivers/net/fs_enet/Kconfig        |   16 ++++-
>  drivers/net/fs_enet/fec_mpc5121.h  |  120
> ++++++++++++++++++++++++++++++++++++
>  drivers/net/fs_enet/fs_enet-main.c |   90 +++++++++++++++++++++++----
>  drivers/net/fs_enet/fs_enet.h      |   14 +++-
>  drivers/net/fs_enet/mac-fec.c      |   22 ++++++-
>  drivers/net/fs_enet/mii-fec.c      |   10 +++-
>  6 files changed, 249 insertions(+), 23 deletions(-)
>  create mode 100644 drivers/net/fs_enet/fec_mpc5121.h
>
> diff --git a/drivers/net/fs_enet/Kconfig b/drivers/net/fs_enet/Kconfig
> index 562ea68..8eea038 100644
> --- a/drivers/net/fs_enet/Kconfig
> +++ b/drivers/net/fs_enet/Kconfig
> @@ -1,9 +1,17 @@
>  config FS_ENET
>        tristate "Freescale Ethernet Driver"
> -       depends on CPM1 || CPM2
> +       depends on CPM1 || CPM2 || FS_ENET_MPC5121_FEC
>        select MII
>        select PHYLIB
>
> +config FS_ENET_MPC5121_FEC
> +       bool "Freescale MPC512x FEC driver"
> +       depends on PPC_MPC512x
> +       select FS_ENET
> +       select FS_ENET_HAS_FEC
> +       select PPC_CPM_NEW_BINDING
> +       default n
> +
>  config FS_ENET_HAS_SCC
>        bool "Chip has an SCC usable for ethernet"
>        depends on FS_ENET && (CPM1 || CPM2)
> @@ -16,13 +24,15 @@ config FS_ENET_HAS_FCC
>
>  config FS_ENET_HAS_FEC
>        bool "Chip has an FEC usable for ethernet"
> -       depends on FS_ENET && CPM1
> +       depends on FS_ENET && (CPM1 || FS_ENET_MPC5121_FEC)
>        select FS_ENET_MDIO_FEC
>        default y
>
> +
>  config FS_ENET_MDIO_FEC
>        tristate "MDIO driver for FEC"
> -       depends on FS_ENET && CPM1
> +       depends on FS_ENET && (CPM1 || FS_ENET_MPC5121_FEC)
> +
>
>  config FS_ENET_MDIO_FCC
>        tristate "MDIO driver for FCC"
> diff --git a/drivers/net/fs_enet/fec_mpc5121.h
> b/drivers/net/fs_enet/fec_mpc5121.h
> new file mode 100644
> index 0000000..b8a69d4
> --- /dev/null
> +++ b/drivers/net/fs_enet/fec_mpc5121.h
> @@ -0,0 +1,120 @@
> +/*
> + * Copyright (C) 2007,2008 Freescale Semiconductor, Inc. All rights
> reserved.
> + *
> + * Author: John Rigby, <jrigby@freescale.com>
> + *
> + * Modified version of drivers/net/fec.h:
> + *
> + *     fec.h  --  Fast Ethernet Controller for Motorola ColdFire SoC
> + *                processors.
> + *
> + *     (C) Copyright 2000-2005, Greg Ungerer (gerg@snapgear.com)
> + *     (C) Copyright 2000-2001, Lineo (www.lineo.com)
> + *
> + * This is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +#ifndef FEC_MPC5121_H
> +#define FEC_MPC5121_H
> +
> +typedef struct fec {
> +       u32 fec_reserved0;
> +       u32 fec_ievent;         /* Interrupt event reg */
> +       u32 fec_imask;          /* Interrupt mask reg */
> +       u32 fec_reserved1;
> +       u32 fec_r_des_active;   /* Receive descriptor reg */
> +       u32 fec_x_des_active;   /* Transmit descriptor reg */
> +       u32 fec_reserved2[3];
> +       u32 fec_ecntrl;         /* Ethernet control reg */
> +       u32 fec_reserved3[6];
> +       u32 fec_mii_data;               /* MII manage frame reg */
> +       u32 fec_mii_speed;              /* MII speed control reg */
> +       u32 fec_reserved4[7];
> +       u32 fec_mib_ctrlstat;   /* MIB control/status reg */
> +       u32 fec_reserved5[7];
> +       u32 fec_r_cntrl;                /* Receive control reg */
> +       u32 fec_reserved6[15];
> +       u32 fec_x_cntrl;                /* Transmit Control reg */
> +       u32 fec_reserved7[7];
> +       u32 fec_addr_low;               /* Low 32bits MAC address */
> +       u32 fec_addr_high;              /* High 16bits MAC address */
> +       u32 fec_opd;            /* Opcode + Pause duration */
> +       u32 fec_reserved8[10];
> +       u32 fec_hash_table_high;        /* High 32bits hash table */
> +       u32 fec_hash_table_low; /* Low 32bits hash table */
> +       u32 fec_grp_hash_table_high;/* High 32bits hash table */
> +       u32 fec_grp_hash_table_low;     /* Low 32bits hash table */
> +       u32 fec_reserved9[7];
> +       u32 fec_x_wmrk;         /* FIFO transmit water mark */
> +       u32 fec_reserved10;
> +       u32 fec_r_bound;                /* FIFO receive bound reg */
> +       u32 fec_r_fstart;               /* FIFO receive start reg */
> +       u32 fec_reserved11[11];
> +       u32 fec_r_des_start;    /* Receive descriptor ring */
> +       u32 fec_x_des_start;    /* Transmit descriptor ring */
> +       u32 fec_r_buff_size;    /* Maximum receive buff size */
> +       u32 fec_dma_control;    /* DMA Endian and other ctrl */
> +} fec_t;
> +
> +/*
> + *     Define the buffer descriptor structure.
> + */
> +typedef struct bufdesc {
> +       unsigned short  cbd_sc;                 /* Control and status info
> */
> +       unsigned short  cbd_datlen;             /* Data length */
> +       unsigned long   cbd_bufaddr;            /* Buffer address */
> +} cbd_t;
> +
> +/*
> + *     The following definitions courtesy of commproc.h, which where
> + *     Copyright (c) 1997 Dan Malek (dmalek@jlc.net).
> + */
> +#define BD_SC_EMPTY     ((ushort)0x8000)        /* Recieve is empty */
> +#define BD_SC_READY     ((ushort)0x8000)        /* Transmit is ready */
> +#define BD_SC_WRAP      ((ushort)0x2000)        /* Last buffer descriptor
> */
> +#define BD_SC_INTRPT    ((ushort)0x1000)        /* Interrupt on change */
> +#define BD_SC_CM        ((ushort)0x0200)        /* Continous mode */
> +#define BD_SC_ID        ((ushort)0x0100)        /* Rec'd too many idles */
> +#define BD_SC_P         ((ushort)0x0100)        /* xmt preamble */
> +#define BD_SC_BR        ((ushort)0x0020)        /* Break received */
> +#define BD_SC_FR        ((ushort)0x0010)        /* Framing error */
> +#define BD_SC_PR        ((ushort)0x0008)        /* Parity error */
> +#define BD_SC_OV        ((ushort)0x0002)        /* Overrun */
> +#define BD_SC_CD        ((ushort)0x0001)        /* ?? */
> +
> +/* Buffer descriptor control/status used by Ethernet receive.
> +*/
> +#define BD_ENET_RX_EMPTY        ((ushort)0x8000)
> +#define BD_ENET_RX_WRAP         ((ushort)0x2000)
> +#define BD_ENET_RX_INTR         ((ushort)0x1000)
> +#define BD_ENET_RX_LAST         ((ushort)0x0800)
> +#define BD_ENET_RX_FIRST        ((ushort)0x0400)
> +#define BD_ENET_RX_MISS         ((ushort)0x0100)
> +#define BD_ENET_RX_LG           ((ushort)0x0020)
> +#define BD_ENET_RX_NO           ((ushort)0x0010)
> +#define BD_ENET_RX_SH           ((ushort)0x0008)
> +#define BD_ENET_RX_CR           ((ushort)0x0004)
> +#define BD_ENET_RX_OV           ((ushort)0x0002)
> +#define BD_ENET_RX_CL           ((ushort)0x0001)
> +#define BD_ENET_RX_STATS        ((ushort)0x013f)        /* All status bits
> */
> +
> +/* Buffer descriptor control/status used by Ethernet transmit.
> +*/
> +#define BD_ENET_TX_READY        ((ushort)0x8000)
> +#define BD_ENET_TX_PAD          ((ushort)0x4000)
> +#define BD_ENET_TX_WRAP         ((ushort)0x2000)
> +#define BD_ENET_TX_INTR         ((ushort)0x1000)
> +#define BD_ENET_TX_LAST         ((ushort)0x0800)
> +#define BD_ENET_TX_TC           ((ushort)0x0400)
> +#define BD_ENET_TX_DEF          ((ushort)0x0200)
> +#define BD_ENET_TX_HB           ((ushort)0x0100)
> +#define BD_ENET_TX_LC           ((ushort)0x0080)
> +#define BD_ENET_TX_RL           ((ushort)0x0040)
> +#define BD_ENET_TX_RCMASK       ((ushort)0x003c)
> +#define BD_ENET_TX_UN           ((ushort)0x0002)
> +#define BD_ENET_TX_CSL          ((ushort)0x0001)
> +#define BD_ENET_TX_STATS        ((ushort)0x03ff)        /* All status bits
> */
> +
> +#endif /* FEC_MPC5121_H */
> diff --git a/drivers/net/fs_enet/fs_enet-main.c
> b/drivers/net/fs_enet/fs_enet-main.c
> index 31c9693..4ca8513 100644
> --- a/drivers/net/fs_enet/fs_enet-main.c
> +++ b/drivers/net/fs_enet/fs_enet-main.c
> @@ -69,6 +69,7 @@ MODULE_PARM_DESC(fs_enet_debug,
>  static void fs_enet_netpoll(struct net_device *dev);
>  #endif
>
> +#define ENET_RX_ALIGN 16
>  static void fs_set_multicast_list(struct net_device *dev)
>  {
>        struct fs_enet_private *fep = netdev_priv(dev);
> @@ -592,6 +593,33 @@ void fs_cleanup_bds(struct net_device *dev)
>
>
>  /**********************************************************************************/
>
> +#define TX_ALIGN_WORKAROUND
> +#ifdef TX_ALIGN_WORKAROUND
> +static struct sk_buff *aligntxskb(struct net_device *dev, struct sk_buff
> *skb)
> +{
> +       struct sk_buff *skbn;
> +       skbn = dev_alloc_skb(ENET_RX_FRSIZE+0x20);
> +       if (skbn)
> +               skb_align(skbn, 0x20);
> +
> +       if (!skbn) {
> +           printk(KERN_WARNING DRV_MODULE_NAME
> +                   ": %s Memory squeeze, dropping tx packet.\n",
> +                   dev->name);
> +               dev_kfree_skb_any(skb);
> +               return NULL;
> +       }
> +
> +       skb_copy_from_linear_data(skb, skbn->data, skb->len);
> +       skb_put(skbn, skb->len);
> +       dev_kfree_skb_any(skb);
> +       return skbn;
> +}
> +#else
> +#define aligntxskb(skb) skb
> +#endif
> +
> +
>  static int fs_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>        struct fs_enet_private *fep = netdev_priv(dev);
> @@ -600,6 +628,7 @@ static int fs_enet_start_xmit(struct sk_buff *skb,
> struct net_device *dev)
>        u16 sc;
>        unsigned long flags;
>
> +       skb = aligntxskb(dev, skb);
>        spin_lock_irqsave(&fep->tx_lock, flags);
>
>        /*
> @@ -951,7 +980,7 @@ static int fs_ioctl(struct net_device *dev, struct
> ifreq *rq, int cmd)
>  {
>        struct fs_enet_private *fep = netdev_priv(dev);
>        struct mii_ioctl_data *mii = (struct mii_ioctl_data *)&rq->ifr_data;
> -
> +       printk("<1> %s: %s (%d)\n",__FILE__,__FUNCTION__,__LINE__);
>        if (!netif_running(dev))
>                return -EINVAL;
>
> @@ -1147,6 +1176,7 @@ static int fs_cleanup_instance(struct net_device
> *ndev)
>
>
>  /**************************************************************************************/
>
> +#ifndef CONFIG_FS_ENET_MPC5121_FEC
>  /* handy pointer to the immap */
>  void __iomem *fs_enet_immap = NULL;
>
> @@ -1168,6 +1198,10 @@ static void cleanup_immap(void)
>        iounmap(fs_enet_immap);
>  #endif
>  }
> +#else
> +#define setup_immap() 0
> +#define cleanup_immap() do {} while (0)
> +#endif
>
>
>  /**************************************************************************************/
>
> @@ -1370,10 +1404,17 @@ static struct of_device_id fs_enet_match[] = {
>        },
>  #endif
>  #ifdef CONFIG_FS_ENET_HAS_FEC
> +#ifndef CONFIG_FS_ENET_MPC5121_FEC
>        {
>                .compatible = "fsl,pq1-fec-enet",
>                .data = (void *)&fs_fec_ops,
>        },
> +#else
> +       {
> +               .compatible = "fsl,mpc5121-fec",
> +               .data = (void *)&fs_fec_ops,
> +       },
> +#endif
>  #endif
>        {}
>  };
> @@ -1431,15 +1472,42 @@ static int fs_enet_remove(struct device *dev)
>        return fs_cleanup_instance(dev_get_drvdata(dev));
>  }
>
> +#ifdef CONFIG_PM
> +static int fs_enet_suspend(struct device *dev, pm_message_t state)
> +{
> +       struct net_device *ndev = dev_get_drvdata(dev);
> +
> +       if (netif_running(ndev))
> +               fs_enet_close(ndev);
> +
> +       return 0;
> +}
> +
> +static int fs_enet_resume(struct device *dev)
> +{
> +       struct net_device *ndev = dev_get_drvdata(dev);
> +
> +       if (netif_running(ndev))
> +               fs_enet_open(ndev);
> +
> +       return 0;
> +}
> +#else
> +#define fs_enet_suspend        NULL
> +#define fs_enet_resume NULL
> +#endif
> +
>  static struct device_driver fs_enet_fec_driver = {
> +#ifndef CONFIG_FS_ENET_MPC5121_FEC
>        .name           = "fsl-cpm-fec",
> +#else
> +       .name           = "fsl-mpc5121-fec",
> +#endif
>        .bus            = &platform_bus_type,
>        .probe          = fs_enet_probe,
>        .remove         = fs_enet_remove,
> -#ifdef CONFIG_PM
> -/*     .suspend        = fs_enet_suspend,      TODO */
> -/*     .resume         = fs_enet_resume,       TODO */
> -#endif
> +       .suspend        = fs_enet_suspend,
> +       .resume         = fs_enet_resume,
>  };
>
>  static struct device_driver fs_enet_scc_driver = {
> @@ -1447,10 +1515,8 @@ static struct device_driver fs_enet_scc_driver = {
>        .bus            = &platform_bus_type,
>        .probe          = fs_enet_probe,
>        .remove         = fs_enet_remove,
> -#ifdef CONFIG_PM
> -/*     .suspend        = fs_enet_suspend,      TODO */
> -/*     .resume         = fs_enet_resume,       TODO */
> -#endif
> +       .suspend        = fs_enet_suspend,
> +       .resume         = fs_enet_resume,
>  };
>
>  static struct device_driver fs_enet_fcc_driver = {
> @@ -1458,10 +1524,8 @@ static struct device_driver fs_enet_fcc_driver = {
>        .bus            = &platform_bus_type,
>        .probe          = fs_enet_probe,
>        .remove         = fs_enet_remove,
> -#ifdef CONFIG_PM
> -/*     .suspend        = fs_enet_suspend,      TODO */
> -/*     .resume         = fs_enet_resume,       TODO */
> -#endif
> +       .suspend        = fs_enet_suspend,
> +       .resume         = fs_enet_resume,
>  };
>
>  static int __init fs_init(void)
> diff --git a/drivers/net/fs_enet/fs_enet.h b/drivers/net/fs_enet/fs_enet.h
> index e05389c..56d3f14 100644
> --- a/drivers/net/fs_enet/fs_enet.h
> +++ b/drivers/net/fs_enet/fs_enet.h
> @@ -9,11 +9,17 @@
>  #include <linux/dma-mapping.h>
>
>  #include <linux/fs_enet_pd.h>
> +#ifndef CONFIG_FS_ENET_MPC5121_FEC
>  #include <asm/fs_pd.h>
> +#else
> +#include "fec_mpc5121.h"
> +#endif
>
>  #ifdef CONFIG_CPM1
>  #include <asm/cpm1.h>
> +#endif
>
> +#if defined(CONFIG_CPM1) || defined(CONFIG_FS_ENET_MPC5121_FEC)
>  struct fec_info {
>        fec_t __iomem *fecp;
>        u32 mii_speed;
> @@ -170,10 +176,10 @@ void fs_enet_platform_cleanup(void);
>  #define __cbd_in16(addr)       __raw_readw(addr)
>  #else
>  /* for others play it safe */
> -#define __cbd_out32(addr, x)   out_be32(addr, x)
> -#define __cbd_out16(addr, x)   out_be16(addr, x)
> -#define __cbd_in32(addr)       in_be32(addr)
> -#define __cbd_in16(addr)       in_be16(addr)
> +#define __cbd_out32(addr, x)   out_be32((volatile void __iomem *)addr, x)
> +#define __cbd_out16(addr, x)   out_be16((volatile void __iomem *)addr, x)
> +#define __cbd_in32(addr)       in_be32((volatile void __iomem *)addr)
> +#define __cbd_in16(addr)       in_be16((volatile void __iomem *)addr)
>  #endif
>
>  /* write */
> diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c
> index 8a311d1..d4de57f 100644
> --- a/drivers/net/fs_enet/mac-fec.c
> +++ b/drivers/net/fs_enet/mac-fec.c
> @@ -42,6 +42,9 @@
>  #include <asm/mpc8xx.h>
>  #include <asm/cpm1.h>
>  #endif
> +#ifdef CONFIG_FS_ENET_MPC5121_FEC
> +#include "fec_mpc5121.h"
> +#endif
>
>  #ifdef CONFIG_PPC_CPM_NEW_BINDING
>  #include <asm/of_device.h>
> @@ -306,7 +309,9 @@ static void restart(struct net_device *dev)
>         * Set maximum receive buffer size.
>         */
>        FW(fecp, r_buff_size, PKT_MAXBLR_SIZE);
> +#ifndef CONFIG_FS_ENET_MPC5121_FEC
>        FW(fecp, r_hash, PKT_MAXBUF_SIZE);
> +#endif
>
>        /* get physical address */
>        rx_bd_base_phys = fep->ring_mem_addr;
> @@ -320,10 +325,17 @@ static void restart(struct net_device *dev)
>
>        fs_init_bds(dev);
>
> +#ifndef CONFIG_FS_ENET_MPC5121_FEC
>        /*
>         * Enable big endian and don't care about SDMA FC.
>         */
>        FW(fecp, fun_code, 0x78000000);
> +#else
> +       /*
> +        * Set DATA_BO and DESC_BO and leave the rest unchanged
> +        */
> +       FS(fecp, dma_control, 0xc0000000);
> +#endif
>
>        /*
>         * Set MII speed.
> @@ -334,11 +346,13 @@ static void restart(struct net_device *dev)
>         * Clear any outstanding interrupt.
>         */
>        FW(fecp, ievent, 0xffc0);
> +#ifndef CONFIG_FS_ENET_MPC5121_FEC
>  #ifndef CONFIG_PPC_MERGE
>        FW(fecp, ivec, (fep->interrupt / 2) << 29);
>  #else
>        FW(fecp, ivec, (virq_to_hw(fep->interrupt) / 2) << 29);
>  #endif
> +#endif
>
>        /*
>         * adjust to speed (only for DUET & RMII)
> @@ -368,9 +382,13 @@ static void restart(struct net_device *dev)
>                out_be32(&immap->im_cpm.cp_cptr, cptr);
>        }
>  #endif
> -
> -
> +#ifdef CONFIG_FS_ENET_MPC5121_FEC
> +       FW(fecp, r_cntrl, PKT_MAXBUF_SIZE<<16); /* max frame size */
> +       FS(fecp, r_cntrl, FEC_RCNTRL_MII_MODE); /* MII enable */
> +#else
>        FW(fecp, r_cntrl, FEC_RCNTRL_MII_MODE); /* MII enable */
> +#endif
> +
>        /*
>         * adjust to duplex mode
>         */
> diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fec.c
> index f0014cf..5d9b846 100644
> --- a/drivers/net/fs_enet/mii-fec.c
> +++ b/drivers/net/fs_enet/mii-fec.c
> @@ -38,6 +38,7 @@
>
>  #ifdef CONFIG_PPC_CPM_NEW_BINDING
>  #include <asm/of_platform.h>
> +#include <asm/time.h>
>  #endif
>
>  #include "fs_enet.h"
> @@ -71,7 +72,7 @@ static int fs_mii_fec_init(struct fec_info* fec, struct
> fs_mii_fec_platform_info
>  {
>        struct resource *r;
>        fec_t __iomem *fecp;
> -       char* name = "fsl-cpm-fec";
> +       char *name = "fsl-cpm-fec";
>
>        /* we need fec in order to be useful */
>        struct platform_device *fec_pdev =
> @@ -261,9 +262,16 @@ static int fs_enet_mdio_remove(struct of_device
> *ofdev)
>  }
>
>  static struct of_device_id fs_enet_mdio_fec_match[] = {
> +#ifdef CONFIG_FS_ENET_FEC
>        {
>                .compatible = "fsl,pq1-fec-mdio",
>        },
> +#endif
> +#ifdef CONFIG_FS_ENET_MPC5121_FEC
> +       {
> +               .compatible = "fsl,mpc5121-fec-mdio",
> +       },
> +#endif
>        {},
>  };
>
> --
> 1.5.4.3
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_13951_27510133.1213724013340
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

David,<br><br>Sorry for the late response but I have been away for the last week.<br><br>This looks like a verbatim copy of the patches authored by me in ltib.&nbsp; I think it is considered gauche to submit someone else&#39;s work with your Signed-off-by.<br>
<br>Others have already spoken of the problems with this patch.&nbsp; I am working on an alternative with far fewer ifdefs that may actually pass review.&nbsp; It has passed an off line review by Scott Wood.<br><br>I&#39;ll submit my latest patch and we will see what people think.<br>
<br>John<br><br><div class="gmail_quote">On Wed, Jun 11, 2008 at 3:44 AM, David Jander &lt;<a href="mailto:david.jander@protonic.nl">david.jander@protonic.nl</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
to current head<br>
<br>
Signed-off-by: David Jander &lt;<a href="mailto:david@protonic.nl">david@protonic.nl</a>&gt;<br>
---<br>
&nbsp;drivers/net/fs_enet/Kconfig &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; 16 ++++-<br>
&nbsp;drivers/net/fs_enet/fec_mpc5121.h &nbsp;| &nbsp;120 ++++++++++++++++++++++++++++++++++++<br>
&nbsp;drivers/net/fs_enet/fs_enet-main.c | &nbsp; 90 +++++++++++++++++++++++----<br>
&nbsp;drivers/net/fs_enet/fs_enet.h &nbsp; &nbsp; &nbsp;| &nbsp; 14 +++-<br>
&nbsp;drivers/net/fs_enet/mac-fec.c &nbsp; &nbsp; &nbsp;| &nbsp; 22 ++++++-<br>
&nbsp;drivers/net/fs_enet/mii-fec.c &nbsp; &nbsp; &nbsp;| &nbsp; 10 +++-<br>
&nbsp;6 files changed, 249 insertions(+), 23 deletions(-)<br>
&nbsp;create mode 100644 drivers/net/fs_enet/fec_mpc5121.h<br>
<br>
diff --git a/drivers/net/fs_enet/Kconfig b/drivers/net/fs_enet/Kconfig<br>
index 562ea68..8eea038 100644<br>
--- a/drivers/net/fs_enet/Kconfig<br>
+++ b/drivers/net/fs_enet/Kconfig<br>
@@ -1,9 +1,17 @@<br>
&nbsp;config FS_ENET<br>
 &nbsp; &nbsp; &nbsp; &nbsp;tristate &quot;Freescale Ethernet Driver&quot;<br>
- &nbsp; &nbsp; &nbsp; depends on CPM1 || CPM2<br>
+ &nbsp; &nbsp; &nbsp; depends on CPM1 || CPM2 || FS_ENET_MPC5121_FEC<br>
 &nbsp; &nbsp; &nbsp; &nbsp;select MII<br>
 &nbsp; &nbsp; &nbsp; &nbsp;select PHYLIB<br>
<br>
+config FS_ENET_MPC5121_FEC<br>
+ &nbsp; &nbsp; &nbsp; bool &quot;Freescale MPC512x FEC driver&quot;<br>
+ &nbsp; &nbsp; &nbsp; depends on PPC_MPC512x<br>
+ &nbsp; &nbsp; &nbsp; select FS_ENET<br>
+ &nbsp; &nbsp; &nbsp; select FS_ENET_HAS_FEC<br>
+ &nbsp; &nbsp; &nbsp; select PPC_CPM_NEW_BINDING<br>
+ &nbsp; &nbsp; &nbsp; default n<br>
+<br>
&nbsp;config FS_ENET_HAS_SCC<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bool &quot;Chip has an SCC usable for ethernet&quot;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;depends on FS_ENET &amp;&amp; (CPM1 || CPM2)<br>
@@ -16,13 +24,15 @@ config FS_ENET_HAS_FCC<br>
<br>
&nbsp;config FS_ENET_HAS_FEC<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bool &quot;Chip has an FEC usable for ethernet&quot;<br>
- &nbsp; &nbsp; &nbsp; depends on FS_ENET &amp;&amp; CPM1<br>
+ &nbsp; &nbsp; &nbsp; depends on FS_ENET &amp;&amp; (CPM1 || FS_ENET_MPC5121_FEC)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;select FS_ENET_MDIO_FEC<br>
 &nbsp; &nbsp; &nbsp; &nbsp;default y<br>
<br>
+<br>
&nbsp;config FS_ENET_MDIO_FEC<br>
 &nbsp; &nbsp; &nbsp; &nbsp;tristate &quot;MDIO driver for FEC&quot;<br>
- &nbsp; &nbsp; &nbsp; depends on FS_ENET &amp;&amp; CPM1<br>
+ &nbsp; &nbsp; &nbsp; depends on FS_ENET &amp;&amp; (CPM1 || FS_ENET_MPC5121_FEC)<br>
+<br>
<br>
&nbsp;config FS_ENET_MDIO_FCC<br>
 &nbsp; &nbsp; &nbsp; &nbsp;tristate &quot;MDIO driver for FCC&quot;<br>
diff --git a/drivers/net/fs_enet/fec_mpc5121.h b/drivers/net/fs_enet/fec_mpc5121.h<br>
new file mode 100644<br>
index 0000000..b8a69d4<br>
--- /dev/null<br>
+++ b/drivers/net/fs_enet/fec_mpc5121.h<br>
@@ -0,0 +1,120 @@<br>
+/*<br>
+ * Copyright (C) 2007,2008 Freescale Semiconductor, Inc. All rights reserved.<br>
+ *<br>
+ * Author: John Rigby, &lt;<a href="mailto:jrigby@freescale.com">jrigby@freescale.com</a>&gt;<br>
+ *<br>
+ * Modified version of drivers/net/fec.h:<br>
+ *<br>
+ * &nbsp; &nbsp; fec.h &nbsp;-- &nbsp;Fast Ethernet Controller for Motorola ColdFire SoC<br>
+ * &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;processors.<br>
+ *<br>
+ * &nbsp; &nbsp; (C) Copyright 2000-2005, Greg Ungerer (<a href="mailto:gerg@snapgear.com">gerg@snapgear.com</a>)<br>
+ * &nbsp; &nbsp; (C) Copyright 2000-2001, Lineo (<a href="http://www.lineo.com" target="_blank">www.lineo.com</a>)<br>
+ *<br>
+ * This is free software; you can redistribute it and/or modify it<br>
+ * under the terms of the GNU General Public License as published by<br>
+ * the Free Software Foundation; either version 2 of the License, or<br>
+ * (at your option) any later version.<br>
+ */<br>
+#ifndef FEC_MPC5121_H<br>
+#define FEC_MPC5121_H<br>
+<br>
+typedef struct fec {<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_reserved0;<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_ievent; &nbsp; &nbsp; &nbsp; &nbsp; /* Interrupt event reg */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_imask; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Interrupt mask reg */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_reserved1;<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_r_des_active; &nbsp; /* Receive descriptor reg */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_x_des_active; &nbsp; /* Transmit descriptor reg */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_reserved2[3];<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_ecntrl; &nbsp; &nbsp; &nbsp; &nbsp; /* Ethernet control reg */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_reserved3[6];<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_mii_data; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* MII manage frame reg */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_mii_speed; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* MII speed control reg */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_reserved4[7];<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_mib_ctrlstat; &nbsp; /* MIB control/status reg */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_reserved5[7];<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_r_cntrl; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Receive control reg */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_reserved6[15];<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_x_cntrl; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Transmit Control reg */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_reserved7[7];<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_addr_low; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* Low 32bits MAC address */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_addr_high; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* High 16bits MAC address */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_opd; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Opcode + Pause duration */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_reserved8[10];<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_hash_table_high; &nbsp; &nbsp; &nbsp; &nbsp;/* High 32bits hash table */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_hash_table_low; /* Low 32bits hash table */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_grp_hash_table_high;/* High 32bits hash table */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_grp_hash_table_low; &nbsp; &nbsp; /* Low 32bits hash table */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_reserved9[7];<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_x_wmrk; &nbsp; &nbsp; &nbsp; &nbsp; /* FIFO transmit water mark */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_reserved10;<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_r_bound; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* FIFO receive bound reg */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_r_fstart; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* FIFO receive start reg */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_reserved11[11];<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_r_des_start; &nbsp; &nbsp;/* Receive descriptor ring */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_x_des_start; &nbsp; &nbsp;/* Transmit descriptor ring */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_r_buff_size; &nbsp; &nbsp;/* Maximum receive buff size */<br>
+ &nbsp; &nbsp; &nbsp; u32 fec_dma_control; &nbsp; &nbsp;/* DMA Endian and other ctrl */<br>
+} fec_t;<br>
+<br>
+/*<br>
+ * &nbsp; &nbsp; Define the buffer descriptor structure.<br>
+ */<br>
+typedef struct bufdesc {<br>
+ &nbsp; &nbsp; &nbsp; unsigned short &nbsp;cbd_sc; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* Control and status info */<br>
+ &nbsp; &nbsp; &nbsp; unsigned short &nbsp;cbd_datlen; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* Data length */<br>
+ &nbsp; &nbsp; &nbsp; unsigned long &nbsp; cbd_bufaddr; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Buffer address */<br>
+} cbd_t;<br>
+<br>
+/*<br>
+ * &nbsp; &nbsp; The following definitions courtesy of commproc.h, which where<br>
+ * &nbsp; &nbsp; Copyright (c) 1997 Dan Malek (<a href="mailto:dmalek@jlc.net">dmalek@jlc.net</a>).<br>
+ */<br>
+#define BD_SC_EMPTY &nbsp; &nbsp; ((ushort)0x8000) &nbsp; &nbsp; &nbsp; &nbsp;/* Recieve is empty */<br>
+#define BD_SC_READY &nbsp; &nbsp; ((ushort)0x8000) &nbsp; &nbsp; &nbsp; &nbsp;/* Transmit is ready */<br>
+#define BD_SC_WRAP &nbsp; &nbsp; &nbsp;((ushort)0x2000) &nbsp; &nbsp; &nbsp; &nbsp;/* Last buffer descriptor */<br>
+#define BD_SC_INTRPT &nbsp; &nbsp;((ushort)0x1000) &nbsp; &nbsp; &nbsp; &nbsp;/* Interrupt on change */<br>
+#define BD_SC_CM &nbsp; &nbsp; &nbsp; &nbsp;((ushort)0x0200) &nbsp; &nbsp; &nbsp; &nbsp;/* Continous mode */<br>
+#define BD_SC_ID &nbsp; &nbsp; &nbsp; &nbsp;((ushort)0x0100) &nbsp; &nbsp; &nbsp; &nbsp;/* Rec&#39;d too many idles */<br>
+#define BD_SC_P &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x0100) &nbsp; &nbsp; &nbsp; &nbsp;/* xmt preamble */<br>
+#define BD_SC_BR &nbsp; &nbsp; &nbsp; &nbsp;((ushort)0x0020) &nbsp; &nbsp; &nbsp; &nbsp;/* Break received */<br>
+#define BD_SC_FR &nbsp; &nbsp; &nbsp; &nbsp;((ushort)0x0010) &nbsp; &nbsp; &nbsp; &nbsp;/* Framing error */<br>
+#define BD_SC_PR &nbsp; &nbsp; &nbsp; &nbsp;((ushort)0x0008) &nbsp; &nbsp; &nbsp; &nbsp;/* Parity error */<br>
+#define BD_SC_OV &nbsp; &nbsp; &nbsp; &nbsp;((ushort)0x0002) &nbsp; &nbsp; &nbsp; &nbsp;/* Overrun */<br>
+#define BD_SC_CD &nbsp; &nbsp; &nbsp; &nbsp;((ushort)0x0001) &nbsp; &nbsp; &nbsp; &nbsp;/* ?? */<br>
+<br>
+/* Buffer descriptor control/status used by Ethernet receive.<br>
+*/<br>
+#define BD_ENET_RX_EMPTY &nbsp; &nbsp; &nbsp; &nbsp;((ushort)0x8000)<br>
+#define BD_ENET_RX_WRAP &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x2000)<br>
+#define BD_ENET_RX_INTR &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x1000)<br>
+#define BD_ENET_RX_LAST &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x0800)<br>
+#define BD_ENET_RX_FIRST &nbsp; &nbsp; &nbsp; &nbsp;((ushort)0x0400)<br>
+#define BD_ENET_RX_MISS &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x0100)<br>
+#define BD_ENET_RX_LG &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x0020)<br>
+#define BD_ENET_RX_NO &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x0010)<br>
+#define BD_ENET_RX_SH &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x0008)<br>
+#define BD_ENET_RX_CR &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x0004)<br>
+#define BD_ENET_RX_OV &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x0002)<br>
+#define BD_ENET_RX_CL &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x0001)<br>
+#define BD_ENET_RX_STATS &nbsp; &nbsp; &nbsp; &nbsp;((ushort)0x013f) &nbsp; &nbsp; &nbsp; &nbsp;/* All status bits */<br>
+<br>
+/* Buffer descriptor control/status used by Ethernet transmit.<br>
+*/<br>
+#define BD_ENET_TX_READY &nbsp; &nbsp; &nbsp; &nbsp;((ushort)0x8000)<br>
+#define BD_ENET_TX_PAD &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((ushort)0x4000)<br>
+#define BD_ENET_TX_WRAP &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x2000)<br>
+#define BD_ENET_TX_INTR &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x1000)<br>
+#define BD_ENET_TX_LAST &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x0800)<br>
+#define BD_ENET_TX_TC &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x0400)<br>
+#define BD_ENET_TX_DEF &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((ushort)0x0200)<br>
+#define BD_ENET_TX_HB &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x0100)<br>
+#define BD_ENET_TX_LC &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x0080)<br>
+#define BD_ENET_TX_RL &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x0040)<br>
+#define BD_ENET_TX_RCMASK &nbsp; &nbsp; &nbsp; ((ushort)0x003c)<br>
+#define BD_ENET_TX_UN &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ((ushort)0x0002)<br>
+#define BD_ENET_TX_CSL &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;((ushort)0x0001)<br>
+#define BD_ENET_TX_STATS &nbsp; &nbsp; &nbsp; &nbsp;((ushort)0x03ff) &nbsp; &nbsp; &nbsp; &nbsp;/* All status bits */<br>
+<br>
+#endif /* FEC_MPC5121_H */<br>
diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c<br>
index 31c9693..4ca8513 100644<br>
--- a/drivers/net/fs_enet/fs_enet-main.c<br>
+++ b/drivers/net/fs_enet/fs_enet-main.c<br>
@@ -69,6 +69,7 @@ MODULE_PARM_DESC(fs_enet_debug,<br>
&nbsp;static void fs_enet_netpoll(struct net_device *dev);<br>
&nbsp;#endif<br>
<br>
+#define ENET_RX_ALIGN 16<br>
&nbsp;static void fs_set_multicast_list(struct net_device *dev)<br>
&nbsp;{<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct fs_enet_private *fep = netdev_priv(dev);<br>
@@ -592,6 +593,33 @@ void fs_cleanup_bds(struct net_device *dev)<br>
<br>
&nbsp;/**********************************************************************************/<br>
<br>
+#define TX_ALIGN_WORKAROUND<br>
+#ifdef TX_ALIGN_WORKAROUND<br>
+static struct sk_buff *aligntxskb(struct net_device *dev, struct sk_buff *skb)<br>
+{<br>
+ &nbsp; &nbsp; &nbsp; struct sk_buff *skbn;<br>
+ &nbsp; &nbsp; &nbsp; skbn = dev_alloc_skb(ENET_RX_FRSIZE+0x20);<br>
+ &nbsp; &nbsp; &nbsp; if (skbn)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; skb_align(skbn, 0x20);<br>
+<br>
+ &nbsp; &nbsp; &nbsp; if (!skbn) {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; printk(KERN_WARNING DRV_MODULE_NAME<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;: %s Memory squeeze, dropping tx packet.\n&quot;,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev-&gt;name);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_kfree_skb_any(skb);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return NULL;<br>
+ &nbsp; &nbsp; &nbsp; }<br>
+<br>
+ &nbsp; &nbsp; &nbsp; skb_copy_from_linear_data(skb, skbn-&gt;data, skb-&gt;len);<br>
+ &nbsp; &nbsp; &nbsp; skb_put(skbn, skb-&gt;len);<br>
+ &nbsp; &nbsp; &nbsp; dev_kfree_skb_any(skb);<br>
+ &nbsp; &nbsp; &nbsp; return skbn;<br>
+}<br>
+#else<br>
+#define aligntxskb(skb) skb<br>
+#endif<br>
+<br>
+<br>
&nbsp;static int fs_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)<br>
&nbsp;{<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct fs_enet_private *fep = netdev_priv(dev);<br>
@@ -600,6 +628,7 @@ static int fs_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;u16 sc;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;unsigned long flags;<br>
<br>
+ &nbsp; &nbsp; &nbsp; skb = aligntxskb(dev, skb);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;spin_lock_irqsave(&amp;fep-&gt;tx_lock, flags);<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
@@ -951,7 +980,7 @@ static int fs_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)<br>
&nbsp;{<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct fs_enet_private *fep = netdev_priv(dev);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct mii_ioctl_data *mii = (struct mii_ioctl_data *)&amp;rq-&gt;ifr_data;<br>
-<br>
+ &nbsp; &nbsp; &nbsp; printk(&quot;&lt;1&gt; %s: %s (%d)\n&quot;,__FILE__,__FUNCTION__,__LINE__);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (!netif_running(dev))<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EINVAL;<br>
<br>
@@ -1147,6 +1176,7 @@ static int fs_cleanup_instance(struct net_device *ndev)<br>
<br>
&nbsp;/**************************************************************************************/<br>
<br>
+#ifndef CONFIG_FS_ENET_MPC5121_FEC<br>
&nbsp;/* handy pointer to the immap */<br>
&nbsp;void __iomem *fs_enet_immap = NULL;<br>
<br>
@@ -1168,6 +1198,10 @@ static void cleanup_immap(void)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;iounmap(fs_enet_immap);<br>
&nbsp;#endif<br>
&nbsp;}<br>
+#else<br>
+#define setup_immap() 0<br>
+#define cleanup_immap() do {} while (0)<br>
+#endif<br>
<br>
&nbsp;/**************************************************************************************/<br>
<br>
@@ -1370,10 +1404,17 @@ static struct of_device_id fs_enet_match[] = {<br>
 &nbsp; &nbsp; &nbsp; &nbsp;},<br>
&nbsp;#endif<br>
&nbsp;#ifdef CONFIG_FS_ENET_HAS_FEC<br>
+#ifndef CONFIG_FS_ENET_MPC5121_FEC<br>
 &nbsp; &nbsp; &nbsp; &nbsp;{<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.compatible = &quot;fsl,pq1-fec-enet&quot;,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.data = (void *)&amp;fs_fec_ops,<br>
 &nbsp; &nbsp; &nbsp; &nbsp;},<br>
+#else<br>
+ &nbsp; &nbsp; &nbsp; {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .compatible = &quot;fsl,mpc5121-fec&quot;,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .data = (void *)&amp;fs_fec_ops,<br>
+ &nbsp; &nbsp; &nbsp; },<br>
+#endif<br>
&nbsp;#endif<br>
 &nbsp; &nbsp; &nbsp; &nbsp;{}<br>
&nbsp;};<br>
@@ -1431,15 +1472,42 @@ static int fs_enet_remove(struct device *dev)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;return fs_cleanup_instance(dev_get_drvdata(dev));<br>
&nbsp;}<br>
<br>
+#ifdef CONFIG_PM<br>
+static int fs_enet_suspend(struct device *dev, pm_message_t state)<br>
+{<br>
+ &nbsp; &nbsp; &nbsp; struct net_device *ndev = dev_get_drvdata(dev);<br>
+<br>
+ &nbsp; &nbsp; &nbsp; if (netif_running(ndev))<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fs_enet_close(ndev);<br>
+<br>
+ &nbsp; &nbsp; &nbsp; return 0;<br>
+}<br>
+<br>
+static int fs_enet_resume(struct device *dev)<br>
+{<br>
+ &nbsp; &nbsp; &nbsp; struct net_device *ndev = dev_get_drvdata(dev);<br>
+<br>
+ &nbsp; &nbsp; &nbsp; if (netif_running(ndev))<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fs_enet_open(ndev);<br>
+<br>
+ &nbsp; &nbsp; &nbsp; return 0;<br>
+}<br>
+#else<br>
+#define fs_enet_suspend &nbsp; &nbsp; &nbsp; &nbsp;NULL<br>
+#define fs_enet_resume NULL<br>
+#endif<br>
+<br>
&nbsp;static struct device_driver fs_enet_fec_driver = {<br>
+#ifndef CONFIG_FS_ENET_MPC5121_FEC<br>
 &nbsp; &nbsp; &nbsp; &nbsp;.name &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; = &quot;fsl-cpm-fec&quot;,<br>
+#else<br>
+ &nbsp; &nbsp; &nbsp; .name &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; = &quot;fsl-mpc5121-fec&quot;,<br>
+#endif<br>
 &nbsp; &nbsp; &nbsp; &nbsp;.bus &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= &amp;platform_bus_type,<br>
 &nbsp; &nbsp; &nbsp; &nbsp;.probe &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= fs_enet_probe,<br>
 &nbsp; &nbsp; &nbsp; &nbsp;.remove &nbsp; &nbsp; &nbsp; &nbsp; = fs_enet_remove,<br>
-#ifdef CONFIG_PM<br>
-/* &nbsp; &nbsp; .suspend &nbsp; &nbsp; &nbsp; &nbsp;= fs_enet_suspend, &nbsp; &nbsp; &nbsp;TODO */<br>
-/* &nbsp; &nbsp; .resume &nbsp; &nbsp; &nbsp; &nbsp; = fs_enet_resume, &nbsp; &nbsp; &nbsp; TODO */<br>
-#endif<br>
+ &nbsp; &nbsp; &nbsp; .suspend &nbsp; &nbsp; &nbsp; &nbsp;= fs_enet_suspend,<br>
+ &nbsp; &nbsp; &nbsp; .resume &nbsp; &nbsp; &nbsp; &nbsp; = fs_enet_resume,<br>
&nbsp;};<br>
<br>
&nbsp;static struct device_driver fs_enet_scc_driver = {<br>
@@ -1447,10 +1515,8 @@ static struct device_driver fs_enet_scc_driver = {<br>
 &nbsp; &nbsp; &nbsp; &nbsp;.bus &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= &amp;platform_bus_type,<br>
 &nbsp; &nbsp; &nbsp; &nbsp;.probe &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= fs_enet_probe,<br>
 &nbsp; &nbsp; &nbsp; &nbsp;.remove &nbsp; &nbsp; &nbsp; &nbsp; = fs_enet_remove,<br>
-#ifdef CONFIG_PM<br>
-/* &nbsp; &nbsp; .suspend &nbsp; &nbsp; &nbsp; &nbsp;= fs_enet_suspend, &nbsp; &nbsp; &nbsp;TODO */<br>
-/* &nbsp; &nbsp; .resume &nbsp; &nbsp; &nbsp; &nbsp; = fs_enet_resume, &nbsp; &nbsp; &nbsp; TODO */<br>
-#endif<br>
+ &nbsp; &nbsp; &nbsp; .suspend &nbsp; &nbsp; &nbsp; &nbsp;= fs_enet_suspend,<br>
+ &nbsp; &nbsp; &nbsp; .resume &nbsp; &nbsp; &nbsp; &nbsp; = fs_enet_resume,<br>
&nbsp;};<br>
<br>
&nbsp;static struct device_driver fs_enet_fcc_driver = {<br>
@@ -1458,10 +1524,8 @@ static struct device_driver fs_enet_fcc_driver = {<br>
 &nbsp; &nbsp; &nbsp; &nbsp;.bus &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= &amp;platform_bus_type,<br>
 &nbsp; &nbsp; &nbsp; &nbsp;.probe &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= fs_enet_probe,<br>
 &nbsp; &nbsp; &nbsp; &nbsp;.remove &nbsp; &nbsp; &nbsp; &nbsp; = fs_enet_remove,<br>
-#ifdef CONFIG_PM<br>
-/* &nbsp; &nbsp; .suspend &nbsp; &nbsp; &nbsp; &nbsp;= fs_enet_suspend, &nbsp; &nbsp; &nbsp;TODO */<br>
-/* &nbsp; &nbsp; .resume &nbsp; &nbsp; &nbsp; &nbsp; = fs_enet_resume, &nbsp; &nbsp; &nbsp; TODO */<br>
-#endif<br>
+ &nbsp; &nbsp; &nbsp; .suspend &nbsp; &nbsp; &nbsp; &nbsp;= fs_enet_suspend,<br>
+ &nbsp; &nbsp; &nbsp; .resume &nbsp; &nbsp; &nbsp; &nbsp; = fs_enet_resume,<br>
&nbsp;};<br>
<br>
&nbsp;static int __init fs_init(void)<br>
diff --git a/drivers/net/fs_enet/fs_enet.h b/drivers/net/fs_enet/fs_enet.h<br>
index e05389c..56d3f14 100644<br>
--- a/drivers/net/fs_enet/fs_enet.h<br>
+++ b/drivers/net/fs_enet/fs_enet.h<br>
@@ -9,11 +9,17 @@<br>
&nbsp;#include &lt;linux/dma-mapping.h&gt;<br>
<br>
&nbsp;#include &lt;linux/fs_enet_pd.h&gt;<br>
+#ifndef CONFIG_FS_ENET_MPC5121_FEC<br>
&nbsp;#include &lt;asm/fs_pd.h&gt;<br>
+#else<br>
+#include &quot;fec_mpc5121.h&quot;<br>
+#endif<br>
<br>
&nbsp;#ifdef CONFIG_CPM1<br>
&nbsp;#include &lt;asm/cpm1.h&gt;<br>
+#endif<br>
<br>
+#if defined(CONFIG_CPM1) || defined(CONFIG_FS_ENET_MPC5121_FEC)<br>
&nbsp;struct fec_info {<br>
 &nbsp; &nbsp; &nbsp; &nbsp;fec_t __iomem *fecp;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;u32 mii_speed;<br>
@@ -170,10 +176,10 @@ void fs_enet_platform_cleanup(void);<br>
&nbsp;#define __cbd_in16(addr) &nbsp; &nbsp; &nbsp; __raw_readw(addr)<br>
&nbsp;#else<br>
&nbsp;/* for others play it safe */<br>
-#define __cbd_out32(addr, x) &nbsp; out_be32(addr, x)<br>
-#define __cbd_out16(addr, x) &nbsp; out_be16(addr, x)<br>
-#define __cbd_in32(addr) &nbsp; &nbsp; &nbsp; in_be32(addr)<br>
-#define __cbd_in16(addr) &nbsp; &nbsp; &nbsp; in_be16(addr)<br>
+#define __cbd_out32(addr, x) &nbsp; out_be32((volatile void __iomem *)addr, x)<br>
+#define __cbd_out16(addr, x) &nbsp; out_be16((volatile void __iomem *)addr, x)<br>
+#define __cbd_in32(addr) &nbsp; &nbsp; &nbsp; in_be32((volatile void __iomem *)addr)<br>
+#define __cbd_in16(addr) &nbsp; &nbsp; &nbsp; in_be16((volatile void __iomem *)addr)<br>
&nbsp;#endif<br>
<br>
&nbsp;/* write */<br>
diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c<br>
index 8a311d1..d4de57f 100644<br>
--- a/drivers/net/fs_enet/mac-fec.c<br>
+++ b/drivers/net/fs_enet/mac-fec.c<br>
@@ -42,6 +42,9 @@<br>
&nbsp;#include &lt;asm/mpc8xx.h&gt;<br>
&nbsp;#include &lt;asm/cpm1.h&gt;<br>
&nbsp;#endif<br>
+#ifdef CONFIG_FS_ENET_MPC5121_FEC<br>
+#include &quot;fec_mpc5121.h&quot;<br>
+#endif<br>
<br>
&nbsp;#ifdef CONFIG_PPC_CPM_NEW_BINDING<br>
&nbsp;#include &lt;asm/of_device.h&gt;<br>
@@ -306,7 +309,9 @@ static void restart(struct net_device *dev)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; * Set maximum receive buffer size.<br>
 &nbsp; &nbsp; &nbsp; &nbsp; */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;FW(fecp, r_buff_size, PKT_MAXBLR_SIZE);<br>
+#ifndef CONFIG_FS_ENET_MPC5121_FEC<br>
 &nbsp; &nbsp; &nbsp; &nbsp;FW(fecp, r_hash, PKT_MAXBUF_SIZE);<br>
+#endif<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* get physical address */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;rx_bd_base_phys = fep-&gt;ring_mem_addr;<br>
@@ -320,10 +325,17 @@ static void restart(struct net_device *dev)<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;fs_init_bds(dev);<br>
<br>
+#ifndef CONFIG_FS_ENET_MPC5121_FEC<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
 &nbsp; &nbsp; &nbsp; &nbsp; * Enable big endian and don&#39;t care about SDMA FC.<br>
 &nbsp; &nbsp; &nbsp; &nbsp; */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;FW(fecp, fun_code, 0x78000000);<br>
+#else<br>
+ &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;* Set DATA_BO and DESC_BO and leave the rest unchanged<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; FS(fecp, dma_control, 0xc0000000);<br>
+#endif<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
 &nbsp; &nbsp; &nbsp; &nbsp; * Set MII speed.<br>
@@ -334,11 +346,13 @@ static void restart(struct net_device *dev)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; * Clear any outstanding interrupt.<br>
 &nbsp; &nbsp; &nbsp; &nbsp; */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;FW(fecp, ievent, 0xffc0);<br>
+#ifndef CONFIG_FS_ENET_MPC5121_FEC<br>
&nbsp;#ifndef CONFIG_PPC_MERGE<br>
 &nbsp; &nbsp; &nbsp; &nbsp;FW(fecp, ivec, (fep-&gt;interrupt / 2) &lt;&lt; 29);<br>
&nbsp;#else<br>
 &nbsp; &nbsp; &nbsp; &nbsp;FW(fecp, ivec, (virq_to_hw(fep-&gt;interrupt) / 2) &lt;&lt; 29);<br>
&nbsp;#endif<br>
+#endif<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
 &nbsp; &nbsp; &nbsp; &nbsp; * adjust to speed (only for DUET &amp; RMII)<br>
@@ -368,9 +382,13 @@ static void restart(struct net_device *dev)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;out_be32(&amp;immap-&gt;im_cpm.cp_cptr, cptr);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&nbsp;#endif<br>
-<br>
-<br>
+#ifdef CONFIG_FS_ENET_MPC5121_FEC<br>
+ &nbsp; &nbsp; &nbsp; FW(fecp, r_cntrl, PKT_MAXBUF_SIZE&lt;&lt;16); /* max frame size */<br>
+ &nbsp; &nbsp; &nbsp; FS(fecp, r_cntrl, FEC_RCNTRL_MII_MODE); /* MII enable */<br>
+#else<br>
 &nbsp; &nbsp; &nbsp; &nbsp;FW(fecp, r_cntrl, FEC_RCNTRL_MII_MODE); /* MII enable */<br>
+#endif<br>
+<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
 &nbsp; &nbsp; &nbsp; &nbsp; * adjust to duplex mode<br>
 &nbsp; &nbsp; &nbsp; &nbsp; */<br>
diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fec.c<br>
index f0014cf..5d9b846 100644<br>
--- a/drivers/net/fs_enet/mii-fec.c<br>
+++ b/drivers/net/fs_enet/mii-fec.c<br>
@@ -38,6 +38,7 @@<br>
<br>
&nbsp;#ifdef CONFIG_PPC_CPM_NEW_BINDING<br>
&nbsp;#include &lt;asm/of_platform.h&gt;<br>
+#include &lt;asm/time.h&gt;<br>
&nbsp;#endif<br>
<br>
&nbsp;#include &quot;fs_enet.h&quot;<br>
@@ -71,7 +72,7 @@ static int fs_mii_fec_init(struct fec_info* fec, struct fs_mii_fec_platform_info<br>
&nbsp;{<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct resource *r;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;fec_t __iomem *fecp;<br>
- &nbsp; &nbsp; &nbsp; char* name = &quot;fsl-cpm-fec&quot;;<br>
+ &nbsp; &nbsp; &nbsp; char *name = &quot;fsl-cpm-fec&quot;;<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* we need fec in order to be useful */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct platform_device *fec_pdev =<br>
@@ -261,9 +262,16 @@ static int fs_enet_mdio_remove(struct of_device *ofdev)<br>
&nbsp;}<br>
<br>
&nbsp;static struct of_device_id fs_enet_mdio_fec_match[] = {<br>
+#ifdef CONFIG_FS_ENET_FEC<br>
 &nbsp; &nbsp; &nbsp; &nbsp;{<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.compatible = &quot;fsl,pq1-fec-mdio&quot;,<br>
 &nbsp; &nbsp; &nbsp; &nbsp;},<br>
+#endif<br>
+#ifdef CONFIG_FS_ENET_MPC5121_FEC<br>
+ &nbsp; &nbsp; &nbsp; {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .compatible = &quot;fsl,mpc5121-fec-mdio&quot;,<br>
+ &nbsp; &nbsp; &nbsp; },<br>
+#endif<br>
 &nbsp; &nbsp; &nbsp; &nbsp;{},<br>
&nbsp;};<br>
<font color="#888888"><br>
--<br>
<a href="http://1.5.4.3" target="_blank">1.5.4.3</a><br>
<br>
_______________________________________________<br>
Linuxppc-embedded mailing list<br>
<a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>
<a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br>
</font></blockquote></div><br>

------=_Part_13951_27510133.1213724013340--
