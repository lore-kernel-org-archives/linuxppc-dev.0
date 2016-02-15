Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDD061A0396
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 21:38:35 +1100 (AEDT)
Message-ID: <1455532715.26205.9.camel@ellerman.id.au>
Subject: Re: [PATCH v2 2/4] powerpc/powernv: Fix stale PE primary bus
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 15 Feb 2016 21:38:35 +1100
In-Reply-To: <20160212060924.GA9809@gwshan>
References: <1454993431-17068-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1454993431-17068-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <56BD7586.7060803@au1.ibm.com> <20160212060924.GA9809@gwshan>
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

On Fri, 2016-02-12 at 17:09 +1100, Gavin Shan wrote:

> On Fri, Feb 12, 2016 at 05:02:46PM +1100, Andrew Donnellan wrote:

> > On 09/02/16 15:50, Gavin Shan wrote:

> > > When PCI bus is unplugged during full hotplug for EEH recovery,
> > > the platform PE instance (struct pnv_ioda_pe) isn't released and
> > > it dereferences the stale PCI bus that has been released. It leads
> > > to kernel crash when referring to the stale PCI bus.
> > > 
> > > This fixes the issue by correcting the PE's primary bus when it's
> > > oneline at plugging time, in pnv_pci_dma_bus_setup() which is to
> > > be called by pcibios_fixup_bus().
> > > 
> > > Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> > > Reported-by: Pradipta Ghosh <pradghos@in.ibm.com>
> > > Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> > > Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> > 
> > I realise this has already been merged, but the following was found by
> > Coverity:
> > 

> > > +void pnv_pci_dma_bus_setup(struct pci_bus *bus)
> > > +{
> > > +	struct pci_controller *hose = bus->sysdata;
> > > +	struct pnv_phb *phb = hose->private_data;
> > > +	struct pnv_ioda_pe *pe;
> > > +
> > > +	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
> > > +		if (!(pe->flags | (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)))
> > > +			continue;
> > 
> > This condition is always false. I think the first "|" is supposed to be "&".
> > 
> 
> Yeah, that should be "&". I think the problem isn't found when doing
> testing in non-SRIOV environment. Thanks for pointing it out.
> 
> Michael, please let me know if I need send a follow-up revision to
> correct this one? I found the first two patches have been put into
> linux-next branch. I think we probably just need repost the correct
> version for this one only.

As it happens I needed to rebase my fixes branch anyway, so I've updated it and
rebased. No further action required :)

cheers
