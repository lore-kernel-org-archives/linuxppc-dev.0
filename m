Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E6BCB1A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 00:01:51 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 12 Nov 2014 18:31:43 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3D82A3940053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 18:31:39 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sACD3nbJ52887798
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 18:33:50 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sACD1ZWL014669
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 18:31:37 +0530
Date: Wed, 12 Nov 2014 18:31:35 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: kernelfans@gmail.com
Subject: Re: [RFC 03/11] powerpc: kvm: add interface to control kvm function
 on a core
Message-ID: <20141112130134.GC16566@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
 <1413487800-7162-4-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1413487800-7162-4-git-send-email-kernelfans@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* kernelfans@gmail.com <kernelfans@gmail.com> [2014-10-16 15:29:52]:

> When kvm is enabled on a core, we migrate all external irq to primary
> thread. Since currently, the kvmirq logic is handled by the primary
> hwthread.
> 
> Todo: this patch lacks re-enable of irqbalance when kvm is disable on
> the core
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

Shouldnt this be 
			if (cpu_online(core * threads_per_core + thr))
				cpumask_set_cpu(core * threads_per_core + thr, &stop_cpus);
?


-- 
Thanks and Regards
Srikar Dronamraju
