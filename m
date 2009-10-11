Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD466B7B72
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 08:25:38 +1100 (EST)
Subject: Re: [PATCH 6/8] 8xx: Add missing Guarded setting in DTLB Error.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
In-Reply-To: <1255278912-8042-7-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-6-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-7-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Oct 2009 08:25:30 +1100
Message-Id: <1255296330.2192.42.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2009-10-11 at 18:35 +0200, Joakim Tjernlund wrote:
> only DTLB Miss did set this bit, DTLB Error needs too otherwise
> the setting is lost when the page becomes dirty.

Easier fix: Stop doing thing in DTLB Error

Ben.

> --
>  arch/powerpc/kernel/head_8xx.S |   13 ++++++++++---
>  1 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index 027856e..371b606 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -552,9 +552,16 @@ DARFix:	/* Return from dcbx instruction bug workaround, r10 holds value of DAR *
>  	 */
>  	ori	r11, r11, 1		/* Set valid bit in physical L2 page */
>  	DO_8xx_CPU6(0x3b80, r3)
> -	mtspr	SPRN_MD_TWC, r11		/* Load pte table base address */
> -	mfspr	r11, SPRN_MD_TWC		/* ....and get the pte address */
> -	lwz	r10, 0(r11)		/* Get the pte */
> +	mtspr	SPRN_MD_TWC, r11	/* Load pte table base address */
> +	mfspr	r10, SPRN_MD_TWC	/* ....and get the pte address */
> +	lwz	r10, 0(r10)		/* Get the pte */
> +	/* Insert the Guarded flag into the TWC from the Linux PTE.
> +	 * It is bit 27 of both the Linux PTE and the TWC
> +	 */
> +	rlwimi	r11, r10, 0, 27, 27
> +	DO_8xx_CPU6(0x3b80, r3)
> +	mtspr	SPRN_MD_TWC, r11
> +	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
>  
>  	ori	r10, r10, _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_HWWRITE
>  	stw	r10, 0(r11)		/* and update pte in table */
