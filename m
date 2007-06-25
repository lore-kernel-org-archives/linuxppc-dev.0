Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 40CFBDDEBB
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 23:36:07 +1000 (EST)
In-Reply-To: <20070625105836.GE9768@bakeyournoodle.com>
References: <20070625105836.GE9768@bakeyournoodle.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <757f020b834543583be36b73b932da3e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix VDSO gettimeofday() when called with NULL struct
	timeval.
Date: Mon, 25 Jun 2007 15:35:51 +0200
To: tony@bakeyournoodle.com (Tony Breeds)
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 	It'd be nice if this made it into 2.6.22, esp. now that more
> distros are shipping glibc's that will use the VDSO.

Yeah.  Not really vital though, no sane program would call
gettimeofday() with a NULL timeval (since that doesn't do
anything).  Or did you find such a program (other than a
testsuite)?

> +++ working/arch/powerpc/kernel/vdso32/gettimeofday.S	2007-06-25 
> 19:40:34.000000000 +1000
> @@ -32,8 +32,10 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
>  	mr	r11,r4			/* r11 saves tz */
>  	bl	__get_datapage@local	/* get data page */
>  	mr	r9, r3			/* datapage ptr in r9 */
> +	cmpli	cr0,r10,0		/* check if tv is NULL */

cmplwi r10,0

cmpli with two or three arguments is not an existing PowerPC
instruction.  Also, don't write cr0 if you don't do the same
in the accompanying branch insn, it only confuses things.

> +	beq	1f
>  	bl	__do_get_xsec@local	/* get xsec from tb & kernel */
> -	bne-	2f			/* out of line -> do syscall */
> +	bne-	3f			/* out of line -> do syscall */

No need to renumber the labels.  Either pick a higher
number for your new label (nothing says they need to be
in order); or reuse some other number (both your new and
the original 1: can be 1: without any problem, these are
local labels after all); or you can use 0: since that's
a valid local label as well.


Segher
