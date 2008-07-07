Return-Path: <benh@kernel.crashing.org>
Subject: Re: [patch 05/11] powerpc/cell: add spu aware cpufreq governor
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: arnd@arndb.de
In-Reply-To: <20080704190806.162475834@arndb.de>
References: <20080704190535.316377278@arndb.de>
	<20080704190806.162475834@arndb.de>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 15:21:59 +1000
Message-Id: <1215408119.8970.67.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, Christian Krafft <krafft@de.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-04 at 21:05 +0200, arnd@arndb.de wrote:
> plain text document attachment
> (0005-powerpc-cell-add-spu-aware-cpufreq-governor.patch)
> This patch adds a cpufreq governor that takes the number of running spus
> into account. It's very similar to the ondemand governor, but not as complex.
> Instead of hacking spu load into the ondemand governor it might be easier to
> have cpufreq accepting multiple governors per cpu in future.
> Don't know if this is the right way, but it would keep the governors simple.
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Arnd, your S-O-B ?

Also, there's the question of whether this should also go in
drivers/cpufreq or not and should be reviewed by the cpufreq
maintainer (whoever that is), no ?

Cheers,
Ben.

> ---
>  arch/powerpc/platforms/cell/Kconfig            |   10 ++
>  arch/powerpc/platforms/cell/Makefile           |    1 +
>  arch/powerpc/platforms/cell/cbe_spu_governor.c |  183 ++++++++++++++++++++++++
>  3 files changed, 194 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/platforms/cell/cbe_spu_governor.c
> 
> diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
> index 3959fcf..2dfff9f 100644
> --- a/arch/powerpc/platforms/cell/Kconfig
> +++ b/arch/powerpc/platforms/cell/Kconfig
> @@ -107,6 +107,16 @@ config CBE_CPUFREQ_PMI
>  	  processor will not only be able to run at lower speed,
>  	  but also at lower core voltage.
>  
> +config CBE_CPUFREQ_SPU_GOVERNOR
> +	tristate "CBE frequency scaling based on SPU usage"
> +	depends on SPU_FS
> +	select CBE_CPUFREQ
> +	default m
> +	help
> +	  This governor checks for spu usage to adjust the cpu frequency.
> +	  If no spu is running on a given cpu, that cpu will be throttled to
> +	  the minimal possible frequency.
> +
>  endmenu
>  
>  config OPROFILE_CELL
> diff --git a/arch/powerpc/platforms/cell/Makefile b/arch/powerpc/platforms/cell/Makefile
> index c2a7e4e..8be5158 100644
> --- a/arch/powerpc/platforms/cell/Makefile
> +++ b/arch/powerpc/platforms/cell/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_CBE_THERM)			+= cbe_thermal.o
>  obj-$(CONFIG_CBE_CPUFREQ_PMI)		+= cbe_cpufreq_pmi.o
>  obj-$(CONFIG_CBE_CPUFREQ)		+= cbe-cpufreq.o
>  cbe-cpufreq-y				+= cbe_cpufreq_pervasive.o cbe_cpufreq.o
> +obj-$(CONFIG_CBE_CPUFREQ_SPU_GOVERNOR)	+= cbe_spu_governor.o
>  
>  ifeq ($(CONFIG_SMP),y)
>  obj-$(CONFIG_PPC_CELL_NATIVE)		+= smp.o
> diff --git a/arch/powerpc/platforms/cell/cbe_spu_governor.c b/arch/powerpc/platforms/cell/cbe_spu_governor.c
> new file mode 100644
> index 0000000..7e63009
> --- /dev/null
> +++ b/arch/powerpc/platforms/cell/cbe_spu_governor.c
> @@ -0,0 +1,183 @@
> +/*
> + * spu aware cpufreq governor for the cell processor
> + *
> + * (C) Copyright IBM Corporation 2006-2008
> + *
> + * Author: Christian Krafft <krafft@de.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/cpufreq.h>
> +#include <linux/sched.h>
> +#include <linux/timer.h>
> +#include <linux/workqueue.h>
> +#include <asm/atomic.h>
> +#include <asm/machdep.h>
> +#include <asm/spu.h>
> +
> +#define POLL_TIME	100000		/* in us */
> +#define EXP		753		/* exp(-1) in fixed-point */
> +
> +struct spu_gov_info_struct {
> +	unsigned long busy_spus;	/* fixed-point */
> +	struct cpufreq_policy *policy;
> +	struct delayed_work work;
> +	unsigned int poll_int;		/* us */
> +};
> +static DEFINE_PER_CPU(struct spu_gov_info_struct, spu_gov_info);
> +
> +static struct workqueue_struct *kspugov_wq;
> +
> +static int calc_freq(struct spu_gov_info_struct *info)
> +{
> +	int cpu;
> +	int busy_spus;
> +
> +	cpu = info->policy->cpu;
> +	busy_spus = atomic_read(&cbe_spu_info[cpu_to_node(cpu)].busy_spus);
> +
> +	CALC_LOAD(info->busy_spus, EXP, busy_spus * FIXED_1);
> +	pr_debug(KERN_ERR "cpu %d: busy_spus=%d, info->busy_spus=%d\n", cpu, busy_spus, info->busy_spus);
> +
> +	return info->policy->max * info->busy_spus / FIXED_1;
> +}
> +
> +static void spu_gov_work(struct work_struct *work)
> +{
> +	struct spu_gov_info_struct *info;
> +	int delay;
> +	unsigned long target_freq;
> +
> +	info = container_of(work, struct spu_gov_info_struct, work.work);
> +
> +	/* after cancel_delayed_work_sync we unset info->policy */
> +	BUG_ON(info->policy == NULL);
> +
> +	target_freq = calc_freq(info);
> +	__cpufreq_driver_target(info->policy, target_freq, CPUFREQ_RELATION_H);
> +
> +	delay = usecs_to_jiffies(info->poll_int);
> +	queue_delayed_work_on(info->policy->cpu, kspugov_wq, &info->work, delay);
> +}
> +
> +static void spu_gov_init_work(struct spu_gov_info_struct *info)
> +{
> +	int delay = usecs_to_jiffies(info->poll_int);
> +	INIT_DELAYED_WORK_DEFERRABLE(&info->work, spu_gov_work);
> +	queue_delayed_work_on(info->policy->cpu, kspugov_wq, &info->work, delay);
> +}
> +
> +static void spu_gov_cancel_work(struct spu_gov_info_struct *info)
> +{
> +	cancel_delayed_work_sync(&info->work);
> +}
> +
> +static int spu_gov_govern(struct cpufreq_policy *policy, unsigned int event)
> +{
> +	unsigned int cpu = policy->cpu;
> +	struct spu_gov_info_struct *info, *affected_info;
> +	int i;
> +	int ret = 0;
> +
> +	info = &per_cpu(spu_gov_info, cpu);
> +
> +	switch (event) {
> +	case CPUFREQ_GOV_START:
> +		if (!cpu_online(cpu)) {
> +			printk(KERN_ERR "cpu %d is not online\n", cpu);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (!policy->cur) {
> +			printk(KERN_ERR "no cpu specified in policy\n");
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		/* initialize spu_gov_info for all affected cpus */
> +		for_each_cpu_mask(i, policy->cpus) {
> +			affected_info = &per_cpu(spu_gov_info, i);
> +			affected_info->policy = policy;
> +		}
> +
> +		info->poll_int = POLL_TIME;
> +
> +		/* setup timer */
> +		spu_gov_init_work(info);
> +
> +		break;
> +
> +	case CPUFREQ_GOV_STOP:
> +		/* cancel timer */
> +		spu_gov_cancel_work(info);
> +
> +		/* clean spu_gov_info for all affected cpus */
> +		for_each_cpu_mask (i, policy->cpus) {
> +			info = &per_cpu(spu_gov_info, i);
> +			info->policy = NULL;
> +		}
> +
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static struct cpufreq_governor spu_governor = {
> +	.name = "spu_governor",
> +	.governor = spu_gov_govern,
> +	.owner = THIS_MODULE,
> +};
> +
> +/*
> + * module init and destoy
> + */
> +
> +static int __init spu_gov_init(void)
> +{
> +	int ret;
> +
> +	kspugov_wq = create_workqueue("kspugov");
> +	if (!kspugov_wq) {
> +		printk(KERN_ERR "creation of kspugov failed\n");
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	ret = cpufreq_register_governor(&spu_governor);
> +	if (ret) {
> +		printk(KERN_ERR "registration of governor failed\n");
> +		destroy_workqueue(kspugov_wq);
> +		goto out;
> +	}
> +out:
> +	return ret;
> +}
> +
> +static void __exit spu_gov_exit(void)
> +{
> +	cpufreq_unregister_governor(&spu_governor);
> +	destroy_workqueue(kspugov_wq);
> +}
> +
> +
> +module_init(spu_gov_init);
> +module_exit(spu_gov_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Christian Krafft <krafft@de.ibm.com>");
> +
> -- 
> 1.5.4.3
> 
