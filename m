Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWFn26XwDzDqn3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 22:49:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 aneesh.kumar@linux.vnet.ibm.com <aneesh.kumar@linux.vnet.ibm.com>,
 Suraj Jitindar Singh  <surajjs@ozlabs.au.ibm.com>
Subject: Re: [PATCH v2 3/9] powerpc/powernv: Remove real mode access limit for
 early allocations
In-Reply-To: <20170813013346.14002-3-npiggin@gmail.com>
References: <20170812113416.15978-1-npiggin@gmail.com>
 <20170813013346.14002-3-npiggin@gmail.com>
Date: Mon, 14 Aug 2017 22:49:39 +1000
Message-ID: <87h8xaqpp8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> This removes the RMA limit on powernv platform, which constrains
> early allocations such as PACAs and stacks. There are still other
> restrictions that must be followed, such as bolted SLB limits, but
> real mode addressing has no constraints.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/mm/hash_utils_64.c | 24 +++++++++++++++---------
>  arch/powerpc/mm/pgtable-radix.c | 33 +++++++++++++++++----------------

I missed that we'd duplicated this logic for radix vs hash [yes I know I
merged the commit that did it :)]

> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 671a45d86c18..61ca17d81737 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -598,22 +598,23 @@ void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
>  	 * physical on those processors
>  	 */
>  	BUG_ON(first_memblock_base != 0);
> -	/*
> -	 * We limit the allocation that depend on ppc64_rma_size
> -	 * to first_memblock_size. We also clamp it to 1GB to
> -	 * avoid some funky things such as RTAS bugs.

That comment about RTAS is 7 years old, and I'm pretty sure it was a
historical note when it was written.

I'm inclined to drop it and if we discover new bugs with RTAS on Power9
then we can always put it back.

> -	 *
> -	 * On radix config we really don't have a limitation
> -	 * on real mode access. But keeping it as above works
> -	 * well enough.

Ergh.

> -	 */
> -	ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
> -	/*
> -	 * Finally limit subsequent allocations. We really don't want
> -	 * to limit the memblock allocations to rma_size. FIXME!! should
> -	 * we even limit at all ?
> -	 */

So I think we should just delete this function entirely.

Any objections?

cheers
