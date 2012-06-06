Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7DEEAB6FAB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 08:22:06 +1000 (EST)
Message-ID: <1339021310.7150.181.camel@pasglop>
Subject: Re: [PATCH] PPC: PCI: Fix pcibios_io_space_offset() so it works for
 32-bit ptr/64-bit rsrcs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Thu, 07 Jun 2012 08:21:50 +1000
In-Reply-To: <4FCFC870.40004@freescale.com>
References: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
 <4FCFC870.40004@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Ben Collins <ben.c@servergy.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-06-06 at 16:15 -0500, Scott Wood wrote:
> On 06/05/2012 10:50 PM, Ben Collins wrote:
> > The commit introducing pcibios_io_space_offset() was ignoring 32-bit to
> > 64-bit sign extention, which is the case on ppc32 with 64-bit resource
> > addresses. This only seems to have shown up while running under QEMU for
> > e500mc target. It may or may be suboptimal that QEMU has an IO base
> > address > 32-bits for the e500-pci implementation, but 1) it's still a
> > regression and 2) it's more correct to handle things this way.
> 
> Where do you see addresses over 32 bits in QEMU's e500-pci, at least
> with current mainline QEMU and the mpc8544ds model?
> 
> I/O space should be at 0xe1000000.
> 
> I'm also not sure what this has to do with the virtual address returned
> by ioremap().

This is due to how we calculate IO offsets on ppc32, see below

> > Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> >  arch/powerpc/kernel/pci-common.c |    8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> > index 8e78e93..be9ced7 100644
> > --- a/arch/powerpc/kernel/pci-common.c
> > +++ b/arch/powerpc/kernel/pci-common.c
> > @@ -1477,9 +1477,15 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
> >  	return pci_enable_resources(dev, mask);
> >  }
> >  
> > +/* Before assuming too much here, take care to realize that we need sign
> > + * extension from 32-bit pointers to 64-bit resource addresses to work.
> > + */
> >  resource_size_t pcibios_io_space_offset(struct pci_controller *hose)
> >  {
> > -	return (unsigned long) hose->io_base_virt - _IO_BASE;
> > +	long vbase = (long)hose->io_base_virt;
> > +	long io_base = _IO_BASE;
> > +
> > +	return (resource_size_t)(vbase - io_base);
> 
> Why do we want sign extension here?
> 
> If we do want it, there are a lot of other places in this file where the
> same calculation is done.

We should probably as much as possible factor it, but basically what
happens is that to access IO space, we turn:

	 oub(port)

into
	 out_8(_IO_BASE + port)

With _IO_BASE being a global.

Now what happens when you have several PHBs ? Well, we make _IO_BASE be
the result of ioremap'ing the IO space window of the first one, minus
the bus address corresponding to the beginning of that window. Then for
each device, we offset devices with the offset calculated above.

Now that means that we can end up with funky arithmetic in a couple of
cases:

 - If the bus address of the IO space is larger than the virtual address
returned by ioremap (it's a bit silly to use large IO addresses but it's
technically possible, normally IO windows start at 0 bus-side though).
In fact I wouldn't be surprised if we have various other bugs if IO
windows don't start at 0 (you may want to double check your dts setup
here).

 - If the ioremap'ed address of the IO space of another domain is lower
than the ioremap'ed address of the first domain, in which case the
calculation:

	host->io_base_virt - _IO_BASE

results in a negative offset.

Thus we need to make sure that this offset is fully sign extended so
that things work properly when applied to a resource_size_t which can be
64-bit.

On ppc64 we do things differently, we have a single linear region that
has all IO spaces and _IO_BASE is the beginning of it so offsets are
never negative, we can do that because we don't care wasting address
space there.

Cheers,
Ben.
