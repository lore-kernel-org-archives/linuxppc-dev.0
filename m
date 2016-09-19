Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scx5r07Q3zDsd8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 16:37:51 +1000 (AEST)
Message-ID: <1474267066.8411.6.camel@russell.cc>
Subject: Re: [PATCH] powernv/pci: Fix m64 checks for SR-IOV and window
 alignment
From: Russell Currey <ruscur@russell.cc>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru
Date: Mon, 19 Sep 2016 16:37:46 +1000
In-Reply-To: <20160914113013.GA11215@gwshan>
References: <20160914063717.2673-1-ruscur@russell.cc>
 <1473839468.8689.342.camel@kernel.crashing.org>
 <20160914113013.GA11215@gwshan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-09-14 at 21:30 +1000, Gavin Shan wrote:
> On Wed, Sep 14, 2016 at 05:51:08PM +1000, Benjamin Herrenschmidt wrote:
> > 
> > On Wed, 2016-09-14 at 16:37 +1000, Russell Currey wrote:
> > > 
> > > Commit 5958d19a143e checks for prefetchable m64 BARs by comparing the
> > > addresses instead of using resource flags.  This broke SR-IOV as the
> > > m64
> > > check in pnv_pci_ioda_fixup_iov_resources() fails.
> > > 
> > > The condition in pnv_pci_window_alignment() also changed to checking
> > > only IORESOURCE_MEM_64 instead of both IORESOURCE_MEM_64 and
> > > IORESOURCE_PREFETCH.
> > 
> > CC'ing Gavin who might have some insight in the matter.
> > 
> > Why do we check for prefetch ? On PCIe, any 64-bit BAR can live under a
> > prefetchable region afaik... Gavin, any idea ?
> > 
> 
> Ben, what I understood for long time: non-prefetchable BAR cannot live under
> a prefetchable region (window), but any BAR can live under non-prefetchable
> region (window).
> 
> > 
> > 
> > > 
> > > Revert these cases to the previous behaviour, adding a new helper
> > > function
> > > to do so.  This is named pnv_pci_is_m64_flags() to make it clear this
> > > function is only looking at resource flags and should not be relied
> > > on for
> > > non-SRIOV resources.
> > > 
> > > Fixes: 5958d19a143e ("Fix incorrect PE reservation attempt on some
> > > 64-bit BARs")
> > > Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > > ---
> > >  arch/powerpc/platforms/powernv/pci-ioda.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
> > > b/arch/powerpc/platforms/powernv/pci-ioda.c
> > > index c16d790..2f25622 100644
> > > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > > @@ -124,6 +124,13 @@ static inline bool pnv_pci_is_m64(struct pnv_phb
> > > *phb, struct resource *r)
> > >  		r->start < (phb->ioda.m64_base + phb-
> > > > 
> > > > ioda.m64_size));
> > >  }
> > >  
> > > +static inline bool pnv_pci_is_m64_flags(unsigned long
> > > resource_flags)
> > > +{
> > > +	unsigned long flags = (IORESOURCE_MEM_64 |
> > > IORESOURCE_PREFETCH);
> > > +
> > > +	return (resource_flags & flags) == flags;
> > > +}
> > > 
> > I don't agree. See below.
> > 
> > > 
> > >  static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int
> > > pe_no)
> > >  {
> > >  	phb->ioda.pe_array[pe_no].phb = phb;
> > > @@ -2871,7 +2878,7 @@ static void
> > > pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
> > >  		res = &pdev->resource[i + PCI_IOV_RESOURCES];
> > >  		if (!res->flags || res->parent)
> > >  			continue;
> > > -		if (!pnv_pci_is_m64(phb, res)) {
> > > +		if (!pnv_pci_is_m64_flags(res->flags)) {
> > >  			dev_warn(&pdev->dev, "Don't support SR-IOV
> > > with"
> > >  					" non M64 VF BAR%d: %pR.
> > > \n",
> > >  				 i, res);
> > 
> > What is that function actually doing ? Having IORESOURCE_64 and
> > PREFETCHABLE is completely orthogonal to being in the M64 region. This
> > is the bug my original patch was fixing in fact as it's possible for
> > the allocator to put a 64-bit resource in the M32 region.
> > 
> 
> This function is called before the resoureces are resized and assigned.
> So using the resource's start/end addresses to judge it's in M64 or M32
> windows are not reliable. Currently, all IOV BARs is required to have
> (IORESOURCE_64 | PREFETCHABLE) which is covered by bridge's M64 window
> and PHB's M64 windows (BARs).
> 
> > 
> > > 
> > > @@ -3096,7 +3103,7 @@ static resource_size_t
> > > pnv_pci_window_alignment(struct pci_bus *bus,
> > >  	 * alignment for any 64-bit resource, PCIe doesn't care and
> > >  	 * bridges only do 64-bit prefetchable anyway.
> > >  	 */
> > > -	if (phb->ioda.m64_segsize && (type & IORESOURCE_MEM_64))
> > > +	if (phb->ioda.m64_segsize && pnv_pci_is_m64_flags(type))
> > >  		return phb->ioda.m64_segsize;
> > 
> > I disagree similarly. 64-bit non-prefetchable resources should live in
> > the M64 space as well.
> > 
> 
> As I understood, 64-bits non-prefetchable BARs cannot live behind
> M64 (64-bits prefetchable) windows.
> 
> > 
> > > 
> > >  	if (type & IORESOURCE_MEM)
> > >  		return phb->ioda.m32_segsize;
> > 
> > Something seems to be deeply wrong here and this patch looks to me that
> > it's just papering over the problem in way that could bring back the
> > bugs I've seen if the generic allocator decides to put things in the
> > M32 window.
> > 
> > We need to look at this more closely and understand WTF that code
> > intends means to do.
> > 
> 
> Yeah, it seems it partially reverts your changes. The start/end addresses
> are usable after resource resizing/assignment is finished. Before that,
> we still need to use the flags.

I agree with Ben that we need to look at this more closely to find a proper fix
rather than this hacky partial revert, but for now it's important that we fix
SR-IOV and thus I think this patch should be carried forward.

This patch is a bandaid, but I believe completely fixing the underlying problem
is not achievable given we're at rc7. 

As a side note, I am going to prototype a heavy refactor of the allocation code
that simplifies things from an EEH perspective and allows us to use more generic
PCI code.

> 
> Thanks,
> Gavin
> 
> 
> > 
> > Cheers,
> > Ben.
> > 
