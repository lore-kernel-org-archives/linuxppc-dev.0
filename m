Return-Path: <kernelfans@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401FNs3hyBzF0nc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 13:02:53 +1100 (AEDT)
Received: by mail-qt0-x242.google.com with SMTP id y6so1885834qtm.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 19:02:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1520909895.16434.67.camel@kernel.crashing.org>
References: <1520829790-14029-1-git-send-email-kernelfans@gmail.com>
 <1520829790-14029-2-git-send-email-kernelfans@gmail.com>
 <1520909895.16434.67.camel@kernel.crashing.org>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 14 Mar 2018 10:02:50 +0800
Message-ID: <CAFgQCTvLN+fPDS6QLfshJ7Fz9Zn==D0uEC+=zQdsz7y_vZ4NUg@mail.gmail.com>
Subject: Re: [PATCHv4 1/3] powerpc, cpu: partially unbind the mapping between
 cpu logical id and its seq in dt
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 mahesh@linux.vnet.ibm.com, cascardo@canonical.com,
 gpiccoli@linux.vnet.ibm.com, paulus@ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 13, 2018 at 10:58 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2018-03-12 at 12:43 +0800, Pingfan Liu wrote:
>> For kexec -p, the boot cpu can be not the cpu0, this causes the problem
>> to alloc paca[]. In theory, there is no requirement to assign cpu's logical
>> id as its present seq by device tree. But we have something like
>> cpu_first_thread_sibling(), which makes assumption on the mapping inside
>> a core. Hence partially changing the mapping, i.e. unbind the mapping of
>> core while keep the mapping inside a core. After this patch, boot-cpu
>> will always be mapped into the range [0,threads_per_core).
>
> I'm ok with the idea but not fan of the implementation:
>
>> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>> ---
>>  arch/powerpc/include/asm/smp.h     |  1 +
>>  arch/powerpc/kernel/prom.c         | 25 ++++++++++++++-----------
>>  arch/powerpc/kernel/setup-common.c | 21 +++++++++++++++++++++
>>  3 files changed, 36 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
>> index fac963e..1299100 100644
>> --- a/arch/powerpc/include/asm/smp.h
>> +++ b/arch/powerpc/include/asm/smp.h
>> @@ -30,6 +30,7 @@
>>  #include <asm/percpu.h>
>>
>>  extern int boot_cpuid;
>> +extern int boot_cpuhwid;
>>  extern int spinning_secondaries;
>>
>>  extern void cpu_die(void);
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index da67606..d0ebb25 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -315,8 +315,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
>>       const __be32 *intserv;
>>       int i, nthreads;
>>       int len;
>> -     int found = -1;
>> -     int found_thread = 0;
>> +     bool found = false;
>>
>>       /* We are scanning "cpu" nodes only */
>>       if (type == NULL || strcmp(type, "cpu") != 0)
>> @@ -341,8 +340,11 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
>>               if (fdt_version(initial_boot_params) >= 2) {
>>                       if (be32_to_cpu(intserv[i]) ==
>>                           fdt_boot_cpuid_phys(initial_boot_params)) {
>> -                             found = boot_cpu_count;
>> -                             found_thread = i;
>> +                             /* always map the boot-cpu logical id into the
>> +                              * the range of [0, thread_per_core)
>> +                              */
>> +                             boot_cpuid = i;
>> +                             found = true;
>>                       }
>
> Call it boot_thread_id
>
But I think boot_cpuid has the meaning of global index, while the
thread_id has the meaning of index in a core.

>>               } else {
>>                       /*
>> @@ -351,8 +353,10 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
>>                        * off secondary threads.
>>                        */
>>                       if (of_get_flat_dt_prop(node,
>> -                                     "linux,boot-cpu", NULL) != NULL)
>> -                             found = boot_cpu_count;
>> +                                     "linux,boot-cpu", NULL) != NULL) {
>> +                             boot_cpuid = i;
>> +                             found = true;
>> +                     }
>>               }
>>  #ifdef CONFIG_SMP
>>               /* logical cpu id is always 0 on UP kernels */
>> @@ -361,13 +365,12 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
>>       }
>>
>>       /* Not the boot CPU */
>> -     if (found < 0)
>> +     if (!found)
>>               return 0;
>>
>> -     DBG("boot cpu: logical %d physical %d\n", found,
>> -         be32_to_cpu(intserv[found_thread]));
>> -     boot_cpuid = found;
>> -     set_hard_smp_processor_id(found, be32_to_cpu(intserv[found_thread]));
>> +     boot_cpuhwid = be32_to_cpu(intserv[boot_cpuid]);
>> +     DBG("boot cpu: logical %d physical %d\n", boot_cpuid, boot_cpuhwid);
>> +     set_hard_smp_processor_id(boot_cpuid, boot_cpuhwid);
>>
>>       /*
>>        * PAPR defines "logical" PVR values for cpus that
>> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
>> index 66f7cc6..1a67344 100644
>> --- a/arch/powerpc/kernel/setup-common.c
>> +++ b/arch/powerpc/kernel/setup-common.c
>> @@ -86,6 +86,7 @@ struct machdep_calls *machine_id;
>>  EXPORT_SYMBOL(machine_id);
>>
>>  int boot_cpuid = -1;
>> +int boot_cpuhwid = -1;
>>  EXPORT_SYMBOL_GPL(boot_cpuid);
>>
>>  /*
>> @@ -459,11 +460,17 @@ static void __init cpu_init_thread_core_maps(int tpc)
>>  void __init smp_setup_cpu_maps(void)
>>  {
>>       struct device_node *dn;
>> +     struct device_node *boot_dn = NULL;
>> +     bool handling_bootdn = true;
>>       int cpu = 0;
>>       int nthreads = 1;
>>
>>       DBG("smp_setup_cpu_maps()\n");
>>
>> +again:
>> +     /* E.g. kexec will not boot from the 1st core. So firstly loop to find out
>> +      * the dn of boot-cpu, and map them onto [0, nthreads)
>> +      */
>>       for_each_node_by_type(dn, "cpu") {
>>               const __be32 *intserv;
>>               __be32 cpu_be;
>> @@ -488,6 +495,16 @@ void __init smp_setup_cpu_maps(void)
>>
>>               nthreads = len / sizeof(int);
>>
>> +             if (handling_bootdn) {
>> +                     if (boot_cpuid < nthreads &&
>> +                             be32_to_cpu(intserv[boot_cpuid]) == boot_cpuhwid) {
>> +                             boot_dn = dn;
>> +                     }
>> +                     if (boot_dn == NULL)
>> +                             continue;
>> +             } else if (dn == boot_dn)
>> +                     continue;
>> +
>>               for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
>>                       bool avail;
>>
>> @@ -509,6 +526,10 @@ void __init smp_setup_cpu_maps(void)
>>                       of_node_put(dn);
>>                       break;
>>               }
>> +             if (handling_bootdn) {
>> +                     handling_bootdn = false;
>> +                     goto again;
>> +             }
>>       }
>
> You don't need that "again" loop and "handling_bootdn" weird boolean.
>
> Instead, start with cpu = 1 instead of cpu = 0, and rename it to
> "next_cpu".
>
> Then, before the thread loop, check if we are on the same core
> as boot_cpuhwid:
>
>         if (same_core_as_boot_cpu(intserv)) {
>                 cpu = 0;
>         } else if (next_cpu < nr_cpus_ids) {
>                 cpu = next_cpu++;
>         } else {
>                 of_node_put(dn);
>                 break;
>         }
>
OK.


Thanks for your review.

Regards,
Pingfan
