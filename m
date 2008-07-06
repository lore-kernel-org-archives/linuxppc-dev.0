Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 789EFDDDEF
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jul 2008 19:44:01 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: [PATCH v4] ibm_newemac: Parameterize EMAC Multicast Match Handling
Date: Sun, 6 Jul 2008 11:43:50 +0200
References: <1215249512-1974-1-git-send-email-gerickson@nuovations.com>
	<1215303343-26410-1-git-send-email-gerickson@nuovations.com>
In-Reply-To: <1215303343-26410-1-git-send-email-gerickson@nuovations.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200807061143.51002.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 06 July 2008, Grant Erickson wrote:
> Various instances of the EMAC core have varying: 1) number of address
> match slots, 2) width of the registers for handling address match slots,
> 3) number of registers for handling address match slots and 4) base
> offset for those registers.

Thanks Grant. Apart from Ben's comments I only have a few nitpicking comment. 
Please see below.

<snip>

> diff --git a/drivers/net/ibm_newemac/core.c
> b/drivers/net/ibm_newemac/core.c index 5d2108c..931a061 100644
> --- a/drivers/net/ibm_newemac/core.c
> +++ b/drivers/net/ibm_newemac/core.c
> @@ -363,25 +363,32 @@ static int emac_reset(struct emac_instance *dev)
>
>  static void emac_hash_mc(struct emac_instance *dev)
>  {
> -	struct emac_regs __iomem *p = dev->emacp;
> -	u16 gaht[4] = { 0 };
> +	const int regs = EMAC_XAHT_REGS(dev);
> +	u32 *gaht_base = emac_gaht_base(dev);
> +	u32 gaht_temp[regs];
>  	struct dev_mc_list *dmi;
> +	int i;
>
>  	DBG(dev, "hash_mc %d" NL, dev->ndev->mc_count);
>
> +	memset(gaht_temp, 0, sizeof (gaht_temp));
> +
>  	for (dmi = dev->ndev->mc_list; dmi; dmi = dmi->next) {
> -		int bit;
> +		int slot, reg, mask;
>  		DBG2(dev, "mc %02x:%02x:%02x:%02x:%02x:%02x" NL,
>  		     dmi->dmi_addr[0], dmi->dmi_addr[1], dmi->dmi_addr[2],
>  		     dmi->dmi_addr[3], dmi->dmi_addr[4], dmi->dmi_addr[5]);
>
> -		bit = 63 - (ether_crc(ETH_ALEN, dmi->dmi_addr) >> 26);
> -		gaht[bit >> 4] |= 0x8000 >> (bit & 0x0f);
> +		slot = EMAC_XAHT_CRC_TO_SLOT(dev, ether_crc(ETH_ALEN, dmi->dmi_addr));
> +		reg = EMAC_XAHT_SLOT_TO_REG(dev, slot);
> +		mask = EMAC_XAHT_SLOT_TO_MASK(dev, slot);
> +
> +		gaht_temp[reg] |= mask;
> +	}
> +
> +	for (i = 0; i < regs; i++) {
> +		out_be32(gaht_base + i, gaht_temp[i]);
>  	}

No parentheses on single line statements.

> -	out_be32(&p->gaht1, gaht[0]);
> -	out_be32(&p->gaht2, gaht[1]);
> -	out_be32(&p->gaht3, gaht[2]);
> -	out_be32(&p->gaht4, gaht[3]);
>  }
>
>  static inline u32 emac_iff2rmr(struct net_device *ndev)
> @@ -398,7 +405,8 @@ static inline u32 emac_iff2rmr(struct net_device *ndev)
>
>  	if (ndev->flags & IFF_PROMISC)
>  		r |= EMAC_RMR_PME;
> -	else if (ndev->flags & IFF_ALLMULTI || ndev->mc_count > 32)
> +	else if (ndev->flags & IFF_ALLMULTI ||
> +			 (ndev->mc_count > EMAC_XAHT_SLOTS(dev)))
>  		r |= EMAC_RMR_PMME;
>  	else if (ndev->mc_count > 0)
>  		r |= EMAC_RMR_MAE;
> @@ -2015,10 +2023,10 @@ static int emac_get_regs_len(struct emac_instance
> *dev) {
>  	if (emac_has_feature(dev, EMAC_FTR_EMAC4))
>  		return sizeof(struct emac_ethtool_regs_subhdr) +
> -			EMAC4_ETHTOOL_REGS_SIZE;
> +			EMAC4_ETHTOOL_REGS_SIZE(dev);
>  	else
>  		return sizeof(struct emac_ethtool_regs_subhdr) +
> -			EMAC_ETHTOOL_REGS_SIZE;
> +			EMAC_ETHTOOL_REGS_SIZE(dev);
>  }
>
>  static int emac_ethtool_get_regs_len(struct net_device *ndev)
> @@ -2045,12 +2053,12 @@ static void *emac_dump_regs(struct emac_instance
> *dev, void *buf) hdr->index = dev->cell_index;
>  	if (emac_has_feature(dev, EMAC_FTR_EMAC4)) {
>  		hdr->version = EMAC4_ETHTOOL_REGS_VER;
> -		memcpy_fromio(hdr + 1, dev->emacp, EMAC4_ETHTOOL_REGS_SIZE);
> -		return ((void *)(hdr + 1) + EMAC4_ETHTOOL_REGS_SIZE);
> +		memcpy_fromio(hdr + 1, dev->emacp, EMAC4_ETHTOOL_REGS_SIZE(dev));
> +		return ((void *)(hdr + 1) + EMAC4_ETHTOOL_REGS_SIZE(dev));
>  	} else {
>  		hdr->version = EMAC_ETHTOOL_REGS_VER;
> -		memcpy_fromio(hdr + 1, dev->emacp, EMAC_ETHTOOL_REGS_SIZE);
> -		return ((void *)(hdr + 1) + EMAC_ETHTOOL_REGS_SIZE);
> +		memcpy_fromio(hdr + 1, dev->emacp, EMAC_ETHTOOL_REGS_SIZE(dev));
> +		return ((void *)(hdr + 1) + EMAC_ETHTOOL_REGS_SIZE(dev));
>  	}
>  }
>
> @@ -2540,7 +2548,9 @@ static int __devinit emac_init_config(struct
> emac_instance *dev) }
>
>  	/* Check EMAC version */
> -	if (of_device_is_compatible(np, "ibm,emac4")) {
> +	if (of_device_is_compatible(np, "ibm,emac4sync")) {
> +		dev->features |= (EMAC_FTR_EMAC4 | EMAC_FTR_EMAC4SYNC);
> +	} else if (of_device_is_compatible(np, "ibm,emac4")) {
>  		dev->features |= EMAC_FTR_EMAC4;
>  		if (of_device_is_compatible(np, "ibm,emac-440gx"))
>  			dev->features |= EMAC_FTR_440GX_PHY_CLK_FIX;
> @@ -2601,6 +2611,15 @@ static int __devinit emac_init_config(struct
> emac_instance *dev) }
>  	memcpy(dev->ndev->dev_addr, p, 6);
>
> +	/* IAHT and GAHT filter parameterization */
> +	if (emac_has_feature(dev, EMAC_FTR_EMAC4SYNC)) {
> +		dev->xaht_slots_shift = EMAC4SYNC_XAHT_SLOTS_SHIFT;
> +		dev->xaht_width_shift = EMAC4SYNC_XAHT_WIDTH_SHIFT;
> +	} else {
> +		dev->xaht_slots_shift = EMAC4_XAHT_SLOTS_SHIFT;
> +		dev->xaht_width_shift = EMAC4_XAHT_WIDTH_SHIFT;
> +	}
> +
>  	DBG(dev, "features     : 0x%08x / 0x%08x\n", dev->features,
> EMAC_FTRS_POSSIBLE); DBG(dev, "tx_fifo_size : %d (%d gige)\n",
> dev->tx_fifo_size, dev->tx_fifo_size_gige); DBG(dev, "rx_fifo_size : %d (%d
> gige)\n", dev->rx_fifo_size, dev->rx_fifo_size_gige); @@ -2672,7 +2691,8 @@
> static int __devinit emac_probe(struct of_device *ofdev, goto
> err_irq_unmap;
>  	}
>  	// TODO : request_mem_region
> -	dev->emacp = ioremap(dev->rsrc_regs.start, sizeof(struct emac_regs));
> +	dev->emacp = ioremap(dev->rsrc_regs.start,
> +						 dev->rsrc_regs.end - dev->rsrc_regs.start + 1);


Indentation above seems incorrect.

>  	if (dev->emacp == NULL) {
>  		printk(KERN_ERR "%s: Can't map device registers!\n",
>  		       np->full_name);
> @@ -2884,6 +2904,10 @@ static struct of_device_id emac_match[] =
>  		.type		= "network",
>  		.compatible	= "ibm,emac4",
>  	},
> +	{
> +		.type		= "network",
> +		.compatible	= "ibm,emac4sync",
> +	},
>  	{},
>  };
>
> diff --git a/drivers/net/ibm_newemac/core.h
> b/drivers/net/ibm_newemac/core.h index 1683db9..312bfa5 100644
> --- a/drivers/net/ibm_newemac/core.h
> +++ b/drivers/net/ibm_newemac/core.h
> @@ -235,6 +235,10 @@ struct emac_instance {
>  	u32				fifo_entry_size;
>  	u32				mal_burst_size; /* move to MAL ? */
>
> +	/* IAHT and GAHT filter parameterization */
> +	u32				xaht_slots_shift;
> +	u32				xaht_width_shift;
> +
>  	/* Descriptor management
>  	 */
>  	struct mal_descriptor		*tx_desc;
> @@ -309,6 +313,10 @@ struct emac_instance {
>   * Set if we need phy clock workaround for 440ep or 440gr
>   */
>  #define EMAC_FTR_440EP_PHY_CLK_FIX	0x00000100
> +/*
> + * The 405EX and 460EX contain the EMAC4SYNC core
> + */
> +#define EMAC_FTR_EMAC4SYNC		0x00000200
>
>
>  /* Right now, we don't quite handle the always/possible masks on the
> @@ -320,7 +328,8 @@ enum {
>
>  	EMAC_FTRS_POSSIBLE	=
>  #ifdef CONFIG_IBM_NEW_EMAC_EMAC4
> -	    EMAC_FTR_EMAC4 | EMAC_FTR_HAS_NEW_STACR |
> +	    EMAC_FTR_EMAC4	| EMAC_FTR_EMAC4SYNC	|
> +	    EMAC_FTR_HAS_NEW_STACR	|
>  	    EMAC_FTR_STACR_OC_INVERT | EMAC_FTR_440GX_PHY_CLK_FIX |
>  #endif
>  #ifdef CONFIG_IBM_NEW_EMAC_TAH
> @@ -342,6 +351,71 @@ static inline int emac_has_feature(struct
> emac_instance *dev, (EMAC_FTRS_POSSIBLE & dev->features & feature);
>  }
>
> +/*
> + * Various instances of the EMAC core have varying 1) number of
> + * address match slots, 2) width of the registers for handling address
> + * match slots, 3) number of registers for handling address match
> + * slots and 4) base offset for those registers.
> + *
> + * These macros and inlines handle these differences based on
> + * parameters supplied by the device tree.
> + */
> +
> +#define	EMAC4_XAHT_SLOTS_SHIFT		6
> +#define	EMAC4_XAHT_WIDTH_SHIFT		4
> +#define	EMAC4_XAHT_BASE_OFFSET		0x30
> +
> +#define	EMAC4SYNC_XAHT_SLOTS_SHIFT	8
> +#define	EMAC4SYNC_XAHT_WIDTH_SHIFT	5
> +#define	EMAC4SYNC_XAHT_BASE_OFFSET	0x80
> +
> +
> +#define	EMAC_XAHT_SLOTS(dev)         	(1 << (dev)->xaht_slots_shift)
> +#define	EMAC_XAHT_WIDTH(dev)         	(1 << (dev)->xaht_width_shift)
> +#define	EMAC_XAHT_REGS(dev)          	(1 << ((dev)->xaht_slots_shift - \
> +					       (dev)->xaht_width_shift))
> +
> +#define	EMAC_XAHT_CRC_TO_SLOT(dev, crc)			\
> +	((EMAC_XAHT_SLOTS(dev) - 1) -			\
> +	 ((crc) >> ((sizeof (u32) * BITS_PER_BYTE) -	\
> +		    (dev)->xaht_slots_shift)))
> +
> +#define	EMAC_XAHT_SLOT_TO_REG(dev, slot)		\
> +	((slot) >> (dev)->xaht_width_shift)
> +
> +#define	EMAC_XAHT_SLOT_TO_MASK(dev, slot)		\
> +	((u32)(1 << (EMAC_XAHT_WIDTH(dev) - 1)) >>	\
> +	 ((slot) & (u32)(EMAC_XAHT_WIDTH(dev) - 1)))
> +
> +static inline u32 *emac_xaht_base(struct emac_instance *dev)
> +{
> +	struct emac_regs __iomem *p = dev->emacp;
> +	int offset;
> +
> +	if (emac_has_feature(dev, EMAC_FTR_EMAC4SYNC))
> +	    offset = EMAC4SYNC_XAHT_BASE_OFFSET;
> +	else
> +	    offset = EMAC4_XAHT_BASE_OFFSET;

Indentation with 4 spaces instead of one tab above "offset =" (twice).

Thanks.

BTW: You should send those ibm_newemac related patches to the netdev list too.

Best regards,
Stefan
