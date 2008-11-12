Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D0ACCDDDE7
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 22:27:48 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id mACBRiXj003027
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 06:27:44 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mACBRind116498
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 06:27:44 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mACBRTxD019823
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 06:27:29 -0500
Date: Wed, 12 Nov 2008 06:27:37 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix 460EX/460GT machine check handling
Message-ID: <20081112062737.19a01a22@zod.rchland.ibm.com>
In-Reply-To: <20081112020409.4FFBCDDDDB@ozlabs.org>
References: <20081112020409.4FFBCDDDDB@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 12 Nov 2008 13:02:43 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Those cores use the 440A type machine check (ie, they have
> MCSRR0/MCSRR1). They thus need to call the appropriate fixup
> function to hook the right variant of the exception.
> 
> Without this, all machine checks become fatal due to loss
> of context when entering the exception handler.

Looks fine to me.  However, what machine checks were you getting that
caused you to see this that aren't fatal anyway?

josh

> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
>  arch/powerpc/kernel/cpu_setup_44x.S |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> --- linux-work.orig/arch/powerpc/kernel/cpu_setup_44x.S	2008-11-12 12:51:24.000000000 +1100
> +++ linux-work/arch/powerpc/kernel/cpu_setup_44x.S	2008-11-12 13:01:03.000000000 +1100
> @@ -34,7 +34,12 @@ _GLOBAL(__setup_cpu_440grx)
>  	blr
>  _GLOBAL(__setup_cpu_460ex)
>  _GLOBAL(__setup_cpu_460gt)
> -	b	__init_fpu_44x
> +	mflr	r4
> +	bl	__init_fpu_44x
> +	bl	__fixup_440A_mcheck
> +	mtlr	r4
> +	blr
> +
>  _GLOBAL(__setup_cpu_440gx)
>  _GLOBAL(__setup_cpu_440spe)
>  	b	__fixup_440A_mcheck
