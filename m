Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CC0AE2C0124
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 07:33:15 +1000 (EST)
Message-ID: <1345066379.11596.1.camel@pasglop>
Subject: Re: [PATCH V7 1/3] powerpc/pci: Make sure ISA IO base is not zero
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Thu, 16 Aug 2012 07:32:59 +1000
In-Reply-To: <502BDC6B.4090800@freescale.com>
References: <1345021026-10886-1-git-send-email-B38951@freescale.com>
 <1345021026-10886-2-git-send-email-B38951@freescale.com>
 <502BDC6B.4090800@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-08-15 at 12:29 -0500, Scott Wood wrote:
> > ---
> >  arch/powerpc/kernel/pci-common.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> > index 0f75bd5..2a09aa5 100644
> > --- a/arch/powerpc/kernel/pci-common.c
> > +++ b/arch/powerpc/kernel/pci-common.c
> > @@ -734,7 +734,7 @@ void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
> >  			hose->io_base_virt = ioremap(cpu_addr, size);
> >  
> >  			/* Expect trouble if pci_addr is not 0 */
> > -			if (primary)
> > +			if (primary || !isa_io_base)
> >  				isa_io_base =
> >  					(unsigned long)hose->io_base_virt;
> >  #endif /* CONFIG_PPC32 */
> > 
> 
> Didn't I already point out that this has problems when the primary bus
> is not the first to be probed?  If your answer is that you fix that in a
> later patch, that breaks bisectability.

Is it though ? ie, we will override it with the real primary in the
above test, so it will only very temporarily be set to the "wrong" bus
no ? IE, the test will still trip on the actual "primary" if there's
one.

Cheers,
Ben.
