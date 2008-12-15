Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [93.163.65.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "A common name", Issuer "A common name" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 18FBADDF25
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Dec 2008 18:55:43 +1100 (EST)
Date: Mon, 15 Dec 2008 08:28:30 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [RESEND] [PATCH] powerpc: remove dead BIO_VMERGE_BOUNDARY
	definition
Message-ID: <20081215072830.GQ23742@kernel.dk>
References: <20081214124508U.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081214124508U.fujita.tomonori@lab.ntt.co.jp>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 14 2008, FUJITA Tomonori wrote:
> This is a resend of:
> 
> http://marc.info/?l=linux-kernel&m=122482703616607&w=2
> 
> =
> From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Subject: [PATCH] powerpc: remove dead BIO_VMERGE_BOUNDARY definition
> 
> The block layer dropped the virtual merge feature
> (b8b3e16cfe6435d961f6aaebcfd52a1ff2a988c5). BIO_VMERGE_BOUNDARY
> definition is meaningless now (For POWER, BIO_VMERGE_BOUNDARY has been
> meaningless for a long time since POWER disables the virtual merge
> feature).
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Acked-by: Jens Axboe <jens.axboe@oracle.com>

> ---
>  arch/powerpc/include/asm/io.h |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index 08266d2..494cd8b 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -713,13 +713,6 @@ static inline void * phys_to_virt(unsigned long address)
>   */
>  #define page_to_phys(page)	((phys_addr_t)page_to_pfn(page) << PAGE_SHIFT)
>  
> -/* We do NOT want virtual merging, it would put too much pressure on
> - * our iommu allocator. Instead, we want drivers to be smart enough
> - * to coalesce sglists that happen to have been mapped in a contiguous
> - * way by the iommu
> - */
> -#define BIO_VMERGE_BOUNDARY	0
> -
>  /*
>   * 32 bits still uses virt_to_bus() for it's implementation of DMA
>   * mappings se we have to keep it defined here. We also have some old
> -- 
> 1.5.5.GIT
> 

-- 
Jens Axboe
