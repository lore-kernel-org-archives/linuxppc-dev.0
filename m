Return-Path: <brking@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AFEEBB7D62
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 May 2010 00:38:01 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4AEQ2nl010776
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 10:26:02 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4AEbs7B153440
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 10:37:54 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4AEbsOH019166
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 10:37:54 -0400
Message-ID: <4BE81A3E.8030501@linux.vnet.ibm.com>
Date: Mon, 10 May 2010 09:37:50 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/2] powerpc: Partition hibernation support
References: <201005071158.o47Bww77013658@d03av03.boulder.ibm.com>
	<1273474102.6591.258.camel@concordia>
In-Reply-To: <1273474102.6591.258.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/10/2010 01:48 AM, Michael Ellerman wrote:
> On Fri, 2010-05-07 at 13:58 -0500, Brian King wrote:
>> diff -puN /dev/null arch/powerpc/platforms/pseries/suspend.c
>> --- /dev/null	2009-12-15 17:58:07.000000000 -0600
>> +++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/suspend.c	2010-05-07 13:49:12.000000000 -0500
>> @@ -0,0 +1,209 @@
>> +/*
>> +  * Copyright (C) 2010 Brian King IBM Corporation
>> +  *
>> +  * This program is free software; you can redistribute it and/or modify
>> +  * it under the terms of the GNU General Public License as published by
>> +  * the Free Software Foundation; either version 2 of the License, or
>> +  * (at your option) any later version.
>> +  *
>> +  * This program is distributed in the hope that it will be useful,
>> +  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +  * GNU General Public License for more details.
>> +  *
>> +  * You should have received a copy of the GNU General Public License
>> +  * along with this program; if not, write to the Free Software
>> +  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
>> +  */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/suspend.h>
>> +#include <asm/hvcall.h>
>> +#include <asm/machdep.h>
>> +#include <asm/mmu.h>
>> +#include <asm/rtas.h>
>> +
>> +static u64 stream_id;
> 
> I don't see any reasons why this is a global?

In summary, I need to be able to access this from pseries_suspend_begin,
whose prototype is dictated by the prototype in struct platform_suspend_ops.

