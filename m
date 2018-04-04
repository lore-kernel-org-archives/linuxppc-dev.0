Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GRkj1mCTzF1lS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 23:34:01 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w34DXwMp120610
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Apr 2018 09:33:58 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h4x3rn8mb-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 09:33:58 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 4 Apr 2018 14:33:55 +0100
Subject: Re: [PATCH 1/2] powerpc/cpu: raise DEVICE_ADD/REMOVE msg to usrspace
To: Pingfan Liu <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <1522372657-27490-1-git-send-email-kernelfans@gmail.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 4 Apr 2018 19:03:51 +0530
MIME-Version: 1.0
In-Reply-To: <1522372657-27490-1-git-send-email-kernelfans@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ec3a9f6c-0226-5f7f-ef48-b40f1b8f258e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 30 March 2018 06:47 AM, Pingfan Liu wrote:
> Some user space tools such as kexec-tools resort to the event
> add/remove to decide whether rebuilding dtb or not.
> So if a new core added and a crash happens on one of its thread,
> then kexec fails to bring up the 2nd kernel since lacking the info
> of boot-cpu-hwid in dtb. This patch uses the interface
> register_/unregister_cpu to fix the problem
>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Reported-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

Thanks for fixing this, Pingfan.
Looks good to me. I now see add/remove uevents for CPUs.
For the series...

Reviewed-by: Hari Bathini <hbathini@linux.vnet.ibm.com>


> ---
>   arch/powerpc/include/asm/smp.h               |  1 +
>   arch/powerpc/kernel/sysfs.c                  | 26 ++++++++++++++------------
>   arch/powerpc/platforms/pseries/hotplug-cpu.c |  3 ++-
>   3 files changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
> index fac963e..3ef730d 100644
> --- a/arch/powerpc/include/asm/smp.h
> +++ b/arch/powerpc/include/asm/smp.h
> @@ -35,6 +35,7 @@ extern int spinning_secondaries;
>   extern void cpu_die(void);
>   extern int cpu_to_chip_id(int cpu);
>
> +DECLARE_PER_CPU(struct cpu, cpu_devices);
>   #ifdef CONFIG_SMP
>
>   struct smp_ops_t {
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 04d0bbd..dbbcc96 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -26,7 +26,7 @@
>   #include <asm/lppaca.h>
>   #endif
>
> -static DEFINE_PER_CPU(struct cpu, cpu_devices);
> +DEFINE_PER_CPU(struct cpu, cpu_devices);
>
>   /*
>    * SMT snooze delay stuff, 64-bit only for now
> @@ -716,6 +716,16 @@ static struct device_attribute pa6t_attrs[] = {
>   #endif /* HAS_PPC_PMC_PA6T */
>   #endif /* HAS_PPC_PMC_CLASSIC */
>
> +/* Only valid if CPU is present. */
> +static ssize_t show_physical_id(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct cpu *cpu = container_of(dev, struct cpu, dev);
> +
> +	return sprintf(buf, "%d\n", get_hard_smp_processor_id(cpu->dev.id));
> +}
> +static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
> +
>   static int register_cpu_online(unsigned int cpu)
>   {
>   	struct cpu *c = &per_cpu(cpu_devices, cpu);
> @@ -723,6 +733,8 @@ static int register_cpu_online(unsigned int cpu)
>   	struct device_attribute *attrs, *pmc_attrs;
>   	int i, nattrs;
>
> +	device_create_file(&c->dev, &dev_attr_physical_id);
> +
>   	/* For cpus present at boot a reference was already grabbed in register_cpu() */
>   	if (!s->of_node)
>   		s->of_node = of_get_cpu_node(cpu, NULL);
> @@ -816,6 +828,7 @@ static int unregister_cpu_online(unsigned int cpu)
>
>   	BUG_ON(!c->hotpluggable);
>
> +	device_remove_file(s, &dev_attr_physical_id);
>   #ifdef CONFIG_PPC64
>   	if (cpu_has_feature(CPU_FTR_SMT))
>   		device_remove_file(s, &dev_attr_smt_snooze_delay);
> @@ -1017,16 +1030,6 @@ static void register_nodes(void)
>
>   #endif
>
> -/* Only valid if CPU is present. */
> -static ssize_t show_physical_id(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> -{
> -	struct cpu *cpu = container_of(dev, struct cpu, dev);
> -
> -	return sprintf(buf, "%d\n", get_hard_smp_processor_id(cpu->dev.id));
> -}
> -static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
> -
>   static int __init topology_init(void)
>   {
>   	int cpu, r;
> @@ -1049,7 +1052,6 @@ static int __init topology_init(void)
>   		if (cpu_online(cpu) || c->hotpluggable) {
>   			register_cpu(c, cpu);
>
> -			device_create_file(&c->dev, &dev_attr_physical_id);
>   		}
>   	}
>   	r = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powerpc/topology:online",
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index 652d3e96..697dfb7 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -367,6 +367,7 @@ static int dlpar_online_cpu(struct device_node *dn)
>   			cpu_maps_update_done();
>   			timed_topology_update(1);
>   			find_and_online_cpu_nid(cpu);
> +			register_cpu(&per_cpu(cpu_devices, cpu), cpu);
>   			rc = device_online(get_cpu_device(cpu));
>   			if (rc)
>   				goto out;
> @@ -541,6 +542,7 @@ static int dlpar_offline_cpu(struct device_node *dn)
>   				rc = device_offline(get_cpu_device(cpu));
>   				if (rc)
>   					goto out;
> +				unregister_cpu(container_of(get_cpu_device(cpu), struct cpu, dev));
>   				cpu_maps_update_begin();
>   				break;
>
> @@ -599,7 +601,6 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
>
>   		return saved_rc;
>   	}
> -
>   	pr_debug("Successfully removed CPU, drc index: %x\n", drc_index);
>   	return 0;
>   }
