Return-Path: <francescolavra.fl@gmail.com>
Message-ID: <514F0FB0.8030109@gmail.com>
Date: Sun, 24 Mar 2013 15:37:36 +0100
From: Francesco Lavra <francescolavra.fl@gmail.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: Notify all policy->cpus in
 cpufreq_notify_transition()
References: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
In-Reply-To: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Liviu.Dudau@arm.com, Steve.Bannister@arm.com,
 sparclinux@vger.kernel.org, arvind.chauhan@arm.com,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Jesper Nilsson <jesper.nilsson@axis.com>, robin.randhawa@arm.com,
 Stephen Warren <swarren@wwwdotorg.org>, cpufreq@vger.kernel.org,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, cbe-oss-dev@lists.ozlabs.org,
 Fenghua Yu <fenghua.yu@intel.com>, linaro-kernel@lists.linaro.org,
 Mike Frysinger <vapier@gentoo.org>, linux-pm@vger.kernel.org,
 Sekhar Nori <nsekhar@ti.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, rjw@sisk.pl,
 Kukjin Kim <kgene.kim@samsung.com>, Borislav Petkov <bp@alien8.de>,
 Ben Dooks <ben-linux@fluff.org>, Thomas Renninger <trenn@suse.de>,
 linux-arm-kernel@lists.infradead.org, Mikael Starvik <starvik@axis.com>,
 Tony Luck <tony.luck@intel.com>, Eric Miao <eric.y.miao@gmail.com>,
 linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>,
 Sascha Hauer <kernel@pengutronix.de>, charles.garcia-tobin@arm.com,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/24/2013 02:48 PM, Viresh Kumar wrote:
