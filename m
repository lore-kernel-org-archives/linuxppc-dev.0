Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B99C4DE049
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 09:08:35 +1100 (EST)
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1r6thvjdq.fsf@ebiederm.dsl.xmission.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
	<20070126064352.GA328@colo.lackof.org>
	<m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
	<5A6F70E0-A8AB-4636-8F41-2EC82A3B13B7@kernel.crashing.org>
	<m1r6thvjdq.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Sat, 27 Jan 2007 09:08:14 +1100
Message-Id: <1169849295.24996.172.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Grant Grundler <grundler@parisc-linux.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The big difference here between what you have and what x86 has
> is that on x86 I can easily setup a pool of locations usable
> by MSI allocate a location, and then independently associate
> that with an MSI irq.  Apparently PPC cannot do that, although
> from what little I have heard about the MPIC just now I don't 
> understand why not.  Any clue where I can find a MPIC datasheet?

The MPIC MSI backend is specific to a given MPIC implementation (the
Apple one in U4 which IBM also uses for some machines). It's not a
generic OpenPIC/MPIC feature.

The MPIC has a certain amount of sources (the Apple one typically about
124). That's the MPIC cell in the chip. Now, those sources (wires) can
be connected internally to either physical lines or other internal
devies inside that chip, that is about 7 of them. The rest is hooked
(well, I don't know the HW details, but from a software perspective,
that's how it looks) to a pair of decoders that decode HT irq messages
and MSIs, and use the number in the message to toggle that source on the
MPIC. 

Thus we basically can allocate for an MSI any vector that isn't already
used by somebody else (an HT interrupt or an internal physical line).

> I care about more than x86 but x86 and derivatives is the platform
> I primarily work with, have test hardware for, and understand all
> of the details of.  To make an abstraction that works across all
> platforms and to help maintain that I need to understand all of the
> relevant details so I do care about ppc.  Especially when I have ppc
> people I can work with.

Well, MSI is only -one- of the possible backends on powerpc. RTAS is
another. I briefly described the one we have in the Axon bridge for cell
which DMAs messages to memory and toggle an IRQ when a new message
arrives (funnily enough, that IRQ itself is routed through an MPIC :-)
But in this case, we implement it as a cascaded controller).

Other examples are Toshiba Spider MSIs which I'm not too sure how they
work off the top of my mind (we might implement them, or not ...
depends) but I think they boil down to 16 lines into the Spider PIC
interrupt controller (thus similar to MPIC). Then, various embedded
processors are now showing up with PCIe support, and thus I expect MSIs,
and while we don't support MSIs on them just yet, I can already tell you
that every single of them will do things differently :-)

Due to the fact that the PowerPC however has 1 interrupt exception in
the programming model, there is always a toplevel IRQ controller, and
thus MSIs will always be routed to that in a way or another.

> Likewise what is different about x86 needs some explaining so it becomes
> clear why msi_ops do not handle what x86 is doing today.  The big
> difference there comes with irq migration because when we migrate an
> irq we must reprogram the msi registers on the cards themselves,
> likewise when we mask an irq we must mask it using the msi registers.

For these, I think the best is to have the backend use the raw_*
functions directly, we just need to add the missing ones (raw_msi_mask,
raw_msix_mask, raw_msi_update, etc...)

> >From that comes our need for a data structure to map from an irq to a
> msi data structure in a generic fashion, because we don't just program
> the pci card and forget about it.  From those requirements comes our
> need for a little bit more complete support of the features of the
> hardware that Michaels implementation.

Well, we need to go from pci_dev -> MSI and from linux irq_desc ->
MSI... for now, we can get away without the later on powerpc, but I
understand that intel needs that. The initial intel code used an array
of NR_IRQs, but that sucks. What I remember of your patch is that they
were using chip_data in irq_desc.

The problem with using chip_data is that it will conflict with our case
where MSIs are hooked to an existing irq controller that already uses
chip_data.

Note that this is a non-issue if the usage of chip_data is kept local to
the backend. However, if we want to push that irq_desc -> msi info to
the generic code, them we'll need to find a different way, possibly
adding a pointer to irq_desc..

Ben.
