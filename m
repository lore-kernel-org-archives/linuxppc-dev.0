Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F726DDE9D
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 21:09:36 +1100 (EST)
Subject: Re: [patch 0/4] RFC: PCI: consolidate several
	pcibios_enable_resources() implementations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk-pci@arm.linux.org.uk>
In-Reply-To: <20080219080947.GB20893@flint.arm.linux.org.uk>
References: <20080219043952.845136014@ldl.fc.hp.com>
	<20080219080947.GB20893@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 19 Feb 2008 21:08:32 +1100
Message-Id: <1203415712.6740.102.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Bjorn Helgaas <bjorn.helgaas@hp.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-02-19 at 08:09 +0000, Russell King wrote:
> On Mon, Feb 18, 2008 at 09:39:52PM -0700, Bjorn Helgaas wrote:
> > There are many implementations of pcibios_enable_resources() that differ
> > in minor ways that look more like bugs than architectural differences.
> > This patch series consolidates most of them to use the x86 version.
> > 
> > This series is for discussion only at this point.  I'm interested in
> > feedback about whether any of the differences are "real" and need to
> > be preserved.
> > 
> > ARM and PA-RISC, in particular, have interesting differences:
> >     - ARM always enables bridge devices, which no other arch does
> 
> ARM does this because there is nothing else which would do that - which
> means devices behind bridges would be completely inaccessible.

That's normally done by pci_enable_bridges() called by
pci_assign_unassigned_resources(). (The later has a weird naming, it
does more than just assign unassigned resources in fact).

> >     - PA-RISC always turns on SERR and PARITY, which no other arch does
> 
> ARM also does this, unless pdev_bad_for_parity(dev) is true.  See
> ARMs pcibios_fixup_bus().

While that sounds like a good idea to generalize, I think it should
remain arch stuff tho, not move to generic code.

On some platforms, weirdo firmwares handle error handling and will be
unhappy if the kernel mucks around (such as pSeries).

> > Should other arches do the same thing, or are these somehow related to
> > ARM and PA-RISC architecture?
> 
> I suspect they're architecture specific; I wouldn't like to do either
> on x86, but they're either required or preferred on ARM.

Ben.
