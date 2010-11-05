Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78033B70FB
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Nov 2010 07:34:22 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oA5KPsBs031120
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Nov 2010 14:25:54 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oA5KY0qN216136
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Nov 2010 14:34:00 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oA5KXx6Y029905
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Nov 2010 14:34:00 -0600
Message-ID: <4CD46A34.3040206@linux.vnet.ibm.com>
Date: Fri, 05 Nov 2010 15:33:56 -0500
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 3/3] powerpc: Disable VPHN polling during a suspend
	operation
References: <20101029002628.17835.37125.sendpatchset@manic8ball.ltc.austin.ibm.com>
	<20101029002921.17835.88560.sendpatchset@manic8ball.ltc.austin.ibm.com>
	<1288786362.989.66.camel@concordia>
In-Reply-To: <1288786362.989.66.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: markn@au1.ibm.com, pmac@au1.ibm.com, tbreeds@au1.ibm.com,
	lkessler@us.ibm.com, mjwolf@us.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/03/2010 07:12 AM, Michael Ellerman wrote:
> On Thu, 2010-10-28 at 20:30 -0400, Jesse Larrew wrote: 
>> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
> 
> Hi Jesse, a few comments ...
> 
>> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
>> index afe4aaa..1747d27 100644
>> --- a/arch/powerpc/include/asm/topology.h
>> +++ b/arch/powerpc/include/asm/topology.h
>> @@ -49,7 +49,7 @@ static inline int pcibus_to_node(struct pci_bus *bus)
>>  {
>>  	return -1;
>>  }
>> -#endif
>> +#endif /* CONFIG_PCI */
> 
> Random change, though not a biggy I suppose.
> 

That was a change that made the header easier to read, but that change should probably be submitted separately.

>> #define cpumask_of_pcibus(bus)	(pcibus_to_node(bus) == -1 ?		\
>>  				 cpu_all_mask :				\
>> @@ -93,6 +93,8 @@ extern void __init dump_numa_cpu_topology(void);
>>  extern int sysfs_add_device_to_node(struct sys_device *dev, int nid);
>>  extern void sysfs_remove_device_from_node(struct sys_device *dev, int nid);
>>  
>> +extern int __init init_topology_update(void);
>> +extern int stop_topology_update(void);
> 
> init_topology_update() is called repeatedly from post_suspend_work() so
> it seems like it should be called start_topology_update(). And it can't
> be __init because the suspend code is called after boot. You should get
> a section mismatch warning if they are enabled.
> 

Agreed. My implementation was based on a similar feature for System Z in arch/s390/kernel/topology.c, and I had simply carried over some of their naming conventions. start_topology_update() is a better name.

>> #else
>>  
>>  static inline void dump_numa_cpu_topology(void) {}
>> @@ -107,6 +109,8 @@ static inline void sysfs_remove_device_from_node(struct sys_device *dev,
>>  {
>>  }
>>  
>> +static int __init init_topology_update(void) {}
>> +static int stop_topology_update(void) {}
> 
> That doesn't look like it compiles to me, you want static inline, and
> they both return int.
>

Good catch! I hadn't tried to compile this with CONFIG_NUMA turned off.
 
>> #endif /* CONFIG_NUMA */
>>  
>>  #include <asm-generic/topology.h>
>> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
>> index 8fe8bc6..317ff2f 100644
>> --- a/arch/powerpc/kernel/rtas.c
>> +++ b/arch/powerpc/kernel/rtas.c
>> @@ -41,6 +41,7 @@
>>  #include <asm/atomic.h>
>>  #include <asm/time.h>
>>  #include <asm/mmu.h>
>> +#include <asm/topology.h>
>>  
>>  struct rtas_t rtas = {
>>  	.lock = __ARCH_SPIN_LOCK_UNLOCKED
>> @@ -706,6 +707,18 @@ void rtas_os_term(char *str)
>>  
>>  static int ibm_suspend_me_token = RTAS_UNKNOWN_SERVICE;
>>  #ifdef CONFIG_PPC_PSERIES
>> +static void pre_suspend_work(void)
>> +{
>> +	stop_topology_update();
>> +	return;
>> +}
>> +
>> +static void post_suspend_work(void)
>> +{
>> +	init_topology_update();
>> +	return;
>> +}
> 
> I'm not sure if it's worth splitting these out into "generic"
> callbacks ..
> 

I talked with Nathan Fontenot about this a couple weeks ago, and I think the plan going forward is to implement a notifier call chain that executes before/after a suspend operation to handle reinitializations like this. In the mean time, I'll just remove the pre_suspend_work() and post_suspend_work() functions in my next revision.

>> static int __rtas_suspend_last_cpu(struct rtas_suspend_me_data *data, int wake_when_done)
>>  {
>>  	u16 slb_size = mmu_slb_size;
>> @@ -713,6 +726,7 @@ static int __rtas_suspend_last_cpu(struct rtas_suspend_me_data *data, int wake_w
>>  	int cpu;
>>  
>>  	slb_set_size(SLB_MIN_SIZE);
>> +	pre_suspend_work();
>>  	printk(KERN_DEBUG "calling ibm,suspend-me on cpu %i\n", smp_processor_id());
>>  
>>  	while (rc == H_MULTI_THREADS_ACTIVE && !atomic_read(&data->done) &&
> 
> And isn't there an error case here where you're not re-enabling the
> polling? See eg. the slb_set_size() call.
> 

I'm not sure that I understand this point. I looked it over, and it looks to me that all possible code paths touch pre_suspend_work() and post_suspend_work() exactly once (even the paths that call slb_set_size()). Which path appears to be unhandled?

>> @@ -728,6 +742,7 @@ static int __rtas_suspend_last_cpu(struct rtas_suspend_me_data *data, int wake_w
>>  		rc = atomic_read(&data->error);
>>  
>>  	atomic_set(&data->error, rc);
>> +	post_suspend_work();
>>  
>>  	if (wake_when_done) {
>>  		atomic_set(&data->done, 1);
> 
> cheers
> 
> 


-- 

Jesse Larrew
Software Engineer, Linux on Power Kernel Team
IBM Linux Technology Center
Phone: (512) 973-2052 (T/L: 363-2052)
jlarrew@linux.vnet.ibm.com
