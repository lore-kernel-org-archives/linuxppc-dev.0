Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CB9B467CCF
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 07:39:40 +1100 (EST)
Subject: Re: [RFC/PATCH 4/7] Powerpc MSI implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <20061107200730.GY27140@parisc-linux.org>
References: <1162884080.585336.70559261997.qpush@cradle>
	<20061107072125.68E9F67CA7@ozlabs.org>
	<20061107200730.GY27140@parisc-linux.org>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 07:39:18 +1100
Message-Id: <1162931959.28571.499.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, linuxppc-dev@ozlabs.org,
	"Eric W.Biederman" <ebiederm@xmission.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-11-07 at 13:07 -0700, Matthew Wilcox wrote:
> On Tue, Nov 07, 2006 at 06:21:23PM +1100, Michael Ellerman wrote:
> > We currently (ab)use the pci_dev to store our msi_info structure. We
> > were hoping to stash it in the pci_dn, but that's not a goer, so the
> > pci_dev seems like the right place, even though it seems naughty to
> > bloat generic structs.
> 
> We have the per-irq void *chip_data; could this be the right place to
> keep it instead?  That way, it won't take up space in the pci_dev for
> devices which don't use MSI.
> 
> Or do you rely on mpic_from_irq() working for MSI interrupts too?

Yes, we rely on that.

The chip_data is for use by the IRQ controller. In our cases, for some
controllers at least, MSIs are just an add-on to an existing controller
(they toggle existing inputs).

In general, I think it just make sense to have pci_dev contain MSI
tracking data for the device though.

Cheers,
Ben.
