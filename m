Return-Path: <alistair@popple.id.au>
Received: from ipmail01.adl6.internode.on.net (ipmail01.adl6.internode.on.net
 [150.101.137.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xmlNx1MJ8zDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 21:49:05 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, arbab@linux.vnet.ibm.com, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH 2/2] powerpc/powernv/npu: Don't explicitly flush nmmu tlb
Date: Tue, 05 Sep 2017 21:48:59 +1000
Message-ID: <11943565.fESM0TqCRL@new-mexico>
In-Reply-To: <eda91861-8b62-fb4e-544e-f43182441777@linux.vnet.ibm.com>
References: <1504583864-8169-1-git-send-email-alistair@popple.id.au>
 <1504583864-8169-2-git-send-email-alistair@popple.id.au>
 <eda91861-8b62-fb4e-544e-f43182441777@linux.vnet.ibm.com>
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

Hi,

On Tue, 5 Sep 2017 10:10:03 AM Frederic Barrat wrote:
> > 
> > +	if (!nphb->npu.nmmu_flush) {
> > +		/*
> > +		 * If we're not explicitly flushing ourselves we need to mark
> > +		 * the thread for global flushes
> > +		 */
> > +		npu_context->nmmu_flush = false;
> > +		inc_mm_active_cpus(mm);
> 
> 
> I can see that you use the inc_mm_active_cpus()/dec_mm_active_cpus() and 
> not the new mm_context_add_copro()/mm_context_remove_copro(). The only 
> difference is that mm_context_remove_copro() adds an extra flush of the 
> full mm (pwc and tlb) before decrementing the active cpu count.

Thanks for pointing that out, I'd overlooked the difference between the two.

> But don't you need the flush when releasing the context? As soon as the 
> active cpu count is decremented, the next TLBI may be local and not 
> visible to the nMMU, so the nMMU could keep obsolete/wrong entries in 
> its cache.

Yes, I think you're right. In practice I doubt we'd ever hit it as the driver
never calls pnv_npu2_destroy_context() prior to the process being torn down
(which should trigger the right global tlbies). But obviously something that
needs fixing so I will post a v2 ... thanks for reviewing!

Regards,

Alistair

>    Fred
> 
> 
> 
> > +	} else
> > +		npu_context->nmmu_flush = true;
> > +
> >   	return npu_context;
> >   }
> >   EXPORT_SYMBOL(pnv_npu2_init_context);
> > @@ -731,6 +744,9 @@ static void pnv_npu2_release_context(struct kref *kref)
> >   	struct npu_context *npu_context =
> >   		container_of(kref, struct npu_context, kref);
> > 
> > +	if (!npu_context->nmmu_flush)
> > +		dec_mm_active_cpus(npu_context->mm);
> > +
> >   	npu_context->mm->context.npu_context = NULL;
> >   	mmu_notifier_unregister(&npu_context->mn,
> >   				npu_context->mm);
> > @@ -819,6 +835,8 @@ int pnv_npu2_init(struct pnv_phb *phb)
> >   	static int npu_index;
> >   	uint64_t rc = 0;
> > 
> > +	phb->npu.nmmu_flush =
> > +		of_property_read_bool(phb->hose->dn, "ibm,nmmu-flush");
> >   	for_each_child_of_node(phb->hose->dn, dn) {
> >   		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
> >   		if (gpdev) {
> > diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> > index a95273c..22025c6 100644
> > --- a/arch/powerpc/platforms/powernv/pci.h
> > +++ b/arch/powerpc/platforms/powernv/pci.h
> > @@ -187,6 +187,9 @@ struct pnv_phb {
> > 
> >   		/* Bitmask for MMIO register usage */
> >   		unsigned long mmio_atsd_usage;
> > +
> > +		/* Do we need to explicitly flush the nest mmu? */
> > +		bool nmmu_flush;
> >   	} npu;
> > 
> >   #ifdef CONFIG_CXL_BASE
> > 
> 
