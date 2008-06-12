Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id DF3BCDDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 20:34:00 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] Re-added support for FEC on MPC5121 from Freescale
	LTIB
Date: Thu, 12 Jun 2008 12:33:12 +0200
References: <200806111143.08905.david.jander@protonic.nl>
	<200806111144.44218.david.jander@protonic.nl>
	<48501725.9080907@freescale.com>
In-Reply-To: <48501725.9080907@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200806121233.13089.david.jander@protonic.nl>
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

On Wednesday 11 June 2008 20:19:17 Scott Wood wrote:
> Please post patches to linuxppc-dev rather than linuxppc-embedded --
> you'll get a larger reviewing audience.

Ok, but I thought linuxppc-dev was for all non-embedded development only...

> PPC_CPM_NEW_BINDING is default y, and will be going away as an option as
> soon as arch/ppc does.  In the meantime, instead of selecting it here,
> add FS_ENET_MPC5121_FEC to the depends list of PPC_CPM_NEW_BINDING -- or
> just remove the depends list altogether.

Good idea, done that.

> > +/*
> > + *	Define the buffer descriptor structure.
> > + */
> > +typedef struct bufdesc {
> > +	unsigned short	cbd_sc;			/* Control and status info */
> > +	unsigned short	cbd_datlen;		/* Data length */
> > +	unsigned long	cbd_bufaddr;		/* Buffer address */
> > +} cbd_t;
>
> This can be factored out into a common header -- along with most if not
> all of the flag defines.

Ok, I added the changes to ../fec.h inside an #if-#else.

> > +#define TX_ALIGN_WORKAROUND
> > +#ifdef TX_ALIGN_WORKAROUND
> > +static struct sk_buff *aligntxskb(struct net_device *dev, struct sk_buff
> > *skb) +{
> > +	struct sk_buff *skbn;
> > +	skbn = dev_alloc_skb(ENET_RX_FRSIZE+0x20);
> > +	if (skbn)
> > +		skb_align(skbn, 0x20);
> > +
> > +	if (!skbn) {
> > +	    printk(KERN_WARNING DRV_MODULE_NAME
> > +		    ": %s Memory squeeze, dropping tx packet.\n",
> > +		    dev->name);
> > +		dev_kfree_skb_any(skb);
> > +		return NULL;
> > +	}
> > +
> > +	skb_copy_from_linear_data(skb, skbn->data, skb->len);
> > +	skb_put(skbn, skb->len);
> > +	dev_kfree_skb_any(skb);
> > +	return skbn;
> > +}
> > +#else
> > +#define aligntxskb(skb) skb
> > +#endif
>
> Can we encode the required alignment for rx and tx in the device tree?

Hmmm... This actually is a silicon-bug workaround AFAIK. 
I agree with you that this solution is not good, but I doubt resolving this 
in the device-tree is much better. It will add run-time overhead just because 
right now there are some buggy chips around. I think this could better 
be a Kconfig option, so people can have faster kernels if they want later.
If you are concerned about multiplatform kernels, this shouldn't harm.

>[...]
> > +	printk("<1> %s: %s (%d)\n",__FILE__,__FUNCTION__,__LINE__);
>
> Please use the KERN_ prefixes rather than hardcoding the number, and put
> spaces after commas.  Of course, if this is to be here at all, this
> should be dev_dbg() rather than KERN_ALERT.

Ooops. This shouldn't be here. Removing it.

> > -#define __cbd_out32(addr, x)	out_be32(addr, x)
> > -#define __cbd_out16(addr, x)	out_be16(addr, x)
> > -#define __cbd_in32(addr)	in_be32(addr)
> > -#define __cbd_in16(addr)	in_be16(addr)
> > +#define __cbd_out32(addr, x)	out_be32((volatile void __iomem *)addr, x)
> > +#define __cbd_out16(addr, x)	out_be16((volatile void __iomem *)addr, x)
> > +#define __cbd_in32(addr)	in_be32((volatile void __iomem *)addr)
> > +#define __cbd_in16(addr)	in_be16((volatile void __iomem *)addr)
>
> NACK, please don't remove type checking.

Ok, but given the macro's further down, I'll have to cast there...

#define CBDR_BUFADDR(_cbd) __cbd_in32((volatile void __iomem *)&(_cbd)->cbd_bufaddr)

> > +#ifndef CONFIG_FS_ENET_MPC5121_FEC
> >  	FW(fecp, r_hash, PKT_MAXBUF_SIZE);
> > +#endif
> >
> >  	/* get physical address */
> >  	rx_bd_base_phys = fep->ring_mem_addr;
> > @@ -320,10 +325,17 @@ static void restart(struct net_device *dev)
> >
> >  	fs_init_bds(dev);
> >
> > +#ifndef CONFIG_FS_ENET_MPC5121_FEC
> >  	/*
> >  	 * Enable big endian and don't care about SDMA FC.
> >  	 */
> >  	FW(fecp, fun_code, 0x78000000);
> > +#else
> > +	/*
> > +	 * Set DATA_BO and DESC_BO and leave the rest unchanged
> > +	 */
> > +	FS(fecp, dma_control, 0xc0000000);
> > +#endif

I have tried, but it is almost impossible, since both FEC types use a struct
named "fec_t" which very different betwen both types. That means that the code
would have enormous amounts of "if" statements all over.
Any suggestion?

Best regards,

-- 
David Jander
Protonic Holland.
