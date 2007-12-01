Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DA46CDDDF7
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 08:17:26 +1100 (EST)
Date: Sat, 1 Dec 2007 15:21:01 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] [PATCH] pasemi: NMI support with MPIC
Message-ID: <20071201212101.GA29428@lixom.net>
References: <20071201182841.GA25103@lixom.net>
	<1196541525.13230.144.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196541525.13230.144.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 02, 2007 at 07:38:45AM +1100, Benjamin Herrenschmidt wrote:
> 
> On Sat, 2007-12-01 at 12:28 -0600, Olof Johansson wrote:
> > Some PWRficient-based boards have a NMI button that's wired up to a GPIO
> > as interrupt source. By configuring the openpic accordingly, these get
> > delivered as a machine check with high priority, instead of as an external
> > interrupt.
> > 
> > The device tree contains a property "nmi-source" in the openpic node
> > for these systems, and it's the (hwirq) source for the input.
> > 
> > Also, for these interrupts, the IACK is read from another register than
> > the regular (MCACK), but they are EOI'd as usual. So implement said
> > function for the mpic driver.
> > 
> > Finally, move a couple of external function defines to include/ instead
> > of local under sysdev. Being able to mask/unmask and eoi directly saves
> > us from setting up a dummy irq handler that will never be called.
> 
> It's interesting how creative implementors are with MPICs :-)

:-)

> Looks allright to me but I haven't tested for regressions.

I've build tested all platforms, and I don't expect any runtime changes
for others since they're not executing the new paths.


Thanks,

-Olof
