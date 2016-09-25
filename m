Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shdrW4PYrzDrPd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 17:24:11 +1000 (AEST)
Date: Sun, 25 Sep 2016 02:24:00 -0500
From: Scott Wood <oss@buserror.net>
To: Chenhui Zhao <chenhui.zhao@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 z.chenhui@gmail.com, jason.jin@nxp.com
Message-ID: <20160925072400.GA17928@home.buserror.net>
References: <1470139172-12699-5-git-send-email-chenhui.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470139172-12699-5-git-send-email-chenhui.zhao@nxp.com>
Subject: Re: [v3,4/5] powerpc/pm: support deep sleep feature on T104x
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 02, 2016 at 07:59:31PM +0800, Chenhui Zhao wrote:
> T104x has deep sleep feature, which can switch off most parts of
> the SoC when it is in deep sleep mode. This way, it becomes more
> energy-efficient.
> 
> The DDR controller will also be powered off in deep sleep. Therefore,
> the last stage (the latter part of fsl_dp_enter_low) will run without DDR
> access. This piece of code and related TLBs are prefetched in advance.
> 
> Due to the different initialization code between 32-bit and 64-bit, they
> have separate resume entry and precedure.
> 
> The feature supports 32-bit and 64-bit kernel mode.
> 
> Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> ---
>  arch/powerpc/include/asm/fsl_pm.h             |  24 ++
>  arch/powerpc/kernel/asm-offsets.c             |  12 +
>  arch/powerpc/kernel/fsl_booke_entry_mapping.S |  10 +
>  arch/powerpc/kernel/head_64.S                 |   2 +-
>  arch/powerpc/platforms/85xx/Makefile          |   1 +
>  arch/powerpc/platforms/85xx/deepsleep.c       | 278 ++++++++++++++
>  arch/powerpc/platforms/85xx/qoriq_pm.c        |  25 ++
>  arch/powerpc/platforms/85xx/t104x_deepsleep.S | 531 ++++++++++++++++++++++++++
>  arch/powerpc/sysdev/fsl_rcpm.c                |   8 +-
>  9 files changed, 889 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/platforms/85xx/deepsleep.c
>  create mode 100644 arch/powerpc/platforms/85xx/t104x_deepsleep.S
> 
> diff --git a/arch/powerpc/include/asm/fsl_pm.h b/arch/powerpc/include/asm/fsl_pm.h
> index e05049b..48c2631 100644
> --- a/arch/powerpc/include/asm/fsl_pm.h
> +++ b/arch/powerpc/include/asm/fsl_pm.h
> @@ -20,6 +20,7 @@
>  
>  #define PLAT_PM_SLEEP	20
>  #define PLAT_PM_LPM20	30
> +#define PLAT_PM_LPM35	40
>  
>  #define FSL_PM_SLEEP		(1 << 0)
>  #define FSL_PM_DEEP_SLEEP	(1 << 1)
> @@ -48,4 +49,27 @@ extern const struct fsl_pm_ops *qoriq_pm_ops;
>  
>  int __init fsl_rcpm_init(void);
>  
> +#ifdef CONFIG_FSL_QORIQ_PM
> +int fsl_enter_deepsleep(void);
> +int fsl_deepsleep_init(void);
> +#else
> +static inline int fsl_enter_deepsleep(void) { return -1; }
> +static inline int fsl_deepsleep_init(void) { return -1; }
> +#endif

Please return proper error codes.

Where can fsl_deepsleep_init() be called without CONFIG_FSL_QORIQ_PM?

> +
> +extern void fsl_dp_enter_low(void *priv);
> +extern void fsl_booke_deep_sleep_resume(void);
> +
> +struct fsl_iomap {
> +	void *ccsr_scfg_base;
> +	void *ccsr_rcpm_base;
> +	void *ccsr_ddr_base;
> +	void *ccsr_gpio1_base;
> +	void *ccsr_cpc_base;
> +	void *dcsr_epu_base;
> +	void *dcsr_npc_base;
> +	void *dcsr_rcpm_base;
> +	void *cpld_base;
> +	void *fpga_base;
> +};

__iomem

>  #endif /* __PPC_FSL_PM_H */
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 9ea0955..cc488f9 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -68,6 +68,10 @@
>  #include "../mm/mmu_decl.h"
>  #endif
>  
> +#ifdef CONFIG_FSL_QORIQ_PM
> +#include <asm/fsl_pm.h>
> +#endif

I know this file ifdefs headers a lot, but it's generally not good
practice.  Does including this file cause any harm on other platforms?

> diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> index 83dd0f6..659b059 100644
> --- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> +++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> @@ -173,6 +173,10 @@ skpinv:	addi	r6,r6,1				/* Increment */
>  	lis	r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_NEEDED)@h
>  	ori	r6,r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_NEEDED)@l
>  	mtspr	SPRN_MAS2,r6
> +#ifdef ENTRY_DEEPSLEEP_SETUP
> +	LOAD_REG_IMMEDIATE(r8, MEMORY_START)
> +	ori	r8,r8,(MAS3_SX|MAS3_SW|MAS3_SR)
> +#endif
>  	mtspr	SPRN_MAS3,r8
>  	tlbwe
>  

Have you tried this with a relocatable kernel?

> +static void fsl_dp_set_resume_pointer(void)
> +{
> +	u32 resume_addr;
> +
> +	/* the bootloader will finally jump to this address to return kernel */
> +#ifdef CONFIG_PPC32
> +	resume_addr = (u32)(__pa(fsl_booke_deep_sleep_resume));
> +#else
> +	resume_addr = (u32)(__pa(*(u64 *)fsl_booke_deep_sleep_resume)
> +			    & 0xffffffff);
> +#endif

Why are you masking the physical address by 0xffffffff?  Besides the
(u32) cast accomplishing the same thing, wouldn't it be a problem if
(e.g. due to a relocatable kernel) the address is above 4 GiB?

> +static void fsl_dp_pins_setup(void)
> +{
> +	u32 mask = BIT(31 - fsl_gpio_mcke);
> +
> +	/* set GPIO1_29 as an output pin (not open-drain), and output 0 */
> +	clrbits32(fsl_dp_priv.ccsr_gpio1_base + CCSR_GPIO1_GPDAT, mask);
> +	clrbits32(fsl_dp_priv.ccsr_gpio1_base + CCSR_GPIO1_GPODR, mask);
> +	setbits32(fsl_dp_priv.ccsr_gpio1_base + CCSR_GPIO1_GPDIR, mask);
> +
> +	/* wait for the stabilization of GPIO1_29 */
> +	udelay(10);
> +
> +	/* enable the functionality of pins relevant to deep sleep */
> +	if (fsl_dp_priv.cpld_base) {
> +		setbits8(fsl_dp_priv.cpld_base + QORIQ_CPLD_MISCCSR,
> +			 QORIQ_CPLD_MISCCSR_SLEEPEN);
> +	} else if (fsl_dp_priv.fpga_base) {
> +		setbits8(fsl_dp_priv.fpga_base + QIXIS_PWR_CTL2,
> +			 QIXIS_PWR_CTL2_PCTL);
> +	}
> +}

Please use callbacks to handle board-specific things.

> +/* reset time base to prevent from overflow */
> +#define DELAY(count)		\
> +	li	r3, count;	\
> +	li	r4, 0;		\
> +	mtspr	SPRN_TBWL, r4;	\
> +101:	mfspr	r4, SPRN_TBRL;	\
> +	cmpw	r4, r3;		\
> +	blt	101b

Please find a better way of dealing with overflow than writing to the
timebase.

-Scott
