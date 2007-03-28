Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80096DDEBA
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2007 09:32:25 +1000 (EST)
Subject: Re: [PATCH] DMA 4GB boundary protection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
In-Reply-To: <1175105842.1398.43.camel@goblue>
References: <1172872183.5310.145.camel@goblue>
	<20070303232915.GB8028@lixom.net> <1174511149.5225.135.camel@goblue>
	<20070322175324.GA21120@lixom.net> <1175026241.1398.23.camel@goblue>
	<20070328155635.GA14356@lixom.net>  <1175105842.1398.43.camel@goblue>
Content-Type: text/plain
Date: Thu, 29 Mar 2007 09:23:03 +1000
Message-Id: <1175124183.32220.17.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-28 at 13:17 -0500, Jake Moilanen wrote:

> One more try.

And patch is still mangled....

> There are many adapters which can not handle DMAing acrosss any 4 GB
> boundary.  For instance the latest Emulex adapters.  
> 
> This normally is not an issue as firmware gives dma-windows under
> 4gigs.  However, some of the new System-P boxes have dma-windows above
> 4gigs, and this present a problem.
> 
> During initialization of the IOMMU tables, the last entry at each 4GB
> boundary is marked as used.  Thus no mappings can cross the boundary.
> If a table ends at a 4GB boundary, the entry is not marked as used.
> 
> A boot option to remove this 4GB protection is given w/ protect4gb=off.
> This exposes the potential issue for driver and hardware development
> purposes.
> 
> Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>
> ---
>  arch/powerpc/kernel/iommu.c |   35 ++++++++++++++++++++++++++++++++++-
>  1 files changed, 34 insertions(+), 1 deletion(-)
> 
> Index: powerpc/arch/powerpc/kernel/iommu.c
> ===================================================================
> --- powerpc.orig/arch/powerpc/kernel/iommu.c
> +++ powerpc/arch/powerpc/kernel/iommu.c
> @@ -47,6 +47,8 @@ static int novmerge = 0;
>  static int novmerge = 1;
>  #endif
>  
> +static int protect4gb = 1;
> +
>  static inline unsigned long iommu_num_pages(unsigned long vaddr,
>  					    unsigned long slen)
>  {
> @@ -58,6 +60,16 @@ static inline unsigned long iommu_num_pa
>  	return npages;
>  }
>  
> +static int __init setup_protect4gb(char *str)
> +{
> +	if (strcmp(str, "on") == 0)
> +		protect4gb = 1;
> +	else if (strcmp(str, "off") == 0)
> +		protect4gb = 0;
> +
> +	return 1;
> +}
> +
>  static int __init setup_iommu(char *str)
>  {
>  	if (!strcmp(str, "novmerge"))
> @@ -67,6 +79,7 @@ static int __init setup_iommu(char *str)
>  	return 1;
>  }
>  
> +__setup("protect4gb=", setup_protect4gb);
>  __setup("iommu=", setup_iommu);
>  
>  static unsigned long iommu_range_alloc(struct iommu_table *tbl,
> @@ -429,6 +442,9 @@ void iommu_unmap_sg(struct iommu_table *
>  struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
>  {
>  	unsigned long sz;
> +	unsigned long start_index, end_index;
> +	unsigned long entries_per_4g;
> +	unsigned long index;
>  	static int welcomed = 0;
>  	struct page *page;
>  
> @@ -450,7 +466,7 @@ struct iommu_table *iommu_init_table(str
>  
>  #ifdef CONFIG_CRASH_DUMP
>  	if (ppc_md.tce_get) {
> -		unsigned long index, tceval;
> +		unsigned long tceval;
>  		unsigned long tcecount = 0;
>  
>  		/*
> @@ -480,6 +496,23 @@ struct iommu_table *iommu_init_table(str
>  	ppc_md.tce_free(tbl, tbl->it_offset, tbl->it_size);
>  #endif
>  
> +	/*
> +	 * DMA cannot cross 4 GB boundary.  Mark last entry of each 4
> +	 * GB chunk as reserved.
> +	 */
> +	if (protect4gb) {
> +		entries_per_4g = 0x100000000l >> IOMMU_PAGE_SHIFT;
> +
> +		/* Mark the last bit before a 4GB boundary as used */
> +		start_index = tbl->it_offset | (entries_per_4g - 1);
> +		start_index -= tbl->it_offset;
> +
> +		end_index = tbl->it_size;
> +
> +		for (index = start_index; index < end_index - 1; index +=
> entries_per_4g)
> +			__set_bit(index, tbl->it_map);
> +	}
> +
>  	if (!welcomed) {
>  		printk(KERN_INFO "IOMMU table initialized, virtual merging %s\n",
>  		       novmerge ? "disabled" : "enabled");
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
