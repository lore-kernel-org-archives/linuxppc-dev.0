Return-Path: <labbott@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B0C91A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 07:51:15 +1000 (AEST)
Subject: Re: [RFC] genalloc:add an gen_pool_alloc_align func to genalloc
To: Zhao Qiang <B45475@freescale.com>, lauraa@codeaurora.org
References: <1436428063-893-1-git-send-email-B45475@freescale.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, olof@lixom.net, catalin.marinas@arm.com,
 scottwood@freescale.com, X.xie@freescale.com
From: Laura Abbott <labbott@redhat.com>
Message-ID: <559EECCF.6060702@redhat.com>
Date: Thu, 9 Jul 2015 14:51:11 -0700
MIME-Version: 1.0
In-Reply-To: <1436428063-893-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2015 12:47 AM, Zhao Qiang wrote:
> Bytes alignment is required to manage some special ram,
> so add gen_pool_alloc_align func to genalloc.
> rename gen_pool_alloc to gen_pool_alloc_align with a align parameter,
> then provide gen_pool_alloc to call gen_pool_alloc_align with
> align = 1 Byte.
>
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> FSL's IP block QE require this function to manage muram.
> QE supported only PowerPC, and its code was put under arch/powerpc directory,
> using arch/powerpc/lib/rheap.c to manage muram.
> Now it support both arm(ls1021,ls1043,ls2085 and such on) and powerpc,
> the code need to move from arch/powerpc to public direcory,
> Scott wood hopes to use genalloc to manage the muram, after discussing
> with scott, we decide to add gen_pool_alloc_align to meet the requirement
> for bytes-alignment.

gen_pool supports custom allocation algorithms. I thought this was discussed
previously and the conclusion was that if you wanted alignment you should
use custom allocation algorithms. I'm failing at finding any thread discussing
it though.

Perhaps another option would be to add another runtime argument to gen_pool
where you could pass the alignment to your custom allocation function. This
way alignment isn't inherently coded into any of the algorithms.

