Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2EC43140151
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 19:12:33 +1100 (EST)
Received: by mail-wi0-f177.google.com with SMTP id cc10so1956148wib.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Apr 2014 01:12:28 -0700 (PDT)
Message-ID: <533D17FC.1000201@linaro.org>
Date: Thu, 03 Apr 2014 10:12:44 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>,
 Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] cpuidle: add freescale e500 family porcessors idle support
References: <1396341234-40515-1-git-send-email-dongsheng.wang@freescale.com>
 <533BDA11.9080905@linaro.org>
 <e32c248e30c54f458f65501227b1ce54@BN1PR03MB188.namprd03.prod.outlook.com>
 <533CFFA7.6000907@linaro.org>
 <69cec4d810a448069df4d30bfc861ea5@BN1PR03MB188.namprd03.prod.outlook.com>
In-Reply-To: <69cec4d810a448069df4d30bfc861ea5@BN1PR03MB188.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "chenhui.zhao@freescale.com" <chenhui.zhao@freescale.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/03/2014 10:03 AM, Dongsheng.Wang@freescale.com wrote:
>
>
>> -----Original Message-----
>> From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org]
>> Sent: Thursday, April 03, 2014 2:29 PM
>> To: Wang Dongsheng-B40534; Wood Scott-B07421
>> Cc: rjw@rjwysocki.net; Li Yang-Leo-R58472; Jin Zhengxiong-R64188; Zhao Chenhui-
>> B35336; linux-pm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
>> Subject: Re: [PATCH] cpuidle: add freescale e500 family porcessors idle support
>>
>> On 04/03/2014 05:20 AM, Dongsheng.Wang@freescale.com wrote:
>>> Hi Daniel,
>>>
>>> Thanks for your review. I will fix your comments.
>>>
>>> BTW, fix Rafael's email. :)
>>>
>>>>> +#include <linux/cpu.h>
>>>>> +#include <linux/cpuidle.h>
>>>>> +#include <linux/init.h>
>>>>> +#include <linux/kernel.h>
>>>>> +#include <linux/notifier.h>
>>>>> +
>>>>> +#include <asm/cputable.h>
>>>>> +#include <asm/machdep.h>
>>>>> +#include <asm/mpc85xx.h>
>>>>> +
>>>>> +static unsigned int max_idle_state; static struct cpuidle_state
>>>>> +*cpuidle_state_table;
>>>>> +
>>>>> +struct cpuidle_driver e500_idle_driver = {
>>>>> +	.name = "e500_idle",
>>>>> +	.owner = THIS_MODULE,
>>>>> +};
>>>>> +
>>>>> +static void e500_cpuidle(void)
>>>>> +{
>>>>> +	if (cpuidle_idle_call())
>>>>> +		cpuidle_wait();
>>>>> +}
>>>>
>>>> Nope, that has been changed. No more call to cpuidle_idle_call in a driver.
>>>>
>>>
>>> Thanks.
>>>
>>>>> +
>>>>> +static int pw10_enter(struct cpuidle_device *dev,
>>>>> +			struct cpuidle_driver *drv, int index) {
>>>>> +	cpuidle_wait();
>>>>> +	return index;
>>>>> +}
>>>>> +
>>>>> +#define MAX_BIT	63
>>>>> +#define MIN_BIT	1
>>>>> +extern u32 cpuidle_entry_bit;
>>>>> +static int pw20_enter(struct cpuidle_device *dev,
>>>>> +		struct cpuidle_driver *drv, int index) {
>>>>> +	u32 pw20_idle;
>>>>> +	u32 entry_bit;
>>>>> +	pw20_idle = mfspr(SPRN_PWRMGTCR0);
>>>>> +	if ((pw20_idle & PWRMGTCR0_PW20_ENT) != PWRMGTCR0_PW20_ENT) {
>>>>> +		pw20_idle &= ~PWRMGTCR0_PW20_ENT;
>>>>> +		entry_bit = MAX_BIT - cpuidle_entry_bit;
>>>>> +		pw20_idle |= (entry_bit << PWRMGTCR0_PW20_ENT_SHIFT);
>>>>> +		mtspr(SPRN_PWRMGTCR0, pw20_idle);
>>>>> +	}
>>>>> +
>>>>> +	cpuidle_wait();
>>>>> +
>>>>> +	pw20_idle &= ~PWRMGTCR0_PW20_ENT;
>>>>> +	pw20_idle |= (MIN_BIT << PWRMGTCR0_PW20_ENT_SHIFT);
>>>>> +	mtspr(SPRN_PWRMGTCR0, pw20_idle);
>>>>> +
>>>>> +	return index;
>>>>> +}
>>>>
>>>> Is it possible to give some comments and encapsulate the code with
>>>> explicit function names to be implemented in an arch specific
>>>> directory file (eg. pm.c) and export these functions in a linux/
>>>> header ? We try to prevent to include asm if possible.
>>>>
>>>
>>> Yep, Looks better. Thanks.
>>>
>>>>> +
>>>>> +static struct cpuidle_state pw_idle_states[] = {
>>>>> +	{
>>>>> +		.name = "pw10",
>>>>> +		.desc = "pw10",
>>>>> +		.flags = CPUIDLE_FLAG_TIME_VALID,
>>>>> +		.exit_latency = 0,
>>>>> +		.target_residency = 0,
>>>>> +		.enter = &pw10_enter
>>>>> +	},
>>>>> +
>>>>> +	{
>>>>> +		.name = "pw20",
>>>>> +		.desc = "pw20-core-idle",
>>>>> +		.flags = CPUIDLE_FLAG_TIME_VALID,
>>>>> +		.exit_latency = 1,
>>>>> +		.target_residency = 50,
>>>>> +		.enter = &pw20_enter
>>>>> +	},
>>>>> +};
>>>>
>>>> No need to define this intermediate structure here, you can directly
>>>> initialize the cpuidle_driver:
>>>>
>>>
>>> Thanks. :)
>>>
>>>>> +static int cpu_hotplug_notify(struct notifier_block *n,
>>>>> +			unsigned long action, void *hcpu) {
>>>>> +	unsigned long hotcpu = (unsigned long)hcpu;
>>>>> +	struct cpuidle_device *dev =
>>>>> +			per_cpu_ptr(cpuidle_devices, hotcpu);
>>>>> +
>>>>> +	if (dev && cpuidle_get_driver()) {
>>>>> +		switch (action) {
>>>>> +		case CPU_ONLINE:
>>>>> +		case CPU_ONLINE_FROZEN:
>>>>> +			cpuidle_pause_and_lock();
>>>>> +			cpuidle_enable_device(dev);
>>>>> +			cpuidle_resume_and_unlock();
>>>>> +			break;
>>>>> +
>>>>> +		case CPU_DEAD:
>>>>> +		case CPU_DEAD_FROZEN:
>>>>> +			cpuidle_pause_and_lock();
>>>>> +			cpuidle_disable_device(dev);
>>>>> +			cpuidle_resume_and_unlock();
>>>>> +			break;
>>>>> +
>>>>> +		default:
>>>>> +			return NOTIFY_DONE;
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>> +	return NOTIFY_OK;
>>>>> +}
>>>>> +
>>>>> +static struct notifier_block cpu_hotplug_notifier = {
>>>>> +	.notifier_call = cpu_hotplug_notify, };
>>>>
>>>> Can you explain why this is needed ?
>>>>
>>>
>>> If a cpu will be plugged out/in, We should be let Cpuidle know to
>>> remove corresponding sys interface and disable/enable cpudile-governor for
>> current cpu.
>>
>> Ok, this code is a copy-paste of the powers' cpuidle driver.
>>
>> IIRC, I posted a patchset to move this portion of code in the cpuidle common
>> framework some time ago.
>>
>> Could you please get rid of this part of code ?
>>
>
> Yes, I can. :) Could you share me your patchset link? I can't found them on your tree.
>

It was a while ago. I should have it somewhere locally. I will find it 
out and resend the patch next week when finishing my current task.

   -- Daniel

>> --
>>    <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter | <http://www.linaro.org/linaro-blog/>
>> Blog
>>
>>
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
