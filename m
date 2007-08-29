Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 24E26DDF04
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 06:08:19 +1000 (EST)
Date: Thu, 30 Aug 2007 01:09:59 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/9] 8xx: Fix CONFIG_PIN_TLB.
Message-ID: <20070830010959.73c4cec9@localhost.localdomain>
In-Reply-To: <20070828201716.GA24260@ld0162-tx32.am.freescale.net>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201716.GA24260@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 28 Aug 2007 15:17:16 -0500
Scott Wood wrote:

> 1. Only map 512K of the IMMR, rather than 8M, to avoid conflicting
> with the default ioremap region.
> 2. The wrong register was being loaded into SPRN_MD_RPN.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
Acked-by: Vitaly Bordug <vitb@kernel.crashing.org>

> ---
>  arch/powerpc/kernel/head_8xx.S |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_8xx.S
> b/arch/powerpc/kernel/head_8xx.S index 901be47..e40e122 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -695,7 +695,7 @@ initial_mmu:
>  	mtspr	SPRN_MI_AP, r8
>  	mtspr	SPRN_MD_AP, r8
>  
> -	/* Map another 8 MByte at the IMMR to get the processor
> +	/* Map another 512 KByte at the IMMR to get the processor
>  	 * internal registers (among other things).
>  	 */
>  #ifdef CONFIG_PIN_TLB
> @@ -703,12 +703,12 @@ initial_mmu:
>  	mtspr	SPRN_MD_CTR, r10
>  #endif
>  	mfspr	r9, 638			/* Get current
> IMMR */
> -	andis.	r9, r9, 0xff80		/* Get 8Mbyte
> boundary */
> +	andis.	r9, r9, 0xfff8		/* Get 512K
> boundary */ 
>  	mr	r8, r9			/* Create vaddr for
> TLB */ ori	r8, r8, MD_EVALID	/* Mark it valid */
>  	mtspr	SPRN_MD_EPN, r8
> -	li	r8, MD_PS8MEG		/* Set 8M byte page */
> +	li	r8, MD_PS512K		/* Set 512K byte page
> */ ori	r8, r8, MD_SVALID	/* Make it valid */
>  	mtspr	SPRN_MD_TWC, r8
>  	mr	r8, r9			/* Create paddr for
> TLB */ @@ -730,13 +730,13 @@ initial_mmu:
>  	mtspr	SPRN_MD_TWC, r9
>  	li	r11, MI_BOOTINIT	/* Create RPN for address
> 0 */ addis	r11, r11, 0x0080	/* Add 8M */
> -	mtspr	SPRN_MD_RPN, r8
> +	mtspr	SPRN_MD_RPN, r11
>  
>  	addis	r8, r8, 0x0080		/* Add 8M */
>  	mtspr	SPRN_MD_EPN, r8
>  	mtspr	SPRN_MD_TWC, r9
>  	addis	r11, r11, 0x0080	/* Add 8M */
> -	mtspr	SPRN_MD_RPN, r8
> +	mtspr	SPRN_MD_RPN, r11
>  #endif
>  
>  	/* Since the cache is enabled according to the information we


-- 
Sincerely, Vitaly
