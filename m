Return-Path: <aik@ozlabs.ru>
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41SSJq3HdvzDqvV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2018 21:35:04 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id r5-v6so5790617pgv.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2018 04:35:04 -0700 (PDT)
Date: Sat, 14 Jul 2018 21:34:50 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Alistair Popple <alistair@popple.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Russell Currey <ruscur@russell.cc>, Balbir
 Singh <bsingharora@gmail.com>, Stewart Smith <stewart@linux.ibm.com>
Subject: Re: [PATCH kernel] powerpc/ioda/npu2: Call hot reset skiboot hook
 when disabling NPU
Message-ID: <20180714213450.0803b435@aikyoga2>
In-Reply-To: <1903233.NnVPaYN7RK@new-mexico>
References: <20180607070607.16037-1-aik@ozlabs.ru>
 <20180711194510.0bc8dc39@aik.ozlabs.ibm.com>
 <1903233.NnVPaYN7RK@new-mexico>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 12 Jul 2018 11:38:34 +1000
Alistair Popple <alistair@popple.id.au> wrote:

> Hi Alexey,
> 
> On Wednesday, 11 July 2018 7:45:10 PM AEST Alexey Kardashevskiy wrote:
> > On Thu,  7 Jun 2018 17:06:07 +1000
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >   
> > > This brings NPU2 in a safe mode when it does not throw HMI if GPU
> > > coherent memory is gone.  
> 
> It might be helpful if you you could describe the problem and what you are
> trying to solve in a bit more depth. Assuming the memory was online how are you
> offlining it?

Fair enough. I am offlining it by simply killing a guest which triggers
GPU PCI reset. Before this, PCI reset would trigger HMI as PTEs were
still in both QEMU and guest pagetables and that would cause
prefetching and thus killing the host.


> If the memory has been online merely fencing/hot-resetting the
> NVLink is likely not sufficient as you also need to flush caches prior to taking
> the links down.

I'd expect the guest driver to take care of this. If this is not enough
and I need to pass some other MMIO (in addition to the ATS/tlb
invalidation thingy which I'll add anyway), then what is it?


> 
> - Alistair
> 
> > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>  
> > 
> > 
> > Anyone, ping?
> > 
> >   
> > > ---
> > > 
> > > The main aim for this is nvlink2 pass through, helps a lot.
> > > 
> > > 
> > > ---
> > >  arch/powerpc/platforms/powernv/pci-ioda.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> > > index 66c2804..29f798c 100644
> > > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > > @@ -3797,6 +3797,16 @@ static void pnv_pci_release_device(struct pci_dev *pdev)
> > >  		pnv_ioda_release_pe(pe);
> > >  }
> > >  
> > > +void pnv_npu_disable_device(struct pci_dev *pdev)
> > > +{
> > > +	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
> > > +	struct eeh_pe *eehpe = edev ? edev->pe : NULL;
> > > +
> > > +	if (eehpe && eeh_ops && eeh_ops->reset) {
> > > +		eeh_ops->reset(eehpe, EEH_RESET_HOT);
> > > +	}
> > > +}
> > > +
> > >  static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
> > >  {
> > >  	struct pnv_phb *phb = hose->private_data;
> > > @@ -3841,6 +3851,7 @@ static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
> > >  	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
> > >  	.dma_set_mask		= pnv_npu_dma_set_mask,
> > >  	.shutdown		= pnv_pci_ioda_shutdown,
> > > +	.disable_device		= pnv_npu_disable_device,
> > >  };
> > >  
> > >  static const struct pci_controller_ops pnv_npu_ocapi_ioda_controller_ops = {  
> > 
> > 
> > 
> > --
> > Alexey
> >   
> 
> 



--
Alexey
