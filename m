Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 51607DDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 00:12:48 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lALDChEI021901
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 08:12:43 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lALDCgQs125568
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 06:12:42 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lALDCfMV018666
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 06:12:42 -0700
Date: Wed, 21 Nov 2007 07:12:40 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 5/14] powerpc: Fix 440/440A machine check handling
Message-ID: <20071121071240.141d2917@weaponx>
In-Reply-To: <20071121061714.0AB82DEAF1@ozlabs.org>
References: <1195625777.579001.269266058699.qpush@grosgo>
	<20071121061714.0AB82DEAF1@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 Nov 2007 17:16:24 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This removes CONFIG_440A which was a problem for multiplatform
> kernels and instead fixes up the IVOR at runtime from a setup_cpu
> function. The "A" version of the machine check also tweaks the
> regs->trap value to differenciate the 2 versions at the C level.
> 

<snip>

>  void machine_check_exception(struct pt_regs *regs)
>  {
> @@ -463,8 +489,20 @@ void machine_check_exception(struct pt_r
>  	/* See if any machine dependent calls */
>  	if (ppc_md.machine_check_exception)
>  		recover = ppc_md.machine_check_exception(regs);
> -	else
> -		recover = generic_machine_check_exception(regs);
> +	else {
> +#ifdef CONFIG_4xx
> +		if (IS_MCHECK_EXC(regs))
> +			recover = decode_machine_check_4xxA(regs);
> +		else
> +			recover = decode_machine_check_4xx(regs);
> +#elif defined (CONFIG_E500)
> +		recover = decode_machine_check_e500(regs);
> +#elif defined (CONFIG_E200)
> +		recover = decode_machine_check_e200(regs);
> +#else
> +		recover = decode_machine_check_generic(regs);
> +#endif

Why didn't you just add a ppc_md.machine_check_exception to the
effected boards?  Then you could have gotten rid of the ifdefs all
together.

josh
