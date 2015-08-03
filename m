Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0136.outbound.protection.outlook.com [157.56.111.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D82AC1A0133
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 09:18:54 +1000 (AEST)
Message-ID: <1438643915.2097.71.camel@freescale.com>
Subject: Re: [RFC v3] genalloc:support memory-allocation with
 bytes-alignment to genalloc
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <qiang.zhao@freescale.com>
CC: <lauraa@codeaurora.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <akpm@linux-foundation.org>,
 <olof@lixom.net>, <catalin.marinas@arm.com>, <X.xie@freescale.com>
Date: Mon, 3 Aug 2015 18:18:35 -0500
In-Reply-To: <1438590921-49116-1-git-send-email-qiang.zhao@freescale.com>
References: <1438590921-49116-1-git-send-email-qiang.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-08-03 at 16:35 +0800, Zhao Qiang wrote:
> 
> @@ -73,6 +74,13 @@ struct gen_pool_chunk {
>       unsigned long bits[0];          /* bitmap for allocating memory chunk */
>  };
>  
> +/*
> + *  General purpose special memory pool data descriptor.
> + */

It's not "general purpose".  It's for gen_pool_first_fit_align (and could be 
reused by any future algorithms that need alignment but nothing else).

> +struct data_align {
> +     int align;              /* alignment by bytes for starting address */
> +};

struct genpool_data_align


> diff --git a/lib/genalloc.c b/lib/genalloc.c
> index d214866..e0b737c 100644
> --- a/lib/genalloc.c
> +++ b/lib/genalloc.c
> @@ -269,6 +269,24 @@ EXPORT_SYMBOL(gen_pool_destroy);
>   */
>  unsigned long gen_pool_alloc(struct gen_pool *pool, size_t size)
>  {
> +     return gen_pool_alloc_data(pool, size, NULL);
> +}
> +EXPORT_SYMBOL(gen_pool_alloc);

This should pass in pool->data, not NULL.

> +
> +/**
> + * gen_pool_alloc_data - allocate special memory from the pool
> + * @pool: pool to allocate from
> + * @size: number of bytes to allocate from the pool
> + * @data: data passed to algorithm
> + *
> + * Allocate the requested number of bytes from the specified pool.
> + * Uses the pool allocation function (with first-fit algorithm by default).
> + * Can not be used in NMI handler on architectures without
> + * NMI-safe cmpxchg implementation.
> + */
> +unsigned long gen_pool_alloc_data(struct gen_pool *pool, size_t size,
> +             void *data)
> +{
>       struct gen_pool_chunk *chunk;
>       unsigned long addr = 0;
>       int order = pool->min_alloc_order;
> @@ -290,7 +308,7 @@ unsigned long gen_pool_alloc(struct gen_pool *pool, 
> size_t size)
>               end_bit = chunk_size(chunk) >> order;
>  retry:
>               start_bit = pool->algo(chunk->bits, end_bit, start_bit, nbits,
> -                             pool->data);
> +                             pool->data, pool);


This should pass in data, not pool->data.  Currently you don't use the data 
argument at all.


> +unsigned long gen_pool_first_fit_align(unsigned long *map, unsigned long 
> size,
> +             unsigned long start, unsigned int nr, void *data,
> +             struct gen_pool *pool)
> +{
> +     struct data_align *alignment;
> +     unsigned long align_mask;
> +     int order;
> +
> +     if (data == NULL)
> +             return -EINVAL;

Unnecessary check.  If this happens it will happen quickly on the developer's 
machine, so let it oops and be obvious.

> +
> +     alignment = (struct data_align *)data;

Unnecessary cast.

-Scott
