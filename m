Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D5B1DDDEB
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 11:02:19 +1100 (EST)
Subject: Re: [PATCH 8/21] [POWERPC] EP405 boards support for arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20071222102424.bc96d03c.sfr@canb.auug.org.au>
References: <20071221043931.1A5CCDDEC0@ozlabs.org>
	<20071222102424.bc96d03c.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Sat, 22 Dec 2007 11:01:09 +1100
Message-Id: <1198281669.6737.24.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2007-12-22 at 10:24 +1100, Stephen Rothwell wrote:

> > +++ linux-merge/arch/powerpc/boot/4xx.c	2007-12-21 14:19:46.000000000 +1100
> > @@ -179,13 +179,16 @@ void ibm40x_dbcr_reset(void)
> >  #define EMAC_RESET 0x20000000
> >  void ibm4xx_quiesce_eth(u32 *emac0, u32 *emac1)
> >  {
> > -	/* Quiesce the MAL and EMAC(s) since PIBS/OpenBIOS don't do this for us */
> > +	/* Quiesce the MAL and EMAC(s) since PIBS/OpenBIOS don't
> > +	 * do this for us
> > +	 */
> >  	if (emac0)
> >  		*emac0 = EMAC_RESET;
> >  	if (emac1)
> >  		*emac1 = EMAC_RESET;
> >  
> >  	mtdcr(DCRN_MAL0_CFG, MAL_RESET);
> > +	while (mfdcr(DCRN_MAL0_CFG) & MAL_RESET) {};
> 
> You need the {} or the ; but not both and please put them indented on the
> next line so that it is very clear that this is an empty loop.

Code was copy/pasted from somewhere else... we can always do a fixup
later.

> > +	if (cpc0_cr0 & 0x80) {
> > +		/* uart0 uses the external clock */
> > +		uart0 = ser_clk;
> > +	} else {
> > +		uart0 = cpu / udiv;
> > +	}
> 
> The braces aren't really needed. (Yes, I noticed that you just moved the
> code here)

Yup :-)

> > +	if (cpc0_cr0 & 0x40) {
> > +		/* uart1 uses the external clock */
> > +		uart1 = ser_clk;
> > +	} else {
> > +		uart1 = cpu / udiv;
> > +	}
> 
> And again.

I'd rather do cleanups separately. I won't send new patches until I'm
back from vacation so Josh, if you want to fix those little nits up,
feel free.

> > +++ linux-merge/arch/powerpc/platforms/40x/ep405.c	2007-12-21 14:19:46.000000000 +1100
> > +
> > +static struct of_device_id ep405_of_bus[] = {
> 
> __initdata (preferably) or const

Ben.
