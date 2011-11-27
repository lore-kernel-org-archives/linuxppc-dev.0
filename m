Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 74365B6F99
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Nov 2011 10:05:42 +1100 (EST)
Message-ID: <1322435131.23348.17.camel@pasglop>
Subject: Re: [RFC PATCH v2 3/4] cpuidle: (POWER) Enable cpuidle and directly
 call cpuidle_idle_call() for pSeries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Mon, 28 Nov 2011 10:05:31 +1100
In-Reply-To: <20111117112852.9191.34256.stgit@localhost6.localdomain6>
References: <20111117112815.9191.2322.stgit@localhost6.localdomain6>
 <20111117112852.9191.34256.stgit@localhost6.localdomain6>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-11-17 at 16:58 +0530, Deepthi Dharwar wrote:
> This patch enables cpuidle for pSeries and cpuidle_idle_call() is
> directly called from the idle loop. As a result pseries_idle cpuidle
> driver registered with cpuidle subsystem comes into action. This patch
> also removes the routines pseries_shared_idle_sleep and
> pseries_dedicated_idle_sleep as they are now implemented as part of
> pseries_idle cpuidle driver.
> 
> Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
> Signed-off-by: Trinabh Gupta <g.trinabh@gmail.com>
> Signed-off-by: Arun R Bharadwaj <arun.r.bharadwaj@gmail.com>
> ---
>  arch/powerpc/platforms/Kconfig         |    6 ++
>  arch/powerpc/platforms/pseries/setup.c |   86 +-------------------------------
>  include/linux/cpuidle.h                |    2 -
>  3 files changed, 8 insertions(+), 86 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index e458872..0d2a028 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -211,6 +211,12 @@ config PPC_PASEMI_CPUFREQ
>  
>  endmenu
>  
> +menu "CPUIdle driver"
> +
> +source "drivers/cpuidle/Kconfig"
> +
> +endmenu
> +
>  config PPC601_SYNC_FIX
>  	bool "Workarounds for PPC601 bugs"
>  	depends on 6xx && (PPC_PREP || PPC_PMAC)
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 9c6716a..f624e74 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -39,6 +39,7 @@
>  #include <linux/irq.h>
>  #include <linux/seq_file.h>
>  #include <linux/root_dev.h>
> +#include <linux/cpuidle.h>
>  
>  #include <asm/mmu.h>
>  #include <asm/processor.h>
> @@ -74,9 +75,6 @@ EXPORT_SYMBOL(CMO_PageSize);
>  
>  int fwnmi_active;  /* TRUE if an FWNMI handler is present */
>  
> -static void pseries_shared_idle_sleep(void);
> -static void pseries_dedicated_idle_sleep(void);
> -
>  static struct device_node *pSeries_mpic_node;
>  
>  static void pSeries_show_cpuinfo(struct seq_file *m)
> @@ -374,18 +372,9 @@ static void __init pSeries_setup_arch(void)
>  
>  	pSeries_nvram_init();
>  
> -	/* Choose an idle loop */
>  	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
>  		vpa_init(boot_cpuid);
> -		if (get_lppaca()->shared_proc) {
> -			printk(KERN_DEBUG "Using shared processor idle loop\n");
> -			ppc_md.power_save = pseries_shared_idle_sleep;
> -		} else {
> -			printk(KERN_DEBUG "Using dedicated idle loop\n");
> -			ppc_md.power_save = pseries_dedicated_idle_sleep;
> -		}
> -	} else {
> -		printk(KERN_DEBUG "Using default idle loop\n");
> +		ppc_md.power_save = (void *)cpuidle_idle_call;
>  	}

I very very much dislike that cast. You should not have to cast a
function pointer ... EVER.

>  	if (firmware_has_feature(FW_FEATURE_LPAR))
> @@ -586,77 +575,6 @@ static int __init pSeries_probe(void)
>  	return 1;
>  }
>  

Cheers,
Ben.
