Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qx3hj1xl0zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 16:29:57 +1000 (AEST)
Received: from mail-ob0-x244.google.com (mail-ob0-x244.google.com
 [IPv6:2607:f8b0:4003:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qx3hh51JDz9t6m
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Apr 2016 16:29:56 +1000 (AEST)
Received: by mail-ob0-x244.google.com with SMTP id n2so5289756obo.1
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Apr 2016 23:29:56 -0700 (PDT)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <1461836327-15417-1-git-send-email-mpe@ellerman.id.au>
References: <1461836327-15417-1-git-send-email-mpe@ellerman.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 29 Apr 2016 15:59:35 +0930
Message-ID: <CACPK8XfB7+oDwhxqgOiW0PJEZjoc6fYTz8vohcphQFaL-ao=2g@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Define and use PPC_ELF_ABI_v2
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 28, 2016 at 7:08 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> We're approaching 20 locations where we need to check for ELF ABI v2.
> That's fine, except the logic is a bit awkward, because we have to check
> that _CALL_ELF is defined and then what its value is.
>
> So check it once in asm/types.h and define PPC_ELF_ABI_v2 when ELF ABI
> v2 is detected.
>
> We don't add explicit includes of asm/types.h because it's included
> basically everywhere via compiler.h.

Thank you! I always wondered why we didn't do this.

> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/powerpc/include/asm/code-patching.h | 6 +++---
>  arch/powerpc/include/asm/ftrace.h        | 2 +-
>  arch/powerpc/include/asm/kprobes.h       | 4 ++--
>  arch/powerpc/include/asm/linkage.h       | 2 +-
>  arch/powerpc/include/asm/ppc_asm.h       | 4 ++--
>  arch/powerpc/include/asm/ptrace.h        | 2 +-
>  arch/powerpc/include/asm/sections.h      | 2 +-
>  arch/powerpc/include/asm/types.h         | 4 ++++
>  arch/powerpc/kernel/entry_64.S           | 2 +-
>  arch/powerpc/kernel/head_64.S            | 2 +-
>  arch/powerpc/kernel/kprobes.c            | 2 +-
>  arch/powerpc/kernel/misc_64.S            | 2 +-
>  arch/powerpc/kernel/module_64.c          | 4 ++--
>  arch/powerpc/kvm/book3s_interrupts.S     | 2 +-
>  arch/powerpc/kvm/book3s_rmhandlers.S     | 2 +-
>  15 files changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
> index 994c60a857ce..d325b35315d3 100644
> --- a/arch/powerpc/include/asm/code-patching.h
> +++ b/arch/powerpc/include/asm/code-patching.h
> @@ -50,7 +50,7 @@ void __patch_exception(int exc, unsigned long addr);
>  static inline unsigned long ppc_function_entry(void *func)
>  {
>  #if defined(CONFIG_PPC64)
> -#if defined(_CALL_ELF) && _CALL_ELF == 2
> +#ifdef PPC_ELF_ABI_v2
>         u32 *insn = func;
>
>         /*
> @@ -90,7 +90,7 @@ static inline unsigned long ppc_function_entry(void *func)
>
>  static inline unsigned long ppc_global_function_entry(void *func)
>  {
> -#if defined(CONFIG_PPC64) && defined(_CALL_ELF) && _CALL_ELF == 2
> +#if defined(CONFIG_PPC64) && defined(PPC_ELF_ABI_v2)

The CONFIG_PPC64 is redundant?

>         /* PPC64 ABIv2 the global entry point is at the address */
>         return (unsigned long)func;
>  #else
