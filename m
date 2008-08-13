Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18594.28433.827798.249177@cargo.ozlabs.ibm.com>
Date: Wed, 13 Aug 2008 15:20:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: mohan@in.ibm.com
Subject: Re: [PATCH 4/5] Relocation support
In-Reply-To: <20080812081103.GD19619@in.ibm.com>
References: <20080811201120.GA25283@in.ibm.com>
	<20080811201644.GD26566@in.ibm.com>
	<20080812081103.GD19619@in.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mohan Kumar M writes:

> Add relocatable kernel support like avoiding copying the vmlinux
> image to compile address, adding relocation delta to the absolute
> symbol references etc. ld does not provide relocation entries for
> .got section, and the user space relocation extraction program
> can not process @got entries.  So use LOAD_REG_IMMEDIATE macro
> instead of LOAD_REG_ADDR macro for relocatable kernel.

I think this is a symptom of the more general problem that
--emit-relocs doesn't actually give us all of the relocations we
need.  That, and the fact that the relevant code paths in ld are more
widely used and better tested, is why I would prefer to build the
kernel as a position-independent executable.

>  static inline int in_kernel_text(unsigned long addr)
>  {
> -	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end)
> +	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end
> +								+ kernel_base)

Your patch adds kernel_base to some addresses but not to all of them,
so your patch description should have told us why you added it in the
those places and not others.  If you tell us the general principle
you're following (even if it seems obvious to you) it will be useful
to people chasing bugs or adding new code later on, or even just
trying to understand what the code does.

> -	RELOC(alloc_bottom) = PAGE_ALIGN((unsigned long)&RELOC(_end) + 0x4000);
> +#ifndef CONFIG_RELOCATABLE_PPC64
> + 	RELOC(alloc_bottom) = PAGE_ALIGN((unsigned long)&RELOC(_end) + 0x4000);
> +#else
> +	RELOC(alloc_bottom) = PAGE_ALIGN((unsigned long)&RELOC(_end) + 0x4000 +
> +							RELOC(reloc_delta));
> +#endif

Ifdefs in code inside a function are frowned upon in the Linux
kernel.  Try to find an alternative way to do this, such as ensuring
that reloc_delta is 0 when CONFIG_RELOCATABLE_PPC64 is not set.
Also it's not clear (to me at least) why you need to add reloc_data in
the relocatable case.

> +#ifndef CONFIG_RELOCATABLE_PPC64
>  	unsigned long *spinloop
>  		= (void *) LOW_ADDR(__secondary_hold_spinloop);
>  	unsigned long *acknowledge
>  		= (void *) LOW_ADDR(__secondary_hold_acknowledge);
> +#else
> +	unsigned long *spinloop
> +		= (void *) &__secondary_hold_spinloop;
> +	unsigned long *acknowledge
> +		= (void *) &__secondary_hold_acknowledge;
> +#endif

This also needs some explanation.  (Put it in the patch description or
in a comment in the code, not in a reply to this mail. :)

> +#ifndef CONFIG_RELOCATABLE_PPC64
>  	ld	r4,htab_hash_mask@got(2)
> +#else
> +	LOAD_REG_IMMEDIATE(r4,htab_hash_mask)
> +#endif
>  	ld	r27,0(r4)	/* htab_hash_mask -> r27 */

Here and in the other similar places, I would prefer you just changed
it to LOAD_REG_ADDR and not have any ifdef.

Paul.
