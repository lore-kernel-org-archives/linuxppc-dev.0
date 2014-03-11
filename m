Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0240.outbound.protection.outlook.com [207.46.163.240])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EAB272C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 10:48:24 +1100 (EST)
Message-ID: <1394581693.13761.66.camel@snotra.buserror.net>
Subject: Re: [PATCH 4/9] powerpc/85xx: support CPU hotplug for e500mc and e5500
From: Scott Wood <scottwood@freescale.com>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
Date: Tue, 11 Mar 2014 18:48:13 -0500
In-Reply-To: <1394168285-32275-4-git-send-email-chenhui.zhao@freescale.com>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-4-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jason.Jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-03-07 at 12:58 +0800, Chenhui Zhao wrote:
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index ac2621a..f3f4401 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -405,8 +405,12 @@ void generic_cpu_die(unsigned int cpu)
>  
>  	for (i = 0; i < 100; i++) {
>  		smp_rmb();
> -		if (per_cpu(cpu_state, cpu) == CPU_DEAD)
> +		if (per_cpu(cpu_state, cpu) == CPU_DEAD) {
> +#ifdef CONFIG_PPC64
> +			paca[cpu].cpu_start = 0;
> +#endif

Why wasn't this needed by previous ppc64 machines?

> diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
> index 2e5911e..0047883 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -19,6 +19,7 @@
>  #include <linux/kexec.h>
>  #include <linux/highmem.h>
>  #include <linux/cpu.h>
> +#include <linux/smp.h>
>  
>  #include <asm/machdep.h>
>  #include <asm/pgtable.h>
> @@ -46,6 +47,17 @@ static u64 timebase;
>  static int tb_req;
>  static int tb_valid;
>  
> +#ifdef CONFIG_PPC_E500MC
> +/* specify the cpu PM state when cpu dies, PH15/NAP is the default */
> +int qoriq_cpu_die_state = E500_PM_PH15;
> +#endif

static?  Is there any way to modify this other than modifying source
code?

BTW, QorIQ doesn't imply an e500mc derivative.

> @@ -125,6 +138,34 @@ static void mpc85xx_take_timebase(void)
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> +#ifdef CONFIG_PPC_E500MC
> +static void qoriq_cpu_die(void)
> +{
> +	unsigned int cpu = smp_processor_id();
> +
> +	local_irq_disable();
> +#ifdef CONFIG_PPC64
> +	__hard_irq_disable();
> +#endif

Why this instead of one call to hard_irq_disable() (no leading
underscores)?

-Scott
