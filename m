Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3FFBE2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 04:57:04 +1000 (EST)
Message-ID: <1378407402.12204.106.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 3/3] powerpc/85xx: add hardware automatically enter
 pw20 state
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Thu, 5 Sep 2013 13:56:42 -0500
In-Reply-To: <1377592900-5020-3-git-send-email-dongsheng.wang@freescale.com>
References: <1377592900-5020-1-git-send-email-dongsheng.wang@freescale.com>
 <1377592900-5020-3-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-08-27 at 16:41 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Using hardware features make core automatically enter PW20 state.
> Set a TB count to hardware, the effective count begins when PW10
> is entered. When the effective period has expired, the core will
> proceed from PW10 to PW20 if no exit conditions have occurred during
> the period.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> Remove:
> delete setup_idle_hw_governor function.
> delete "Fix erratum" for rev1.
> 
> Move:
> move setup_* into __setup/restore_cpu_e6500.
> 
> diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
> index 8364bbe..e846495 100644
> --- a/arch/powerpc/include/asm/reg_booke.h
> +++ b/arch/powerpc/include/asm/reg_booke.h
> @@ -219,6 +219,7 @@
>  
>  /* Bit definitions for PWRMGTCR0. */
>  #define PWRMGTCR0_ALTIVEC_IDLE	(1 << 22) /* Altivec idle enable */
> +#define PWRMGTCR0_PW20_WAIT	(1 << 14) /* PW20 state enable bit */
>  
>  /* Bit definitions for the MCSR. */
>  #define MCSR_MCS	0x80000000 /* Machine Check Summary */
> diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> index 90bbb46..295ccb5 100644
> --- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> +++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> @@ -59,6 +59,7 @@ _GLOBAL(__setup_cpu_e6500)
>  	bl	.setup_altivec_ivors
>  #endif
>  	bl	setup_altivec_idle
> +	bl	setup_pw20_idle
>  	bl	__setup_cpu_e5500
>  	mtlr	r6
>  	blr
> @@ -121,6 +122,7 @@ _GLOBAL(__restore_cpu_e6500)
>  	mflr	r5
>  	bl	.setup_altivec_ivors
>  	bl	setup_altivec_idle
> +	bl	setup_pw20_idle
>  	bl	__restore_cpu_e5500
>  	mtlr	r5
>  	blr
> diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
> index 93b563b..cdd526e 100644
> --- a/arch/powerpc/platforms/85xx/common.c
> +++ b/arch/powerpc/platforms/85xx/common.c
> @@ -15,12 +15,22 @@
>  
>  #define ALTIVEC_COUNT_OFFSET		16
>  #define ALTIVEC_IDLE_COUNT_MASK		0x003f0000
> +#define PW20_COUNT_OFFSET		8
> +#define PW20_IDLE_COUNT_MASK		0x00003f00
>  
>  /*
>   * FIXME - We don't know the AltiVec application scenarios.
>   */
>  #define ALTIVEC_IDLE_TIME_BIT	14 /* 1ms */
>  
> +/*
> + * FIXME - We don't know, what time should we let the core into PW20 state.
> + * because we don't know the current state of the cpu load. And threads are
> + * independent, so we can not know the state of different thread has been
> + * idle.
> + */
> +#define PW20_IDLE_TIME_BIT	14 /* 1ms */
> +
>  static struct of_device_id __initdata mpc85xx_common_ids[] = {
>  	{ .type = "soc", },
>  	{ .compatible = "soc", },
> @@ -125,3 +135,25 @@ void setup_altivec_idle(void)
>  
>  	mtspr(SPRN_PWRMGTCR0, altivec_idle);
>  }
> +
> +void setup_pw20_idle(void)
> +{
> +	u32 pw20_idle;
> +
> +	if (!has_pw20_altivec_idle())
> +		return;
> +
> +	pw20_idle = mfspr(SPRN_PWRMGTCR0);
> +
> +	/* Set PW20_WAIT bit, Enable PW20 State */
> +	pw20_idle |= PWRMGTCR0_PW20_WAIT;
> +
> +	/* Set Automatic PW20 Core Idle Count */
> +	/* clear count */
> +	pw20_idle &= ~PW20_IDLE_COUNT_MASK;
> +
> +	/* set count */
> +	pw20_idle |= ((MAX_BIT - PW20_IDLE_TIME_BIT) << PW20_COUNT_OFFSET);
> +
> +	mtspr(SPRN_PWRMGTCR0, pw20_idle);
> +}

You can't call C code from __restore_cpu_e6500 as you don't have a stack
yet.

-Scott
