Return-Path: <david-b@pacbell.net>
Received: from smtp110.sbc.mail.mud.yahoo.com (smtp110.sbc.mail.mud.yahoo.com
	[68.142.198.209]) by ozlabs.org (Postfix) with SMTP id 7502ADDEC1
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Dec 2006 11:57:15 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [PATCH] Adapt spi_mpc83xx SPI driver for 832x
Date: Fri, 22 Dec 2006 16:57:11 -0800
References: <037901c71f14$a47115b0$020120ac@Jocke>
In-Reply-To: <037901c71f14$a47115b0$020120ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200612221657.12007.david-b@pacbell.net>
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 13 December 2006 4:13 pm, Joakim Tjernlund wrote:
>
> > The problem I have with this patch is that it has too much 
> > #ifdeffery.  If
> 
> Too much? There is only 2 of them.

But it's the wrong kind of  #ifdeffery, and that's avoidable.


> > > (possibly this can be reduced by adding more logic to the 
> > > tx_buf/rx_buf functions)
> > > not to mention what will happen when support for reversed 
> > > bit order is added.
> > 
> > Sure enough, sounds ugly.  But cpu_is_xxx() macros, combined 
> > with GCC dead
> > code elimination will strip out functions that are unused, so 
> > that e.g.
> > 
> > 	if (cpu_is_mpc834x())
> > 		fn = mpc834x_spi_tx_buf_u16;
> > 	else if (cpu_is_mpc832x())
> > 		fn = mpc832x_spi_tx_buf_u16;
> > 
> > would only link one of them unless the kernel supports both SOCs.  And
> > without in-driver #ifdeffery.
> 
> Hmm, I can't find any cpu_is_xxx macros/functions. I guess the
> infrastructure isn't there yet?

So it would seem.    At least for PPC.  I noticed the patch from
Kumar Gala, which takes an alternate approach based on parameters
passed through platform_data ... that works too, in terms of
code being cleaner.

- Dave
