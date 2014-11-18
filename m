Return-Path: <kernelfans@gmail.com>
Received: from mail-yk0-x232.google.com (mail-yk0-x232.google.com
 [IPv6:2607:f8b0:4002:c07::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E18E71A065E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 16:17:20 +1100 (AEDT)
Received: by mail-yk0-f178.google.com with SMTP id 20so3635371yks.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 21:17:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <544DC46A.4050906@linux.vnet.ibm.com>
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
 <1413487800-7162-4-git-send-email-kernelfans@gmail.com>
 <544DC46A.4050906@linux.vnet.ibm.com>
Date: Tue, 18 Nov 2014 13:17:17 +0800
Message-ID: <CAFgQCTvPw0NRG2k5F4pGXC=LP0rC-FJfL46F71JSh4EZJ3zFRQ@mail.gmail.com>
Subject: Re: [RFC 03/11] powerpc: kvm: add interface to control kvm function
 on a core
From: Liu ping fan <kernelfans@gmail.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 27, 2014 at 12:04 PM, Preeti U Murthy
<preeti@linux.vnet.ibm.com> wrote:
> Hi Liu,
>
> On 10/17/2014 12:59 AM, kernelfans@gmail.com wrote:
>> When kvm is enabled on a core, we migrate all external irq to primary
>> thread. Since currently, the kvmirq logic is handled by the primary
>> hwthread.
>>
>> Todo: this patch lacks re-enable of irqbalance when kvm is disable on
>> the core
>
> Why is a sysfs file introduced to trigger irq migration? Why is it not
> done during kvm module insert ? And similarly spread interrupts when the
> module is removed? Isn't this a saner way ?

Consider the scene: coreA and coreB, we want to enable KVM on coreA,
while keeping coreB unchanged.
In fact, I try to acheive something un-symmetric on the platform. Do
you think it is an justification?
>>
>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/sysfs.c            | 39 ++++++++++++++++++++++++++++++++++
>>  arch/powerpc/sysdev/xics/xics-common.c | 12 +++++++++++
>>  2 files changed, 51 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
>> index 67fd2fd..a2595dd 100644
>> --- a/arch/powerpc/kernel/sysfs.c
>> +++ b/arch/powerpc/kernel/sysfs.c
>> @@ -552,6 +552,45 @@ static void sysfs_create_dscr_default(void)
>>       if (cpu_has_feature(CPU_FTR_DSCR))
>>               err = device_create_file(cpu_subsys.dev_root, &dev_attr_dscr_default);
>>  }
>> +
>> +#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
>> +#define NR_CORES     (CONFIG_NR_CPUS/threads_per_core)
>> +static DECLARE_BITMAP(kvm_on_core, NR_CORES) __read_mostly
>> +
>> +static ssize_t show_kvm_enable(struct device *dev,
>> +             struct device_attribute *attr, char *buf)
>> +{
>> +}
>> +
>> +static ssize_t __used store_kvm_enable(struct device *dev,
>> +             struct device_attribute *attr, const char *buf,
>> +             size_t count)
>> +{
>> +     struct cpumask stop_cpus;
>> +     unsigned long core, thr;
>> +
>> +     sscanf(buf, "%lx", &core);
>> +     if (core > NR_CORES)
>> +             return -1;
>> +     if (!test_bit(core, &kvm_on_core))
>> +             for (thr = 1; thr< threads_per_core; thr++)
>> +                     if (cpu_online(thr * threads_per_core + thr))
>> +                             cpumask_set_cpu(thr * threads_per_core + thr, &stop_cpus);
>
> What is the above logic trying to do? Did you mean
> cpu_online(threads_per_core * core + thr) ?
>
Yeah. My mistake, should be cpumask_set_cpu(core * threads_per_core +
thr, &stop_cpus)

>> +
>> +     stop_machine(xics_migrate_irqs_away_secondary, NULL, &stop_cpus);
>> +     set_bit(core, &kvm_on_core);
>> +     return count;
>> +}
>> +
>> +static DEVICE_ATTR(kvm_enable, 0600,
>> +     show_kvm_enable, store_kvm_enable);
>> +
>> +static void sysfs_create_kvm_enable(void)
>> +{
>> +     device_create_file(cpu_subsys.dev_root, &dev_attr_kvm_enable);
>> +}
>> +#endif
>> +
>>  #endif /* CONFIG_PPC64 */
>>
>>  #ifdef HAS_PPC_PMC_PA6T
>> diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
>> index fe0cca4..68b33d8 100644
>> --- a/arch/powerpc/sysdev/xics/xics-common.c
>> +++ b/arch/powerpc/sysdev/xics/xics-common.c
>> @@ -258,6 +258,18 @@ unlock:
>>               raw_spin_unlock_irqrestore(&desc->lock, flags);
>>       }
>>  }
>> +
>> +int xics_migrate_irqs_away_secondary(void *data)
>> +{
>> +     int cpu = smp_processor_id();
>> +     if(cpu%thread_per_core != 0) {
>> +             WARN(condition, format...);
>> +             return 0;
>> +     }
>> +     /* In fact, if we can migrate the primary, it will be more fine */
>> +     ();
>
> Isn't the aim of the patch to migrate irqs away from the secondary onto
> the primary? But from above it looks like we are returning when we find
> out that we are secondary threads, isn't it?
>
Yes, will fix in next version.

>> +     return 0;
>> +}
>>  #endif /* CONFIG_HOTPLUG_CPU */
>
> Note that xics_migrate_irqs_away() is defined under CONFIG_CPU_HOTPLUG.
> But we will need this option on PowerKVM even when hotplug is not
> configured in.
>
Yes, will fix the dependency in next version

Thx,
Fan

> Regards
> Preeti U Murthy
>>  #ifdef CONFIG_SMP
>>
>
