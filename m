Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E743167A2E
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Jul 2006 09:13:32 +1000 (EST)
Subject: Re: [PATCH] powerpc:Fix rheap alignment problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E04FF6@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306E04FF6@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 09:13:13 +1000
Message-Id: <1151709194.27137.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, 'Paul Mackerras' <paulus@samba.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-06-30 at 21:02 +0800, Li Yang-r58472 wrote:
> Honour alignment parameter in the rheap allocator.
> Remove compile warning.

What is this used for ? This rheap allocator ? I see no user in
arch/powerpc at least and only two users apparently in arch/ppc... are
we sure we need something that complex for these ? Can't we just use a
running bitmap allocator or an idr ?

Cheers,
Ben.

> Signed-off-by: Pantelis Antoniou <pantelis@embeddedalley.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> 
> ---
>  arch/powerpc/lib/Makefile |    1 +
>  arch/powerpc/lib/rheap.c  |   24 ++++++++++++++++++++----
>  include/asm-ppc/rheap.h   |    4 ++++
>  3 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index 34f5c2e..136a892 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -11,6 +11,7 @@ obj-y			+= bitops.o
>  obj-$(CONFIG_PPC64)	+= checksum_64.o copypage_64.o copyuser_64.o \
>  			   memcpy_64.o usercopy_64.o mem_64.o string.o \
>  			   strcase.o
> +obj-$(CONFIG_QUICC_ENGINE) += rheap.o
>  obj-$(CONFIG_PPC_ISERIES) += e2a.o
>  obj-$(CONFIG_XMON)	+= sstep.o
>  
> diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
> index 31e5118..57bf991 100644
> --- a/arch/powerpc/lib/rheap.c
> +++ b/arch/powerpc/lib/rheap.c
> @@ -423,17 +423,21 @@ void *rh_detach_region(rh_info_t * info,
>  	return (void *)s;
>  }
>  
> -void *rh_alloc(rh_info_t * info, int size, const char *owner)
> +void *rh_alloc_align(rh_info_t * info, int size, int alignment, const char *owner)
>  {
>  	struct list_head *l;
>  	rh_block_t *blk;
>  	rh_block_t *newblk;
>  	void *start;
>  
> -	/* Validate size */
> -	if (size <= 0)
> +	/* Validate size, (must be power of two) */
> +	if (size <= 0 || (alignment & (alignment - 1)) != 0)
>  		return ERR_PTR(-EINVAL);
>  
> +	/* given alignment larger that default rheap alignment */
> +	if (alignment > info->alignment)
> +		size += alignment - 1;
> +
>  	/* Align to configured alignment */
>  	size = (size + (info->alignment - 1)) & ~(info->alignment - 1);
>  
> @@ -476,15 +480,27 @@ void *rh_alloc(rh_info_t * info, int siz
>  
>  	attach_taken_block(info, newblk);
>  
> +	/* for larger alignment return fixed up pointer  */
> +	/* this is no problem with the deallocator since */
> +	/* we scan for pointers that lie in the blocks   */
> +	if (alignment > info->alignment)
> +		start = (void *)(((unsigned long)start + alignment - 1) &
> +				~(alignment - 1));
> +
>  	return start;
>  }
>  
> +void *rh_alloc(rh_info_t * info, int size, const char *owner)
> +{
> +	return rh_alloc_align(info, size, info->alignment, owner);
> +}
> +
>  /* allocate at precisely the given address */
>  void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
>  {
>  	struct list_head *l;
>  	rh_block_t *blk, *newblk1, *newblk2;
> -	unsigned long s, e, m, bs, be;
> +	unsigned long s, e, m, bs = 0, be = 0;
>  
>  	/* Validate size */
>  	if (size <= 0)
> diff --git a/include/asm-ppc/rheap.h b/include/asm-ppc/rheap.h
> index e6ca1f6..65b9322 100644
> --- a/include/asm-ppc/rheap.h
> +++ b/include/asm-ppc/rheap.h
> @@ -62,6 +62,10 @@ extern int rh_attach_region(rh_info_t * 
>  /* Detach a free region */
>  extern void *rh_detach_region(rh_info_t * info, void *start, int size);
>  
> +/* Allocate the given size from the remote heap (with alignment) */
> +extern void *rh_alloc_align(rh_info_t * info, int size, int alignment,
> +		const char *owner);
> +
>  /* Allocate the given size from the remote heap */
>  extern void *rh_alloc(rh_info_t * info, int size, const char *owner);
> 
> --
> Leo Li
> Freescale Semiconductor
> 
> LeoLi@freescale.com 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
