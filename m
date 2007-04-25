Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 3D540DDF59
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 09:48:23 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [2.6.22] pasemi: cpufreq driver
Date: Thu, 26 Apr 2007 01:47:35 +0200
References: <20070425204633.GC19781@lixom.net>
In-Reply-To: <20070425204633.GC19781@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704260147.35878.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, egor@pasemi.com, paulus@samba.org,
	cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 25 April 2007, Olof Johansson wrote:

> +/* This should eventually come out of the device tree */
> +#define SDCPWR_BASE		0xfc104000
> +#define SDCPWR_SIZE		0x1000
> +
> +#define SDCASR_BASE		0xfc120000
> +#define SDCASR_SIZE		0x2000

the comment is right. Why don't you do it then? ;-)

> +static int pas_cpufreq_cpu_init (struct cpufreq_policy *policy)
> +{
> +	u32 *max_freq;
> +	int i, cur_astate;
> +	struct device_node *cpu;
> +
> +	cpu = of_get_cpu_node(policy->cpu, NULL);
> +
> +	if(!cpu)
> +		return -ENODEV;
> +
> +	sdcpwr_mapbase = ioremap(SDCPWR_BASE, SDCPWR_SIZE);
> +	sdcasr_mapbase = ioremap(SDCASR_BASE, SDCASR_SIZE);
> +	if (!sdcpwr_mapbase || !sdcasr_mapbase)
> +		panic("SDCMAP: Cannot map registers!");

I can't see any check in here that finds out if you are actually running on
the right hardware. 
The proper way to implement this driver would be to register an
of_platform_driver for the cpufreq device and then get the register
addresses from there,

> @@ -155,7 +155,7 @@ source "drivers/cpufreq/Kconfig"
>  
>  config CPU_FREQ_PMAC
>  	bool "Support for Apple PowerBooks"
> -	depends on CPU_FREQ && ADB_PMU && PPC32
> +	depends on ADB_PMU && PPC32
>  	select CPU_FREQ_TABLE
>  	help
>  	  This adds support for frequency switching on Apple PowerBooks,
> @@ -164,11 +164,21 @@ config CPU_FREQ_PMAC
>  
>  config CPU_FREQ_PMAC64
>  	bool "Support for some Apple G5s"
> -	depends on CPU_FREQ && PPC64
> +	depends on PPC64
>  	select CPU_FREQ_TABLE
>  	help
>  	  This adds support for frequency switching on Apple iMac G5,
>  	  and some of the more recent desktop G5 machines as well.

Why this change?

> +config PPC_PASEMI_CPUFREQ
> +	bool "Support for PA Semi PWRficient"
> +	depends on PPC_PASEMI
> +	default y
> +	select CPU_FREQ_TABLE
> +	help
> +	  This adds the support for frequency switching on PA Semi
> +	  PWRficient processors.
> +
>  endmenu

Why bool and not tristate?

	Arnd <><
