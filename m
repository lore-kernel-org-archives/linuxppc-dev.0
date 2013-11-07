Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D772A2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 15:15:27 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Thu, 7 Nov 2013 14:15:27 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 221B82CE804A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 15:15:20 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA73vnC149610858
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Nov 2013 14:57:49 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rA74FIUB007763
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Nov 2013 15:15:19 +1100
Message-ID: <527B13C8.9030602@linux.vnet.ibm.com>
Date: Thu, 07 Nov 2013 09:45:04 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V7 5/7] POWER/cpuidle: Generic POWER CPUIDLE driver
 supporting PSERIES.
References: <20131029110052.31547.82682.stgit@deepthi.in.ibm.com>
 <20131029110148.31547.8944.stgit@deepthi.in.ibm.com>
 <527AAF1D.5080605@linaro.org>
In-Reply-To: <527AAF1D.5080605@linaro.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-kernel@vger.kernel.org, preeti@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com, scottwood@freescale.com,
 linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/2013 02:35 AM, Daniel Lezcano wrote:
> On 10/29/2013 12:01 PM, Deepthi Dharwar wrote:
>> This patch includes cleanup and refactoring of the
>> existing code to make the driver POWER generic.
>> * Re-naming the functions from pseries to generic power.
>> * Re-naming the backend driver from pseries_idle to
>>    ibm-power-idle.
>>
>> Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Hi Daniel,

Thanks for the Acks.

> ... but I am wondering if 'power' name is not confusing with power
> management and if 'powerpc' would suit better.

'powerpc' would be very generic arch and would comprise of all platforms
including embedded 32/64 bit to server 64 bit (similar to that of ARM).
This driver does not intend to support complete powerpc arch, but just
PSERIES and POWERNV platforms termed as 'POWER' processors. So to avoid
confusion btw 'power mgmt' and 'POWER' archs, I have prefixed both the
driver and file names with 'IBM'namely ibm-power-driver, cpuidle-ibm-power.

Regards,
Deepthi

>> ---
>>   drivers/cpuidle/cpuidle-ibm-power.c |   32
>> ++++++++++++++++----------------
>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-ibm-power.c
>> b/drivers/cpuidle/cpuidle-ibm-power.c
>> index e81c207..5b92242 100644
>> --- a/drivers/cpuidle/cpuidle-ibm-power.c
>> +++ b/drivers/cpuidle/cpuidle-ibm-power.c
>> @@ -20,8 +20,8 @@
>>   #include <asm/runlatch.h>
>>   #include <asm/plpar_wrappers.h>
>>
>> -struct cpuidle_driver pseries_idle_driver = {
>> -    .name             = "pseries_idle",
>> +struct cpuidle_driver power_idle_driver = {
>> +    .name             = "ibm_power_idle",
>>       .owner            = THIS_MODULE,
>>   };
>>
>> @@ -182,7 +182,7 @@ void update_smt_snooze_delay(int cpu, int residency)
>>               drv->states[1].target_residency = residency;
>>   }
>>
>> -static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
>> +static int power_cpuidle_add_cpu_notifier(struct notifier_block *n,
>>               unsigned long action, void *hcpu)
>>   {
>>       int hotcpu = (unsigned long)hcpu;
>> @@ -213,16 +213,16 @@ static int
>> pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
>>   }
>>
>>   static struct notifier_block setup_hotplug_notifier = {
>> -    .notifier_call = pseries_cpuidle_add_cpu_notifier,
>> +    .notifier_call = power_cpuidle_add_cpu_notifier,
>>   };
>>
>>   /*
>> - * pseries_cpuidle_driver_init()
>> + * power_cpuidle_driver_init()
>>    */
>> -static int pseries_cpuidle_driver_init(void)
>> +static int power_cpuidle_driver_init(void)
>>   {
>>       int idle_state;
>> -    struct cpuidle_driver *drv = &pseries_idle_driver;
>> +    struct cpuidle_driver *drv = &power_idle_driver;
>>
>>       drv->state_count = 0;
>>       for (idle_state = 0; idle_state < max_idle_state; ++idle_state) {
>> @@ -241,10 +241,10 @@ static int pseries_cpuidle_driver_init(void)
>>   }
>>
>>   /*
>> - * pseries_idle_probe()
>> + * power_idle_probe()
>>    * Choose state table for shared versus dedicated partition
>>    */
>> -static int pseries_idle_probe(void)
>> +static int power_idle_probe(void)
>>   {
>>
>>       if (cpuidle_disable != IDLE_NO_OVERRIDE)
>> @@ -264,24 +264,24 @@ static int pseries_idle_probe(void)
>>       return 0;
>>   }
>>
>> -static int __init pseries_processor_idle_init(void)
>> +static int __init power_processor_idle_init(void)
>>   {
>>       int retval;
>>
>> -    retval = pseries_idle_probe();
>> +    retval = power_idle_probe();
>>       if (retval)
>>           return retval;
>>
>> -    pseries_cpuidle_driver_init();
>> -    retval = cpuidle_register(&pseries_idle_driver, NULL);
>> +    power_cpuidle_driver_init();
>> +    retval = cpuidle_register(&power_idle_driver, NULL);
>>       if (retval) {
>> -        printk(KERN_DEBUG "Registration of pseries driver failed.\n");
>> +        printk(KERN_DEBUG "Registration of ibm_power_idle driver
>> failed.\n");
>>           return retval;
>>       }
>>
>>       register_cpu_notifier(&setup_hotplug_notifier);
>> -    printk(KERN_DEBUG "pseries_idle_driver registered\n");
>> +    printk(KERN_DEBUG "ibm_power_idle registered\n");
>>       return 0;
>>   }
>>
>> -device_initcall(pseries_processor_idle_init);
>> +device_initcall(power_processor_idle_init);
>>
> 
> 
