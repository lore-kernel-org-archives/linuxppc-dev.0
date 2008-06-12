Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D1B4BDDE18
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 23:29:42 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m5CDTbUh021324 for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 06:29:37 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5CDTaRZ019072
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 08:29:36 -0500 (CDT)
Date: Thu, 12 Jun 2008 08:29:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH 2/2] Re-added support for FEC on MPC5121 from Freescale
	LTIB
Message-ID: <20080612132936.GB21060@ld0162-tx32.am.freescale.net>
References: <200806111143.08905.david.jander@protonic.nl>
	<200806111144.44218.david.jander@protonic.nl>
	<48501725.9080907@freescale.com>
	<200806121233.13089.david.jander@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200806121233.13089.david.jander@protonic.nl>
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

On Thu, Jun 12, 2008 at 12:33:12PM +0200, David Jander wrote:
> On Wednesday 11 June 2008 20:19:17 Scott Wood wrote:
> > Please post patches to linuxppc-dev rather than linuxppc-embedded --
> > you'll get a larger reviewing audience.
> 
> Ok, but I thought linuxppc-dev was for all non-embedded development only...

No, it's for all Linux/PowerPC development.  linuxppc-embedded is more
for user questions.

> > Can we encode the required alignment for rx and tx in the device tree?
> 
> Hmmm... This actually is a silicon-bug workaround AFAIK. 
> I agree with you that this solution is not good, but I doubt resolving this 
> in the device-tree is much better. It will add run-time overhead just because 
> right now there are some buggy chips around. I think this could better 
> be a Kconfig option, so people can have faster kernels if they want later.
> If you are concerned about multiplatform kernels, this shouldn't harm.

OK.

> > > -#define __cbd_out32(addr, x)	out_be32(addr, x)
> > > -#define __cbd_out16(addr, x)	out_be16(addr, x)
> > > -#define __cbd_in32(addr)	in_be32(addr)
> > > -#define __cbd_in16(addr)	in_be16(addr)
> > > +#define __cbd_out32(addr, x)	out_be32((volatile void __iomem *)addr, x)
> > > +#define __cbd_out16(addr, x)	out_be16((volatile void __iomem *)addr, x)
> > > +#define __cbd_in32(addr)	in_be32((volatile void __iomem *)addr)
> > > +#define __cbd_in16(addr)	in_be16((volatile void __iomem *)addr)
> >
> > NACK, please don't remove type checking.
> 
> Ok, but given the macro's further down, I'll have to cast there...
> 
> #define CBDR_BUFADDR(_cbd) __cbd_in32((volatile void __iomem *)&(_cbd)->cbd_bufaddr)

Why?  cbd should already have an __iomem annotation, and the volatile is
unnecessary.

> > > +#ifndef CONFIG_FS_ENET_MPC5121_FEC
> > >  	FW(fecp, r_hash, PKT_MAXBUF_SIZE);
> > > +#endif
> > >
> > >  	/* get physical address */
> > >  	rx_bd_base_phys = fep->ring_mem_addr;
> > > @@ -320,10 +325,17 @@ static void restart(struct net_device *dev)
> > >
> > >  	fs_init_bds(dev);
> > >
> > > +#ifndef CONFIG_FS_ENET_MPC5121_FEC
> > >  	/*
> > >  	 * Enable big endian and don't care about SDMA FC.
> > >  	 */
> > >  	FW(fecp, fun_code, 0x78000000);
> > > +#else
> > > +	/*
> > > +	 * Set DATA_BO and DESC_BO and leave the rest unchanged
> > > +	 */
> > > +	FS(fecp, dma_control, 0xc0000000);
> > > +#endif
> 
> I have tried, but it is almost impossible, since both FEC types use a struct
> named "fec_t" which very different betwen both types. That means that the code
> would have enormous amounts of "if" statements all over.
> Any suggestion?

OK, I missed that this was FEC-specific code and not general fs-enet. 

8xx/512x multiplatform is already unsupported due to core differences,
but make sure that 82xx/512x multiplatform doesn't get broken.

-Scott
