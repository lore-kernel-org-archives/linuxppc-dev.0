Return-Path: <gregory.clement@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tvNGS6rK4zDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 20:50:40 +1100 (AEDT)
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Remove CONFIG_CPU_FREQ_STAT_DETAILS config option
References: <d4299228a500a889c2b4b9e305674f3d1ea9ae06.1483604760.git.viresh.kumar@linaro.org>
Date: Thu, 05 Jan 2017 10:50:25 +0100
In-Reply-To: <d4299228a500a889c2b4b9e305674f3d1ea9ae06.1483604760.git.viresh.kumar@linaro.org>
 (Viresh Kumar's message of "Thu, 5 Jan 2017 13:57:41 +0530")
Message-ID: <877f69esym.fsf@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Viresh,
 
 On jeu., janv. 05 2017, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> This doesn't have any benefit apart from saving a small amount of memory
> when it is disabled. The ifdef hackery in the code makes it dirty
> unnecessarily.
>
> Clean it up by removing the Kconfig option completely. Few defconfigs
> are also updated and CONFIG_CPU_FREQ_STAT_DETAILS is replaced with
> CONFIG_CPU_FREQ_STAT now in them, as users wanted stats to be enabled.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/configs/exynos_defconfig         |  2 +-
>  arch/arm/configs/multi_v5_defconfig       |  2 +-
>  arch/arm/configs/multi_v7_defconfig       |  2 +-

>  arch/arm/configs/mvebu_v5_defconfig       |  2 +-
For this file:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Gregory


>  arch/arm/configs/pxa_defconfig            |  2 +-
>  arch/arm/configs/shmobile_defconfig       |  2 +-
>  arch/mips/configs/lemote2f_defconfig      |  1 -
>  arch/powerpc/configs/ppc6xx_defconfig     |  1 -
>  arch/sh/configs/sh7785lcr_32bit_defconfig |  2 +-
>  drivers/cpufreq/Kconfig                   |  8 --------
>  drivers/cpufreq/cpufreq_stats.c           | 14 --------------
>  11 files changed, 7 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 79c415c33f69..809f0bf3042a 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -24,7 +24,7 @@ CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
>  CONFIG_CPU_FREQ=y
> -CONFIG_CPU_FREQ_STAT_DETAILS=y
> +CONFIG_CPU_FREQ_STAT=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>  CONFIG_CPU_FREQ_GOV_POWERSAVE=m
>  CONFIG_CPU_FREQ_GOV_USERSPACE=m
> diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
> index 361686a362f1..69a4bd13eea5 100644
> --- a/arch/arm/configs/multi_v5_defconfig
> +++ b/arch/arm/configs/multi_v5_defconfig
> @@ -58,7 +58,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_CPU_FREQ=y
> -CONFIG_CPU_FREQ_STAT_DETAILS=y
> +CONFIG_CPU_FREQ_STAT=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>  CONFIG_CPU_IDLE=y
>  CONFIG_ARM_KIRKWOOD_CPUIDLE=y
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index b01a43851294..2dcac90eba01 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -132,7 +132,7 @@ CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_KEXEC=y
>  CONFIG_EFI=y
>  CONFIG_CPU_FREQ=y
> -CONFIG_CPU_FREQ_STAT_DETAILS=y
> +CONFIG_CPU_FREQ_STAT=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>  CONFIG_CPU_FREQ_GOV_POWERSAVE=m
>  CONFIG_CPU_FREQ_GOV_USERSPACE=m
> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
> index f7f6039419aa..4b598da0d086 100644
> --- a/arch/arm/configs/mvebu_v5_defconfig
> +++ b/arch/arm/configs/mvebu_v5_defconfig
> @@ -44,7 +44,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_CPU_FREQ=y
> -CONFIG_CPU_FREQ_STAT_DETAILS=y
> +CONFIG_CPU_FREQ_STAT=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>  CONFIG_CPU_IDLE=y
>  CONFIG_ARM_KIRKWOOD_CPUIDLE=y
> diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
> index e4314b1227a3..271dc7e78e43 100644
> --- a/arch/arm/configs/pxa_defconfig
> +++ b/arch/arm/configs/pxa_defconfig
> @@ -97,7 +97,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_CMDLINE="root=/dev/ram0 ro"
>  CONFIG_KEXEC=y
>  CONFIG_CPU_FREQ=y
> -CONFIG_CPU_FREQ_STAT_DETAILS=y
> +CONFIG_CPU_FREQ_STAT=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>  CONFIG_CPU_FREQ_GOV_POWERSAVE=m
>  CONFIG_CPU_FREQ_GOV_USERSPACE=m
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index 1b0f8ae36fb3..adeaecd831a4 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -38,7 +38,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_KEXEC=y
>  CONFIG_CPU_FREQ=y
> -CONFIG_CPU_FREQ_STAT_DETAILS=y
> +CONFIG_CPU_FREQ_STAT=y
>  CONFIG_CPU_FREQ_GOV_POWERSAVE=y
>  CONFIG_CPU_FREQ_GOV_USERSPACE=y
>  CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
> index 5da76e0e120f..bed745596d86 100644
> --- a/arch/mips/configs/lemote2f_defconfig
> +++ b/arch/mips/configs/lemote2f_defconfig
> @@ -40,7 +40,6 @@ CONFIG_PM_STD_PARTITION="/dev/hda3"
>  CONFIG_CPU_FREQ=y
>  CONFIG_CPU_FREQ_DEBUG=y
>  CONFIG_CPU_FREQ_STAT=m
> -CONFIG_CPU_FREQ_STAT_DETAILS=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>  CONFIG_CPU_FREQ_GOV_POWERSAVE=m
>  CONFIG_CPU_FREQ_GOV_USERSPACE=m
> diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
> index 3ce91a3df27f..1d2d69dd6409 100644
> --- a/arch/powerpc/configs/ppc6xx_defconfig
> +++ b/arch/powerpc/configs/ppc6xx_defconfig
> @@ -62,7 +62,6 @@ CONFIG_MPC8610_HPCD=y
>  CONFIG_GEF_SBC610=y
>  CONFIG_CPU_FREQ=y
>  CONFIG_CPU_FREQ_STAT=m
> -CONFIG_CPU_FREQ_STAT_DETAILS=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
>  CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
>  CONFIG_CPU_FREQ_GOV_POWERSAVE=m
> diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/sh7785lcr_32bit_defconfig
> index 9bdcf72ec06a..2fce54d9c388 100644
> --- a/arch/sh/configs/sh7785lcr_32bit_defconfig
> +++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
> @@ -25,7 +25,7 @@ CONFIG_SH_SH7785LCR=y
>  CONFIG_NO_HZ=y
>  CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_CPU_FREQ=y
> -CONFIG_CPU_FREQ_STAT_DETAILS=y
> +CONFIG_CPU_FREQ_STAT=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>  CONFIG_SH_CPU_FREQ=y
>  CONFIG_HEARTBEAT=y
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index d8b164a7c4e5..15adef473d42 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -37,14 +37,6 @@ config CPU_FREQ_STAT
>  
>  	  If in doubt, say N.
>  
> -config CPU_FREQ_STAT_DETAILS
> -	bool "CPU frequency transition statistics details"
> -	depends on CPU_FREQ_STAT
> -	help
> -	  Show detailed CPU frequency transition table in sysfs.
> -
> -	  If in doubt, say N.
> -
>  choice
>  	prompt "Default CPUFreq governor"
>  	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index ac284e66839c..18abd454da43 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -25,9 +25,7 @@ struct cpufreq_stats {
>  	unsigned int last_index;
>  	u64 *time_in_state;
>  	unsigned int *freq_table;
> -#ifdef CONFIG_CPU_FREQ_STAT_DETAILS
>  	unsigned int *trans_table;
> -#endif
>  };
>  
>  static int cpufreq_stats_update(struct cpufreq_stats *stats)
> @@ -46,9 +44,7 @@ static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
>  	unsigned int count = stats->max_state;
>  
>  	memset(stats->time_in_state, 0, count * sizeof(u64));
> -#ifdef CONFIG_CPU_FREQ_STAT_DETAILS
>  	memset(stats->trans_table, 0, count * count * sizeof(int));
> -#endif
>  	stats->last_time = get_jiffies_64();
>  	stats->total_trans = 0;
>  }
> @@ -84,7 +80,6 @@ static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
>  	return count;
>  }
>  
> -#ifdef CONFIG_CPU_FREQ_STAT_DETAILS
>  static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>  {
>  	struct cpufreq_stats *stats = policy->stats;
> @@ -129,7 +124,6 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>  	return len;
>  }
>  cpufreq_freq_attr_ro(trans_table);
> -#endif
>  
>  cpufreq_freq_attr_ro(total_trans);
>  cpufreq_freq_attr_ro(time_in_state);
> @@ -139,9 +133,7 @@ static struct attribute *default_attrs[] = {
>  	&total_trans.attr,
>  	&time_in_state.attr,
>  	&reset.attr,
> -#ifdef CONFIG_CPU_FREQ_STAT_DETAILS
>  	&trans_table.attr,
> -#endif
>  	NULL
>  };
>  static struct attribute_group stats_attr_group = {
> @@ -200,9 +192,7 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  
>  	alloc_size = count * sizeof(int) + count * sizeof(u64);
>  
> -#ifdef CONFIG_CPU_FREQ_STAT_DETAILS
>  	alloc_size += count * count * sizeof(int);
> -#endif
>  
>  	/* Allocate memory for time_in_state/freq_table/trans_table in one go */
>  	stats->time_in_state = kzalloc(alloc_size, GFP_KERNEL);
> @@ -211,9 +201,7 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  
>  	stats->freq_table = (unsigned int *)(stats->time_in_state + count);
>  
> -#ifdef CONFIG_CPU_FREQ_STAT_DETAILS
>  	stats->trans_table = stats->freq_table + count;
> -#endif
>  
>  	stats->max_state = count;
>  
> @@ -259,8 +247,6 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
>  	cpufreq_stats_update(stats);
>  
>  	stats->last_index = new_index;
> -#ifdef CONFIG_CPU_FREQ_STAT_DETAILS
>  	stats->trans_table[old_index * stats->max_state + new_index]++;
> -#endif
>  	stats->total_trans++;
>  }
> -- 
> 2.7.1.410.g6faf27b
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