> policy->cpus contains all online cpus that have single shared clock line. And
> their frequencies are always updated together.
> 
> Many SMP system's cpufreq drivers take care of this in individual drivers but
> the best place for this code is in cpufreq core.
> 
> This patch modifies cpufreq_notify_transition() to notify frequency change for
> all cpus in policy->cpus and hence updates all users of this API.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: Mikael Starvik <starvik@axis.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Thomas Renninger <trenn@suse.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-cris-kernel@axis.com
> Cc: linux-ia64@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: cbe-oss-dev@lists.ozlabs.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm/mach-davinci/cpufreq.c              |  5 +-
>  arch/arm/mach-imx/cpufreq.c                  |  5 +-
>  arch/arm/mach-integrator/cpu.c               |  6 +--
>  arch/arm/mach-pxa/cpufreq-pxa2xx.c           |  5 +-
>  arch/arm/mach-pxa/cpufreq-pxa3xx.c           |  5 +-
>  arch/arm/mach-s3c24xx/cpufreq.c              |  8 +--
>  arch/arm/mach-sa1100/cpu-sa1100.c            |  5 +-
>  arch/arm/mach-sa1100/cpu-sa1110.c            |  5 +-
>  arch/arm/mach-tegra/cpu-tegra.c              |  6 +--
>  arch/avr32/mach-at32ap/cpufreq.c             |  5 +-
>  arch/blackfin/mach-common/cpufreq.c          | 79 ++++++++++++----------------
>  arch/cris/arch-v32/mach-a3/cpufreq.c         | 20 +++----
>  arch/cris/arch-v32/mach-fs/cpufreq.c         | 17 +++---
>  arch/ia64/kernel/cpufreq/acpi-cpufreq.c      | 22 ++++----
>  arch/mips/kernel/cpufreq/loongson2_cpufreq.c |  5 +-
>  arch/powerpc/platforms/cell/cbe_cpufreq.c    |  5 +-
>  arch/powerpc/platforms/pasemi/cpufreq.c      |  5 +-
>  arch/powerpc/platforms/powermac/cpufreq_32.c | 14 ++---
>  arch/powerpc/platforms/powermac/cpufreq_64.c |  5 +-
>  arch/sh/kernel/cpufreq.c                     |  5 +-
>  arch/sparc/kernel/us2e_cpufreq.c             | 13 ++---
>  arch/sparc/kernel/us3_cpufreq.c              | 13 ++---
>  arch/unicore32/kernel/cpu-ucv2.c             |  5 +-
>  drivers/cpufreq/acpi-cpufreq.c               | 11 +---
>  drivers/cpufreq/cpufreq-cpu0.c               | 12 ++---
>  drivers/cpufreq/cpufreq-nforce2.c            |  5 +-
>  drivers/cpufreq/cpufreq.c                    | 45 +++++++++-------
>  drivers/cpufreq/dbx500-cpufreq.c             |  6 +--
>  drivers/cpufreq/e_powersaver.c               | 11 ++--
>  drivers/cpufreq/elanfreq.c                   | 10 ++--
>  drivers/cpufreq/exynos-cpufreq.c             |  7 +--
>  drivers/cpufreq/gx-suspmod.c                 | 11 ++--
>  drivers/cpufreq/imx6q-cpufreq.c              | 12 ++---
>  drivers/cpufreq/kirkwood-cpufreq.c           | 10 ++--
>  drivers/cpufreq/longhaul.c                   | 18 ++++---
>  drivers/cpufreq/maple-cpufreq.c              |  5 +-
>  drivers/cpufreq/omap-cpufreq.c               | 11 +---
>  drivers/cpufreq/p4-clockmod.c                | 10 +---
>  drivers/cpufreq/pcc-cpufreq.c                |  5 +-
>  drivers/cpufreq/powernow-k6.c                | 12 ++---
>  drivers/cpufreq/powernow-k7.c                | 10 ++--
>  drivers/cpufreq/powernow-k8.c                | 16 +++---
>  drivers/cpufreq/s3c2416-cpufreq.c            |  5 +-
>  drivers/cpufreq/s3c64xx-cpufreq.c            |  7 ++-
>  drivers/cpufreq/s5pv210-cpufreq.c            |  5 +-
>  drivers/cpufreq/sc520_freq.c                 | 10 ++--
>  drivers/cpufreq/spear-cpufreq.c              |  7 +--
>  drivers/cpufreq/speedstep-centrino.c         | 24 ++-------
>  drivers/cpufreq/speedstep-ich.c              | 12 +----
>  drivers/cpufreq/speedstep-smi.c              |  5 +-
>  include/linux/cpufreq.h                      |  4 +-
>  51 files changed, 232 insertions(+), 337 deletions(-)
[...]
> diff --git a/arch/blackfin/mach-common/cpufreq.c b/arch/blackfin/mach-common/cpufreq.c
> index d88bd31..4e67368 100644
> --- a/arch/blackfin/mach-common/cpufreq.c
> +++ b/arch/blackfin/mach-common/cpufreq.c
> @@ -127,13 +127,13 @@ unsigned long cpu_set_cclk(int cpu, unsigned long new)
>  }
>  #endif
>  
> -static int bfin_target(struct cpufreq_policy *poli,
> +static int bfin_target(struct cpufreq_policy *policy,
>  			unsigned int target_freq, unsigned int relation)
>  {
>  #ifndef CONFIG_BF60x
>  	unsigned int plldiv;
>  #endif
> -	unsigned int index, cpu;
> +	unsigned int index;
>  	unsigned long cclk_hz;
>  	struct cpufreq_freqs freqs;
>  	static unsigned long lpj_ref;
> @@ -144,59 +144,48 @@ static int bfin_target(struct cpufreq_policy *poli,
>  	cycles_t cycles;
>  #endif
>  
> -	for_each_online_cpu(cpu) {
> -		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	if (cpufreq_frequency_table_target(policy, bfin_freq_table, target_freq,
> +				relation, &index))
> +		return -EINVAL;
>  
> -		if (!policy)
> -			continue;
> +	cclk_hz = bfin_freq_table[index].frequency;
>  
> -		if (cpufreq_frequency_table_target(policy, bfin_freq_table,
> -				 target_freq, relation, &index))
> -			return -EINVAL;
> +	freqs.old = bfin_getfreq_khz(0);
> +	freqs.new = cclk_hz;
>  
> -		cclk_hz = bfin_freq_table[index].frequency;
> +	pr_debug("cpufreq: changing cclk to %lu; target = %u, oldfreq = %u\n",
> +			cclk_hz, target_freq, freqs.old);
>  
> -		freqs.old = bfin_getfreq_khz(0);
> -		freqs.new = cclk_hz;
> -		freqs.cpu = cpu;
> -
> -		pr_debug("cpufreq: changing cclk to %lu; target = %u, oldfreq = %u\n",
> -			 cclk_hz, target_freq, freqs.old);
> -
> -		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> -		if (cpu == CPUFREQ_CPU) {
> +	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
>  #ifndef CONFIG_BF60x
> -			plldiv = (bfin_read_PLL_DIV() & SSEL) |
> -						dpm_state_table[index].csel;
> -			bfin_write_PLL_DIV(plldiv);
> +	plldiv = (bfin_read_PLL_DIV() & SSEL) | dpm_state_table[index].csel;
> +	bfin_write_PLL_DIV(plldiv);
>  #else
> -			ret = cpu_set_cclk(cpu, freqs.new * 1000);
> -			if (ret != 0) {
> -				WARN_ONCE(ret, "cpufreq set freq failed %d\n", ret);
> -				break;
> -			}
> +	ret = cpu_set_cclk(policy->cpu, freqs.new * 1000);
> +	if (ret != 0) {
> +		WARN_ONCE(ret, "cpufreq set freq failed %d\n", ret);
> +		break;

This doesn't even compile, as the break statement isn't in the
for_each_online_cpu() loop anymore.

--
Francesco
