Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4671ADDE46
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 01:56:20 +1000 (EST)
In-Reply-To: <46BB2CE2.2060207@freescale.com>
References: <op.twhnwi18nhx3hy@phoenix>
	<20070803201036.GA18229@ld0162-tx32.am.freescale.net>
	<F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
	<op.twol4cixnhx3hy@phoenix> <46B88DAC.70005@freescale.com>
	<op.twqn4vtsnhx3hy@phoenix> <op.twqvg3i0nhx3hy@phoenix>,
	<op.twqvg3i0nhx3hy@phoenix> <twig.1186602365.9125@inaccessnetworks.com>,
	<twig.1186602365.9125@inaccessnetworks.com>
	<twig.1186611635.44657@inaccessnetworks.com>
	<46BB2CE2.2060207@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2b043cf24b0f5ddda06fcf1f01cb62f3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: pci in arch/powerpc vs arch/ppc
Date: Thu, 9 Aug 2007 17:56:05 +0200
To: Scott Wood <scottwood@freescale.com>
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

> It means the bus on which legacy I/O ports can be found.  It's a fairly
> broken concept; each host bridge should really be treated as a
> completely separate entity, and if something like a VGA card has legacy
> I/O ports that need to be used, they should be looked for on the same
> PCI bus as the card itself.  Legacy ISA ports should be discovered
> through the device tree (or platform devices, or whatever) that
> explicitly state which PCI-to-ISA bridge they're under.

Currently, Linux does not allow multiple PCI domains to use
overlapping legacy I/O ranges.  Yeah it's a pain.

> Yes, apparently -- according to a recent thread here, recent versions 
> of
> the PCI spec removed the wording that prohibited a zero BAR (is there
> then no way to disable a BAR?).

I couldn't find that prohibition even in ancient versions of
the PCI specification, for what it's worth.  Maybe I'm just
blind.

> Still, it'd be better to avoid it.

Yeah, many drivers go bonkers otherwise.  Some devices might
misbehave, too.


Segher
