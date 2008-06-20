Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 703A1DDF13
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 01:04:00 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5KF3vSq005464
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 11:03:57 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5KF3veM089116
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 11:03:57 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5KF3umo032392
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 11:03:56 -0400
Date: Fri, 20 Jun 2008 10:03:55 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 11/19] powerpc: iommu enablement for CMO
Message-ID: <20080620150354.GA6594@linux.vnet.ibm.com>
References: <20080612215312.GF30916@linux.vnet.ibm.com>
	<20080612221936.GS30916@linux.vnet.ibm.com>
	<20080613014349.GB32705@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080613014349.GB32705@lixom.net>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Olof Johansson (olof@lixom.net) wrote:
> Hi,
> 
> Some comments and questions below.
> 
> 
> -Olof
> 
> On Thu, Jun 12, 2008 at 05:19:36PM -0500, Robert Jennings wrote:
> > Index: b/arch/powerpc/kernel/iommu.c
> > ===================================================================
> > --- a/arch/powerpc/kernel/iommu.c
> > +++ b/arch/powerpc/kernel/iommu.c
> > @@ -183,6 +183,49 @@ static unsigned long iommu_range_alloc(s
> >  	return n;
> >  }
> >  
> > +/** iommu_undo - Clear iommu_table bits without calling platform tce_free.
> > + *
> > + * @tbl - struct iommu_table to alter
> > + * @dma_addr - DMA address to free entries for
> > + * @npages - number of pages to free entries for
> > + *
> > + * This is the same as __iommu_free without the call to ppc_md.tce_free();
> 
> __iommu_free has the __ prepended to indicate that it's not locking.
> Since this does the same, please keep the __. Also see comments below.
> 
> > + *
> > + * To clean up after ppc_md.tce_build() errors we need to clear bits
> > + * in the table without calling the ppc_md.tce_free() method; calling
> > + * ppc_md.tce_free() could alter entries that were not touched due to a
> > + * premature failure in ppc_md.tce_build().
> > + *
> > + * The ppc_md.tce_build() needs to perform its own clean up prior to
> > + * returning its error.
> > + */
> > +static void iommu_undo(struct iommu_table *tbl, dma_addr_t dma_addr,
> > +			 unsigned int npages)
> > +{
> > +	unsigned long entry, free_entry;
> > +
> > +	entry = dma_addr >> IOMMU_PAGE_SHIFT;
> > +	free_entry = entry - tbl->it_offset;
> > +
> > +	if (((free_entry + npages) > tbl->it_size) ||
> > +	    (entry < tbl->it_offset)) {
> > +		if (printk_ratelimit()) {
> > +			printk(KERN_INFO "iommu_undo: invalid entry\n");
> > +			printk(KERN_INFO "\tentry    = 0x%lx\n", entry);
> > +			printk(KERN_INFO "\tdma_addr = 0x%lx\n", (u64)dma_addr);
> > +			printk(KERN_INFO "\tTable    = 0x%lx\n", (u64)tbl);
> > +			printk(KERN_INFO "\tbus#     = 0x%lx\n", tbl->it_busno);
> > +			printk(KERN_INFO "\tsize     = 0x%lx\n", tbl->it_size);
> > +			printk(KERN_INFO "\tstartOff = 0x%lx\n", tbl->it_offset);
> > +			printk(KERN_INFO "\tindex    = 0x%lx\n", tbl->it_index);
> > +			WARN_ON(1);
> > +		}
> > +		return;
> > +	}
> > +
> > +	iommu_area_free(tbl->it_map, free_entry, npages);
> > +}
> 
> Ick, This should just be refactored to reuse code together with
> iommu_free() instead of duplicating it. Also, the error checking
> shouldn't be needed here.
> 
> Actually, is there harm in calling tce_free for these cases anyway? I'm
> guessing it's not a performance critical path.

There is no harm and I will get rid of this and just call __iommu_free.

