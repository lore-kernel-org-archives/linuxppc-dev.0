Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkCyV2LmWzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 04:05:38 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v58I4Mgv017912
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 14:05:35 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ay2etjjmc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 14:05:34 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 9 Jun 2017 04:05:31 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v58I5UGD6226260
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 04:05:30 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v58I5Lhf015730
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 04:05:22 +1000
Subject: Re: [PATCH v9 10/10] powerpc/perf: Thread imc cpuhotplug support
To: Thomas Gleixner <tglx@linutronix.de>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com,
 bsingharora@gmail.com, anton@samba.org, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org, stewart@linux.vnet.ibm.com, dja@axtens.net,
 eranian@google.com, hemant@linux.vnet.ibm.com
References: <1496665922-702-1-git-send-email-anju@linux.vnet.ibm.com>
 <1496665922-702-3-git-send-email-anju@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1706061209140.1885@nanos>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 8 Jun 2017 23:35:22 +0530
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1706061209140.1885@nanos>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ded88b97-7bb7-429f-189b-a1047c032fdf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 06 June 2017 03:57 PM, Thomas Gleixner wrote:
> On Mon, 5 Jun 2017, Anju T Sudhakar wrote:
>>   static void thread_imc_mem_alloc(int cpu_id)
>>   {
>> -	u64 ldbar_addr, ldbar_value;
>>   	int phys_id = topology_physical_package_id(cpu_id);
>>   
>>   	per_cpu_add[cpu_id] = (u64)alloc_pages_exact_nid(phys_id,
>>   			(size_t)IMC_THREAD_COUNTER_MEM, GFP_KERNEL | __GFP_ZERO);
> It took me a while to understand that per_cpu_add is an array and not a new
> fangled per cpu function which adds something to a per cpu variable.
>
> So why is that storing the address as u64?

Value that we need to load to the ldbar spr also has other bits
apart from memory addr. So we made it as an array. But this
should be a per_cpu pointer.  Will fix it.


>
> And why is this a NR_CPUS sized array instead of a regular per cpu variable?

Yes. will fix it.

>> +}
>> +
>> +static void thread_imc_update_ldbar(unsigned int cpu_id)
>> +{
>> +	u64 ldbar_addr, ldbar_value;
>> +
>> +	if (per_cpu_add[cpu_id] == 0)
>> +		thread_imc_mem_alloc(cpu_id);
> So if that allocation fails then you happily proceed. Optmistic
> programming, right?

Will add return value check.

>
>> +
>>   	ldbar_addr = (u64)virt_to_phys((void *)per_cpu_add[cpu_id]);
> Ah, it's stored as u64 because you have to convert it back to a void
> pointer at the place where it is actually used. Interesting approach.
>
>>   	ldbar_value = (ldbar_addr & (u64)THREAD_IMC_LDBAR_MASK) |
>> -		(u64)THREAD_IMC_ENABLE;
>> +			(u64)THREAD_IMC_ENABLE;
>>   	mtspr(SPRN_LDBAR, ldbar_value);
>>   }
>>   
>> @@ -442,6 +450,26 @@ static void core_imc_change_cpu_context(int old_cpu, int new_cpu)
>>   	perf_pmu_migrate_context(&core_imc_pmu->pmu, old_cpu, new_cpu);
>>   }
>>   
>> +static int ppc_thread_imc_cpu_online(unsigned int cpu)
>> +{
>> +	thread_imc_update_ldbar(cpu);
>> +	return 0;
>> +}
>> +
>> +static int ppc_thread_imc_cpu_offline(unsigned int cpu)
>> +{
>> +	mtspr(SPRN_LDBAR, 0);
>> +	return 0;
>> +}
>> +
>> +void thread_imc_cpu_init(void)
>> +{
>> +	cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
>> +			  "perf/powerpc/imc_thread:online",
>> +			  ppc_thread_imc_cpu_online,
>> +			  ppc_thread_imc_cpu_offline);
>> +}
>> +
>>   static int ppc_core_imc_cpu_online(unsigned int cpu)
>>   {
>>   	const struct cpumask *l_cpumask;
>> @@ -953,6 +981,9 @@ int __init init_imc_pmu(struct imc_events *events, int idx,
>>   		if (ret)
>>   			return ret;
>>   		break;
>> +	case IMC_DOMAIN_THREAD:
>> +		thread_imc_cpu_init();
>> +		break;
>>   	default:
>>   		return -1;  /* Unknown domain */
>>   	}
> Just a general observation. If anything in init_imc_pmu() fails, then all
> the hotplug callbacks are staying registered, at least I haven't seen
> anything undoing it.
Yes. We did not add code to unregister the call back on failure.
Will fix that in next version.

Thanks for the review.
Maddy

> Thanks,
>
> 	tglx
>
