Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 800BC2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 20:35:19 +1000 (EST)
Message-ID: <1375785310.12557.61.camel@pasglop>
Subject: Re: [PATCH 1/3] powerpc: move the testing of
 CPU_FTR_COHERENT_ICACHE into __flush_icache_range
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Tue, 06 Aug 2013 20:35:10 +1000
In-Reply-To: <1375784612-14399-2-git-send-email-haokexin@gmail.com>
References: <1375784612-14399-1-git-send-email-haokexin@gmail.com>
 <1375784612-14399-2-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-08-06 at 18:23 +0800, Kevin Hao wrote:
> In function flush_icache_range(), we use cpu_has_feature() to test
> the feature bit of CPU_FTR_COHERENT_ICACHE. But this seems not optimal
> for two reasons:
>  a) For ppc32, the function __flush_icache_range() already do this
>     check with the macro END_FTR_SECTION_IFSET.
>  b) Compare with the cpu_has_feature(), the method of using macro
>     END_FTR_SECTION_IFSET will not introduce any runtime overhead.

Nak.

It adds the overhead of calling into a function :-)

What about modifying cpu_has_feature to use jump labels ? It might solve
the problem of no runtime overhead ... however it might also be hard to
keep the ability to remove the whole statement at compile time if the
bit doesn't fit in the POSSIBLE mask... unless you find the right macro
magic.

In any case, I suspect the function call introduces more overhead than
the bit test + conditional branch which will generally predict very
well, so the patch as-is is probably a regression.

Did you measure ?

Ben.


> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  arch/powerpc/include/asm/cacheflush.h | 3 +--
>  arch/powerpc/kernel/misc_64.S         | 4 +++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
> index b843e35..60b620d 100644
> --- a/arch/powerpc/include/asm/cacheflush.h
> +++ b/arch/powerpc/include/asm/cacheflush.h
> @@ -35,8 +35,7 @@ extern void __flush_disable_L1(void);
>  extern void __flush_icache_range(unsigned long, unsigned long);
>  static inline void flush_icache_range(unsigned long start, unsigned long stop)
>  {
> -	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
> -		__flush_icache_range(start, stop);
> +	__flush_icache_range(start, stop);
>  }
>  
>  extern void flush_icache_user_range(struct vm_area_struct *vma,
> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
> index 6820e45..74d87f1 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -68,7 +68,9 @@ PPC64_CACHES:
>   */
>  
>  _KPROBE(__flush_icache_range)
> -
> +BEGIN_FTR_SECTION
> +	blr
> +END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
>  /*
>   * Flush the data cache to memory 
>   * 
