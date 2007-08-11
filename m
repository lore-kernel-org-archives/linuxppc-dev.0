Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B106EDDEC8
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 05:49:26 +1000 (EST)
Subject: Re: pci in arch/powerpc vs arch/ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <2b043cf24b0f5ddda06fcf1f01cb62f3@kernel.crashing.org>
References: <op.twhnwi18nhx3hy@phoenix>
	<20070803201036.GA18229@ld0162-tx32.am.freescale.net>
	<F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
	<op.twol4cixnhx3hy@phoenix> <46B88DAC.70005@freescale.com>
	<op.twqn4vtsnhx3hy@phoenix> <op.twqvg3i0nhx3hy@phoenix> ,
	<op.twqvg3i0nhx3hy@phoenix> <twig.1186602365.9125@inaccessnetworks.com>
	, <twig.1186602365.9125@inaccessnetworks.com>
	<twig.1186611635.44657@inaccessnetworks.com>
	<46BB2CE2.2060207@freescale.com>
	<2b043cf24b0f5ddda06fcf1f01cb62f3@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 11 Aug 2007 18:28:07 -0500
Message-Id: <1186874887.1576.41.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
	Alexandros Kostopoulos <akostop@inaccessnetworks.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-08-09 at 17:56 +0200, Segher Boessenkool wrote:
> > It means the bus on which legacy I/O ports can be found.  It's a fairly
> > broken concept; each host bridge should really be treated as a
> > completely separate entity, and if something like a VGA card has legacy
> > I/O ports that need to be used, they should be looked for on the same
> > PCI bus as the card itself.  Legacy ISA ports should be discovered
> > through the device tree (or platform devices, or whatever) that
> > explicitly state which PCI-to-ISA bridge they're under.
> 
> Currently, Linux does not allow multiple PCI domains to use
> overlapping legacy I/O ranges.  Yeah it's a pain.

I have a plan I exposed a little while ago to handle that. We need that
for VGA cards among others anyway.

The idea is basically a call around the lines of
pci_convert_legacy_resource(struct resource *r);

You fill up the resource with flags = MEM/IO and start/end being your
legacy range, and it returns a "fixed" resource that you can use with
inX/outX, or whatever else.

Haven't had time to code something up, and we need to provide a default
impl. for all archs too ... but feel free to volunteer and beat me to
it :-)

Ben.
