Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 125A567CDC
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 07:41:29 +1100 (EST)
Subject: Re: [RFC/PATCH 4/7] Powerpc MSI implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk-pci@arm.linux.org.uk>
In-Reply-To: <20061107201436.GE9533@flint.arm.linux.org.uk>
References: <1162884080.585336.70559261997.qpush@cradle>
	<20061107072125.68E9F67CA7@ozlabs.org>
	<20061107200730.GY27140@parisc-linux.org>
	<20061107201436.GE9533@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 07:40:57 +1100
Message-Id: <1162932057.28571.501.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Matthew Wilcox <matthew@wil.cx>, Greg Kroah-Hartman <greg@kroah.com>,
	linuxppc-dev@ozlabs.org, "Eric W.Biederman" <ebiederm@xmission.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-11-07 at 20:14 +0000, Russell King wrote:
> On Tue, Nov 07, 2006 at 01:07:30PM -0700, Matthew Wilcox wrote:
> > On Tue, Nov 07, 2006 at 06:21:23PM +1100, Michael Ellerman wrote:
> > > We currently (ab)use the pci_dev to store our msi_info structure. We
> > > were hoping to stash it in the pci_dn, but that's not a goer, so the
> > > pci_dev seems like the right place, even though it seems naughty to
> > > bloat generic structs.
> > 
> > We have the per-irq void *chip_data; could this be the right place to
> > keep it instead?  That way, it won't take up space in the pci_dev for
> > devices which don't use MSI.
> 
> Bah.  chip_data is supposed to be __iomem.  I bet if you build ARM
> with sparse it'll kick out lots of warnings as a result of that loss.
> 
> Grumble, generic irq, pah.  Grumble.

Oh well... on various cases, on ppc, I use it not as __iomem but as a
pointer to a irq controller "instance" (which itself contains the
__iomem pointer, along with a bunch of other things).

But yeah, you were there first ;)

Ben.
