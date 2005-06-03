Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id B1FAA67B24
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Jun 2005 13:29:53 +1000 (EST)
Date: Thu, 2 Jun 2005 20:29:51 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050602202951.A28314@cox.net>
References: <20050601105145.B15351@cox.net>
	<20050602153540.53486bde.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050602153540.53486bde.akpm@osdl.org>;
	from akpm@osdl.org on Thu, Jun 02, 2005 at 03:35:40PM -0700
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] cpm_uart: Route SCC2 pins for the STx GP3 board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 02, 2005 at 03:35:40PM -0700, Andrew Morton wrote:
> Matt Porter <mporter@kernel.crashing.org> wrote:
> >
> > +++ uncommitted/drivers/serial/cpm_uart/cpm_uart_cpm2.c  (mode:100644)
> > @@ -134,12 +134,21 @@
> >  
> >  void scc2_lineif(struct uart_cpm_port *pinfo)
> >  {
> > +	/*
> > +	 * STx GP3 uses the SCC2 secondary option pin assignment
> > +	 * which this driver doesn't account for in the static
> > +	 * pin assignments. This kind of board specific info
> > +	 * really has to get out of the driver so boards can
> > +	 * be supported in a sane fashion.
> > +	 */
> > +#ifndef CONFIG_STX_GP3
> >  	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
> >  	io->iop_pparb |= 0x008b0000;
> 
> Silly question: why is this driver using a volatile pointer to
> memory-mapped I/O rather than readl and writel?

readl/writel just won't work.  They are byte swapped on PPC since
they are specifically for PCI access.  In other "on-chip" drivers
for PPC32, we typically ioremap() to a non-volatile type and then
use out_be32()/in_be32() since everything except PCI on PPC is
in right-endian (big endian) form. out_be*()/in_be*() contain
an eieio instruction to guarantee proper ordering.

I know this driver was recently rewritten but the authors may have
missed the past threads about why volatile use is discouraged.  We
do something similar with register overlay structures in
drivers/net/ibm_emac. However, we don't use a volatile type and do
use PPC32-specific (these are PPC-specific drivers anyway)
out_be32()/in_be32() for correctness.

-Matt
