Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DA365B712C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 11:41:33 +1000 (EST)
Subject: Re: [PATCH 10/33] powerpc/cell: Extract duplicated IOPTE_* to
	<asm/iommu.h>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
Content-Type: text/plain
Date: Mon, 15 Jun 2009 11:41:25 +1000
Message-Id: <1245030085.19217.5.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-06-10 at 16:38 +0200, Geert Uytterhoeven wrote:
> Both arch/powerpc/platforms/cell/iommu.c and arch/powerpc/platforms/ps3/mm.c
> contain the same Cell IOMMU page table entry definitions. Extract them and move
> them to <asm/iommu.h>, while adding a CBE_ prefix.
> This also allows them to be used by drivers.

Are we sure include/asm/iommu.h is the right place for that ?

I'm hesitating here...

Cheers,
Ben.

> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
> v2: Add CBE_ prefix
> 
>  arch/powerpc/include/asm/iommu.h        |   10 ++++++++
>  arch/powerpc/platforms/cell/iommu.c     |   37 ++++++++++++------------------
>  arch/powerpc/platforms/ps3/mm.c         |    7 ++++-
>  arch/powerpc/platforms/ps3/platform.h   |   10 --------
>  arch/powerpc/platforms/ps3/system-bus.c |   15 +++++++-----
>  5 files changed, 39 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
> index 7464c0d..7ead7c1 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -35,6 +35,16 @@
>  #define IOMMU_PAGE_MASK       (~((1 << IOMMU_PAGE_SHIFT) - 1))
>  #define IOMMU_PAGE_ALIGN(addr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE)
>  
> +/* Cell page table entries */
> +#define CBE_IOPTE_PP_W		0x8000000000000000ul /* protection: write */
> +#define CBE_IOPTE_PP_R		0x4000000000000000ul /* protection: read */
> +#define CBE_IOPTE_M		0x2000000000000000ul /* coherency required */
> +#define CBE_IOPTE_SO_R		0x1000000000000000ul /* ordering: writes */
> +#define CBE_IOPTE_SO_RW		0x1800000000000000ul /* ordering: r & w */
> +#define CBE_IOPTE_RPN_Mask	0x07fffffffffff000ul /* RPN */
> +#define CBE_IOPTE_H		0x0000000000000800ul /* cache hint */
> +#define CBE_IOPTE_IOID_Mask	0x00000000000007fful /* ioid */
> +
>  /* Boot time flags */
>  extern int iommu_is_off;
>  extern int iommu_force_on;
> diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
> index bed4690..5b34fc2 100644
> --- a/arch/powerpc/platforms/cell/iommu.c
> +++ b/arch/powerpc/platforms/cell/iommu.c
> @@ -100,16 +100,6 @@
>  #define IOSTE_PS_1M		0x0000000000000005ul /*   - 1MB  */
>  #define IOSTE_PS_16M		0x0000000000000007ul /*   - 16MB */
>  
> -/* Page table entries */
> -#define IOPTE_PP_W		0x8000000000000000ul /* protection: write */
> -#define IOPTE_PP_R		0x4000000000000000ul /* protection: read */
> -#define IOPTE_M			0x2000000000000000ul /* coherency required */
> -#define IOPTE_SO_R		0x1000000000000000ul /* ordering: writes */
> -#define IOPTE_SO_RW             0x1800000000000000ul /* ordering: r & w */
> -#define IOPTE_RPN_Mask		0x07fffffffffff000ul /* RPN */
> -#define IOPTE_H			0x0000000000000800ul /* cache hint */
> -#define IOPTE_IOID_Mask		0x00000000000007fful /* ioid */
> -
>  
>  /* IOMMU sizing */
>  #define IO_SEGMENT_SHIFT	28
> @@ -193,19 +183,21 @@ static int tce_build_cell(struct iommu_table *tbl, long index, long npages,
>  	 */
>  	const unsigned long prot = 0xc48;
>  	base_pte =
> -		((prot << (52 + 4 * direction)) & (IOPTE_PP_W | IOPTE_PP_R))
> -		| IOPTE_M | IOPTE_SO_RW | (window->ioid & IOPTE_IOID_Mask);
> +		((prot << (52 + 4 * direction)) &
> +		 (CBE_IOPTE_PP_W | CBE_IOPTE_PP_R)) |
> +		CBE_IOPTE_M | CBE_IOPTE_SO_RW |
> +		(window->ioid & CBE_IOPTE_IOID_Mask);
>  #else
> -	base_pte = IOPTE_PP_W | IOPTE_PP_R | IOPTE_M | IOPTE_SO_RW |
> -		(window->ioid & IOPTE_IOID_Mask);
> +	base_pte = CBE_IOPTE_PP_W | CBE_IOPTE_PP_R | CBE_IOPTE_M |
> +		CBE_IOPTE_SO_RW | (window->ioid & CBE_IOPTE_IOID_Mask);
>  #endif
>  	if (unlikely(dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs)))
> -		base_pte &= ~IOPTE_SO_RW;
> +		base_pte &= ~CBE_IOPTE_SO_RW;
>  
>  	io_pte = (unsigned long *)tbl->it_base + (index - tbl->it_offset);
>  
>  	for (i = 0; i < npages; i++, uaddr += IOMMU_PAGE_SIZE)
> -		io_pte[i] = base_pte | (__pa(uaddr) & IOPTE_RPN_Mask);
> +		io_pte[i] = base_pte | (__pa(uaddr) & CBE_IOPTE_RPN_Mask);
>  
>  	mb();
>  
> @@ -231,8 +223,9 @@ static void tce_free_cell(struct iommu_table *tbl, long index, long npages)
>  #else
>  	/* spider bridge does PCI reads after freeing - insert a mapping
>  	 * to a scratch page instead of an invalid entry */
> -	pte = IOPTE_PP_R | IOPTE_M | IOPTE_SO_RW | __pa(window->iommu->pad_page)
> -		| (window->ioid & IOPTE_IOID_Mask);
> +	pte = CBE_IOPTE_PP_R | CBE_IOPTE_M | CBE_IOPTE_SO_RW |
> +		__pa(window->iommu->pad_page) |
> +		(window->ioid & CBE_IOPTE_IOID_Mask);
>  #endif
>  
>  	io_pte = (unsigned long *)tbl->it_base + (index - tbl->it_offset);
> @@ -1001,7 +994,7 @@ static void insert_16M_pte(unsigned long addr, unsigned long *ptab,
>  	pr_debug("iommu: addr %lx ptab %p segment %lx offset %lx\n",
>  		  addr, ptab, segment, offset);
>  
> -	ptab[offset] = base_pte | (__pa(addr) & IOPTE_RPN_Mask);
> +	ptab[offset] = base_pte | (__pa(addr) & CBE_IOPTE_RPN_Mask);
>  }
>  
>  static void cell_iommu_setup_fixed_ptab(struct cbe_iommu *iommu,
> @@ -1016,14 +1009,14 @@ static void cell_iommu_setup_fixed_ptab(struct cbe_iommu *iommu,
>  
>  	pr_debug("iommu: mapping 0x%lx pages from 0x%lx\n", fsize, fbase);
>  
> -	base_pte = IOPTE_PP_W | IOPTE_PP_R | IOPTE_M
> -		    | (cell_iommu_get_ioid(np) & IOPTE_IOID_Mask);
> +	base_pte = CBE_IOPTE_PP_W | CBE_IOPTE_PP_R | CBE_IOPTE_M |
> +		(cell_iommu_get_ioid(np) & CBE_IOPTE_IOID_Mask);
>  
>  	if (iommu_fixed_is_weak)
>  		pr_info("IOMMU: Using weak ordering for fixed mapping\n");
>  	else {
>  		pr_info("IOMMU: Using strong ordering for fixed mapping\n");
> -		base_pte |= IOPTE_SO_RW;
> +		base_pte |= CBE_IOPTE_SO_RW;
>  	}
>  
>  	for (uaddr = 0; uaddr < fsize; uaddr += (1 << 24)) {
> diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
> index 9a2b6d9..017b614 100644
> --- a/arch/powerpc/platforms/ps3/mm.c
> +++ b/arch/powerpc/platforms/ps3/mm.c
> @@ -24,6 +24,7 @@
>  #include <linux/lmb.h>
>  
>  #include <asm/firmware.h>
> +#include <asm/iommu.h>
>  #include <asm/prom.h>
>  #include <asm/udbg.h>
>  #include <asm/lv1call.h>
> @@ -1001,7 +1002,8 @@ static int dma_sb_region_create_linear(struct ps3_dma_region *r)
>  		if (len > r->len)
>  			len = r->len;
>  		result = dma_sb_map_area(r, virt_addr, len, &tmp,
> -			IOPTE_PP_W | IOPTE_PP_R | IOPTE_SO_RW | IOPTE_M);
> +			CBE_IOPTE_PP_W | CBE_IOPTE_PP_R | CBE_IOPTE_SO_RW |
> +			CBE_IOPTE_M);
>  		BUG_ON(result);
>  	}
>  
> @@ -1014,7 +1016,8 @@ static int dma_sb_region_create_linear(struct ps3_dma_region *r)
>  		else
>  			len -= map.rm.size - r->offset;
>  		result = dma_sb_map_area(r, virt_addr, len, &tmp,
> -			IOPTE_PP_W | IOPTE_PP_R | IOPTE_SO_RW | IOPTE_M);
> +			CBE_IOPTE_PP_W | CBE_IOPTE_PP_R | CBE_IOPTE_SO_RW |
> +			CBE_IOPTE_M);
>  		BUG_ON(result);
>  	}
>  
> diff --git a/arch/powerpc/platforms/ps3/platform.h b/arch/powerpc/platforms/ps3/platform.h
> index 136aa06..9a196a8 100644
> --- a/arch/powerpc/platforms/ps3/platform.h
> +++ b/arch/powerpc/platforms/ps3/platform.h
> @@ -232,14 +232,4 @@ int ps3_repository_read_spu_resource_id(unsigned int res_index,
>  int ps3_repository_read_vuart_av_port(unsigned int *port);
>  int ps3_repository_read_vuart_sysmgr_port(unsigned int *port);
>  
> -/* Page table entries */
> -#define IOPTE_PP_W		0x8000000000000000ul /* protection: write */
> -#define IOPTE_PP_R		0x4000000000000000ul /* protection: read */
> -#define IOPTE_M			0x2000000000000000ul /* coherency required */
> -#define IOPTE_SO_R		0x1000000000000000ul /* ordering: writes */
> -#define IOPTE_SO_RW             0x1800000000000000ul /* ordering: r & w */
> -#define IOPTE_RPN_Mask		0x07fffffffffff000ul /* RPN */
> -#define IOPTE_H			0x0000000000000800ul /* cache hint */
> -#define IOPTE_IOID_Mask		0x00000000000007fful /* ioid */
> -
>  #endif
> diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
> index 9a73d02..9fead0f 100644
> --- a/arch/powerpc/platforms/ps3/system-bus.c
> +++ b/arch/powerpc/platforms/ps3/system-bus.c
> @@ -27,6 +27,7 @@
>  #include <asm/udbg.h>
>  #include <asm/lv1call.h>
>  #include <asm/firmware.h>
> +#include <asm/iommu.h>
>  
>  #include "platform.h"
>  
> @@ -531,7 +532,8 @@ static void * ps3_alloc_coherent(struct device *_dev, size_t size,
>  	}
>  
>  	result = ps3_dma_map(dev->d_region, virt_addr, size, dma_handle,
> -			     IOPTE_PP_W | IOPTE_PP_R | IOPTE_SO_RW | IOPTE_M);
> +			     CBE_IOPTE_PP_W | CBE_IOPTE_PP_R |
> +			     CBE_IOPTE_SO_RW | CBE_IOPTE_M);
>  
>  	if (result) {
>  		pr_debug("%s:%d: ps3_dma_map failed (%d)\n",
> @@ -575,7 +577,8 @@ static dma_addr_t ps3_sb_map_page(struct device *_dev, struct page *page,
>  
>  	result = ps3_dma_map(dev->d_region, (unsigned long)ptr, size,
>  			     &bus_addr,
> -			     IOPTE_PP_R | IOPTE_PP_W | IOPTE_SO_RW | IOPTE_M);
> +			     CBE_IOPTE_PP_R | CBE_IOPTE_PP_W |
> +			     CBE_IOPTE_SO_RW | CBE_IOPTE_M);
>  
>  	if (result) {
>  		pr_debug("%s:%d: ps3_dma_map failed (%d)\n",
> @@ -596,16 +599,16 @@ static dma_addr_t ps3_ioc0_map_page(struct device *_dev, struct page *page,
>  	u64 iopte_flag;
>  	void *ptr = page_address(page) + offset;
>  
> -	iopte_flag = IOPTE_M;
> +	iopte_flag = CBE_IOPTE_M;
>  	switch (direction) {
>  	case DMA_BIDIRECTIONAL:
> -		iopte_flag |= IOPTE_PP_R | IOPTE_PP_W | IOPTE_SO_RW;
> +		iopte_flag |= CBE_IOPTE_PP_R | CBE_IOPTE_PP_W | CBE_IOPTE_SO_RW;
>  		break;
>  	case DMA_TO_DEVICE:
> -		iopte_flag |= IOPTE_PP_R | IOPTE_SO_R;
> +		iopte_flag |= CBE_IOPTE_PP_R | CBE_IOPTE_SO_R;
>  		break;
>  	case DMA_FROM_DEVICE:
> -		iopte_flag |= IOPTE_PP_W | IOPTE_SO_RW;
> +		iopte_flag |= CBE_IOPTE_PP_W | CBE_IOPTE_SO_RW;
>  		break;
>  	default:
>  		/* not happned */
