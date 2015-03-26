Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0102.outbound.protection.outlook.com [65.55.169.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ACF121A0AAA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 08:32:29 +1100 (AEDT)
Date: Thu, 26 Mar 2015 16:32:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: [v3, 01/11] powerpc/8xx: remove remaining unnecessary code in
 FixupDAR
Message-ID: <20150326213215.GA21815@home.buserror.net>
References: <20150203113816.E77811A5F13@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20150203113816.E77811A5F13@localhost.localdomain>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 03, 2015 at 12:38:16PM +0100, LEROY Christophe wrote:
> Since commit 33fb845a6f01 ("powerpc/8xx: Don't use MD_TWC for walk"), MD_EPN and
> MD_TWC are not writen anymore in FixupDAR so saving r3 has become useless.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> v2: no change
> v3: no change

This doesn't apply cleanly.

>  arch/powerpc/kernel/head_8xx.S | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index 3d4b8ee..79b8a23 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -532,9 +532,6 @@ DARFixed:/* Return from dcbx instruction bug workaround */
>   /* define if you don't want to use self modifying code */
>  #define NO_SELF_MODIFYING_CODE
>  FixupDAR:/* Entry point for dcbx workaround. */
> -#ifdef CONFIG_8xx_CPU6
> -	mtspr	SPRN_DAR, r3
> -#endif
>  	mtspr	SPRN_SPRG_SCRATCH2, r10
>  	/* fetch instruction from memory. */
>  	mfspr	r10, SPRN_SRR0

This hunk looks OK but should start at line 500.

> @@ -551,9 +548,6 @@ FixupDAR:/* Entry point for dcbx workaround. */
>  	/* Extract level 2 index */
>  	rlwinm	r11, r11, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
>  	lwzx	r11, r10, r11	/* Get the pte */
> -#ifdef CONFIG_8xx_CPU6
> -	mfspr	r3, SPRN_DAR
> -#endif
>  	/* concat physical page address(r11) and page offset(r10) */
>  	mfspr	r10, SPRN_SRR0
>  	rlwimi	r11, r10, 0, 32 - PAGE_SHIFT, 31

There is no ifdef CONFIG_8xx_CPU6 after any of the the "Get the pte"
lines, and none of them are "lwzx	r11, r10, r11".

What tree is this patchset against?

-Scott
