Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (unknown [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y74ff6kRGzDr5H
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 18:49:30 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: Default to enabling STRICT_KERNEL_RWX
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <20171005034505.GA32157@beast>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <6e6bf9ba-d66c-0bcc-358e-fed97b2ca5cd@c-s.fr>
Date: Thu, 5 Oct 2017 09:49:06 +0200
MIME-Version: 1.0
In-Reply-To: <20171005034505.GA32157@beast>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 05/10/2017 à 05:45, Kees Cook a écrit :
> When available, CONFIG_KERNEL_RWX should be default-enabled.

On PPC32, this option implies deactivating BATs and/or LTLB mapping of 
the linear kernel address space, hence a significant performance 
degradation.

So at least on PPC32, it should remain unselected by default.

Christophe

> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   arch/powerpc/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 809c468edab1..9a549bbfc278 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -178,6 +178,7 @@ config PPC
>   	select HAVE_ARCH_TRACEHOOK
>   	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
>   	select ARCH_OPTIONAL_KERNEL_RWX		if ARCH_HAS_STRICT_KERNEL_RWX
> +	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
>   	select HAVE_CBPF_JIT			if !PPC64
>   	select HAVE_CONTEXT_TRACKING		if PPC64
>   	select HAVE_DEBUG_KMEMLEAK
> 