> > @@ -275,7 +330,7 @@ int iommu_map_sg(struct device *dev, str
> >  	dma_addr_t dma_next = 0, dma_addr;
> >  	unsigned long flags;
> >  	struct scatterlist *s, *outs, *segstart;
> > -	int outcount, incount, i;
> > +	int outcount, incount, i, rc = 0;
> >  	unsigned int align;
> >  	unsigned long handle;
> >  	unsigned int max_seg_size;
> > @@ -336,7 +391,10 @@ int iommu_map_sg(struct device *dev, str
> >  			    npages, entry, dma_addr);
> >  
> >  		/* Insert into HW table */
> > -		ppc_md.tce_build(tbl, entry, npages, vaddr & IOMMU_PAGE_MASK, direction);
> > +		rc = ppc_md.tce_build(tbl, entry, npages,
> > +		                      vaddr & IOMMU_PAGE_MASK, direction);
> > +		if(unlikely(rc))
> > +			goto failure;
> >  
> >  		/* If we are in an open segment, try merging */
> >  		if (segstart != s) {
> > @@ -399,7 +457,10 @@ int iommu_map_sg(struct device *dev, str
> >  
> >  			vaddr = s->dma_address & IOMMU_PAGE_MASK;
> >  			npages = iommu_num_pages(s->dma_address, s->dma_length);
> > -			__iommu_free(tbl, vaddr, npages);
> > +			if (!rc)
> > +				__iommu_free(tbl, vaddr, npages);
> > +			else
> > +				iommu_undo(tbl, vaddr, npages);
> 
> 'rc' is a quite generic name to carry state this far away from where
> it's set. Either a more descriptive name (build_fail, whatever), or if
> the above is true, just call __iommu_free here as well.

I'll fix this.

> > -static void tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
> > +static void tce_free_pSeriesLP(struct iommu_table*, long, long);
> > +static void tce_freemulti_pSeriesLP(struct iommu_table*, long, long);
> > +
> > +static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
> >  				long npages, unsigned long uaddr,
> >  				enum dma_data_direction direction)
> >  {
> > -	u64 rc;
> > +	u64 rc = 0;
> >  	u64 proto_tce, tce;
> >  	u64 rpn;
> > +	int sleep_msecs, ret = 0;
> > +	long tcenum_start = tcenum, npages_start = npages;
> >  
> >  	rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
> >  	proto_tce = TCE_PCI_READ;
> > @@ -108,7 +115,21 @@ static void tce_build_pSeriesLP(struct i
> >  
> >  	while (npages--) {
> >  		tce = proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT;
> > -		rc = plpar_tce_put((u64)tbl->it_index, (u64)tcenum << 12, tce);
> > +		do {
> > +			rc = plpar_tce_put((u64)tbl->it_index,
> > +			                   (u64)tcenum << 12, tce);
> > +			if (unlikely(H_IS_LONG_BUSY(rc))) {
> > +				sleep_msecs = plpar_get_longbusy_msecs(rc);
> > +				mdelay(sleep_msecs);
> 
> Ouch! You're holding locks and stuff here. Do you really want this right
> here?

All of this delay business will be removed.  The firmware will not be
returning any H_LONG_BUSY return codes.

> > +			}
> > +		} while (unlikely(H_IS_LONG_BUSY(rc)));
> 
> Do you also want to keep doing this forever, or eventually just fail
> instead?
> 
> > +		if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
> > +			ret = (int)rc;
> > +			tce_free_pSeriesLP(tbl, tcenum_start,
> > +			                   (npages_start - (npages + 1)));
> > +			break;
> > +		}
> >  
> >  		if (rc && printk_ratelimit()) {
> >  			printk("tce_build_pSeriesLP: plpar_tce_put failed. rc=%ld\n", rc);
> > @@ -121,19 +142,22 @@ static void tce_build_pSeriesLP(struct i
> >  		tcenum++;
> >  		rpn++;
> >  	}
> > +	return ret;
> >  }
> >  
> >  static DEFINE_PER_CPU(u64 *, tce_page) = NULL;
> >  
> > -static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
> > +static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
> >  				     long npages, unsigned long uaddr,
> >  				     enum dma_data_direction direction)
> >  {
> > -	u64 rc;
> > +	u64 rc = 0;
> >  	u64 proto_tce;
> >  	u64 *tcep;
> >  	u64 rpn;
> >  	long l, limit;
> > +	long tcenum_start = tcenum, npages_start = npages;
> > +	int sleep_msecs, ret = 0;
> >  
> >  	if (npages == 1)
> >  		return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
> > @@ -171,15 +195,26 @@ static void tce_buildmulti_pSeriesLP(str
> >  			rpn++;
> >  		}
> >  
> > -		rc = plpar_tce_put_indirect((u64)tbl->it_index,
> > -					    (u64)tcenum << 12,
> > -					    (u64)virt_to_abs(tcep),
> > -					    limit);
> > +		do {
> > +			rc = plpar_tce_put_indirect(tbl->it_index, tcenum << 12,
> > +						    virt_to_abs(tcep), limit);
> > +			if (unlikely(H_IS_LONG_BUSY(rc))) {
> > +				sleep_msecs = plpar_get_longbusy_msecs(rc);
> > +				mdelay(sleep_msecs);
> > +			}
> > +		} while (unlikely(H_IS_LONG_BUSY(rc)));
> >  
> >  		npages -= limit;
> >  		tcenum += limit;
> >  	} while (npages > 0 && !rc);
> >  
> > +	if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
> > +		ret = (int)rc;
> > +		tce_freemulti_pSeriesLP(tbl, tcenum_start,
> > +		                        (npages_start - (npages + limit)));
> > +		return ret;
> > +	}
> > +
> >  	if (rc && printk_ratelimit()) {
> >  		printk("tce_buildmulti_pSeriesLP: plpar_tce_put failed. rc=%ld\n", rc);
> >  		printk("\tindex   = 0x%lx\n", (u64)tbl->it_index);
> > @@ -187,14 +222,23 @@ static void tce_buildmulti_pSeriesLP(str
> >  		printk("\ttce[0] val = 0x%lx\n", tcep[0]);
> >  		show_stack(current, (unsigned long *)__get_SP());
> >  	}
> > +	return ret;
> >  }
> >  
> >  static void tce_free_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
> >  {
> > +	int sleep_msecs;
> >  	u64 rc;
> >  
> >  	while (npages--) {
> > -		rc = plpar_tce_put((u64)tbl->it_index, (u64)tcenum << 12, 0);
> > +		do {
> > +			rc = plpar_tce_put((u64)tbl->it_index,
> > +			                   (u64)tcenum << 12, 0);
> > +			if (unlikely(H_IS_LONG_BUSY(rc))) {
> > +				sleep_msecs = plpar_get_longbusy_msecs(rc);
> > +				mdelay(sleep_msecs);
> > +			}
> > +		} while (unlikely(H_IS_LONG_BUSY(rc)));
> 
> Can this ever happen? I would hope that any entry that's got an active
> mapping is actually pinned in memory, what other than paging in from
> disk can result in long busy?

This won't happen, I'll remove it.

> > @@ -210,9 +254,17 @@ static void tce_free_pSeriesLP(struct io
> >  
> >  static void tce_freemulti_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
> >  {
> > +	int sleep_msecs;
> >  	u64 rc;
> >  
> > -	rc = plpar_tce_stuff((u64)tbl->it_index, (u64)tcenum << 12, 0, npages);
> > +	do {
> > +		rc = plpar_tce_stuff((u64)tbl->it_index,
> > +		                     (u64)tcenum << 12, 0, npages);
> > +		if (unlikely(H_IS_LONG_BUSY(rc))) {
> > +			sleep_msecs = plpar_get_longbusy_msecs(rc);
> > +			mdelay(sleep_msecs);
> > +		}
> > +	} while (unlikely(H_IS_LONG_BUSY(rc)));
> >  
> >  	if (rc && printk_ratelimit()) {
> >  		printk("tce_freemulti_pSeriesLP: plpar_tce_stuff failed\n");
