Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYvtH2Dv3zDsW6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 18:32:23 +1000 (AEST)
Message-ID: <1473839468.8689.342.camel@kernel.crashing.org>
Subject: Re: [PATCH] powernv/pci: Fix m64 checks for SR-IOV and window
 alignment
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Wed, 14 Sep 2016 17:51:08 +1000
In-Reply-To: <20160914063717.2673-1-ruscur@russell.cc>
References: <20160914063717.2673-1-ruscur@russell.cc>
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

On Wed, 2016-09-14 at 16:37 +1000, Russell Currey wrote:
> Commit 5958d19a143e checks for prefetchable m64 BARs by comparing the
> addresses instead of using resource flags.  This broke SR-IOV as the
> m64
> check in pnv_pci_ioda_fixup_iov_resources() fails.
> 
> The condition in pnv_pci_window_alignment() also changed to checking
> only IORESOURCE_MEM_64 instead of both IORESOURCE_MEM_64 and
> IORESOURCE_PREFETCH.

CC'ing Gavin who might have some insight in the matter.

Why do we check for prefetch ? On PCIe, any 64-bit BAR can live under a
prefetchable region afaik... Gavin, any idea ?

Also:

> Revert these cases to the previous behaviour, adding a new helper
> function
> to do so.  This is named pnv_pci_is_m64_flags() to make it clear this
> function is only looking at resource flags and should not be relied
> on for
> non-SRIOV resources.
> 
> Fixes: 5958d19a143e ("Fix incorrect PE reservation attempt on some
> 64-bit BARs")
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
> b/arch/powerpc/platforms/powernv/pci-ioda.c
> index c16d790..2f25622 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -124,6 +124,13 @@ static inline bool pnv_pci_is_m64(struct pnv_phb
> *phb, struct resource *r)
>  		r->start < (phb->ioda.m64_base + phb-
> >ioda.m64_size));
>  }
>  
> +static inline bool pnv_pci_is_m64_flags(unsigned long
> resource_flags)
> +{
> +	unsigned long flags = (IORESOURCE_MEM_64 |
> IORESOURCE_PREFETCH);
> +
> +	return (resource_flags & flags) == flags;
> +}
> 
I don't agree. See below.

>  static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int
> pe_no)
>  {
>  	phb->ioda.pe_array[pe_no].phb = phb;
> @@ -2871,7 +2878,7 @@ static void
> pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>  		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>  		if (!res->flags || res->parent)
>  			continue;
> -		if (!pnv_pci_is_m64(phb, res)) {
> +		if (!pnv_pci_is_m64_flags(res->flags)) {
>  			dev_warn(&pdev->dev, "Don't support SR-IOV
> with"
>  					" non M64 VF BAR%d: %pR.
> \n",
>  				 i, res);

What is that function actually doing ? Having IORESOURCE_64 and
PREFETCHABLE is completely orthogonal to being in the M64 region. This
is the bug my original patch was fixing in fact as it's possible for
the allocator to put a 64-bit resource in the M32 region.

> @@ -3096,7 +3103,7 @@ static resource_size_t
> pnv_pci_window_alignment(struct pci_bus *bus,
>  	 * alignment for any 64-bit resource, PCIe doesn't care and
>  	 * bridges only do 64-bit prefetchable anyway.
>  	 */
> -	if (phb->ioda.m64_segsize && (type & IORESOURCE_MEM_64))
> +	if (phb->ioda.m64_segsize && pnv_pci_is_m64_flags(type))
>  		return phb->ioda.m64_segsize;

I disagree similarly. 64-bit non-prefetchable resources should live in
the M64 space as well.

>  	if (type & IORESOURCE_MEM)
>  		return phb->ioda.m32_segsize;

Something seems to be deeply wrong here and this patch looks to me that
it's just papering over the problem in way that could bring back the
bugs I've seen if the generic allocator decides to put things in the
M32 window.

We need to look at this more closely and understand WTF that code
intends means to do.

Cheers,
Ben.
