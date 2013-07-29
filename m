Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-ee0-f50.google.com (mail-ee0-f50.google.com [74.125.83.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DDFC52C0105
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 00:44:51 +1000 (EST)
Received: by mail-ee0-f50.google.com with SMTP id d51so1551075eek.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2013 07:44:46 -0700 (PDT)
Message-ID: <51F67FDE.6070902@linaro.org>
Date: Mon, 29 Jul 2013 16:44:46 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] cpuidle/powernv: Enable idle powernv cpu to call
 into the cpuidle framework.
References: <20130723090111.7291.99479.stgit@deepthi.in.ibm.com>
 <20130723090150.7291.89879.stgit@deepthi.in.ibm.com>
 <51F35AC7.8060909@linaro.org> <51F67BE5.10701@linux.vnet.ibm.com>
In-Reply-To: <51F67BE5.10701@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/29/2013 04:27 PM, Deepthi Dharwar wrote:
> On 07/27/2013 10:59 AM, Daniel Lezcano wrote:
>> On 07/23/2013 11:01 AM, Deepthi Dharwar wrote:
>>> This patch enables idle powernv cpu to hook on to the cpuidle
>>> framework, if available, else call on to default idle platform
>>> code.
>>
>> Why do you need to do that ?
>>
> 
> Hi Daniel,
> 
> Well, this is needed in case when one does not compile with CPU_IDLE
> config option.
> 
> When CPUIDLE is not configured, idle cpus are needed to be running some
> sort of default idle code or loop ( in the worst case) if cpuidle driver
> is not registered or if one decides not to have that config enabled.

Hi Deepthi,

ok may be there is some difference with the other platform but the
arch_cpu_idle function defined in the other archs do:

void arch_cpu_idle(void)
{
        if (cpuidle_idle_call())
                x86_idle();
        else
                local_irq_enable();
}

or

void arch_cpu_idle(void)
{
        if (cpuidle_idle_call())
                default_idle();
}

When the cpuidle driver is not compiled or not loaded, cpuidle_idle_call
fails, falling back to the default idle function.

The arch_cpu_idle function is called from the generic code in
kernel/cpu/idle.c.

Is there a particular reason to do it in a different way ?

Thanks
  -- Daniel

>>
>>> Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
>>> ---
>>>  arch/powerpc/platforms/powernv/setup.c |   12 +++++++++++-
>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
>>> index 84438af..97d0951 100644
>>> --- a/arch/powerpc/platforms/powernv/setup.c
>>> +++ b/arch/powerpc/platforms/powernv/setup.c
>>> @@ -25,6 +25,7 @@
>>>  #include <linux/of.h>
>>>  #include <linux/interrupt.h>
>>>  #include <linux/bug.h>
>>> +#include <linux/cpuidle.h>
>>>  
>>>  #include <asm/machdep.h>
>>>  #include <asm/firmware.h>
>>> @@ -196,6 +197,15 @@ static int __init pnv_probe(void)
>>>  	return 1;
>>>  }
>>>  
>>> +void powernv_idle(void)
>>> +{
>>> +	/* Hook to cpuidle framework if available, else
>>> +	 * call on default platform idle code
>>> +	 */
>>> +	if (cpuidle_idle_call())
>>> +		power7_idle();
>>> +}
>>> +
>>>  define_machine(powernv) {
>>>  	.name			= "PowerNV",
>>>  	.probe			= pnv_probe,
>>> @@ -205,7 +215,7 @@ define_machine(powernv) {
>>>  	.show_cpuinfo		= pnv_show_cpuinfo,
>>>  	.progress		= pnv_progress,
>>>  	.machine_shutdown	= pnv_shutdown,
>>> -	.power_save             = power7_idle,
>>> +	.power_save             = powernv_idle,
>>>  	.calibrate_decr		= generic_calibrate_decr,
>>>  #ifdef CONFIG_KEXEC
>>>  	.kexec_cpu_down		= pnv_kexec_cpu_down,
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>
>>
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
