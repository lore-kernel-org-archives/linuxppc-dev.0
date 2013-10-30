Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 046182C0369
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 13:04:18 +1100 (EST)
Message-ID: <1383092023.5117.40.camel@pasglop>
Subject: Re: [PATCH 1/3] powerpc: Enable emulate_step In Little Endian Mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Musta <tommusta@gmail.com>
In-Reply-To: <1382125235.2206.24.camel@tmusta-sc.rchland.ibm.com>
References: <1382125125.2206.22.camel@tmusta-sc.rchland.ibm.com>
 <1382125235.2206.24.camel@tmusta-sc.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 30 Oct 2013 11:13:43 +1100
Mime-Version: 1.0
Cc: tmusta@gmail.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-10-18 at 14:40 -0500, Tom Musta wrote:
> This patch modifies the endian chicken switch in the single step
> emulation code (emulate_step()).  The old (big endian) code bailed
> early if a load or store instruction was to be emulated in little
> endian mode.
> 
> The new code modifies the check and only bails in a cross-endian
> situation (LE mode in a kernel compiled for BE and vice verse).

I get a malformed patch error, looks like it got wrapped.

Cheers,
Ben.

> Signed-off-by: Tom Musta <tmusta@gmail.com>
> ---
>  arch/powerpc/lib/sstep.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index b1faa15..5e0d0e9 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -1222,12 +1222,18 @@ int __kprobes emulate_step(struct pt_regs *regs,
> unsigned int instr)
>  	}
>  
>  	/*
> -	 * Following cases are for loads and stores, so bail out
> -	 * if we're in little-endian mode.
> +	 * Following cases are for loads and stores and this
> +	 * implementation does not support cross-endian.  So
> +	 * bail out if this is the case.
>  	 */
> +#ifdef __BIG_ENDIAN__
>  	if (regs->msr & MSR_LE)
>  		return 0;
> -
> +#endif
> +#ifdef __LITTLE_ENDIAN__
> +	if (!regs->msr & MSR_LE)
> +		return 0;
> +#endif
>  	/*
>  	 * Save register RA in case it's an update form load or store
>  	 * and the access faults.
