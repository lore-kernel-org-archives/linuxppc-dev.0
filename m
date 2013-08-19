Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE6202C0111
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 20:18:53 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Mon, 19 Aug 2013 15:42:59 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 1DFF4394004D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 15:48:38 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7JAIgPZ40042678
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 15:48:42 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7JAIiUv004593
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 15:48:45 +0530
Message-ID: <5211F0E0.7080507@linux.vnet.ibm.com>
Date: Mon, 19 Aug 2013 15:48:08 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Subject: Re: [RFC PATCH V3 3/5] powerpc/cpuidle: Generic powerpc backend
 cpuidle driver.
References: <20130819042736.8609.17890.stgit@deepthi.in.ibm.com>
 <20130819042818.8609.77060.stgit@deepthi.in.ibm.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259010226D5@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259010226D5@039-SN2MPN1-021.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
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


Hi Dongsheng,

On 08/19/2013 11:22 AM, Wang Dongsheng-B40534 wrote:
> I think we should move the states and handle function to arch/power/platform*
> The states and handle function is belong to backend driver, not for this, different platform have different state.
> Different platforms to make their own deal with these states.
> 
> I think we cannot put all the status of different platforms and handler in this driver.

The idea here is a single powerpc back-end driver, which does a runtime
detection of the platform it is running and choose the right
idle states table. This was one of outcome of V2 discussion.

I feel there is no harm in keeping the state information in the same
file. We do have x86, which has all its variants information in one
file. One place will have all the idle consolidated information of
all the platform variants. If community does feel, we need to
have just the states information in arch specific file, we can do so.


>> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
>> index 0e2cd5c..99ee5d4 100644
>> --- a/drivers/cpuidle/Kconfig
>> +++ b/drivers/cpuidle/Kconfig
>> @@ -42,6 +42,13 @@ config CPU_IDLE_ZYNQ
>>  	help
>>  	  Select this to enable cpuidle on Xilinx Zynq processors.
>>
>> +config CPU_IDLE_POWERPC
>> +	bool "CPU Idle driver for POWERPC platforms"
>> +	depends on PPC64
> 
> Why not PPC?

PPC64 seems to a good place to began the consolidation work. This
patch-set has not been tested for PPC32 currently.