>
>   include/linux/genalloc.h | 10 +++++++---
>   lib/genalloc.c           | 38 ++++++++++++++++++++++++++++++--------
>   2 files changed, 37 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
> index 1ccaab4..65fdf14 100644
> --- a/include/linux/genalloc.h
> +++ b/include/linux/genalloc.h
> @@ -96,6 +96,8 @@ static inline int gen_pool_add(struct gen_pool *pool, unsigned long addr,
>   }
>   extern void gen_pool_destroy(struct gen_pool *);
>   extern unsigned long gen_pool_alloc(struct gen_pool *, size_t);
> +extern unsigned long gen_pool_alloc_align(struct gen_pool *, size_t,
> +		unsigned long align);
>   extern void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size,
>   		dma_addr_t *dma);
>   extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
> @@ -108,14 +110,16 @@ extern void gen_pool_set_algo(struct gen_pool *pool, genpool_algo_t algo,
>   		void *data);
>
>   extern unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
> -		unsigned long start, unsigned int nr, void *data);
> +		unsigned long start, unsigned int nr, void *data,
> +		unsigned long align_mask);
>
>   extern unsigned long gen_pool_first_fit_order_align(unsigned long *map,
>   		unsigned long size, unsigned long start, unsigned int nr,
> -		void *data);
> +		void *data, unsigned long align_mask);
>
>   extern unsigned long gen_pool_best_fit(unsigned long *map, unsigned long size,
> -		unsigned long start, unsigned int nr, void *data);
> +		unsigned long start, unsigned int nr, void *data,
> +		unsigned long align_mask);
>
>   extern struct gen_pool *devm_gen_pool_create(struct device *dev,
>   		int min_alloc_order, int nid);
> diff --git a/lib/genalloc.c b/lib/genalloc.c
> index d214866..dd63448 100644
> --- a/lib/genalloc.c
> +++ b/lib/genalloc.c
> @@ -258,19 +258,22 @@ void gen_pool_destroy(struct gen_pool *pool)
>   EXPORT_SYMBOL(gen_pool_destroy);
>
>   /**
> - * gen_pool_alloc - allocate special memory from the pool
> + * gen_pool_alloc_align - allocate special memory from the pool
>    * @pool: pool to allocate from
>    * @size: number of bytes to allocate from the pool
> + * @align: number of bytes to align
>    *
>    * Allocate the requested number of bytes from the specified pool.
>    * Uses the pool allocation function (with first-fit algorithm by default).
>    * Can not be used in NMI handler on architectures without
>    * NMI-safe cmpxchg implementation.
>    */
> -unsigned long gen_pool_alloc(struct gen_pool *pool, size_t size)
> +unsigned long gen_pool_alloc_align(struct gen_pool *pool, size_t size,
> +		unsigned long align)
>   {
>   	struct gen_pool_chunk *chunk;
>   	unsigned long addr = 0;
> +	unsigned long align_mask;
>   	int order = pool->min_alloc_order;
>   	int nbits, start_bit = 0, end_bit, remain;
>
> @@ -281,6 +284,7 @@ unsigned long gen_pool_alloc(struct gen_pool *pool, size_t size)
>   	if (size == 0)
>   		return 0;
>
> +	align_mask = ((align + (1UL << order) - 1) >> order) - 1;
>   	nbits = (size + (1UL << order) - 1) >> order;
>   	rcu_read_lock();
>   	list_for_each_entry_rcu(chunk, &pool->chunks, next_chunk) {
> @@ -290,7 +294,7 @@ unsigned long gen_pool_alloc(struct gen_pool *pool, size_t size)
>   		end_bit = chunk_size(chunk) >> order;
>   retry:
>   		start_bit = pool->algo(chunk->bits, end_bit, start_bit, nbits,
> -				pool->data);
> +				pool->data, align_mask);
>   		if (start_bit >= end_bit)
>   			continue;
>   		remain = bitmap_set_ll(chunk->bits, start_bit, nbits);
> @@ -309,6 +313,22 @@ retry:
>   	rcu_read_unlock();
>   	return addr;
>   }
> +EXPORT_SYMBOL(gen_pool_alloc_align);
> +
> +/**
> + * gen_pool_alloc - allocate special memory from the pool
> + * @pool: pool to allocate from
> + * @size: number of bytes to allocate from the pool
> + *
> + * Allocate the requested number of bytes from the specified pool.
> + * Uses the pool allocation function (with first-fit algorithm by default).
> + * Can not be used in NMI handler on architectures without
> + * NMI-safe cmpxchg implementation.
> + */
> +unsigned long gen_pool_alloc(struct gen_pool *pool, size_t size)
> +{
> +	return gen_pool_alloc_align(pool, size, 1);

Passing 1 here would change the behavior of the existing algorithms which
were passing 0 for the align mask

> +}
>   EXPORT_SYMBOL(gen_pool_alloc);
>
>   /**
> @@ -502,9 +522,10 @@ EXPORT_SYMBOL(gen_pool_set_algo);
>    * @data: additional data - unused
>    */
>   unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
> -		unsigned long start, unsigned int nr, void *data)
> +		unsigned long start, unsigned int nr, void *data,
> +		unsigned long align_mask)
>   {
> -	return bitmap_find_next_zero_area(map, size, start, nr, 0);
> +	return bitmap_find_next_zero_area(map, size, start, nr, align_mask);
>   }
>   EXPORT_SYMBOL(gen_pool_first_fit);
>
> @@ -520,7 +541,7 @@ EXPORT_SYMBOL(gen_pool_first_fit);
>    */
>   unsigned long gen_pool_first_fit_order_align(unsigned long *map,
>   		unsigned long size, unsigned long start,
> -		unsigned int nr, void *data)
> +		unsigned int nr, void *data, unsigned long align_mask)
>   {
>   	unsigned long align_mask = roundup_pow_of_two(nr) - 1;
>
> @@ -541,13 +562,14 @@ EXPORT_SYMBOL(gen_pool_first_fit_order_align);
>    * which we can allocate the memory.
>    */
>   unsigned long gen_pool_best_fit(unsigned long *map, unsigned long size,
> -		unsigned long start, unsigned int nr, void *data)
> +				unsigned long start, unsigned int nr,
> +				void *data, unsigned long align_mask)
>   {
>   	unsigned long start_bit = size;
>   	unsigned long len = size + 1;
>   	unsigned long index;
>
> -	index = bitmap_find_next_zero_area(map, size, start, nr, 0);
> +	index = bitmap_find_next_zero_area(map, size, start, nr, align_mask);
>
>   	while (index < size) {
>   		int next_bit = find_next_bit(map, size, index + nr);
>

Thanks,
Laura
