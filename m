Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vs9RL3RBxzDqY6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 21:35:58 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2RAY2EN094085
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 06:35:46 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29exhc6948-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 06:35:46 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 27 Mar 2017 06:35:45 -0400
Subject: Re: [PATCH 12/13] powerpc/perf: Thread imc cpuhotplug support
To: ego@linux.vnet.ibm.com, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
References: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1489649707-8021-13-git-send-email-maddy@linux.vnet.ibm.com>
 <20170323171511.GA4148@in.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Mon, 27 Mar 2017 16:05:35 +0530
MIME-Version: 1.0
In-Reply-To: <20170323171511.GA4148@in.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <a77a45bb-4b0e-2a08-b011-d0f1f91b61b3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 23 March 2017 10:45 PM, Gautham R Shenoy wrote:
> Hi Maddy, Anju,
>
> On Thu, Mar 16, 2017 at 01:05:06PM +0530, Madhavan Srinivasan wrote:
>> From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>>
>> This patch adds support for thread IMC on cpuhotplug.
>>
>> When a cpu goes offline, the LDBAR for that cpu is disabled, and when it comes
>> back online the previous ldbar value is written back to the LDBAR for that cpu.
>>
>> To register the hotplug functions for thread_imc, a new state
>> CPUHP_AP_PERF_POWERPC_THREADIMC_ONLINE is added to the list of existing
>> states.
>>
>> Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> Cc: Balbir Singh <bsingharora@gmail.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Anton Blanchard <anton@samba.org>
>> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>> Cc: Michael Neuling <mikey@neuling.org>
>> Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
>> Cc: Daniel Axtens <dja@axtens.net>
>> Cc: Stephane Eranian <eranian@google.com>
>> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/perf/imc-pmu.c | 33 ++++++++++++++++++++++++++++-----
>>   include/linux/cpuhotplug.h  |  1 +
>>   2 files changed, 29 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
>> index 6802960db51c..2ff39fe2a5ce 100644
>> --- a/arch/powerpc/perf/imc-pmu.c
>> +++ b/arch/powerpc/perf/imc-pmu.c
>> @@ -687,6 +687,16 @@ static void cleanup_all_thread_imc_memory(void)
>>   	on_each_cpu(cleanup_thread_imc_memory, NULL, 1);
>>   }
>>
>> +static void thread_imc_update_ldbar(unsigned int cpu_id)
>> +{
>> +	u64 ldbar_addr, ldbar_value;
>> +
>> +	ldbar_addr = (u64)virt_to_phys((void *)per_cpu_add[cpu_id]);
>> +	ldbar_value = (ldbar_addr & (u64)THREAD_IMC_LDBAR_MASK) |
>> +			(u64)THREAD_IMC_ENABLE;
>> +	mtspr(SPRN_LDBAR, ldbar_value);
>> +}
>> +
>>   /*
>>    * Allocates a page of memory for each of the online cpus, and, writes the
>>    * physical base address of that page to the LDBAR for that cpu. This starts
>> @@ -694,20 +704,33 @@ static void cleanup_all_thread_imc_memory(void)
>>    */
>>   static void thread_imc_mem_alloc(void *dummy)
>>   {
>> -	u64 ldbar_addr, ldbar_value;
>>   	int cpu_id = smp_processor_id();
>>
>>   	per_cpu_add[cpu_id] = (u64)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
>>   						    0);
>> -	ldbar_addr = (u64)virt_to_phys((void *)per_cpu_add[cpu_id]);
>> -	ldbar_value = (ldbar_addr & (u64)THREAD_IMC_LDBAR_MASK) |
>> -		(u64)THREAD_IMC_ENABLE;
>> -	mtspr(SPRN_LDBAR, ldbar_value);
>> +	thread_imc_update_ldbar(cpu_id);
>> +}
>> +
>> +static int ppc_thread_imc_cpu_online(unsigned int cpu)
>> +{
>> +	thread_imc_update_ldbar(cpu);
>> +	return 0;
>> +
>> +}
>> +
>> +static int ppc_thread_imc_cpu_offline(unsigned int cpu)
>> +{
>> +	mtspr(SPRN_LDBAR, 0);
>> +	return 0;
>>   }
> This patch looks ok to me.
>
> So it appears that in case of a full-core deep stop entry/exit you
> will need to save/restore LDBAR as well. But I will take it up for the
> next set of stop cleanups.
>
> For this patch,
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Thank you for  reviewing the patch Gautham.

-Anju

>
>>   void thread_imc_cpu_init(void)
>>   {
>>   	on_each_cpu(thread_imc_mem_alloc, NULL, 1);
>> +	cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_THREADIMC_ONLINE,
>> +			  "POWER_THREAD_IMC_ONLINE",
>> +			   ppc_thread_imc_cpu_online,
>> +			   ppc_thread_imc_cpu_offline);
>>   }
>>
>>   static void thread_imc_ldbar_disable(void *dummy)
>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>> index abde85d9511a..724df46b2c3c 100644
>> --- a/include/linux/cpuhotplug.h
>> +++ b/include/linux/cpuhotplug.h
>> @@ -138,6 +138,7 @@ enum cpuhp_state {
>>   	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
>>   	CPUHP_AP_PERF_POWERPC_NEST_ONLINE,
>>   	CPUHP_AP_PERF_POWERPC_COREIMC_ONLINE,
>> +	CPUHP_AP_PERF_POWERPC_THREADIMC_ONLINE,
>>   	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
>>   	CPUHP_AP_WORKQUEUE_ONLINE,
>>   	CPUHP_AP_RCUTREE_ONLINE,
>> -- 
>> 2.7.4
>>
> --
> Thanks and Regards
> gautham.
