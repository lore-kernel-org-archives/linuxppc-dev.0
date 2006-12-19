Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9CF5BDDF64
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 10:01:12 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add a device_initcall to call
	of_platform_bus_probe on all fsl SoCs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20061219153102.20ab3345.kim.phillips@freescale.com>
References: <20061219153102.20ab3345.kim.phillips@freescale.com>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 10:00:46 +1100
Message-Id: <1166569246.19254.86.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-12-19 at 15:31 -0600, Kim Phillips wrote:
> Utilize of_platform_bus_probe() in lieu of manually
> calling of_platform_device_create for each ucc_geth device
> (consequently, the QE is added to of_default_bus_ids).
> 
> This has been extended outside mpc83xx platform code,
> since other fsl SoCs are going to need it (thanks Kumar).
> 
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

Big NACK

The effect of this patch is that of_platform_bus_probe() will be
unconditionally called on anything if a paltform using fsl_soc.c is
included in the build.

I want that called by the platform code or by something called by the
platform code for FSL boards, not totally unconditional like that.

Ben.
 
> ---
>  arch/powerpc/kernel/of_platform.c |    1 +
>  arch/powerpc/sysdev/fsl_soc.c     |    9 +++++++++
>  2 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
> index 3002ea3..72da78b 100644
> --- a/arch/powerpc/kernel/of_platform.c
> +++ b/arch/powerpc/kernel/of_platform.c
> @@ -50,6 +50,7 @@ static struct of_device_id of_default_bu
>  	{ .type = "plb5", },
>  	{ .type = "plb4", },
>  	{ .type = "opb", },
> +	{ .type = "qe", },
>  	{},
>  };
>  
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
> index ad31e56..c41b851 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -28,6 +28,7 @@
>  #include <linux/fs_uart_pd.h>
>  
>  #include <asm/system.h>
> +#include <asm/of_platform.h>
>  #include <asm/atomic.h>
>  #include <asm/io.h>
>  #include <asm/irq.h>
> @@ -63,6 +64,14 @@ phys_addr_t get_immrbase(void)
>  
>  EXPORT_SYMBOL(get_immrbase);
>  
> +static int __init fsl_publish_devices(void)
> +{
> +	of_platform_bus_probe(NULL, NULL, NULL);
> +
> +	return 0;
> +}
> +device_initcall(fsl_publish_devices);
> +
>  #ifdef CONFIG_CPM2
>  
>  static u32 brgfreq = -1;
