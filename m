Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C1F4D67C24
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 14:23:21 +1000 (EST)
Subject: Re: [PATCH 5/10 v2] Add 8641 CPU and i8259 Setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1149803956.23938.284.camel@cashmere.sps.mot.com>
References: <1149803956.23938.284.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 14:23:09 +1000
Message-Id: <1149826989.12687.50.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -224,6 +224,10 @@ turn_on_mmu:
>  	li	r3,1			/* MTX only has 1 cpu */
>  	.globl	__secondary_hold
>  __secondary_hold:
> +#ifdef CONFIG_PPC_86xx
> +	/* get the cpu id */
> +	mfspr	r3, SPRN_PIR
> +#endif

The above is wrong, it prevents using the same kernel image on another
platform. If you need a separate hold loop, then go for it but don't
change the existing one in a non-compatible way. Alternatively, you can
do like powermac, that is have several "entrypoints" to the same hold
loop providing different CPU IDs.

>  	/* tell the master we're here */
>  	stw	r3,__secondary_hold_acknowledge@l(0)
>  #ifdef CONFIG_SMP
> @@ -348,6 +352,16 @@ #define EXC_XFER_EE_LITE(n, hdlr)	\
>  #if defined(CONFIG_GEMINI) && defined(CONFIG_SMP)
>  	. = 0x100
>  	b	__secondary_start_gemini
> +#endif
> +/* we need to ensure that the address translation is disabled */
> +#if defined(CONFIG_PPC_86xx) && defined(CONFIG_SMP)
> +        . = 0x100
> +        mfmsr   r3
> +        andi.   r0, r3, (MSR_IR | MSR_DR)
> +        andc    r3, r3, r0
> +        mtmsr   r3
> +        isync
> +        b       __secondary_hold
>  #else
>  	EXCEPTION(0x100, Reset, unknown_exception, EXC_XFER_STD)
>  #endif

Same comment above... #ifdef is bad. You are entering from 0x100 with
address translation not disabled ? How is that possible ? If it's your
firmware, then fix it :) If not possible, then have a real good
explanation why and how you end up in 0x100 that way. At worse, do like
pmac does and "patch" the 0x100 vector to point to some machine specific
code dynamically at runtime. 

> @@ -1019,6 +1033,7 @@ #endif /* CONFIG_6xx */
>  	stw	r0,0(r3)
>  
>  	/* load up the MMU */
> +	bl	clear_bats
>  	bl	load_up_mmu

Why do you need to call clear_bats here ? load_up_mmu should load BATs.
If it doesn't handle the high BATs, then fix it :) 

>  	/* ptr to phys current thread */
> diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
> index b7ac32f..9b755e1 100644
> --- a/arch/powerpc/sysdev/i8259.c
> +++ b/arch/powerpc/sysdev/i8259.c
> @@ -201,6 +201,11 @@ void __init i8259_init(unsigned long int
>  	outb(0x0B, 0x20);
>  	outb(0x0B, 0xA0);
>  
> +#ifdef CONFIG_I8259_LEVEL_TRIGGER
> +	outb(0xfa, 0x4d0); /* level triggered */
> +	outb(0xde, 0x4d1);
> +#endif

Another change that breaks multiplatform... Can you explain precisely
what you are trying to acheive here ? If necessary, we can add an
argument to i8259_init. Or you could do the above in your platform
code ... though I agree it would be a bit ugly :) 

>  	/* Mask all interrupts */
>  	outb(cached_A1, 0xA1);
>  	outb(cached_21, 0x21);
