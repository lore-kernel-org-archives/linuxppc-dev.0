Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vn88j4XryzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 08:24:21 +1100 (AEDT)
Message-ID: <1490045009.2504.36.camel@kernel.crashing.org>
Subject: Re: Optimised memset64/memset32 for powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Wilcox <willy@infradead.org>, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 21 Mar 2017 08:23:29 +1100
In-Reply-To: <20170320211447.GB5073@bombadil.infradead.org>
References: <20170320211447.GB5073@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-03-20 at 14:14 -0700, Matthew Wilcox wrote:
> I recently introduced memset32() / memset64().  I've done implementations
> for x86 & ARM; akpm has agreed to take the patchset through his tree.
> Do you fancy doing a powerpc version?  Minchan Kim got a 7% performance
> increase with zram from switching to the optimised version on x86.

+Anton

Thanks Matthew !

> Here's the development git tree:
> http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/memfill
> (most recent 7 commits)
> 
> ARM probably offers the best model for you to work from; it's basically
> just a case of jumping into the middle of your existing memset loop.
> It was only three instructions to add support to ARM, but I don't know
> PowerPC well enough to understand how your existing memset works.
> I'd start with something like this ... note that you don't have to
> implement memset64 on 32-bit; I only did it on ARM because it was free.
> It doesn't look free for you as you only store one register each time
> around the loop in the 32-bit memset implementation:
> 
> 1:      stwu    r4,4(r6)
>         bdnz    1b
> 
> (wouldn't you get better performance on 32-bit powerpc by unrolling that
> loop like you do on 64-bit?)
> 
> diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
> index da3cdffca440..c02392fced98 100644
> --- a/arch/powerpc/include/asm/string.h
> +++ b/arch/powerpc/include/asm/string.h
> @@ -6,6 +6,7 @@
>  #define __HAVE_ARCH_STRNCPY
>  #define __HAVE_ARCH_STRNCMP
>  #define __HAVE_ARCH_MEMSET
> +#define __HAVE_ARCH_MEMSET_PLUS
>  #define __HAVE_ARCH_MEMCPY
>  #define __HAVE_ARCH_MEMMOVE
>  #define __HAVE_ARCH_MEMCMP
> @@ -23,6 +24,18 @@ extern void * memmove(void *,const void *,__kernel_size_t);
>  extern int memcmp(const void *,const void *,__kernel_size_t);
>  extern void * memchr(const void *,int,__kernel_size_t);
>  
> +extern void *__memset32(uint32_t *, uint32_t v, __kernel_size_t);
> +static inline void *memset32(uint32_t *p, uint32_t v, __kernel_size_t n)
> +{
> > +	return __memset32(p, v, n * 4);
> +}
> +
> +extern void *__memset64(uint64_t *, uint64_t v, __kernel_size_t);
> +static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
> +{
> > +	return __memset64(p, v, n * 8);
> +}
> +
>  #endif /* __KERNEL__ */
>  
> >  #endif	/* _ASM_POWERPC_STRING_H */
