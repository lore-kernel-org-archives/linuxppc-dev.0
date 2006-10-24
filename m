Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6BDAB679E9
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 14:43:39 +1000 (EST)
Subject: Re: [RFC]: map 4K iommu pages even on 64K largepage systems.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061024002540.GA6360@austin.ibm.com>
References: <20061024002540.GA6360@austin.ibm.com>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 14:43:27 +1000
Message-Id: <1161665007.10524.572.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Haven't yet thought if this is a good long-term solution or not,
> whether this kind of thing is desirable or not.  That's why its 
> an RFC.  Comments?

Ok, after some time reading the details of the patch, it looks fairly
good, just a few nits. Also, we need to fix the DART code still :)

Ben

 
> +static inline unsigned long
> +iommu_num_pages(unsigned long vaddr, unsigned long slen)

Coding style in that file is to do:

static inline unsigned long iommu_num_pages(unsigned long vaddr,
					    unsigned long slen)


> @@ -557,8 +562,8 @@ void iommu_unmap_single(struct iommu_tab
>  	BUG_ON(direction == DMA_NONE);
>  
>  	if (tbl)
> -		iommu_free(tbl, dma_handle, (PAGE_ALIGN(dma_handle + size) -
> -					(dma_handle & PAGE_MASK)) >> PAGE_SHIFT);
> +		iommu_free(tbl, dma_handle, (IOMMU_PAGE_ALIGN(dma_handle + size) -
> +					(dma_handle & IOMMU_PAGE_MASK)) >> IOMMU_PAGE_SHIFT);
>  }

Use iommu_num_pages ?

>  /* Allocates a contiguous real buffer and creates mappings over it.
> @@ -571,6 +576,7 @@ void *iommu_alloc_coherent(struct iommu_
>  	void *ret = NULL;
>  	dma_addr_t mapping;
>  	unsigned int npages, order;
> +	unsigned int nio_pages, io_order;
>  	struct page *page;
>  
>  	size = PAGE_ALIGN(size);
> @@ -598,8 +604,10 @@ void *iommu_alloc_coherent(struct iommu_
>  	memset(ret, 0, size);
>  
>  	/* Set up tces to cover the allocated range */
> -	mapping = iommu_alloc(tbl, ret, npages, DMA_BIDIRECTIONAL,
> -			      mask >> PAGE_SHIFT, order);
> +	nio_pages = size >> IOMMU_PAGE_SHIFT;
> +	io_order = get_iommu_order(size);

Not directly related to your patch, but do we really have this
requirement of allocating with an alignement of the order of the
alloation size here ?

Also, your code assumes that PAGE_SHIFT >= IOMMU_PAGE_SHIFT... it might
be useful to not have this restriction in fact. Just maybe use
iommu_num_pages(size) instead of size >> IOMMU_PAGE_SHIFT here ...

