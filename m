Return-Path: <bjorn.helgaas@hp.com>
Received: from g1t0028.austin.hp.com (g1t0028.austin.hp.com [15.216.28.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 3EF82DDEB6
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 05:11:30 +1100 (EST)
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: benh@kernel.crashing.org
Subject: Re: [patch 0/4] RFC: PCI: consolidate several
	pcibios_enable_resources() implementations
Date: Tue, 19 Feb 2008 11:02:12 -0700
References: <20080219043952.845136014@ldl.fc.hp.com>
	<20080219080947.GB20893@flint.arm.linux.org.uk>
	<1203415712.6740.102.camel@pasglop>
In-Reply-To: <1203415712.6740.102.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200802191102.13777.bjorn.helgaas@hp.com>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz,
	Russell King <rmk-pci@arm.linux.org.uk>,
	linux-arm-kernel@lists.arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 19 February 2008 03:08:32 am Benjamin Herrenschmidt wrote:
> On Tue, 2008-02-19 at 08:09 +0000, Russell King wrote:
> > On Mon, Feb 18, 2008 at 09:39:52PM -0700, Bjorn Helgaas wrote:
> > > 
> > > ARM and PA-RISC, in particular, have interesting differences:
> > >     - ARM always enables bridge devices, which no other arch does
> > 
> > ARM does this because there is nothing else which would do that - which
> > means devices behind bridges would be completely inaccessible.
> 
> That's normally done by pci_enable_bridges() called by
> pci_assign_unassigned_resources().

alpha, mips, mn10300, powerpc, and x86 use pci_enable_bridges() via
pci_assign_unassigned_resources().  parisc uses pci_enable_bridges()
directly from lba_driver_probe().  I guess the other arches (except
arm) rely on firmware to enable bridge.

I think pci_assign_unassigned_resources() is a bit of an anachronism --
it's a boot-time thing that does it for all root buses at once.  A
more hot-plug oriented scheme would do it like parisc, where every
time we discover a root bridge, we do any necessary resource assignment
and bridge enablement underneath it.

For ARM, maybe that could happen in pcibios_init_hw() or something
similar.

> > >     - PA-RISC always turns on SERR and PARITY, which no other arch does
> > 
> > ARM also does this, unless pdev_bad_for_parity(dev) is true.  See
> > ARMs pcibios_fixup_bus().
> 
> While that sounds like a good idea to generalize, I think it should
> remain arch stuff tho, not move to generic code.
> 
> On some platforms, weirdo firmwares handle error handling and will be
> unhappy if the kernel mucks around (such as pSeries).

I agree the SERR and PARITY stuff probably needs to remain arch code.
But it would be nice to at least have this and the bridge enable done in
similar places across arches.

Bjorn
