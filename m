Return-Path: <rjw@rjwysocki.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F10ED1A011B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 08:39:53 +1100 (AEDT)
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by ozlabs.org (Postfix) with SMTP id 25E9714007F
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2015 08:39:51 +1100 (AEDT)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Yuantian.Tang@freescale.com
Subject: Re: [PATCH 2/2 v5] cpufreq: qoriq: rename the driver
Date: Thu, 19 Mar 2015 23:03:44 +0100
Message-ID: <1632290.3aq8l1mgG0@vostro.rjw.lan>
In-Reply-To: <1426221542-41043-2-git-send-email-Yuantian.Tang@freescale.com>
References: <1426221542-41043-1-git-send-email-Yuantian.Tang@freescale.com>
 <1426221542-41043-2-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, March 13, 2015 12:39:02 PM Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
> 
> This driver works on all QorIQ platforms which include
> ARM-based cores and PPC-based cores.
> Rename it in order to represent better.
> 
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Both queued up for 4.1, thanks!

> ---
> v5:
> 	- rebased to 4.0-rc3
> 	- added Kconfig and Makefile entry
> v3, v4
> 	- none
> v2:
> 	- use -C -M options when format-patch
> 
>  drivers/cpufreq/Kconfig                                    | 8 ++++++++
>  drivers/cpufreq/Kconfig.powerpc                            | 9 ---------
>  drivers/cpufreq/Makefile                                   | 2 +-
>  drivers/cpufreq/{ppc-corenet-cpufreq.c => qoriq-cpufreq.c} | 0
>  4 files changed, 9 insertions(+), 10 deletions(-)
>  rename drivers/cpufreq/{ppc-corenet-cpufreq.c => qoriq-cpufreq.c} (100%)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index a171fef..659879a 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -293,5 +293,13 @@ config SH_CPU_FREQ
>  	  If unsure, say N.
>  endif
>  
> +config QORIQ_CPUFREQ
> +	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
> +	depends on OF && COMMON_CLK && (PPC_E500MC || ARM)
> +	select CLK_QORIQ
> +	help
> +	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
> +	  which are capable of changing the CPU's frequency dynamically.
> +
>  endif
>  endmenu
> diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
> index 7ea2441..3a0595b 100644
> --- a/drivers/cpufreq/Kconfig.powerpc
> +++ b/drivers/cpufreq/Kconfig.powerpc
> @@ -23,15 +23,6 @@ config CPU_FREQ_MAPLE
>  	  This adds support for frequency switching on Maple 970FX
>  	  Evaluation Board and compatible boards (IBM JS2x blades).
>  
> -config PPC_CORENET_CPUFREQ
> -	tristate "CPU frequency scaling driver for Freescale E500MC SoCs"
> -	depends on PPC_E500MC && OF && COMMON_CLK
> -	select CLK_QORIQ
> -	help
> -	  This adds the CPUFreq driver support for Freescale e500mc,
> -	  e5500 and e6500 series SoCs which are capable of changing
> -	  the CPU's frequency dynamically.
> -
>  config CPU_FREQ_PMAC
>  	bool "Support for Apple PowerBooks"
>  	depends on ADB_PMU && PPC32
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 82a1821..26df0ad 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -85,7 +85,7 @@ obj-$(CONFIG_CPU_FREQ_CBE)		+= ppc-cbe-cpufreq.o
>  ppc-cbe-cpufreq-y			+= ppc_cbe_cpufreq_pervasive.o ppc_cbe_cpufreq.o
>  obj-$(CONFIG_CPU_FREQ_CBE_PMI)		+= ppc_cbe_cpufreq_pmi.o
>  obj-$(CONFIG_CPU_FREQ_MAPLE)		+= maple-cpufreq.o
> -obj-$(CONFIG_PPC_CORENET_CPUFREQ)   += ppc-corenet-cpufreq.o
> +obj-$(CONFIG_QORIQ_CPUFREQ)   		+= qoriq-cpufreq.o
>  obj-$(CONFIG_CPU_FREQ_PMAC)		+= pmac32-cpufreq.o
>  obj-$(CONFIG_CPU_FREQ_PMAC64)		+= pmac64-cpufreq.o
>  obj-$(CONFIG_PPC_PASEMI_CPUFREQ)	+= pasemi-cpufreq.o
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> similarity index 100%
> rename from drivers/cpufreq/ppc-corenet-cpufreq.c
> rename to drivers/cpufreq/qoriq-cpufreq.c
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
