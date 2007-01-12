Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A2E53DDDFE
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 18:25:12 +1100 (EST)
Subject: Re: [PATCH 3/7] Enable MSI on Powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070111213708.GC23237@lst.de>
References: <1168514716.63474.857278133999.qpush@cradle>
	<20070111112503.920E6DDEBE@ozlabs.org> <20070111213708.GC23237@lst.de>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 18:24:59 +1100
Message-Id: <1168586699.5011.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Olof Johannsson <olof@lixom.net>,
	linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-01-11 at 22:37 +0100, Christoph Hellwig wrote:
> > -# Build the PCI MSI interrupt support
> > +# Build the PCI MSI interrupt support, but not for arch/powerpc
> > +ifndef CONFIG_PPC_MERGE
> >  obj-$(CONFIG_PCI_MSI) += msi.o
> > +endif
> 
> This is not very nice.  I'd rather prefer this code beeing funnel in
> through your higher level code.

There are some issues in hooking the existing intel/altix stuff on
Michael's infrastructure that I'd rather not even go near for 2.6.21 so
I'd prefer if we could just build the new stuff or the old stuff based
on config options as a first step...

>From there, we can start working on doing proper new back-ends for the
new stuff for intel and altix.

Among others, there have been some nasty calls to the MSI stuff by the
pci power management code that I'm not sure the new stuff is dealing
with just yet (we don't need them yet for the few powerpc machines for
which we have backends for now, though we'll have to fix it).

I think it's important that we get this code in 2.6.21 and not wait for
having all the old stuff ported to it, as it's really getting fairly
urgent to get MSI support in, and I'm quite confident having both old
and new infrastructures in until intel/altix are ported over shouldn't
be a problem.

Ben.
