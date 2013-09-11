Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0AC212C0117
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 08:43:06 +1000 (EST)
Message-ID: <1378939377.12204.412.camel@snotra.buserror.net>
Subject: Re: [PATCH v3 2/4] powerpc/85xx: add hardware automatically enter
 altivec idle state
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Wed, 11 Sep 2013 17:42:57 -0500
In-Reply-To: <1378879004-2446-2-git-send-email-dongsheng.wang@freescale.com>
References: <1378879004-2446-1-git-send-email-dongsheng.wang@freescale.com>
 <1378879004-2446-2-git-send-email-dongsheng.wang@freescale.com>
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

On Wed, 2013-09-11 at 13:56 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Each core's AltiVec unit may be placed into a power savings mode
> by turning off power to the unit. Core hardware will automatically
> power down the AltiVec unit after no AltiVec instructions have
> executed in N cycles. The AltiVec power-control is triggered by hardware.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> *v3:
> Assembly code instead of C code.
> 
> *v2:
> Remove:
> delete setup_idle_hw_governor function.
> delete "Fix erratum" for rev1.
> 
> Move:
> move setup_* into __setup/restore_cpu_e6500.
> 
>  arch/powerpc/kernel/cpu_setup_fsl_booke.S | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> index bfb18c7..3c03c109 100644
> --- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> +++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> @@ -53,11 +53,30 @@ _GLOBAL(__e500_dcache_setup)
>  	isync
>  	blr
> 
> +/*
> + * FIXME - We don't know the AltiVec application scenarios.
> + */
> +#define AV_WAIT_IDLE_BIT		50 /* 1ms, TB frequency is 41.66MHZ */
> +_GLOBAL(setup_altivec_idle)
> +	mfspr	r3, SPRN_PWRMGTCR0
> +
> +	/* Enable Altivec Idle */
> +	oris	r3, r3, PWRMGTCR0_AV_IDLE_PD_EN@h
> +	li	r4, AV_WAIT_IDLE_BIT
> +
> +	/* Set Automatic AltiVec Idle Count */
> +	rlwimi	r3, r4, PWRMGTCR0_AV_IDLE_CNT_SHIFT, PWRMGTCR0_AV_IDLE_CNT
> +
> +	mtspr	SPRN_PWRMGTCR0, r3
> +
> +	blr

The FIXME comment is not clear.  If you mean that we haven't yet done
testing to determine a reasonable default value for AV_WAIT_IDLE_BIT,
then just say that.  Likewise with the FIXME comment in the pw20 patch
-- the uncertainty is due to a lack of investigation, not "because we
don't know the current state of the cpu load".

While some workloads may want a different value than whatever default we
set, that's what the sysfs interface is for.  The only thing missing
here is benchmarking to determine a good overall default.

-Scott
