Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 21721B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Jul 2009 09:49:43 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78717DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Jul 2009 09:49:42 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix another bug in move of altivec code to
	vector.S
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
In-Reply-To: <m2iqi0w83z.fsf@igel.home>
References: <m2iqi0w83z.fsf@igel.home>
Content-Type: text/plain
Date: Sat, 11 Jul 2009 09:49:27 +1000
Message-Id: <1247269767.21776.17.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-07-10 at 23:17 +0200, Andreas Schwab wrote:
> When moving load_up_altivec to vector.S a typo in a comment caused a
> thinko setting the wrong variable.
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Good catch, thanks.

Cheers,
Ben.

> ---
> diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
> index ef36cbb..ea4d646 100644
> --- a/arch/powerpc/kernel/vector.S
> +++ b/arch/powerpc/kernel/vector.S
> @@ -80,10 +80,10 @@ _GLOBAL(load_up_altivec)
>  	mtvscr	vr0
>  	REST_32VRS(0,r4,r5)
>  #ifndef CONFIG_SMP
> -	/* Update last_task_used_math to 'current' */
> +	/* Update last_task_used_altivec to 'current' */
>  	subi	r4,r5,THREAD		/* Back to 'current' */
>  	fromreal(r4)
> -	PPC_STL	r4,ADDROFF(last_task_used_math)(r3)
> +	PPC_STL	r4,ADDROFF(last_task_used_altivec)(r3)
>  #endif /* CONFIG_SMP */
>  	/* restore registers and return */
>  	blr
> @@ -172,7 +172,7 @@ _GLOBAL(load_up_vsx)
>  	oris	r12,r12,MSR_VSX@h
>  	std	r12,_MSR(r1)
>  #ifndef CONFIG_SMP
> -	/* Update last_task_used_math to 'current' */
> +	/* Update last_task_used_vsx to 'current' */
>  	ld	r4,PACACURRENT(r13)
>  	std	r4,0(r3)
>  #endif /* CONFIG_SMP */
> 
