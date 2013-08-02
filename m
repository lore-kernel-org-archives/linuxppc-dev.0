Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 405022C008A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 20:35:21 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 2 Aug 2013 15:59:16 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 3B83C1258043
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 16:04:45 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r72AZ9ic44761236
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Aug 2013 16:05:09 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r72AZBv7005270
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Aug 2013 16:05:12 +0530
Message-ID: <51FB8AD0.6080606@linux.vnet.ibm.com>
Date: Fri, 02 Aug 2013 16:02:48 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [linux-pm] [PATCH 1/3] cpuidle/powernv: cpuidle backend driver
 for powernv
References: <20130723090111.7291.99479.stgit@deepthi.in.ibm.com>
 <20130723090137.7291.36657.stgit@deepthi.in.ibm.com>
 <51F35A2A.1080408@linaro.org>
In-Reply-To: <51F35A2A.1080408@linaro.org>
Content-Type: text/plain; charset=UTF-8
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Daniel,

On 07/27/2013 10:57 AM, Daniel Lezcano wrote:
> On 07/23/2013 11:01 AM, Deepthi Dharwar wrote:
>> This patch implements a back-end cpuidle driver for
>> powernv calling power7_nap and snooze idle states.
>> This can be extended by adding more idle states
>> in the future to the existing framework.
>>
>> Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/Kconfig          |    9 +
>>  arch/powerpc/platforms/powernv/Makefile         |    1 
>>  arch/powerpc/platforms/powernv/processor_idle.c |  239 +++++++++++++++++++++++
>>  3 files changed, 249 insertions(+)
>>  create mode 100644 arch/powerpc/platforms/powernv/processor_idle.c
>>
>> diff --git a/arch/powerpc/platforms/powernv/processor_idle.c b/arch/powerpc/platforms/powernv/processor_idle.c
>> new file mode 100644
>> index 0000000..f43ad91a
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/powernv/processor_idle.c
>> @@ -0,0 +1,239 @@
>> +/*
>> + *  processor_idle - idle state cpuidle driver.
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
>> +#include <asm/machdep.h>
>> +#include <asm/runlatch.h>
>> +
>> +struct cpuidle_driver powernv_idle_driver = {
>> +	.name =		"powernv_idle",
>> +	.owner =	THIS_MODULE,
>> +};
>> +
>> +#define MAX_IDLE_STATE_COUNT	2
>> +
>> +static int max_idle_state = MAX_IDLE_STATE_COUNT - 1;
>> +static struct cpuidle_device __percpu *powernv_cpuidle_devices;
>> +static struct cpuidle_state *cpuidle_state_table;
>> +
>> +static int snooze_loop(struct cpuidle_device *dev,
>> +			struct cpuidle_driver *drv,
>> +			int index)
>> +{
>> +	int cpu = dev->cpu;
>> +
>> +	local_irq_enable();
>> +	set_thread_flag(TIF_POLLING_NRFLAG);
>> +
>> +	while ((!need_resched()) && cpu_online(cpu)) {
>> +		ppc64_runlatch_off();
>> +		HMT_very_low();
>> +	}
> 
> Why are you using the cpu_online test here ?
> 
>> +
>> +	HMT_medium();
>> +	clear_thread_flag(TIF_POLLING_NRFLAG);
>> +	smp_mb();
>> +	return index;
>> +}
>> +
>> +
>> +static int nap_loop(struct cpuidle_device *dev,
>> +				struct cpuidle_driver *drv,
>> +				int index)
>> +{
>> +	ppc64_runlatch_off();
>> +	power7_idle();
>> +	return index;
>> +}
>> +
>> +/*
>> + * States for dedicated partition case.
>> + */
>> +static struct cpuidle_state powernv_states[MAX_IDLE_STATE_COUNT] = {
>> +	{ /* Snooze */
>> +		.name = "snooze",
>> +		.desc = "snooze",
>> +		.flags = CPUIDLE_FLAG_TIME_VALID,
>> +		.exit_latency = 0,
>> +		.target_residency = 0,
>> +		.enter = &snooze_loop },
>> +	 { /* Nap */
>> +		.name = "Nap",
>> +		.desc = "Nap",
>> +		.flags = CPUIDLE_FLAG_TIME_VALID,
>> +		.exit_latency = 10,
>> +		.target_residency = 100,
>> +		.enter = &nap_loop },
>> +};
>> +
>> +static int powernv_cpuidle_add_cpu_notifier(struct notifier_block *n,
>> +			unsigned long action, void *hcpu)
>> +{
>> +	int hotcpu = (unsigned long)hcpu;
>> +	struct cpuidle_device *dev =
>> +			per_cpu_ptr(powernv_cpuidle_devices, hotcpu);
>> +
>> +	if (dev && cpuidle_get_driver()) {
>> +		switch (action) {
>> +		case CPU_ONLINE:
>> +		case CPU_ONLINE_FROZEN:
>> +			cpuidle_pause_and_lock();
>> +			cpuidle_enable_device(dev);
>> +			cpuidle_resume_and_unlock();
>> +			break;
>> +
>> +		case CPU_DEAD:
>> +		case CPU_DEAD_FROZEN:
>> +			cpuidle_pause_and_lock();
>> +			cpuidle_disable_device(dev);
>> +			cpuidle_resume_and_unlock();
>> +			break;
>> +
>> +		default:
>> +			return NOTIFY_DONE;
>> +		}
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block setup_hotplug_notifier = {
>> +	.notifier_call = powernv_cpuidle_add_cpu_notifier,
>> +};
> 
> This is duplicated code with the pseries cpuidle driver and IMHO it
> should be moved to the cpuidle framework.
> 

Will this not require a cleanup of the hotplug cpuidle notifiers from
other architectures into the cpuidle framework as well?

Regards
Preeti U Murthy
