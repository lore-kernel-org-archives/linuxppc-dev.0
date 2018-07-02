Return-Path: <aik@ozlabs.ru>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41K1DK1QnWzF1Pn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 18:50:25 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id d185-v6so14056444ioe.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jul 2018 01:50:24 -0700 (PDT)
Date: Mon, 2 Jul 2018 18:50:15 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH kernel 1/2] powerpc/powernv: Reuse existing TCE code for
 sketchy bypass
Message-ID: <20180702185015.784db4a4@aik.ozlabs.ibm.com>
In-Reply-To: <615a926cedadfe528cd72e4f29a4183b0a7f8c08.camel@kernel.crashing.org>
References: <20180601081028.29401-1-aik@ozlabs.ru>
 <20180601081028.29401-2-aik@ozlabs.ru>
 <615a926cedadfe528cd72e4f29a4183b0a7f8c08.camel@kernel.crashing.org>
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

On Sat, 16 Jun 2018 11:04:32 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2018-06-01 at 18:10 +1000, Alexey Kardashevskiy wrote:
> > The existing sketchy bypass ignores the existing default 32bit TCE table
> > (created by default for every PE at boot time or after being used by
> > VFIO) and it allocates another table instead without updating PE DMA
> > config (pe->table_group). So if we decide to use such device for VFIO
> > later, this new table will also leak memory.
> > 
> > This replaces adhoc table allocation and programming with the existing
> > API which handles memory leaks.
> > 
> > This programs the default 32bit table back to TVE#0 if configuring
> > the new table failed for some reason.
> > 
> > While we are at it, switch from the hardcoded 256MB TCEs to the biggest
> > size supported by the hardware and reported by the firmware. This allows
> > the sketchy bypass (originally made for POWER8 only) to work on POWER9
> > too assuming that PHB4 type is defined and pnv_pci_ioda_dma_64bit_bypass()
> > is called (coming next).  
> 
> It won't work on POWER9 for other reasons. Mostly memory isn't
> contiguous there.


This simply allocates a table using the existing API which makes
things more accurate and manageable. "[PATCH 0/3] PCI DMA pseudo-bypass
for powernv" still allocates a table and programs it via OPAL, why does
it have to replicate all the helpers I put there? Do they all suck and
the new ones are better? If so, how exactly are they better? And let's
fix them then.



> 
> What we shuld look into rather than removing the 32-bit table is
> exploit DD2 P9 feature allowing to overlay TVE0 and TVE1 so that 0..4G
> is in control of TVE0 and the rest goes to TVE1.
>  
> > This does not call iommu_init_table() for the new table as the caller
> > will use &dma_nommu_ops and therefore ::it_map is not needed.
> > 
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> > 
> > Tested with:
> >  	if (pe->tce_bypass_enabled) {
> >  		top = pe->tce_bypass_base + memblock_end_of_DRAM() - 1;
> > -		bypass = (dma_mask >= top);
> > +		bypass = false;//(dma_mask >= top);
> >  	}
> > ---
> >  arch/powerpc/platforms/powernv/pci-ioda.c | 71 +++++++++++++++++--------------
> >  1 file changed, 39 insertions(+), 32 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> > index ceb7e64..9239142 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -1791,54 +1791,61 @@ static bool pnv_pci_ioda_pe_single_vendor(struct pnv_ioda_pe *pe)
> >   *
> >   * Currently this will only work on PHB3 (POWER8).
> >   */
> > +static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
> > +		int num, __u32 page_shift, __u64 window_size, __u32 levels,
> > +		struct iommu_table **ptbl);
> > +
> > +static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
> > +		int num, struct iommu_table *tbl);
> > +
> > +static unsigned long pnv_ioda_parse_tce_sizes(struct pnv_phb *phb);
> > +
> >  static int pnv_pci_ioda_dma_64bit_bypass(struct pnv_ioda_pe *pe)
> >  {
> > -	u64 window_size, table_size, tce_count, addr;
> > -	struct page *table_pages;
> > -	u64 tce_order = 28; /* 256MB TCEs */
> > -	__be64 *tces;
> > +	u64 window_size;
> >  	s64 rc;
> > +	struct iommu_table *tbl, *oldtbl = NULL;
> > +	unsigned long shift, offset;
> >  
> >  	/*
> >  	 * Window size needs to be a power of two, but needs to account for
> >  	 * shifting memory by the 4GB offset required to skip 32bit space.
> >  	 */
> > -	window_size = roundup_pow_of_two(memory_hotplug_max() + (1ULL << 32));
> > -	tce_count = window_size >> tce_order;
> > -	table_size = tce_count << 3;
> > -
> > -	if (table_size < PAGE_SIZE)
> > -		table_size = PAGE_SIZE;
> > +	window_size = roundup_pow_of_two(memory_hotplug_max() + SZ_4G);
> > +	shift = ilog2(pnv_ioda_parse_tce_sizes(pe->phb));
> > +	rc = pnv_pci_ioda2_create_table(&pe->table_group, 0, shift, window_size,
> > +			POWERNV_IOMMU_DEFAULT_LEVELS, &tbl);
> > +	if (rc) {
> > +		pe_err(pe, "Failed to create 64-bypass TCE table, err %ld", rc);
> > +		return rc;
> > +	}
> >  
> > -	table_pages = alloc_pages_node(pe->phb->hose->node, GFP_KERNEL,
> > -				       get_order(table_size));
> > -	if (!table_pages)
> > +	offset = SZ_4G >> shift;
> > +	rc = tbl->it_ops->set(tbl, offset, tbl->it_size - offset,
> > +			0 /* uaddr */, DMA_BIDIRECTIONAL, 0 /* attrs */);
> > +	if (rc)
> >  		goto err;
> >  
> > -	tces = page_address(table_pages);
> > -	if (!tces)
> > +	if (pe->table_group.tables[0]) {
> > +		oldtbl = pe->table_group.tables[0];
> > +		pnv_pci_ioda2_unset_window(&pe->table_group, 0);
> > +	}
> > +
> > +	rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
> > +	if (rc != OPAL_SUCCESS) {
> > +		rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, oldtbl);
> >  		goto err;
> > +	}
> >  
> > -	memset(tces, 0, table_size);
> > +	if (oldtbl)
> > +		iommu_tce_table_put(oldtbl);
> >  
> > -	for (addr = 0; addr < memory_hotplug_max(); addr += (1 << tce_order)) {
> > -		tces[(addr + (1ULL << 32)) >> tce_order] =
> > -			cpu_to_be64(addr | TCE_PCI_READ | TCE_PCI_WRITE);
> > -	}
> > +	pe_info(pe, "Using 64-bit DMA iommu bypass (through TVE#0)\n");
> > +	return 0;
> >  
> > -	rc = opal_pci_map_pe_dma_window(pe->phb->opal_id,
> > -					pe->pe_number,
> > -					/* reconfigure window 0 */
> > -					(pe->pe_number << 1) + 0,
> > -					1,
> > -					__pa(tces),
> > -					table_size,
> > -					1 << tce_order);
> > -	if (rc == OPAL_SUCCESS) {
> > -		pe_info(pe, "Using 64-bit DMA iommu bypass (through TVE#0)\n");
> > -		return 0;
> > -	}
> >  err:
> > +	iommu_tce_table_put(tbl);
> > +
> >  	pe_err(pe, "Error configuring 64-bit DMA bypass\n");
> >  	return -EIO;
> >  }  



--
Alexey
