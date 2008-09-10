Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1B68CDDE98
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 10:09:54 +1000 (EST)
Subject: Re: [PATCH] fix compile failure with non modular builds
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <1221005058.23271.16.camel@localhost.localdomain>
References: <1221005058.23271.16.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 10 Sep 2008 10:09:47 +1000
Message-Id: <1221005387.14835.14.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-09 at 19:04 -0500, James Bottomley wrote:
> commit deac93df26b20cf8438339b5935b5f5643bc30c9
> Author: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date:   Wed Sep 3 20:43:36 2008 -0500
> 
>     lib: Correct printk %pF to work on all architectures
> 
> Broke the non modular builds by moving an essential function into
> modules.c.  Fix this by moving it out again and into asm/sections.h as
> an inline.  To do this, the definition of struct ppc64_opd_entry has
> been lifted out of modules.c and put in asm/elf.h where it belongs.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Ouch. Ack.

Ben.

> ---
> diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
> index 80d1f39..64c6ee2 100644
> --- a/arch/powerpc/include/asm/elf.h
> +++ b/arch/powerpc/include/asm/elf.h
> @@ -409,6 +409,13 @@ do {									\
>  /* Keep this the last entry.  */
>  #define R_PPC64_NUM		107
>  
> +/* There's actually a third entry here, but it's unused */
> +struct ppc64_opd_entry
> +{
> +	unsigned long funcaddr;
> +	unsigned long r2;
> +};
> +
>  #ifdef  __KERNEL__
>  
>  #ifdef CONFIG_SPU_BASE
> diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
> index 7710e9e..07956f3 100644
> --- a/arch/powerpc/include/asm/sections.h
> +++ b/arch/powerpc/include/asm/sections.h
> @@ -2,6 +2,8 @@
>  #define _ASM_POWERPC_SECTIONS_H
>  #ifdef __KERNEL__
>  
> +#include <linux/elf.h>
> +#include <linux/uaccess.h>
>  #include <asm-generic/sections.h>
>  
>  #ifdef __powerpc64__
> @@ -17,7 +19,15 @@ static inline int in_kernel_text(unsigned long addr)
>  }
>  
>  #undef dereference_function_descriptor
> -void *dereference_function_descriptor(void *);
> +static inline void *dereference_function_descriptor(void *ptr)
> +{
> +	struct ppc64_opd_entry *desc = ptr;
> +	void *p;
> +
> +	if (!probe_kernel_address(&desc->funcaddr, p))
> +		ptr = p;
> +	return ptr;
> +}
>  
>  #endif
>  
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> index ad79de2..1af2377 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -21,9 +21,7 @@
>  #include <linux/err.h>
>  #include <linux/vmalloc.h>
>  #include <linux/bug.h>
> -#include <linux/uaccess.h>
>  #include <asm/module.h>
> -#include <asm/sections.h>
>  #include <asm/firmware.h>
>  #include <asm/code-patching.h>
>  #include <linux/sort.h>
> @@ -43,13 +41,6 @@
>  #define DEBUGP(fmt , ...)
>  #endif
>  
> -/* There's actually a third entry here, but it's unused */
> -struct ppc64_opd_entry
> -{
> -	unsigned long funcaddr;
> -	unsigned long r2;
> -};
> -
>  /* Like PPC32, we need little trampolines to do > 24-bit jumps (into
>     the kernel itself).  But on PPC64, these need to be used for every
>     jump, actually, to reset r2 (TOC+0x8000). */
> @@ -452,13 +443,3 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
>  
>  	return 0;
>  }
> -
> -void *dereference_function_descriptor(void *ptr)
> -{
> -	struct ppc64_opd_entry *desc = ptr;
> -	void *p;
> -
> -	if (!probe_kernel_address(&desc->funcaddr, p))
> -		ptr = p;
> -	return ptr;
> -}
> 
