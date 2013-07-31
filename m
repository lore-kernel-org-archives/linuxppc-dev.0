Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A0E4A2C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 13:05:00 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Wed, 31 Jul 2013 12:57:58 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C3F57357804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 13:04:40 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6V2mxNf53346462
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 12:48:59 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r6V34ds9012692
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 13:04:40 +1000
Message-ID: <51F87E92.5020407@linux.vnet.ibm.com>
Date: Wed, 31 Jul 2013 08:33:46 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Subject: Re: [PATCH] cpuidle: add freescale e500 family porcessors idle support
References: <1375167603-16722-1-git-send-email-dongsheng.wang@freescale.com>
 <51F78CA1.40605@linaro.org>
 <ABB05CD9C9F68C46A5CEDC7F15439259FEF361@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259FEF361@039-SN2MPN1-021.039d.mgd.msft.net>
Content-Type: text/plain; charset=UTF-8
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, "rjw@sisk.pl" <rjw@sisk.pl>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2013 04:32 PM, Wang Dongsheng-B40534 wrote:

Hi Dongsheng,

I have posted out a generic powerpc idle backend driver ccing you.
Please take a look at it and integrate your platform idle states into it.

Right now, cpu hotplug notifier is common for all powerpc. This
shouldn't hinder you.
This will reduce code duplication and would make it easier to
plug into the framework. All you need is platform specific
idle states table and config changes.

Regards,
Deepthi


