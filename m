Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsdYm45rxzDqY6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 15:43:07 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2S4gWAb086844
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 00:42:58 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29fgr412vn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 00:42:57 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 28 Mar 2017 14:42:55 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2S4giO317760310
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 15:42:52 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2S4gJlE026858
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 15:42:20 +1100
Subject: Re: [PATCH v5 08/13] powerpc/perf: PMU functions for Core IMC and
 hotplugging
To: ego@linux.vnet.ibm.com
References: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1489649707-8021-9-git-send-email-maddy@linux.vnet.ibm.com>
 <20170323130947.GB4897@in.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 28 Mar 2017 10:11:51 +0530
MIME-Version: 1.0
In-Reply-To: <20170323130947.GB4897@in.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5aaf098d-5919-e7c6-b4a6-0acbb5baa222@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 23 March 2017 06:39 PM, Gautham R Shenoy wrote:
> Hi Maddy, Hemant, Anju,
>
> On Thu, Mar 16, 2017 at 01:05:02PM +0530, Madhavan Srinivasan wrote:
>
> [..snip..]
>
>> +
>> +static void core_imc_change_cpu_context(int old_cpu, int new_cpu)
>> +{
>> +	if (!core_imc_pmu)
>> +		return;
>> +	perf_pmu_migrate_context(&core_imc_pmu->pmu, old_cpu, new_cpu);
>> +}
>> +
>> +
>> +static int ppc_core_imc_cpu_online(unsigned int cpu)
>> +{
>> +	int ret;
>> +
>> +	/* If a cpu for this core is already set, then, don't do anything */
>> +	ret = cpumask_any_and(&core_imc_cpumask,
>> +				 cpu_sibling_mask(cpu));
>> +	if (ret < nr_cpu_ids)
>> +		return 0;
>> +
>> +	/* Else, set the cpu in the mask, and change the context */
>> +	cpumask_set_cpu(cpu, &core_imc_cpumask);
>> +	core_imc_change_cpu_context(-1, cpu);
> So, in the core case, we are ok as long as any cpu in the core is
> present in the imc_cpumask. It need not have to be the smallest online
> cpu in the core.
>
> Can the same logic be applied to the earlier nest case ?

Yes. This makes sense. Let me look at this.

Thanks for review
Maddy

>
> We can have a single function for cpu_offline and cpu_online which
> implements these checks and sets the cpu bit if required.
>
> ppc_entity_imc_cpu_offline(unsigned int cpu, cpumask_t
> 			   entity_imc_mask,
> 			   entity_imc_change_cpu_context_fn)
> {
> 	.
> 	.
> 	.
> 	
> }
>
>
> static ppc_nest_imc_cpu_offline(unsigned int cpu)
> {
> 	return ppc_entity_imc_cpu_offline(cpu, nest_imc_mask,
> 					  nest_imc_change_cpu_context);
> }
>
> And similar ones for core imc and thread imc.
>
> Does this sound reasonable ?

>> +	return 0;
>> +}
>> +
>> +static int ppc_core_imc_cpu_offline(unsigned int cpu)
>> +{
>> +	int target;
>> +	unsigned int ncpu;
>> +
>> +	/*
>> +	 * clear this cpu out of the mask, if not present in the mask,
>> +	 * don't bother doing anything.
>> +	 */
>> +	if (!cpumask_test_and_clear_cpu(cpu, &core_imc_cpumask))
>> +		return 0;
>> +
>> +	/* Find any online cpu in that core except the current "cpu" */
>> +	ncpu = cpumask_any_but(cpu_sibling_mask(cpu), cpu);
>> +
>> +	if (ncpu < nr_cpu_ids) {
>> +		target = ncpu;
>> +		cpumask_set_cpu(target, &core_imc_cpumask);
>> +	} else
>> +		target = -1;
>> +
>> +	/* migrate the context */
>> +	core_imc_change_cpu_context(cpu, target);
>> +
>> +	return 0;
>> +}
>> +
> --
> Thanks and Regards
> gautham.
