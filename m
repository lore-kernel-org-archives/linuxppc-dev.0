Return-Path: <srs0=xuo0=lm=gmail.com=nicholas.piggin@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420dZN5jWQzF2QL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 18:09:32 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 420dZN4PkHz8t44
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 18:09:32 +1000 (AEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 420dZM6fkKz9s3Z
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2018 18:09:31 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id b11-v6so1934548pfo.3
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2018 01:09:31 -0700 (PDT)
Date: Wed, 29 Aug 2018 18:09:12 +1000
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linuxppc-dev@ozlabs.org, schwab@linux-m68k.org, jeyu@kernel.org,
 mpe@ellerman.id.au, will.deacon@arm.com, mingo@kernel.org,
 akpm@linux-foundation.org, linux-arch@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH] powerpc: disable support for relative ksymtab references
Message-ID: <20180829180912.7a7b39a6@roar.ozlabs.ibm.com>
In-Reply-To: <20180829064753.7133-1-ard.biesheuvel@linaro.org>
References: <20180829064753.7133-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 29 Aug 2018 08:47:53 +0200
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> The newly added code that emits ksymtab entries as pairs of 32-bit
> relative references interacts poorly with the way powerpc lays out
> its address space: when a module exports a per-CPU variable, the
> primary module region covering the ksymtab entry -and thus the 32-bit
> relative reference- is too far away from the actual per-CPU variable's
> base address (to which the per-CPU offsets are applied to obtain the
> respective address of each CPU's copy), resulting in corruption when
> the module loader attempts to resolve symbol references of modules
> that are loaded on top and link to the exported per-CPU symbol.
> 
> So let's disable this feature on powerpc. Even though it implements
> CONFIG_RELOCATABLE, it does not implement CONFIG_RANDOMIZE_BASE and
> so KASLR kernels (which are the main target of the feature) do not
> exist on powerpc anyway.

Let's go with this for now. We have a bit more work to do with module
loader, linker, percpu, or all of the above. Thanks everyone.

Linus can you merge this? I think Michael is on vacation this week and
things are pretty crashy without it here. Don't need to call him off
the beach for it.

Thanks,
Nick

> 
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Suggested-by: Nicholas Piggin <nicholas.piggin@gmail.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/powerpc/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index db0b6eebbfa5..a80669209155 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -177,7 +177,6 @@ config PPC
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_MMAP_RND_BITS
>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
> -	select HAVE_ARCH_PREL32_RELOCATIONS
>  	select HAVE_ARCH_SECCOMP_FILTER
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_CBPF_JIT			if !PPC64
> -- 
> 2.17.1
> 