> +	mapping = iommu_alloc(tbl, ret, nio_pages, DMA_BIDIRECTIONAL,
> +			      mask >> IOMMU_PAGE_SHIFT, io_order);
>  	if (mapping == DMA_ERROR_CODE) {
>  		free_pages((unsigned long)ret, order);
>  		return NULL;
> @@ -614,9 +622,10 @@ void iommu_free_coherent(struct iommu_ta
>  	unsigned int npages;
>  
>  	if (tbl) {
> -		size = PAGE_ALIGN(size);
> -		npages = size >> PAGE_SHIFT;
> +		size = IOMMU_PAGE_ALIGN(size);
> +		npages = size >> IOMMU_PAGE_SHIFT;
>
>  		iommu_free(tbl, dma_handle, npages);
> +		size = PAGE_ALIGN(size);
>  		free_pages((unsigned long)vaddr, get_order(size));
>  	}

All those repeated alignments on size and one loses track... Are you
sure you'll always end up with the proper values ? I'd rather use
iommu_num_pages() for the iommu_free and only align size once with
PAGE_ALIGN for free_pages().

>  }
> Index: linux-2.6.19-rc1-git11/include/asm-powerpc/iommu.h
> ===================================================================
> --- linux-2.6.19-rc1-git11.orig/include/asm-powerpc/iommu.h	2006-09-19 22:42:06.000000000 -0500
> +++ linux-2.6.19-rc1-git11/include/asm-powerpc/iommu.h	2006-10-23 18:28:21.000000000 -0500
> @@ -23,16 +23,41 @@
>  #ifdef __KERNEL__
>  
>  #include <asm/types.h>
> +#include <linux/compiler.h>
>  #include <linux/spinlock.h>
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
>  
> +#define IOMMU_PAGE_SHIFT      12
> +#define IOMMU_PAGE_SIZE       (ASM_CONST(1) << IOMMU_PAGE_SHIFT)
> +#define IOMMU_PAGE_MASK       (~((1 << IOMMU_PAGE_SHIFT) - 1))
> +#define IOMMU_PAGE_ALIGN(addr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE)
> +
> +#ifndef __ASSEMBLY__
> +
> +/* Pure 2^n version of get_order */
> +static __inline__ __attribute_const__ int get_iommu_order(unsigned long size)
> +{
> +	int order;
> +
> +	size = (size - 1) >> (IOMMU_PAGE_SHIFT - 1);
> +	order = -1;
> +	do {
> +		size >>= 1;
> +		order++;
> +	} while (size);
> +	return order;
> +}
> +
> +#endif   /* __ASSEMBLY__ */

Use cntlzw... or ilog2, which would give something like :

	return __ilog2((size - 1) >> IOMMU_PAGE_SHIFT) + 1;

I think Dave Howells has patches fixing get_order generically to be
implemented in terms of ilog2. (I just discovered that on ppc64, we
didn't use cntlzw/ilog2 for it, sucks, but let's wait for Dave patches
rather than fixing it ourselves now).

> +
>  /*
>   * IOMAP_MAX_ORDER defines the largest contiguous block
>   * of dma space we can get.  IOMAP_MAX_ORDER = 13
>   * allows up to 2**12 pages (4096 * 4096) = 16 MB
>   */
> -#define IOMAP_MAX_ORDER 13
> +#define IOMAP_MAX_ORDER (25 - PAGE_SHIFT)

I'm not completely sure we want the above to be defined as a function of
the page shift... 

>  struct iommu_table {
>  	unsigned long  it_busno;     /* Bus number this table belongs to */
> Index: linux-2.6.19-rc1-git11/include/asm-powerpc/tce.h
> ===================================================================
> --- linux-2.6.19-rc1-git11.orig/include/asm-powerpc/tce.h	2006-09-19 22:42:06.000000000 -0500
> +++ linux-2.6.19-rc1-git11/include/asm-powerpc/tce.h	2006-10-23 15:46:57.000000000 -0500
> @@ -22,6 +22,8 @@
>  #define _ASM_POWERPC_TCE_H
>  #ifdef __KERNEL__
>  
> +#include <asm/iommu.h>
> +
>  /*
>   * Tces come in two formats, one for the virtual bus and a different
>   * format for PCI
> @@ -33,7 +35,7 @@
>  
>  #define TCE_SHIFT	12
>  #define TCE_PAGE_SIZE	(1 << TCE_SHIFT)
> -#define TCE_PAGE_FACTOR	(PAGE_SHIFT - TCE_SHIFT)
> +#define TCE_PAGE_FACTOR	(IOMMU_PAGE_SHIFT - TCE_SHIFT)
>  
>  #define TCE_ENTRY_SIZE		8		/* each TCE is 64 bits */

We can actually remove TCE_PAGE_FACTOR and code using it completely.

With your patch, TCE_SHIFT == IOMMU_PAGE_SHIFT, and in a second step, we
can start having the iommu_page_shift be a member of iommu_table. Thus
there will no longer be any need for a correction factor in the backend.

> Index: linux-2.6.19-rc1-git11/arch/powerpc/kernel/vio.c
> ===================================================================
> --- linux-2.6.19-rc1-git11.orig/arch/powerpc/kernel/vio.c	2006-10-13 11:52:51.000000000 -0500
> +++ linux-2.6.19-rc1-git11/arch/powerpc/kernel/vio.c	2006-10-23 16:06:43.000000000 -0500
> @@ -92,9 +92,9 @@ static struct iommu_table *vio_build_iom
>  				&tbl->it_index, &offset, &size);
>  
>  		/* TCE table size - measured in tce entries */
> -		tbl->it_size = size >> PAGE_SHIFT;
> +		tbl->it_size = size >> IOMMU_PAGE_SHIFT;
>  		/* offset for VIO should always be 0 */
> -		tbl->it_offset = offset >> PAGE_SHIFT;
> +		tbl->it_offset = offset >> IOMMU_PAGE_SHIFT;
>  		tbl->it_busno = 0;
>  		tbl->it_type = TCE_VB;
>  
> Index: linux-2.6.19-rc1-git11/arch/powerpc/platforms/pseries/iommu.c
> ===================================================================
> --- linux-2.6.19-rc1-git11.orig/arch/powerpc/platforms/pseries/iommu.c	2006-10-13 11:54:00.000000000 -0500
> +++ linux-2.6.19-rc1-git11/arch/powerpc/platforms/pseries/iommu.c	2006-10-23 18:42:03.000000000 -0500
> @@ -289,7 +289,7 @@ static void iommu_table_setparms(struct 
>  	tbl->it_busno = phb->bus->number;
>  
>  	/* Units of tce entries */
> -	tbl->it_offset = phb->dma_window_base_cur >> PAGE_SHIFT;
> +	tbl->it_offset = phb->dma_window_base_cur >> IOMMU_PAGE_SHIFT;
>  
>  	/* Test if we are going over 2GB of DMA space */
>  	if (phb->dma_window_base_cur + phb->dma_window_size > 0x80000000ul) {
> @@ -300,7 +300,7 @@ static void iommu_table_setparms(struct 
>  	phb->dma_window_base_cur += phb->dma_window_size;
>  
>  	/* Set the tce table size - measured in entries */
> -	tbl->it_size = phb->dma_window_size >> PAGE_SHIFT;
> +	tbl->it_size = phb->dma_window_size >> IOMMU_PAGE_SHIFT;
>  
>  	tbl->it_index = 0;
>  	tbl->it_blocksize = 16;
> @@ -325,8 +325,8 @@ static void iommu_table_setparms_lpar(st
>  	tbl->it_base   = 0;
>  	tbl->it_blocksize  = 16;
>  	tbl->it_type = TCE_PCI;
> -	tbl->it_offset = offset >> PAGE_SHIFT;
> -	tbl->it_size = size >> PAGE_SHIFT;
> +	tbl->it_offset = offset >> IOMMU_PAGE_SHIFT;
> +	tbl->it_size = size >> IOMMU_PAGE_SHIFT;
>  }
>  
>  static void iommu_bus_setup_pSeries(struct pci_bus *bus)
> @@ -522,8 +522,6 @@ static void iommu_dev_setup_pSeriesLP(st
>  	const void *dma_window = NULL;
>  	struct pci_dn *pci;
>  
> -	DBG("iommu_dev_setup_pSeriesLP, dev %p (%s)\n", dev, pci_name(dev));
> -
>  	/* dev setup for LPAR is a little tricky, since the device tree might
>  	 * contain the dma-window properties per-device and not neccesarily
>  	 * for the bus. So we need to search upwards in the tree until we
> @@ -532,6 +530,9 @@ static void iommu_dev_setup_pSeriesLP(st
>  	 */
>  	dn = pci_device_to_OF_node(dev);
>  
> +	DBG("iommu_dev_setup_pSeriesLP, dev %p (%s) %s\n",
> +	     dev, pci_name(dev), dn->full_name);
> +
>  	for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table;
>  	     pdn = pdn->parent) {
>  		dma_window = get_property(pdn, "ibm,dma-window", NULL);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
