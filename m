Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zh5XS3WpYzF1DS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 15:10:00 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 Mark Hairgrove <mhairgrove@nvidia.com>, Javier Cabezas <jcabezas@nvidia.com>
Subject: Re: [PATCH] powerpc/npu-dma.c: Fix deadlock in mmio_invalidate
Date: Wed, 14 Feb 2018 14:23:56 +1100
Message-ID: <3544963.SI8Y64vzmd@new-mexico>
In-Reply-To: <20180213170620.409daf29@balbir.ozlabs.ibm.com>
References: <20180213031734.19831-1-alistair@popple.id.au>
 <20180213170620.409daf29@balbir.ozlabs.ibm.com>
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

> > +struct mmio_atsd_reg {
> > +	struct npu *npu;
> > +	int reg;
> > +};
> > +
> 
> Is it just easier to move reg to inside of struct npu?

I don't think so, struct npu is global to all npu contexts where as this is
specific to the given invalidation. We don't have enough registers to assign
each NPU context it's own dedicated register so I'm not sure it makes sense to
put it there either.

> > +static void acquire_atsd_reg(struct npu_context *npu_context,
> > +			struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS])
> > +{
> > +	int i, j;
> > +	struct npu *npu;
> > +	struct pci_dev *npdev;
> > +	struct pnv_phb *nphb;
> >  
> > -		/*
> > -		 * The GPU requires two flush ATSDs to ensure all entries have
> > -		 * been flushed. We use PID 0 as it will never be used for a
> > -		 * process on the GPU.
> > -		 */
> > -		if (flush)
> > -			mmio_invalidate_pid(npu, 0, true);
> > +	for (i = 0; i <= max_npu2_index; i++) {
> > +		mmio_atsd_reg[i].reg = -1;
> > +		for (j = 0; j < NV_MAX_LINKS; j++) {
> 
> Is it safe to assume that npu_context->npdev will not change in this
> loop? I guess it would need to be stronger than just this loop.

It is not safe to assume that npu_context->npdev won't change during this loop,
however I don't think it is a problem if it does as we only read each element
once during the invalidation.

There are two possibilities for how this could change. pnv_npu2_init_context()
will add a nvlink to the npdev which will result in the TLB invalidation being
sent to that GPU as well which should not be a problem.

pnv_npu2_destroy_context() will remove the the nvlink from npdev. If it happens
prior to this loop it should not be a problem (as the destruction will have
already invalidated the GPU TLB). If it happens after this loop it shouldn't be
a problem either (it will just result in an extra TLB invalidate being sent to
this GPU).

> > +			npdev = npu_context->npdev[i][j];
> > +			if (!npdev)
> > +				continue;
> > +
> > +			nphb = pci_bus_to_host(npdev->bus)->private_data;
> > +			npu = &nphb->npu;
> > +			mmio_atsd_reg[i].npu = npu;
> > +			mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
> > +			while (mmio_atsd_reg[i].reg < 0) {
> > +				mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
> > +				cpu_relax();
> 
> A cond_resched() as well if we have too many tries?

I don't think we can as the invalidate_range() function is called under the ptl
spin-lock and is not allowed to sleep (at least according to
include/linux/mmu_notifier.h).

- Alistair

> Balbir
> 
