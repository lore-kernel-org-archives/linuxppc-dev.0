Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C4323DDED6
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 15:43:09 +1000 (EST)
Subject: Re: [PATCH 1/3] powerpc: Fix pte_update for CONFIG_PTE_64BIT and
	!PTE_ATOMIC_UPDATES
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0807140808090.9284@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0807140808090.9284@blarg.am.freescale.net>
Content-Type: text/plain
Date: Tue, 15 Jul 2008 15:43:03 +1000
Message-Id: <1216100583.7740.70.camel@pasglop>
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

On Mon, 2008-07-14 at 08:08 -0500, Kumar Gala wrote:
> Because the pte is now 64-bits the compiler was optimizing the update
> to always clear the upper 32-bits of the pte.  We need to ensure the
> clr mask is treated as an unsigned long long to get the proper behavior.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Putting that one into my tree. I'll let you put the 2 others in yours.

Cheers,
Ben.

> ---
>  include/asm-powerpc/pgtable-ppc32.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/asm-powerpc/pgtable-ppc32.h b/include/asm-powerpc/pgtable-ppc32.h
> index 11eede4..73015f0 100644
> --- a/include/asm-powerpc/pgtable-ppc32.h
> +++ b/include/asm-powerpc/pgtable-ppc32.h
> @@ -624,7 +624,7 @@ static inline unsigned long long pte_update(pte_t *p,
>  	: "cc" );
>  #else /* PTE_ATOMIC_UPDATES */
>  	unsigned long long old = pte_val(*p);
> -	*p = __pte((old & ~clr) | set);
> +	*p = __pte((old & ~(unsigned long long)clr) | set);
>  #endif /* !PTE_ATOMIC_UPDATES */
> 
>  #ifdef CONFIG_44x
