Return-Path: <alistair@popple.id.au>
Received: from ipmail02.adl2.internode.on.net (ipmail02.adl2.internode.on.net
 [150.101.137.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 41Qz9X4ptdzF35m
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 11:38:40 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell Currey <ruscur@russell.cc>, Balbir Singh <bsingharora@gmail.com>,
 Stewart Smith <stewart@linux.ibm.com>
Subject: Re: [PATCH kernel] powerpc/ioda/npu2: Call hot reset skiboot hook
 when disabling NPU
Date: Thu, 12 Jul 2018 11:38:34 +1000
Message-ID: <1903233.NnVPaYN7RK@new-mexico>
In-Reply-To: <20180711194510.0bc8dc39@aik.ozlabs.ibm.com>
References: <20180607070607.16037-1-aik@ozlabs.ru>
 <20180711194510.0bc8dc39@aik.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alexey,

On Wednesday, 11 July 2018 7:45:10 PM AEST Alexey Kardashevskiy wrote:
> On Thu,  7 Jun 2018 17:06:07 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
> > This brings NPU2 in a safe mode when it does not throw HMI if GPU
> > coherent memory is gone.

It might be helpful if you you could describe the problem and what you are
trying to solve in a bit more depth. Assuming the memory was online how are you
offlining it? If the memory has been online merely fencing/hot-resetting the
NVLink is likely not sufficient as you also need to flush caches prior to taking
the links down.

- Alistair

> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> 
> Anyone, ping?
> 
> 
> > ---
> > 
> > The main aim for this is nvlink2 pass through, helps a lot.
> > 
> > 
> > ---
> >  arch/powerpc/platforms/powernv/pci-ioda.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> > index 66c2804..29f798c 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -3797,6 +3797,16 @@ static void pnv_pci_release_device(struct pci_dev *pdev)
> >  		pnv_ioda_release_pe(pe);
> >  }
> >  
> > +void pnv_npu_disable_device(struct pci_dev *pdev)
> > +{
> > +	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
> > +	struct eeh_pe *eehpe = edev ? edev->pe : NULL;
> > +
> > +	if (eehpe && eeh_ops && eeh_ops->reset) {
> > +		eeh_ops->reset(eehpe, EEH_RESET_HOT);
> > +	}
> > +}
> > +
> >  static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
> >  {
> >  	struct pnv_phb *phb = hose->private_data;
> > @@ -3841,6 +3851,7 @@ static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
> >  	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
> >  	.dma_set_mask		= pnv_npu_dma_set_mask,
> >  	.shutdown		= pnv_pci_ioda_shutdown,
> > +	.disable_device		= pnv_npu_disable_device,
> >  };
> >  
> >  static const struct pci_controller_ops pnv_npu_ocapi_ioda_controller_ops = {
> 
> 
> 
> --
> Alexey
> 
