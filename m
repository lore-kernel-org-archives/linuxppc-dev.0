Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5369A2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 21:56:17 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Fri, 23 Aug 2013 21:45:11 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6353D2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 21:56:13 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7NBeDIE45809720
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 21:40:13 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7NBuB1S026767
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 21:56:12 +1000
Message-ID: <52174DB5.5050201@linux.vnet.ibm.com>
Date: Fri, 23 Aug 2013 17:25:33 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Subject: Re: [PATCH V5 3/5] POWER/cpuidle: Generic IBM-POWER backend cpuidle
 driver.
References: <20130822095323.27416.79369.stgit@deepthi.in.ibm.com>
 <20130822095357.27416.48110.stgit@deepthi.in.ibm.com>
 <ABB05CD9C9F68C46A5CEDC7F154392590102822A@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F154392590102822A@039-SN2MPN1-021.039d.mgd.msft.net>
Content-Type: text/plain; charset=UTF-8
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>,
 "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/23/2013 08:46 AM, Wang Dongsheng-B40534 wrote:
> 
>> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
>> index 0e2cd5c..e805dcd 100644
>> --- a/drivers/cpuidle/Kconfig
>> +++ b/drivers/cpuidle/Kconfig
> 
> Maybe drivers/cpuidle/Kconfig.powerpc is better? Like arm.
> 
>> +obj-$(CONFIG_CPU_IDLE_IBM_POWER) += cpuidle-ibm-power.o
>> diff --git a/drivers/cpuidle/cpuidle-ibm-power.c
>> b/drivers/cpuidle/cpuidle-ibm-power.c
>> new file mode 100644
>> index 0000000..4ee5a94
>> --- /dev/null
>> +++ b/drivers/cpuidle/cpuidle-ibm-power.c
>> @@ -0,0 +1,304 @@
>> +/*
>> + *  cpuidle-ibm-power - idle state cpuidle driver.
>> + *  Adapted from drivers/idle/intel_idle.c and
>> + *  drivers/acpi/processor_idle.c
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/cpuidle.h>
>> +#include <linux/cpu.h>
>> +#include <linux/notifier.h>
>> +
>> +#include <asm/paca.h>
>> +#include <asm/reg.h>
>> +#include <asm/machdep.h>
>> +#include <asm/firmware.h>
>> +#include <asm/runlatch.h>
>> +#include <asm/plpar_wrappers.h>
>> +
>> +struct cpuidle_driver power_idle_driver = {
>> +	.name             = "IBM-POWER-Idle",
>> +	.owner            = THIS_MODULE,
>> +};
>> +
>> +#define MAX_IDLE_STATE_COUNT	2
>> +
>> +static int max_idle_state = MAX_IDLE_STATE_COUNT - 1;
> 
> Again, do not use the macro.

Wanting to re-use CPUIDLE_STATE_MAX macro, defined in linux/cpuidle.h
similar to what x86 uses. This is def scalable for various platforms ,
as demonstrated in drivers/idle/intel_idle.c

 >
>> +static struct cpuidle_state *cpuidle_state_table;
>> +
>> +static inline void idle_loop_prolog(unsigned long *in_purr)
>> +{
>> +	*in_purr = mfspr(SPRN_PURR);
>> +	/*
>> +	 * Indicate to the HV that we are idle. Now would be
>> +	 * a good time to find other work to dispatch.
>> +	 */
>> +	get_lppaca()->idle = 1;
>> +}
>> +
>> +static inline void idle_loop_epilog(unsigned long in_purr)
>> +{
>> +	get_lppaca()->wait_state_cycles += mfspr(SPRN_PURR) - in_purr;
>> +	get_lppaca()->idle = 0;
>> +}
>> +
>> +static int snooze_loop(struct cpuidle_device *dev,
>> +			struct cpuidle_driver *drv,
>> +			int index)
>> +{
>> +	unsigned long in_purr;
>> +
>> +	idle_loop_prolog(&in_purr);
>> +	local_irq_enable();
> 
> snooze_loop has already registered in cpuidle framework to handle snooze state.
> where disable the irq? Why do "enable" here?
> 
>> +/*
>> + * States for dedicated partition case.
>> + */
>> +static struct cpuidle_state dedicated_states[MAX_IDLE_STATE_COUNT] = {
>> +	{ /* Snooze */
>> +		.name = "snooze",
>> +		.desc = "snooze",
>> +		.flags = CPUIDLE_FLAG_TIME_VALID,
>> +		.exit_latency = 0,
>> +		.target_residency = 0,
>> +		.enter = &snooze_loop },
>> +	{ /* CEDE */
>> +		.name = "CEDE",
>> +		.desc = "CEDE",
>> +		.flags = CPUIDLE_FLAG_TIME_VALID,
>> +		.exit_latency = 10,
>> +		.target_residency = 100,
>> +		.enter = &dedicated_cede_loop },
>> +};
>> +
>> +/*
>> + * States for shared partition case.
>> + */
>> +static struct cpuidle_state shared_states[MAX_IDLE_STATE_COUNT] = {
>> +	{ /* Shared Cede */
>> +		.name = "Shared Cede",
>> +		.desc = "Shared Cede",
>> +		.flags = CPUIDLE_FLAG_TIME_VALID,
>> +		.exit_latency = 0,
>> +		.target_residency = 0,
>> +		.enter = &shared_cede_loop },
>> +};
>> +
>> +static void __exit power_processor_idle_exit(void)
>> +{
>> +
>> +	unregister_cpu_notifier(&setup_hotplug_notifier);
> 
> Remove a blank line.
> 
>> +	cpuidle_unregister(&power_idle_driver);
>> +	return;
>> +}
>> +
>> +module_init(power_processor_idle_init);
>> +module_exit(power_processor_idle_exit);
>> +
> 
> Did you have tested the module? If not tested, please don't use the module.
> 
>> +MODULE_AUTHOR("Deepthi Dharwar <deepthi@linux.vnet.ibm.com>");
>> +MODULE_DESCRIPTION("Cpuidle driver for IBM POWER platforms");
>> +MODULE_LICENSE("GPL");
>>
> 
