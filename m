Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21387DEDC6
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 14:37:52 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix determining TI_CPU in
	power_save_ppc32_restore()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0808252058320.21303@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0808252058320.21303@blarg.am.freescale.net>
Content-Type: text/plain
Date: Tue, 26 Aug 2008 14:37:40 +1000
Message-Id: <1219725460.13162.120.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, G.Chen@freescale.com,
	Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>  #ifdef CONFIG_SMP
> -	mfspr	r12,SPRN_SPRG3
> -	lwz	r11,TI_CPU(r12)		/* get cpu number * 4 */
> +	lwz	r11,TI_CPU(r9)		/* get cpu number * 4 */
>  	slwi	r11,r11,2
>  #else
>  	li	r11,0
>  #endif
> +
> +	lwz	r9,_LINK(r11)		/* interrupted in ppc6xx_idle: */
> +	stw	r9,_NIP(r11)		/* make it do a blr */
> +

hrm... you just clobbered r11, won't work very well :-)

Ben.

>  	/* Todo make sure all these are in the same page
>  	 * and load r11 (@ha part + CPU offset) only once
>  	 */
> diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
> index 0630403..c9d7234 100644
> --- a/arch/powerpc/kernel/idle_e500.S
> +++ b/arch/powerpc/kernel/idle_e500.S
> @@ -76,18 +76,19 @@ END_FTR_SECTION_IFSET(CPU_FTR_L2CSR|CPU_FTR_CAN_NAP)
>  /*
>   * Return from NAP/DOZE mode, restore some CPU specific registers,
>   * r2 containing physical address of current.
> + * r9 points to thread_info
>   * r11 points to the exception frame (physical address).
>   * We have to preserve r10.
>   */
>  _GLOBAL(power_save_ppc32_restore)
> -	lwz	r9,_LINK(r11)		/* interrupted in e500_idle */
> -	stw	r9,_NIP(r11)		/* make it do a blr */
> -
>  #ifdef CONFIG_SMP
> -	mfspr	r12,SPRN_SPRG3
> -	lwz	r11,TI_CPU(r12)		/* get cpu number * 4 */
> +	lwz	r11,TI_CPU(r9)		/* get cpu number * 4 */
>  	slwi	r11,r11,2
>  #else
>  	li	r11,0
>  #endif
> +
> +	lwz	r9,_LINK(r11)		/* interrupted in e500_idle */
> +	stw	r9,_NIP(r11)		/* make it do a blr */
> +
>  	b	transfer_to_handler_cont
