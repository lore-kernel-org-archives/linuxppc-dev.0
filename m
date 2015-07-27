Return-Path: <vz@mleia.com>
Received: from mail.mleia.com (li271-223.members.linode.com [178.79.152.223])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 58D9B1A0061
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 02:49:17 +1000 (AEST)
Message-ID: <55B66103.2020403@mleia.com>
Date: Mon, 27 Jul 2015 19:49:07 +0300
From: Vladimir Zapolskiy <vz@mleia.com>
MIME-Version: 1.0
To: Zhao Qiang <qiang.zhao@freescale.com>
CC: lauraa@codeaurora.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, scottwood@freescale.com, olof@lixom.net,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 X.xie@freescale.com
Subject: Re: [RFC v2] genalloc:add an gen_pool_first_fit_align algo to genalloc
References: <1437991074-35377-1-git-send-email-qiang.zhao@freescale.com>
In-Reply-To: <1437991074-35377-1-git-send-email-qiang.zhao@freescale.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Zhao,

On 27.07.2015 12:57, Zhao Qiang wrote:
> Bytes alignment is required to manage some special ram,
> so add gen_pool_first_fit_align to genalloc.
> User should define data structure
> struct data {
> 	int align;
> 	struct gen_pool *pool;
> }
> align is the number of  bytes alignment,
> pool points to gen_pool which include data.
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
> ---
> *v2:
> changes:
> title has been modified, original patch link: 
> http://patchwork.ozlabs.org/patch/493297/
> 
> original patch add a func gen_pool_alloc_align, 
> then pass alignment to it as an parameter.
> after discussing with lauraa and scott, they recommend 
> to pass alignment as part of data based on 
> commit message for ca279cf1065fb689abea1dc7d8c11787729bb185 which adds "data":
> 
> "As I can't predict all the possible requirements/needs for all allocation    
> uses cases, I add a "free" field 'void *data' to pass any needed     
> information to the allocation function.  For example 'data' could be used     
> to handle a structure where you store the alignment, the expected memory     
> bank, the requester device, or any information that could influence the     
> allocation algorithm."
> 
> 
> 
> 
>  include/linux/genalloc.h |  4 ++++
>  lib/genalloc.c           | 25 +++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
> index 1ccaab4..b85d0f8 100644
> --- a/include/linux/genalloc.h
> +++ b/include/linux/genalloc.h
> @@ -110,6 +110,10 @@ extern void gen_pool_set_algo(struct gen_pool *pool, genpool_algo_t algo,
>  extern unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
>  		unsigned long start, unsigned int nr, void *data);
>  
> +extern unsigned long gen_pool_first_fit_align(unsigned long *map,
> +		unsigned long size, unsigned long start, unsigned int nr,
> +		void *data);
> +
>  extern unsigned long gen_pool_first_fit_order_align(unsigned long *map,
>  		unsigned long size, unsigned long start, unsigned int nr,
>  		void *data);
> diff --git a/lib/genalloc.c b/lib/genalloc.c
> index d214866..e6608cd 100644
> --- a/lib/genalloc.c
> +++ b/lib/genalloc.c
> @@ -509,6 +509,31 @@ unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
>  EXPORT_SYMBOL(gen_pool_first_fit);
>  
>  /**
> + * gen_pool_first_fit_align - find the first available region
> + * of memory matching the size requirement (no alignment constraint)

no alignment constraint?

> + * @map: The address to base the search on
> + * @size: The bitmap size in bits
> + * @start: The bitnumber to start searching at
> + * @nr: The number of zeroed bits we're looking for
> + * @data: additional data - unused

unused?

> + */
> +unsigned long gen_pool_first_fit_align(unsigned long *map, unsigned long size,
> +		unsigned long start, unsigned int nr, void *data)
> +{
> +	unsigned long align_mask;
> +	int order;
> +
> +	if (data && data->pool) {

"data" type is (void *), missing cast?

> +		order = data->pool->min_alloc_order;
> +		align_mask = ((data->align + (1UL << order) - 1) >> order) - 1;
> +	} else {
> +		pr_err("no data or data->pool\n");
> +	}
> +	return bitmap_find_next_zero_area(map, size, start, nr, align_mask);

You may end up in a situation, when align_mask is undefined, I believe
bitmap_find_next_zero_area() should not be called on error path.

> +}
> +EXPORT_SYMBOL(gen_pool_first_fit_algin);
> +
> +/**
>   * gen_pool_first_fit_order_align - find the first available region
>   * of memory matching the size requirement. The region will be aligned
>   * to the order of the size specified.
> 

--
With best wishes,
Vladimir