> 
>> +	default y
>> +        help
>> +          Select this option to enable processor idle state management
>> +	  for POWERPC platform.
>>  endif
>>
>>  config ARCH_NEEDS_CPU_IDLE_COUPLED
>> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
>> index 8767a7b..d12e205 100644
>> --- a/drivers/cpuidle/Makefile
>> +++ b/drivers/cpuidle/Makefile
>> @@ -8,3 +8,5 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
>>  obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
>>  obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
>>  obj-$(CONFIG_CPU_IDLE_ZYNQ) += cpuidle-zynq.o
>> +
>> +obj-$(CONFIG_CPU_IDLE_POWERPC) += cpuidle-powerpc.o
>> diff --git a/drivers/cpuidle/cpuidle-powerpc.c b/drivers/cpuidle/cpuidle-
>> powerpc.c
>> new file mode 100644
>> index 0000000..5756085
>> --- /dev/null
>> +++ b/drivers/cpuidle/cpuidle-powerpc.c
>> @@ -0,0 +1,361 @@
>> +/*
>> + *  processor_idle - idle state cpuidle driver.
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
>> +struct cpuidle_driver powerpc_idle_driver = {
>> +	.name             = "powerpc_idle",
>> +	.owner            = THIS_MODULE,
>> +};
>> +
>> +#define MAX_IDLE_STATE_COUNT	2
>> +
>> +static int max_idle_state = MAX_IDLE_STATE_COUNT - 1;
> If this is a generic driver, do not define MAX_IDLE_STATE_COUNT, because we don't know how many state on other platforms.
> 
> How about using ARRAY_SIZE to get the max idle state?
> 
Yes, I do agree. We need a generic way to return the no of idle states.

>> +static struct cpuidle_device __percpu *powerpc_cpuidle_devices;
>> +static struct cpuidle_state *cpuidle_state_table;
>> +
> Should be remove all about *device*.
> If the notifier handle using device, you can use "cpuidle_devices"(include/linux/cpuidle.h).

The hotplug notifier has a dependency to the cpu device struct.
Yes, I agree using this is way to go forward. As outlined in the cover
cpuidle cleanups will be taken in subsequent versions.

>> +static inline void idle_loop_prolog(unsigned long *in_purr)
>> +{
>> +	*in_purr = mfspr(SPRN_PURR);
>> +	/*
>> +	 * Indicate to the HV that we are idle. Now would be
>> +	 * a good time to find other work to dispatch.
>> +	 */
>> +	set_lppaca_idle(1);
>> +}
>> +
>> +static inline void idle_loop_epilog(unsigned long in_purr)
>> +{
>> +	add_lppaca_wait_state(mfspr(SPRN_PURR) - in_purr);
>> +	set_lppaca_idle(0);
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
>> +	set_thread_flag(TIF_POLLING_NRFLAG);
>> +
>> +	while (!need_resched()) {
>> +		ppc64_runlatch_off();
>> +		HMT_low();
>> +		HMT_very_low();
>> +	}
>> +
>> +	HMT_medium();
>> +	clear_thread_flag(TIF_POLLING_NRFLAG);
>> +	smp_mb();
>> +
>> +	idle_loop_epilog(in_purr);
>> +
>> +	return index;
>> +}
>> +
>> +static void check_and_cede_processor(void)
>> +{
>> +	/*
>> +	 * Ensure our interrupt state is properly tracked,
>> +	 * also checks if no interrupt has occurred while we
>> +	 * were soft-disabled
>> +	 */
>> +	if (prep_irq_for_idle()) {
>> +		cede_processor();
>> +#ifdef CONFIG_TRACE_IRQFLAGS
>> +		/* Ensure that H_CEDE returns with IRQs on */
>> +		if (WARN_ON(!(mfmsr() & MSR_EE)))
>> +			__hard_irq_enable();
>> +#endif
>> +	}
>> +}
>> +
>> +static int dedicated_cede_loop(struct cpuidle_device *dev,
>> +				struct cpuidle_driver *drv,
>> +				int index)
>> +{
>> +	unsigned long in_purr;
>> +
>> +	idle_loop_prolog(&in_purr);
>> +	set_lppaca_donate_dedicated_cpu(1);
>> +
>> +	ppc64_runlatch_off();
>> +	HMT_medium();
>> +	check_and_cede_processor();
>> +
>> +	set_lppaca_donate_dedicated_cpu(0);
>> +	idle_loop_epilog(in_purr);
>> +
>> +	return index;
>> +}
>> +
>> +static int shared_cede_loop(struct cpuidle_device *dev,
>> +			struct cpuidle_driver *drv,
>> +			int index)
>> +{
>> +	unsigned long in_purr;
>> +
>> +	idle_loop_prolog(&in_purr);
>> +
>> +	/*
>> +	 * Yield the processor to the hypervisor.  We return if
>> +	 * an external interrupt occurs (which are driven prior
>> +	 * to returning here) or if a prod occurs from another
>> +	 * processor. When returning here, external interrupts
>> +	 * are enabled.
>> +	 */
>> +	check_and_cede_processor();
>> +
>> +	idle_loop_epilog(in_purr);
>> +
>> +	return index;
>> +}
>> +
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
>> +void update_smt_snooze_delay(int cpu, int residency)
>> +{
>> +	struct cpuidle_driver *drv = cpuidle_get_driver();
>> +	struct cpuidle_device *dev = per_cpu(cpuidle_devices, cpu);
>> +
>> +	if (cpuidle_state_table != dedicated_states)
>> +		return;
>> +
>> +	if (residency < 0) {
>> +		/* Disable the Nap state on that cpu */
>> +		if (dev)
>> +			dev->states_usage[1].disable = 1;
>> +	} else
>> +		if (drv)
>> +			drv->states[1].target_residency = residency;
>> +}
>> +
>> +static int powerpc_cpuidle_add_cpu_notifier(struct notifier_block *n,
>> +			unsigned long action, void *hcpu)
>> +{
>> +	int hotcpu = (unsigned long)hcpu;
>> +	struct cpuidle_device *dev =
>> +			per_cpu_ptr(powerpc_cpuidle_devices, hotcpu);
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
>> +	.notifier_call = powerpc_cpuidle_add_cpu_notifier,
>> +};
>> +
> We should discuss this with Daniel.

Yes, having a single cpuidle hotplug notifier across
all archs removes a lot of code duplication. But this would involve
changes across archs that is a huge feature by itself and extensive
testing. This is not in the per-view of current patch series but will be
taken up separately.

