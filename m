Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
 [74.125.82.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5EC962C013B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 08:11:08 +1100 (EST)
Received: by mail-we0-f169.google.com with SMTP id q58so80451wes.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Nov 2013 13:11:04 -0800 (PST)
Message-ID: <527AB066.6050805@linaro.org>
Date: Wed, 06 Nov 2013 22:11:02 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 7/7] powernv/cpuidle: Enable idle powernv cpu to call
 into the cpuidle framework.
References: <20131029110052.31547.82682.stgit@deepthi.in.ibm.com>
 <20131029110201.31547.55088.stgit@deepthi.in.ibm.com>
In-Reply-To: <20131029110201.31547.55088.stgit@deepthi.in.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: preeti@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 scottwood@freescale.com, linux-pm@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/29/2013 12:02 PM, Deepthi Dharwar wrote:
> This patch enables idle cpu on the powernv platform  to hook on to the cpuidle
> framework, if available, else call on to default idle platform
> code.
>
> Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/powerpc/platforms/powernv/setup.c |   13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index e239dcf..42a6ba0 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -25,6 +25,7 @@
>   #include <linux/of.h>
>   #include <linux/interrupt.h>
>   #include <linux/bug.h>
> +#include <linux/cpuidle.h>
>
>   #include <asm/machdep.h>
>   #include <asm/firmware.h>
> @@ -192,6 +193,16 @@ static void __init pnv_setup_machdep_rtas(void)
>   }
>   #endif /* CONFIG_PPC_POWERNV_RTAS */
>
> +void powernv_idle(void)
> +{
> +	/* Hook to cpuidle framework if available, else
> +	 * call on default platform idle code
> +	 */
> +	if (cpuidle_idle_call()) {
> +		power7_idle();
> +	}
> +}
> +
>   static int __init pnv_probe(void)
>   {
>   	unsigned long root = of_get_flat_dt_root();
> @@ -222,7 +233,7 @@ define_machine(powernv) {
>   	.show_cpuinfo		= pnv_show_cpuinfo,
>   	.progress		= pnv_progress,
>   	.machine_shutdown	= pnv_shutdown,
> -	.power_save             = power7_idle,
> +	.power_save             = powernv_idle,
>   	.calibrate_decr		= generic_calibrate_decr,
>   #ifdef CONFIG_KEXEC
>   	.kexec_cpu_down		= pnv_kexec_cpu_down,
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
