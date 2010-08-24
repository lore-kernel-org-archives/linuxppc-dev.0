Return-Path: <brking@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EDCD7B70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Aug 2010 07:40:56 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7OLVakb003206
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2010 15:31:36 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o7OLeliq246546
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2010 15:40:47 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o7OLiIMp008794
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2010 15:44:19 -0600
Message-ID: <4C743C61.8060906@linux.vnet.ibm.com>
Date: Tue, 24 Aug 2010 16:40:49 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1] powerpc: Clear cpu_sibling_map in cpu_die
References: <201008112034.o7BKYvEJ013392@d03av04.boulder.ibm.com>
	<1282627487.22370.508.camel@pasglop>
In-Reply-To: <1282627487.22370.508.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/24/2010 12:24 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2010-08-11 at 15:34 -0500, Brian King wrote:
>> While testing CPU DLPAR, the following problem was discovered.
>> We were DLPAR removing the first CPU, which in this case was
>> logical CPUs 0-3. CPUs 0-2 were already marked offline and
>> we were in the process of offlining CPU 3. After marking
>> the CPU inactive and offline in cpu_disable, but before the
>> cpu was completely idle (cpu_die), we ended up in __make_request
>> on CPU 3. There we looked at the topology map to see which CPU
>> to complete the I/O on and found no CPUs in the cpu_sibling_map.
>> This resulted in the block layer setting the completion cpu
>> to be NR_CPUS, which then caused an oops when we tried to
>> complete the I/O.
>>
>> Fix this by delaying clearing the sibling map of the cpu we
>> are offlining for the cpu we are offlining until cpu_die.
> 
> So I'm not getting a clear mental picture of the situation, sorry about
> that.
> 
> We are offlining CPU 3, and we have already marked it inactive and
> online, so how come we end up in __make_request() on it at this stage

I'm not sure about that. My thought was that until we get into cpu_die,
the cpu could still be executing code.

> and shouldn't it be the block layer that notices that it's targeting an
> offlined CPU ?

It could be easily fixed in blk_cpu_to_group as well. I'll look into
this.

> IE. I have doubts about leaving a CPU in the sibling map which isn't
> online... Wouldn't we end up "scheduling" things to it after it's
> supposed to have freed itself of everything (timers, workqueues,
> etc...) ?

I was assuming this wouldn't happen since the cpu is no longer online.


Thanks,

Brian

> 
> As I said, I'm probably missing a part of the puzzle ..
> 
> Ben.
> 
>> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
>> ---
>>
>>  arch/powerpc/kernel/smp.c |    9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff -puN arch/powerpc/kernel/smp.c~powerpc_sibling_map_offline arch/powerpc/kernel/smp.c
>> --- linux-2.6/arch/powerpc/kernel/smp.c~powerpc_sibling_map_offline	2010-08-09 16:49:47.000000000 -0500
>> +++ linux-2.6-bjking1/arch/powerpc/kernel/smp.c	2010-08-09 16:49:47.000000000 -0500
>> @@ -598,8 +598,11 @@ int __cpu_disable(void)
>>  	/* Update sibling maps */
>>  	base = cpu_first_thread_in_core(cpu);
>>  	for (i = 0; i < threads_per_core; i++) {
>> -		cpumask_clear_cpu(cpu, cpu_sibling_mask(base + i));
>> -		cpumask_clear_cpu(base + i, cpu_sibling_mask(cpu));
>> +		if ((base + i) != cpu) {
>> +			cpumask_clear_cpu(cpu, cpu_sibling_mask(base + i));
>> +			cpumask_clear_cpu(base + i, cpu_sibling_mask(cpu));
>> +		}
>> +
>>  		cpumask_clear_cpu(cpu, cpu_core_mask(base + i));
>>  		cpumask_clear_cpu(base + i, cpu_core_mask(cpu));
>>  	}
>> @@ -641,6 +644,8 @@ void cpu_hotplug_driver_unlock()
>>  
>>  void cpu_die(void)
>>  {
>> +	cpumask_clear_cpu(smp_processor_id(), cpu_sibling_mask(smp_processor_id()));
>> +
>>  	if (ppc_md.cpu_die)
>>  		ppc_md.cpu_die();
>>  }
>> _
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
