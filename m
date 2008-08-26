Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4CA2DDEC53
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 12:10:46 +1000 (EST)
Message-Id: <B2E08627-F781-499B-B7B6-4D93C5DF60AB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0808252058320.21303@blarg.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc: Fix determining TI_CPU in
	power_save_ppc32_restore()
Date: Mon, 25 Aug 2008 21:10:35 -0500
References: <Pine.LNX.4.64.0808252058320.21303@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, G.Chen@freescale.com,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/ 
> idle_6xx.S
> index 019b02d..0138d88 100644
> --- a/arch/powerpc/kernel/idle_6xx.S
> +++ b/arch/powerpc/kernel/idle_6xx.S
> @@ -151,19 +151,20 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
>  * Return from NAP/DOZE mode, restore some CPU specific registers,
>  * we are called with DR/IR still off and r2 containing physical
>  * address of current.  R11 points to the exception frame (physical
> - * address).  We have to preserve r10.
> + * address).  We have to preserve r10.  R9 contains the physical
> + * address of thread_info.
>  */
> _GLOBAL(power_save_ppc32_restore)
> -	lwz	r9,_LINK(r11)		/* interrupted in ppc6xx_idle: */
> -	stw	r9,_NIP(r11)		/* make it do a blr */
> -
> #ifdef CONFIG_SMP
> -	mfspr	r12,SPRN_SPRG3
> -	lwz	r11,TI_CPU(r12)		/* get cpu number * 4 */
> +	lwz	r11,TI_CPU(r9)		/* get cpu number * 4 */
> 	slwi	r11,r11,2
> #else
> 	li	r11,0
> #endif
> +
> +	lwz	r9,_LINK(r11)		/* interrupted in ppc6xx_idle: */
> +	stw	r9,_NIP(r11)		/* make it do a blr */
> +

this is just brain damaged as I'm clobber r11 before setting up r9  
with LR.  V2 of the patch does things right.

- k
