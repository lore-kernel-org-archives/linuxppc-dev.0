Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33A24DDEEB
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 22:39:56 +1000 (EST)
Subject: Re: [PATCH] Fix VDSO gettimeofday() when called with NULL struct
	timeval.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20070625105836.GE9768@bakeyournoodle.com>
References: <20070625105836.GE9768@bakeyournoodle.com>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 22:39:42 +1000
Message-Id: <1182775182.5521.62.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Index: working/arch/powerpc/kernel/vdso32/gettimeofday.S
> ===================================================================
> --- working.orig/arch/powerpc/kernel/vdso32/gettimeofday.S	2007-06-25 19:35:47.000000000 +1000
> +++ working/arch/powerpc/kernel/vdso32/gettimeofday.S	2007-06-25 19:40:34.000000000 +1000
> @@ -32,8 +32,10 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
>  	mr	r11,r4			/* r11 saves tz */
>  	bl	__get_datapage@local	/* get data page */
>  	mr	r9, r3			/* datapage ptr in r9 */
> +	cmpli	cr0,r10,0		/* check if tv is NULL */
> +	beq	1f

Please use cmplwi here.

>  	bl	__do_get_xsec@local	/* get xsec from tb & kernel */
> -	bne-	2f			/* out of line -> do syscall */
> +	bne-	3f			/* out of line -> do syscall */
>  
>  	/* seconds are xsec >> 20 */
>  	rlwinm	r5,r4,12,20,31
> @@ -50,20 +52,19 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
>  	mulhwu	r5,r5,r6
>  	stw	r5,TVAL32_TV_USEC(r10)
>  
> -	cmpli	cr0,r11,0		/* check if tz is NULL */
> -	beq	1f
> +1:	cmpli	cr0,r11,0		/* check if tz is NULL */
> +	beq	2f

And fix that one while at it :-) It's the same thing, but at least one
is explicit on the size of the comparison. Also, I don't think you need
to renumber the labels, or did I miss something ?

Cheers,
Ben.
