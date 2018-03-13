Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400tr0301SzDrBW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 23:06:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: akpm@linux-foundation.org, mhocko@suse.com, catalin.marinas@arm.com,
 pasha.tatashin@oracle.com, takahiro.akashi@linaro.org,
 gi-oh.kim@profitbricks.com, npiggin@gmail.com, baiyaowei@cmss.chinamobile.com,
 bob.picco@oracle.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: OK to merge via powerpc? (was Re: [PATCH 05/14] mm: make
 memblock_alloc_base_nid non-static)
In-Reply-To: <20180213150824.27689-6-npiggin@gmail.com>
References: <20180213150824.27689-1-npiggin@gmail.com>
 <20180213150824.27689-6-npiggin@gmail.com>
Date: Tue, 13 Mar 2018 23:06:35 +1100
Message-ID: <873714goxg.fsf@concordia.ellerman.id.au>
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

Anyone object to us merging the following patch via the powerpc tree?

Full series is here if anyone's interested:
  http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=28377&state=*

cheers

Nicholas Piggin <npiggin@gmail.com> writes:
> This will be used by powerpc to allocate per-cpu stacks and other
> data structures node-local where possible.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  include/linux/memblock.h | 5 ++++-
>  mm/memblock.c            | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 8be5077efb5f..8cab51398705 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -316,9 +316,12 @@ static inline bool memblock_bottom_up(void)
>  #define MEMBLOCK_ALLOC_ANYWHERE	(~(phys_addr_t)0)
>  #define MEMBLOCK_ALLOC_ACCESSIBLE	0
>  
> -phys_addr_t __init memblock_alloc_range(phys_addr_t size, phys_addr_t align,
> +phys_addr_t memblock_alloc_range(phys_addr_t size, phys_addr_t align,
>  					phys_addr_t start, phys_addr_t end,
>  					ulong flags);
> +phys_addr_t memblock_alloc_base_nid(phys_addr_t size,
> +					phys_addr_t align, phys_addr_t max_addr,
> +					int nid, ulong flags);
>  phys_addr_t memblock_alloc_base(phys_addr_t size, phys_addr_t align,
>  				phys_addr_t max_addr);
>  phys_addr_t __memblock_alloc_base(phys_addr_t size, phys_addr_t align,
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 5a9ca2a1751b..cea2af494da0 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1190,7 +1190,7 @@ phys_addr_t __init memblock_alloc_range(phys_addr_t size, phys_addr_t align,
>  					flags);
>  }
>  
> -static phys_addr_t __init memblock_alloc_base_nid(phys_addr_t size,
> +phys_addr_t __init memblock_alloc_base_nid(phys_addr_t size,
>  					phys_addr_t align, phys_addr_t max_addr,
>  					int nid, ulong flags)
>  {
> -- 
> 2.16.1
