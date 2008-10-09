Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18669.38444.112286.785452@cargo.ozlabs.ibm.com>
Date: Thu, 9 Oct 2008 16:27:08 +1100
From: Paul Mackerras <paulus@samba.org>
To: mohan@in.ibm.com
Subject: Re: [PATCH] Support for relocatable kdump kernel
In-Reply-To: <20081001182645.GB20319@in.ibm.com>
References: <20081001182645.GB20319@in.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mohan Kumar M writes:

> Support for relocatable kdump kernel

[snip]

> @@ -1384,7 +1392,15 @@ _STATIC(__after_prom_start)
>  	/* process relocations for the final address of the kernel */
>  	lis	r25,PAGE_OFFSET@highest	/* compute virtual base of kernel */
>  	sldi	r25,r25,32
> -	mr	r3,r25
> +#ifdef CONFIG_CRASH_DUMP
> +	ld	r7,__kdump_flag@got(r2)
> +	add	r7,r7,r26
> +	ld	r7,0(r7)

I think it is dangerous to use an address from the GOT at this point
when we haven't called relocate() yet.  In fact those 3 instructions
can be replaced by one:

	ld	r7,__kdump_flag-_stext(r26)

since we have our base address (i.e. the address of _stext) in r26 at
this point.

> +#ifdef CONFIG_RELOCATABLE
> +#ifdef CONFIG_CRASH_DUMP
> +/*
> + * Check if the kernel has to be running as relocatable kernel based on the
> + * variable __kdump_flag, if it is set the kernel is treated as relocatble
> + * kernel, otherwise it will be moved to PHYSICAL_START
> + */
> +	ld	r7,__kdump_flag@got(r2)
> +	ld	r7,0(r7)

Here again I would rather you did

	ld	r7,__kdump_flag-_stext(r26)

since the kernel is relocated for its final location by this point,
but it is not running at the final location yet.

> +	cmpldi	cr0,r7,1
> +	bne	regular
> +
> +	li	r5,__end_interrupts - _stext	/* just copy interrupts */
> +	b	5f
> +regular:
> +#endif
> +	lis	r5,(copy_to_here - _stext)@ha
> +	addi	r5,r5,(copy_to_here - _stext)@l /* # bytes of memory to copy */
>  
>  	bl	.copy_and_flush		/* copy the first n bytes	 */
>  					/* this includes the code being	 */
> @@ -1411,15 +1443,33 @@ _STATIC(__after_prom_start)
>  	mtctr	r8
>  	bctr
>  
> +p_end:	.llong	_end - _stext
> +
>  4:	/* Now copy the rest of the kernel up to _end */
>  	addis	r5,r26,(p_end - _stext)@ha
>  	ld	r5,(p_end - _stext)@l(r5)	/* get _end */
> -	bl	.copy_and_flush		/* copy the rest */
> +#else
> +	lis	r5,(copy_to_here - _stext)@ha
> +	addi	r5,r5,(copy_to_here - _stext)@l /* # bytes of memory to copy */
>  
> -9:	b	.start_here_multiplatform
> +	bl	.copy_and_flush		/* copy the first n bytes	 */
> +					/* this includes the code being	 */
> +					/* executed here.		 */
> +	addis	r8,r3,(4f - _stext)@ha	/* Jump to the copy of this code */
> +	addi	r8,r8,(4f - _stext)@l	/* that we just made */
> +	mtctr	r8
> +	bctr
>  
>  p_end:	.llong	_end - _stext
>  
> +4:	/* Now copy the rest of the kernel up to _end */
> +	addis	r5,r26,(p_end - _stext)@ha
> +	ld	r5,(p_end - _stext)@l(r5)	/* get _end */
> +#endif
> +5:	bl	.copy_and_flush		/* copy the rest */
> +
> +9:	b	.start_here_multiplatform

You have ended up with two separate copies of the code here depending
on whether or not we have CONFIG_RELOCATABLE set.  I don't think the
code paths should be different to such an extent.  Please try to make
the ifdef as small as possible (ideally, nonexistent).

Paul.
