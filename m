Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32B4C68A2D
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Feb 2006 11:23:48 +1100 (EST)
Date: Tue, 31 Jan 2006 18:15:58 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Fix Kernel FP unavail exception for BookE
In-Reply-To: <Pine.LNX.4.61.0601311746250.18350@cde-tx32-ldt329.sps.mot.com>
Message-ID: <Pine.LNX.4.44.0601311815140.30616-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Acked-by: Kumar Gala <galak@kernel.crashing.org>

On Tue, 31 Jan 2006, Becky Bruce wrote:

> powerpc: Correct BookE FP unavailable exception
> 
> Updated FP unavailable exception to refer to the correct
> function in traps.c. head_booke.h was using the old name, KernelFP,
> instead of kernel_fp_unavailable_exception.
> 
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> 
> ---
> commit 6e481b074a1cbe44dd5ccc29fe74857986a41e14
> tree 5e3d59136176a927dae2f42ce83b393b17fc86e6
> parent 2a68349345a9bf292d06a8baaa8182b946c7056c
> author Becky Bruce <becky.bruce@freescale.com> Tue, 31 Jan 2006 17:41:00 -0600
> committer Becky Bruce <becky.bruce@freescale.com> Tue, 31 Jan 2006 17:41:00 -0600
> 
>  arch/powerpc/kernel/head_booke.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
> index 5827c27..8536e76 100644
> --- a/arch/powerpc/kernel/head_booke.h
> +++ b/arch/powerpc/kernel/head_booke.h
> @@ -358,6 +358,6 @@ label:
>  	NORMAL_EXCEPTION_PROLOG;					      \
>  	bne	load_up_fpu;		/* if from user, just load it up */   \
>  	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
> -	EXC_XFER_EE_LITE(0x800, KernelFP)
> +	EXC_XFER_EE_LITE(0x800, kernel_fp_unavailable_exception)
>  
>  #endif /* __HEAD_BOOKE_H__ */
> 
