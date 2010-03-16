Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0C49B7D29
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 08:20:57 +1100 (EST)
Subject: Re: [PATCH 3/4] 8xx: Don't touch ACCESSED when no SWAP.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
In-Reply-To: <1267172983-28721-4-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1267172983-28721-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267172983-28721-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267172983-28721-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267172983-28721-4-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Mar 2010 08:20:52 +1100
Message-ID: <1268774452.2335.132.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-02-26 at 09:29 +0100, Joakim Tjernlund wrote:
> Only the swap function cares about the ACCESSED bit in
> the pte. Do not waste cycles updateting ACCESSED when swap
> is not compiled into the kernel.
> ---

Your changeset comment is a bit misleading since the code isn't actually
updating ACCESSED... it's testing if ACCESSED is set and goes to the
higher level fault if not (which might then update ACCESSED).

Cheers,
Ben.

>  arch/powerpc/kernel/head_8xx.S |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index 84ca1d9..6478a96 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -343,10 +343,11 @@ InstructionTLBMiss:
>  	mfspr	r11, SPRN_MD_TWC	/* ....and get the pte address */
>  	lwz	r10, 0(r11)	/* Get the pte */
>  
> +#ifdef CONFIG_SWAP
>  	andi.	r11, r10, _PAGE_ACCESSED | _PAGE_PRESENT
>  	cmpwi	cr0, r11, _PAGE_ACCESSED | _PAGE_PRESENT
>  	bne-	cr0, 2f
> -
> +#endif
>  	/* The Linux PTE won't go exactly into the MMU TLB.
>  	 * Software indicator bits 21 and 28 must be clear.
>  	 * Software indicator bits 24, 25, 26, and 27 must be
> @@ -439,10 +440,11 @@ DataStoreTLBMiss:
>  	 * r11 = ((r10 & PRESENT) & ((r10 & ACCESSED) >> 5));
>  	 * r10 = (r10 & ~PRESENT) | r11;
>  	 */
> +#ifdef CONFIG_SWAP
>  	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
>  	and	r11, r11, r10
>  	rlwimi	r10, r11, 0, _PAGE_PRESENT
> -
> +#endif
>  	/* Honour kernel RO, User NA */
>  	/* 0x200 == Extended encoding, bit 22 */
>  	rlwimi	r10, r10, 32-2, 0x200 /* Copy USER to bit 22, 0x200 */
