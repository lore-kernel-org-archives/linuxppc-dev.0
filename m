Return-Path: <domen@coderock.org>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id BB94BDDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 May 2007 04:00:34 +1000 (EST)
Date: Fri, 25 May 2007 20:00:32 +0200
From: Domen Puncer <domen@coderock.org>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 3/3] Re: [PATCH] mpc52xx_psc_spi: fix it for CONFIG_PPC_MERGE
Message-ID: <20070525180032.GA27425@nd47.coderock.org>
References: <20070516073707.GD9667@nd47.coderock.org>
	<464ABE97.7090603@246tNt.com>
	<20070525084750.GC23149@nd47.coderock.org>
	<200705250934.47045.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705250934.47045.david-b@pacbell.net>
Cc: Dragos Carp <dragos.carp@toptica.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 25/05/07 09:34 -0700, David Brownell wrote:
> On Friday 25 May 2007, Domen Puncer wrote:
> 
> > For clk.h, it does seem quite some code, compared what's there currently.
> 
> You're using it wrong then ...

I meant this + the clock.c part.

> 
> 
> > --- work-powerpc.git.orig/drivers/spi/mpc52xx_psc_spi.c
> > +++ work-powerpc.git/drivers/spi/mpc52xx_psc_spi.c
> > @@ -18,6 +18,7 @@
> >  
> >  #if defined(CONFIG_PPC_MERGE)
> >  #include <asm/of_platform.h>
> > +#include <linux/clk.h>
> >  #else
> >  #include <linux/platform_device.h>
> >  #endif
> > @@ -106,13 +107,52 @@ static void mpc52xx_psc_spi_activate_cs(
> >  	/* Set clock frequency and bits per word
> >  	 * Because psc->ccr is defined as 16bit register instead of 32bit
> >  	 * just set the lower byte of BitClkDiv
> > +	 * Because BitClkDiv is 8-bit on mpc5200. Lets stay compatible.
> >  	 */
> > +#if defined(CONFIG_PPC_MERGE)
> >  	ccr = in_be16(&psc->ccr);
> >  	ccr &= 0xFF00;
> > +	{
> > +		u8 bitclkdiv = 2;	/* minimum bitclkdiv */
> > +		int speed = cs->speed_hz ? cs->speed_hz : 1000000;
> > +		char clk_name[10];
> > +		struct clk *clk;	// TODO into mps, clk_get, clk_put
> > +		int mclk;
> > +		int system;
> > +		/*
> > +		 * pscclk = mclk/(bitclkdiv+1))		bitclkdiv is 8-bit, >= 2
> > +		 * mclk = fsys/(mclkdiv+1)		mclkdiv is 9-bit, >= 1
> > +		 * as mclkdiv has higher precision, we want is as big as possible
> > +		 * => we get < 0.002*clock error
> > +		 */
> > +
> > +		snprintf(clk_name, 10, "psc%i_mclk", spi->master->bus_num);
> > +
> > +		clk = clk_get(&spi->dev, clk_name);
> 
> Don't expect spi->dev to have a clock.  Instead, the host controller
> has a clock, which would be looked up the probe() routine, then released
> in remove():  clock = clk_get(dev, "clockname"), with the clock framework
> using "dev" to identify which clock it returns.  (That is, the function
> clock for all SPI controllers would have the same name ... not for
> example "spi1_fclk", "spi2_fclk", etc. but instead "spi_fclk".)


Aha, so that's what struct dev* is for. :-)
Now I see two options:
- create something like at91_clock_associate(), and call it from
  _probe (of_devices are created automatically from device tree,
  so we can't call it the way at91_clock_associate is).
- in clk_get() call dev_get_drvdata(dev), cast it to spi_master *,
  _hope_ it really is that, use bus_id.

Sure there must be a third, right one?


	Domen
> 
> 
> > +		if (!clk)
> > +			dev_err(&spi->dev, "couldn't get %s clock\n", clk_name);
> > +
> > +		system = clk_get_rate(clk_get_parent(clk));	// TODO, checking, refcounting
> > +		mclk = speed * (bitclkdiv+1);
> > +		if (system/mclk > 512) { /* bigger than mclkdiv */
> > +			bitclkdiv = system/512/speed;
> > +			mclk = speed * (bitclkdiv+1);
> > +		}
> > +
> > +		if (clk_set_rate(clk, mclk))
> > +			dev_err(&spi->dev, "couldn't set %s's rate\n", clk_name);
> > +
> > +		dev_info(&spi->dev, "clock: wanted: %i, got: %li\n", speed,
> > +				clk_round_rate(clk, mclk) / (bitclkdiv+1));
> > +
> > +		ccr |= bitclkdiv;
> > +	}
> > +#else
> >  	if (cs->speed_hz)
> >  		ccr |= (MCLK / cs->speed_hz - 1) & 0xFF;
> >  	else /* by default SPI Clk 1MHz */
> >  		ccr |= (MCLK / 1000000 - 1) & 0xFF;
> > +#endif
> >  	out_be16(&psc->ccr, ccr);
> >  	mps->bits_per_word = cs->bits_per_word;
> >  
> \
