Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 755C3DDEBE
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 08:02:46 +1000 (EST)
Date: Wed, 6 Jun 2007 17:09:13 -0500
To: Timur Tabi <timur@freescale.com>
Subject: Re: MPC8349ea Random Device Generator driver
Message-ID: <20070606220913.GA27820@lixom.net>
References: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
	<46672DB4.80504@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46672DB4.80504@freescale.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, sl@powerlinux.fr,
	Philippe Lachenal <philippe.lachenal@hotmail.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 06, 2007 at 04:57:08PM -0500, Timur Tabi wrote:

> > +#include <asm/of_platform.h>
> > +#include <asm/io.h>
> > +
> > +#define TALITOS_RNGSR		0x028	/* RNG status register */
> > +#define TALITOS_RNGSR_HI	0x02c	/* RNG status register */
> > +#define TALITOS_RNGSR_HI_RD	0x1	/* RNG Reset done */
> > +#define TALITOS_RNGSR_HI_OFL	0xff0000/* number of dwords in RNG output FIFO*/
> > +#define TALITOS_RNGDSR		0x010	/* RNG data size register */
> > +#define TALITOS_RNGDSR_HI	0x014	/* RNG data size register */
> > +#define TALITOS_RNG_FIFO	0x800	/* RNG FIFO - pool of random numbers */
> > +#define TALITOS_RNGISR		0x030	/* RNG Interrupt status register */
> > +#define TALITOS_RNGISR_HI	0x034	/* RNG Interrupt status register */
> > +#define TALITOS_RNGRCR		0x018	/* RNG Reset control register */
> > +#define TALITOS_RNGRCR_HI	0x01c	/* RNG Reset control register */
> 
> Please create a structure instead of using macros like this.  Example:
> 
> struct sec_rng {
> 	__be64	rngmr;
> 	u8 res1[8];
> 	__be64 rngdsr;
> 	__be64 rngrcr;
> ...
> };
> 
> and then ...	

There's nothing wrong with the way he coded that up. Lots of drivers
are written that way (all of mine are). It's at least as clear as any
structure, and it doesn't cause temptation to do...

> > +static int talitos_hwrng_data_present(struct hwrng *rng)
> > +{
> > +	void __iomem *rng_regs = (void __iomem *)rng->priv;
> 
> 	struct sec_rng __iomem *rng = (struct sec_rng __iomem *) rng->priv;
> 
> > +
> > +
> > +	/* check for things like FIFO underflow */
> > +	
> > +	u32 v;
> > +
> > +	v = in_be32(rng_regs + TALITOS_RNGISR_HI);
> 
> 	u64 v;
> 	v = rng->rngisr;
> 
> or something like that.  Try to use the built-in support for 64-bit data types when possible.

...this. NO! Don't reference ioremapped memory from regular code like
that. The way he's doing it is the preferred way.


-Olof
