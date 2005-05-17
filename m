Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F27D8679FC
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2005 13:17:59 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <2dd506f0a6d4b03e771c0bc9d80735e6@embeddededge.com>
References: <1116222720.5095.86.camel@gaston>
	<7d5cfed0ee1edade8050d2c4da94b3f1@freescale.com>
	<c58d28ab50872f95d4c4a751d1768513@embeddededge.com>
	<1116255938.5095.133.camel@gaston>
	<fe487e7a8a89e65cfefd4f5dd39a982d@embeddededge.com>
	<1116261725.5095.139.camel@gaston> <4288DFCB.2080208@mvista.com>
	<4288E10A.9030408@mvista.com>
	<2dd506f0a6d4b03e771c0bc9d80735e6@embeddededge.com>
Content-Type: text/plain
Date: Tue, 17 May 2005 13:14:39 +1000
Message-Id: <1116299680.5095.175.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, John Reiser <jreiser@BitWagon.com>
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-05-16 at 16:31 -0400, Dan Malek wrote:
> On May 16, 2005, at 2:06 PM, Mark A. Greer wrote:
> 
> > Oops...
> > /me unintentionally stepped into the middle of a flame war  :)
> 
> Just pee on it :-)
> 
> > To be clear, "offender" == board that has an io_block_mapping below 
> > the 3 GB line.
> 
> That is one of the obvious changes. You are likely to find some other 
> assumptions
> that may need attention.  The problem with io_block_mapping is you just 
> can't
> remove it, you have to fix up all of the code that is based on the 
> assumption these
> spaces are mapped.  You are likely to find yourself in a situation 
> where you need
> access to some board control registers before VM is set up and you can 
> call
> ioremap().  So, you will find yourself doing some hack in head.S to map 
> BAT
> registers to get access to this, which is exactly what 
> io_block_mapping() does,
> only in a way that is obvious :-)

Well, I agree that way we currently do it has this issue, but I think
this is because we did it wrong in the first place. We really shouldn't
need to do anything before ioremap can be used. And if we need an early
ioremap, we could implement bolted hash entries like we do on ppc64 :)
However, don't get wrong here, I'm not 100% opposed to the use of BATs
for early mappings, I just think that the whole hard-coding of the
virtual address is a bad idea, and that we shouldn't have allowed them
to be below KERNELBASE. The BAT could still have been "dynamically"
positioned using the ioremap_bot mecanism with appropriate alignment, or
at worse, we could have kept the current mecanism, but just not let it
work below KERNELBASE.

Ben.
