Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6CFD01A0245
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 11:13:37 +1000 (AEST)
Message-ID: <1440638016.23182.7.camel@ellerman.id.au>
Subject: Re: [PATCH 2/3] powerpc/iommu: Cleanup setting of DMA base/offset
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Thu, 27 Aug 2015 11:13:36 +1000
In-Reply-To: <55DD7E49.6010709@ozlabs.ru>
References: <1435123527.3996.30.camel@kernel.crashing.org>
 <55DD7E49.6010709@ozlabs.ru>
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

On Wed, 2015-08-26 at 18:52 +1000, Alexey Kardashevskiy wrote:
> On 06/24/2015 03:25 PM, Benjamin Herrenschmidt wrote:
> > Now that the table and the offset can co-exist, we no longer need
> > to flip/flop, we can just establish both once at boot time.
> >
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> >   arch/powerpc/platforms/powernv/pci-ioda.c |  3 +--
> >   arch/powerpc/platforms/pseries/iommu.c    |  3 +--
> >   arch/powerpc/sysdev/dart_iommu.c          | 16 +++-------------
> >   3 files changed, 5 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> > index 5738d31..2c286b57 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -1620,11 +1620,9 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
> >   	if (bypass) {
> >   		dev_info(&pdev->dev, "Using 64-bit DMA iommu bypass\n");
> >   		set_dma_ops(&pdev->dev, &dma_direct_ops);
> > -		set_dma_offset(&pdev->dev, pe->tce_bypass_base);
> 
> 
> This particular change breaks SRIOV. So some SRIOV code relies on that but 
> I could not spot this place quickly.

Thanks for finding it.

> Also, this specific patch in powerpc/next tree just does not compile 
> because of "powerpc/iommu: Remove dma_data union" but this is another story :)

<redacted>

cheers
