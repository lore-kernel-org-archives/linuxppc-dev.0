Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05C99DE857
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 04:19:23 +1000 (EST)
Message-ID: <48501725.9080907@freescale.com>
Date: Wed, 11 Jun 2008 13:19:17 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH 2/2] Re-added support for FEC on MPC5121 from Freescale
	LTIB
References: <200806111143.08905.david.jander@protonic.nl>
	<200806111144.44218.david.jander@protonic.nl>
In-Reply-To: <200806111144.44218.david.jander@protonic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Please post patches to linuxppc-dev rather than linuxppc-embedded -- 
you'll get a larger reviewing audience.

David Jander wrote:
> +config FS_ENET_MPC5121_FEC
> +	bool "Freescale MPC512x FEC driver"
> +	depends on PPC_MPC512x
> +	select FS_ENET
> +	select FS_ENET_HAS_FEC
> +	select PPC_CPM_NEW_BINDING

PPC_CPM_NEW_BINDING is default y, and will be going away as an option as 
soon as arch/ppc does.  In the meantime, instead of selecting it here, 
add FS_ENET_MPC5121_FEC to the depends list of PPC_CPM_NEW_BINDING -- or 
just remove the depends list altogether.

> +	default n

Unnecessary, please omit.

> +/*
> + *	Define the buffer descriptor structure.
> + */
> +typedef struct bufdesc {
> +	unsigned short	cbd_sc;			/* Control and status info */
> +	unsigned short	cbd_datlen;		/* Data length */
> +	unsigned long	cbd_bufaddr;		/* Buffer address */
> +} cbd_t;

This can be factored out into a common header -- along with most if not 
all of the flag defines.

> diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
> index 31c9693..4ca8513 100644
> --- a/drivers/net/fs_enet/fs_enet-main.c
> +++ b/drivers/net/fs_enet/fs_enet-main.c
> @@ -69,6 +69,7 @@ MODULE_PARM_DESC(fs_enet_debug,
>  static void fs_enet_netpoll(struct net_device *dev);
>  #endif
>  
> +#define ENET_RX_ALIGN 16

This is already defined in fs_enet.h.

> +#define TX_ALIGN_WORKAROUND
> +#ifdef TX_ALIGN_WORKAROUND
> +static struct sk_buff *aligntxskb(struct net_device *dev, struct sk_buff *skb)
> +{
> +	struct sk_buff *skbn;
> +	skbn = dev_alloc_skb(ENET_RX_FRSIZE+0x20);
> +	if (skbn)
> +		skb_align(skbn, 0x20);
> +
> +	if (!skbn) { 
> +	    printk(KERN_WARNING DRV_MODULE_NAME
> +		    ": %s Memory squeeze, dropping tx packet.\n",
> +		    dev->name);
> +		dev_kfree_skb_any(skb);
> +		return NULL;
> +	}
> +
> +	skb_copy_from_linear_data(skb, skbn->data, skb->len);
> +	skb_put(skbn, skb->len);
> +	dev_kfree_skb_any(skb);
> +	return skbn;
> +}
> +#else
> +#define aligntxskb(skb) skb
> +#endif

Can we encode the required alignment for rx and tx in the device tree?

> @@ -951,7 +980,7 @@ static int fs_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
>  {
>  	struct fs_enet_private *fep = netdev_priv(dev);
>  	struct mii_ioctl_data *mii = (struct mii_ioctl_data *)&rq->ifr_data;
> -
> +	printk("<1> %s: %s (%d)\n",__FILE__,__FUNCTION__,__LINE__);

Please use the KERN_ prefixes rather than hardcoding the number, and put 
spaces after commas.  Of course, if this is to be here at all, this 
should be dev_dbg() rather than KERN_ALERT.

> +#ifndef CONFIG_FS_ENET_MPC5121_FEC
>  /* handy pointer to the immap */
>  void __iomem *fs_enet_immap = NULL;
>  
> @@ -1168,6 +1198,10 @@ static void cleanup_immap(void)
>  	iounmap(fs_enet_immap);
>  #endif
>  }
> +#else
> +#define setup_immap() 0
> +#define cleanup_immap() do {} while (0)
> +#endif

NACK, this precludes a 52xx/82xx multiplatform kernel.

>  static struct device_driver fs_enet_fec_driver = {
> +#ifndef CONFIG_FS_ENET_MPC5121_FEC
>  	.name	  	= "fsl-cpm-fec",
> +#else
> +	.name	  	= "fsl-mpc5121-fec",
> +#endif
 >  	.bus		= &platform_bus_type,

This is non-PPC_CPM_NEW_BINDING stuff which is now for arch/ppc only -- 
we don't need to support 52xx with it if it didn't already.

> +#ifndef CONFIG_FS_ENET_MPC5121_FEC
>  #include <asm/fs_pd.h>
> +#else
> +#include "fec_mpc5121.h"
> +#endif

Why can't we unconditionally include asm/fs_pd.h?

> -#define __cbd_out32(addr, x)	out_be32(addr, x)
> -#define __cbd_out16(addr, x)	out_be16(addr, x)
> -#define __cbd_in32(addr)	in_be32(addr)
> -#define __cbd_in16(addr)	in_be16(addr)
> +#define __cbd_out32(addr, x)	out_be32((volatile void __iomem *)addr, x)
> +#define __cbd_out16(addr, x)	out_be16((volatile void __iomem *)addr, x)
> +#define __cbd_in32(addr)	in_be32((volatile void __iomem *)addr)
> +#define __cbd_in16(addr)	in_be16((volatile void __iomem *)addr)

NACK, please don't remove type checking.

> +#ifndef CONFIG_FS_ENET_MPC5121_FEC
>  	FW(fecp, r_hash, PKT_MAXBUF_SIZE);
> +#endif
>  
>  	/* get physical address */
>  	rx_bd_base_phys = fep->ring_mem_addr;
> @@ -320,10 +325,17 @@ static void restart(struct net_device *dev)
>  
>  	fs_init_bds(dev);
>  
> +#ifndef CONFIG_FS_ENET_MPC5121_FEC
>  	/*
>  	 * Enable big endian and don't care about SDMA FC.
>  	 */
>  	FW(fecp, fun_code, 0x78000000);
> +#else
> +	/*
> +	 * Set DATA_BO and DESC_BO and leave the rest unchanged
> +	 */
> +	FS(fecp, dma_control, 0xc0000000);
> +#endif

Please do a runtime check for hw type rather than compile-time (here and 
elsewhere).

-Scott