>> +/*
>> + * powerpc_cpuidle_driver_init()
>> + */
>> +static int powerpc_cpuidle_driver_init(void)
>> +{
>> +	int idle_state;
>> +	struct cpuidle_driver *drv = &powerpc_idle_driver;
>> +
>> +	drv->state_count = 0;
>> +
>> +	for (idle_state = 0; idle_state < MAX_IDLE_STATE_COUNT;
>> ++idle_state) {
>> +
>> +		if (idle_state > max_idle_state)
>> +			break;
>> +
>> +		/* is the state not enabled? */
>> +		if (cpuidle_state_table[idle_state].enter == NULL)
>> +			continue;
>> +
> Did the state have dependent?
> If yes, may be should break out the loop, not continue.

Dependent in what way ?

>> +		drv->states[drv->state_count] =	/* structure copy */
>> +			cpuidle_state_table[idle_state];
>> +
>> +		drv->state_count += 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/* powerpc_idle_devices_uninit(void)
>> + * unregister cpuidle devices and de-allocate memory
>> + */
>> +static void powerpc_idle_devices_uninit(void)
>> +{
>> +	int i;
>> +	struct cpuidle_device *dev;
>> +
>> +	for_each_possible_cpu(i) {
>> +		dev = per_cpu_ptr(powerpc_cpuidle_devices, i);
>> +		cpuidle_unregister_device(dev);
>> +	}
>> +
>> +	free_percpu(powerpc_cpuidle_devices);
>> +	return;
>> +}
>> +
>> +/* powerpc_idle_devices_init()
>> + * allocate, initialize and register cpuidle device
>> + */
>> +static int powerpc_idle_devices_init(void)
>> +{
>> +	int i;
>> +	struct cpuidle_driver *drv = &powerpc_idle_driver;
>> +	struct cpuidle_device *dev;
>> +
>> +	powerpc_cpuidle_devices = alloc_percpu(struct cpuidle_device);
>> +	if (powerpc_cpuidle_devices == NULL)
>> +		return -ENOMEM;
>> +
>> +	for_each_possible_cpu(i) {
>> +		dev = per_cpu_ptr(powerpc_cpuidle_devices, i);
>> +		dev->state_count = drv->state_count;
>> +		dev->cpu = i;
>> +		if (cpuidle_register_device(dev)) {
> 
> Please use cpuidle_register().
> 
>> +			printk(KERN_DEBUG \
>> +				"cpuidle_register_device %d failed!\n", i);
>> +			return -EIO;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * powerpc_idle_probe()
>> + * Choose state table for shared versus dedicated partition
>> + */
>> +static int powerpc_idle_probe(void)
>> +{
>> +
>> +	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
>> +		return -ENODEV;
>> +
>> +	if (cpuidle_disable != IDLE_NO_OVERRIDE)
>> +		return -ENODEV;
>> +
>> +	if (max_idle_state == 0) {
>> +		printk(KERN_DEBUG "powerpc processor idle disabled.\n");
>> +		return -EPERM;
>> +	}
>> +
>> +	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
>> +		if (get_lppaca_is_shared_proc() == 1)
>> +			cpuidle_state_table = shared_states;
>> +		else if (get_lppaca_is_shared_proc() == 0)
>> +			cpuidle_state_table = dedicated_states;
>> +	} else
>> +		return -ENODEV;
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init powerpc_processor_idle_init(void)
>> +{
>> +	int retval;
>> +
>> +	retval = powerpc_idle_probe();
>> +	if (retval)
>> +		return retval;
>> +
>> +	powerpc_cpuidle_driver_init();
>> +	retval = cpuidle_register_driver(&powerpc_idle_driver);
>> +	if (retval) {
>> +		printk(KERN_DEBUG "Registration of powerpc driver failed.\n");
>> +		return retval;
>> +	}
>> +
>> +	retval = powerpc_idle_devices_init();
>> +	if (retval) {
>> +		powerpc_idle_devices_uninit();
>> +		cpuidle_unregister_driver(&powerpc_idle_driver);
>> +		return retval;
>> +	}
>> +
>> +	register_cpu_notifier(&setup_hotplug_notifier);
>> +	printk(KERN_DEBUG "powerpc_idle_driver registered\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit powerpc_processor_idle_exit(void)
>> +{
>> +
>> +	unregister_cpu_notifier(&setup_hotplug_notifier);
>> +	powerpc_idle_devices_uninit();
>> +	cpuidle_unregister_driver(&powerpc_idle_driver);
>> +
>> +	return;
>> +}
>> +
> Did you test module mode? *Remove* the module cannot work.
>>

This is currently in-built module as there is a dependency in
kernel/sysfs.c currently. Going forward we will look to have this as a
module.

This is just an RFC patch to see if we can go forward this line. Thanks
so much for the review. I have duly noted down the issues
that will be addressed in the coming versions.

Regards,
Deepthi


> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 
