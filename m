Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418JRg5r7XzF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 14:45:03 +1000 (AEST)
Message-ID: <82ebaedf4279dce05a7cd6bdb0d9b84bdf232a02.camel@kernel.crashing.org>
Subject: Re: [PATCH kernel 2/2] powerpc/powernv: Define PHB4 type and enable
 sketchy bypass on POWER9
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Russell Currey <ruscur@russell.cc>
Date: Mon, 18 Jun 2018 14:44:56 +1000
In-Reply-To: <20180618121307.199cd998@aik.ozlabs.ibm.com>
References: <20180601081028.29401-1-aik@ozlabs.ru>
 <20180601081028.29401-3-aik@ozlabs.ru>
 <fa34ce6fa30554e7cede85a5d71fa822dcdfeb01.camel@kernel.crashing.org>
 <20180618121307.199cd998@aik.ozlabs.ibm.com>
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

On Mon, 2018-06-18 at 12:13 +1000, Alexey Kardashevskiy wrote:
> On Sat, 16 Jun 2018 11:05:19 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Fri, 2018-06-01 at 18:10 +1000, Alexey Kardashevskiy wrote:
> > > These are found in POWER9 chips. Right now these PHBs have unknown type
> > > so changing it to PHB4 won't make much of a difference except enabling
> > > sketchy bypass for POWER9 as this does below.  
> > 
> > And that will break on multi-chip systems since P9 doesn't have the
> > memory contiguous (it has the chip ID in the top bits).
> 
> 
> This did not break mine and it is hard to see why it would break at all
> if we use 1G pages and the maximum we need to cover is 48 bits (this
> is what we are trying to support here - all these gpus, right?), or is
> it more now? If so, I have posted v2 of tce multilevel dynamic
> allocation which helps with enormous tce tables.

The whole point of sketchy bypass is to deal with devices with small
amount of DMA bits... most Radeon's have 40 for example. So that won't
work terribly well.

Cheers,
Ben.

> 
> 
> > 
> > Russell is working on a different implementation that should be much
> > more imune to the system physical memory layout.
> > 
> > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > ---
> > >  arch/powerpc/platforms/powernv/pci.h      | 1 +
> > >  arch/powerpc/platforms/powernv/pci-ioda.c | 5 ++++-
> > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> > > index eada4b6..1408247 100644
> > > --- a/arch/powerpc/platforms/powernv/pci.h
> > > +++ b/arch/powerpc/platforms/powernv/pci.h
> > > @@ -23,6 +23,7 @@ enum pnv_phb_model {
> > >  	PNV_PHB_MODEL_UNKNOWN,
> > >  	PNV_PHB_MODEL_P7IOC,
> > >  	PNV_PHB_MODEL_PHB3,
> > > +	PNV_PHB_MODEL_PHB4,
> > >  	PNV_PHB_MODEL_NPU,
> > >  	PNV_PHB_MODEL_NPU2,
> > >  };
> > > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> > > index 9239142..66c2804 100644
> > > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > > @@ -1882,7 +1882,8 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
> > >  		if (dma_mask >> 32 &&
> > >  		    dma_mask > (memory_hotplug_max() + (1ULL << 32)) &&
> > >  		    pnv_pci_ioda_pe_single_vendor(pe) &&
> > > -		    phb->model == PNV_PHB_MODEL_PHB3) {
> > > +		    (phb->model == PNV_PHB_MODEL_PHB3 ||
> > > +		     phb->model == PNV_PHB_MODEL_PHB4)) {
> > >  			/* Configure the bypass mode */
> > >  			rc = pnv_pci_ioda_dma_64bit_bypass(pe);
> > >  			if (rc)
> > > @@ -3930,6 +3931,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
> > >  		phb->model = PNV_PHB_MODEL_P7IOC;
> > >  	else if (of_device_is_compatible(np, "ibm,power8-pciex"))
> > >  		phb->model = PNV_PHB_MODEL_PHB3;
> > > +	else if (of_device_is_compatible(np, "ibm,power9-pciex"))
> > > +		phb->model = PNV_PHB_MODEL_PHB4;
> > >  	else if (of_device_is_compatible(np, "ibm,power8-npu-pciex"))
> > >  		phb->model = PNV_PHB_MODEL_NPU;
> > >  	else if (of_device_is_compatible(np, "ibm,power9-npu-pciex"))  
> 
> 
> 
> --
> Alexey
