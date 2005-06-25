Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6CE0467A45
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Jun 2005 08:25:11 +1000 (EST)
In-Reply-To: <20050625145318.GA32117@logos.cnet>
References: <20050625145318.GA32117@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 25 Jun 2005 18:24:47 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: map_page() skip pinned region and tlbie debugging
	aid
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 25, 2005, at 10:53 AM, Marcelo Tosatti wrote:

> Dan: I dont think ioremap() is an issue because it never works inside 
> the
> kernel's static virtual address space (which is the only one we're 
> interested
> in having pinned at the moment).

Take a close look at the initialization code.  I believe it also
pins the IMMR space, which is subject to ioremap().

>  source "drivers/Kconfig"
> diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
> --- a/arch/ppc/kernel/misc.S
> +++ b/arch/ppc/kernel/misc.S
> @@ -565,6 +565,19 @@ _GLOBAL(_tlbie)
>  	SYNC_601
>  	isync
>  #else /* CONFIG_SMP */
> +#ifdef CONFIG_DEBUG_PIN_TLBIE
> +/* check if the address being invalidated overlaps with the pinned 
> region */
> +	lis	r4,(pin_area_start)@ha
> +	lwz	r5,(pin_area_start)@l(4)
> +	cmplw	r3, r5
> +	blt	11f
> +	lis	r4,(pin_area_end)@ha
> +	lwz	r5,(pin_area_end)@l(4)
> +	cmplw	r3, r5
> +	bge	11f
> +	trap
> +#endif
> +11:
>  	tlbie	r3
>  	sync

We don't need this kind of assembly code on the 8xx.  Just define
_tlbie as a macro (which has always been done) and write this debug
stuff as C code.

> +#ifdef CONFIG_PIN_TLB
> +unsigned long pin_area_start = KERNELBASE;
> +unsigned long pin_area_end = KERNELBASE + 0x00800000;
> +#endif

This only covers the kernel instruction space.  We pin 24M bytes
of data plus 8M bytes of IMMR.

> +#ifdef CONFIG_PIN_TLB
> +			if (va < pin_area_start || va >= pin_area_end)
> +#endif
> +				flush_HPTE(0, va, pmd_val(*pd));

We really want to see this generate an error.  We shouldn't be
calling this on any of the pinned spaces.  In the case of initially
mapping the kernel space, we should set up the page tables but
not call this far down that we get here.

Thanks.

	-- Dan
