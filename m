Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 4652267C46
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 11:13:14 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'David Brownell'" <david-b@pacbell.net>,
	<spi-devel-general@lists.sourceforge.net>
Subject: RE: [spi-devel-general] [PATCH] Adapt spi_mpc83xx SPI driver for 832x
Date: Thu, 14 Dec 2006 01:13:12 +0100
Message-ID: <037901c71f14$a47115b0$020120ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200612131231.22905.david-b@pacbell.net>
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net] 
> Sent: den 13 december 2006 21:31
> To: spi-devel-general@lists.sourceforge.net
> Cc: Joakim Tjernlund; 'Kumar Gala'; 'linuxppc-dev Development'
> Subject: Re: [spi-devel-general] [PATCH] Adapt spi_mpc83xx 
> SPI driver for 832x
> 
> 
> On Wednesday 13 December 2006 7:36 am, Joakim Tjernlund wrote:
> 
> > > One problem I have with this patch is the fact that it 
> assumes the  
> > > current driver for (mpc834x) and your mods to support 
> mpc832x/QE are  
> > > mutually exclusive.
> > 
> > I don't see that as a problem ATM. If that is added it 
> should be optional.
> 
> If PPC supports multi-CPU/board kernels, PPC drivers should 
> too.  I know that
> some ARMs don't support them (PXA) while some do (OMAP); so 
> PPC could go either
> way.  (Overall it's a win, since it's easier to uncover build 
> breakage if one
> kernel can support lots of configurations and drivers.)
> 
> The problem I have with this patch is that it has too much 
> #ifdeffery.  If

Too much? There is only 2 of them.

> the PPC code expects that, it should be easy to put 
> infrastructure in place
> so that it can be eliminated.  That is, if the PPC 
> powers-that-be allow it!
> 
> 
> > > We need to handle the case of having driver support for 
> both the QE  
> > > and MPC834x style in the same kernel.
> > 
> > Adding that will double the number RX_BUF/TX_BUF functions 
> from 6 to 12
> 
> Your patch already does this, just they're #ifdeffed so that 
> only one of
> the sets will build at a time.

Yes, that's my point

> 
> 
> > (possibly this can be reduced by adding more logic to the 
> tx_buf/rx_buf functions)
> > not to mention what will happen when support for reversed 
> bit order is added.
> 
> Sure enough, sounds ugly.  But cpu_is_xxx() macros, combined 
> with GCC dead
> code elimination will strip out functions that are unused, so 
> that e.g.
> 
> 	if (cpu_is_mpc834x())
> 		fn = mpc834x_spi_tx_buf_u16;
> 	else if (cpu_is_mpc832x())
> 		fn = mpc832x_spi_tx_buf_u16;
> 
> would only link one of them unless the kernel supports both SOCs.  And
> without in-driver #ifdeffery.

Hmm, I can't find any cpu_is_xxx macros/functions. I guess the
infrastructure isn't there yet?

> 
>  
> > I would argue that the kernel lacks the possibility to 
> remove complexity
> > I don't need. Example in this driver is that there is no 
> way to remove
> > support for 16 and 32 bit SPI character sizes. The same 
> goes for a lot of
> > the probing code in fsl-soc.c.
> 
> You could certainly add Kconfig options to help shift some complexity
> from runtime to compile time.  But if you do that, remember that it's
> not always a win in terms of the overall system.  Every configuration
> needs to be tested for correctness, after all.

Well, so does the dynamic kernel too. I don't know if the 16/32 bit
char size works, I don't have such HW.

> 
> 
> > It would be nice if a board port could add a custom header file that
> > gets included by all .c automatically. Then one could add knobs
> > (read #defines) there to futher tune such things as SPI char size.
> > That way one don't have add Kconfig entries for all those small
> > tuning knobs.
> 
> Sounds error prone to me.  What's the point ... removing maybe 100
> bytes of code in this one driver?  You could save more than that
> just by switching over to platform_device_probe() instead of using
> platform_device_register().  And that'd be without adding failure
> modes like "oops, this board stack really _does_ use 12 bit words
> for the ADCs".

One size reduction in another area doesn't justify bloat in
another. People are switching to kzmalloc() to save space(not
the only reason though).

The point is not only this driver. I add small tweaks here and
there and it would be great if I could put function prototypes,
my own #defines there too. This would help me not to clutter pristine
kernel code too much, makes maintenace easier.

 Jocke
 