> 
>> -----Original Message-----
>> From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org]
>> Sent: Tuesday, July 30, 2013 5:51 PM
>> To: Wang Dongsheng-B40534
>> Cc: Wood Scott-B07421; rjw@sisk.pl; benh@kernel.crashing.org; Li Yang-
>> R58472; Zhao Chenhui-B35336; linux-pm@vger.kernel.org; linuxppc-
>> dev@lists.ozlabs.org
>> Subject: Re: [PATCH] cpuidle: add freescale e500 family porcessors idle
>> support
>>
>> On 07/30/2013 09:00 AM, Dongsheng Wang wrote:
>>> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>>>
>>> Add cpuidle support for e500 family, using cpuidle framework to manage
>>> various low power modes. The new implementation will remain compatible
>>> with original idle method.
>>>
>>> Initially, this supports PW10, and subsequent patches will support
>>> PW20/DOZE/NAP.
>>>
>>> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>>> ---
>>> This patch keep using cpuidle_register_device(), because we need to
>>> support cpu hotplug. I will fix "device" issue in this driver, after
>>> Deepthi Dharwar <deepthi@linux.vnet.ibm.com> add a hotplug handler
>>> into cpuidle freamwork.
>>>
>>> diff --git a/arch/powerpc/include/asm/machdep.h
>>> b/arch/powerpc/include/asm/machdep.h
>>> index 8b48090..cbdbe25 100644
>>> --- a/arch/powerpc/include/asm/machdep.h
>>> +++ b/arch/powerpc/include/asm/machdep.h
>>> @@ -271,6 +271,16 @@ extern void power7_idle(void);  extern void
>>> ppc6xx_idle(void);  extern void book3e_idle(void);
>>>
>>> +/* Wait for Interrupt */
>>> +static inline void fsl_cpuidle_wait(void) { #ifdef CONFIG_PPC64
>>> +	book3e_idle();
>>> +#else
>>> +	e500_idle();
>>> +#endif
>>> +}
>>> +
>>>  /*
>>>   * ppc_md contains a copy of the machine description structure for the
>>>   * current platform. machine_id contains the initial address where the
>>> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
>>> index b3fb81d..7ed114b 100644
>>> --- a/drivers/cpuidle/Kconfig
>>> +++ b/drivers/cpuidle/Kconfig
>>> @@ -35,6 +35,11 @@ depends on ARM
>>>  source "drivers/cpuidle/Kconfig.arm"
>>>  endmenu
>>>
>>> +menu "PowerPC CPU Idle Drivers"
>>> +depends on PPC32 || PPC64
>>> +source "drivers/cpuidle/Kconfig.powerpc"
>>> +endmenu
>>> +
>>>  endif
>>>
>>>  config ARCH_NEEDS_CPU_IDLE_COUPLED
>>> diff --git a/drivers/cpuidle/Kconfig.powerpc
>> b/drivers/cpuidle/Kconfig.powerpc
>>> new file mode 100644
>>> index 0000000..9f3f5ef
>>> --- /dev/null
>>> +++ b/drivers/cpuidle/Kconfig.powerpc
>>> @@ -0,0 +1,9 @@
>>> +#
>>> +# PowerPC CPU Idle drivers
>>> +#
>>> +
>>> +config PPC_E500_CPUIDLE
>>> +	bool "CPU Idle Driver for E500 family processors"
>>> +	depends on FSL_SOC_BOOKE
>>> +	help
>>> +	  Select this to enable cpuidle on e500 family processors.
>>> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
>>> index 0b9d200..0dde3db 100644
>>> --- a/drivers/cpuidle/Makefile
>>> +++ b/drivers/cpuidle/Makefile
>>> @@ -11,3 +11,7 @@ obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-
>> calxeda.o
>>>  obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
>>>  obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
>>>  obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
>>> +
>>>
>> +########################################################################
>> ##########
>>> +# PowerPC platform drivers
>>> +obj-$(CONFIG_PPC_E500_CPUIDLE)		+= cpuidle-e500.o
>>> diff --git a/drivers/cpuidle/cpuidle-e500.c b/drivers/cpuidle/cpuidle-
>> e500.c
>>> new file mode 100644
>>> index 0000000..1919cea
>>> --- /dev/null
>>> +++ b/drivers/cpuidle/cpuidle-e500.c
>>> @@ -0,0 +1,222 @@
>>> +/*
>>> + * Copyright 2013 Freescale Semiconductor, Inc.
>>> + *
>>> + * CPU Idle driver for Freescale PowerPC e500 family processors.
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>> modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * Author: Wang Dongsheng <dongsheng.wang@freescale.com>
>>> + */
>>> +
>>> +#include <linux/cpu.h>
>>> +#include <linux/cpuidle.h>
>>> +#include <linux/init.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/notifier.h>
>>> +
>>> +#include <asm/machdep.h>
>>> +
>>> +static struct cpuidle_driver e500_idle_driver = {
>>> +	.name = "e500_idle",
>>> +	.owner = THIS_MODULE,
>>> +};
>>> +
>>> +static struct cpuidle_device __percpu *e500_cpuidle_devices;
>>> +
>>> +static void e500_cpuidle(void)
>>> +{
>>> +	/*
>>> +	 * This would call on the cpuidle framework, and the back-end
>>> +	 * driver to go to idle states.
>>> +	 */
>>> +	if (cpuidle_idle_call()) {
>>> +		/*
>>> +		 * On error, execute default handler
>>> +		 * to go into low thread priority and possibly
>>> +		 * low power mode.
>>> +		 */
>>> +		HMT_low();
>>> +		HMT_very_low();
>>> +	}
>>> +}
>>
>> Nope, this is not the place to add such function.
>>
> Thanks.
> 
> But Why not? On powerpc there is already have a cpuidle method. We need to compatible them.
> 
> Um.. arch/powerpc/platforms/xxx ?
> 
>>> +static int pw10_enter(struct cpuidle_device *dev,
>>> +			struct cpuidle_driver *drv, int index)
>>> +{
>>> +	fsl_cpuidle_wait();
>>> +	return index;
>>> +}
>>> +
>>> +static struct cpuidle_state fsl_pw_idle_states[] = {
>>> +	{
>>> +		.name = "pw10",
>>> +		.desc = "pw10",
>>> +		.flags = CPUIDLE_FLAG_TIME_VALID,
>>> +		.exit_latency = 0,
>>> +		.target_residency = 0,
>>> +		.enter = &pw10_enter
>>> +	},
>>> +};
>>> +
>>> +static int cpu_hotplug_notify(struct notifier_block *n,
>>> +			unsigned long action, void *hcpu)
>>> +{
>>> +	unsigned long hotcpu = (unsigned long)hcpu;
>>> +	struct cpuidle_device *dev =
>>> +			per_cpu_ptr(e500_cpuidle_devices, hotcpu);
>>> +
>>> +	if (dev && cpuidle_get_driver()) {
>>> +		switch (action) {
>>> +		case CPU_ONLINE:
>>> +		case CPU_ONLINE_FROZEN:
>>> +			cpuidle_pause_and_lock();
>>> +			cpuidle_enable_device(dev);
>>> +			cpuidle_resume_and_unlock();
>>> +			break;
>>> +
>>> +		case CPU_DEAD:
>>> +		case CPU_DEAD_FROZEN:
>>> +			cpuidle_pause_and_lock();
>>> +			cpuidle_disable_device(dev);
>>> +			cpuidle_resume_and_unlock();
>>> +			break;
>>> +
>>> +		default:
>>> +			return NOTIFY_DONE;
>>> +		}
>>> +	}
>>> +
>>> +	return NOTIFY_OK;
>>> +}
>>> +
>>> +static struct notifier_block cpu_hotplug_notifier = {
>>> +	.notifier_call = cpu_hotplug_notify,
>>> +};
>>
>> This should go to the cpuidle framework.
>>
> Yes, I see, Deepthi will post it...
> :(, This patch is relying on for Deepthi's patch about "hotplug notifier".
> 
>>> +
>>> +/*
>>> + * e500_idle_devices_init(void)
>>> + * allocate, initialize and register cpuidle device
>>> + */
>>> +static int e500_idle_devices_init(void)
>>> +{
>>> +	int i;
>>> +	struct cpuidle_driver *drv = &e500_idle_driver;
>>> +	struct cpuidle_device *dev;
>>> +
>>> +	e500_cpuidle_devices = alloc_percpu(struct cpuidle_device);
>>> +	if (!e500_cpuidle_devices)
>>> +		return -ENOMEM;
>>> +
>>> +	for_each_possible_cpu(i) {
>>> +		dev = per_cpu_ptr(e500_cpuidle_devices, i);
>>> +		dev->state_count = drv->state_count;
>>> +		dev->cpu = i;
>>> +
>>> +		if (cpuidle_register_device(dev)) {
>>> +			pr_err("cpuidle_register_device %d failed!\n", i);
>>> +			return -EIO;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/*
>>> + * e500_idle_devices_uninit(void)
>>> + * unregister cpuidle devices and de-allocate memory
>>> + */
>>> +static void e500_idle_devices_uninit(void)
>>> +{
>>> +	int i;
>>> +	struct cpuidle_device *dev;
>>> +
>>> +	if (!e500_cpuidle_devices)
>>> +		return;
>>> +
>>> +	for_each_possible_cpu(i) {
>>> +		dev = per_cpu_ptr(e500_cpuidle_devices, i);
>>> +		cpuidle_unregister_device(dev);
>>> +	}
>>> +
>>> +	free_percpu(e500_cpuidle_devices);
>>> +}
>>> +
>>> +static void e500_cpuidle_driver_init(unsigned int max_idle_state,
>>> +		struct cpuidle_state *cpuidle_state_table)
>>> +{
>>> +	int idle_state;
>>> +	struct cpuidle_driver *drv = &e500_idle_driver;
>>> +
>>> +	drv->state_count = 0;
>>> +
>>> +	for (idle_state = 0; idle_state < max_idle_state; ++idle_state) {
>>> +		if (!cpuidle_state_table[idle_state].enter)
>>> +			break;
>>> +
>>> +		drv->states[drv->state_count] =
>> cpuidle_state_table[idle_state];
>>> +		drv->state_count++;
>>> +	}
>>> +}
>>> +
>>> +static int cpu_is_feature(unsigned long feature)
>>> +{
>>> +	return (cur_cpu_spec->cpu_features == feature);
>>> +}
>>> +
>>> +static int __init e500_idle_init(void)
>>> +{
>>> +	struct cpuidle_state *cpuidle_state_table = NULL;
>>> +	struct cpuidle_driver *drv = &e500_idle_driver;
>>> +	int err;
>>> +	unsigned int max_idle_state = 0;
>>> +
>>> +	if (cpuidle_disable != IDLE_NO_OVERRIDE)
>>> +		return -ENODEV;
>>> +
>>> +	if (cpu_is_feature(CPU_FTRS_E500MC) ||
>> cpu_is_feature(CPU_FTRS_E5500) ||
>>> +			cpu_is_feature(CPU_FTRS_E6500)) {
>>> +		cpuidle_state_table = fsl_pw_idle_states;
>>> +		max_idle_state = ARRAY_SIZE(fsl_pw_idle_states);
>>> +	}
>>> +
>>> +	if (!cpuidle_state_table || !max_idle_state)
>>> +		return -EPERM;
>>
>> Please use different drivers for each and then register the right one
>> instead of state count convolutions.
>>
>> Then use cpuidle_register(&mydriver, NULL) and get rid of the duplicate
>> initialization routine.
>>
> Yes, Thanks, This patch keep using cpuidle_register_device(), because we need to
> support cpu hotplug. I will fix "device" issue in this driver, after
> Deepthi Dharwar <deepthi@linux.vnet.ibm.com> add a hotplug handler
> into cpuidle freamwork.
> 
>>
>>> +	e500_cpuidle_driver_init(max_idle_state, cpuidle_state_table);
>>> +
>>> +	if (!drv->state_count)
>>> +		return -EPERM;
>>> +
>>> +	err = cpuidle_register_driver(drv);
>>> +	if (err) {
>>> +		pr_err("Register e500 family cpuidle driver failed.\n");
>>> +
>>> +		return err;
>>> +	}
>>> +
>>> +	err = e500_idle_devices_init();
>>> +	if (err)
>>> +		goto out;
>>> +
>>> +	err = register_cpu_notifier(&cpu_hotplug_notifier);
>>> +	if (err)
>>> +		goto out;
>>> +
>>> +	ppc_md.power_save = e500_cpuidle;
>>
>> This is not the place.
>>
>>> +
>>> +	pr_info("e500_idle_driver registered.\n");
>>> +
>>> +	return 0;
>>> +
>>> +out:
>>> +	e500_idle_devices_uninit();
>>> +	cpuidle_unregister_driver(drv);
>>> +
>>> +	pr_err("Register e500 family cpuidle driver failed.\n");
>>> +
>>> +	return err;
>>> +}
>>> +device_initcall(e500_idle_init);
>>>
>>
>>
>> --
>>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
