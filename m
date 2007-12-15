Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AC69EDDDF5
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 17:16:40 +1100 (EST)
Subject: Re: [PATCH 03/10] powerpc: Add kexec support for PPC_85xx platforms
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20071122154607.GA26447@xyzzy.farnsworth.org>
References: <20071122154607.GA26447@xyzzy.farnsworth.org>
Content-Type: text/plain
Date: Sat, 15 Dec 2007 17:16:25 +1100
Message-Id: <1197699385.6696.43.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> index 8b642ab..db0e749 100644
> --- a/arch/powerpc/kernel/misc_32.S
> +++ b/arch/powerpc/kernel/misc_32.S
> @@ -816,6 +816,75 @@ relocate_new_kernel:
>  	/* r4 = reboot_code_buffer */
>  	/* r5 = start_address      */
>  
> +#ifdef CONFIG_E500
> +	/*
> +	 * Since we can't turn off the MMU, we must create an identity
> +	 * map for kernel low memory.  We start by invalidating the
> +	 * TLB entries we don't need.
> +	 *
> +	 * First, invalidate the TLB0 entries
> +	 */
> +	li	r6, 0x04
> +	tlbivax	0, r6
> +#ifdef CONFIG_SMP
> +	tlbsync
> +#endif
> +	msync
> +

This is really E500 specific or should it be CONFIG_FSL_BOOKE ?

Ben.
