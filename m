Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0144.outbound.protection.outlook.com [157.56.110.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B40521A0895
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 13:35:22 +1100 (AEDT)
Date: Mon, 30 Mar 2015 21:35:07 -0500
From: Scott Wood <scottwood@freescale.com>
To: chenhui zhao <chenhui.zhao@freescale.com>
Subject: Re: [4/4] powerpc/85xx: support sleep feature on QorIQ SoCs with RCPM
Message-ID: <20150331023507.GD5667@home.buserror.net>
References: <1427365095-26396-4-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1427365095-26396-4-git-send-email-chenhui.zhao@freescale.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Jason.Jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 26, 2015 at 06:18:15PM +0800, chenhui zhao wrote:
> In sleep mode, the clocks of e500 cores and unused IP blocks is
> turned off. The IP blocks which are allowed to wake up the processor
> are still running.
> 
> The sleep mode is equal to the Standby state in Linux. Use the
> command to enter sleep mode:
>   echo standby > /sys/power/state
> 
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> ---
>  arch/powerpc/Kconfig                   |  3 +-
>  arch/powerpc/platforms/85xx/Kconfig    |  5 +++
>  arch/powerpc/platforms/85xx/Makefile   |  1 +
>  arch/powerpc/platforms/85xx/qoriq_pm.c | 59 ++++++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/86xx/Kconfig    |  1 +
>  5 files changed, 67 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/platforms/85xx/qoriq_pm.c
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 9846c83..162eb53 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -233,7 +233,7 @@ config ARCH_HIBERNATION_POSSIBLE
>  config ARCH_SUSPEND_POSSIBLE
>  	def_bool y
>  	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
> -		   (PPC_85xx && !PPC_E500MC) || PPC_86xx || PPC_PSERIES \
> +		   FSL_SOC_BOOKE || PPC_86xx || PPC_PSERIES \
>  		   || 44x || 40x
>  
>  config PPC_DCR_NATIVE
> @@ -747,7 +747,6 @@ config FSL_PCI
>  
>  config FSL_PMC
>  	bool
> -	default y
>  	depends on SUSPEND && (PPC_85xx || PPC_86xx)

Get rid of this depends line if you're going to use select instead.

> +static int qoriq_suspend_valid(suspend_state_t state)
> +{
> +	unsigned int pm_modes;
> +
> +	pm_modes = qoriq_pm_ops->get_pm_modes();
> +
> +	if ((state == PM_SUSPEND_STANDBY) && (pm_modes & FSL_PM_SLEEP))
> +		return 1;

Unnecessary parentheses around ==

-Scott
