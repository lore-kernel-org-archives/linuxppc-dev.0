Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [150.101.137.145])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qrjDZ6v9DzDqhc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 14:23:58 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, grant.likely@linaro.org, robherring2@gmail.com,
 bhelgaas@google.com, dja@axtens.net
Subject: Re: [PATCH v8 36/45] powerpc/powernv: Support PCI slot ID
Date: Fri, 22 Apr 2016 14:23:54 +1000
Message-ID: <5008269.vZDqGUuHuL@new-mexico>
In-Reply-To: <57170215.7080405@ozlabs.ru>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20160420022840.GC28594@gwshan> <57170215.7080405@ozlabs.ru>
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

On Wed, 20 Apr 2016 14:14:13 Alexey Kardashevskiy wrote:

<snip>

> >
> >>
> >> btw how will new OPAL react if old kernel is running, i.e. not passing @state
> >> at all? If it is initialized to NULL somewher - fine but what exactly does
> >> this initialization and makes sure that OPAL won't see garbage as a second
> >> parameter?
> >>
> >
> > @state is always NULL for old kernel + new OPAL.
> 
> What piece of code writes NULL to "state"? Old kernel will do 
> opal_pci_poll(id) and omit the "state" so something has to take care of it 
> and write NULL where OPAL expects to see a pointer to "state" (which we set 
> to NULL) and that place would be some GPR which may have garbage.
> 
> I am looking at
> #define OPAL_CALL(name, token)
> 
> and cannot see where the second parameter (which old kernel omits) is 
> reset, i.e. gpr4 (or gpr5?) is cleared.

Gavin walked me through the code here and he's right that this won't cause a
problem at the moment. Not because @state is NULL on old kernels (as you point
out it isn't) but because old kernels call a specific sequence of OPAL calls 
which mean that the new Skiboot wont check @state when an old kernel is running.

However this is more a side-effect and is very brittle. It would need far more
commenting on the OPAL side and there's still a good chance someone will break
it by accident. Far easier just to add another OPAL call - eg. opal_pci_poll2().

> > @state is used in
> > PCI hotplug functionality in OPAL only. As old kernel doesn't support
> > PCI hotplug, @state is never used. I'm not sure it's the answer you
> > want?
> 
> No, it is not :)
> 
> >> When ABI like this changes, I expect to see opal_pci_poll2() or
> >> opal_pci_poll_ex() rather than just an additional parameter to
> >> opal_pci_poll()...
> >>
> >
> > It's a good suggestion but it would be nicer if you raised this
> > early. One question I have: current opal_pci_poll() is enough
> > to cover all cases, why we need introduce and maintain another
> > similar one? Sorry that I don't see the reason from your context
> > and could you please provide more details?

Because @state will be some non-NULL random number when opal_pci_poll() is
called on older kernels and if OPAL ever dereferences it you will at best get
a machine check and at worst random memory corruption. It would be far easier
to maintain a new OPAL call than to deal with these kind of problems in the
future.

Also it is an important suggestion that has potentially saved some difficult
debugging. Whilst it is *preferable* for reviewers to notice things earlier in
the review process it is also *preferable* for developers to not write bugs in
the first place. Unfortunately we all miss things and make mistakes. It's far
more important that we catch and correct these problems even if they are noticed
later than we would desire.

- Alistair

> >>> +
> >>> +	return (rval == OPAL_SUCCESS) ? 0 : -EIO;
> >>> +}
> >>> +
> >>>   #ifdef CONFIG_PCI_MSI
> >>>   int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> >>>   {
> >>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> >>> index 0cddde3..6857703 100644
> >>> --- a/arch/powerpc/platforms/powernv/pci.h
> >>> +++ b/arch/powerpc/platforms/powernv/pci.h
> >>> @@ -192,6 +192,7 @@ extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
> >>>   		unsigned long *hpa, enum dma_data_direction *direction);
> >>>   extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
> >>>
> >>> +int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *state);
> >>>   void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
> >>>   				unsigned char *log_buff);
> >>>   int pnv_pci_cfg_read(struct pci_dn *pdn,
> >>>
> >>
> >>
> >> --
> >> Alexey
> >>
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 
> 
