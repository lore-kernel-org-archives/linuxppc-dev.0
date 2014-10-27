Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C8571A006B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 15:05:22 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 27 Oct 2014 00:05:18 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2E15D38C804A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 00:05:15 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9R45Ffg19595270
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 04:05:15 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9R45EMo021580
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 00:05:14 -0400
Message-ID: <544DC46A.4050906@linux.vnet.ibm.com>
Date: Mon, 27 Oct 2014 09:34:58 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: kernelfans@gmail.com, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Subject: Re: [RFC 03/11] powerpc: kvm: add interface to control kvm function
 on a core
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
 <1413487800-7162-4-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1413487800-7162-4-git-send-email-kernelfans@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Liu,

On 10/17/2014 12:59 AM, kernelfans@gmail.com wrote:
> When kvm is enabled on a core, we migrate all external irq to primary
> thread. Since currently, the kvmirq logic is handled by the primary
> hwthread.
> 
> Todo: this patch lacks re-enable of irqbalance when kvm is disable on
> the core

Why is a sysfs file introduced to trigger irq migration? Why is it not
done during kvm module insert ? And similarly spread interrupts when the
module is removed? Isn't this a saner way ?
> 
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/sysfs.c            | 39 ++++++++++++++++++++++++++++++++++
>  arch/powerpc/sysdev/xics/xics-common.c | 12 +++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 67fd2fd..a2595dd 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -552,6 +552,45 @@ static void sysfs_create_dscr_default(void)
>  	if (cpu_has_feature(CPU_FTR_DSCR))
>  		err = device_create_file(cpu_subsys.dev_root, &dev_attr_dscr_default);
>  }
> +
> +#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
> +#define NR_CORES	(CONFIG_NR_CPUS/threads_per_core)
> +static DECLARE_BITMAP(kvm_on_core, NR_CORES) __read_mostly
> +
> +static ssize_t show_kvm_enable(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +}
> +
> +static ssize_t __used store_kvm_enable(struct device *dev,
> +		struct device_attribute *attr, const char *buf,
> +		size_t count)
> +{
> +	struct cpumask stop_cpus;
> +	unsigned long core, thr;
> +
> +	sscanf(buf, "%lx", &core);
> +	if (core > NR_CORES)
> +		return -1;
> +	if (!test_bit(core, &kvm_on_core))
> +		for (thr = 1; thr< threads_per_core; thr++)
> +			if (cpu_online(thr * threads_per_core + thr))
> +				cpumask_set_cpu(thr * threads_per_core + thr, &stop_cpus);

What is the above logic trying to do? Did you mean
cpu_online(threads_per_core * core + thr) ?

> +
> +	stop_machine(xics_migrate_irqs_away_secondary, NULL, &stop_cpus);
> +	set_bit(core, &kvm_on_core);
> +	return count;
> +}
> +
> +static DEVICE_ATTR(kvm_enable, 0600,
> +	show_kvm_enable, store_kvm_enable);
> +
> +static void sysfs_create_kvm_enable(void)
> +{
> +	device_create_file(cpu_subsys.dev_root, &dev_attr_kvm_enable);
> +}
> +#endif
> +
>  #endif /* CONFIG_PPC64 */
>  
>  #ifdef HAS_PPC_PMC_PA6T
> diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
> index fe0cca4..68b33d8 100644
> --- a/arch/powerpc/sysdev/xics/xics-common.c
> +++ b/arch/powerpc/sysdev/xics/xics-common.c
> @@ -258,6 +258,18 @@ unlock:
>  		raw_spin_unlock_irqrestore(&desc->lock, flags);
>  	}
>  }
> +
> +int xics_migrate_irqs_away_secondary(void *data)
> +{
> +	int cpu = smp_processor_id();
> +	if(cpu%thread_per_core != 0) {
> +		WARN(condition, format...);
> +		return 0;
> +	}
> +	/* In fact, if we can migrate the primary, it will be more fine */
> +	xics_migrate_irqs_away();

Isn't the aim of the patch to migrate irqs away from the secondary onto
the primary? But from above it looks like we are returning when we find
out that we are secondary threads, isn't it?

> +	return 0;
> +}
>  #endif /* CONFIG_HOTPLUG_CPU */

Note that xics_migrate_irqs_away() is defined under CONFIG_CPU_HOTPLUG.
But we will need this option on PowerKVM even when hotplug is not
configured in.

Regards
Preeti U Murthy
>  #ifdef CONFIG_SMP
> 
