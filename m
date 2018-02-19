Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22e.google.com (mail-pf0-x22e.google.com
 [IPv6:2607:f8b0:400e:c00::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zl7hG3FpHzDrVm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 13:57:17 +1100 (AEDT)
Received: by mail-pf0-x22e.google.com with SMTP id z14so705443pfe.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Feb 2018 18:57:17 -0800 (PST)
Date: Mon, 19 Feb 2018 13:57:04 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Mark Hairgrove <mhairgrove@nvidia.com>
Cc: Alistair Popple <alistair@popple.id.au>, <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>, Javier Cabezas <jcabezas@nvidia.com>
Subject: Re: [PATCH] powerpc/npu-dma.c: Fix deadlock in mmio_invalidate
Message-ID: <20180219135704.3bd0cfb9@balbir.ozlabs.ibm.com>
In-Reply-To: <alpine.DEB.2.00.1802151910400.10245@mdh-linux64-2.nvidia.com>
References: <20180213031734.19831-1-alistair@popple.id.au>
 <20180213170620.409daf29@balbir.ozlabs.ibm.com>
 <3544963.SI8Y64vzmd@new-mexico>
 <alpine.DEB.2.00.1802151910400.10245@mdh-linux64-2.nvidia.com>
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

On Thu, 15 Feb 2018 19:11:19 -0800
Mark Hairgrove <mhairgrove@nvidia.com> wrote:

> On Wed, 14 Feb 2018, Alistair Popple wrote:
> 
> > > > +struct mmio_atsd_reg {
> > > > +	struct npu *npu;
> > > > +	int reg;
> > > > +};
> > > > +  
> > > 
> > > Is it just easier to move reg to inside of struct npu?  
> > 
> > I don't think so, struct npu is global to all npu contexts where as this is
> > specific to the given invalidation. We don't have enough registers to assign
> > each NPU context it's own dedicated register so I'm not sure it makes sense to
> > put it there either.

Fair enough, also discussed this offline with you.

> >   
> > > > +static void acquire_atsd_reg(struct npu_context *npu_context,
> > > > +			struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS])
> > > > +{
> > > > +	int i, j;
> > > > +	struct npu *npu;
> > > > +	struct pci_dev *npdev;
> > > > +	struct pnv_phb *nphb;
> > > >  
> > > > -		/*
> > > > -		 * The GPU requires two flush ATSDs to ensure all entries have
> > > > -		 * been flushed. We use PID 0 as it will never be used for a
> > > > -		 * process on the GPU.
> > > > -		 */
> > > > -		if (flush)
> > > > -			mmio_invalidate_pid(npu, 0, true);
> > > > +	for (i = 0; i <= max_npu2_index; i++) {
> > > > +		mmio_atsd_reg[i].reg = -1;
> > > > +		for (j = 0; j < NV_MAX_LINKS; j++) {  
> > > 
> > > Is it safe to assume that npu_context->npdev will not change in this
> > > loop? I guess it would need to be stronger than just this loop.  
> > 
> > It is not safe to assume that npu_context->npdev won't change during this loop,
> > however I don't think it is a problem if it does as we only read each element
> > once during the invalidation.  
> 
> Shouldn't that be enforced with READ_ONCE() then?

Good point, although I think the acquire_* function itself may be called
from a higher layer with the mmap_sem always held. I wonder if we need
barriers around get and put mmio_atsd_reg.


> 
> I assume that npdev->bus can't change until after the last
> pnv_npu2_destroy_context() is called for an npu. In that case, the
> mmu_notifier_unregister() in pnv_npu2_release_context() will block until
> mmio_invalidate() is done using npdev. That seems safe enough, but a
> comment somewhere about that would be useful.
> 
> > 
> > There are two possibilities for how this could change. pnv_npu2_init_context()
> > will add a nvlink to the npdev which will result in the TLB invalidation being
> > sent to that GPU as well which should not be a problem.
> > 
> > pnv_npu2_destroy_context() will remove the the nvlink from npdev. If it happens
> > prior to this loop it should not be a problem (as the destruction will have
> > already invalidated the GPU TLB). If it happens after this loop it shouldn't be
> > a problem either (it will just result in an extra TLB invalidate being sent to
> > this GPU).
> >   
> > > > +			npdev = npu_context->npdev[i][j];
> > > > +			if (!npdev)
> > > > +				continue;
> > > > +
> > > > +			nphb = pci_bus_to_host(npdev->bus)->private_data;
> > > > +			npu = &nphb->npu;
> > > > +			mmio_atsd_reg[i].npu = npu;
> > > > +			mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
> > > > +			while (mmio_atsd_reg[i].reg < 0) {
> > > > +				mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
> > > > +				cpu_relax();  
> > > 
> > > A cond_resched() as well if we have too many tries?  
> > 
> > I don't think we can as the invalidate_range() function is called under the ptl
> > spin-lock and is not allowed to sleep (at least according to
> > include/linux/mmu_notifier.h).

I double checked, It's the reverse

	 /*
          * If both of these callbacks cannot block, mmu_notifier_ops.flags
          * should have MMU_INVALIDATE_DOES_NOT_BLOCK set.
          */
         void (*invalidate_range_start)(struct mmu_notifier *mn,
                                        struct mm_struct *mm,
                                        unsigned long start, unsigned long end);
         void (*invalidate_range_end)(struct mmu_notifier *mn,
                                      struct mm_struct *mm,
                                      unsigned long start, unsigned long end);



> > 
> > - Alistair
> >   
> > > Balbir
> > >   
> > 
> > 
> >   

I think it looks good to me otherwise,

Balbir Singh.
