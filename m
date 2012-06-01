Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9749DB7007
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2012 07:54:45 +1000 (EST)
Message-ID: <4FC93A1B.8060209@freescale.com>
Date: Fri, 1 Jun 2012 16:54:35 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v5 3/5] powerpc/85xx: add sleep and deep sleep support
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <1336737235-15370-3-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1336737235-15370-3-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/11/2012 06:53 AM, Zhao Chenhui wrote:
> From: Li Yang <leoli@freescale.com>
> 
> In sleep PM mode, the clocks of e500 core and unused IP blocks is
> turned off. IP blocks which are allowed to wake up the processor
> are still running.
> 
> Some Freescale chips like MPC8536 and P1022 has deep sleep PM mode
> in addtion to the sleep PM mode.
> 
> While in deep sleep PM mode, additionally, the power supply is
> removed from e500 core and most IP blocks. Only the blocks needed
> to wake up the chip out of deep sleep are ON.
> 
> This patch supports 32-bit and 36-bit address space.
> 
> The sleep mode is equal to the Standby state in Linux. The deep sleep
> mode is equal to the Suspend-to-RAM state of Linux Power Management.
> 
> Command to enter sleep mode.
>   echo standby > /sys/power/state
> Command to enter deep sleep mode.
>   echo mem > /sys/power/state
> 
> Signed-off-by: Dave Liu <daveliu@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Jin Qing <b24347@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Cc: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
> Changes for v5:
>  * Rename flush_disable_L1 to __flush_disable_L1.
> 
>  arch/powerpc/Kconfig                  |    2 +-
>  arch/powerpc/include/asm/cacheflush.h |    5 +
>  arch/powerpc/kernel/Makefile          |    3 +
>  arch/powerpc/kernel/l2cache_85xx.S    |   53 +++
>  arch/powerpc/platforms/85xx/Makefile  |    3 +
>  arch/powerpc/platforms/85xx/sleep.S   |  609 +++++++++++++++++++++++++++++++++
>  arch/powerpc/sysdev/fsl_pmc.c         |   91 ++++-
>  arch/powerpc/sysdev/fsl_soc.h         |    5 +
>  8 files changed, 752 insertions(+), 19 deletions(-)
>  create mode 100644 arch/powerpc/kernel/l2cache_85xx.S
>  create mode 100644 arch/powerpc/platforms/85xx/sleep.S
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index d65ae35..039f0a6 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -673,7 +673,7 @@ config FSL_PCI
>  config FSL_PMC
>  	bool
>  	default y
> -	depends on SUSPEND && (PPC_85xx || PPC_86xx)
> +	depends on SUSPEND && (PPC_85xx || PPC_86xx) && !PPC_E500MC
>  	help
>  	  Freescale MPC85xx/MPC86xx power management controller support
>  	  (suspend/resume). For MPC83xx see platforms/83xx/suspend.c
> diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
> index 94ec20a..baa000c 100644
> --- a/arch/powerpc/include/asm/cacheflush.h
> +++ b/arch/powerpc/include/asm/cacheflush.h
> @@ -33,6 +33,11 @@ extern void flush_dcache_page(struct page *page);
>  #if defined(CONFIG_FSL_BOOKE) || defined(CONFIG_6xx)
>  extern void __flush_disable_L1(void);
>  #endif
> +#if defined(CONFIG_FSL_BOOKE)
> +extern void flush_dcache_L1(void);
> +#else
> +#define flush_dcache_L1()	do { } while (0)
> +#endif

It doesn't seem right to no-op this on other platforms.

>  extern void __flush_icache_range(unsigned long, unsigned long);
>  static inline void flush_icache_range(unsigned long start, unsigned long stop)
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index f5808a3..cb70dba 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -64,6 +64,9 @@ obj-$(CONFIG_FA_DUMP)		+= fadump.o
>  ifeq ($(CONFIG_PPC32),y)
>  obj-$(CONFIG_E500)		+= idle_e500.o
>  endif
> +ifneq ($(CONFIG_PPC_E500MC),y)
> +obj-$(CONFIG_PPC_85xx)		+= l2cache_85xx.o
> +endif

Can we introduce a symbol that specifically means pre-e500mc e500,
rather than using negative logic?

I think something like CONFIG_PPC_E500_V1_V2 has been proposed before.

> -static int pmc_probe(struct platform_device *ofdev)
> +static int pmc_probe(struct platform_device *pdev)
>  {
> -	pmc_regs = of_iomap(ofdev->dev.of_node, 0);
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	pmc_regs = of_iomap(np, 0);
>  	if (!pmc_regs)
>  		return -ENOMEM;
>  
> -	pmc_dev = &ofdev->dev;
> +	pmc_flag = PMC_SLEEP;
> +	if (of_device_is_compatible(np, "fsl,mpc8536-pmc"))
> +		pmc_flag |= PMC_DEEP_SLEEP;
> +
> +	if (of_device_is_compatible(np, "fsl,p1022-pmc"))
> +		pmc_flag |= PMC_DEEP_SLEEP;
> +
>  	suspend_set_ops(&pmc_suspend_ops);
> +
> +	pr_info("Freescale PMC driver\n");

If you're going to be noisy on probe, at least provide some useful info
like whether deep sleep or jog are supported.

>  	return 0;
>  }
>  
> diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
> index c6d0073..949377d 100644
> --- a/arch/powerpc/sysdev/fsl_soc.h
> +++ b/arch/powerpc/sysdev/fsl_soc.h
> @@ -48,5 +48,10 @@ extern struct platform_diu_data_ops diu_ops;
>  void fsl_hv_restart(char *cmd);
>  void fsl_hv_halt(void);
>  
> +/*
> + * Cast the ccsrbar to 64-bit parameter so that the assembly
> + * code can be compatible with both 32-bit & 36-bit.
> + */
> +extern void mpc85xx_enter_deep_sleep(u64 ccsrbar, u32 powmgtreq);

s/Cast the ccsrbar to 64-bit parameter/ccsrbar is u64 rather than
phys_addr_t/

-Scott
