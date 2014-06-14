Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E8A41A02A8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 17:20:20 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 14 Jun 2014 12:50:15 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 64A87E005B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 12:51:14 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5E7KOpM62324792
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 12:50:24 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5E7KARx031515
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 12:50:11 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH v2 09/10] mm,
 cma: move output param to the end of param list
In-Reply-To: <1402543307-29800-10-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-10-git-send-email-iamjoonsoo.kim@lge.com>
Date: Sat, 14 Jun 2014 12:50:09 +0530
Message-ID: <87tx7oez4m.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joonsoo Kim <iamjoonsoo.kim@lge.com> writes:

> Conventionally, we put output param to the end of param list.
> cma_declare_contiguous() doesn't look like that, so change it.
>
> Additionally, move down cma_areas reference code to the position
> where it is really needed.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

>
> diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
> index 28ec226..97613ea 100644
> --- a/arch/powerpc/kvm/book3s_hv_builtin.c
> +++ b/arch/powerpc/kvm/book3s_hv_builtin.c
> @@ -184,7 +184,7 @@ void __init kvm_cma_reserve(void)
>
>  		align_size = max(kvm_rma_pages << PAGE_SHIFT, align_size);
>  		cma_declare_contiguous(selected_size, 0, 0, align_size,
> -			KVM_CMA_CHUNK_ORDER - PAGE_SHIFT, &kvm_cma, false);
> +			KVM_CMA_CHUNK_ORDER - PAGE_SHIFT, false, &kvm_cma);
>  	}
>  }
>
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index f177f73..bfd4553 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -149,7 +149,7 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>  {
>  	int ret;
>
> -	ret = cma_declare_contiguous(size, base, limit, 0, 0, res_cma, fixed);
> +	ret = cma_declare_contiguous(size, base, limit, 0, 0, fixed, res_cma);
>  	if (ret)
>  		return ret;
>
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index e38efe9..e53eead 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -6,7 +6,7 @@ struct cma;
>  extern int __init cma_declare_contiguous(phys_addr_t size,
>  				phys_addr_t base, phys_addr_t limit,
>  				phys_addr_t alignment, int order_per_bit,
> -				struct cma **res_cma, bool fixed);
> +				bool fixed, struct cma **res_cma);
>  extern struct page *cma_alloc(struct cma *cma, int count, unsigned int align);
>  extern bool cma_release(struct cma *cma, struct page *pages, int count);
>  #endif
> diff --git a/mm/cma.c b/mm/cma.c
> index 01a0713..22a5b23 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -142,8 +142,8 @@ core_initcall(cma_init_reserved_areas);
>   * @limit: End address of the reserved memory (optional, 0 for any).
>   * @alignment: Alignment for the contiguous memory area, should be power of 2
>   * @order_per_bit: Order of pages represented by one bit on bitmap.
> - * @res_cma: Pointer to store the created cma region.
>   * @fixed: hint about where to place the reserved area
> + * @res_cma: Pointer to store the created cma region.
>   *
>   * This function reserves memory from early allocator. It should be
>   * called by arch specific code once the early allocator (memblock or bootmem)
> @@ -156,9 +156,9 @@ core_initcall(cma_init_reserved_areas);
>  int __init cma_declare_contiguous(phys_addr_t size,
>  				phys_addr_t base, phys_addr_t limit,
>  				phys_addr_t alignment, int order_per_bit,
> -				struct cma **res_cma, bool fixed)
> +				bool fixed, struct cma **res_cma)
>  {
> -	struct cma *cma = &cma_areas[cma_area_count];
> +	struct cma *cma;
>  	int ret = 0;
>
>  	pr_debug("%s(size %lx, base %08lx, limit %08lx alignment %08lx)\n",
> @@ -214,6 +214,7 @@ int __init cma_declare_contiguous(phys_addr_t size,
>  	 * Each reserved area must be initialised later, when more kernel
>  	 * subsystems (like slab allocator) are available.
>  	 */
> +	cma = &cma_areas[cma_area_count];
>  	cma->base_pfn = PFN_DOWN(base);
>  	cma->count = size >> PAGE_SHIFT;
>  	cma->order_per_bit = order_per_bit;
> -- 
> 1.7.9.5
