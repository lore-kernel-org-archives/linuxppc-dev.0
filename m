Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3BF67140087
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 20:39:10 +1100 (EST)
Received: by mail-wg0-f47.google.com with SMTP id x12so8593687wgg.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Apr 2014 02:39:06 -0700 (PDT)
Message-ID: <533BDAC9.6090702@linaro.org>
Date: Wed, 02 Apr 2014 11:39:21 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Dongsheng Wang <dongsheng.wang@freescale.com>,
 scottwood@freescale.com
Subject: Re: [PATCH] cpuidle: add freescale e500 family porcessors idle support
References: <1396341234-40515-1-git-send-email-dongsheng.wang@freescale.com>
 <533BDA11.9080905@linaro.org>
In-Reply-To: <533BDA11.9080905@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: chenhui.zhao@freescale.com, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, jason.jin@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2014 11:36 AM, Daniel Lezcano wrote:

> On 04/01/2014 10:33 AM, Dongsheng Wang wrote:
>> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>>
>> Add cpuidle support for e500 family, using cpuidle framework to
>> manage various low power modes. The new implementation will remain
>> compatible with original idle method.
>>
>> I have done test about power consumption and latency. Cpuidle framework
>> will make CPU response time faster than original method, but power
>> consumption is higher than original method.
>>
>> Power consumption:
>> The original method, power consumption is 10.51202 (W).
>> The cpuidle framework, power consumption is 10.5311 (W).
>>
>> Latency:
>> The original method, avg latency is 6782 (us).
>> The cpuidle framework, avg latency is 6482 (us).
>>
>> Initially, this supports PW10, PW20 and subsequent patches will support
>> DOZE/NAP and PH10, PH20.
>>
>> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

Please fix Rafael's email when resending/answering.

Thanks

   -- Daniel

