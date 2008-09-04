Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53336DDFF5
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 13:14:29 +1000 (EST)
Subject: Re: [PATCH v3 3/4] powerpc/fsl-booke: Fixup 64-bit PTE reading for
	SMP support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1220465344-16753-3-git-send-email-galak@kernel.crashing.org>
References: <1220465344-16753-1-git-send-email-galak@kernel.crashing.org>
	<1220465344-16753-2-git-send-email-galak@kernel.crashing.org>
	<1220465344-16753-3-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 04 Sep 2008 13:14:22 +1000
Message-Id: <1220498062.4879.38.camel@pasglop>
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


>  	FIND_PTE
>  	andc.	r13,r13,r11		/* Check permission */
> -	bne	2f			/* Bail if permission mismach */
>  
>  #ifdef CONFIG_PTE_64BIT
> -	lwz	r13, 0(r12)
> +#ifdef CONFIG_SMP
> +	subf	r10, r11, r12		/* create false data dep */
> +	lwzx	r13, r11, r10		/* Get upper pte bits */
> +#else
> +	lwz	r13, 0(r12)		/* Get upper pte bits */
>  #endif
> +#endif

Minor nit, but we don't usually use spaces after "," in asm.

Cheers,
Ben.
