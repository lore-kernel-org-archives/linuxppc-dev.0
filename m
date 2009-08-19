Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4D3A2B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 17:29:54 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix __flush_icache_range on 44x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090817134136.GB8710@zod.rchland.ibm.com>
References: <20090817134136.GB8710@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 19 Aug 2009 17:29:44 +1000
Message-Id: <1250666984.4810.17.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-08-17 at 09:41 -0400, Josh Boyer wrote:
> The ptrace POKETEXT interface allows a process to modify the text pages of
> a child process being ptraced, usually to insert breakpoints via trap
> instructions.  The kernel eventually calls copy_to_user_page, which in turn
> calls __flush_icache_range to invalidate the icache lines for the child
> process.
> 
> However, this function does not work on 44x due to the icache being virtually
> indexed.  This was noticed by a breakpoint being triggered after it had been
> cleared by ltrace on a 440EPx board.  The convenient solution is to do a
> flash invalidate of the icache in the __flush_icache_range function.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

I've put it in -test for now, but I'd like you to respin when you get a
chance with:

 - removing the icbi loop in the 440 case
 - adding a nice fat comment explaining why next to the iccci
instruction itself so we don't be tempted to remove it.

Cheers,
Ben.

> ---
> 
> diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
> index 15f28e0..c9805a4 100644
> --- a/arch/powerpc/kernel/misc_32.S
> +++ b/arch/powerpc/kernel/misc_32.S
> @@ -346,6 +346,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
>  2:	icbi	0,r6
>  	addi	r6,r6,L1_CACHE_BYTES
>  	bdnz	2b
> +#ifdef CONFIG_44x
> +	iccci	r0, r0
> +#endif
>  	sync				/* additional sync needed on g4 */
>  	isync
>  	blr