> 
>> +static struct sys_device suspend_sysdev;
>> +static DECLARE_COMPLETION(suspend_work);
>> +static struct rtas_suspend_me_data suspend_data;
>> +static atomic_t suspending;
>> +
>> +/**
>> + * pseries_suspend_begin - First phase of hibernation
>> + *
>> + * Check to ensure we are in a valid state to hibernate
>> + *
>> + * Return value:
>> + * 	0 on success / other on failure
>> + **/
>> +static int pseries_suspend_begin(suspend_state_t state)
>> +{
>> +	long vs, rc;
> 
> I read "vs" as "versus", whereas I think it's meant to be "vasi state".
> "state" might be a better name.

Since state is the function parameter, I'll update this to be called vasi_state.

> 
>> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
>> +
>> +	if (!rtas_service_present("ibm,suspend-me"))
>> +		return -ENOSYS;
>> +
>> +	/* Make sure the state is valid */
>> +	rc = plpar_hcall(H_VASI_STATE, retbuf, stream_id);
>> +
>> +	vs = retbuf[0];
>> +
>> +	if (rc) {
>> +		pr_err("pseries_suspend_begin: vasi_state returned %ld\n",rc);
>> +		return rc;
>> +	} else if (vs == H_VASI_ENABLED) {
>> +		return RTAS_NOT_SUSPENDABLE;
> 
> I'm sure if I read PAPR this would make sense, but I haven't, why does
> enabled mean we can't suspend?

It means that hibernation has been initiated. The OS is expected to continue
to call the H_VASI_STATE hcall as long as H_VASI_ENABLED is returned, since
firmware is in the process of preparing for the hibernation, but is not
yet ready for the OS to hibernate.

> 
>> +	} else if (vs != H_VASI_SUSPENDING) {
>> +		pr_err("pseries_suspend_begin: vasi_state returned state %ld\n", vs);
>> +		return -EIO;
>> +	}
> 
> The comment above "Make sure the state is valid" made me think that was
> just a preliminary check before we started suspending. But it seems that
> actually starts the suspend?

The suspension actually starts because of the HMC. The HMC sends a command
to firmware to start the hibernation. It also sends a command to the LPAR
with the stream id of the hibernation, which we use on the H_VASI_STATE
hcall. Firmware checks to make sure the stream ids match.

>> +/**
>> + * pseries_prepare_late - Prepare to suspend all other CPUs
>> + *
>> + * Return value:
>> + * 	0 on success / other on failure
>> + **/
>> +static int pseries_prepare_late(void)
>> +{
>> +	atomic_set(&suspending, 1);
>> +	atomic_set(&suspend_data.working, 0);
>> +	atomic_set(&suspend_data.done, 0);
>> +	atomic_set(&suspend_data.error, 0);
>> +	suspend_data.token = rtas_token("ibm,suspend-me");
> 
> You could look this up at init time.

Agreed

> 
>> +	suspend_data.complete = &suspend_work;
>> +	INIT_COMPLETION(suspend_work);
>> +	return 0;
>> +}
>> +
>> +/**
>> + * store_hibernate - Initiate partition hibernation
>> + * @classdev:	sysdev class struct
>> + * @attr:		class device attribute struct
>> + * @buf:		buffer
>> + * @count:		buffer size
>> + *
>> + * Write the stream ID received from the HMC to this file
>> + * to trigger hibernating the partition
>> + *
>> + * Return value:
>> + * 	number of bytes printed to buffer / other on failure
>> + **/
>> +static ssize_t store_hibernate(struct sysdev_class *classdev,
>> +			       struct sysdev_class_attribute *attr,
>> +			       const char *buf, size_t count)
>> +{
>> +	int rc;
>> +
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +
>> +	stream_id = simple_strtoul(buf, NULL, 16);
> 
> Error handling?

I'm relying on H_VASI_STATE for the error checking. If an invalid
stream ID is passed to H_VASI_STATE, we will get back H_PARAMETER.

> 
>> +	do {
>> +		rc = pseries_suspend_begin(PM_SUSPEND_MEM);
>> +		if (rc == RTAS_NOT_SUSPENDABLE)
>> +			ssleep(1);
> 
> Hmm OK. So if we're not suspendable, we just try again? That sounds more
> like -EAGAIN to me.

I'll change to use -EAGAIN for this return value

> 
>> +	} while (rc == RTAS_NOT_SUSPENDABLE);
>> +
>> +	if (!rc)
>> +		rc = pm_suspend(PM_SUSPEND_MEM);
>> +
>> +	stream_id = 0;
> 
> Same comment before about this being global.
> 
>> +	if (!rc)
>> +		rc = count;
>> +	return rc;
>> +}
>> +
>> +static SYSDEV_CLASS_ATTR(hibernate, S_IWUSR, NULL, store_hibernate);
>> +
>> +static struct sysdev_class suspend_sysdev_class = {
>> +	.name = "power",
> 
> "power" like powerpc, or like electricity? If it's the former should it
> be "pseries" instead.

Like electricty. This results in a sysfs file in the following directory:

/sys/devices/system/power/hibernate

Userspace then simply writes the stream id received from the HMC to this file
to start the hibernation. (This is typically done by the drmgr tool which is
invoked by the HMC.)


> ...
>> +/**
>> + * pseries_suspend_init - initcall for pSeries suspend
>> + *
>> + * Return value:
>> + * 	0 on success / other on failure
>> + **/
>> +static int __init pseries_suspend_init(void)
>> +{
>> +	int rc;
>> +
>> +	if ((rc = pseries_suspend_sysfs_register(&suspend_sysdev)))
>> +		return rc;
>> +
>> +	ppc_md.suspend_disable_cpu = pseries_suspend_cpu;
>> +	suspend_set_ops(&pseries_suspend_ops);
> 
> This unconditionally sets the pseries suspend ops, regardless of whether
> we're actually running on a pseries machine, or if the required RTAS
> tokens were found.
> 
> You should probably use the presence of ibm,suspend-me as the condition?
> And while you're looking it up anyway you can store it in
> suspend_data :)

Agreed

> 
>> +	return 0;
>> +}
>> +
>> +__initcall(pseries_suspend_init);
>> diff -puN arch/powerpc/kernel/rtas.c~powerpc_allarch_pseries_hibernation arch/powerpc/kernel/rtas.c
>> --- linux-2.6/arch/powerpc/kernel/rtas.c~powerpc_allarch_pseries_hibernation	2010-05-07 13:49:12.000000000 -0500
>> +++ linux-2.6-bjking1/arch/powerpc/kernel/rtas.c	2010-05-07 13:49:12.000000000 -0500
>> @@ -47,14 +47,6 @@ struct rtas_t rtas = {
>>  };
>>  EXPORT_SYMBOL(rtas);
>>  
>> -struct rtas_suspend_me_data {
>> -	atomic_t working; /* number of cpus accessing this struct */
>> -	atomic_t done;
>> -	int token; /* ibm,suspend-me */
>> -	int error;
>> -	struct completion *complete; /* wait on this until working == 0 */
>> -};
>> -
>>  DEFINE_SPINLOCK(rtas_data_buf_lock);
>>  EXPORT_SYMBOL(rtas_data_buf_lock);
>>  
>> @@ -711,14 +703,54 @@ void rtas_os_term(char *str)
>>  
>>  static int ibm_suspend_me_token = RTAS_UNKNOWN_SERVICE;
>>  #ifdef CONFIG_PPC_PSERIES
>> -static void rtas_percpu_suspend_me(void *info)
>> +static int __rtas_suspend_last_cpu(struct rtas_suspend_me_data *data, int wake_when_done)
>> +{
>> +	u16 slb_size = mmu_slb_size;
>> +	int rc = H_MULTI_THREADS_ACTIVE;
>> +	int cpu;
>> +
>> +	atomic_inc(&data->working);
>> +
>> +	slb_set_size(SLB_MIN_SIZE);
>> +	printk(KERN_DEBUG "calling ibm,suspend-me on cpu %i\n", smp_processor_id());
>> +
>> +	while (rc == H_MULTI_THREADS_ACTIVE && !atomic_read(&data->done) &&
>> +	       !atomic_read(&data->error))
>> +		rc = rtas_call(data->token, 0, 1, NULL);
>> +
>> +	if (rc || atomic_read(&data->error)) {
>> +		printk(KERN_DEBUG "ibm,suspend-me returned %d\n", rc);
>> +		slb_set_size(slb_size);
>> +	}
>> +
>> +	if (atomic_read(&data->error))
>> +		rc = atomic_read(&data->error);
>> +
>> +	atomic_set(&data->error, rc);
>> +
>> +	if (wake_when_done) {
>> +		atomic_set(&data->done, 1);
>> +
>> +		for_each_online_cpu(cpu)
>> +			plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
>> +	}
>> +
>> +	if (atomic_dec_return(&data->working) == 0)
>> +		complete(data->complete);
>> +
>> +	return rc;
>> +}
>> +
>> +int rtas_suspend_last_cpu(struct rtas_suspend_me_data *data)
>> +{
>> +	return __rtas_suspend_last_cpu(data, 0);
>> +}
>> +
>> +static int __rtas_suspend_cpu(struct rtas_suspend_me_data *data, int wake_when_done)
>>  {
>>  	long rc = H_SUCCESS;
>>  	unsigned long msr_save;
>> -	u16 slb_size = mmu_slb_size;
>>  	int cpu;
>> -	struct rtas_suspend_me_data *data =
>> -		(struct rtas_suspend_me_data *)info;
>>  
>>  	atomic_inc(&data->working);
>>  
>> @@ -726,7 +758,7 @@ static void rtas_percpu_suspend_me(void
>>  	msr_save = mfmsr();
>>  	mtmsr(msr_save & ~(MSR_EE));
>>  
>> -	while (rc == H_SUCCESS && !atomic_read(&data->done))
>> +	while (rc == H_SUCCESS && !atomic_read(&data->done) && !atomic_read(&data->error))
>>  		rc = plpar_hcall_norets(H_JOIN);
>>  
>>  	mtmsr(msr_save);
>> @@ -738,33 +770,37 @@ static void rtas_percpu_suspend_me(void
>>  		/* All other cpus are in H_JOIN, this cpu does
>>  		 * the suspend.
>>  		 */
>> -		slb_set_size(SLB_MIN_SIZE);
>> -		printk(KERN_DEBUG "calling ibm,suspend-me on cpu %i\n",
>> -		       smp_processor_id());
>> -		data->error = rtas_call(data->token, 0, 1, NULL);
>> -
>> -		if (data->error) {
>> -			printk(KERN_DEBUG "ibm,suspend-me returned %d\n",
>> -			       data->error);
>> -			slb_set_size(slb_size);
>> -		}
>> +		return __rtas_suspend_last_cpu(data, wake_when_done);
>>  	} else {
>>  		printk(KERN_ERR "H_JOIN on cpu %i failed with rc = %ld\n",
>>  		       smp_processor_id(), rc);
>> -		data->error = rc;
>> +		atomic_set(&data->error, rc);
>>  	}
>>  
>> -	atomic_set(&data->done, 1);
>> +	if (wake_when_done) {
>> +		atomic_set(&data->done, 1);
>>  
>> -	/* This cpu did the suspend or got an error; in either case,
>> -	 * we need to prod all other other cpus out of join state.
>> -	 * Extra prods are harmless.
>> -	 */
>> -	for_each_online_cpu(cpu)
>> -		plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
>> +		/* This cpu did the suspend or got an error; in either case,
>> +		 * we need to prod all other other cpus out of join state.
>> +		 * Extra prods are harmless.
>> +		 */
>> +		for_each_online_cpu(cpu)
>> +			plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
>> +	}
>>  out:
>>  	if (atomic_dec_return(&data->working) == 0)
>>  		complete(data->complete);
>> +	return rc;
>> +}
>> +
>> +int rtas_suspend_cpu(struct rtas_suspend_me_data *data)
>> +{
>> +	return __rtas_suspend_cpu(data, 0);
>> +}
>> +
>> +static void rtas_percpu_suspend_me(void *info)
>> +{
>> +	__rtas_suspend_cpu((struct rtas_suspend_me_data *)info, 1);
>>  }
> 
> What is the current path via rtas_ibm_suspend_me() used for? It's not
> clear to me that you've changed that in a way that is equivalent.

Its used for Live Partition Mobility. This patch does change this path
slightly, but it should be functionally equivalent.


>>  static int rtas_ibm_suspend_me(struct rtas_args *args)
>> @@ -799,29 +835,41 @@ static int rtas_ibm_suspend_me(struct rt
>>  
>>  	atomic_set(&data.working, 0);
>>  	atomic_set(&data.done, 0);
>> +	atomic_set(&data.error, 0);
>>  	data.token = rtas_token("ibm,suspend-me");
>> -	data.error = 0;
>>  	data.complete = &done;
>>  
>>  	/* Call function on all CPUs.  One of us will make the
>>  	 * rtas call
>>  	 */
>>  	if (on_each_cpu(rtas_percpu_suspend_me, &data, 0))
>> -		data.error = -EINVAL;
>> +		atomic_set(&data.error, -EINVAL);
>>  
>>  	wait_for_completion(&done);
>>  
>> -	if (data.error != 0)
>> +	if (atomic_read(&data.error) != 0)
>>  		printk(KERN_ERR "Error doing global join\n");
>>  
>> -	return data.error;
>> +	return atomic_read(&data.error);
> 
> So while moving the struct definition you've also changed error to be
> atomic, and fixed the code here. That would be nicer as a separate
> commit, at the very least you should call it out in your changelog.

Ok.

> 
> And why does it need to be atomic?

Its potentially checked and set on different cpus. I considered creating
a lock for updating this data structure, which seemed like overkill and
would have complicated the code. Another option would be to simply sprinkle
memory barriers at the appropriate places. I thought the atomics were
simple, clean, and consistent with the existing code.


>>  }
>>  #else /* CONFIG_PPC_PSERIES */
>>  static int rtas_ibm_suspend_me(struct rtas_args *args)
>>  {
>>  	return -ENOSYS;
>>  }
>> +
>> +int rtas_suspend_cpu(struct rtas_suspend_me_data *data)
>> +{
>> +	return -ENOSYS;
>> +}
>> +
>> +int rtas_suspend_last_cpu(struct rtas_suspend_me_data *data)
>> +{
>> +	return -ENOSYS;
>> +}
> 
> Don't see why you need these empty versions, they're only ever called
> from pseries code aren't they?

True, but we still need to be able to link the code in a cross platform
kernel.

>>  #endif
>> +EXPORT_SYMBOL_GPL(rtas_suspend_cpu);
>> +EXPORT_SYMBOL_GPL(rtas_suspend_last_cpu);
> 
> Don't see why these need to be exported, CONFIG_SUSPEND is bool so
> pseries/suspend.c is only ever built-in.

Ok.

> 
>> diff -puN arch/powerpc/include/asm/rtas.h~powerpc_allarch_pseries_hibernation arch/powerpc/include/asm/rtas.h
>> --- linux-2.6/arch/powerpc/include/asm/rtas.h~powerpc_allarch_pseries_hibernation	2010-05-07 13:49:12.000000000 -0500
>> +++ linux-2.6-bjking1/arch/powerpc/include/asm/rtas.h	2010-05-07 13:49:12.000000000 -0500
>> @@ -63,6 +63,14 @@ struct rtas_t {
>>  	struct device_node *dev;	/* virtual address pointer */
>>  };
>>  
>> +struct rtas_suspend_me_data {
>> +	atomic_t working; /* number of cpus accessing this struct */
>> +	atomic_t done;
>> +	int token; /* ibm,suspend-me */
>> +	atomic_t error;
>> +	struct completion *complete; /* wait on this until working == 0 */
>> +};
>> +
>>  /* RTAS event classes */
>>  #define RTAS_INTERNAL_ERROR		0x80000000 /* set bit 0 */
>>  #define RTAS_EPOW_WARNING		0x40000000 /* set bit 1 */
> 
> 
>> diff -puN arch/powerpc/include/asm/hvcall.h~powerpc_allarch_pseries_hibernation arch/powerpc/include/asm/hvcall.h
>> --- linux-2.6/arch/powerpc/include/asm/hvcall.h~powerpc_allarch_pseries_hibernation	2010-05-07 13:49:12.000000000 -0500
>> +++ linux-2.6-bjking1/arch/powerpc/include/asm/hvcall.h	2010-05-07 13:49:12.000000000 -0500
>> @@ -74,6 +74,7 @@
>>  #define H_NOT_ENOUGH_RESOURCES -44
>>  #define H_R_STATE       -45
>>  #define H_RESCINDEND    -46
>> +#define H_MULTI_THREADS_ACTIVE -9005
> 
> Which means what?

When calling ibm,suspend-me, all other CPU threads must have called H_JOIN to ensure
that there are no other CPU threads executing in the LPAR. If this has not occurred,
the ibm,suspend-me RTAS call will fail with H_MULTI_THREADS_ACTIVE.

> 
>> diff -puN arch/powerpc/include/asm/machdep.h~powerpc_allarch_pseries_hibernation arch/powerpc/include/asm/machdep.h
>> --- linux-2.6/arch/powerpc/include/asm/machdep.h~powerpc_allarch_pseries_hibernation	2010-05-07 13:49:12.000000000 -0500
>> +++ linux-2.6-bjking1/arch/powerpc/include/asm/machdep.h	2010-05-07 13:49:12.000000000 -0500
>> @@ -266,6 +266,7 @@ struct machdep_calls {
>>  	void (*suspend_disable_irqs)(void);
>>  	void (*suspend_enable_irqs)(void);
>>  #endif
>> +	int (*suspend_disable_cpu)(void);
> 
> Should this be ifdef CONFIG_SUSPEND ? 

I purposely did not do that so that the code in arch/powerpc/platforms/pseries/hotplug-cpu.c
wouldn't need to ifdef CONFIG_SUSPEND around checking this function pointer.

> 
>> diff -puN arch/powerpc/platforms/pseries/hotplug-cpu.c~powerpc_allarch_pseries_hibernation arch/powerpc/platforms/pseries/hotplug-cpu.c
>> --- linux-2.6/arch/powerpc/platforms/pseries/hotplug-cpu.c~powerpc_allarch_pseries_hibernation	2010-05-07 13:49:12.000000000 -0500
>> +++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/hotplug-cpu.c	2010-05-07 13:49:12.000000000 -0500
>> @@ -116,6 +116,12 @@ static void pseries_mach_cpu_die(void)
>>  
>>  	if (get_preferred_offline_state(cpu) == CPU_STATE_INACTIVE) {
>>  		set_cpu_current_state(cpu, CPU_STATE_INACTIVE);
>> +		if (ppc_md.suspend_disable_cpu)
>> +			ppc_md.suspend_disable_cpu();
>> +	}
>> +
>> +	if (get_preferred_offline_state(cpu) == CPU_STATE_INACTIVE) {
>> +		set_cpu_current_state(cpu, CPU_STATE_INACTIVE);
> 
> That looks weird? Do we expect preferred offline state to change?

After looking at this a bit closer, I don't think it can. I'll update in the next rev
of the patch. Thanks for reviewing!

-Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