>> diff --git a/arch/powerpc/include/asm/machdep.h
>> b/arch/powerpc/include/asm/machdep.h
>> index 5b6c03f..9301420 100644
>> --- a/arch/powerpc/include/asm/machdep.h
>> +++ b/arch/powerpc/include/asm/machdep.h
>> @@ -294,6 +294,15 @@ extern void power7_idle(void);
>>   extern void ppc6xx_idle(void);
>>   extern void book3e_idle(void);
>>
>> +static inline void cpuidle_wait(void)
>> +{
>> +#ifdef CONFIG_PPC64
>> +    book3e_idle();
>> +#else
>> +    e500_idle();
>> +#endif
>> +}
>> +
>>   /*
>>    * ppc_md contains a copy of the machine description structure for the
>>    * current platform. machine_id contains the initial address where the
>> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
>> index 97e1dc9..edd193f 100644
>> --- a/arch/powerpc/kernel/sysfs.c
>> +++ b/arch/powerpc/kernel/sysfs.c
>> @@ -190,6 +190,9 @@ static ssize_t show_pw20_wait_time(struct device
>> *dev,
>>       return sprintf(buf, "%llu\n", time > 0 ? time : 0);
>>   }
>>
>> +#ifdef CONFIG_CPU_IDLE_E500
>> +u32 cpuidle_entry_bit;
>> +#endif
>>   static void set_pw20_wait_entry_bit(void *val)
>>   {
>>       u32 *value = val;
>> @@ -204,7 +207,11 @@ static void set_pw20_wait_entry_bit(void *val)
>>       /* set count */
>>       pw20_idle |= ((MAX_BIT - *value) << PWRMGTCR0_PW20_ENT_SHIFT);
>>
>> +#ifdef CONFIG_CPU_IDLE_E500
>> +    cpuidle_entry_bit = *value;
>> +#else
>>       mtspr(SPRN_PWRMGTCR0, pw20_idle);
>> +#endif
>>   }
>>
>>   static ssize_t store_pw20_wait_time(struct device *dev,
>> diff --git a/drivers/cpuidle/Kconfig.powerpc
>> b/drivers/cpuidle/Kconfig.powerpc
>> index 66c3a09..0949dbf 100644
>> --- a/drivers/cpuidle/Kconfig.powerpc
>> +++ b/drivers/cpuidle/Kconfig.powerpc
>> @@ -18,3 +18,10 @@ config POWERNV_CPUIDLE
>>       help
>>         Select this option to enable processor idle state management
>>         through cpuidle subsystem.
>> +
>> +config CPU_IDLE_E500
>> +    bool "CPU Idle Driver for E500 family processors"
>> +    depends on CPU_IDLE
>> +    depends on FSL_SOC_BOOKE
>> +    help
>> +      Select this to enable cpuidle on e500 family processors.
>> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
>> index f71ae1b..7e6adea 100644
>> --- a/drivers/cpuidle/Makefile
>> +++ b/drivers/cpuidle/Makefile
>> @@ -18,3 +18,4 @@ obj-$(CONFIG_ARM_AT91_CPUIDLE)          +=
>> cpuidle-at91.o
>>   # POWERPC drivers
>>   obj-$(CONFIG_PSERIES_CPUIDLE)        += cpuidle-pseries.o
>>   obj-$(CONFIG_POWERNV_CPUIDLE)        += cpuidle-powernv.o
>> +obj-$(CONFIG_CPU_IDLE_E500)        += cpuidle-e500.o
>> diff --git a/drivers/cpuidle/cpuidle-e500.c
>> b/drivers/cpuidle/cpuidle-e500.c
>> new file mode 100644
>> index 0000000..ddc0def
>> --- /dev/null
>> +++ b/drivers/cpuidle/cpuidle-e500.c
>> @@ -0,0 +1,194 @@
>> +/*
>> + * CPU Idle driver for Freescale PowerPC e500 family processors.
>> + *
>> + * Copyright 2014 Freescale Semiconductor, Inc.
>> + *
>> + * Author: Dongsheng Wang <dongsheng.wang@freescale.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/cpu.h>
>> +#include <linux/cpuidle.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/notifier.h>
>> +
>> +#include <asm/cputable.h>
>> +#include <asm/machdep.h>
>> +#include <asm/mpc85xx.h>
>> +
>> +static unsigned int max_idle_state;
>> +static struct cpuidle_state *cpuidle_state_table;
>> +
>> +struct cpuidle_driver e500_idle_driver = {
>> +    .name = "e500_idle",
>> +    .owner = THIS_MODULE,
>> +};
>> +
>> +static void e500_cpuidle(void)
>> +{
>> +    if (cpuidle_idle_call())
>> +        cpuidle_wait();
>> +}
>
> Nope, that has been changed. No more call to cpuidle_idle_call in a driver.
>
>> +
>> +static int pw10_enter(struct cpuidle_device *dev,
>> +            struct cpuidle_driver *drv, int index)
>> +{
>> +    cpuidle_wait();
>> +    return index;
>> +}
>> +
>> +#define MAX_BIT    63
>> +#define MIN_BIT    1
>> +extern u32 cpuidle_entry_bit;
>> +static int pw20_enter(struct cpuidle_device *dev,
>> +        struct cpuidle_driver *drv, int index)
>> +{
>> +    u32 pw20_idle;
>> +    u32 entry_bit;
>> +    pw20_idle = mfspr(SPRN_PWRMGTCR0);
>> +    if ((pw20_idle & PWRMGTCR0_PW20_ENT) != PWRMGTCR0_PW20_ENT) {
>> +        pw20_idle &= ~PWRMGTCR0_PW20_ENT;
>> +        entry_bit = MAX_BIT - cpuidle_entry_bit;
>> +        pw20_idle |= (entry_bit << PWRMGTCR0_PW20_ENT_SHIFT);
>> +        mtspr(SPRN_PWRMGTCR0, pw20_idle);
>> +    }
>> +
>> +    cpuidle_wait();
>> +
>> +    pw20_idle &= ~PWRMGTCR0_PW20_ENT;
>> +    pw20_idle |= (MIN_BIT << PWRMGTCR0_PW20_ENT_SHIFT);
>> +    mtspr(SPRN_PWRMGTCR0, pw20_idle);
>> +
>> +    return index;
>> +}
>
> Is it possible to give some comments and encapsulate the code with
> explicit function names to be implemented in an arch specific directory
> file (eg. pm.c) and export these functions in a linux/ header ? We try
> to prevent to include asm if possible.
>
>> +
>> +static struct cpuidle_state pw_idle_states[] = {
>> +    {
>> +        .name = "pw10",
>> +        .desc = "pw10",
>> +        .flags = CPUIDLE_FLAG_TIME_VALID,
>> +        .exit_latency = 0,
>> +        .target_residency = 0,
>> +        .enter = &pw10_enter
>> +    },
>> +
>> +    {
>> +        .name = "pw20",
>> +        .desc = "pw20-core-idle",
>> +        .flags = CPUIDLE_FLAG_TIME_VALID,
>> +        .exit_latency = 1,
>> +        .target_residency = 50,
>> +        .enter = &pw20_enter
>> +    },
>> +};
>
> No need to define this intermediate structure here, you can directly
> initialize the cpuidle_driver:
>
>
> struct cpuidle_driver e500_idle_driver = {
>      .name = "e500_idle",
>      .owner = THIS_MODULE,
>      .states = {
>          .name = "pw10",
>          .desc = "pw10",
>          .flags = CPUIDLE_FLAG_TIME_VALID,
>          .target_residency = 0,
>          .enter = &pw10_enter,
>      },
>
>      ....
>
>      .state_count = 2,
> };
>
> Then in the init function you initialize the state_count consequently:
>
> if (PVR_VER(cur_cpu_spec->pvr_value) != PVR_VER_E6500)
>      drv->state_count = 1;
>
> Then you can kill:
>
> max_idle_state, cpuidle_state_table, e500_idle_state_probe and
> pw_idle_states.
>
>> +
>> +static int cpu_hotplug_notify(struct notifier_block *n,
>> +            unsigned long action, void *hcpu)
>> +{
>> +    unsigned long hotcpu = (unsigned long)hcpu;
>> +    struct cpuidle_device *dev =
>> +            per_cpu_ptr(cpuidle_devices, hotcpu);
>> +
>> +    if (dev && cpuidle_get_driver()) {
>> +        switch (action) {
>> +        case CPU_ONLINE:
>> +        case CPU_ONLINE_FROZEN:
>> +            cpuidle_pause_and_lock();
>> +            cpuidle_enable_device(dev);
>> +            cpuidle_resume_and_unlock();
>> +            break;
>> +
>> +        case CPU_DEAD:
>> +        case CPU_DEAD_FROZEN:
>> +            cpuidle_pause_and_lock();
>> +            cpuidle_disable_device(dev);
>> +            cpuidle_resume_and_unlock();
>> +            break;
>> +
>> +        default:
>> +            return NOTIFY_DONE;
>> +        }
>> +    }
>> +
>> +    return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block cpu_hotplug_notifier = {
>> +    .notifier_call = cpu_hotplug_notify,
>> +};
>
> Can you explain why this is needed ?
>
>> +static void e500_cpuidle_driver_init(void)
>> +{
>> +    int idle_state;
>> +    struct cpuidle_driver *drv = &e500_idle_driver;
>
> Pass the cpuidle_driver as parameter to the function.
>
>> +
>> +    drv->state_count = 0;
>> +
>> +    for (idle_state = 0; idle_state < max_idle_state; ++idle_state) {
>> +        if (!cpuidle_state_table[idle_state].enter)
>> +            break;
>> +
>> +        drv->states[drv->state_count] = cpuidle_state_table[idle_state];
>> +        drv->state_count++;
>> +    }
>
> This code should disappear.
>
> As this function will just initialize state_count, you can move it in
> caller and kill this function.
>
>> +}
>> +
>> +static int e500_idle_state_probe(void)
>> +{
>> +    if (cpuidle_disable != IDLE_NO_OVERRIDE)
>> +        return -ENODEV;
>> +
>> +    cpuidle_state_table = pw_idle_states;
>> +    max_idle_state = ARRAY_SIZE(pw_idle_states);
>> +
>> +    /* Disable PW20 feature for e500mc, e5500 */
>> +    if (PVR_VER(cur_cpu_spec->pvr_value) != PVR_VER_E6500)
>> +        cpuidle_state_table[1].enter = NULL;
>> +
>> +    if (!cpuidle_state_table || !max_idle_state)
>> +        return -ENODEV;
>> +
>> +    return 0;
>> +}
>
> This code should disappear.
>
>> +static void replace_orig_idle(void *dummy)
>> +{
>> +    return;
>> +}
>> +
>> +static int __init e500_idle_init(void)
>> +{
>> +    struct cpuidle_driver *drv = &e500_idle_driver;
>> +    int err;
>> +
>> +    if (e500_idle_state_probe())
>> +        return -ENODEV;
>> +
>> +    e500_cpuidle_driver_init();
>> +    if (!drv->state_count)
>> +        return -ENODEV;
>
> No need of this check, because:
>
> 1. you know how you initialized the driver (1 or 2 states)
> 2. this is already by the cpuidle framework
>
>> +
>> +    err = cpuidle_register(drv, NULL);
>> +    if (err) {
>> +        pr_err("Register e500 family cpuidle driver failed.\n");
>
> extra carriage return.
>> +
>> +        return err;
>> +    }
>> +
>> +    err = register_cpu_notifier(&cpu_hotplug_notifier);
>> +    if (err)
>> +        pr_warn("Cpuidle driver: register cpu notifier failed.\n");
>> +
>> +    /* Replace the original way of idle after cpuidle registered. */
>> +    ppc_md.power_save = e500_cpuidle;
>> +    on_each_cpu(replace_orig_idle, NULL, 1);
>
> Why ?
>
>> +    pr_info("e500_idle_driver registered.\n");
>> +
>> +    return 0;
>> +}
>> +late_initcall(e500_idle_init);
>>
>
> Thanks
>
>    -- Daniel
>
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
