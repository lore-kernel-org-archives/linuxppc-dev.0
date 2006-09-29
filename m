Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D979367BDD
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Sep 2006 02:46:11 +1000 (EST)
Date: Fri, 29 Sep 2006 09:46:09 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH] IBM GPIO driver for PowerPC 4xx is back from the dead
Message-ID: <20060929164609.GB17656@gate.ebshome.net>
References: <1159518565.9269.1.camel@jb-portable>
	<200609291106.20987.arnd.bergmann@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
In-Reply-To: <200609291106.20987.arnd.bergmann@de.ibm.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@teamlog.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Sep 29, 2006 at 11:06:19AM +0200, Arnd Bergmann wrote:
> 
> > +{
> > +šššššššu32 cfg_reg;
> > +
> > +šššššššif (device != 0)
> > +šššššššššššššššreturn -ENXIO;
> > +
> > +#ifdef CONFIG_40x
> > +#ifdef DCRN_CHCR0
> > +ššššššš/*
> > +ššššššš * PPC405 uses CPC0_CR0 to select multiplexed GPIO pins.
> > +ššššššš */
> > +šššššššcfg_reg = mfdcr(DCRN_CHCR0);
> > +šššššššcfg_reg = (cfg_reg & ~mask) | (data & mask);
> > +šššššššmtdcr(DCRN_CHCR0, cfg_reg);
> > +#endif
> > +#elif CONFIG_440GP
> > +ššššššš/*
> > +ššššššš * PPC440GP uses CPC0_GPIO to select multiplexed GPIO pins.
> > +ššššššš */
> > +šššššššcfg_reg = mfdcr(DCRN_CPC0_GPIO);
> > +šššššššcfg_reg = (cfg_reg & ~mask) | (data & mask);
> > +šššššššmtdcr(DCRN_CPC0_GPIO, cfg_reg);
> > +#elif CONFIG_440GX
> > +ššššššš/*
> > +ššššššš * PPC440GX uses SDR0_PFC0 to select multiplexed GPIO pins
> > +ššššššš */
> > +šššššššcfg_reg = SDR_READ(DCRN_SDR_PFC0);
> > +šššššššcfg_reg = (cfg_reg & ~mask) | (data & mask);
> > +šššššššSDR_WRITE(DCRN_SDR_PFC0, cfg_reg);
> > +#else
> > +#error This driver is only supported on PPC40x and PPC440 CPUs
> > +#endif
> 
> This prevents building a single kernel for multiple 440 version.
> Please use a run-time check, or better get the necessary information
> from the device tree.

440 kernels _are_ built for each particular 440 chip separately, and 
not all these defines are even available simultaneously.

So, frankly, I don't understand your complain here. We don't support 
single kernel image running on different 440s. Also, last time I 
checked, 440 port wasn't using device tree as well.

-- 
Eugene
