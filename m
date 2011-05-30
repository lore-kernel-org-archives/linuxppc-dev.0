Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EDDDFB6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 May 2011 07:18:39 +1000 (EST)
Subject: Re: [PATCH] 2.6.39 powerpc: Fix 32-bit SMP build
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20110530122621.GD2557@zod.rchland.ibm.com>
References: <20110530122621.GD2557@zod.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 31 May 2011 07:18:28 +1000
Message-ID: <1306790308.7481.618.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-05-30 at 08:26 -0400, Josh Boyer wrote:
> Backport upstream commit 6de06f313a65d0ec
>     
> Commit fa3f82c8bb7acb ("powerpc/smp: soft-replugged CPUs must go back to
> start_secondary") introduced start_secondary_resume to head_32.S, however
> it uses a 64-bit instruction which is not valid on 32-bit platforms.  Use
> 'stw' instead.
>     
> CC: stable@kernel.org
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
> index c5c24be..727f40a 100644
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -896,7 +896,7 @@ _GLOBAL(start_secondary_resume)
>  	rlwinm  r1,r1,0,0,(31-THREAD_SHIFT)     /* current_thread_info() */
>  	addi    r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
>  	li      r3,0
> -	std     r3,0(r1)                /* Zero the stack frame pointer */
> +	stw     r3,0(r1)                /* Zero the stack frame pointer */
>  	bl      start_secondary
>  	b       .
>  #endif /* CONFIG_SMP */
